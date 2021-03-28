Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF19134BE53
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhC1Spy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 14:45:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhC1Sph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 14:45:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616957134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJZptEJKwMIdJPhu5KiINrZRVqsQG4a7pwYku6LvI9c=;
        b=12sBNARDp38OveHuPZQpsMyUPOWpc8PkKYFsHUixNkhDCHLY01IkqrB/14C4F/u9cN0Qq1
        3b9/P6Y8TATpXRJQ63zWFJG1l4GYnUmfj6ixmmN+tiAJrZniGTChK6R8IzgwGae2PTtNge
        42esRM2X8XPrpGFT2jIWt4kTYrVfBAVIXn9PhgXjo6ctHK/QK6kbBBb/phZZCAWJrCHoZa
        6qatUZdJIc//q2qxwtjcflBA8ScpZnPViLRxFis+KDnDbTgNlVmSjUG5UVomNKKb4YYbQs
        RaRDqruIuGx/gBWlXC6SqfmNVxQjClITMPN6IUUkV1QVwbBXEGmxF61OU1S45w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616957134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJZptEJKwMIdJPhu5KiINrZRVqsQG4a7pwYku6LvI9c=;
        b=Mak/wYRJv+k31x+kPp0W64MZLuFIQvs+EDkMZsJuZeJj3ahLmR0Z6eHZ22l/rqV3c+m6lB
        rMBg5OcJPut9txAA==
To:     Chris Friesen <chris.friesen@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [IRQ] IRQ affinity not working properly?
In-Reply-To: <a0d5551e-761b-1571-b8e1-5586ec4d9f3b@windriver.com>
References: <a0d5551e-761b-1571-b8e1-5586ec4d9f3b@windriver.com>
Date:   Sun, 28 Mar 2021 20:45:34 +0200
Message-ID: <87blb3ce29.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29 2021 at 13:17, Chris Friesen wrote:
> I have a CentOS 7 linux system with 48 logical CPUs and a number of

Kernel version?

> Intel NICs running the i40e driver.  It was booted with 
> irqaffinity=0-1,24-25 in the kernel boot args, resulting in 
> /proc/irq/default_smp_affinity showing "0000,03000003".   CPUs 2-11 are 
> set as "isolated" in the kernel boot args.  The irqbalance daemon is not 
> running.
>
> The problem I'm seeing is that /proc/interrupts shows iavf interrupts 
> (associated with physical devices running the i40e driver) on other CPUs 
> than the expected affinity.  For example, here are some iavf interrupts 
> on CPU 4 where I would not expect to see any interrupts given that "cat 
> /proc/irq/<NUM>/smp_affinity_list" reports "0-1,24-25" for all these 
> interrupts.  (Sorry for the line wrapping.)
>
> cat /proc/interrupts | grep -e CPU -e 941: -e 942: -e 943: -e 944: -e 
> 945: -e 961: -e 962: -e 963: -e 964: -e 965:
>
>               CPU0       CPU1       CPU2       CPU3 CPU4       CPU5
> 941:          0          0          0          0 28490          0 
> IR-PCI-MSI-edge iavf-0000:b5:03.6:mbx
> 942:          0          0          0          0 333832         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-0
> 943:          0          0          0          0 300842         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-1
> 944:          0          0          0          0 333845         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-2
> 945:          0          0          0          0 333822         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-3
> 961:          0          0          0          0 28492         0 
> IR-PCI-MSI-edge iavf-0000:b5:02.7:mbx
> 962:          0          0          0          0 435608         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-0
> 963:          0          0          0          0 394832         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-1
> 964:          0          0          0          0 398414         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-2
> 965:          0          0          0          0 192847         0 
> IR-PCI-MSI-edge      iavf-net1-TxRx-3
>
> There were IRQs coming in on the "iavf-0000:b5:02.7:mbx" interrupt at 
> roughly 1 per second without any traffic, while the interrupt rate on 
> the "iavf-net1-TxRx-<X>" seemed to be related to traffic.
>
> Is this expected?  It seems like the IRQ subsystem is not respecting the 
> configured SMP affinity for the interrupt in question.  I've also seen 
> the same behaviour with igb interrupts.

No it's not expected. Do you see the same behaviour with a recent
mainline kernel, i.e. 5.10 or 5.11?

Thanks,

        tglx
