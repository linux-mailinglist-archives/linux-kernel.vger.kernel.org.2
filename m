Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F394383D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhJWNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 09:39:19 -0400
Received: from foss.arm.com ([217.140.110.172]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhJWNjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 09:39:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ED6AD6E;
        Sat, 23 Oct 2021 06:36:58 -0700 (PDT)
Received: from [10.57.28.205] (unknown [10.57.28.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F693F70D;
        Sat, 23 Oct 2021 06:36:52 -0700 (PDT)
Subject: Re: [PATCH 09/15] irq: arm: perform irqentry in entry code
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
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
 <cada0034-7427-f4ae-0f88-7bbb1be2b1a5@arm.com> <87ilxnc21r.wl-maz@kernel.org>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <c43c8c0e-946e-93c6-00d0-f015f948833a@arm.com>
Date:   Sat, 23 Oct 2021 14:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ilxnc21r.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 2:18 PM, Marc Zyngier wrote:
> On Sat, 23 Oct 2021 13:06:25 +0100,
> Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> On 10/22/21 7:43 PM, Marc Zyngier wrote:
>>> On Fri, 22 Oct 2021 18:58:54 +0100,
>>> Mark Rutland <mark.rutland@arm.com> wrote:
>>>>
>>>> On Fri, Oct 22, 2021 at 05:34:20PM +0100, Vladimir Murzin wrote:
> 
> [...]
> 
>>>>> As for TODO, is [1] look something you have been thinking of? IIUC,
>>>>> the show stopper is that hwirq is being passed from exception entry
>>>>> which retrieved via xPSR (IPSR to be precise). OTOH hwirq also available
>>>>> via Interrupt Controller Status Register (ICSR) thus can be used in
>>>>> driver itself... I gave [1] a go and it runs fine, yet I admit I might
>>>>> be missing something...
>>>>
>>>> I hadn't thought about it in much detail, but that looks good!
>>>>
>>>> I was wondering if we needed something like a
>>>> handle_arch_vectored_irq(), but if we can rely on the ICSR that seems
>>>> simpler overall. I'm not at all familiar with M-class, so I'm not sure
>>>> if there are pitfalls in this area.
>>>
>>> Why can't we just use IPSR instead from the C code? It has the
>>> potential of being of lower latency then a MMIO read (though I have no
>>> idea whether it makes a material difference on M-class) and from what
>>> I can see in the arch spec, they are strictly equivalent.
>>
>> Hmmm, less arch specific asm(s) in driver code, no?
> 
> Well, it isn't like this driver is going to be useful on anything
> else, is it?
> 

Well, with some work to unwire it from arch/arm it can be COMPILE_TEST :)

> If there is no overhead in reading from MMIO compared to the
> architected register, then I agree that ICSR is the way to
> go. Is there any chance you could measure it on a HW platform? Or
> maybe in emulation?

My MPS{2,3} boards left in office and I'm on holiday next week... OTOH, I
have no strong opinion on ICSR vs IPSR, I just wanted to check how much
work it'd be to close TODO per my (quite limited) understanding :)

Cheers
Vladimir


> 
> Thanks,
> 
> 	M.
> 

