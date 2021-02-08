Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73713130DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhBHL3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:29:43 -0500
Received: from marcansoft.com ([212.63.210.85]:49824 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232535AbhBHLOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:14:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4CE7A41EE3;
        Mon,  8 Feb 2021 11:13:25 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-16-marcan@marcan.st> <87eehqlxlr.wl-maz@kernel.org>
 <CAK8P3a25eFFrMG-9QknFZ6Ckc3-gkiLK=jQdnyTMgn-z4X0RHQ@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 15/18] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <0a1a9d20-ad4e-27e8-0356-567d519653cc@marcan.st>
Date:   Mon, 8 Feb 2021 20:13:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a25eFFrMG-9QknFZ6Ckc3-gkiLK=jQdnyTMgn-z4X0RHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 19.29, Arnd Bergmann wrote:
> On Mon, Feb 8, 2021 at 10:25 AM Marc Zyngier <maz@kernel.org> wrote:
>> On Thu, 04 Feb 2021 20:39:48 +0000, Hector Martin <marcan@marcan.st> wrote:
> 
>>> +{
>>> +     return readl(ic->base + reg);
>>
>> Please consider using the _relaxed accessors, as I don't think any of
>> these interacts with memory (apart from IPIs, of course).
> 
> MSI interrupts require serializing with DMA, so at the minimum I think there
> needs to be something that ensures that DMA from device into memory
> has completed before delivering the completion interrupt to a driver. This
> may already be implied when the AIC is entered, but this is hard to know
> without actual hardware specs.
> 

I don't think this can be implied in any case, because if IRQ A fires 
and then the CPU speculates its way through AIC into the IRQ B handler, 
which reads DMA'd memory, then IRQ B fires and it has higher priority 
and *that* is what ends up getting returned from the event register 
first, the execution will commit with an ordering violation.

I'm pretty sure we need *some* level of explicit synchronization between 
reading the event register and actually delivering IRQs downstream. 
Using _relaxed might be okay, but we'd still need something where the 
isb() currently is in aic_handle_irq (though I admit I don't have a 
perfect picture of the memory ordering subtleties involved here yet).

Incidentally, just from the races and problems I've run into with 
trivial tests in m1n1, these CPUs seem to be *very* eager to speculate 
and I suspect they will help uncover race conditions in Linux...

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
