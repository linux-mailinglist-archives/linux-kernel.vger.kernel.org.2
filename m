Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96A2352B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhDBOPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhDBOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:15:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A11C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:15:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so4857437wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kn+08Y+8syWf3BIq6nvfSf388zuVhuWp9zeWcCzqy7w=;
        b=zpTd3fJufNsoqgF2kpXYRIbztSDSQ/kpIYpXrVGVQ70wAagZC31L4d2qpg5n6/NucQ
         Gyqq9C6ruWvgPH5PNiEkM/cGx/rMpq/Ukz1aE51QrGunbgruXZQZmVC2eCopkU8o0i2t
         oJhIArEfoEvLq4lrlWib/n6NRN9p+2+rLKKwlOPG+1KuYSGqvDdU4oPoJLah1lWrjpCQ
         DeDp6/ZKAid5mMpyeI/LK69MOHMcQe62uWjItVaRan0N0fpIOnOxSDL5Az5ymvf2mqgL
         7yWtWluw38tybfVmiWpy88tRwvBnMXAlUePNsZtxo57oJzZs2RvVlRX/C33mXb7T1mu8
         tlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kn+08Y+8syWf3BIq6nvfSf388zuVhuWp9zeWcCzqy7w=;
        b=reUyuIXnvcm2q7Qzd3AmdFYJsXm53BwzzgXkqCpROGsCrrL5EeqpsriLVooiefZxzH
         YXWD31mooPVLn+xbw6Ovy77nrAhDUDuTcucibXLF7oi30n7j3+qr4pq6uHV7CPmsitPX
         mvQkf7C0IyXN6h9GgO9aTHPfPiisXCwiLlcZYrnH7vRHopvL1Yz90vyvKrO7gfXyjjY6
         yE/mKPvq9QwLJHB79ljRngIBHYB45AENoeT1yteAozmp12sxgQ7c1SrGK/BtGpX+oOQy
         /FPaN2D23BR3+ljKA308ah9tApN2Qwf36Zf/G4j57FL8PMr/94mHdlQPVO/UwACNyo9j
         jxpw==
X-Gm-Message-State: AOAM532CTbUGLIt8dDs+jDbLgO6HqgIoy8epFCzwm6U3k36rtoq8HBV0
        PkYwQUP3/Tr/EQAOg7sgVqvTyg==
X-Google-Smtp-Source: ABdhPJxWqQxR/dWDzV5EyWMmMbTFOQb0j4pNLaNkp2JHQqv8+a27RS5SvuxtwmFPRbBy88+4e/Hlow==
X-Received: by 2002:adf:e108:: with SMTP id t8mr15236750wrz.371.1617372915954;
        Fri, 02 Apr 2021 07:15:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:34f1:44bb:31bf:7aaf? ([2a01:e34:ed2f:f020:34f1:44bb:31bf:7aaf])
        by smtp.googlemail.com with ESMTPSA id c2sm14874504wrt.47.2021.04.02.07.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 07:15:15 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/clocksource/mediatek: Ack and disable
 interrupts on shutdown
To:     Evan Benn <evanbenn@gmail.com>
Cc:     Evan Benn <evanbenn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
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
 <049946ac-5263-21ee-9651-7295f0bcf387@linaro.org>
 <CAP8nV8rv6bKARZ31fVqcjVgMe+5UyVG8UAyNsm1hDCP2BbRSgw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <67eed9a2-2b97-be1b-3290-948da662ea65@linaro.org>
Date:   Fri, 2 Apr 2021 16:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAP8nV8rv6bKARZ31fVqcjVgMe+5UyVG8UAyNsm1hDCP2BbRSgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Evan,

On 27/03/2021 02:31, Evan Benn wrote:
> Hi Daniel,
> 
> That is a good point, and I did try that at first and it works fine. I
> uploaded this version because the suspend/resume callbacks were
> undocumented and mostly not used by other clocksource drivers. I
> thought a smaller diff might be preferable.
> I also thought it would be better to shut off the interrupt as soon as
> it is not needed, avoiding any other potential bugs, instead of just
> fixing the one we know about with suspend. I'm not sure how the other
> driver / timer disable flows are intended to work for example
> (shutdown, detach, etc).
> 
> That said I am happy to upload that version if people think it is better.

