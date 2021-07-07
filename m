Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80FF3BE4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhGGIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:53:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43430 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhGGIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:53:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625647852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9L+NhrAVyih3jbZMP9vTTphcf3rwJymWrt3VSsoaNI=;
        b=GMSJvpeP32mWrQFfvpc0lQIBgOB7/zTTl4wPG9hGJqi3nypg4B42eH9WU6GX8PtDkQ6LS1
        urNezaLlW/cuUba8xtnz9yEXYmd6b9Sg9lzk9W6KKzclgcHVrjVHgMElh7XZpAM8eRTcKA
        zqFgTfVzH11hCTRPd3xFTmzJXQgqxNY4nv4Aq0T4Ih1CeXQthZzRHyyB+isyM6TDepXrzY
        KkdEfz2zPKq0gbQEA/mqf3fxRkXo6HkWsxGYZmrok/uw34rdTYSVGJgUDJtf+qLnpE758a
        T5BOZEOQElnHOsvLXyrmEnNddRAqtr1g72T3FKSX2rgVM9VTGVVo0eCYTBbmow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625647852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9L+NhrAVyih3jbZMP9vTTphcf3rwJymWrt3VSsoaNI=;
        b=wUa/ve+UavwLOtzOPXMQ+CoR7aT4ibRaKid85YzCWQWU3UK9Pdo1DfIEwgvcLS7dsI8WRi
        OaFbH2JGv1oPhMAA==
To:     "Dey\, Megha" <megha.dey@intel.com>
Cc:     linux-kernel@vger.kernel.org, "Raj\, Ashok" <ashok.raj@intel.com>,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Tian\, Kevin" <kevin.tian@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu\, Yi L" <yi.l.liu@intel.com>, jgg@mellanox.com,
        "Kumar\, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven\, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: Programming PASID in IMS entries
In-Reply-To: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
Date:   Wed, 07 Jul 2021 10:50:52 +0200
Message-ID: <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Megha,

On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> Per your suggestions during the last meeting, we wanted to confirm the 
> sequence to program the PASID into the IMS entries:
>
> 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> source-id's such as Jason's vm-id can be added to it)

Yes. Though we also discussed storing the default PASID in struct device
to begin with which is then copied to the msi_desc entries during
allocation.

> 2. Create an API which device drivers can call, to program the PASID 
> (PASID provided by the driver) on a per-irq basis. This API is to be 
> called after msi_domain_alloc_irqs and will write to the corresponding 
> msi_desc->pasid entry. (Assumption: For now, all devices will have the 
> same IMS format). for e.g:
>
> msi_desc_set_pasid (irq, pasid) {
>
> struct msi_desc *desc = irq_get_msi_desc(irq);
>
> desc->pasid = pasid;
>
> }

That interface should be opaque probably with an u64 argument so it can
be reused for Jason's VM-id. Jason?

> 3. In request_irq, add a irq_chip callback (in __setup_irq maybe??) to 
> automatically write the pasid into the corresponding IMS entry:

Why? There is no need for yet another callback. The PASID or whatever ID
is required can be written as part of e.g. irq_unmask().

> Is this the correct approach?

No.

> Also, from a previous discussion [1], we want to make IMS more dynamic:
>
> Given the QEMU behavior it doesn't ask for all IRQs upfront. It only 
> allocates 1, and when it unmasks the 2nd, it wants to dynamically add a 
> second. This will allow adding a second IRQ without having to free all 
> the old irqs and reacquire the new number (as it is done today).
>
> This dynamic behavior is only for MSIx/IMS backed entries. For legacy
> MSI, QEMU will allocate everything upfront. Since it has a
> "num_vectors" enabled, nothing can be dynamically done for MSI. Kevin
> is looking to have this fixed for legacy to stop the dynamic part for
> MSI. We are pursuing this change just for IMS first, and once it
> works, we can replicate the same for MSIx too.

No. Fix the existing stuff first and then IMS just works.

> In order to make IMS dynamic, we were thinking of the following 
> enhancements to the IMS core:
>
> 1. Device Driver specifies maximum number of interrupts the sub device 
> is allowed to request, while creating the dev-msi domain. E.g. in the 
> case of DSA, Driver can specify that each mdev created can have upto X

Why would this be mdev specific? IIRC the sub devices can be used on
bare metal as well.

> number of IMS interrupts. If device asks for more than this number,it 
> will behave like how current IRQ allocation works i.e. give what is 
> available.
>
> 2. Driver can ask for more interrupts after probe as well as long as the 
> request has not exceeded the maximum permitted for it and the physical 
> device has the requested number available.

Ok.

> We are still working on the virtualization flows: when guest updates 
> PASID, and how it flows to host IMS update. But we will come to that 
> once the above pieces are agreed upon.

Hypercall?

Thanks,

        tglx
