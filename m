Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E4363DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhDSIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhDSIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:45:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B087C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:44:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so33085481wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTUicYn2ZPNcfjliuOy4sPKfu2P1IFAME69ExWOzQFU=;
        b=zGvLLCwASa/kobu7RHCgl7wBZKFpMqcCJRufnfk8f/6fp+9P+8qO3UhXpogbyPseUW
         g7TwuxKH/3p2IEcg09BPdxnuoY8dGLRIUL0yl2bOjXU1+o3/luQo3sb5mUQhAeLOOq2m
         puZCuv2XIqz+6E6LUTa4+chF5F0jKIzUkQbJWwPG2uUEfb3WuflcJ/vn8MeBxN6PI9n/
         EbP6tBM3ssjvyB7P9sRLvZQADteggAc7XsflDg9tGYnHmtpSJtHBI3cSJCa95JTPYwwp
         69Dr+3EbA1synqCnZSvr7F8oiQGhUmZ8n+6C9HIC0MY4yDk2Xt/5AIKUjV7B6a0dIRXX
         dOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTUicYn2ZPNcfjliuOy4sPKfu2P1IFAME69ExWOzQFU=;
        b=PG7V7xGZrKr+s/9ORjXvfnqQ+r7oQatiC82erIbSJ1+O6gd9sXBzS/rKQbi9N8crEH
         8GMgoV4kMCoxWF2SSgV3+XFKFrKSAWhGYU3pbH2cbqrRRzOq9W18aDx8P7gIkhHvQ+cM
         XOTcQR3Gs0IHnstnkBe3BnXRwqR73OlGUPwCK6b7d51TujRbfCN0K9Oc3O7oAWOyctJM
         EpdcISEDGK65xYah3gDO+bSDYjj14zhnf4TX8V1LVzfu4RTcg3YjOajL1iyhzkatlTfb
         bjZMa1EGb3bcofx4kEC9braDu91525hQcOvjiN2fEJIooI/oyBHUqACVqF3GStd4sFdO
         ryPA==
X-Gm-Message-State: AOAM530lDw7zmWMqywGUys20UmYCNusY9NVbyfscXEI5dvJZGJpXjaUI
        IXSK8AJ5eZC+ZUc7DJD9M0g5MA==
X-Google-Smtp-Source: ABdhPJx5D7lFlk4bYnmVatrdb6C9VwXdtuKYfFdSCdhFeMhpry0kZfvdOfbAYm1RBT/wBm2fQGzjdA==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr13075902wrw.322.1618821876115;
        Mon, 19 Apr 2021 01:44:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:796f:a096:3809:6fc5? ([2a01:e34:ed2f:f020:796f:a096:3809:6fc5])
        by smtp.googlemail.com with ESMTPSA id h5sm3245015wmq.23.2021.04.19.01.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:44:35 -0700 (PDT)
Subject: Re: [PATCH] [v4, 1/1] clocksource/drivers/timer-mediatek: optimize
 systimer irq clear flow on shutdown
To:     Fengquan Chen <Fengquan.Chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     dehui.sun@mediatek.com, Evan Benn <evanbenn@chromium.org>
References: <1617960162-1988-1-git-send-email-Fengquan.Chen@mediatek.com>
 <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4d3b342c-a14f-f4ac-6860-9f6a88a24501@linaro.org>
Date:   Mon, 19 Apr 2021 10:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 11:22, Fengquan Chen wrote:
> mtk_syst_clkevt_shutdown is called after irq disabled in suspend flow,
> clear any pending systimer irq when shutdown to avoid suspend aborted
> due to timer irq pending
> 
> Also as for systimer in mediatek socs, there must be firstly enable
> timer before clear systimer irq
> 
> Fixes: e3af677607d9("clocksource/drivers/timer-mediatek: Add support for system timer")
> Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
> 
> ---
>  drivers/clocksource/timer-mediatek.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edc..6461fd3 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -60,9 +60,9 @@
>   * SYST_CON_EN: Clock enable. Shall be set to
>   *   - Start timer countdown.
>   *   - Allow timeout ticks being updated.
> - *   - Allow changing interrupt functions.
> + *   - Allow changing interrupt status,like clear irq pending.
>   *
> - * SYST_CON_IRQ_EN: Set to allow interrupt.
> + * SYST_CON_IRQ_EN: Set to enable interrupt.
>   *
>   * SYST_CON_IRQ_CLR: Set to clear interrupt.
>   */
> @@ -75,6 +75,7 @@
>  static void mtk_syst_ack_irq(struct timer_of *to)
>  {
>  	/* Clear and disable interrupt */
> +	writel(SYST_CON_EN, SYST_CON_REG(to));
>  	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
>  }

IIRC, there is a hardware issue here. If it is the case, please describe
it and refer to an errata if any.

Also Evan Benn commented your code and asked a couple of questions [1],
please answer before reposting a new version.

Comments ignored == patch ignored

> @@ -111,6 +112,9 @@ static int mtk_syst_clkevt_next_event(unsigned long ticks,
>  
>  static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
>  {
> +	/* Clear any irq */
> +	mtk_syst_ack_irq(to_timer_of(clkevt));
> +
>  	/* Disable timer */
>  	writel(0, SYST_CON_REG(to_timer_of(clkevt)));

Please check out the patch sent by Evan Benn [2], if you agree, ack it.

Thanks

  -- Daniel

[1] https://patchwork.kernel.org/comment/24059277/
[2]
https://lore.kernel.org/linux-arm-kernel/20210412132200.v3.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
