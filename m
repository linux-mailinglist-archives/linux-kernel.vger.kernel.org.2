Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D43A4AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 00:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFKWoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKWoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 18:44:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 15:42:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l2so7558743wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cNUN2g0mfX244M+M6Lc6XCabb3Q8HtawWABkFTZIz10=;
        b=hgwQ5QZzCw6+f75Tc6cWR4RvvLzPGwOhhIJFMuUc+ig6HT4C8Afo6IhROd+mDZddhS
         ilQpnsi6pCHQ6MzaQBqAv3Yx4iLMcR7emF2I2sK1iakNYV6zQCjRjjU49qx6ekDE3Dgg
         A4Qkalo1RzzHPXyDHeR1evK+q3J1KTzMuAKPJBKp0k/5InlJN/5XRUv33FayPejMK7pS
         Yujoov3V67/lpIpG5fgVLdGNMRd16V3SoGIVRPJvLz4N+8+fmQWdtRL82fyG3LdyLzWy
         9LzJET96WX03sYH8McONFYjUeVBH6wAJI75TZR3WvWXuEsmWwsyCC+0LH1EdGMg4eQkd
         /uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cNUN2g0mfX244M+M6Lc6XCabb3Q8HtawWABkFTZIz10=;
        b=DTBWkRZysXMbHA8nYJD6Az4x/r/SrE39jQeevwP5o7JRQer3DhcoaGWsR0s50kErNj
         W911q74bZAUTPM5m6bW6YiAd2/kJJacnHwlH+APd8qguKXvG191s9YjuXoeohOV1fcer
         oCiYAB8xQDsntnGL+Suq4B/Xe36kOrPGx0L+C/pbVIVDpFN1DY+doYPHgzXMc36ElRYB
         5cbUKRCwgBIq2FL69xsOEIiZcIst7tM+/RjFSh5IeyJN+RCgYZz5R67aarAmuVAOcZcH
         dWhB+pVneGyDR2G7njp8FTuHKboMo27R4PekNCMkqAwsya5QLZm7fPmeu9aTV1zj9m2s
         8glA==
X-Gm-Message-State: AOAM533tKzIb520HZwCh5LPSwgk/1Mip+nXMWarrdXB/5rnJlsoAhFFP
        b2/7VMFyvmz48wCV1pcXiv0=
X-Google-Smtp-Source: ABdhPJzX+yUY0qiTnmqidx770KUMHkpkQ3vZaKsVej3whoZQJNUdUGn23j8ZLQxHc+rfn4Q1daIngg==
X-Received: by 2002:adf:e5c1:: with SMTP id a1mr6321986wrn.16.1623451327253;
        Fri, 11 Jun 2021 15:42:07 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id p12sm12634130wme.43.2021.06.11.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 15:42:06 -0700 (PDT)
Message-ID: <8cdf2b130ae02ba00324d0a70cbbcd3ba53e1d09.camel@gmail.com>
Subject: Re: [PATCH 1/1] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Jun 2021 00:42:05 +0200
In-Reply-To: <20210525083340.27722-2-nikita.shubin@maquefel.me>
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
         <20210525083340.27722-2-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nikita!

On Tue, 2021-05-25 at 11:33 +0300, Nikita Shubin wrote:
> Converted in-place without moving file to drivers/clk.
> 
> tested on ts7250 (EP9302).
> 
> Only setting rate and change parent tested for, as they
> are missing on ts7250:
> - video
> - I2S
> - ADC/KEYPAD
> - PWM
> 
> Only video and I2S clock are interesting, as they are
> GATE + double DIV + MUX, all other are pretty much
> common but require ep93xx_syscon_swlocked_write to set
> registers.

This doesnt look good in my test:


