Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECB32AB01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582008AbhCBUBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238915AbhCBRbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDC0A64F34;
        Tue,  2 Mar 2021 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614706231;
        bh=zMsEr7NF02vkcIHVkx/Vs36PXAllyxVlPl3cpejbnoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vdz68UEfkqL3qK16PfAG44S7Ef3+Rw01xKKIGTBCtV0a+UFCAAKEXm15pNkdSPTbU
         wHZkW45hj4L+trxZSL3Jrw7Wf8q/G0sBo7CV5SbtE2JaZMDhJCp4XbeXwJRqDurzhT
         y3u/tCM+489GPba1K3pwEaWtr+6G2g7mwN14De0Yu06QmMDeKsrpnmOpCM2pBOA/8c
         YFH1YpVPV4CgUB80V1ysdMxkEb1dMbIqBgfRrXx07XnVr8NrbImTSVVqVgJPxa/v+7
         nGSg8MmXhTrceKigBGHxFpMLj+5iTwWdE/CLFaPY/qvFt0RVMDzQPFv+fLvspMhLGp
         JPVEVuCaQz+IQ==
Date:   Tue, 2 Mar 2021 17:29:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] ASoC: cs42l42: Report jack and button detection
Message-ID: <20210302172923.GR4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-11-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-11-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 05:04:49PM +0000, Lucas Tanure wrote:

> Report the Jack events to the user space through ALSA.
> Also moves request_threaded_irq() to component_probe so it don't get
> interrupts before the initialization the struct snd_soc_jack.

This looks like it should be split into two changes too, one for the
code motion and one for the jack API.  However I'm not convinced it's a
good idea to move the interrupt requesting to the component
registration, in general we should be doing resource acquisition in the
main probe function so things like deferred probe work well - it gets
messy if we try to handle stuff like that in component registration.

I'd have expected the interrupt handling to just be able to check if
there's a jack set, and note that snd_soc_jack_report() supports being
called with a NULL jack anyway.

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+dfMACgkQJNaLcl1U
h9CiVgf/dFINDm+6qu7kKJCs0YL6+0f85LIlSpcHaZ9UE5N60AVCnC7jZqbDmygz
j/DhCUDmk6o5G8IU6S1OOD76dLRHO7UMTzTo72DWLPUKfNsceNNZr3D3uNYQ0xNk
1uW01K4kEXwp1xfChstEp/PqJQ86QMiYiAIE8qmm+1vM5NqscS8xLOfmDdUjJwI5
o8U2P8VIJscJ5KKfLUzyJ55AtYwl88WfeLTjDCvn8fSHF/X5HghO58HfomWfXDkm
KSNmGBbnKmxVSBxxSapAjvLD8HMChpuis1ulxZMh5MiocoAiRVtRaRG6WrTZ2ToM
nXb5LftNZQTx7+Dqet0CIsGxBdK3EA==
=Ov94
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
