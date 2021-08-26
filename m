Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46903F8E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhHZTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbhHZTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:04:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42252C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:03:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s3so6949055ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQVp2PnUA+5Zt+sP4F+QqkwU+Vh7PyB+v8DN1CEukro=;
        b=GQbps7P/g3/96W8cwR+gYavPfVHkYrFpKsTIt1JfEz0c0mguwDWMYvgwCXVzbm5BAj
         5UHw4denh34XoXIM4VzpmYBLSIRkUYhR29NsvNMR5UNabkaMv4gj8SBkQglfg6+ZU+rW
         P+C42s/+iPr2VvgM+iSGEl2pVvci2jvXqQrPBOcPYzuwQeP8IzV6UKcsMQrKCxnp20na
         fKznSiHsxbzGOkZtuMdD3FWeeOn3hvGfZzYw/QZMTBcw7y7A/bfN1X3ZDGZ02+wfxRXA
         xz9lyY07mw7jQvXQpDmGZjWXUgSfEPnlue0ZP99D/r3xIt8vyeur2k3xjHaFMctCq/eb
         8VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQVp2PnUA+5Zt+sP4F+QqkwU+Vh7PyB+v8DN1CEukro=;
        b=CKcXwFPr2hDEGwv8W3bI3XjvayeTBaWURsOHArdFmLRg0S9LhddYalpui+sn4yKh3r
         2t6I07q7xPk3QxFKXZ+fzI+uo6cguBmGRbCwJ8+BULG7G3TIrXsN98w0IPgQNQb+lT7/
         UUrvstSfUIbYKSxQJh+qhY+kj0t/WgE5dCOInVaIV8O7XLUT7IFbxaQBCWVGm8v7vL9a
         axR5XaC1NXYd2UZhE/TpFBUBlT1lZ5pbJAEiAKni2hGXfGdy1ryyunEjNZEfM+LJlnjB
         cNMgwzNrdo7+iCEHLXNMHA0xsag6DOeh+DXHa1JwMQNckYPZyD9N0ecsOyoWLnDfUphf
         yekA==
X-Gm-Message-State: AOAM530DMuJmr0ca/ABHYnhU9tGi73BvAnp5PiEsWa+cAYOWksakuOAs
        hwGkkE4rabQgmPtjgkR7F5sAd+K9BHt/tVhugwI=
X-Google-Smtp-Source: ABdhPJx7oqIjiY4LYgkuU/889okKWI9HwxaFhGK2B+n/5jiogU3F2Jv8cr7/h9tg0f47uNliaf3CZ8nndiPRkOaeoKM=
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr4434995ljj.444.1630004623466;
 Thu, 26 Aug 2021 12:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210819140345.357167-1-marcel@ziswiler.com> <20210819140345.357167-3-marcel@ziswiler.com>
In-Reply-To: <20210819140345.357167-3-marcel@ziswiler.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Aug 2021 16:03:32 -0300
Message-ID: <CAOMZO5B9Tb+1d1eU1huCZKNH6BjdnmvBUnkY_242L1yub=2Q9g@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] ARM: imx_v6_v7_defconfig: enable fb
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
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

Hi Marcel,

On Thu, Aug 19, 2021 at 11:04 AM Marcel Ziswiler <marcel@ziswiler.com> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Enable CONFIG_FB which is nowadays required for CONFIG_DRM_PANEL_LVDS,
> CONFIG_DRM_PANEL_SIMPLE, CONFIG_DRM_PANEL_SEIKO_43WVF1G,
> CONFIG_FB_MODE_HELPERS, CONFIG_BACKLIGHT_PWM, CONFIG_BACKLIGHT_GPIO,
> CONFIG_FRAMEBUFFER_CONSOLE, CONFIG_LOGO, CONFIG_FONTS, CONFIG_FONT_8x8
> and CONFIG_FONT_8x16.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Yes, I noticed that I had no LCD output on an imx6ull-evk board and
after selecting CONFIG_FB it works again.

For the entire series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
