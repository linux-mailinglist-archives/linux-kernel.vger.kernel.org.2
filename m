Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266DB34A742
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZMaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:30:11 -0400
Received: from foss.arm.com ([217.140.110.172]:58536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhCZM3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:29:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA4F143D;
        Fri, 26 Mar 2021 05:29:31 -0700 (PDT)
Received: from [10.57.27.121] (unknown [10.57.27.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 382BB3F7D7;
        Fri, 26 Mar 2021 05:29:30 -0700 (PDT)
Subject: Re: Marvell: hw perfevents: unable to count PMU IRQs
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Robert Marko <robert.marko@sartura.hr>
References: <dc43adf0-daa3-b939-e0ed-5d0c8d01bd91@molgen.mpg.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ec735dae-5448-dcf4-9537-898977ebc8f4@arm.com>
Date:   Fri, 26 Mar 2021 12:29:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dc43adf0-daa3-b939-e0ed-5d0c8d01bd91@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-25 21:39, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Marvell Prestera switch, Linux 5.10.4 prints the error (with an 
> additional info level message) below.
> 
>      [    0.000000] Linux version 5.10.4 (robimarko@onlbuilder9) 
> (aarch64-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516, GNU ld (GNU 
> Binutils for Debian) 2.28) #1 SMP PREEMPT Thu Mar 11 10:22:09 UTC 2021
>      […]
>      [    1.996658] hw perfevents: unable to count PMU IRQs
>      [    2.001825] hw perfevents: /ap806/config-space@f0000000/pmu: 
> failed to register PMU devices!
> 
> ```
> # lscpu
> Architecture:          aarch64
> Byte Order:            Little Endian
> CPU(s):                4
> On-line CPU(s) list:   0-3
> Thread(s) per core:    1
> Core(s) per socket:    4
> Socket(s):             1
> NUMA node(s):          1
> Model:                 1
> BogoMIPS:              50.00
> L1d cache:             32K
> L1i cache:             48K
> L2 cache:              512K
> NUMA node0 CPU(s):     0-3
> Flags:                 fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> # cat /proc/cpuinfo
> processor       : 0
> BogoMIPS        : 50.00
> Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> CPU implementer : 0x41
> CPU architecture: 8
> CPU variant     : 0x0
> CPU part        : 0xd08
> CPU revision    : 1
> […]
> ```
> 
> Please find the output of `dmesg` attached.
> 
> How can the IRQs be counted?

Well, that message simply means we got an error back from 
platform_irq_count(), which in turn implies that 
platform_get_irq_optional() failed. Most likely we got -EPROBE_DEFER 
back from of_irq_get() because the relevant interrupt controller wasn't 
ready by that point - especially since that's the o9nly error code that 
platform_irq_cont() will actually pass. It looks like that should end up 
getting propagated all the way out appropriately, so the PMU driver 
should defer and be able to probe OK once the mvebu-pic driver has 
turned up to provide its IRQ. We could of course do a better job of not 
shouting error messages for a non-fatal condition....

As for why the PMU doesn't eventually show up, my best guess would be 
either an issue with the mvebu-pic driver itself probing, and/or perhaps 
something in fw_devlink going awry - inspecting sysfs should shed a bit 
more light on those.

Robin.
