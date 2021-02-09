Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2F31500E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBINUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhBINUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:20:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D1C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:19:55 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 63so17457713oty.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sN36/8AiDCApQHV/kX0b4fpa0OvOFhUElicB6Dq/DXw=;
        b=Z8jEL+am9PbC4QOwtuhi+PDzgStn4f4ezHfpVE6P4hKC6dKsxLf40+mW68LF/POQJz
         ZUyCeGByl06jny7LqJYvIobWbtmeY1pQd0f4FkxhFNyn1kTQd5EhYzyQDF1qe/a0e8P2
         mEPTLWxPGSaIyP1Z4cTrnqlJAKjXGmikB0Ph0Meh3R1uIMsCQVuwrd+x51XJSzWL3xHe
         kGJ5dJq/3f2TWWbTXXlPYh/XWygDdYvPN1ygZfou780+8/IwvvxUcyGtYVD5QtG7qUlR
         E9vyoZ1bXrMUXU3hGTbSCIo1Yrpl6FPZmT3NXZTyWNPCS7b4JPc6uhtZObKNf4DbwR5a
         ej6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sN36/8AiDCApQHV/kX0b4fpa0OvOFhUElicB6Dq/DXw=;
        b=QN3w4YiCfhS7UPCrrKQ6Qu5spggEQ4E56wokRB48LYz5x90a0+E5wFMZbW1zDEwcZ+
         u3iUY81GDRoWufGM2oL+1U1sfjDLzbZJSOBmOzTSXvjwCZfOIsrdcCiUjpkh65pX/hht
         maHcVMJygf/Co20an5yFeq/McdltSmvw/BZeJ4hHHRqWRRw+dltt6gUS2iAeqe36Ebek
         hPL8B2FFlVh9Ydbo+HGk2VrxyfTEC62zznl5efoj9ZVFMLywcvHLfv6tsCOCHPy2muuk
         uHv4chKDWnMJwii6ereFHq+Ut/U9wSEPUYJL2uUTiud78Di4EwlTi35yX+rz7BfhgUbO
         xWHQ==
X-Gm-Message-State: AOAM5328OFz9H0qtxmuVyCvrf5tvnv6hwxrF2KXZYGHQZCMt+V/Rnhey
        KvjUnmZXgd+V+mDwZVKETuT9iJ6qjYB8GwlhtMWcSg==
X-Google-Smtp-Source: ABdhPJyQg11OlQ4jaawQiWusdDwJ93jPDB8i4Mr25XSP7EJtaXw0QpoGdcly6zhbszMXmbOqxyWreVCVFaG3Hm2T1W0=
X-Received: by 2002:a05:6830:1052:: with SMTP id b18mr1371683otp.91.1612876795341;
 Tue, 09 Feb 2021 05:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20210209125912.3398-1-nsaenzjulienne@suse.de> <20210209125912.3398-10-nsaenzjulienne@suse.de>
In-Reply-To: <20210209125912.3398-10-nsaenzjulienne@suse.de>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Tue, 9 Feb 2021 13:19:45 +0000
Message-ID: <CAMEGJJ3i_hEAnO4rDQ+emqB=OYXetLyKh1kMRwAbUnYZ1e48VA@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 09/16] soc: bcm: bcm2835-power: Add support for
 BCM2711's Argon ASB
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        eric@anholt.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Tue, 9 Feb 2021 at 13:00, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> In BCM2711 the new ARGON ASB took over V3D. The old ASB is still present
> with the ISP and H264 bits, and V3D is in the same place in the new ASB
> as the old one.
>
> Use the fact that 'pm->argon_asb' is populated as a hint that we're on
> BCM2711. On top of that introduce the macro ASB_BASE() which will select
> the correct ASB register base, based on whether we're trying to access
> V3D and which platform we're on.

