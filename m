Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A243FA504
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhH1Ki1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:38:27 -0400
Received: from 10.mo52.mail-out.ovh.net ([87.98.187.244]:58726 "EHLO
        10.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhH1KiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:38:22 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Aug 2021 06:38:22 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.136])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 4C731291AE1;
        Sat, 28 Aug 2021 10:08:33 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Sat, 28 Aug
 2021 10:08:33 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-98R00272d487fd-ef86-4ee1-a566-b4163bc8ecab,
                    6CE952B1E590FC391734534FA2C2FCCDA042449D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 83.199.102.86
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
 <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
Date:   Sat, 28 Aug 2021 10:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 72be6025-9f93-43a8-9883-949d2b562fd1
X-Ovh-Tracer-Id: 17222046451889048425
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddugedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvth
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8/28/21 5:37 AM, Guenter Roeck wrote:
> On 8/27/21 3:01 PM, Linus Walleij wrote:
>> On Sat, Aug 21, 2021 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:
>>
>>>> Make sure we check that the right interrupt occurred before
>>>> calling the event handler for timer 1. Report spurious IRQs
>>>> as IRQ_NONE.
>>>>
>>>> Cc: Cédric Le Goater <clg@kaod.org>
>>>> Cc: Joel Stanley <joel@jms.id.au>
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> This patch results in boot stalls with several qemu aspeed emulations
>>> (quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
>>> romulus-bmc, g220a-bmc). Reverting this patch together with
>>> "clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
>>> fixes the problem. Bisect log is attached.
>>
>> Has it been tested on real hardware?

It breaks the AST2500 EVB.
 
>>
>> We are reading register 0x34 TIMER_INTR_STATE for this.
>> So this should reflect the state of raw interrupts from the timers.
>>
>> I looked in qemu/hw/timer/aspeed_timer.c
>> and the aspeed_timer_read() looks dubious.
>> It rather looks like this falls down to returning whatever
>> was written to this register and not reflect which IRQ
>> was fired at all.
>>
> 
> Actually, no. Turns out the qemu code is just a bit difficult to understand.
> The code in question is:
> 
>     default:
>         value = ASPEED_TIMER_GET_CLASS(s)->read(s, offset);
>         break;
> 
> For ast2500-evb, that translates to a call to aspeed_2500_timer_read().
> Here is a trace example (after adding some more tracing):
> 
> aspeed_2500_timer_read From 0x34: 0x0
> aspeed_timer_read From 0x34: of size 4: 0x0
> 
> Problem is that - at least in qemu - only the 2600 uses register 0x34
> for the interrupt status. On the 2500, 0x34 is the ctrl2 register.
> 
> Indeed, the patch works fine on, for example, ast2600-evb.
> It only fails on ast2400 and ast2500 boards.

The QEMU modelling is doing a good job ! I agree that the timer model 
is not the most obvious one to read. 

> I don't have the manuals, so I can't say what the correct behavior is,
> but at least there is some evidence that TIMER_INTR_STATE may not exist
> on ast2400 and ast2500 SOCs. 

On Aspeed SoCs AST2400 and AST2500, the TMC[34] register is a
"control register #2" whereas on the AST2600 it is an "interrupt
status register" with bits [0-7] holding the timers status.

I would say that the patch simply should handle the "is_aspeed" case.  

> From drivers/clocksource/timer-fttmr010.c:

yes. See commit 86fe57fc47b1 ("clocksource/drivers/fttmr010: Fix 
invalid interrupt register access")

AFAICT, the ast2600 does not use a fttmr010 clocksource. Something to 
clarify may be Joel ? 

Thanks,

C.

> 
> /*
>  * Interrupt status/mask register definitions for fttmr010/gemini/moxart
>  * timers.
>  * The registers don't exist and they are not needed on aspeed timers
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  * because:
>  *   - aspeed timer overflow interrupt is controlled by bits in Control
>  *     Register (TMC30).
>  *   - aspeed timers always generate interrupt when either one of the
>  *     Match registers equals to Status register.
>  */
> 
> Guenter

