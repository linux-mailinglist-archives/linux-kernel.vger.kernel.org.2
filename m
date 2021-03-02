Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F932AABB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836166AbhCBTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238993AbhCBRWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:22:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12EE864F2E;
        Tue,  2 Mar 2021 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614705714;
        bh=s5SF+Wj96fPpy4phjHO8+7ewmYpQWLI+RzEeNDqAZhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNi3Xxua4yUalefJTSZJWlmcrPr32axcZE/36Zn+IxAaiFak/0Ykp6NtSF4YRqB6J
         KqFCwK4DItx0g5k7SbF0rE9z0IoBHv2Ixmq1yVoJU6dCx9xePNhH+r/iWwiqWKeXav
         PK2Ggp/7gI1P3xqGnnNZ9yAfr8sjBraq7nhJfrX9F29+0AwT0b99CkTxOkF3e5uGYQ
         zKfbXkEKU0z4hiwmxSq6hbC4jc5DVHAf2zmum8hFf6cH0QdEbiIBYqdtB83bV7F1Jk
         KyGJo4Kcm8v7uwhaJhMsTaoLapeP1zOs3As3ZJFlaThCWU5JEVbRjJYR6DfUzl83u1
         tRUcCrLsIH+dQ==
Date:   Tue, 2 Mar 2021 17:20:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] ASoC: cs42l42: Fix channel width support
Message-ID: <20210302172047.GQ4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-9-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-9-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 05:04:47PM +0000, Lucas Tanure wrote:
> Remove the hard coded 32 bits width and replace with the correct width
> calculated by params_width.

Again, fixes should go at the start of the series before any cleanups or
anything so they can be merged independently.

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+c+8ACgkQJNaLcl1U
h9C7Wwf+LEu+tkUUbnjzd6cLW7YcPusn3vpfd2rNRuXKUf4I70MypIONcc1TDxzJ
dL3hZr7w959SdTc31ghiy/on4MXjh0H3dIlGpkZ0XMhygCIvc4vy9OCPXTODw3Zz
/upnnTX/Mi7c0pwv+NiRjqIc1f0lZLv2+M02xMbvqNBhmG4QYTqdh2aHeSpb5Kvj
1Y9/eR9XrK2Phlk4r7iRAt3URNdqyh3GIag0434taYRClds4L5Ck2jphWATT0STc
QfoSJjUnmIZtw3ZpArjKAVKnUEJpdA44Jl5HU2nXpg1CRC7qvAhllNlpCz8jSU/n
4EyYd1TyzGh36d/GH7r8NYo9HSrPMA==
=Vz/P
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--
