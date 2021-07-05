Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014BD3BC259
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGERpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGERpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F9D7611ED;
        Mon,  5 Jul 2021 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625506992;
        bh=bXlnuLgazQj2meMgG4cEjc2movH3UbvP3OkyY+5bsG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuCLpuRfSCy6zFng7F7kcQIgdWFfDnoCetQaxlVTkyI9+7PLx//3nAyBFLGpdgGvX
         1KNkezYZ20RtIMQO0bXqiMWgTQpWVQd4AueyAVGliGhWRTr4FV1zyFbFgwRdmzUhUb
         03m8QwZEIYai6MqukNvbEkzo/hdvL9tP6wJ1kNBs7P0gJ1LlqbnCyWUATYb3ccLLkc
         UNF+u+GD0K/6TwXPKZt5AoA7FxSyFe3bXZq4AM60xMBXaeWknkVYbnQ3cnlRKk4SIE
         NRhf0e6go4f9Jhwpa2MO9E+cxhhNoY/wr6VtYaK1ADnsOQabpFcjNtR7VEURg+RjW4
         NjU31JYxVp6PQ==
Date:   Mon, 5 Jul 2021 18:42:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
        amistry@google.com, nartemiev@google.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: add dai_reoder flag to reverse the stop sequence
Message-ID: <20210705174241.GF4574@sirena.org.uk>
References: <20210705155830.24693-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
In-Reply-To: <20210705155830.24693-1-vijendar.mukunda@amd.com>
X-Cookie: Star Trek Lives!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 05, 2021 at 09:28:28PM +0530, Vijendar Mukunda wrote:

> @@ -982,6 +982,7 @@ struct snd_soc_card {
>  	unsigned int disable_route_checks:1;
>  	unsigned int probed:1;
>  	unsigned int component_chaining:1;
> +	unsigned int dai_reorder:1;

This feels like it should be a per dai_link option rather than a card
wide option - the system could have a mix of links that do and don't
want this depending on why it's an issue.  The name probably also wants
to be more specific to what's being reordered, something like
stop_dma_first for example since it's only for stops and moves the DMA
first.

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDjRJEACgkQJNaLcl1U
h9Ad1wf+ODiFiCnjZAzJXHv3jIrxKfUZB9Fe48MZPeeN1PjK4BgqyHYo6O5BnzW/
ODBJKx4nWtiBFIyT39nEmZIXWNaFkThhfW35aGgMkLjv56IHXWIYeAipR2a5tohk
ltWhE/YLIpfO+ktdNievZ6RTuxXbTzu/+N9E3Hw8hlLUMmDrAwt5dWc8IU/HKTst
1V+nSCB8G8vA2mHCg/Jo1z6BZxnyWBHXmG4ukKhl9soNjK+qwQ+VqBemFOCRCMsY
cxKGZtfY55/kxrPNakKnK632FGMeGZ2PGVWUelUb62YwRHEjd8i+9ieWd7sbaaVk
4vpi5Ihu+HTFNipGFWid20ioKsL0FQ==
=Byu8
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
