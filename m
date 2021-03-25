Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D600348B31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhCYIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCYIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:07:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:07:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so1278941wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ItQynOcBUmT2daeIzClvyDiamObFHlZM+po2il7NGQQ=;
        b=F337VBkF8MjeFbPXLUVv+p3BwEBcTQLsElNSRK3KIpxKKh2MJlV3PGaDi23VQ6SLSV
         Qt/0FoW4k/1BwSq4St1ORrlUVQSJEdeq97DRDhd3Wf8avGT+6LGLpAgygewSVN8n91Pq
         2kQXMHHL7zMF+cv/uIDik/ZZ5YPmAgkiMAEkGU+nvJ5Sb+RxxcQ7Z/phG2VRYWUuGXYP
         RAAGee5Reidw+pYMPTP2iUJ1DV1re7jNG45joK19qTHl1IAEocDq5JTr4QZCQuZh3rXg
         6vZeTRIauG1uXhJaZuJbW7yWTngb8nfvn44H2sh9D2lqlnBKo9ela2OmJg81zpY0IQtj
         jmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ItQynOcBUmT2daeIzClvyDiamObFHlZM+po2il7NGQQ=;
        b=aw+G/kJQi6SvZ6eZn1BYF7/QtKPzJcsIUQpUcvDYLAhVAQa8zO9HwS7TRoR0kjHs0y
         4rTSy4JplMOeZnP1eB6n/LgeXDntkmhmrxm6a+DqlEVhgpnQ+BNTgq/oomxAOnGmtcgm
         BHX00LvcoGTy1PcsUFm0YFkQIuqdSi8SxxI/AYe0cE5I1ZeI4I0AUOVmIIawnenY1Xz9
         YMjUH9esfP9VPyi+Tf3DAFI18A0+P+4mkcpS363Kms9xZTBrSW/pSar4HJWNAcVReIyj
         9A0bEBBeMGfjzcaig6CoQjB49PdFM+GA64xWd479w5PFr943tpOkk4WOrpxPsmLET5FG
         aU0w==
X-Gm-Message-State: AOAM530M3/L4J/9LW0ucouYxWsvX0223hnmos7L0C9+/FhNZ6GnCmKIC
        RXzqg3vnrFhBE9byM2LlUDHoiw==
X-Google-Smtp-Source: ABdhPJwdML/QxUKT+3QoJa23+qO8dGO9h3U44vmooj0OX1w4rKyzII4PY323pukeymEh6+h1e9kMDQ==
X-Received: by 2002:adf:de92:: with SMTP id w18mr7373772wrl.217.1616659670443;
        Thu, 25 Mar 2021 01:07:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8c1:335e:f39f:249c? ([2a01:e34:ed2f:f020:d8c1:335e:f39f:249c])
        by smtp.googlemail.com with ESMTPSA id 81sm5431289wmc.11.2021.03.25.01.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 01:07:49 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/clocksource/mediatek: Ack and disable
 interrupts on shutdown
To:     Evan Benn <evanbenn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
References: <20210325123446.v2.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <049946ac-5263-21ee-9651-7295f0bcf387@linaro.org>
Date:   Thu, 25 Mar 2021 09:07:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210325123446.v2.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2021 02:35, Evan Benn wrote:
> set_state_shutdown is called during system suspend after interrupts have
> been disabled. If the timer has fired in the meantime, there will be
> a pending IRQ. So we ack that now and disable the timer. Without this
> ARM trusted firmware will abort the suspend due to the pending
> interrupt.
> 
> Now always disable the IRQ in state transitions, and re-enable in
> set_periodic and next_event.

Why not put add the suspend/resume callbacks and put there the specific
code and let the irq untouched in the normal flow ?

> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
> 
> Changes in v2:
> Remove the patch that splits the drivers into 2 files.
> 
>  drivers/clocksource/timer-mediatek.c | 49 +++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edcd8963..fba2f9494d90 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -132,13 +132,33 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
>  	return readl_relaxed(gpt_sched_reg);
>  }
>  
> +static void mtk_gpt_disable_ack_interrupts(struct timer_of *to, u8 timer)
> +{
> +	u32 val;
> +
> +	/* Disable interrupts */
> +	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> +	writel(val & ~GPT_IRQ_ENABLE(timer), timer_of_base(to) +
> +	       GPT_IRQ_EN_REG);
> +
> +	/* Ack interrupts */
> +	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
> +}
> +
>  static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
>  {
>  	u32 val;
>  
> +	/* Disable timer */
>  	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
>  	writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
>  	       GPT_CTRL_REG(timer));
> +
> +	/* This may be called with interrupts disabled,
> +	 * so we need to ack any interrupt that is pending
> +	 * Or for example ATF will prevent a suspend from completing.
> +	 */
> +	mtk_gpt_disable_ack_interrupts(to, timer);
>  }
>  
>  static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
> @@ -152,8 +172,10 @@ static void mtk_gpt_clkevt_time_start(struct timer_of *to,
>  {
>  	u32 val;
>  
> -	/* Acknowledge interrupt */
> -	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
> +	/* Enable interrupts */
> +	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> +	writel(val | GPT_IRQ_ENABLE(timer),
> +	       timer_of_base(to) + GPT_IRQ_EN_REG);
>  
>  	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
>  
> @@ -226,21 +248,6 @@ __init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
>  	       timer_of_base(to) + GPT_CTRL_REG(timer));
>  }
>  
> -static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
> -{
> -	u32 val;
> -
> -	/* Disable all interrupts */
> -	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
> -
> -	/* Acknowledge all spurious pending interrupts */
> -	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
> -
> -	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> -	writel(val | GPT_IRQ_ENABLE(timer),
> -	       timer_of_base(to) + GPT_IRQ_EN_REG);
> -}
> -
>  static struct timer_of to = {
>  	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
>  
> @@ -292,6 +299,12 @@ static int __init mtk_gpt_init(struct device_node *node)
>  	if (ret)
>  		return ret;
>  
> +	/* In case the firmware left the interrupts enabled
> +	 * disable and ack those now
> +	 */
> +	mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_SRC);
> +	mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_EVT);
> +
>  	/* Configure clock source */
>  	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
>  	clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
> @@ -305,8 +318,6 @@ static int __init mtk_gpt_init(struct device_node *node)
>  	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
>  					TIMER_SYNC_TICKS, 0xffffffff);
>  
> -	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
> -
>  	return 0;
>  }
>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
