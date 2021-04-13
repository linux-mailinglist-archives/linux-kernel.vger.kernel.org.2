Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5735DF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbhDMMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244281AbhDMMoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CE1D613B2;
        Tue, 13 Apr 2021 12:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618317825;
        bh=qiBtcnTxT4Pf7P7KT8Oez6AX4LDmqJOiJjbynCK5Sj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcVngKpkYCCvBk30DH3rjZnD81URSc77GI/TivDJuZF+4tHYUzBHbiGRZFQKzU/hN
         ZZd7LleKkJSJSMxCNDZ81vuOBQu1iKygcACi8Kapx63xuyjRTIz3r7apROxSrIBrt9
         SW7CwCdUyk8qDCob+4+R0pnqn6t95Iz0DX7WNb1tAxwsdPSSbYhFJWfbSifPFhEVp8
         TcRw+cUQ8AgMyh8bX+XW/uCj/OnbZd8D2TWWZzotYppfUI1ta2IuFwRzffbsoyuVY6
         MSJx0kpElpiiM+/qwbeDgRIpK/aNd3L8E5zrkIN+8Z0KIgScp8hKbzPoLlglOUvUc2
         Oupbo+qQ98xAg==
Date:   Tue, 13 Apr 2021 13:43:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
Message-ID: <20210413124323.GD5586@sirena.org.uk>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 11, 2021 at 02:51:06PM +0200, Christophe JAILLET wrote:
> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
> return directly as already done by the surrounding error handling paths.

These are stylistic improvements rather than bug fixes so it's probably
better not to call them fixes.

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1keoACgkQJNaLcl1U
h9Cv3wf+NEs2AimelvFepIXotWXQORggDNT0w9PYpIVhx8qJDau2m0VQTgfzprrE
SBxqb8RaJnOrzew3fZmzDit+EpfjT7D+X1tWwUvGY8HI/bjc0clVVzlpW81+s/FT
F1mepwHK26ct0/VZxKqiibsNoFCsf81VUDPy26KiScG7BAdrF8us25gVSepKAyIF
kh4fqhgcU8GPtUHz23pSgn0vzgA5qdWPJVVQ44tBoJRAtkJ0zBCf9pnvE5ZNZQt0
bwHL/EwG84ufa0Y4x+wzx+O3VeDaT1fv9K9Se/hIylrCRYg+o/agbgnZcCUDD2RI
v8uynYS9hbv6gYfp3hqFkqKWRH1suA==
=q+7O
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
