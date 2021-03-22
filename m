Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51F343D86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCVKL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCVKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:10:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:10:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so8895504wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pl/1x/dUibJwhZPPXqj++9a+GjOkKTPY4TtNftw5ACE=;
        b=fzQrW0MY/qPU0DyGvJ8PqjweP6lFpaYeQnb2kYMfUyF2dHpGZpsxKb1iPJ+KBz48bs
         nuHPcsBGejT/eGKmy7MV8vRuU4Q3KW/JqXzGARh0J9/OkihRjshIXhadGscapTMqjxx1
         kNXI6rhv6yo9JtEsXhyiZbi5ciQdliP02vux6EU9Yhgy/wB+XAODcPS85U2S6Jz0YY1V
         YfaAzE8MaA16j+Jmjf1ODzFJ5FZcQ8NyvgoPjZJ9kioZSMXtDHQJExfKCz/QxhFGXcdG
         vcqdLg8bByYPX1VjFKwiqnDubcGvWPbNuEHxp33CPyI5XtQW3C6U+lLY/6W8Q4e6I2Y4
         dFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pl/1x/dUibJwhZPPXqj++9a+GjOkKTPY4TtNftw5ACE=;
        b=b4AiC4MtURSVgoUbX1YLKU4DCfFNDxKkrHXGiPC7yHMzFPJNdu755RjxnrKrb77UT+
         H9rROah1Ihs1nWzdZmg2mMryNqf2/yRiuf5OdblKKDfyJmFhNfjOlJRfHV8/bu9sz/Y2
         Fhr2WBXnqGl/FRvxtQXqB3CIHlQirr+s5h0Dbh1QjtP4n7OoSKOFLqDtBd9DosiDuePr
         NRdpdLvC5FtjJB1gbADS1oREv0H+b6u+G2WQ31zy8m1xVVoi5/5FnQ+sLupcn17PchhU
         xqNKjt3XbNPnwQW9V8bvc4K6okhPeFogIcBlyqv+VM69PyU+z8EOqQpzb4lZXo6B0hP/
         lQ4A==
X-Gm-Message-State: AOAM530OCnsPBZbmjaLqMPG2q+bBvSSHAjCLF77DzAIFYDIZ+ywRR4AW
        bSeWIKnEnXHL9MJV8kb85N3Zrw==
X-Google-Smtp-Source: ABdhPJw6hR/D3ntozds8E1xl58azewk89v8W83EuKkKgkv9xG2vtmsbj2U4laVkYvMRLrzNd2gHtVA==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr15036765wmq.19.1616407852724;
        Mon, 22 Mar 2021 03:10:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8b:d5f9:2138:169c? ([2a01:e34:ed2f:f020:d8b:d5f9:2138:169c])
        by smtp.googlemail.com with ESMTPSA id i11sm19455755wro.53.2021.03.22.03.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 03:10:52 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: optimize systimer irq
 clear flow on Mediatek Socs
To:     Fengquan Chen <Fengquan.Chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     dehui.sun@mediatek.com
References: <1614670085-26229-1-git-send-email-Fengquan.Chen@mediatek.com>
 <1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c91e9afc-8b04-f35b-bcf9-1fcf9a6f425f@linaro.org>
Date:   Mon, 22 Mar 2021 11:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 08:28, Fengquan Chen wrote:
> 1)ensure systimer is enabled before clear and disable interrupt, which only
> for systimer in Mediatek Socs.
>
> 2)clear any pending timer-irq when shutdown to keep suspend flow clean,
> when use systimer as tick-broadcast timer
> 
> Change-Id: Ia3eda83324af2fdaf5cbb3569a9bf020a11f8009

Remove the above.

Add a Fixes tag.

> Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
> ---
>  drivers/clocksource/timer-mediatek.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edc..9f1f095dc 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -75,6 +75,7 @@
>  static void mtk_syst_ack_irq(struct timer_of *to)
>  {
>  	/* Clear and disable interrupt */
> +	writel(SYST_CON_EN, SYST_CON_REG(to));

	SYST_CON_EN is set below, why do you have to do it before?

Is that a hw bug ?

It is confusing what the description of the SYST_CON_EN says:

/*
 * SYST_CON_EN: Clock enable. Shall be set to
 *   - Start timer countdown.
 *   - Allow timeout ticks being updated.
 *   - Allow changing interrupt functions.

What means "interrupt functions" ?

Does writing writel(SYST_CON_EN, SYST_CON_REG(to)) before
SYST_CON_IRQ_CLR allows to clear the interrupt flag?

Can you explain how the timer works regarding this part?

It sounds to me a bit strange.

 *
 * SYST_CON_IRQ_EN: Set to allow interrupt.
 *
 * SYST_CON_IRQ_CLR: Set to clear interrupt.
 */


>  	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
>  }
>  
> @@ -111,6 +112,9 @@ static int mtk_syst_clkevt_next_event(unsigned long ticks,
>  
>  static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
>  {
> +	/* Clear any irq */
> +	mtk_syst_ack_irq(to_timer_of(clkevt));
> +
>  	/* Disable timer */
>  	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
