Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9F410F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhITGXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 02:23:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50408 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhITGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 02:23:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18K6M8cR105491;
        Mon, 20 Sep 2021 01:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632118928;
        bh=cGzq+LElCi0WvquyL9h04M9GQMqt65EWmM2LFPx7TSM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ji8QzlKOv8kBMVaGYBtnG9gVpAfAAlLqHrJfGkB8Ls/csigL0yVMYbdk3qYsmorCS
         kV768iiE9blPcHxew98zksrQ16lbYnSZEKS8y1ghG/jWlwZNuZH0JJAWKDs/1rF9st
         9F/gTq6jQyFAnEDXRbEHZC5vdZLBPXaVA4m1Iiwk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18K6M8b1038594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 01:22:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 01:22:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 01:22:07 -0500
Received: from [10.250.232.18] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18K6M5nq027605;
        Mon, 20 Sep 2021 01:22:06 -0500
Subject: Re: [QUERY] Using same ITS device ID for two PCI devices (two PCI
 Requestor ID)
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vutla, Lokesh" <lokeshvutla@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>
References: <5f8f586b-4308-dad7-d87d-9a341a248680@ti.com>
 <87sfy4bd8h.wl-maz@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7cf627db-9859-c7e1-5f07-0ab29f2efe7e@ti.com>
Date:   Mon, 20 Sep 2021 11:52:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87sfy4bd8h.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 16/09/21 11:43 pm, Marc Zyngier wrote:
> Kishon,
> 
> On Thu, 16 Sep 2021 14:02:58 +0100,
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Marc, Thomas,
>>
>> TI's K3 platforms use GIT ITS for PCIe MSI/MSI-X interrupts. It uses
>> *pre_its_window* as implemented by
>> *its_enable_quirk_socionext_synquacer* in irq-gic-v3-its.c.
> 
> I see it coming... If it sounds like a car crash, if it smells like a
> car crash, it probably is a car crash...
> 
>> So PCIe controller instead of directly writing to GITS_TRANSLATER,
>> will write to a separate window and the device ID is taken from the
>> offset to which the PCIe device writes (instead of dedicated lines
>> from PCIe controller to GIC ITS). So every 4-byte register address
>> maps in this window maps to a unique ITS device id.
>>
>> All of this is already implemented in Linux Kernel
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-gic-v3-its.c#n4645
>>
>> Now TI's AM64 has an issue in that it doesn't trigger interrupt if
>> the address in the *pre_its_window* is not aligned to 8-bytes (this
>> is due to an invalid bridge configuration in HW).
>>
>> This means there will not be interrupts for devices with PCIe
>> requestor ID, 0x1, 0x3, 0x5..., as the address in the pre-ITS window
>> would be 4 (1 << 2), 12 (3 << 2), 20 (5 << 2) respectively.
> 
> Let me get this straight: instead of using the existing infrastructure
> and propagating the RIDs to the ITS, TI decided to go our of their way
> to copy the Socionext utter madness, something that was already a
> glaring bug, and managed to add a bug of their own on top of it?

unfortunately yes.
> 
> Not only this completely breaks device isolation (the Socionext bug),
> but you can't even have an odd-numbered function generating MSIs? Good

Yes.
> thing I'm on holiday, I can have an early drink to forget...
> 
>> So in order to provide 8 byte aligned address always, I mapped the PCIe
>> requestor ID to ITS device ID such that it always provides 8-byte aligned
>> address. The DT property like below helped me achieve that.
>>
>> msi-map = <0x0 &gic_its 0x0 0x10000>;
>> msi-map-mask = <0xfffe>;
>>
>> So this would result in creating one "struct its_device" for 2 PCIe
>> devices and the pre-ITS address will be aligned to 8-bytes.
>>
>> However with this, its_alloc_device_irq() for the 2nd PCIe device is failing
>> since we create "struct its_device" with the number of interrupt vectors
>> requested by the 1st PCIe device.
>>
>> Would like to get your opinion on what would be the best way to
>> workaround this for AM64.
> 
> My preferred workaround would be to take a drill and end the life of
> this thing right now. I guess this isn't an option, so see below for
> the next best thing.
> 
>> One option would be to create a new compatible for AM64 ("ti,am64,gic-v3-its")
>> allocate a minimal number of interrupt vector while creating "struct
>> its_device". Would that be acceptable? Any other ideas?
> 
> No. Messing with the core ITS allocation isn't acceptable. If there is
> such a hack, it has to be dealt within the ITS PCI backend (I assume
> you don't have anything but PCI devices targeting the ITS, right?).

That's right!
> 
> We already have to deal with cases where the endpoints are behind
> aliasing bridges, meaning that we can't distinguish between them, and
> have to account for all the endpoints behind this bridge. You will
> have to perform something similar and compute the upper bound for
> these two devices (functions of the same device actually). See
> its_pci_msi_prepare() for the gory details.

Thanks for the hint. Let me take a stab at it.

Regards,
Kishon
