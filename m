Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274FC38992E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhESWRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:17:47 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:16:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id f9so20151156ybo.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=morWyCz634GJ3NdKEMEwQrgVfNZXxZKJ8lbMev09OtQ=;
        b=uV7co41K+jzB90+kCl10zutljqclIGAx406/xNkciCWxoJeH6ruUk5w4v8IkKtFsm3
         7yOROGpqqunroCFsrybvrM4uwzneoiT2kmuoN3iXCJl7Zhls9l//ZDS1kww3KEFWS0qs
         jboGUHBMO0PU6KgmEAJ/FKZ4/u/8DgiUAF0jufuwnkacGd0x+G9LWQ29xVbXmTTmh+p1
         fkCDIQJgyH9dEzay9DUenGe4YZwr+c1Q/EUF421jJDNVBHJmY+xxbRkKIjdUbXaE0D8t
         AFYm7AYq0wFVS6WECQTUho0QZGd+5Y+PeLmPwXwgGsfXiFgF0pTv/ASrqLxh7zDP6xNg
         6igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=morWyCz634GJ3NdKEMEwQrgVfNZXxZKJ8lbMev09OtQ=;
        b=k4yuSUn5cBfpmo4aKftsCQaQCGchBvsnOrI7uLdY/0/hwWC+frTt/wXH6yrOIOtH26
         qR52fG0RGMe4yW2Z7D/H5qeQLnccpfXraeV8eZtW3DY589pk0QheMFLx9ErzV6dYQCP2
         OjWy2AWau9FAmW0DDX9Xl95BcQTMcQOkXLhfs7+aw/wX3P1IJV5YUWmjZNp4XwYqowHO
         D8BBN3cftfmrs0uNK4YCbfu/oz9BzUpQ1SyPamOZbHos3URNIUY2Hj3+Q8ILbyA8JScw
         WsrjfYUQFmVYl0DLthgrtV3W2ooMYX+QHUK/XSgiMEo/371TA1T+j23enmKlyFwvvxkl
         qcwQ==
X-Gm-Message-State: AOAM533cujUBB7ZeDY1htQIGFulrNwLyhzx4tOPdH7F87xmOLycRdHbt
        /YQL8dJ/deF8e/iw010SwYmJx7r/PZcb83fkdc9pPA==
X-Google-Smtp-Source: ABdhPJw11tXcHV8xvlarIjiFWKlXfwjiqkS3QaXU4gTbF5LGSwwfFExxi6O536u++qiva04zK9oO+gbaN3hYrXl5xmY=
X-Received: by 2002:a25:a2c8:: with SMTP id c8mr2778666ybn.20.1621462585825;
 Wed, 19 May 2021 15:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210516170539.2yxe43qwezonuo3r@core> <CAGETcx93RxfsXG51zeaUK+UyKdEDgivqkmS85mcMPp0H42X5ZQ@mail.gmail.com>
 <20210517082957.sddwy2dv5esbzmo4@core> <CAGETcx-UgSCn9V5W0EgOBbdNGxsXR+ZGPNLL1MMJfHN35WCLRw@mail.gmail.com>
 <20210519220002.w6e3jf6m5t45vbob@core>
In-Reply-To: <20210519220002.w6e3jf6m5t45vbob@core>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 May 2021 15:15:49 -0700
Message-ID: <CAGETcx-dS56NK3zuiUheB8ggavw-0O5G81N6Ea0LnoNxWm=OtA@mail.gmail.com>
Subject: Re: fw_devlink=on and sunxi HDMI
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 3:00 PM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> Hello Saravana,
>
> On Wed, May 19, 2021 at 02:29:48PM -0700, Saravana Kannan wrote:
> >
> > Nothing in sun8i_hdmi_phy_probe() depends on anything from
> > sun8i_dw_hdmi.c other than getting a struct device pointer to use with
> > dev_err and some devm_* APIs. So it seems pretty straightforward to
> > fix this so that you don't have one struct device trying to represent
> > two distinct hardware blocks. What am I missing?
> >
> > Anyway, I took a swing at fixing this while preserving the ordering of
> > the important bits. The changes are fairly trivial/straightforward and
> > not meant to be final code, but can you test this out please?
>
> the patch seems to work, after fixing a few compilation issues. See
> bellow. Thanks!

Thanks for the quick test! Do you want to fix it up and get it
upstreamed? I can do it, but I have other stuff I need to take care
of. Also, I just wanted to prove the change I was suggesting wasn't
complicated and fairly trivial.

> I think the probe order is reversed, but HDMI works in my case, so
> I guess that doesn't matter in the end. Or at least it didn't in the
> short test I made.

I don't think the "probe" order really changed. Firstly there was no
real phy "probe" before. However, I'm guessing the order that really
matters is the order between sun8i_hdmi_phy_init() and dw_hdmi_bind().
My patch still preserves that and that's why I think it works fine.
sun8i_hdmi_phy_probe() was just doing a bunch of "gets" on resources
so doing that a bit earlier seens pretty harmless.

