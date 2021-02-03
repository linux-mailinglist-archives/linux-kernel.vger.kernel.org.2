Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FA630DF96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhBCQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhBCQVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:21:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F05CB64F7C;
        Wed,  3 Feb 2021 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612369240;
        bh=1yMtRmiXEbjhnyEHQCW06t598A7qF+k9oLej17rISL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SV94P1m4W/3UrOwSqq2xe2/ru3TeU0LEFT1oUMFGtlOPfRMe+Ch19HqGo4N7HrzuB
         YYBEvBx4J8JZ3LglWnvl9anEgayHsiOMEGOmsBbRHyQ72btUyCvqVJ3GGa+CsRqrW7
         wDAjaXMYWznXl/fTOlLNAskkIfmkjxduGvHV0dmJ5SodW7uExRYDFV+tKO1ICdM39v
         /btzFvd7/68r51dv8IhroL4Wsui1MgcIkcrBLLUMEV7J9ATr02MSSF7KMRAKOkNjFm
         4qVjLYezSu7pKBFB6dMacDzYg04yogihkw/4Jxh3O9+oyBlc/46Ina5P29GxJdeZ0t
         IhIRHm4zQWWDw==
Date:   Wed, 3 Feb 2021 16:19:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com
Subject: Re: [PATCH 1/2] ASoC: audio-graph: Export graph_remove() function
Message-ID: <20210203161951.GG4880@sirena.org.uk>
References: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
 <1612368575-25991-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <1612368575-25991-2-git-send-email-spujar@nvidia.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 03, 2021 at 09:39:34PM +0530, Sameer Pujar wrote:

> +int graph_remove(struct platform_device *pdev);

I think this needs better namespacing if it's going to be exported.

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAazScACgkQJNaLcl1U
h9AwjAf/XixFJdwXumZh6e4G4JogNNq4rLyk1Po+DOZ3Dmp5LtzCNj1hwALHxlvm
gDH7sKvnVZ3+Ve9dSq0W3qi4SWSuvwTE/pMCxggeMawZvhYvFjzs43j0y4CwPAWZ
8A8l6dBgWZNLwK89wvUEvampht9g7dVya2Lu4+Y1UhCr+KrzJTtNTFmCfTsjnSHD
J2s/mfxZGuVewx9x5LeDeI3Oq1NlPJ1tGhXZKTsJlle8PBmULi2V4b3cFS4Al8W5
OOKCXsA9y5RmPHKYiTF4Zwae+u9d8RfmWuYGsGRxM1UarrDmUahphJQQ7Z0mqWc9
OKbLHvjn5eNiEr2NUJbHS1Rvjy1/dw==
=Z2ls
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
