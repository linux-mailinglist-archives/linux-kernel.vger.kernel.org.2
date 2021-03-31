Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8B350449
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhCaQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCaQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:14:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258B3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:14:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1413442wmy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FEkVrZqt9llz3eUvcA5IAVVGMII33dzbxhY4iNq3068=;
        b=j0WLvSRPcTPYEL8heIvhdTC6aDFbW5eJWuM6KsK3Y1fn9CK821uh7vWFE4WRYpU/v/
         x0ZWUZO27gWc0BbhwmEzcg4hcAJgLJ0FrXomvyioBIkgXCd64Q/c6rX4GWE++s+Lr5+R
         HlqDRSBaW8kY5/jiA5j06I6ukqZfZeE3toOOujKBT9b18zb7SEMHOgeWlkP6BtRzyTr0
         bCpSO9DR5kzqL3s71RF9Rf/mCePcjEYGCl3FXf3lrP9MRuaHkzHwtK6QRt0vjmwdVeyt
         ANfx8Hl9zWIH6hPP+TxjVL2IygEqd7SP7R33/1UdReDbxV1W3VSeON5dHRociht40rb/
         YwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FEkVrZqt9llz3eUvcA5IAVVGMII33dzbxhY4iNq3068=;
        b=GtTFA5sKmvM6ViI4m/v9LoRWQjiDoN8ovizopYyMfWtFMYRDGjCicbh9F9qsSLZmm0
         MzSBRTOERR+BAvq+JFP/Q+4n/bmpeDSv4K762+wofvU7WhdtaQVp88CQXmizZ0XjnPCq
         3QEl4yfHr29jOZ3o8oZYHw1AV0U7juWTftXLraK7wz39VoNyHA/30wXaTfpwhqEuirJr
         pjkpVETXhnBIpo89hdcTeV0tsG4bG6Haf1bTgJ/1JGLyNxw9qhVaoB4pR4G7Ug7vYmK6
         O7dfPGCpQnBCzUGZXrWhFBrSSyraIGnhOLKGp2aZaEHv4iwb0MlbYFk1E2YhXroFX887
         02Ow==
X-Gm-Message-State: AOAM531jLAsGSqZrOEomRv+b5UBgBveqhcuXs+jH9P0RsJOFT1U9x56+
        IRWh+JlvBRiGdsiiRO/QvNZGQkuLgnSV9w==
X-Google-Smtp-Source: ABdhPJxCnVbthjr9Z3rmJ4AGMx228nVyU2PQFrpLplNuJ8SF3zq7eG9TAOStRa2SpmYRUvk0gz5tRQ==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr3816530wmq.71.1617207278688;
        Wed, 31 Mar 2021 09:14:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id u8sm5596487wrr.42.2021.03.31.09.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:14:38 -0700 (PDT)
Subject: Re: [PATCH] clocksource/arm_arch_timer: add __ro_after_init and
 __init
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210330140444.4fb2a7cb@xhacker.debian>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e6179eb3-2439-ea34-db2e-307db048e6e6@linaro.org>
Date:   Wed, 31 Mar 2021 18:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330140444.4fb2a7cb@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 30/03/2021 08:04, Jisheng Zhang wrote:
> Some functions are not needed after booting, so mark them as __init
> to move them to the .init section.
> 
> Some global variables are never modified after init, so can be
> __ro_after_init.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Mar[ck] ? Any comment on this change ?



> ---
>  drivers/clocksource/arm_arch_timer.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index d0177824c518..1b885964fb34 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -51,7 +51,7 @@
>  
>  static unsigned arch_timers_present __initdata;
>  
> -static void __iomem *arch_counter_base;
> +static void __iomem *arch_counter_base __ro_after_init;
>  
>  struct arch_timer {
>  	void __iomem *base;
> @@ -60,15 +60,16 @@ struct arch_timer {
>  
>  #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
>  
> -static u32 arch_timer_rate;
> -static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
> +static u32 arch_timer_rate __ro_after_init;
> +u32 arch_timer_rate1 __ro_after_init;
> +static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
>  
>  static struct clock_event_device __percpu *arch_timer_evt;
>  
> -static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
> -static bool arch_timer_c3stop;
> -static bool arch_timer_mem_use_virtual;
> -static bool arch_counter_suspend_stop;
> +static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init = ARCH_TIMER_VIRT_PPI;
> +static bool arch_timer_c3stop __ro_after_init;
> +static bool arch_timer_mem_use_virtual __ro_after_init;
> +static bool arch_counter_suspend_stop __ro_after_init;
>  #ifdef CONFIG_GENERIC_GETTIMEOFDAY
>  static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
>  #else
> @@ -76,7 +77,7 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
>  #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
>  
>  static cpumask_t evtstrm_available = CPU_MASK_NONE;
> -static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
> +static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
>  
>  static int __init early_evtstrm_cfg(char *buf)
>  {
> @@ -176,7 +177,7 @@ static notrace u64 arch_counter_get_cntvct(void)
>   * to exist on arm64. arm doesn't use this before DT is probed so even
>   * if we don't have the cp15 accessors we won't have a problem.
>   */
> -u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
> +u64 (*arch_timer_read_counter)(void) __ro_after_init = arch_counter_get_cntvct;
>  EXPORT_SYMBOL_GPL(arch_timer_read_counter);
>  
>  static u64 arch_counter_read(struct clocksource *cs)
> @@ -925,7 +926,7 @@ static int validate_timer_rate(void)
>   * rate was probed first, and don't verify that others match. If the first node
>   * probed has a clock-frequency property, this overrides the HW register.
>   */
> -static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
> +static void __init arch_timer_of_configure_rate(u32 rate, struct device_node *np)
>  {
>  	/* Who has more than one independent system counter? */
>  	if (arch_timer_rate)
> @@ -939,7 +940,7 @@ static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
>  		pr_warn("frequency not available\n");
>  }
>  
> -static void arch_timer_banner(unsigned type)
> +static void __init arch_timer_banner(unsigned type)
>  {
>  	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>  		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
