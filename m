Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CACD33F06F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCQMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCQMeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C1F364F67;
        Wed, 17 Mar 2021 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615984455;
        bh=p/0eZuyW/IBDs7DbrwA7LKUEyQKZH6BVvh29JSrTriY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofo1s0d3wDRux0P1nXeH2DI/iD9dguSxzxSHCYKXoKOK9NHguGKh2Fe2exlnz2hJF
         P39FrQqJjr6K4LfuCmRAFU8VjNXyp0gBDR3xss9WIy7UkwtfACuAdRRigpWjJ6kpOd
         jqHtSrChwkWQTISjPk8RQvDoe3yPu8rl29K8YJr2EPh9+4EwVH6GqpIr8ZX3mmoPwA
         ZQjOjAAX4IQhAH0SDblT/vwF+z+OnNdnF0dYIPPLtw0PWu3x9Ix2yj/R0LImWGrbhf
         k9McLi3BSdHvc68p2Ss5YngoX5/riWsPIS0FmrSHQcqFmVcotv8JinLbOCOGw55f16
         r/X2WU77MFv5A==
Date:   Wed, 17 Mar 2021 12:34:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] sound: soc: ti: Fix a typo in the file ams-delta.c
Message-ID: <20210317123411.GA5559@sirena.org.uk>
References: <20210317082042.3670745-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20210317082042.3670745-1-unixbhaskar@gmail.com>
X-Cookie: Please ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 01:50:42PM +0530, Bhaskar Chowdhury wrote:
>=20
> s/functonality/functionality/

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBR90MACgkQJNaLcl1U
h9Cywgf+NwSumzHQekGy/UWSLcJwy82l+4wk/bEPqjc2EluNmc8Atn/8al7+1/W5
QwTdjpepmA9HQZs8KJDlwvnoPNA4dG+WyaJFUYFe8Qg9pZYzn2KZnHfDNyoA5n1Y
AIitp08hz93kjp9An54ePgLFpkZTm7elBeQ2qWn8bPedCtJtplprV1jp/K5iqqlO
8vA0xAYZopQdZTSqG+CXAiG4wwmT/cRvZrfGXebz5JO1Yfsu9QTKZ6iQZzF9gI1O
K3wcVLRk4VtX/wI7m1vOfdL0Bcqz+lvF+6WWFVhH4bQjNJ1kRbo1w71ksrynVGbI
KUgLFmOK8m0WI+OJ/7Cmd09YYR9FqA==
=l/vX
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
