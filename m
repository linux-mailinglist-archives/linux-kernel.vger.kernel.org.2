Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6F310603
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBEHm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:42:56 -0500
Received: from marcansoft.com ([212.63.210.85]:39276 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBEHmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:42:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AFC7742598;
        Fri,  5 Feb 2021 07:41:41 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-16-marcan@marcan.st>
 <CAK8P3a1zbLM0s_GwkJ0AJQ8cocS-zcsWWKhOB7B99OtRYyDE7g@mail.gmail.com>
 <8adb1047-2b1a-9cfc-c906-3c369a8e494f@marcan.st>
 <CAK8P3a14vsLkCujd_XBAOAjL2h878gxkaoKPpaxL4jddZZcc-A@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 15/18] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <06620a31-ed81-5e3e-c81a-047d986769fd@marcan.st>
Date:   Fri, 5 Feb 2021 16:41:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a14vsLkCujd_XBAOAjL2h878gxkaoKPpaxL4jddZZcc-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 08.04, Arnd Bergmann wrote:
> On Thu, Feb 4, 2021 at 11:06 PM Hector Martin 'marcan' <marcan@marcan.st> wrote:
>> If we split it up again, one of the two still needs to be the root,
>> decide whether what fired is an IRQ or FIQ, and dispatch accordingly. Or
>> we could have three nodes and have one root handler dispatch to IRQ and
>> FIQ nodes, but that sounds like overkill... (?)
> 
> Maybe I'm misreading the low-level entry code, but my impression
> was that the fiq and irq exception vectors could just be pointed to
> two different root drivers from the code in kernel_ventry

Certainly, but we'd have to introduce a fiq handler global and duplicate 
the handler code; this is what was done in the previous submission, but 
I seem to recall someone (Marc?) mentioned it would be cleaner to just 
merge them into the single IRQ path and discriminate in the irqchip, 
which is what I did here.

I can certainly go with either solution; I don't have a strong 
preference here.

Advantages of split path:

* More orthogonal

Advantages of merged path:

* Minimizes common vector changes needed for a single platform
* Keeps FIQ/IRQ code common, so FIQs are less likely to be accidentally 
broken by people not testing on Apple platforms.

Unclear:

* Performance. Split path runs less code, merged path has lower icache 
pressure.

>> Are you proposing just having different drivers/nodes in the same file,
>> or implementing these as separate drivers in separate files?
> 
> I was thinking of separate driver files.

That's what I previously had then :)

If this is the way to go I can certainly go back to that.

> I looked at other architectures, and found that at least powerpc
> and sparc64 have a really minimal timer tick, with their timer_interrupt()
> function getting called directly from the exception vector, and
> doing a minimum of accounting (irq_enter(), statistics, ...) manually.
> 
> It's a different question if we want to do that, or if there should always
> be an irqchip for consistency.

I think the issue here is that those platforms presumably have *one* 
timer hard wired to a specific exception vector (e.g. on PowerPC that's 
the decrementer). So, that setup is shared by all implementations in 
that platform.

But on ARM64, the architectural timer is supposed to go through an 
irqchip (GIC in normal platforms), it's just that here it ended up 
hard-wired to FIQ - though not alone, since fast IPIs are also there, so 
we can't treat it as a strict "timer vector" either.

So even if we could do this for Apple SoCs, it would be a non-standard 
setup, since every other ARM64 platform puts the timer behind an 
irqchip. Therefore, I think it makes sense to always go through an 
irqchip, rather than introduce a bypass for these SoCs.

Also worth noting that we have at least two functional hardware timers 
here (not sure if there are more, we run with HCR_EL2.E2H=1 in m1n1 
which maps the EL2 timer to be the EL1 timer; I'm not yet sure if 
setting that to 0 will expose extra HV timers or not) wired to the same 
FIQ. I confirmed that both the virtual and physical timers function 
independently in m1n1.

I did confirm there are no secure timers, which is expected given that 
there is no EL3 on these chips.

> Benchmarking would at least help understand why there are two.

Well, they call them "Fast IPIs" so *presumably* they are faster, but 
we'll see :)

> I don't think we have to pay too much attention to preparing the
> code design for it, we can always change it when needed. However,
> anything that impacts the DT binding here would have to be designed
> to not get in the way of adding it later.

I think this shouldn't pose much of a problem, since IPIs aren't exposed 
in the DT anyway. As long as we decide how we're handling IRQs vs FIQs 
(one or two nodes/drivers), then either of them could take 
responsibility for handling IPIs depending on the platform. We should 
probably just add a "fast-ipi" property to both nodes on platforms that 
support that, so that the drivers can make the decision based on it. Or 
perhaps that should be done with different compatibles?

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
