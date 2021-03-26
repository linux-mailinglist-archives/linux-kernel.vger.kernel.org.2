Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCB34A9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhCZOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:17 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53575 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229779AbhCZOew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:34:52 -0400
Received: from [192.168.0.2] (ip5f5ae918.dynamic.kabel-deutschland.de [95.90.233.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C805206479D4;
        Fri, 26 Mar 2021 15:34:43 +0100 (CET)
Subject: Re: Marvell: hw perfevents: unable to count PMU IRQs
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Robert Marko <robert.marko@sartura.hr>
References: <dc43adf0-daa3-b939-e0ed-5d0c8d01bd91@molgen.mpg.de>
 <ec735dae-5448-dcf4-9537-898977ebc8f4@arm.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <6ca582cc-56ab-f481-d9e0-4e2b0b0d833e@molgen.mpg.de>
Date:   Fri, 26 Mar 2021 15:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <ec735dae-5448-dcf4-9537-898977ebc8f4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robin,


Thank you for the quick reply.

Am 26.03.21 um 13:29 schrieb Robin Murphy:
> On 2021-03-25 21:39, Paul Menzel wrote:

>> On the Marvell Prestera switch, Linux 5.10.4 prints the error (with an 
>> additional info level message) below.
>>
>>      [    0.000000] Linux version 5.10.4 (robimarko@onlbuilder9) (aarch64-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516, GNU ld (GNU Binutils for Debian) 2.28) #1 SMP PREEMPT Thu Mar 11 10:22:09 UTC 2021
>>      […]
>>      [    1.996658] hw perfevents: unable to count PMU IRQs
>>      [    2.001825] hw perfevents: /ap806/config-space@f0000000/pmu: failed to register PMU devices!

[…]

>> Please find the output of `dmesg` attached.
>>
>> How can the IRQs be counted?
> 
> Well, that message simply means we got an error back from 
> platform_irq_count(), which in turn implies that 
> platform_get_irq_optional() failed. Most likely we got -EPROBE_DEFER 
> back from of_irq_get() because the relevant interrupt controller wasn't 
> ready by that point - especially since that's the o9nly error code that 
> platform_irq_cont() will actually pass. It looks like that should end up 
> getting propagated all the way out appropriately, so the PMU driver 
> should defer and be able to probe OK once the mvebu-pic driver has 
> turned up to provide its IRQ. We could of course do a better job of not 
> shouting error messages for a non-fatal condition....

Yes, that would be great.

> As for why the PMU doesn't eventually show up, my best guess would be 
> either an issue with the mvebu-pic driver itself probing, and/or perhaps 
> something in fw_devlink going awry - inspecting sysfs should shed a bit 
> more light on those.

I just noticed, I missed

     [    3.298670] hw perfevents: enabled with armv8_cortex_a72 PMU 
driver, 7 counters available

a good second. So the interrupt controller indeed seems to take longer 
to be ready.

I guess, I’d need to boot with `initcall_debug` to find out the callers 
of the PMU functions.


Kind regards,

Paul