------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-adc
CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc5-... #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
[<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
[<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a2150>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
[<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
[<c01d8698>] (clk_core_enable_lock) from [<c0266560>] (ep93xx_adc_probe+0xe4/0x1a0)
[<c0266560>] (ep93xx_adc_probe) from [<c02126e0>] (platform_probe+0x34/0x80)
[<c02126e0>] (platform_probe) from [<c0210bf8>] (really_probe+0xe8/0x394)
[<c0210bf8>] (really_probe) from [<c0211464>] (device_driver_attach+0x5c/0x64)
[<c0211464>] (device_driver_attach) from [<c02114e8>] (__driver_attach+0x7c/0xec)
[<c02114e8>] (__driver_attach) from [<c020f1b4>] (bus_for_each_dev+0x78/0xc4)
[<c020f1b4>] (bus_for_each_dev) from [<c0211570>] (driver_attach+0x18/0x24)
[<c0211570>] (driver_attach) from [<c020fab4>] (bus_add_driver+0x140/0x1cc)
[<c020fab4>] (bus_add_driver) from [<c0211c44>] (driver_register+0x74/0x114)
[<c0211c44>] (driver_register) from [<c02134f8>] (__platform_driver_register+0x18/0x24)
[<c02134f8>] (__platform_driver_register) from [<c0470148>] (ep93xx_adc_driver_init+0x10/0x1c)
[<c0470148>] (ep93xx_adc_driver_init) from [<c045ce88>] (do_one_initcall+0x7c/0x1a4)
[<c045ce88>] (do_one_initcall) from [<c045d184>] (kernel_init_freeable+0x17c/0x1fc)
[<c045d184>] (kernel_init_freeable) from [<c03a64d0>] (kernel_init+0x8/0xf8)
[<c03a64d0>] (kernel_init) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
Exception stack(0xc1031fb0 to 0xc1031ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 84c9abeb9dc67909 ]---
ep93xx-adc ep93xx-adc: Cannot enable clock
ep93xx-adc: probe of ep93xx-adc failed with error -108
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-spi.0
CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.13.0-rc5-... #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
[<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
[<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a2150>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
[<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
[<c01d8698>] (clk_core_enable_lock) from [<c023eeb4>] (ep93xx_spi_prepare_hardware+0x10/0x30)
[<c023eeb4>] (ep93xx_spi_prepare_hardware) from [<c023c0f8>] (__spi_pump_messages+0x124/0x620)
[<c023c0f8>] (__spi_pump_messages) from [<c023e5b8>] (__spi_sync+0x280/0x2c0)
[<c023e5b8>] (__spi_sync) from [<c023e61c>] (spi_sync+0x24/0x40)
[<c023e61c>] (spi_sync) from [<c021f8a4>] (spi_sync_transfer.constprop.0+0x64/0x8c)
[<c021f8a4>] (spi_sync_transfer.constprop.0) from [<c021f914>] (regmap_spi_write+0x48/0x70)
[<c021f914>] (regmap_spi_write) from [<c021c320>] (_regmap_raw_write_impl+0x640/0x740)
[<c021c320>] (_regmap_raw_write_impl) from [<c021c49c>] (_regmap_bus_raw_write+0x7c/0xac)
[<c021c49c>] (_regmap_bus_raw_write) from [<c021bbd4>] (_regmap_update_bits+0xec/0xf8)
[<c021bbd4>] (_regmap_update_bits) from [<c021dac4>] (regmap_update_bits_base+0x50/0x7c)
[<c021dac4>] (regmap_update_bits_base) from [<c0290ea8>] (cs4271_component_probe+0x74/0x148)
[<c0290ea8>] (cs4271_component_probe) from [<c02889b4>] (snd_soc_component_probe+0x24/0x74)
[<c02889b4>] (snd_soc_component_probe) from [<c027e9d0>] (soc_probe_component+0x11c/0x29c)
[<c027e9d0>] (soc_probe_component) from [<c027ef14>] (snd_soc_bind_card+0x3c4/0x8a8)
[<c027ef14>] (snd_soc_bind_card) from [<c0291798>] (edb93xx_probe+0x34/0x5c)
[<c0291798>] (edb93xx_probe) from [<c02126e0>] (platform_probe+0x34/0x80)
[<c02126e0>] (platform_probe) from [<c0210bf8>] (really_probe+0xe8/0x394)
[<c0210bf8>] (really_probe) from [<c0211464>] (device_driver_attach+0x5c/0x64)
[<c0211464>] (device_driver_attach) from [<c02114e8>] (__driver_attach+0x7c/0xec)
[<c02114e8>] (__driver_attach) from [<c020f1b4>] (bus_for_each_dev+0x78/0xc4)
[<c020f1b4>] (bus_for_each_dev) from [<c0211570>] (driver_attach+0x18/0x24)
[<c0211570>] (driver_attach) from [<c020fab4>] (bus_add_driver+0x140/0x1cc)
[<c020fab4>] (bus_add_driver) from [<c0211c44>] (driver_register+0x74/0x114)
[<c0211c44>] (driver_register) from [<c02134f8>] (__platform_driver_register+0x18/0x24)
[<c02134f8>] (__platform_driver_register) from [<c047084c>] (edb93xx_driver_init+0x10/0x1c)
[<c047084c>] (edb93xx_driver_init) from [<c045ce88>] (do_one_initcall+0x7c/0x1a4)
[<c045ce88>] (do_one_initcall) from [<c045d184>] (kernel_init_freeable+0x17c/0x1fc)
[<c045d184>] (kernel_init_freeable) from [<c03a64d0>] (kernel_init+0x8/0xf8)
[<c03a64d0>] (kernel_init) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
Exception stack(0xc1031fb0 to 0xc1031ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 84c9abeb9dc6790a ]---
spi_master spi0: failed to prepare transfer hardware: -108
------------[ cut here ]------------
WARNING: CPU: 0 PID: 36 at drivers/clk/clk.c:952 clk_core_disable+0xbc/0xd8
ep93xx-spi.0 already disabled
CPU: 0 PID: 36 Comm: spi0 Tainted: G        W         5.13.0-rc5-... #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
[<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
[<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a2150>] (warn_slowpath_fmt) from [<c01d82a0>] (clk_core_disable+0xbc/0xd8)
[<c01d82a0>] (clk_core_disable) from [<c01d8674>] (clk_core_disable_lock+0x18/0x24)
[<c01d8674>] (clk_core_disable_lock) from [<c023ee98>] (ep93xx_spi_unprepare_hardware+0x20/0x2c)
[<c023ee98>] (ep93xx_spi_unprepare_hardware) from [<c023c35c>] (__spi_pump_messages+0x388/0x620)
[<c023c35c>] (__spi_pump_messages) from [<c0039068>] (kthread_worker_fn+0xfc/0x1a4)
[<c0039068>] (kthread_worker_fn) from [<c0038964>] (kthread+0x104/0x154)
[<c0038964>] (kthread) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
Exception stack(0xc11d1fb0 to 0xc11d1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 84c9abeb9dc6790b ]---

Now I'm able to test without 3 weeks delay, so you can send me
next versions before publishing.

> ---
>  arch/arm/Kconfig             |   2 +-
>  arch/arm/mach-ep93xx/clock.c | 989 ++++++++++++++++++++---------------
>  arch/arm/mach-ep93xx/core.c  |   2 +-
>  arch/arm/mach-ep93xx/soc.h   |  42 +-
>  4 files changed, 593 insertions(+), 442 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2fae14857dcf..4a1a8957aa1b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -354,7 +354,7 @@ config ARCH_EP93XX
>         select CLKSRC_MMIO
>         select CPU_ARM920T
>         select GPIOLIB
> -       select HAVE_LEGACY_CLK
> +       select COMMON_CLK
>         help
>           This enables support for the Cirrus EP93xx series of CPUs.
>  
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 2810eb5b2aca..f728eb96a288 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/soc/cirrus/ep93xx.h>
>  
>  #include "hardware.h"
> @@ -24,348 +25,194 @@
>  
>  #include "soc.h"
>  
> -struct clk {
> -       struct clk      *parent;
> -       unsigned long   rate;
> -       int             users;
> -       int             sw_locked;
> -       void __iomem    *enable_reg;
> -       u32             enable_mask;
> -
> -       unsigned long   (*get_rate)(struct clk *clk);
> -       int             (*set_rate)(struct clk *clk, unsigned long rate);
> -};
> -
> -
> -static unsigned long get_uart_rate(struct clk *clk);
> -
> -static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
> -static int set_div_rate(struct clk *clk, unsigned long rate);
> -static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate);
> -static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate);
> +static DEFINE_SPINLOCK(clk_lock);
>  
> -static struct clk clk_xtali = {
> -       .rate           = EP93XX_EXT_CLK_RATE,
> -};
> -static struct clk clk_uart1 = {
> -       .parent         = &clk_xtali,
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_DEVCFG,
> -       .enable_mask    = EP93XX_SYSCON_DEVCFG_U1EN,
> -       .get_rate       = get_uart_rate,
> -};
> -static struct clk clk_uart2 = {
> -       .parent         = &clk_xtali,
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_DEVCFG,
> -       .enable_mask    = EP93XX_SYSCON_DEVCFG_U2EN,
> -       .get_rate       = get_uart_rate,
> -};
> -static struct clk clk_uart3 = {
> -       .parent         = &clk_xtali,
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_DEVCFG,
> -       .enable_mask    = EP93XX_SYSCON_DEVCFG_U3EN,
> -       .get_rate       = get_uart_rate,
> -};
> -static struct clk clk_pll1 = {
> -       .parent         = &clk_xtali,
> -};
> -static struct clk clk_f = {
> -       .parent         = &clk_pll1,
> -};
> -static struct clk clk_h = {
> -       .parent         = &clk_pll1,
> -};
> -static struct clk clk_p = {
> -       .parent         = &clk_pll1,
> -};
> -static struct clk clk_pll2 = {
> -       .parent         = &clk_xtali,
> -};
> -static struct clk clk_usb_host = {
> -       .parent         = &clk_pll2,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_USH_EN,
> -};
> -static struct clk clk_keypad = {
> -       .parent         = &clk_xtali,
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_KEYTCHCLKDIV,
> -       .enable_mask    = EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
> -       .set_rate       = set_keytchclk_rate,
> -};
> -static struct clk clk_adc = {
> -       .parent         = &clk_xtali,
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_KEYTCHCLKDIV,
> -       .enable_mask    = EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
> -       .set_rate       = set_keytchclk_rate,
> -};
> -static struct clk clk_spi = {
> -       .parent         = &clk_xtali,
> -       .rate           = EP93XX_EXT_CLK_RATE,
> -};
> -static struct clk clk_pwm = {
> -       .parent         = &clk_xtali,
> -       .rate           = EP93XX_EXT_CLK_RATE,
> -};
> +static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
> +static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
> +static char pclk_divisors[] = { 1, 2, 4, 8 };
>  
> -static struct clk clk_video = {
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_VIDCLKDIV,
> -       .enable_mask    = EP93XX_SYSCON_CLKDIV_ENABLE,
> -       .set_rate       = set_div_rate,
> -};
> +static char adc_divisors[] = { 16, 4 };
> +static char sclk_divisors[] = { 2, 4 };
> +static char lrclk_divisors[] = { 32, 64, 128 };
>  
> -static struct clk clk_i2s_mclk = {
> -       .sw_locked      = 1,
> -       .enable_reg     = EP93XX_SYSCON_I2SCLKDIV,
> -       .enable_mask    = EP93XX_SYSCON_CLKDIV_ENABLE,
> -       .set_rate       = set_div_rate,
> +static const char * const mux_parents[] = {
> +       "xtali",
> +       "pll1",
> +       "pll2"
>  };
>  
> -static struct clk clk_i2s_sclk = {
> -       .sw_locked      = 1,
> -       .parent         = &clk_i2s_mclk,
> -       .enable_reg     = EP93XX_SYSCON_I2SCLKDIV,
> -       .enable_mask    = EP93XX_SYSCON_I2SCLKDIV_SENA,
> -       .set_rate       = set_i2s_sclk_rate,
> -};
> +/*
> + * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
> + */
> +static unsigned long calc_pll_rate(unsigned long long rate, u32 config_word)
> +{
> +       int i;
>  
> -static struct clk clk_i2s_lrclk = {
> -       .sw_locked      = 1,
> -       .parent         = &clk_i2s_sclk,
> -       .enable_reg     = EP93XX_SYSCON_I2SCLKDIV,
> -       .enable_mask    = EP93XX_SYSCON_I2SCLKDIV_SENA,
> -       .set_rate       = set_i2s_lrclk_rate,
> -};
> +       rate *= ((config_word >> 11) & 0x1f) + 1;               /* X1FBD */
> +       rate *= ((config_word >> 5) & 0x3f) + 1;                /* X2FBD */
> +       do_div(rate, (config_word & 0x1f) + 1);                 /* X2IPD */
> +       for (i = 0; i < ((config_word >> 16) & 3); i++)         /* PS */
> +               rate >>= 1;
>  
> -/* DMA Clocks */
> -static struct clk clk_m2p0 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P0,
> -};
> -static struct clk clk_m2p1 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P1,
> -};
> -static struct clk clk_m2p2 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P2,
> -};
> -static struct clk clk_m2p3 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P3,
> -};
> -static struct clk clk_m2p4 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P4,
> -};
> -static struct clk clk_m2p5 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P5,
> -};
> -static struct clk clk_m2p6 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P6,
> -};
> -static struct clk clk_m2p7 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P7,
> -};
> -static struct clk clk_m2p8 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P8,
> -};
> -static struct clk clk_m2p9 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2P9,
> -};
> -static struct clk clk_m2m0 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2M0,
> -};
> -static struct clk clk_m2m1 = {
> -       .parent         = &clk_h,
> -       .enable_reg     = EP93XX_SYSCON_PWRCNT,
> -       .enable_mask    = EP93XX_SYSCON_PWRCNT_DMA_M2M1,
> -};
> +       return (unsigned long)rate;
> +}
>  
> -#define INIT_CK(dev,con,ck)                                    \
> -       { .dev_id = dev, .con_id = con, .clk = ck }
> -
> -static struct clk_lookup clocks[] = {
> -       INIT_CK(NULL,                   "xtali",        &clk_xtali),
> -       INIT_CK("apb:uart1",            NULL,           &clk_uart1),
> -       INIT_CK("apb:uart2",            NULL,           &clk_uart2),
> -       INIT_CK("apb:uart3",            NULL,           &clk_uart3),
> -       INIT_CK(NULL,                   "pll1",         &clk_pll1),
> -       INIT_CK(NULL,                   "fclk",         &clk_f),
> -       INIT_CK(NULL,                   "hclk",         &clk_h),
> -       INIT_CK(NULL,                   "apb_pclk",     &clk_p),
> -       INIT_CK(NULL,                   "pll2",         &clk_pll2),
> -       INIT_CK("ohci-platform",        NULL,           &clk_usb_host),
> -       INIT_CK("ep93xx-keypad",        NULL,           &clk_keypad),
> -       INIT_CK("ep93xx-adc",           NULL,           &clk_adc),
> -       INIT_CK("ep93xx-fb",            NULL,           &clk_video),
> -       INIT_CK("ep93xx-spi.0",         NULL,           &clk_spi),
> -       INIT_CK("ep93xx-i2s",           "mclk",         &clk_i2s_mclk),
> -       INIT_CK("ep93xx-i2s",           "sclk",         &clk_i2s_sclk),
> -       INIT_CK("ep93xx-i2s",           "lrclk",        &clk_i2s_lrclk),
> -       INIT_CK(NULL,                   "pwm_clk",      &clk_pwm),
> -       INIT_CK(NULL,                   "m2p0",         &clk_m2p0),
> -       INIT_CK(NULL,                   "m2p1",         &clk_m2p1),
> -       INIT_CK(NULL,                   "m2p2",         &clk_m2p2),
> -       INIT_CK(NULL,                   "m2p3",         &clk_m2p3),
> -       INIT_CK(NULL,                   "m2p4",         &clk_m2p4),
> -       INIT_CK(NULL,                   "m2p5",         &clk_m2p5),
> -       INIT_CK(NULL,                   "m2p6",         &clk_m2p6),
> -       INIT_CK(NULL,                   "m2p7",         &clk_m2p7),
> -       INIT_CK(NULL,                   "m2p8",         &clk_m2p8),
> -       INIT_CK(NULL,                   "m2p9",         &clk_m2p9),
> -       INIT_CK(NULL,                   "m2m0",         &clk_m2m0),
> -       INIT_CK(NULL,                   "m2m1",         &clk_m2m1),
> +struct clk_psc {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       u8 bit_idx;
> +       u32 mask;
> +       u8 shift;
> +       u8 width;
> +       char *div;
> +       u8 num_div;
> +       spinlock_t *lock;
>  };
>  
> -static DEFINE_SPINLOCK(clk_lock);
> +#define to_clk_psc(_hw) container_of(_hw, struct clk_psc, hw)
>  
> -static void __clk_enable(struct clk *clk)
> +static int ep93xx_clk_is_enabled(struct clk_hw *hw)
>  {
> -       if (!clk->users++) {
> -               if (clk->parent)
> -                       __clk_enable(clk->parent);
> -
> -               if (clk->enable_reg) {
> -                       u32 v;
> -
> -                       v = __raw_readl(clk->enable_reg);
> -                       v |= clk->enable_mask;
> -                       if (clk->sw_locked)
> -                               ep93xx_syscon_swlocked_write(v, clk->enable_reg);
> -                       else
> -                               __raw_writel(v, clk->enable_reg);
> -               }
> -       }
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       u32 val = readl(psc->reg);
> +
> +       return (val & BIT(psc->bit_idx)) ? 1 : 0;
>  }
>  
> -int clk_enable(struct clk *clk)
> +static int ep93xx_clk_enable(struct clk_hw *hw)
>  {
> -       unsigned long flags;
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       unsigned long flags = 0;
> +       u32 val;
>  
> -       if (!clk)
> -               return -EINVAL;
> +       if (psc->lock)
> +               spin_lock_irqsave(psc->lock, flags);
> +
> +       val = __raw_readl(psc->reg);
> +       val |= BIT(psc->bit_idx);
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
>  
> -       spin_lock_irqsave(&clk_lock, flags);
> -       __clk_enable(clk);
> -       spin_unlock_irqrestore(&clk_lock, flags);
> +       if (psc->lock)
> +               spin_unlock_irqrestore(psc->lock, flags);
>  
>         return 0;
>  }
> -EXPORT_SYMBOL(clk_enable);
>  
> -static void __clk_disable(struct clk *clk)
> +static void ep93xx_clk_disable(struct clk_hw *hw)
>  {
> -       if (!--clk->users) {
> -               if (clk->enable_reg) {
> -                       u32 v;
> -
> -                       v = __raw_readl(clk->enable_reg);
> -                       v &= ~clk->enable_mask;
> -                       if (clk->sw_locked)
> -                               ep93xx_syscon_swlocked_write(v, clk->enable_reg);
> -                       else
> -                               __raw_writel(v, clk->enable_reg);
> -               }
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       unsigned long flags = 0;
> +       u32 val;
>  
> -               if (clk->parent)
> -                       __clk_disable(clk->parent);
> -       }
> -}
> +       if (psc->lock)
> +               spin_lock_irqsave(psc->lock, flags);
>  
> -void clk_disable(struct clk *clk)
> -{
> -       unsigned long flags;
> +       val = __raw_readl(psc->reg);
> +       val &= ~BIT(psc->bit_idx);
>  
> -       if (!clk)
> -               return;
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
>  
> -       spin_lock_irqsave(&clk_lock, flags);
> -       __clk_disable(clk);
> -       spin_unlock_irqrestore(&clk_lock, flags);
> +       if (psc->lock)
> +               spin_unlock_irqrestore(psc->lock, flags);
>  }
> -EXPORT_SYMBOL(clk_disable);
>  
> -static unsigned long get_uart_rate(struct clk *clk)
> -{
> -       unsigned long rate = clk_get_rate(clk->parent);
> -       u32 value;
> +static const struct clk_ops clk_ep93xx_gate_ops = {
> +       .enable = ep93xx_clk_enable,
> +       .disable = ep93xx_clk_disable,
> +       .is_enabled = ep93xx_clk_is_enabled,
> +};
>  
> -       value = __raw_readl(EP93XX_SYSCON_PWRCNT);
> -       if (value & EP93XX_SYSCON_PWRCNT_UARTBAUD)
> -               return rate;
> -       else
> -               return rate / 2;
> +static struct clk_hw *ep93xx_clk_register_gate(const char *name,
> +                                   const char *parent_name,
> +                                   void __iomem *reg,
> +                                   u8 bit_idx)
> +{
> +       struct clk_init_data init;
> +       struct clk_psc *psc;
> +       struct clk *clk;
> +
> +       psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +       if (!psc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &clk_ep93xx_gate_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
> +       init.parent_names = (parent_name ? &parent_name : NULL);
> +       init.num_parents = (parent_name ? 1 : 0);
> +
> +       psc->reg = reg;
> +       psc->bit_idx = bit_idx;
> +       psc->hw.init = &init;
> +       psc->lock = &clk_lock;
> +
> +       clk = clk_register(NULL, &psc->hw);
> +       if (IS_ERR(clk))
> +               kfree(psc);
> +
> +       return &psc->hw;
>  }
>  
> -unsigned long clk_get_rate(struct clk *clk)
> +static u8 ep93xx_mux_get_parent(struct clk_hw *hw)
>  {
> -       if (clk->get_rate)
> -               return clk->get_rate(clk);
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       u32 val = __raw_readl(psc->reg);
>  
> -       return clk->rate;
> +       if (!(val & EP93XX_SYSCON_CLKDIV_ESEL))
> +               return 0;
> +
> +       if (!(val & EP93XX_SYSCON_CLKDIV_PSEL))
> +               return 1;
> +
> +       return 2;
>  }
> -EXPORT_SYMBOL(clk_get_rate);
>  
> -static int set_keytchclk_rate(struct clk *clk, unsigned long rate)
> +static int ep93xx_mux_set_parent_lock(struct clk_hw *hw, u8 index)
>  {
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       unsigned long flags = 0;
>         u32 val;
> -       u32 div_bit;
>  
> -       val = __raw_readl(clk->enable_reg);
> +       if (index >= ARRAY_SIZE(mux_parents))
> +               return -EINVAL;
>  
> -       /*
> -        * The Key Matrix and ADC clocks are configured using the same
> -        * System Controller register.  The clock used will be either
> -        * 1/4 or 1/16 the external clock rate depending on the
> -        * EP93XX_SYSCON_KEYTCHCLKDIV_KDIV/EP93XX_SYSCON_KEYTCHCLKDIV_ADIV
> -        * bit being set or cleared.
> -        */
> -       div_bit = clk->enable_mask >> 15;
> +       if (psc->lock)
> +               spin_lock_irqsave(psc->lock, flags);
>  
> -       if (rate == EP93XX_KEYTCHCLK_DIV4)
> -               val |= div_bit;
> -       else if (rate == EP93XX_KEYTCHCLK_DIV16)
> -               val &= ~div_bit;
> -       else
> -               return -EINVAL;
> +       val = __raw_readl(psc->reg);
> +       val &= ~(EP93XX_SYSCON_CLKDIV_ESEL | EP93XX_SYSCON_CLKDIV_PSEL);
> +
> +
> +       if (index != 0) {
> +               val |= EP93XX_SYSCON_CLKDIV_ESEL;
> +               val |= (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
> +       }
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +       if (psc->lock)
> +               spin_unlock_irqrestore(psc->lock, flags);
>  
> -       ep93xx_syscon_swlocked_write(val, clk->enable_reg);
> -       clk->rate = rate;
>         return 0;
>  }
>  
> -static int calc_clk_div(struct clk *clk, unsigned long rate,
> -                       int *psel, int *esel, int *pdiv, int *div)
> +static bool _is_best(unsigned long rate, unsigned long now,
> +                    unsigned long best)
>  {
> -       struct clk *mclk;
> -       unsigned long max_rate, actual_rate, mclk_rate, rate_err = -1;
> -       int i, found = 0, __div = 0, __pdiv = 0;
> +       return abs(rate - now) < abs(rate - best);
> +}
>  
> -       /* Don't exceed the maximum rate */
> -       max_rate = max3(clk_pll1.rate / 4, clk_pll2.rate / 4, clk_xtali.rate / 4);
> -       rate = min(rate, max_rate);
> +static int ep93xx_mux_determine_rate(struct clk_hw *hw,
> +                               struct clk_rate_request *req)
> +{
> +       unsigned long rate = req->rate;
> +       struct clk *parent_best = 0;
> +       unsigned long __parent_rate;
> +       unsigned long best_rate = 0, actual_rate, mclk_rate;
> +       unsigned long parent_rate_best;
> +       int __div = 0, __pdiv = 0;
> +       int i;
>  
>         /*
>          * Try the two pll's and the external clock
> @@ -376,213 +223,517 @@ static int calc_clk_div(struct clk *clk, unsigned long rate,
>          * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
>          *
>          */
> -       for (i = 0; i < 3; i++) {
> -               if (i == 0)
> -                       mclk = &clk_xtali;
> -               else if (i == 1)
> -                       mclk = &clk_pll1;
> -               else
> -                       mclk = &clk_pll2;
> -               mclk_rate = mclk->rate * 2;
> +       for (i = 0; i < ARRAY_SIZE(mux_parents); i++) {
> +               struct clk *parent = clk_get_sys(mux_parents[i], NULL);
> +
> +               __parent_rate = clk_get_rate(parent);
> +               mclk_rate = __parent_rate * 2;
>  
>                 /* Try each predivider value */
>                 for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
>                         __div = mclk_rate / (rate * __pdiv);
> -                       if (__div < 2 || __div > 127)
> +                       if (__div < 2 || __div > 127) {
> +                               pr_info("%s : continue __div=%d", __func__, __div);
>                                 continue;
> +                       }
> +
> +                       actual_rate = DIV_ROUND_UP_ULL((u64)mclk_rate, (__pdiv * __div));
>  
> -                       actual_rate = mclk_rate / (__pdiv * __div);
> -
> -                       if (!found || abs(actual_rate - rate) < rate_err) {
> -                               *pdiv = __pdiv - 3;
> -                               *div = __div;
> -                               *psel = (i == 2);
> -                               *esel = (i != 0);
> -                               clk->parent = mclk;
> -                               clk->rate = actual_rate;
> -                               rate_err = abs(actual_rate - rate);
> -                               found = 1;
> +                       if (_is_best(rate, actual_rate, best_rate)) {
> +                               best_rate = actual_rate;
> +                               parent_rate_best = __parent_rate;
> +                               parent_best = parent;
>                         }
>                 }
>         }
>  
> -       if (!found)
> +       if (!parent_best)
>                 return -EINVAL;
>  
> +       req->best_parent_rate = parent_rate_best;
> +       req->best_parent_hw = __clk_get_hw(parent_best);
> +       req->rate = best_rate;
> +
>         return 0;
>  }
>  
> -static int set_div_rate(struct clk *clk, unsigned long rate)
> +static unsigned long ep93xx_ddiv_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
>  {
> -       int err, psel = 0, esel = 0, pdiv = 0, div = 0;
> -       u32 val;
> -
> -       err = calc_clk_div(clk, rate, &psel, &esel, &pdiv, &div);
> -       if (err)
> -               return err;
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       unsigned long rate = 0;
> +       u32 val = __raw_readl(psc->reg);
> +       int __pdiv = ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);
> +       int __div = val & 0x7f;
>  
> -       /* Clear the esel, psel, pdiv and div bits */
> -       val = __raw_readl(clk->enable_reg);
> -       val &= ~0x7fff;
> +       if (__div > 0)
> +               rate = (parent_rate * 2) / ((__pdiv + 3) * __div);
>  
> -       /* Set the new esel, psel, pdiv and div bits for the new clock rate */
> -       val |= (esel ? EP93XX_SYSCON_CLKDIV_ESEL : 0) |
> -               (psel ? EP93XX_SYSCON_CLKDIV_PSEL : 0) |
> -               (pdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | div;
> -       ep93xx_syscon_swlocked_write(val, clk->enable_reg);
> -       return 0;
> +       return rate;
>  }
>  
> -static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate)
> +static int ep93xx_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long parent_rate)
>  {
> -       unsigned val = __raw_readl(clk->enable_reg);
> -
> -       if (rate == clk_i2s_mclk.rate / 2)
> -               ep93xx_syscon_swlocked_write(val & ~EP93XX_I2SCLKDIV_SDIV, 
> -                                            clk->enable_reg);
> -       else if (rate == clk_i2s_mclk.rate / 4)
> -               ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_SDIV, 
> -                                            clk->enable_reg);
> -       else
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       int pdiv = 0, div = 0;
> +       unsigned long best_rate = 0, actual_rate, mclk_rate, rate_err = -1;
> +       int found = 0, __div = 0, __pdiv = 0;
> +       u32 val = __raw_readl(psc->reg);
> +
> +       mclk_rate = parent_rate * 2;
> +
> +       for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
> +               __div = mclk_rate / (rate * __pdiv);
> +               if (__div < 2 || __div > 127)
> +                       continue;
> +
> +               actual_rate = mclk_rate / (__pdiv * __div);
> +
> +               if (!found || abs(actual_rate - rate) < rate_err) {
> +                       pdiv = __pdiv - 3;
> +                       div = __div;
> +                       best_rate = actual_rate;
> +                       rate_err = abs(actual_rate - rate);
> +                       found = 1;
> +               }
> +       }
> +
> +       if (!found)
>                 return -EINVAL;
>  
> -       clk_i2s_sclk.rate = rate;
> +       /* Clear old dividers */
> +       val &= ~0x37f;
> +
> +       /* Set the new pdiv and div bits for the new clock rate */
> +       val |= (pdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | div;
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
>         return 0;
>  }
>  
> -static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate)
> -{
> -       unsigned val = __raw_readl(clk->enable_reg) & 
> -               ~EP93XX_I2SCLKDIV_LRDIV_MASK;
> -       
> -       if (rate == clk_i2s_sclk.rate / 32)
> -               ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV32,
> -                                            clk->enable_reg);
> -       else if (rate == clk_i2s_sclk.rate / 64)
> -               ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV64,
> -                                            clk->enable_reg);
> -       else if (rate == clk_i2s_sclk.rate / 128)
> -               ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV128,
> -                                            clk->enable_reg);
> -       else
> -               return -EINVAL;
> +static const struct clk_ops clk_ddiv_ops = {
> +       .enable = ep93xx_clk_enable,
> +       .disable = ep93xx_clk_disable,
> +       .is_enabled = ep93xx_clk_is_enabled,
> +       .get_parent = ep93xx_mux_get_parent,
> +       .set_parent = ep93xx_mux_set_parent_lock,
> +       .determine_rate = ep93xx_mux_determine_rate,
> +       .recalc_rate = ep93xx_ddiv_recalc_rate,
> +       .set_rate = ep93xx_ddiv_set_rate,
> +};
>  
> -       clk_i2s_lrclk.rate = rate;
> -       return 0;
> +static struct clk_hw *clk_hw_register_ddiv(const char *name,
> +                                         void __iomem *reg,
> +                                         u8 bit_idx)
> +{
> +       struct clk_init_data init;
> +       struct clk_psc *psc;
> +       struct clk *clk;
> +
> +       psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +       if (!psc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &clk_ddiv_ops;
> +       init.flags = 0;
> +       init.parent_names = mux_parents;
> +       init.num_parents = ARRAY_SIZE(mux_parents);
> +
> +       psc->reg = reg;
> +       psc->bit_idx = bit_idx;
> +       psc->lock = &clk_lock;
> +       psc->hw.init = &init;
> +
> +       clk = clk_register(NULL, &psc->hw);
> +       if (IS_ERR(clk))
> +               kfree(psc);
> +
> +       return &psc->hw;
>  }
>  
> -int clk_set_rate(struct clk *clk, unsigned long rate)
> +static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
>  {
> -       if (clk->set_rate)
> -               return clk->set_rate(clk, rate);
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       u32 val = __raw_readl(psc->reg);
> +       u8 index = (val & psc->mask) >> psc->shift;
> +
> +       if (index > psc->num_div)
> +               return 0;
>  
> -       return -EINVAL;
> +       return DIV_ROUND_UP_ULL(parent_rate, psc->div[index]);
>  }
> -EXPORT_SYMBOL(clk_set_rate);
>  
> -long clk_round_rate(struct clk *clk, unsigned long rate)
> +static long ep93xx_div_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                  unsigned long *parent_rate)
>  {
> -       WARN_ON(clk);
> -       return 0;
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       unsigned long best = 0, now, maxdiv;
> +       int i;
> +
> +       maxdiv = psc->div[psc->num_div - 1];
> +
> +       for (i = 0; i < psc->num_div; i++) {
> +               if ((rate * psc->div[i]) == *parent_rate)
> +                       return DIV_ROUND_UP_ULL((u64)*parent_rate, psc->div[i]);
> +
> +               now = DIV_ROUND_UP_ULL((u64)*parent_rate, psc->div[i]);
> +
> +               if (_is_best(rate, now, best))
> +                       best = now;
> +       }
> +
> +       if (!best)
> +               best = DIV_ROUND_UP_ULL(*parent_rate, maxdiv);
> +
> +       return best;
>  }
> -EXPORT_SYMBOL(clk_round_rate);
>  
> -int clk_set_parent(struct clk *clk, struct clk *parent)
> +static int ep93xx_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
>  {
> -       WARN_ON(clk);
> +       struct clk_psc *psc = to_clk_psc(hw);
> +       u32 val = __raw_readl(psc->reg) & ~psc->mask;
> +       int i;
> +
> +       for (i = 0; i < psc->num_div; i++)
> +               if (rate == parent_rate / psc->div[i]) {
> +                       val |= i << psc->shift;
> +                       break;
> +               }
> +
> +       if (i == psc->num_div)
> +               return -EINVAL;
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
>         return 0;
>  }
> -EXPORT_SYMBOL(clk_set_parent);
>  
> -struct clk *clk_get_parent(struct clk *clk)
> +static const struct clk_ops ep93xx_div_ops = {
> +       .enable = ep93xx_clk_enable,
> +       .disable = ep93xx_clk_disable,
> +       .is_enabled = ep93xx_clk_is_enabled,
> +       .recalc_rate = ep93xx_div_recalc_rate,
> +       .round_rate = ep93xx_div_round_rate,
> +       .set_rate = ep93xx_div_set_rate,
> +};
> +
> +static struct clk_hw *clk_hw_register_div(const char *name,
> +                                         const char *parent_name,
> +                                         void __iomem *reg,
> +                                         u8 enable_bit,
> +                                         u8 shift,
> +                                         u8 width,
> +                                         char *clk_divisors,
> +                                         u8 num_div)
>  {
> -       return clk->parent;
> +       struct clk_init_data init;
> +       struct clk_psc *psc;
> +       struct clk *clk;
> +
> +       psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +       if (!psc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &ep93xx_div_ops;
> +       init.flags = 0;
> +       init.parent_names = (parent_name ? &parent_name : NULL);
> +       init.num_parents = 1;
> +
> +       psc->reg = reg;
> +       psc->bit_idx = enable_bit;
> +       psc->mask = GENMASK(shift + width - 1, shift);
> +       psc->shift = shift;
> +       psc->div = clk_divisors;
> +       psc->num_div = num_div;
> +       psc->lock = &clk_lock;
> +       psc->hw.init = &init;
> +
> +       clk = clk_register(NULL, &psc->hw);
> +       if (IS_ERR(clk))
> +               kfree(psc);
> +
> +       return &psc->hw;
>  }
> -EXPORT_SYMBOL(clk_get_parent);
>  
> +struct ep93xx_gate {
> +       unsigned int bit;
> +       const char *dev_id;
> +       const char *con_id;
> +};
>  
> -static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
> -static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
> -static char pclk_divisors[] = { 1, 2, 4, 8 };
> +static struct ep93xx_gate ep93xx_uarts[] = {
> +       {EP93XX_SYSCON_DEVCFG_U1EN, "apb:uart1", NULL},
> +       {EP93XX_SYSCON_DEVCFG_U2EN, "apb:uart2", NULL},
> +       {EP93XX_SYSCON_DEVCFG_U3EN, "apb:uart3", NULL},
> +};
>  
> -/*
> - * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
> - */
> -static unsigned long calc_pll_rate(u32 config_word)
> +static void __init ep93xx_uart_clock_init(void)
>  {
> -       unsigned long long rate;
> -       int i;
> +       unsigned int i;
> +       struct clk_hw *hw;
> +       u32 value;
> +       unsigned int clk_uart_div;
>  
> -       rate = clk_xtali.rate;
> -       rate *= ((config_word >> 11) & 0x1f) + 1;               /* X1FBD */
> -       rate *= ((config_word >> 5) & 0x3f) + 1;                /* X2FBD */
> -       do_div(rate, (config_word & 0x1f) + 1);                 /* X2IPD */
> -       for (i = 0; i < ((config_word >> 16) & 3); i++)         /* PS */
> -               rate >>= 1;
> +       value = __raw_readl(EP93XX_SYSCON_PWRCNT);
> +       if (value & EP93XX_SYSCON_PWRCNT_UARTBAUD)
> +               clk_uart_div = 1;
> +       else
> +               clk_uart_div = 2;
>  
> -       return (unsigned long)rate;
> +       hw = clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);
> +
> +       /* parenting uart gate clocks to uart clock */
> +       for (i = 0; i < ARRAY_SIZE(ep93xx_uarts); i++) {
> +               hw = ep93xx_clk_register_gate(ep93xx_uarts[i].dev_id,
> +                                       "uart",
> +                                       EP93XX_SYSCON_DEVCFG,
> +                                       ep93xx_uarts[i].bit);
> +
> +               clk_hw_register_clkdev(hw, NULL, ep93xx_uarts[i].dev_id);
> +       }
>  }
>  
> +static struct ep93xx_gate ep93xx_dmas[] = {
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P0, NULL, "m2p0"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P1, NULL, "m2p1"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P2, NULL, "m2p2"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P3, NULL, "m2p3"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P4, NULL, "m2p4"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P5, NULL, "m2p5"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P6, NULL, "m2p6"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P7, NULL, "m2p7"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P8, NULL, "m2p8"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2P9, NULL, "m2p9"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2M0, NULL, "m2m0"},
> +       {EP93XX_SYSCON_PWRCNT_DMA_M2M1, NULL, "m2m1"},
> +};
> +
>  static void __init ep93xx_dma_clock_init(void)
>  {
> -       clk_m2p0.rate = clk_h.rate;
> -       clk_m2p1.rate = clk_h.rate;
> -       clk_m2p2.rate = clk_h.rate;
> -       clk_m2p3.rate = clk_h.rate;
> -       clk_m2p4.rate = clk_h.rate;
> -       clk_m2p5.rate = clk_h.rate;
> -       clk_m2p6.rate = clk_h.rate;
> -       clk_m2p7.rate = clk_h.rate;
> -       clk_m2p8.rate = clk_h.rate;
> -       clk_m2p9.rate = clk_h.rate;
> -       clk_m2m0.rate = clk_h.rate;
> -       clk_m2m1.rate = clk_h.rate;
> +       unsigned int i;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       for (i = 0; i < ARRAY_SIZE(ep93xx_dmas); i++) {
> +               hw = clk_hw_register_gate(NULL, ep93xx_dmas[i].con_id,
> +                                       "hclk", 0,
> +                                       EP93XX_SYSCON_PWRCNT,
> +                                       ep93xx_dmas[i].bit,
> +                                       0,
> +                                       &clk_lock);
> +
> +               ret = clk_hw_register_clkdev(hw, ep93xx_dmas[i].con_id, NULL);
> +               if (ret)
> +                       pr_err("%s: failed to register lookup %s\n",
> +                              __func__, ep93xx_dmas[i].con_id);
> +       }
>  }
>  
>  static int __init ep93xx_clock_init(void)
>  {
>         u32 value;
> +       struct clk_hw *hw;
> +       unsigned long clk_pll1_rate;
> +       unsigned long clk_f_rate;
> +       unsigned long clk_h_rate;
> +       unsigned long clk_p_rate;
> +       unsigned long clk_pll2_rate;
> +       unsigned int clk_f_div;
> +       unsigned int clk_h_div;
> +       unsigned int clk_p_div;
> +       unsigned int clk_usb_div;
> +       unsigned long clk_spi_div;
> +
> +       hw = clk_hw_register_fixed_rate(NULL, "xtali", NULL, 0, EP93XX_EXT_CLK_RATE);
> +       clk_hw_register_clkdev(hw, NULL, "xtali");
>  
>         /* Determine the bootloader configured pll1 rate */
>         value = __raw_readl(EP93XX_SYSCON_CLKSET1);
>         if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
> -               clk_pll1.rate = clk_xtali.rate;
> +               clk_pll1_rate = EP93XX_EXT_CLK_RATE;
>         else
> -               clk_pll1.rate = calc_pll_rate(value);
> +               clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
> +
> +       hw = clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_pll1_rate);
> +       clk_hw_register_clkdev(hw, NULL, "pll1");
>  
>         /* Initialize the pll1 derived clocks */
> -       clk_f.rate = clk_pll1.rate / fclk_divisors[(value >> 25) & 0x7];
> -       clk_h.rate = clk_pll1.rate / hclk_divisors[(value >> 20) & 0x7];
> -       clk_p.rate = clk_h.rate / pclk_divisors[(value >> 18) & 0x3];
> +       clk_f_div = fclk_divisors[(value >> 25) & 0x7];
> +       clk_h_div = hclk_divisors[(value >> 20) & 0x7];
> +       clk_p_div = pclk_divisors[(value >> 18) & 0x3];
> +
> +       hw = clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, clk_f_div);
> +       clk_f_rate = clk_get_rate(hw->clk);
> +       hw = clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, clk_h_div);
> +       clk_h_rate = clk_get_rate(hw->clk);
> +       hw = clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, clk_p_div);
> +       clk_p_rate = clk_get_rate(hw->clk);
> +
> +       clk_hw_register_clkdev(hw, "apb_pclk", NULL);
> +
>         ep93xx_dma_clock_init();
>  
>         /* Determine the bootloader configured pll2 rate */
>         value = __raw_readl(EP93XX_SYSCON_CLKSET2);
>         if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
> -               clk_pll2.rate = clk_xtali.rate;
> +               clk_pll2_rate = EP93XX_EXT_CLK_RATE;
>         else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
> -               clk_pll2.rate = calc_pll_rate(value);
> +               clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
>         else
> -               clk_pll2.rate = 0;
> +               clk_pll2_rate = 0;
> +
> +       hw = clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_pll2_rate);
> +       clk_hw_register_clkdev(hw, NULL, "pll2");
>  
>         /* Initialize the pll2 derived clocks */
> -       clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
> +
> +       /*
> +        * These four bits set the divide ratio between the PLL2
> +        * output and the USB clock.
> +        * 0000 - Divide by 1
> +        * 0001 - Divide by 2
> +        * 0010 - Divide by 3
> +        * 0011 - Divide by 4
> +        * 0100 - Divide by 5
> +        * 0101 - Divide by 6
> +        * 0110 - Divide by 7
> +        * 0111 - Divide by 8
> +        * 1000 - Divide by 9
> +        * 1001 - Divide by 10
> +        * 1010 - Divide by 11
> +        * 1011 - Divide by 12
> +        * 1100 - Divide by 13
> +        * 1101 - Divide by 14
> +        * 1110 - Divide by 15
> +        * 1111 - Divide by 1
> +        * On power-on-reset these bits are reset to 0000b.
> +        */
> +
> +       clk_usb_div = (((value >> 28) & 0xf) + 1);
> +       hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
> +       hw = clk_hw_register_gate(NULL, "ohci-platform",
> +                               "usb_clk", 0,
> +                               EP93XX_SYSCON_PWRCNT,
> +                               EP93XX_SYSCON_PWRCNT_USH_EN,
> +                               0,
> +                               &clk_lock);
> +       clk_hw_register_clkdev(hw, NULL, "ohci-platform");
>  
>         /*
>          * EP93xx SSP clock rate was doubled in version E2. For more information
>          * see:
>          *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
>          */
> +       clk_spi_div = 1;
>         if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
> -               clk_spi.rate /= 2;
> +               clk_spi_div = 2;
> +       hw = clk_hw_register_fixed_factor(NULL, "ep93xx-spi.0", "xtali", 0, 1, clk_spi_div);
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-spi.0");
> +
> +       /* pwm clock */
> +       hw = clk_hw_register_fixed_factor(NULL, "pwm_clk", "xtali", 0, 1, 1);
> +       clk_hw_register_clkdev(hw, "pwm_clk", NULL);
>  
>         pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
> -               clk_pll1.rate / 1000000, clk_pll2.rate / 1000000);
> +               clk_pll1_rate / 1000000, clk_pll2_rate / 1000000);
>         pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
> -               clk_f.rate / 1000000, clk_h.rate / 1000000,
> -               clk_p.rate / 1000000);
> +               clk_f_rate / 1000000, clk_h_rate / 1000000,
> +               clk_p_rate / 1000000);
> +
> +
> +       ep93xx_uart_clock_init();
> +
> +       /* touchscreen/adc clock */
> +       hw = clk_hw_register_div("ep93xx-adc",
> +                               "xtali",
> +                               EP93XX_SYSCON_KEYTCHCLKDIV,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_ADIV,
> +                               1,
> +                               adc_divisors,
> +                               ARRAY_SIZE(adc_divisors));
> +
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-adc");
> +
> +       /* keypad clock */
> +       hw = clk_hw_register_div("ep93xx-keypad",
> +                               "xtali",
> +                               EP93XX_SYSCON_KEYTCHCLKDIV,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_KDIV,
> +                               1,
> +                               adc_divisors,
> +                               ARRAY_SIZE(adc_divisors));
> +
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-keypad");
> +
> +       /* On reset PDIV and VDIV is set to zero, while PDIV zero
> +        * means clock disable, VDIV shouldn't be zero.
> +        * So i set both dividers to minimum.
> +        */
> +       /* ENA - Enable CLK divider. */
> +       /* PDIV - 00 - Disable clock */
> +       /* VDIV - at least 2 */
> +       /* Check and enable video clk registers */
> +       value = __raw_readl(EP93XX_SYSCON_VIDCLKDIV);
> +       value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +       ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_VIDCLKDIV);
> +
> +       /* check and enable i2s clk registers */
> +       value = __raw_readl(EP93XX_SYSCON_I2SCLKDIV);
> +       value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +       ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_I2SCLKDIV);
> +
> +       /* video clk */
> +       hw = clk_hw_register_ddiv("ep93xx-fb",
> +                               EP93XX_SYSCON_VIDCLKDIV,
> +                               EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-fb");
> +
> +       /* i2s clk */
> +       hw = clk_hw_register_ddiv("mclk",
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +       clk_hw_register_clkdev(hw, "mclk", "ep93xx-i2s");
> +
> +       /* i2s sclk */
> +#define EP93XX_I2SCLKDIV_SDIV_SHIFT    16
> +#define EP93XX_I2SCLKDIV_SDIV_WIDTH    1
> +       hw = clk_hw_register_div("sclk",
> +                               "mclk",
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_I2SCLKDIV_SENA,
> +                               EP93XX_I2SCLKDIV_SDIV_SHIFT,
> +                               EP93XX_I2SCLKDIV_SDIV_WIDTH,
> +                               sclk_divisors,
> +                               ARRAY_SIZE(sclk_divisors));
> +
> +       clk_hw_register_clkdev(hw, "sclk", "ep93xx-i2s");
> +
> +       /* i2s lrclk */
> +#define EP93XX_I2SCLKDIV_LRDIV32_SHIFT 17
> +#define EP93XX_I2SCLKDIV_LRDIV32_WIDTH 3
> +       hw = clk_hw_register_div("lrclk",
> +                               "sclk",
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_I2SCLKDIV_SENA,
> +                               EP93XX_I2SCLKDIV_LRDIV32_SHIFT,
> +                               EP93XX_I2SCLKDIV_LRDIV32_WIDTH,
> +                               lrclk_divisors,
> +                               ARRAY_SIZE(lrclk_divisors));
> +
> +       clk_hw_register_clkdev(hw, "lrclk", "ep93xx-i2s");
> +
> +       /* IrDa clk uses same pattern but no init code presents in original clock driver */
>  
> -       clkdev_add_table(clocks, ARRAY_SIZE(clocks));
>         return 0;
>  }
>  postcore_initcall(ep93xx_clock_init);
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 6fb19a393fd2..bbb79f263331 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -214,7 +214,7 @@ static int ep93xx_ohci_power_on(struct platform_device *pdev)
>                         return PTR_ERR(ep93xx_ohci_host_clock);
>         }
>  
> -       return clk_enable(ep93xx_ohci_host_clock);
> +       return clk_prepare_enable(ep93xx_ohci_host_clock);
>  }
>  
>  static void ep93xx_ohci_power_off(struct platform_device *pdev)
> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
> index f2dace1c9154..94ef7f275f94 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -111,19 +111,19 @@
>  #define EP93XX_SYSCON_PWRCNT           EP93XX_SYSCON_REG(0x04)
>  #define EP93XX_SYSCON_PWRCNT_FIR_EN    (1<<31)
>  #define EP93XX_SYSCON_PWRCNT_UARTBAUD  (1<<29)
> -#define EP93XX_SYSCON_PWRCNT_USH_EN    (1<<28)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2M1  (1<<27)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2M0  (1<<26)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P8  (1<<25)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P9  (1<<24)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P6  (1<<23)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P7  (1<<22)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P4  (1<<21)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P5  (1<<20)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P2  (1<<19)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P3  (1<<18)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P0  (1<<17)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P1  (1<<16)
> +#define EP93XX_SYSCON_PWRCNT_USH_EN    28
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M1  27
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M0  26
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P8  25
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P9  24
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P6  23
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P7  22
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P4  21
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P5  20
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P2  19
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P3  18
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P0  17
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P1  16
>  #define EP93XX_SYSCON_HALT             EP93XX_SYSCON_REG(0x08)
>  #define EP93XX_SYSCON_STANDBY          EP93XX_SYSCON_REG(0x0c)
>  #define EP93XX_SYSCON_CLKSET1          EP93XX_SYSCON_REG(0x20)
> @@ -139,13 +139,13 @@
>  #define EP93XX_SYSCON_DEVCFG_GONK      (1<<27)
>  #define EP93XX_SYSCON_DEVCFG_TONG      (1<<26)
>  #define EP93XX_SYSCON_DEVCFG_MONG      (1<<25)
> -#define EP93XX_SYSCON_DEVCFG_U3EN      (1<<24)
> +#define EP93XX_SYSCON_DEVCFG_U3EN      24
>  #define EP93XX_SYSCON_DEVCFG_CPENA     (1<<23)
>  #define EP93XX_SYSCON_DEVCFG_A2ONG     (1<<22)
>  #define EP93XX_SYSCON_DEVCFG_A1ONG     (1<<21)
> -#define EP93XX_SYSCON_DEVCFG_U2EN      (1<<20)
> +#define EP93XX_SYSCON_DEVCFG_U2EN      20
>  #define EP93XX_SYSCON_DEVCFG_EXVC      (1<<19)
> -#define EP93XX_SYSCON_DEVCFG_U1EN      (1<<18)
> +#define EP93XX_SYSCON_DEVCFG_U1EN      18
>  #define EP93XX_SYSCON_DEVCFG_TIN       (1<<17)
>  #define EP93XX_SYSCON_DEVCFG_HC3IN     (1<<15)
>  #define EP93XX_SYSCON_DEVCFG_HC3EN     (1<<14)
> @@ -163,12 +163,12 @@
>  #define EP93XX_SYSCON_DEVCFG_KEYS      (1<<1)
>  #define EP93XX_SYSCON_DEVCFG_SHENA     (1<<0)
>  #define EP93XX_SYSCON_VIDCLKDIV                EP93XX_SYSCON_REG(0x84)
> -#define EP93XX_SYSCON_CLKDIV_ENABLE    (1<<15)
> +#define EP93XX_SYSCON_CLKDIV_ENABLE    15
>  #define EP93XX_SYSCON_CLKDIV_ESEL      (1<<14)
>  #define EP93XX_SYSCON_CLKDIV_PSEL      (1<<13)
>  #define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT        8
>  #define EP93XX_SYSCON_I2SCLKDIV                EP93XX_SYSCON_REG(0x8c)
> -#define EP93XX_SYSCON_I2SCLKDIV_SENA   (1<<31)
> +#define EP93XX_SYSCON_I2SCLKDIV_SENA   31
>  #define EP93XX_SYSCON_I2SCLKDIV_ORIDE   (1<<29)
>  #define EP93XX_SYSCON_I2SCLKDIV_SPOL   (1<<19)
>  #define EP93XX_I2SCLKDIV_SDIV          (1 << 16)
> @@ -177,9 +177,9 @@
>  #define EP93XX_I2SCLKDIV_LRDIV128      (2 << 17)
>  #define EP93XX_I2SCLKDIV_LRDIV_MASK    (3 << 17)
>  #define EP93XX_SYSCON_KEYTCHCLKDIV     EP93XX_SYSCON_REG(0x90)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN        (1<<31)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV        (1<<16)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN (1<<15)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN        31
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV        16
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN 15
>  #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV        (1<<0)
>  #define EP93XX_SYSCON_SYSCFG           EP93XX_SYSCON_REG(0x9c)
>  #define EP93XX_SYSCON_SYSCFG_REV_MASK  (0xf0000000)

-- 
Alexander Sverdlin.


