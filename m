Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189F5363D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhDSIdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhDSIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:33:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FECDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:33:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so5467440wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwGEofnYqrSMdgze3a6W2GQYeIBqGGaYbDUA6vt3vKo=;
        b=sY39fkO9gzV2OOZ3mQUmHEXWL25JK42CMP9UfCDOvL6iTg2W/IxtRe2ADaWrJhlUBU
         ybBynFYKWFJoBYx3os8jOydAU4Jlrxr6NYOpPi2HaLPz6tHjRiCPqxquo8bjg2P7V9/N
         pXmHq/qqrGJSFt0yLGXoZqW6monxkaRnUHj2tOWAQSX4zrrXTneihvMCie0XQiayY1Vu
         j3uONKpZi7Coz5IQS1CPnoK4R3yG1G6oRXZITnPbJf/GrEIw+XPeu3j4l5t7iGuQBHWC
         2EbMC5aNNVCnxiEbxSBL6VLpdW4fgHhgPPHNmCcmxGaQh2fazwiHY56De4D4xF5JqqVo
         Sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwGEofnYqrSMdgze3a6W2GQYeIBqGGaYbDUA6vt3vKo=;
        b=hH9kT9er2Hte6kTGtJIHx698zKIOew8wE3kBjkI0YMOaca58dkdPtdQlNYnEPAiR3d
         Nu1MPokkLcFr6aIZgh1x/8slfEigENnL3tKDPkW5IGQjxvqhDAvkd4FoYzpeLldVG11u
         nQUNVX9hQaWbmrcboTQOXs/hSd7Oy+zaYOgphD+87NY13YYzwv4qKsmNqwA/YANKrcSk
         PmIWsEkm9zjez3fTkhhdn1JeseiocMilmRsHIfb7N3sa3MAyzxNhsA9d4xobQAZuB1kT
         /091blt8lz3JNkIh8kFCfFxuicQ6e6WkdF42rSJgVcZOo3wjaQhaF5RxGSCHB/8QJUw6
         oO/g==
X-Gm-Message-State: AOAM533IGOgSZ1x2c/c2kpR5b+lypvTXQ8EXy6y8PR8UKSznb4sTWSQT
        muly3+GV9fj/Xvu2orQzIBccQKSixS541gq5
X-Google-Smtp-Source: ABdhPJytCUAriVHySrcb+bsrQYHcDr2ZuO/waZciNVUCjaiN9QDanVUjNYbH38fH0WjMuejRKOXPKA==
X-Received: by 2002:a1c:60c2:: with SMTP id u185mr20068734wmb.157.1618821183863;
        Mon, 19 Apr 2021 01:33:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:796f:a096:3809:6fc5? ([2a01:e34:ed2f:f020:796f:a096:3809:6fc5])
        by smtp.googlemail.com with ESMTPSA id f23sm18932470wmf.37.2021.04.19.01.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:33:03 -0700 (PDT)
Subject: Re: [PATCH v3] drivers/clocksource/mediatek: Ack and disable
 interrupts on suspend
To:     Evan Benn <evanbenn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210412132200.v3.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3e4803f8-7c38-6f71-fc89-2fa763e3395e@linaro.org>
Date:   Mon, 19 Apr 2021 10:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412132200.v3.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2021 05:22, Evan Benn wrote:
> Interrupts are disabled during suspend before this driver disables its
> timers. ARM trusted firmware will abort suspend if the timer irq is
> pending, so ack and disable the timer interrupt during suspend.
> 
> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
> 
> Changes in v3:
> Move the ACK from the shutdown to the suspend function.
> 
> Changes in v2:
> Remove the patch that splits the drivers into 2 files.
> 
>  drivers/clocksource/timer-mediatek.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edcd8963..1ae8fee639bf 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -241,6 +241,27 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
>  	       timer_of_base(to) + GPT_IRQ_EN_REG);
>  }
>  
> +static void mtk_gpt_resume(struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +
> +	mtk_gpt_enable_irq(to, TIMER_CLK_EVT);
> +}
> +
> +static void mtk_gpt_suspend(struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +
> +	/* Disable all interrupts */
> +	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
> +
> +	/* This is called with interrupts disabled,

Please fix the comment style:

	/*
	 * This is called with interrupts disabled
	 * so ...
	 * ...
	 */

Other than than that I'll be happy to pick it.

> +	 * so we need to ack any interrupt that is pending
> +	 * Or for example ATF will prevent a suspend from completing.
> +	 */
> +	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
> +}
> +
>  static struct timer_of to = {
>  	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
>  
> @@ -286,6 +307,8 @@ static int __init mtk_gpt_init(struct device_node *node)
>  	to.clkevt.set_state_oneshot = mtk_gpt_clkevt_shutdown;
>  	to.clkevt.tick_resume = mtk_gpt_clkevt_shutdown;
>  	to.clkevt.set_next_event = mtk_gpt_clkevt_next_event;
> +	to.clkevt.suspend = mtk_gpt_suspend;
> +	to.clkevt.resume = mtk_gpt_resume;
>  	to.of_irq.handler = mtk_gpt_interrupt;
>  
>  	ret = timer_of_init(node, &to);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
