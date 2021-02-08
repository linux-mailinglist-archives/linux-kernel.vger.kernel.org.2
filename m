Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5D3135CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhBHO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhBHOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:54:44 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086BC061788;
        Mon,  8 Feb 2021 06:53:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AB4A941F47;
        Mon,  8 Feb 2021 14:53:54 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <a2825482e2f68c2f8cad7cb564414759@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <8d660b1f-cb80-d16c-14e4-2a1c7f5229d1@marcan.st>
Date:   Mon, 8 Feb 2021 23:53:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a2825482e2f68c2f8cad7cb564414759@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 21.27, Marc Zyngier wrote:
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupt-parent = <&aic>;
>> +		interrupts = <AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>,
>> +				<AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>,
>> +				<AIC_FIQ 1 IRQ_TYPE_LEVEL_HIGH>,
>> +				<AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>;
> 
> This unfortunately doesn't match the binding, which doesn't cater
> for systems without a secure physical timer, nor allows the description
> of the EL2 virtual timer.
> 
> You should also have *different* interrupts for EL1 and EL2 timers,
> although this is all a lie...

Well, we do - now that I confirmed all 4 timers work properly, the AIC 
driver should provide all 4. And ideally I find those EL1 timer mask 
bits and implement them in the aic driver too (for only the virt timers 
that have them and of course need them).

I just found the code in arm_arch_timer that forwards all this stuff to 
the kvm code, so it all makes sense now; if I can wire that up properly, 
heck, KVM might even just work here.

> 
> Looking at the only similar case, XGene lies about the secure timer
> (it doesn't have any), and of course doesn't have an EL2 virtual
> timer (ARMv8.0 only).
> 
> A sensible course of action could be to update the binding to at least:
> 
> - tell the kernel that there is no secure physical timer (and that
>     the interrupt should be ignored)
> - introduce a 5th possible interrupt for the EL2 virtual timer.

Sounds like I should be introducing interrupt-names support into this 
driver and using that, so we can just not specify IRQs that don't exist, 
instead of the hack with dummies. Falling back to indexes of course, to 
keep DT compat. i.e.

const char *names = {"phys-secure", "phys", "virt", "hyp-phys", "hyp-virt"};

bool has_names = of_property_read_bool(..., "interrupt-names");

for (each irq)
	if (has_names) foo = of_irq_get_byname(..., names[i])
	else foo = of_irq_get(..., i)

That said, is there a use case for the EL2 virtual timer? The driver 
always uses the EL2 physical timer with VHE right now. I guess it's 
worth describing it in the binding and dts, even if the driver never 
selects it...?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
