Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1760A4383A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhJWMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 08:08:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhJWMIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 08:08:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B5CD6E;
        Sat, 23 Oct 2021 05:06:32 -0700 (PDT)
Received: from [10.57.28.205] (unknown [10.57.28.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 266E83F70D;
        Sat, 23 Oct 2021 05:06:27 -0700 (PDT)
Subject: Re: [PATCH 09/15] irq: arm: perform irqentry in entry code
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-10-mark.rutland@arm.com>
 <0efc4465-12b5-a568-0228-c744ec0509a3@arm.com>
 <20211022153602.GE86184@C02TD0UTHF1T.local>
 <1dc39ac9-1a05-cf8d-2aef-633903a6338d@arm.com>
 <20211022175854.GK86184@C02TD0UTHF1T.local> <87tuh8uchn.wl-maz@kernel.org>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <cada0034-7427-f4ae-0f88-7bbb1be2b1a5@arm.com>
Date:   Sat, 23 Oct 2021 13:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87tuh8uchn.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 7:43 PM, Marc Zyngier wrote:
> On Fri, 22 Oct 2021 18:58:54 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Fri, Oct 22, 2021 at 05:34:20PM +0100, Vladimir Murzin wrote:
>>> On 10/22/21 4:36 PM, Mark Rutland wrote:
>>>> On Fri, Oct 22, 2021 at 04:18:18PM +0100, Vladimir Murzin wrote:
>>>>> Hi Mark,
>>>>>
>>>>> On 10/21/21 7:02 PM, Mark Rutland wrote:
>>>>>> +/*
>>>>>> + * TODO: restructure the ARMv7M entry logic so that this entry logic can live
>>>>>> + * in arch code.
>>>>>> + */
>>>>>> +asmlinkage void __exception_irq_entry
>>>>>> +static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>>>>>
>>>>> I'm seeing build time failure...
>>>>>
>>>>> drivers/irqchip/irq-nvic.c:50:8: error: two or more data types in declaration specifiers
>>>>>  static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>>>>>         ^~~~
>>>>> drivers/irqchip/irq-nvic.c:50:13: warning: 'nvic_handle_irq' defined but not used [-Wunused-function]
>>>>>  static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
>>>>>
>>>>> I've fixed that locally and planing to give it a go...
>>>>
>>>> Ah, whoops. I've removed the extraneous `static void` from
>>>> nvic_handle_irq() and build tested that as part of stm32_defconfig.
>>>>
>>>> The updated version is in my irq/handle-domain-irq branch at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
>>>>
>>>
>>> $ cat /proc/interrupts
>>>            CPU0       
>>>  16:         24  nvic_irq   4 Edge      mps2-clkevt
>>>  17:          0  nvic_irq  32 Edge      mps2-uart-rx
>>>  18:          6  nvic_irq  33 Edge      mps2-uart-tx
>>>  19:          0  nvic_irq  47 Edge      mps2-uart-overrun
>>> Err:          0
>>>
>>> So if it helps feel free to add my 
>>>
>>> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
>>
>> Thanks!
>>
>> I've folded that in and uppdated the branch.
>>
>>> As for TODO, is [1] look something you have been thinking of? IIUC,
>>> the show stopper is that hwirq is being passed from exception entry
>>> which retrieved via xPSR (IPSR to be precise). OTOH hwirq also available
>>> via Interrupt Controller Status Register (ICSR) thus can be used in
>>> driver itself... I gave [1] a go and it runs fine, yet I admit I might
>>> be missing something...
>>
>> I hadn't thought about it in much detail, but that looks good!
>>
>> I was wondering if we needed something like a
>> handle_arch_vectored_irq(), but if we can rely on the ICSR that seems
>> simpler overall. I'm not at all familiar with M-class, so I'm not sure
>> if there are pitfalls in this area.
> 
> Why can't we just use IPSR instead from the C code? It has the
> potential of being of lower latency then a MMIO read (though I have no
> idea whether it makes a material difference on M-class) and from what
> I can see in the arch spec, they are strictly equivalent.

Hmmm, less arch specific asm(s) in driver code, no?

Cheers
Vladimir

> 
> Thanks,
> 
> 	M.
> 