Please don't refer to this block as ARGON - it is the IP of Raspberry
Pi Trading and it's name is RPiVid.

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v1:
>  - Correct names
>
>  drivers/soc/bcm/bcm2835-power.c | 68 ++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
> index 59b8abfc5617..42e105758b47 100644
> --- a/drivers/soc/bcm/bcm2835-power.c
> +++ b/drivers/soc/bcm/bcm2835-power.c
> @@ -126,8 +126,9 @@
>
>  #define ASB_AXI_BRDG_ID                        0x20
>
> -#define ASB_READ(reg) readl(power->rpivid_asb + (reg))
> -#define ASB_WRITE(reg, val) writel(PM_PASSWORD | (val), power->rpivid_asb + (reg))
> +#define ASB_BASE(is_v3d) (is_v3d && power->argon_asb ? power->argon_asb : power->rpivid_asb)
> +#define ASB_READ(reg, is_v3d) readl(ASB_BASE(is_v3d) + (reg))
> +#define ASB_WRITE(reg, val, is_v3d) writel(PM_PASSWORD | (val), ASB_BASE(is_v3d) + (reg))
>
>  struct bcm2835_power_domain {
>         struct generic_pm_domain base;
> @@ -142,13 +143,16 @@ struct bcm2835_power {
>         void __iomem            *base;
>         /* RPiVid bridge registers. */
>         void __iomem            *rpivid_asb;
> +       /* Argon bridge registers. */
> +       void __iomem            *argon_asb;
>
>         struct genpd_onecell_data pd_xlate;
>         struct bcm2835_power_domain domains[BCM2835_POWER_DOMAIN_COUNT];
>         struct reset_controller_dev reset;
>  };
>
> -static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
> +static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg,
> +                             bool is_v3d)
>  {
>         u64 start;
>
> @@ -158,8 +162,8 @@ static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
>         start = ktime_get_ns();
>
>         /* Enable the module's async AXI bridges. */
> -       ASB_WRITE(reg, ASB_READ(reg) & ~ASB_REQ_STOP);
> -       while (ASB_READ(reg) & ASB_ACK) {
> +       ASB_WRITE(reg, ASB_READ(reg, is_v3d) & ~ASB_REQ_STOP, is_v3d);
> +       while (ASB_READ(reg, is_v3d) & ASB_ACK) {
>                 cpu_relax();
>                 if (ktime_get_ns() - start >= 1000)
>                         return -ETIMEDOUT;
> @@ -168,7 +172,8 @@ static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
>         return 0;
>  }
>
> -static int bcm2835_asb_disable(struct bcm2835_power *power, u32 reg)
> +static int bcm2835_asb_disable(struct bcm2835_power *power, u32 reg,
> +                              bool is_v3d)
>  {
>         u64 start;
>
> @@ -178,8 +183,8 @@ static int bcm2835_asb_disable(struct bcm2835_power *power, u32 reg)
>         start = ktime_get_ns();
>
>         /* Enable the module's async AXI bridges. */
> -       ASB_WRITE(reg, ASB_READ(reg) | ASB_REQ_STOP);
> -       while (!(ASB_READ(reg) & ASB_ACK)) {
> +       ASB_WRITE(reg, ASB_READ(reg, is_v3d) | ASB_REQ_STOP, is_v3d);
> +       while (!(ASB_READ(reg, is_v3d) & ASB_ACK)) {
>                 cpu_relax();
>                 if (ktime_get_ns() - start >= 1000)
>                         return -ETIMEDOUT;
> @@ -274,7 +279,8 @@ static int bcm2835_asb_power_on(struct bcm2835_power_domain *pd,
>                                 u32 pm_reg,
>                                 u32 asb_m_reg,
>                                 u32 asb_s_reg,
> -                               u32 reset_flags)
> +                               u32 reset_flags,
> +                               bool is_v3d)
>  {
>         struct bcm2835_power *power = pd->power;
>         int ret;
> @@ -301,13 +307,13 @@ static int bcm2835_asb_power_on(struct bcm2835_power_domain *pd,
>                 goto err_enable_resets;
>         }
>
> -       ret = bcm2835_asb_enable(power, asb_m_reg);
> +       ret = bcm2835_asb_enable(power, asb_m_reg, is_v3d);
>         if (ret) {
>                 dev_err(power->dev, "Failed to enable ASB master for %s\n",
>                         pd->base.name);
>                 goto err_disable_clk;
>         }
> -       ret = bcm2835_asb_enable(power, asb_s_reg);
> +       ret = bcm2835_asb_enable(power, asb_s_reg, is_v3d);
>         if (ret) {
>                 dev_err(power->dev, "Failed to enable ASB slave for %s\n",
>                         pd->base.name);
> @@ -317,7 +323,7 @@ static int bcm2835_asb_power_on(struct bcm2835_power_domain *pd,
>         return 0;
>
>  err_disable_asb_master:
> -       bcm2835_asb_disable(power, asb_m_reg);
> +       bcm2835_asb_disable(power, asb_m_reg, is_v3d);
>  err_disable_clk:
>         clk_disable_unprepare(pd->clk);
>  err_enable_resets:
> @@ -329,22 +335,23 @@ static int bcm2835_asb_power_off(struct bcm2835_power_domain *pd,
>                                  u32 pm_reg,
>                                  u32 asb_m_reg,
>                                  u32 asb_s_reg,
> -                                u32 reset_flags)
> +                                u32 reset_flags,
> +                                bool is_v3d)
>  {
>         struct bcm2835_power *power = pd->power;
>         int ret;
>
> -       ret = bcm2835_asb_disable(power, asb_s_reg);
> +       ret = bcm2835_asb_disable(power, asb_s_reg, is_v3d);
>         if (ret) {
>                 dev_warn(power->dev, "Failed to disable ASB slave for %s\n",
>                          pd->base.name);
>                 return ret;
>         }
> -       ret = bcm2835_asb_disable(power, asb_m_reg);
> +       ret = bcm2835_asb_disable(power, asb_m_reg, is_v3d);
>         if (ret) {
>                 dev_warn(power->dev, "Failed to disable ASB master for %s\n",
>                          pd->base.name);
> -               bcm2835_asb_enable(power, asb_s_reg);
> +               bcm2835_asb_enable(power, asb_s_reg, is_v3d);
>                 return ret;
>         }
>
> @@ -369,7 +376,7 @@ static int bcm2835_power_pd_power_on(struct generic_pm_domain *domain)
>         case BCM2835_POWER_DOMAIN_GRAFX_V3D:
>                 return bcm2835_asb_power_on(pd, PM_GRAFX,
>                                             ASB_V3D_M_CTRL, ASB_V3D_S_CTRL,
> -                                           PM_V3DRSTN);
> +                                           PM_V3DRSTN, true);
>
>         case BCM2835_POWER_DOMAIN_IMAGE:
>                 return bcm2835_power_power_on(pd, PM_IMAGE);
> @@ -377,17 +384,17 @@ static int bcm2835_power_pd_power_on(struct generic_pm_domain *domain)
>         case BCM2835_POWER_DOMAIN_IMAGE_PERI:
>                 return bcm2835_asb_power_on(pd, PM_IMAGE,
>                                             0, 0,
> -                                           PM_PERIRSTN);
> +                                           PM_PERIRSTN, false);
>
>         case BCM2835_POWER_DOMAIN_IMAGE_ISP:
>                 return bcm2835_asb_power_on(pd, PM_IMAGE,
>                                             ASB_ISP_M_CTRL, ASB_ISP_S_CTRL,
> -                                           PM_ISPRSTN);
> +                                           PM_ISPRSTN, false);
>
>         case BCM2835_POWER_DOMAIN_IMAGE_H264:
>                 return bcm2835_asb_power_on(pd, PM_IMAGE,
>                                             ASB_H264_M_CTRL, ASB_H264_S_CTRL,
> -                                           PM_H264RSTN);
> +                                           PM_H264RSTN, false);
>
>         case BCM2835_POWER_DOMAIN_USB:
>                 PM_WRITE(PM_USB, PM_USB_CTRLEN);
> @@ -435,7 +442,7 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
>         case BCM2835_POWER_DOMAIN_GRAFX_V3D:
>                 return bcm2835_asb_power_off(pd, PM_GRAFX,
>                                              ASB_V3D_M_CTRL, ASB_V3D_S_CTRL,
> -                                            PM_V3DRSTN);
> +                                            PM_V3DRSTN, true);
>
>         case BCM2835_POWER_DOMAIN_IMAGE:
>                 return bcm2835_power_power_off(pd, PM_IMAGE);
> @@ -443,17 +450,17 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
>         case BCM2835_POWER_DOMAIN_IMAGE_PERI:
>                 return bcm2835_asb_power_off(pd, PM_IMAGE,
>                                              0, 0,
> -                                            PM_PERIRSTN);
> +                                            PM_PERIRSTN, false);
>
>         case BCM2835_POWER_DOMAIN_IMAGE_ISP:
>                 return bcm2835_asb_power_off(pd, PM_IMAGE,
>                                              ASB_ISP_M_CTRL, ASB_ISP_S_CTRL,
> -                                            PM_ISPRSTN);
> +                                            PM_ISPRSTN, false);
>
>         case BCM2835_POWER_DOMAIN_IMAGE_H264:
>                 return bcm2835_asb_power_off(pd, PM_IMAGE,
>                                              ASB_H264_M_CTRL, ASB_H264_S_CTRL,
> -                                            PM_H264RSTN);
> +                                            PM_H264RSTN, false);
>
>         case BCM2835_POWER_DOMAIN_USB:
>                 PM_WRITE(PM_USB, 0);
> @@ -626,13 +633,22 @@ static int bcm2835_power_probe(struct platform_device *pdev)
>         power->dev = dev;
>         power->base = pm->base;
>         power->rpivid_asb = pm->rpivid_asb;
> +       power->argon_asb = pm->argon_asb;
>
> -       id = ASB_READ(ASB_AXI_BRDG_ID);
> +       id = ASB_READ(ASB_AXI_BRDG_ID, false);
>         if (id != 0x62726467 /* "BRDG" */) {
> -               dev_err(dev, "ASB register ID returned 0x%08x\n", id);
> +               dev_err(dev, "RPiVid ASB register ID returned 0x%08x\n", id);
>                 return -ENODEV;
>         }
>
> +       if (pm->argon_asb) {
> +               id = ASB_READ(ASB_AXI_BRDG_ID, true);
> +               if (id != 0x62726467 /* "BRDG" */) {
> +                       dev_err(dev, "Argon ASB register ID returned 0x%08x\n", id);
> +                       return -ENODEV;
> +               }
> +       }
> +

Surely these are the same register. Is this the result of a bad merge?

Thanks,

Phil
