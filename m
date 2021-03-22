Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31336343F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCVLTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCVLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:19:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:19:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo9015506wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILH1ojuvD8rXlNPbR2kqJNn2iUTPKEEwesIarB0NxY0=;
        b=vnQn28tDthzyGeFsAtGlSU5XPPXOE6nA+A3Cp+qp7Qxq2rVooE7geFWbGABrl75ZCu
         riYuL/KfUnsLkVO51wnijWm1MGwHyZ7eWRP4ow5AM42LZGQe9S759U/PRxt5L5NM66yt
         VSRkcKwCCOhW+mbpnEXJu3Xb42FPfC4qQKeAXy6/hjxENxAHfM+O+2r2Z9FGA5dp8sDi
         7WmbYby7sGTlirmP5FX5cOYrTIT8COB8exGmGW/S6b45pZWZGvuwWKybWEmkXFc3zSYK
         yJPyzAzSF1JBDN1C1v+h9SkGrQcJEa3HOhzU1OxRIf0MyENPL4smXwbMxDxKd10U4yUy
         7/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILH1ojuvD8rXlNPbR2kqJNn2iUTPKEEwesIarB0NxY0=;
        b=bD6ngZlGoGp7gbxL5X/cqiEM5TDQUaS3ajpGyDW3fprGgWJPKiB7NvSLpKJjhsEaVC
         zJYTwMTG6gwu7/RNIv2J5y/F6EQK+5aRb90vVQOwRclc0mcdPKf1TEccyWJsxpUbE5Q8
         VDYgxK2M2uOP973LXlN4U90VbhXQhIQye/CASk8KxKPJYk4UzVtZXewjkDH61pff4YIx
         nX5msGlJpJBPLYjaLBmOpNvQWA+H0xUmWxFscPWrkQm4yluuYhEmGuo9GYvljvrmq9rg
         Ekhoeq9m9Na+RqVX1j1CnstotqjSfwPxe05MGzvjxm+D8wgaIaOwiyotFrfqyvn4+PXs
         9fKw==
X-Gm-Message-State: AOAM531QAXyIvU8uQGsNXPy0oJq7gaOI6lmf3MZpxmwBtfpbt1BJuSNQ
        Vxj/sA6uIaA/hrsRsviGoKyk8g==
X-Google-Smtp-Source: ABdhPJyGvEQSAsL6wRiONIJQgj72d0B3XRNm8MAiCdfU/a3L5SW0OnnT42EkCRK+fw5GUqYlno24RQ==
X-Received: by 2002:a1c:9a47:: with SMTP id c68mr15288831wme.63.1616411976164;
        Mon, 22 Mar 2021 04:19:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8b:d5f9:2138:169c? ([2a01:e34:ed2f:f020:d8b:d5f9:2138:169c])
        by smtp.googlemail.com with ESMTPSA id m9sm19734029wro.52.2021.03.22.04.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 04:19:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/mediatek: Split mediatek drivers
 into 2 files
To:     Evan Benn <evanbenn@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
References: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5a0272dc-bb00-ac4b-4e44-5a2980d7baaa@linaro.org>
Date:   Mon, 22 Mar 2021 12:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Evan,

On 18/03/2021 06:04, Evan Benn wrote:
> mtk_gpt and mtk_syst drivers for mt6577 and mt6765 devices were not
> sharing any code. So split them into separate files.

For the sake of consistency, keeping all in one is better.

Thanks
  -- Daniel

> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
> 
>  arch/arm/mach-mediatek/Kconfig                |   3 +-
>  arch/arm64/Kconfig.platforms                  |   3 +-
>  drivers/clocksource/Kconfig                   |  13 +-
>  drivers/clocksource/Makefile                  |   3 +-
>  ...mer-mediatek.c => timer-mediatek-mt6577.c} | 100 -------------
>  drivers/clocksource/timer-mediatek-mt6765.c   | 135 ++++++++++++++++++
>  6 files changed, 151 insertions(+), 106 deletions(-)
>  rename drivers/clocksource/{timer-mediatek.c => timer-mediatek-mt6577.c} (69%)
>  create mode 100644 drivers/clocksource/timer-mediatek-mt6765.c
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 9e0f592d87d8..8686f992c4b6 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -4,7 +4,8 @@ menuconfig ARCH_MEDIATEK
>  	depends on ARCH_MULTI_V7
>  	select ARM_GIC
>  	select PINCTRL
> -	select MTK_TIMER
> +	select TIMER_MEDIATEK_MT6577
> +	select TIMER_MEDIATEK_MT6765
>  	select MFD_SYSCON
>  	help
>  	  Support for Mediatek MT65xx & MT81xx SoCs
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index cdfd5fed457f..d4752375ab0b 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -161,7 +161,8 @@ config ARCH_MEDIATEK
>  	bool "MediaTek SoC Family"
>  	select ARM_GIC
>  	select PINCTRL
> -	select MTK_TIMER
> +	select TIMER_MEDIATEK_MT6577
> +	select TIMER_MEDIATEK_MT6765
>  	help
>  	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
>  	  & MT81xx ARMv8 SoCs
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d01e05..d697c799284e 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -438,13 +438,20 @@ config OXNAS_RPS_TIMER
>  config SYS_SUPPORTS_SH_CMT
>  	bool
>  
> -config MTK_TIMER
> -	bool "Mediatek timer driver" if COMPILE_TEST
> +config TIMER_MEDIATEK_MT6577
> +	bool "Mediatek mt6577 timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
>  	select TIMER_OF
>  	select CLKSRC_MMIO
>  	help
> -	  Support for Mediatek timer driver.
> +	  Enables clocksource and clockevent driver for Mediatek mt6577 timer.
> +
> +config TIMER_MEDIATEK_MT6765
> +	bool "Mediatek mt6765 timer driver" if COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select TIMER_OF
> +	help
> +	  Enables clockevent driver for Mediatek mt6765 timer.
>  
>  config SPRD_TIMER
>  	bool "Spreadtrum timer driver" if EXPERT
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index c17ee32a7151..b1f06ce114f9 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -49,7 +49,8 @@ obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
>  obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
>  obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
>  obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
> -obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
> +obj-$(CONFIG_TIMER_MEDIATEK_MT6577)		+= timer-mediatek-mt6577.o
> +obj-$(CONFIG_TIMER_MEDIATEK_MT6765)		+= timer-mediatek-mt6765.o
>  obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
>  obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
>  obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek-mt6577.c
> similarity index 69%
> rename from drivers/clocksource/timer-mediatek.c
> rename to drivers/clocksource/timer-mediatek-mt6577.c
> index 9318edcd8963..9e5241d1876d 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek-mt6577.c
> @@ -47,86 +47,8 @@
>  #define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
>  #define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
>  
> -/* system timer */
> -#define SYST_BASE               (0x40)
> -
> -#define SYST_CON                (SYST_BASE + 0x0)
> -#define SYST_VAL                (SYST_BASE + 0x4)
> -
> -#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
> -#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
> -
> -/*
> - * SYST_CON_EN: Clock enable. Shall be set to
> - *   - Start timer countdown.
> - *   - Allow timeout ticks being updated.
> - *   - Allow changing interrupt functions.
> - *
> - * SYST_CON_IRQ_EN: Set to allow interrupt.
> - *
> - * SYST_CON_IRQ_CLR: Set to clear interrupt.
> - */
> -#define SYST_CON_EN              BIT(0)
> -#define SYST_CON_IRQ_EN          BIT(1)
> -#define SYST_CON_IRQ_CLR         BIT(4)
> -
>  static void __iomem *gpt_sched_reg __read_mostly;
>  
> -static void mtk_syst_ack_irq(struct timer_of *to)
> -{
> -	/* Clear and disable interrupt */
> -	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> -}
> -
> -static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> -{
> -	struct clock_event_device *clkevt = dev_id;
> -	struct timer_of *to = to_timer_of(clkevt);
> -
> -	mtk_syst_ack_irq(to);
> -	clkevt->event_handler(clkevt);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int mtk_syst_clkevt_next_event(unsigned long ticks,
> -				      struct clock_event_device *clkevt)
> -{
> -	struct timer_of *to = to_timer_of(clkevt);
> -
> -	/* Enable clock to allow timeout tick update later */
> -	writel(SYST_CON_EN, SYST_CON_REG(to));
> -
> -	/*
> -	 * Write new timeout ticks. Timer shall start countdown
> -	 * after timeout ticks are updated.
> -	 */
> -	writel(ticks, SYST_VAL_REG(to));
> -
> -	/* Enable interrupt */
> -	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> -
> -	return 0;
> -}
> -
> -static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
> -{
> -	/* Disable timer */
> -	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
> -
> -	return 0;
> -}
> -
> -static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
> -{
> -	return mtk_syst_clkevt_shutdown(clkevt);
> -}
> -
> -static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
> -{
> -	return 0;
> -}
> -
>  static u64 notrace mtk_gpt_read_sched_clock(void)
>  {
>  	return readl_relaxed(gpt_sched_reg);
> @@ -255,27 +177,6 @@ static struct timer_of to = {
>  	},
>  };
>  
> -static int __init mtk_syst_init(struct device_node *node)
> -{
> -	int ret;
> -
> -	to.clkevt.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT;
> -	to.clkevt.set_state_shutdown = mtk_syst_clkevt_shutdown;
> -	to.clkevt.set_state_oneshot = mtk_syst_clkevt_oneshot;
> -	to.clkevt.tick_resume = mtk_syst_clkevt_resume;
> -	to.clkevt.set_next_event = mtk_syst_clkevt_next_event;
> -	to.of_irq.handler = mtk_syst_handler;
> -
> -	ret = timer_of_init(node, &to);
> -	if (ret)
> -		return ret;
> -
> -	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> -					TIMER_SYNC_TICKS, 0xffffffff);
> -
> -	return 0;
> -}
> -
>  static int __init mtk_gpt_init(struct device_node *node)
>  {
>  	int ret;
> @@ -310,4 +211,3 @@ static int __init mtk_gpt_init(struct device_node *node)
>  	return 0;
>  }
>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> -TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> diff --git a/drivers/clocksource/timer-mediatek-mt6765.c b/drivers/clocksource/timer-mediatek-mt6765.c
> new file mode 100644
> index 000000000000..b4f22f226feb
> --- /dev/null
> +++ b/drivers/clocksource/timer-mediatek-mt6765.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Mediatek SoCs General-Purpose Timer handling.
> + *
> + * Copyright (C) 2014 Matthias Brugger
> + *
> + * Matthias Brugger <matthias.bgg@gmail.com>
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/sched_clock.h>
> +#include <linux/slab.h>
> +#include "timer-of.h"
> +
> +#define TIMER_SYNC_TICKS        (3)
> +
> +/* system timer */
> +#define SYST_BASE               (0x40)
> +
> +#define SYST_CON                (SYST_BASE + 0x0)
> +#define SYST_VAL                (SYST_BASE + 0x4)
> +
> +#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
> +#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
> +
> +/*
> + * SYST_CON_EN: Clock enable. Shall be set to
> + *   - Start timer countdown.
> + *   - Allow timeout ticks being updated.
> + *   - Allow changing interrupt functions.
> + *
> + * SYST_CON_IRQ_EN: Set to allow interrupt.
> + *
> + * SYST_CON_IRQ_CLR: Set to clear interrupt.
> + */
> +#define SYST_CON_EN              BIT(0)
> +#define SYST_CON_IRQ_EN          BIT(1)
> +#define SYST_CON_IRQ_CLR         BIT(4)
> +
> +static void mtk_syst_ack_irq(struct timer_of *to)
> +{
> +	/* Clear and disable interrupt */
> +	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> +}
> +
> +static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *clkevt = dev_id;
> +	struct timer_of *to = to_timer_of(clkevt);
> +
> +	mtk_syst_ack_irq(to);
> +	clkevt->event_handler(clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_syst_clkevt_next_event(unsigned long ticks,
> +				      struct clock_event_device *clkevt)
> +{
> +	struct timer_of *to = to_timer_of(clkevt);
> +
> +	/* Enable clock to allow timeout tick update later */
> +	writel(SYST_CON_EN, SYST_CON_REG(to));
> +
> +	/*
> +	 * Write new timeout ticks. Timer shall start countdown
> +	 * after timeout ticks are updated.
> +	 */
> +	writel(ticks, SYST_VAL_REG(to));
> +
> +	/* Enable interrupt */
> +	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> +
> +	return 0;
> +}
> +
> +static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
> +{
> +	/* Disable timer */
> +	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
> +
> +	return 0;
> +}
> +
> +static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
> +{
> +	return mtk_syst_clkevt_shutdown(clkevt);
> +}
> +
> +static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
> +{
> +	return 0;
> +}
> +
> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +
> +	.clkevt = {
> +		.name = "mtk-clkevt",
> +		.rating = 300,
> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +	},
> +};
> +
> +static int __init mtk_syst_init(struct device_node *node)
> +{
> +	int ret;
> +
> +	to.clkevt.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT;
> +	to.clkevt.set_state_shutdown = mtk_syst_clkevt_shutdown;
> +	to.clkevt.set_state_oneshot = mtk_syst_clkevt_oneshot;
> +	to.clkevt.tick_resume = mtk_syst_clkevt_resume;
> +	to.clkevt.set_next_event = mtk_syst_clkevt_next_event;
> +	to.of_irq.handler = mtk_syst_handler;
> +
> +	ret = timer_of_init(node, &to);
> +	if (ret)
> +		return ret;
> +
> +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
