Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78955401AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbhIFLsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241229AbhIFLsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:48:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C39FC60F14;
        Mon,  6 Sep 2021 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630928856;
        bh=6aDKCqu7JUaygznso9JGDgn2RHl3/CuxBKHsT/8A0lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCIGLnFO443t/wH9KJX7gxqLZ/AsJXnCQeOdnOvRaq7CiFd7g0bIgyW+MbtaUM3Wr
         +sxyua/eKGw5Sfq4WoOKHmmesRwMGddAp3FjvdsSwSzQ05eF0aS2l6Q/l5C/7vNG+5
         OYWPmzJbTspXA5CBPo4BY42TShaJN/bN1FyZfl2i/qCiqxXNMkuHMGPDJNrVINtYpU
         WMGk4ssNYLLwZriGXW9Fn8nxoxJc+XpcHR06q8YTYE+SBWdDATYCV/TujPKtm++atD
         GoxWhlRTdZ1RDI+I7yV/AUllx0E4hIU0oKXJaFwYDAp7CD0NnxJLCc08haFk7Pu/XL
         C3f3MXG+u8tPQ==
Date:   Mon, 6 Sep 2021 12:47:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.15 0/5] ASoC: fsl: register platform component
 before registering cpu dai
Message-ID: <20210906114701.GC4309@sirena.org.uk>
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 03, 2021 at 06:30:01PM +0800, Shengjiu Wang wrote:

> There is no defer probe when adding platform component to
> snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()

...

> So if the platform component is not ready at that time, then the
> sound card still registered successfully, but platform component
> is empty, the sound card can't be used.

This sounds like a bug which should be fixed there?

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE1/7QACgkQJNaLcl1U
h9A2PQf+MXqqe36AsD9bn8IpQ83/IyczIGKq7d94luUncaivHbSF3i18scHq2SrW
d1wUCYn+J0TbavlsquPzmuuFzGVQ8B0I0mWvqfLvcCOboaEce6os/pgXqxJKctqd
XimllKcJFViLzssrsJG1q2XHCwXw1mj9clwKXZ6iOjQxtTN5GqFEBdQd14hy+Zod
wKhPoCb87qO/ngT6iSwVqGoET5xip9q4WkeeO5QCTCcTyW1Mc4YbuV9dnqV2DjQ0
9rW4xZ0xA1ZbLekeaYzqChqmYyWxn0RGdVa/wiyDXPS0I/FaYJAJ6xkD0VvyYF6E
ObuvLN4+E7wgeufVxAeSwXbORT6/uA==
=PvOc
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
