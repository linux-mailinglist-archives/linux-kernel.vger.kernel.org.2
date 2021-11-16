Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F0452A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhKPGWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhKPGVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:21:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5AC061570;
        Mon, 15 Nov 2021 22:18:56 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id p4so11129936qkm.7;
        Mon, 15 Nov 2021 22:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moerj2/cgT79WMwA3cg6oVNVd7JpZXYnNz8s9GSEqKA=;
        b=axRjeAncLDk6D+syQ/d2VsHsutNSI4x27SjHRyoPl9o25rBGBK3j6Gh4Dn9KUiWnYT
         0MpySKJno6XucXPEWA+VlJam/a0zHvgekifkZK9g1vznIhawEDyupHKl1ijMsf+2rPC8
         rwSGWJalrbiZGu92meQeUQbIiBUy2xwuixcdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moerj2/cgT79WMwA3cg6oVNVd7JpZXYnNz8s9GSEqKA=;
        b=svSzEtMpbFh/WD+L7sXdbL0GdLOd/ON2b4YnuKKzTAsNRfWw/HCJ43/NbdifQ4JNbw
         bAtFJVNKsUrnJlNyXiSkZskRBGXAsrRCskpgm5ga3gEnJIABXoUfL4X29IvbgJtBUSB0
         0UsyuWxz+83Eb7q5Tip9pNUdNkdXl2v08Ph2Qsbz1OC/ycdl6yAsRJ/QRkPiKT1A+0RP
         q2Ca4RUwXW0qtvkmh4ky56AgAHR/isepJhoJkY/YrUpDLYwft1ODanXxlzUn5qj9s0V9
         VTzjgouBqBlPUQRGkWQTrunU5XFLJZWS8IU0F6mmvFejAhaPpelfbFNEvDU2CF3wQ1d7
         rLVA==
X-Gm-Message-State: AOAM531V7pXhr3BwM5x3Zzso4YfSav6VkEE1sBfrIFK0Ljb1sWJhjKQA
        VMsIUfYr05GAAv3QpmM8Vg0dyL3MHfgd2aZF22U=
X-Google-Smtp-Source: ABdhPJwbRmw+e/yporUG0JiCfdTUsBHQLhSw4joRHWlLquSvp7BF321H3I8yxPtqP2ko/CFyW/RBwgtfEUdd7Wx+7jg=
X-Received: by 2002:a05:620a:298a:: with SMTP id r10mr4130440qkp.381.1637043535864;
 Mon, 15 Nov 2021 22:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20211101110107.29010-1-tommy_huang@aspeedtech.com> <20211101110107.29010-4-tommy_huang@aspeedtech.com>
In-Reply-To: <20211101110107.29010-4-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 16 Nov 2021 06:18:43 +0000
Message-ID: <CACPK8XembQc9vMZbschzC6NuXftcXAuzZbLw1ic==iXkK8c-PA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/aspeed: Update INTR_STS handling
To:     tommy-huang <tommy_huang@aspeedtech.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 at 11:01, tommy-huang <tommy_huang@aspeedtech.com> wrote:
>
>     The V-sync INTR_STS is differnet on AST2600.
>     Change into general rule to handle it.
>
> Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx.h     |  2 ++
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 26 ++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> index 96501152bafa..5eed9275bce7 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> @@ -12,6 +12,8 @@ struct aspeed_gfx {
>         struct regmap                   *scu;
>
>         u32                             dac_reg;
> +       u32                             int_reg;
> +       u32                             int_clr_reg;
>         u32                             vga_scratch_reg;
>         u32                             throd_val;
>         u32                             scan_line_max;
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index b53fee6f1c17..1092060cb59c 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -60,6 +60,8 @@
>
>  struct aspeed_gfx_config {
>         u32 dac_reg;            /* DAC register in SCU */
> +       u32 int_status_reg;     /* Interrupt status register */

This is the same for all supported chips; do you need to introduce the
variable for it?

> +       u32 int_clear_reg;      /* Interrupt clear register */
>         u32 vga_scratch_reg;    /* VGA scratch register in SCU */
>         u32 throd_val;          /* Default Threshold Seting */
>         u32 scan_line_max;      /* Max memory size of one scan line */
> @@ -67,6 +69,8 @@ struct aspeed_gfx_config {
>
>  static const struct aspeed_gfx_config ast2400_config = {
>         .dac_reg = 0x2c,
> +       .int_status_reg = 0x60,
> +       .int_clear_reg = 0x60,
>         .vga_scratch_reg = 0x50,
>         .throd_val = CRT_THROD_LOW(0x1e) | CRT_THROD_HIGH(0x12),
>         .scan_line_max = 64,
> @@ -74,14 +78,26 @@ static const struct aspeed_gfx_config ast2400_config = {
>
>  static const struct aspeed_gfx_config ast2500_config = {
>         .dac_reg = 0x2c,
> +       .int_status_reg = 0x60,
> +       .int_clear_reg = 0x60,
>         .vga_scratch_reg = 0x50,
>         .throd_val = CRT_THROD_LOW(0x24) | CRT_THROD_HIGH(0x3c),
>         .scan_line_max = 128,
>  };
>
> +static const struct aspeed_gfx_config ast2600_config = {
> +       .dac_reg = 0xc0,
> +       .int_status_reg = 0x60,
> +       .int_clear_reg = 0x68,
> +       .vga_scratch_reg = 0x50,
> +       .throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
> +       .scan_line_max = 128,
> +};

This patch combines adding the clear_reg functionality with support
for the 2600. Can you split them out; add int_clear_reg first, and
then add support for the 2600 in the following patch?


> +
>  static const struct of_device_id aspeed_gfx_match[] = {
>         { .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
>         { .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config },
> +       { .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_gfx_match);
> @@ -113,13 +129,15 @@ static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
>  {
>         struct drm_device *drm = data;
>         struct aspeed_gfx *priv = to_aspeed_gfx(drm);
> -       u32 reg;
> +       u32 reg, clr_reg;
>
> -       reg = readl(priv->base + CRT_CTRL1);
> +       reg = readl(priv->base + priv->int_reg);
>
>         if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
>                 drm_crtc_handle_vblank(&priv->pipe.crtc);
> -               writel(reg, priv->base + CRT_CTRL1);
> +               clr_reg = (readl(priv->base + priv->int_clr_reg) |
> +                       CRT_CTRL_VERTICAL_INTR_STS);
> +               writel(clr_reg, priv->base + priv->int_clr_reg);
You do not need to do read-modify-write.

On the 2500 you're writing back the value you read. On the 2600 all of
the bits are read only except the INTR_STS bit, which is W1C, so you
can use the value you read from CRT_CTRL1, so this should be enough:

 writel(reg, priv->base + priv->int_clr_reg);

>                 return IRQ_HANDLED;
>         }
>
> @@ -147,6 +165,8 @@ static int aspeed_gfx_load(struct drm_device *drm)
>         config = match->data;
>
>         priv->dac_reg = config->dac_reg;
> +       priv->int_reg = config->int_status_reg;
> +       priv->int_clr_reg = config->int_clear_reg;
>         priv->vga_scratch_reg = config->vga_scratch_reg;
>         priv->throd_val = config->throd_val;
>         priv->scan_line_max = config->scan_line_max;
> --
> 2.17.1
>
