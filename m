Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA68368FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhDWJyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:54:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:54:11 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619171611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EUkRnGmsqhgrQyxHLAHubhiYlG1lft/auMlvDrVMo0=;
        b=SWl30oiEoreeJO/d+ubxk+HpPskgtn2goqqUYabC614+fscJyKpptKik3cwl4Up8fp3t9P
        ksLq1d4Qzn3bql9vrG7JLO606HR5nZ4yeV10Ysm+aIReNlNbTsR8nSjgfbF7RiEdxAq32S
        nhi2sZSU3du7wsYiRTdO6aRladMzZBdmIGl0RqY9pL/0PblFLuaI9nS5UASS/jCb7x/DQF
        grRmZvaEY6eExaX0K8Lhhhca7/SOJQXasrjTgcXExF2lQHcByRm0EPMBXdK/GnZ9t5dwcu
        rgCuc5jbWrH5Lr9+MX5BC10uNIOjZTU5NJvjoWsDhvfNNwoofQSwd9u67syNaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619171611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EUkRnGmsqhgrQyxHLAHubhiYlG1lft/auMlvDrVMo0=;
        b=pJ9C+xxyFa5R1JF5w9VH0Tus/w+W4S4gpIjTvWKWQJyB/6uDGgBmq0X9hawLjcCi7ruoQZ
        vDYk0nPMCM6NgUBw==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 086/190] Revert "x86/PCI: Fix PCI IRQ routing table memory leak"
In-Reply-To: <20210422050919.GA2913711@bjorn-Precision-5520>
References: <20210422050919.GA2913711@bjorn-Precision-5520>
Date:   Fri, 23 Apr 2021 11:53:31 +0200
Message-ID: <87a6ppwcmc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22 2021 at 00:09, Bjorn Helgaas wrote:
> On Wed, Apr 21, 2021 at 02:59:21PM +0200, Greg Kroah-Hartman wrote:
> I would prefer that you not apply this revert.
>
> Prior to ea094d53580f ("x86/PCI: Fix PCI IRQ routing table memory
> leak"), we had essentially this:
>
>   pcibios_irq_init()
>     pirq_table = pcibios_get_irq_routing_table();  # kmallocs
>     if (pirq_table) {
>       if (io_apic_assign_pci_irqs)
> 	pirq_table = NULL;
>     }
>
> So if we called pcibios_get_irq_routing_table(), we kmalloced some
> space and then (if io_apic_assign_pci_irqs) threw away the pointer,
> which leaks the pointer as the commit log says.
>
> After ea094d53580f, we have:
>
>   pcibios_irq_init()
>     rtable = NULL;
>     pirq_table = pcibios_get_irq_routing_table();  # kmallocs
>     rtable = pirq_table;
>     if (pirq_table) {
>       if (io_apic_assign_pci_irqs) {
>         kfree(rtable);
> 	pirq_table = NULL;
>       }
>     }
>
> which seems right to me.

It is correct.

Though looking at it again, the question is why this invokes
pcibios_get_irq_routing_table() at all if io_apic_assign_pci_irqs is
true?

Thanks,

        tglx
