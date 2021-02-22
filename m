Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587BA321A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhBVOSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhBVNsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:48:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CC5E64E5C;
        Mon, 22 Feb 2021 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614001671;
        bh=XCrkV1b4eW72wlwlFGJM+fGMWXYsc1qnWdLhx0MpYXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRbFZS3OzDUIDA+H5IZtI3RLtcop6I2kCgE8NHwvesNuNTcxgFWAlnvExVji+Girz
         qTrlBNa2NslOXgqEQNL9JiyAaiyfZpZNel8U8+7MtljhsXM4DHZPZr6H32QRnLTbs6
         L+R9SGvOpmZlHPtVbS07qYjuThmsLXhc0duuZ/lFL9bxKR5aX7lYo1cwu3H+eaY9ZL
         iQY+/oulgHQRZa6O5vElhThVZSwgXjOuoB091GAcDvu50eJba1/JIYHRBtWmBaO8v9
         GyBJu2jqHDGtSvxzmEwiqYLMZ1fzeJgQAlck0TpXkHcx6R38yamNKmiXqbDHRjw1Q/
         mi9ZPSUOXRCFQ==
Date:   Mon, 22 Feb 2021 13:46:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210222134650.GD6127@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
 <20210209222953.GF4916@sirena.org.uk>
 <CAA+D8AN=SDMLhuNbstzHL_H2p_L6cr+oCXbauNB0gGs2BW5tmA@mail.gmail.com>
 <20210210153808.GB4748@sirena.org.uk>
 <CAA+D8ANdqd2W6xvwFuuk=YqUGCfuXCFzwO7tkhuGwzPRgA_A4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANdqd2W6xvwFuuk=YqUGCfuXCFzwO7tkhuGwzPRgA_A4g@mail.gmail.com>
X-Cookie: A motion to adjourn is always in order.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 18, 2021 at 03:57:11PM +0800, Shengjiu Wang wrote:

> Can I add a flag:
> "rpmsg->mclk_streams & BIT(substream->stream)"
> for avoiding multiple calls of hw_params function before enabling
> clock?

Yes, if you do local refcounting that'd avoid the issue.

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAztckACgkQJNaLcl1U
h9B2Ygf+N5kwNgpqApDIfReFqtqLtqQXDeHRtyJUp2Mw/FBKGxRIZtSpFboDMi5J
VXujKz7xY9csIA8KyCOStwamXxGesJy0uWUdrjX1Et/X4YYUXtDc+F6hUB1zaB7v
6xEPPINxm87gd/m1j2qeCKA8yVqdLLuZRBLIYvhzr5xzZhN5q5brqie2sHaxjysF
GeuG0uiWiLDUn/+KJAN1MNnnk3zrGR6oD8C8ZL1IZhT10oxYuK8M/wxlWMXC0JbE
fxxUD9Aau8k0ezS5VQquzWRTjZAC4utv/F4N6DBK1FCv3My0aM69mL4BL5a0mUji
tAkM5F9xNM+F83iGENlGypDkiCgd8g==
=kbni
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
