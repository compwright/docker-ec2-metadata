<?php

namespace Compwright\DockerEc2Metadata\Controllers;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use React\Http\Message\Response;

class IdentityDocumentController
{
    public function __construct(private string $region)
    {
    }

    public function __invoke(ServerRequestInterface $request): ResponseInterface
    {
        return new Response(
            200,
            ['Content-Type' => 'application/json'],
            json_encode(['region' => $this->region], JSON_THROW_ON_ERROR)
        );
    }
}
