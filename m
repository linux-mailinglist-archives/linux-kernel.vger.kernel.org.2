Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2B3F77D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhHYOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:55:25 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60719 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234380AbhHYOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:55:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4942D581075;
        Wed, 25 Aug 2021 10:54:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 Aug 2021 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=IqJM9t4viIksZpN3cNv1P81kyYI
        WsJz+PszGrJJmalk=; b=q0s2segFpoUph9ozZyNmF175KEKs6Jw9GmRitRQibTD
        KlsRtCsrwUtITeiUXVIfefFSqFR3WHjhdv4GY5lNJ0fQyzm9Yjk+ph/jw3r3Lp4m
        STdFxzfQiXSnaekbeA3dt5p46YqG+HKHP2favJ5qegt9vXNl9THGVKk9ADU9C5k1
        c3QCpVRB8H8Hr+RLBETaTXFB0/cYwOwtdH5xAfn8/eaiGExCqc0vvMMwbAlTGj6R
        nGsJ+9csqoAj8FejrSwPy1SW7fBKvp2fBks9YKvio8zCHTfJCVLNJoP2MRZWlQAS
        0tELQsIMTZmCUVgDeXZHOh4pAU6d/mcGoLSjKO0zMfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IqJM9t
        4viIksZpN3cNv1P81kyYIWsJz+PszGrJJmalk=; b=noD1zg8iL2XnTLBPh+0OWT
        MVo4oaUJFG8knVLYoYtfJQkKl2Ih59G5GFOGPZBJxwBBSSY5M7/WUg5TWY+8ZA4h
        kAKInzBShxqjWyeNlFEGR22jgmdiwoE5W0VvhvvXbtu1muMV3VMnboZQNvQtwoaj
        8mM4OvMrWxiGPuyxO/l8LEAw7VWQPwYVweMXMsX3h/IZkwFAU6qr3lrjhNK0UABj
        ST9ps2d697SGL7Mb9jSHlIObLoyBBqwVL8Wf64Z346LQvH888nBAtyP7jQFYi1iM
        +zxjijY1REKfu0Mt0oRTYYz0RzSWWqZDcOllr+ilWzynP/GAa0vfuZM9f2gKxR6w
        ==
X-ME-Sender: <xms:rFkmYSMV0JB1vBFiDtusGG3tX6WrCQD0ew2UiLk349WsVA00J_xBQQ>
    <xme:rFkmYQ-O0LlivwPriktmL0hPlgSlwJvMBExUlz8iwByS8OXFi3BRCemQsuT8Aa5OL
    MBlljn6HwijPlwDvpA>
X-ME-Received: <xmr:rFkmYZROomxG6Q9lU4m2nB26ZW4HxflpoKPLIeT3mGVroMcpWn1q_73cVKy8qMQClX8J127Il8D10AKyFqcW_PC4qjRrkdQJ0dRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rFkmYSvZByGSCuHIEr1Wd9vWY6OlBG3GZ5u1W80CjZlXkfWzL8d3nQ>
    <xmx:rFkmYafdW9dNvgVrYVcGc0tIDVyVIeVH4UsLfUDxsBlQceUVQLURjg>
    <xmx:rFkmYW0GHOQhCUeuFLRgJHNzN27jieRrsRngYMJyKXwc5lbo-rJtjg>
    <xmx:rlkmYW2OJCvYMC4APBf6mcrQ1_930_A78G9qUVVtSxA19XL34fj9Kg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 10:54:36 -0400 (EDT)
Date:   Wed, 25 Aug 2021 16:54:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] clk: sunxi-ng: add support for Allwinner R329 CCU
Message-ID: <20210825145434.vdrhgrgblnnmvmve@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-12-icenowy@sipeed.com>
 <3e56e53f-e6df-50cf-5545-e9132e521ed1@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jd6omazv7t4jt7hs"