-Saravana

>
> kind regards,
>         o.
>
>
> From 0eac644368711f52fffa4246aefc546591cef090 Mon Sep 17 00:00:00 2001
> From: Ondrej Jirman <megous@megous.com>
> Date: Wed, 19 May 2021 23:44:45 +0200
> Subject: [PATCH] fix compilation issues
>
> ---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
> index c44ed22d8aef0..947b4231f6449 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/delay.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>
>  #include "sun8i_dw_hdmi.h"
>
> @@ -748,7 +749,7 @@ int sun8i_hdmi_phy_probe(struct platform_device *pdev=
)
>         return ret;
>  }
>
> -void sun8i_hdmi_phy_remove(struct platform_device *pdev)
> +int sun8i_hdmi_phy_remove(struct platform_device *pdev)
>  {
>         struct sun8i_hdmi_phy *phy =3D platform_get_drvdata(pdev);
>
> --
> 2.31.1
>
>
> [    0.307254] platform 1c28000.serial: probe deferral - supplier 1c20800=
.pinctrl not ready
> [    0.307340] platform 1c28400.serial: probe deferral - supplier 1c20800=
.pinctrl not ready
> [    0.307379] platform 1c28c00.serial: probe deferral - supplier 1c20800=
.pinctrl not ready
> [    0.309235] fwnode_links_purge_suppliers: display-engine
> [    0.310176] platform 1c0c000.lcd-controller: probe deferral - wait for=
 supplier mixer@200000
> [    0.310228] platform 1c0d000.lcd-controller: probe deferral - wait for=
 supplier mixer@200000
> [    0.311902] platform 1ca0000.dsi: probe deferral - wait for supplier p=
mic@3a3
> [    0.312287] platform 1ee0000.hdmi: probe deferral - wait for supplier =
pmic@3a3
> [    0.313076] fwnode_links_purge_suppliers: hdmi-phy@1ef0000    <------ =
phy probed
> [    0.316766] platform 1c21800.lradc: probe deferral - wait for supplier=
 pmic@3a3
> [    0.317258] platform vibrator: probe deferral - wait for supplier pmic=
@3a3
> [    0.318703] sun6i-rtc 1f00000.rtc: registered as rtc0
> [    0.318748] sun6i-rtc 1f00000.rtc: setting system clock to 2021-05-19T=
21:40:59 UTC (1621460459)
> [    0.318917] sun6i-rtc 1f00000.rtc: RTC enabled
> [    0.318938] fwnode_links_purge_suppliers: rtc@1f00000
> [    0.318960] fwnode_links_purge_consumers: reboot-mode@4
> [    0.319185] i2c /dev entries driver
>
> ....
>
> [    0.453301] fwnode_links_purge_consumers: port
> [    0.453323] fwnode_links_purge_consumers: endpoint
> [    0.453346] fwnode_links_purge_consumers: panel@0
> [    0.491868] sun4i-drm display-engine: bound 1100000.mixer (ops 0xfffff=
fc010a44230)
> [    0.501830] sun4i-drm display-engine: bound 1200000.mixer (ops 0xfffff=
fc010a44230)
> [    0.502915] sun4i-drm display-engine: No panel or bridge found... RGB =
output disabled
> [    0.502956] sun4i-drm display-engine: bound 1c0c000.lcd-controller (op=
s 0xffffffc010a415a0)
> [    0.503466] sun4i-drm display-engine: bound 1c0d000.lcd-controller (op=
s 0xffffffc010a415a0)
> [    0.503545] sun4i-drm display-engine: bound 1ca0000.dsi (ops 0xffffffc=
010a431c8)
> [    0.505330] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1=
.32a with HDCP (sun8i_dw_hdmi_phy)
> [    0.507566] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C=
 bus driver
> [    0.510717] sun4i-drm display-engine: bound 1ee0000.hdmi (ops 0xffffff=
c010a43568)
> [    0.514674] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-eng=
ine on minor 0
> [    0.514932] sun4i-drm display-engine: [drm] Cannot find any crtc or si=
zes
> [    0.515160] fwnode_links_purge_suppliers: hdmi@1ee0000           <----=
-- hdmi probed
> [    0.515195] fwnode_links_purge_consumers: ports
> [    0.515217] fwnode_links_purge_consumers: port@0
> [    0.515240] fwnode_links_purge_consumers: endpoint
> [    0.515264] fwnode_links_purge_consumers: port@1
> [    0.515343] fwnode_links_purge_consumers: endpoint
> [    0.517089] input: 1c21800.lradc as /devices/platform/soc/1c21800.lrad=
c/input/input1
> [    0.517358] fwnode_links_purge_suppliers: lradc@1c21800
> [    0.517384] fwnode_links_purge_consumers: button-200
> [    0.517407] fwnode_links_purge_consumers: button-400
> [    0.518414] input: gpio-vibrator as /devices/platform/vibrator/input/i=
nput2
> [    0.518582] fwnode_links_purge_suppliers: vibrator
>
>
>
> > -Saravana
