Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D51316A61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhBJPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhBJPjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:39:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47C2764DA5;
        Wed, 10 Feb 2021 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612971540;
        bh=UmFQ9LVN1sbDvFGlexMO9nwDPmQ4xxV03atwcYGV+pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzWmVUtoGG76LVFlqhysU3JpLDxUvQBi6njFUh6JGOkt6CbjseqgqzAqS+HaHdmfk
         T1XuWkdk5zPEx/9xLQaTza0Y/MeMuhnXGQ4ZsJ1nrkY6ndPKGqYONNd+4tyv0TPcbp
         cbTzyicTC7YJi5IoUYNq2rNOYtPl7ZEzN0Q5t4ehLU+WA4UMrHzZqJmn9pA3a2U+9H
         NBhxOfNGPwfhxZ/Ib+CGKBuIqxeO//97USv+mY2rIxCb/00SToRpINZm6S17fFaTU+
         v8WCV+RHf2qZ5VNRVkQKCHeHDm0eiJO/6xl+e0xoybXefr16H/iFnlXkR/9geyt2Xr
         kUKg94zDyIa6w==
Date:   Wed, 10 Feb 2021 15:38:08 +0000
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
Message-ID: <20210210153808.GB4748@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
 <20210209222953.GF4916@sirena.org.uk>
 <CAA+D8AN=SDMLhuNbstzHL_H2p_L6cr+oCXbauNB0gGs2BW5tmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <CAA+D8AN=SDMLhuNbstzHL_H2p_L6cr+oCXbauNB0gGs2BW5tmA@mail.gmail.com>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2021 at 02:35:29PM +0800, Shengjiu Wang wrote:
> On Wed, Feb 10, 2021 at 6:30 AM Mark Brown <broonie@kernel.org> wrote:

> > Like I say I'd actually recommend moving this control to DAPM.

> I may understand your point, you suggest to use the .set_bias_level
> interface. But in my case I need to enable the clock in earlier stage
> and keep the clock on when system go to suspend.

The device can be kept alive over system suspend if that's needed, or
possibly it sounds like runtime PM is a better fit?  There's callbacks
in the core to keep the device runtime PM enabled while it's open which
is probably about the time range you're looking for.

> I am not sure .set_bias_level can met my requirement. we start
> the Chinese new year holiday now, so currently I can't do test for this
> recommendation.


> Maybe we can keep current implementation, can we?
> Later after I do the test, I can submit another patch for it.

Well, the current version is clearly going to leak clock enables with
valid userspace so=20

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAj/d8ACgkQJNaLcl1U
h9DudQf/TaziP/3fIA/+VtOM1vmRz+Y+qg+fko13UVOigl8UEJA/n+4WEegQRoJG
uDTO557iKp/JwY4o5tXxXQxGZhGMhhDg3MDhWbWx0QJ9y/bMhD4R+sZ421eYHwLI
0cjTI9P2I+EiYtMsTICqZgFmEtR+wJHwtJyXTWaIXDPtJYCJuxGBK4mIxn+2YO72
yXEhmkzRVFDFSMhOR0aPUfAD7yMMvRP8UM0R7VBtwXavEtV9ZHrMqxkibnoMt8oX
ONd0cWMywupFjGVZQalfZJyHmnawloUrOg6V5NU5pS7dvIyMgUCgqcwg+8STUDRF
/ynzOHGXxgiNb5x9zte6dG9YVbs3vw==
=A1BK
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
