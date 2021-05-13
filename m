Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E037F95A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhEMOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhEMOHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A496F60FE3;
        Thu, 13 May 2021 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620914798;
        bh=4rN+VVlc8ibw3oXGCckMjpVShm3yI4NuuKf5/cjLR7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peVuKaSPy1xii6lSFRq++WcAMLUe07WXffeuebnVowAyjX4FQyHPg00L7khinSz+j
         kTINuPDLIAqe3fFT6vVYpP/OoNXWP72iooecMWNyhYXY5AJ8NtywC4OLQhFaMhTqWf
         NgQyjT9YTYcN9ukf9+uIUGV5ZXb5k2BVMLdpm6vxIOFJEN5GBSfjJYNvGD7S0Y7RG3
         gRPCItwiNNLIa5kaBjfTjTYc+T6u6d4oCbp+bTQW3chVQ5RSPcjzUSsErN9Qr7v2n8
         cL7T/vcX1lBMvohiNwQ+TN1BHn/OqReTs4/9IhXcUHvZMCFq1AZS41MHnovtg+GqQA
         r1pakCjLk70lg==
Date:   Thu, 13 May 2021 15:05:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        alsa-devel@alsa-project.org, amistry@google.com,
        nartemiev@google.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dwc: add a quirk DW_I2S_QUIRK_STOP_ON_SHUTDOWN
 to dwc driver
Message-ID: <20210513140556.GD5813@sirena.org.uk>
References: <1619195089-29710-1-git-send-email-Vijendar.Mukunda@amd.com>
 <20210423164617.GG5507@sirena.org.uk>
 <e1268120-7a91-da49-0bb6-89d5cb4e2cce@gmail.com>
 <b32fcc42-d67e-bfbd-ed83-7f7274fb2f79@amd.com>
 <ac5244d1-643d-6577-80cd-bf6867e75ca2@gmail.com>
 <b86ad586-9513-8fa9-54e3-a0b4a3a7fd92@amd.com>
 <070b4e5b-b7bd-b8a6-beea-593a94ec3078@gmail.com>
 <26c79eec-5e74-38bc-465b-0ca2b2d9a6f5@amd.com>
 <9b689495-e956-6242-0784-af3ccf7c3238@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <9b689495-e956-6242-0784-af3ccf7c3238@amd.com>
X-Cookie: snafu = Situation Normal All F%$*ed up
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 10, 2021 at 10:57:25PM +0530, Mukunda,Vijendar wrote:

> How about declaring a flag in sound card structure and this flag will be set
> in stoneyridge machine driver.

> Based on flag check trigger stop sequence will be re-ordered.

A couple of people suggested that already, making sure the core knows
what's going on is probably the best way forwards here.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCdMkMACgkQJNaLcl1U
h9CnIQf8CZTlwmEvhbx0XYcSv9tj7ITIo7+jFMz6cTd6x5LQfqk08xg0xOrij+im
FW5gReU/GxTEgE7K483MSbITxxRjPgLqURXSBrmub5Dp+2vCvNiXu3bX4X4vF4MG
pt9LnM0wibEgBg431MlbaPLiL9SbOCCzQJ2o0zn8kJQ3gK7ttgtDarXjjAXvJkaZ
Tcnfx9yY+zFrmfoC1wjphihSG2Gr+6y/2h+TYl1FWyw2lzJjsZh7U4w8vzE94+N3
FJz5Rm9c7Y/mMCumRHlJPED1ZIeWo+vchwf2dz7nOgtcId5yBkeSGvZewauMnSOB
onDJfyVf7Kc/qA4NYupS1QeJ8Dzwkw==
=lt08
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