Content-Disposition: inline
In-Reply-To: <3e56e53f-e6df-50cf-5545-e9132e521ed1@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jd6omazv7t4jt7hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 09:41:26PM -0500, Samuel Holland wrote:
> On 8/2/21 1:22 AM, Icenowy Zheng wrote:
> > Allwinner R329 has a CCU that is similar to the H616 one, but it's cut
> > down and have PLLs moved out.
> >=20
> > Add support for it.
> >=20
> > Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> > ---
> >  drivers/clk/sunxi-ng/Kconfig                |   5 +
> >  drivers/clk/sunxi-ng/Makefile               |   1 +
> >  drivers/clk/sunxi-ng/ccu-sun50i-r329.c      | 526 ++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu-sun50i-r329.h      |  32 ++
> >  include/dt-bindings/clock/sun50i-r329-ccu.h |  73 +++
> >  include/dt-bindings/reset/sun50i-r329-ccu.h |  45 ++
> >  6 files changed, 682 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.h
> >  create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
> >  create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
> >=20
> > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> > index e49b2c2fa5b7..4b32d5f81ea8 100644
> > --- a/drivers/clk/sunxi-ng/Kconfig
> > +++ b/drivers/clk/sunxi-ng/Kconfig
> > @@ -42,6 +42,11 @@ config SUN50I_H6_R_CCU
> >  	default ARM64 && ARCH_SUNXI
> >  	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> > =20
> > +config SUN50I_R329_CCU
> > +	bool "Support for the Allwinner R329 CCU"
> > +	default ARM64 && ARCH_SUNXI
> > +	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> > +
> >  config SUN50I_R329_R_CCU
> >  	bool "Support for the Allwinner R329 PRCM CCU"
> >  	default ARM64 && ARCH_SUNXI
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makef=
ile
> > index db338a2188fd..62f3c5bf331c 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+=3D ccu-sun50i-a100-=
r.o
> >  obj-$(CONFIG_SUN50I_H6_CCU)	+=3D ccu-sun50i-h6.o
> >  obj-$(CONFIG_SUN50I_H616_CCU)	+=3D ccu-sun50i-h616.o
> >  obj-$(CONFIG_SUN50I_H6_R_CCU)	+=3D ccu-sun50i-h6-r.o
> > +obj-$(CONFIG_SUN50I_R329_CCU)	+=3D ccu-sun50i-r329.o
> >  obj-$(CONFIG_SUN50I_R329_R_CCU)	+=3D ccu-sun50i-r329-r.o
> >  obj-$(CONFIG_SUN4I_A10_CCU)	+=3D ccu-sun4i-a10.o
> >  obj-$(CONFIG_SUN5I_CCU)		+=3D ccu-sun5i.o
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329.c b/drivers/clk/sunxi=
-ng/ccu-sun50i-r329.c
> > new file mode 100644
> > index 000000000000..a0b4cfd6e1db
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329.c
> > @@ -0,0 +1,526 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Based on the H616 CCU driver, which is:
> > + *   Copyright (c) 2020 Arm Ltd.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "ccu_common.h"
> > +#include "ccu_reset.h"
> > +
> > +#include "ccu_div.h"
> > +#include "ccu_gate.h"
> > +#include "ccu_mp.h"
> > +#include "ccu_mult.h"
> > +#include "ccu_nk.h"
> > +#include "ccu_nkm.h"
> > +#include "ccu_nkmp.h"
> > +#include "ccu_nm.h"
> > +
> > +#include "ccu-sun50i-r329.h"
> > +
> > +/*
> > + * An external divider of PLL-CPUX is controlled here. As it's similar=
 to
> > + * the external divider of PLL-CPUX on previous SoCs (only usable under
> > + * 288MHz}, ignore it.
>=20
> Mismatched (braces} here
>=20
> > + */
> > +static const char * const cpux_parents[] =3D { "osc24M", "osc32k", "io=
sc",
> > +					     "pll-cpux", "pll-periph",
> > +					     "pll-periph-2x",
> > +					     "pll=3Dperiph-800m" };
>=20
> =3D should be a -.
>=20
> Now that these PLLs are in a different device, how is this supposed to af=
fect
> the DT binding? Do we put all of them in the clocks property?
>=20
> If so, we can use .fw_name at some point. If not, why bother with the clo=
cks
> property at all? This is another part of the "let's get the clock tree ri=
ght
> from the start" discussion.

Agreed

Maxime

--jd6omazv7t4jt7hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYSZZqgAKCRDj7w1vZxhR
xf7MAQCaA0w3oNAOvdQ5ITxY5Ab2GivujOLUDDhU3UcM2ZnHEAEAxNsnCPVFwlPY
bfCv++67RwNPa1FPsCUxvKudlvWfWQc=
=Z5kK
-----END PGP SIGNATURE-----

--jd6omazv7t4jt7hs--
