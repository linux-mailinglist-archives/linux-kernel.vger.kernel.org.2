Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91115352F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhDBTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBTC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 381A761151;
        Fri,  2 Apr 2021 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617390145;
        bh=ViFsXDUB1E7AWBfBJCrghovWOG7+1rHYDGYcDESiobc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gb0iBUJPDJ+eaWDrat0XQQvUF1+X2c3Mt2qvyCL+aLpQ4qdoUK8jYbafG3MNFrR4c
         des71nJQQRO47tL4D6tiiPYmkj43VphHWqjT7AEkB4HEhw1ZiPE/6jCIQmL70ak/XN
         DMp6guhXEjbxi+ZpZ/GPNtXHEH4EFDKbAvEuiewRoY7DKQLEiohnQM97zdgpszy0x8
         hQh9kgmvp7MLD1gkxOBTDcBCBocmEc/WB3dpyXFAsrN/eC5DX4bvsqigXJlXfhbsNX
         7v6d5G6AivHACl5Rm77MffP4sjVEGhPIDr5Tmi2hqShBUKtqOvfykLLh3CPX7x+vN5
         abXxZlILdQUjg==
Date:   Fri, 2 Apr 2021 20:02:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v5 16/19] regulator: bd71815: use ramp-delay helper
Message-ID: <20210402190211.GJ5402@sirena.org.uk>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
 <31db9c2bf1e9e1883d8caf4bf3b90475a8a1166e.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
In-Reply-To: <31db9c2bf1e9e1883d8caf4bf3b90475a8a1166e.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 04:00:13PM +0300, Matti Vaittinen wrote:
> Use generic regamp ramp-delay helper function instead of implementing own.

This is patching something which was just added in the previous patch...

Acked-by: Mark Brown <broonie@kernel.org>

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnajMACgkQJNaLcl1U
h9AaTQf9Gzw/b+PuEoYrIwaA7DklAoHk0w6KLVtsZNCFYQQMNu3qCql4QDoO3rAd
SDN7tGg3baWbFswp+SVxGvsPp3UOfvSuOtjpoZGRvItNKxqMIeh6uYRBdMyo49oW
3+XhsX/963bAf0LTM5hHIe5Yx/G2qhUcisO4cOVYfPrXECVa5wIUJoYmhd4jqPO+
UIlW9ncneYPrmInFuYFbwUsInOllgj6hQJ/YQN65JAdoCMhBm2NysQuIvmfgltCU
4CKwE0UuJdX+CMbyrW+Sq4Rlp8NrEiRzMvZDVCENkMJTpWwlaDBOoOTPtDFJ1bHT
7bV9xdLU8x7qJhde7W4U55A7d1b2UQ==
=eDIV
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