IMO, it is not in the normal flow to disable/enable the interrupts.

Does this timer belong to an always-on power domain ?



> https://elixir.bootlin.com/linux/latest/source/include/linux/clockchips.h#L120
> 
> 
> On Thu, 25 Mar 2021 at 19:10, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 25/03/2021 02:35, Evan Benn wrote:
>>> set_state_shutdown is called during system suspend after interrupts have
>>> been disabled. If the timer has fired in the meantime, there will be
>>> a pending IRQ. So we ack that now and disable the timer. Without this
>>> ARM trusted firmware will abort the suspend due to the pending
>>> interrupt.


>>> Now always disable the IRQ in state transitions, and re-enable in
>>> set_periodic and next_event.
>>
>> Why not put add the suspend/resume callbacks and put there the specific
>> code and let the irq untouched in the normal flow ?
>>
>>> Signed-off-by: Evan Benn <evanbenn@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> Remove the patch that splits the drivers into 2 files.
>>>
>>>  drivers/clocksource/timer-mediatek.c | 49 +++++++++++++++++-----------
>>>  1 file changed, 30 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
>>> index 9318edcd8963..fba2f9494d90 100644
>>> --- a/drivers/clocksource/timer-mediatek.c
>>> +++ b/drivers/clocksource/timer-mediatek.c
>>> @@ -132,13 +132,33 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
>>>       return readl_relaxed(gpt_sched_reg);
>>>  }
>>>
>>> +static void mtk_gpt_disable_ack_interrupts(struct timer_of *to, u8 timer)
>>> +{
>>> +     u32 val;
>>> +
>>> +     /* Disable interrupts */
>>> +     val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
>>> +     writel(val & ~GPT_IRQ_ENABLE(timer), timer_of_base(to) +
>>> +            GPT_IRQ_EN_REG);
>>> +
>>> +     /* Ack interrupts */
>>> +     writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
>>> +}
>>> +
>>>  static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
>>>  {
>>>       u32 val;
>>>
>>> +     /* Disable timer */
>>>       val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
>>>       writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
>>>              GPT_CTRL_REG(timer));
>>> +
>>> +     /* This may be called with interrupts disabled,
>>> +      * so we need to ack any interrupt that is pending
>>> +      * Or for example ATF will prevent a suspend from completing.
>>> +      */
>>> +     mtk_gpt_disable_ack_interrupts(to, timer);
>>>  }
>>>
>>>  static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
>>> @@ -152,8 +172,10 @@ static void mtk_gpt_clkevt_time_start(struct timer_of *to,
>>>  {
>>>       u32 val;
>>>
>>> -     /* Acknowledge interrupt */
>>> -     writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
>>> +     /* Enable interrupts */
>>> +     val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
>>> +     writel(val | GPT_IRQ_ENABLE(timer),
>>> +            timer_of_base(to) + GPT_IRQ_EN_REG);
>>>
>>>       val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
>>>
>>> @@ -226,21 +248,6 @@ __init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
>>>              timer_of_base(to) + GPT_CTRL_REG(timer));
>>>  }
>>>
>>> -static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
>>> -{
>>> -     u32 val;
>>> -
>>> -     /* Disable all interrupts */
>>> -     writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
>>> -
>>> -     /* Acknowledge all spurious pending interrupts */
>>> -     writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
>>> -
>>> -     val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
>>> -     writel(val | GPT_IRQ_ENABLE(timer),
>>> -            timer_of_base(to) + GPT_IRQ_EN_REG);
>>> -}
>>> -
>>>  static struct timer_of to = {
>>>       .flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
>>>
>>> @@ -292,6 +299,12 @@ static int __init mtk_gpt_init(struct device_node *node)
>>>       if (ret)
>>>               return ret;
>>>
>>> +     /* In case the firmware left the interrupts enabled
>>> +      * disable and ack those now
>>> +      */
>>> +     mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_SRC);
>>> +     mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_EVT);
>>> +
>>>       /* Configure clock source */
>>>       mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
>>>       clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
>>> @@ -305,8 +318,6 @@ static int __init mtk_gpt_init(struct device_node *node)
>>>       clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
>>>                                       TIMER_SYNC_TICKS, 0xffffffff);
>>>
>>> -     mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
>>> -
>>>       return 0;
>>>  }
>>>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
