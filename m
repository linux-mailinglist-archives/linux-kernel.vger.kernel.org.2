Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2EE3FA364
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhH1Diw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 23:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhH1Dit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 23:38:49 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23345C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 20:38:00 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso306994otu.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 20:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aBUEc/1o/dcHZcAssq2pXxkW7IBn2OYtFLHrnrOZLG4=;
        b=j6stF9Q1YdfQY0NyG8smT7KeZDlWzF6ukz00qwTgUeGzJEHpznRK4srIph/dGTKZhJ
         57RPHvmxyptd0mQaV3hVRaYZMfjVL2v/8xsTcP0GyDwcB92GI5HzNvwJ/OpeX7NmyvqV
         bUUUYmMxBL+xeFssNejGlfHXJM6F47YRVAPY2sS7ya8d0wC72oSJYb98n/Ialm9eGzGD
         EDNiUTsWbNJmReMr11xVWojTZnHKkDyaoJvZrTDNNX8fgIpNUbTTuBNyV2ok0n0RalV3
         0uCwqbLpiACpxvqPBOOvjXmdJqa14EvWtOFZiDvVZmagavA3/ccp2Cu6QD2IKmJGtEI4
         OYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBUEc/1o/dcHZcAssq2pXxkW7IBn2OYtFLHrnrOZLG4=;
        b=d8lL5sDAc4WjvhEasB4y88+5b+I7S5p6g7uizWiOd35Gv3h1ImQVPpts4BQyRv06M/
         xn2wnxJ0o7o9KQ7VQRXj0+RhZ51LalFP2UAU7FakakXqt1VCpP2o8CTEdxYco12bnYeC
         gbnm3JjkhUUDqthwWwBDOJFEtJ0dBi19zk33ClMDezB3vUtlqXxusebPAvTp5TEShLqi
         bz/kB7U4DE6bv7LHL9LOeRCjKTEWUjfcoDByez6VNoWMHd9dWTq4rD0Zk4ez7ihbHbkx
         dc495a+2WT63ojekHccFEO3dL11x1/VyqwwFZtrGx+GbNvBg9KSYXkqZxxYcB3PIblnZ
         XaDw==
X-Gm-Message-State: AOAM53149AgGetmyKrL4RcpTGf7j+PLF3hGUmyschXVVnNwsys2gLTuP
        gV1MIlysr5dYqkpaLp+GsRU=
X-Google-Smtp-Source: ABdhPJykkL9iV6CMo1bU3OAbS4bWpJtrjLIurhUSsJfO5aIbuWtVgZYbsVQHZCeE5R19Z18GRCEFoA==
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr4078808oti.139.1630121879446;
        Fri, 27 Aug 2021 20:37:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm1562459ooq.41.2021.08.27.20.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 20:37:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
Message-ID: <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
Date:   Fri, 27 Aug 2021 20:37:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 3:01 PM, Linus Walleij wrote:
> On Sat, Aug 21, 2021 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:
> 
>>> Make sure we check that the right interrupt occurred before
>>> calling the event handler for timer 1. Report spurious IRQs
>>> as IRQ_NONE.
>>>
>>> Cc: Cédric Le Goater <clg@kaod.org>
>>> Cc: Joel Stanley <joel@jms.id.au>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> This patch results in boot stalls with several qemu aspeed emulations
>> (quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
>> romulus-bmc, g220a-bmc). Reverting this patch together with
>> "clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
>> fixes the problem. Bisect log is attached.
> 
> Has it been tested on real hardware?
> 
> We are reading register 0x34 TIMER_INTR_STATE for this.
> So this should reflect the state of raw interrupts from the timers.
> 
> I looked in qemu/hw/timer/aspeed_timer.c
> and the aspeed_timer_read() looks dubious.
> It rather looks like this falls down to returning whatever
> was written to this register and not reflect which IRQ
> was fired at all.
> 

Actually, no. Turns out the qemu code is just a bit difficult to understand.
The code in question is:

     default:
         value = ASPEED_TIMER_GET_CLASS(s)->read(s, offset);
         break;

For ast2500-evb, that translates to a call to aspeed_2500_timer_read().
Here is a trace example (after adding some more tracing):

aspeed_2500_timer_read From 0x34: 0x0
aspeed_timer_read From 0x34: of size 4: 0x0

Problem is that - at least in qemu - only the 2600 uses register 0x34
for the interrupt status. On the 2500, 0x34 is the ctrl2 register.

Indeed, the patch works fine on, for example, ast2600-evb.
It only fails on ast2400 and ast2500 boards.

I don't have the manuals, so I can't say what the correct behavior is,
but at least there is some evidence that TIMER_INTR_STATE may not exist
on ast2400 and ast2500 SOCs. From drivers/clocksource/timer-fttmr010.c:

/*
  * Interrupt status/mask register definitions for fttmr010/gemini/moxart
  * timers.
  * The registers don't exist and they are not needed on aspeed timers
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  * because:
  *   - aspeed timer overflow interrupt is controlled by bits in Control
  *     Register (TMC30).
  *   - aspeed timers always generate interrupt when either one of the
  *     Match registers equals to Status register.
  */

Guenter
