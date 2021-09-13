Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278B409F67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhIMV6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIMV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:58:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:57:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p15so19885436ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UTnlGh7RVU5tX+P8Vs38fHAJKAjq8VVy75gZLiJ3A8=;
        b=LwVpaRH80MmR1W2mVCC/LjpSo/ftEq15hyNyRAJvL0wqGp26EfPWcFQSFjHqSt4Ts2
         B03tR7hh/f7c+4e8IxfD4jhEq6OxBQtGYqCFCl6WqHX1hY56R+Yk1Zdpxw99BNpFFtru
         2A62zy2BBgnwg/xyxNdY9XqpbVondTJTG9zOM8MqxPYin4bhjHZtW195IjmgeQvXGCJa
         FQ2nfgkEiwg+npOlk8gI6xgD+mwLPcx/IUKJe28T0jyHY9ng+N5kWZF/AalVx9ETzD64
         Cn1Y9eEkxK5nO1ydKFX1UdQFrd6iTXRiy/njPhCf/BH6ZWVLz75t2YId1jdJkxHrUCyx
         LAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UTnlGh7RVU5tX+P8Vs38fHAJKAjq8VVy75gZLiJ3A8=;
        b=N54sqtEk6GUcWo79Izk70AlaAXj5Y+WU7NHX5peYirFAxwdnNmFo5XUte1UNem579R
         C4Dwhc38Dc42xDc7M+s9mteOR1lSJ1opasOR6qvf/rGeFBvj531YpCvwIv9fniJEAd2+
         96TNWMsXCOuJhEFsmr4Rhz5iz2iGiJ9m+YuHjZ9Lt9ID1n9UeDTYWL7WcfvkEwJEAWRr
         IKKoRCtPSY/4spIibibZsuDS5AK4ipijo82pRZV22g5jxp/sdqhFtgufLK8HxDKqkq3y
         ZUa032gRbJjrsUgVH51c/GIzsS23hzM9Kq4bKxnEktkPEuWg1BeBn30eeMZBIKqhvt4C
         gnlw==
X-Gm-Message-State: AOAM5321E4+Td78K4YoGOMYG5dt5Lf1Wc9fDxIgiRMYg7nwTM87vRaB3
        aPjhkymO6BnuJ1uDrPo+m4KpuMmH/YQM+H/27xY=
X-Google-Smtp-Source: ABdhPJxeSJyg29LR3pxcSNIBnu6Ye9+u4+ceEWhmgzwV/M0DgmXdVilHJq30BttxnZ9BNrkJ1F9cIccZm43XOX6Q1eA=
X-Received: by 2002:a2e:a485:: with SMTP id h5mr12896534lji.345.1631570245522;
 Mon, 13 Sep 2021 14:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210819140345.357167-1-marcel@ziswiler.com> <20210819140345.357167-3-marcel@ziswiler.com>
 <CAOMZO5B9Tb+1d1eU1huCZKNH6BjdnmvBUnkY_242L1yub=2Q9g@mail.gmail.com> <4eafec9e-cb67-8194-9219-cc6d7df99fdd@i2se.com>
In-Reply-To: <4eafec9e-cb67-8194-9219-cc6d7df99fdd@i2se.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 Sep 2021 18:57:14 -0300
Message-ID: <CAOMZO5C77MSXtjMyE5iTCcwFDo0pPFBM=qscRPU1J7kkmgs-pQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] ARM: imx_v6_v7_defconfig: enable fb
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:33 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi,
>
> Am 26.08.21 um 21:03 schrieb Fabio Estevam:
> > Hi Marcel,
> >
> > On Thu, Aug 19, 2021 at 11:04 AM Marcel Ziswiler <marcel@ziswiler.com> wrote:
> >> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >>
> >> Enable CONFIG_FB which is nowadays required for CONFIG_DRM_PANEL_LVDS,
> >> CONFIG_DRM_PANEL_SIMPLE, CONFIG_DRM_PANEL_SEIKO_43WVF1G,
> >> CONFIG_FB_MODE_HELPERS, CONFIG_BACKLIGHT_PWM, CONFIG_BACKLIGHT_GPIO,
> >> CONFIG_FRAMEBUFFER_CONSOLE, CONFIG_LOGO, CONFIG_FONTS, CONFIG_FONT_8x8
> >> and CONFIG_FONT_8x16.
> >>
> >> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Yes, I noticed that I had no LCD output on an imx6ull-evk board and
> > after selecting CONFIG_FB it works again.
>
> this was caused by:
>
> f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")

Thanks, Stefan.

Marcel, I think you could resend this one with the Fixes tag and
hopefully it could be applied as a fix for 5.14-rc.

We can consider it as a regression fix, because it restores display
support on many i.MX boards on 5.14-rc.

Thanks
