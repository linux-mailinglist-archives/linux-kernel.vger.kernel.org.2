Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282D73DE886
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhHCIfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:35:32 -0400
Received: from foss.arm.com ([217.140.110.172]:44728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234423AbhHCIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:35:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 376B1D6E;
        Tue,  3 Aug 2021 01:35:20 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785AE3F70D;
        Tue,  3 Aug 2021 01:35:18 -0700 (PDT)
Subject: Re: [EXTERNAL] Re: [RFC 1/1] irqchip/gic-v3-its: Add irq domain and
 chip for Direct LPI without ITS
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <MW4PR21MB2002BA20FA4A8DAA1C27F4C6C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87a6mt2jke.wl-maz@kernel.org>
 <MW4PR21MB2002E51429F7E13B61A34FFEC0E89@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87tuka24kj.wl-maz@kernel.org>
 <MW4PR21MB20027EAC23E8053210364E2BC0F09@MW4PR21MB2002.namprd21.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b2dea108-9166-dc9d-abd0-d22491f78568@arm.com>
Date:   Tue, 3 Aug 2021 09:35:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <MW4PR21MB20027EAC23E8053210364E2BC0F09@MW4PR21MB2002.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-03 03:11, Sunil Muthuswamy wrote:
>   On Saturday, July 31, 2021 2:52 AM,
>   Marc Zyngier <maz@kernel.org> wrote:
>>
>> [...]
>>
>>>> I also want to understand *how* you are going to plumb this into both
>>>> ACPI and DT, given that neither understand how to link a PCI endpoint
>>>> to a set of RDs.
>>>>
>>>> 	M.
>>>
>>> One way to do this for NUMA-aware systems would be to use the NUMA
>>> related information that is available with PCI endpoints or root complex, to
>>> pick a Redistributor/CPU that is in the NUMA node, as specified by the PCI
>>> endpoint/root complex. In DT PCI devices can specify this using
>>> 'numa-node-id' and in ACPI using the '_PXM (Proximity)'. For systems that
>>> are not NUMA-aware, we can go with *any* Redistributor/CPU.
>>
>> This makes zero sense. From the point of view of a device, all the RDs
>> should be reachable, and firmware has no say in it. Dealing with
>> interrupt affinity is the responsibility of the endpoint driver, and
>> NUMA affinity is only a performance optimisation.
>>
>>> Is there any additional information we would be able to gather from ACPI
>>> or DT that's not there currently, that would be useful here?
>>
>> You will need some firmware information describing that a given set of
>> devices must use the RDs for their MSIs. Just like we currently
>> describe it in IORT for the ITS. You cannot /assume/ things. At the
>> moment, there is nothing at all, because no-one (including Microsoft)
>> thought it would be a good idea not to have an ITS, which is also why
>> ACPI doesn't describe MBIs as a potential MSI provider.
>>
> I am a little bit confused by your above comment. Maybe you can help me
> understand the ask. You indicate that from the point of the view of the
> device, all the RDs should be reachable. But, then if we define a mapping
> between PCI endpoint and RD in the firmware, we would be doing exactly
> the opposite. i.e. restricting the RDs that are reachable by the device. Can
> you please clarify?
> 
> Is your concern that the device should be able to only DMA to a subset of
> GIC Redistributor, for the MSIs? If so, in the IORT, there is "memory address
> size limit" for both device and root complex nodes. In the implementation,
> we can enforce that the GICR is within that range. And, if a device deviates
> further than that (ex: by having accessibility gaps within the GICR range),
> then that is out of scope for support.

No, please don't try to abuse the Memory Address Size Limit - that has 
far more chance of adversely affecting normal DMA operation than of 
being any use here.

I believe the point Marc was trying to make is that firmware should not 
associate a device with any one *specific* redistributor, however ACPI 
currently has no way to describe that MSIs can target redistributors *at 
all*, only ITS groups - there is no such concept as a "redistributor group".

Robin.
