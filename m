Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA03CA078
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhGOOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237305AbhGOOVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0B9B6127C;
        Thu, 15 Jul 2021 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626358698;
        bh=6Tn/bHMMoFMkTpR5Cc+yMgZwnfSPFP99ggxrB8ZaDts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lt1+xDmjNlKpUQJ4DVBCaZQXeM4xO/RTBAFX0h0daQaABwztUHGNrS80LLRIpUn8l
         iQ8m83UftbZPLae6PtV/AAQGkX3U81e9NsaT1TAPO583x79IfvzKnHM0XukQozjue/
         datrukQ46KWvo0TpJJddvluztrTKMz4lpMpcozyrBtalAIhW/7/wXvmmg9tLf3ZO7S
         ajHkydWWux7qTJ1xF73x0AX5+U+HET/ghqg6/4fq05QS7zmTmDU0V9jeCF0xJc30Gc
         pvmC5unBHkLJ5EOdPdiG5RGM/L036H8LS75cMFedSEJEK+ea/Zp1wzGusU2RHL63dB
         +Dwt2OqyM7uZw==
Date:   Thu, 15 Jul 2021 15:17:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, amistry@google.com,
        nartemiev@google.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] ASoC: add a flag to reverse the stop sequence
Message-ID: <20210715141740.GC4590@sirena.org.uk>
References: <20210708175529.13313-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20210708175529.13313-1-vijendar.mukunda@amd.com>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 08, 2021 at 11:25:27PM +0530, Vijendar Mukunda wrote:

>  include/sound/soc.h                  |  6 ++++++
>  sound/soc/amd/acp-da7219-max98357a.c |  5 +++++
>  sound/soc/soc-pcm.c                  | 22 ++++++++++++++++------
>  3 files changed, 27 insertions(+), 6 deletions(-)

This should be two patches, one adding a new feature and the other using
it.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDwQ4QACgkQJNaLcl1U
h9ABpQf/XSip+BC68mqysPaI6+TXiMCNF6fKsG5ZD8dvlFh+bGqRrm+qOG/CHnqd
IjTNrzxysPvNM19HhztFyrUyv0rAETY+4hpOFoOng4MruSnCgMOq0qBj/Xt7cxMU
6mdWVWy9JZdFLzEUrWg6G49yr9LysgwY6HQcUVMrisi+spm6m+IG+YDGTgb5CHG5
wqpatcj2DSoLVeOlZW9BuSZZ8+SXXcE4yy0Zh3Wm6Q7LmTw0GR4uLEoNGeQAl870
vuFXYREMa17MCBSY83f/AWfTGJPHSneO4n3+axyfUEvQ8NKgCmScl78o8lhWi/dg
SAQCw5LHw8j3qOhM7nFWDhAJg9raWg==
=8oKq
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
