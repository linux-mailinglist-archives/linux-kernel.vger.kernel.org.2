Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90D739BCEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFDQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:22:33 -0400
Received: from foss.arm.com ([217.140.110.172]:42478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFDQWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:22:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBD9812FC;
        Fri,  4 Jun 2021 09:20:45 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F6C3F93E;
        Fri,  4 Jun 2021 09:20:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] arm64: Make kexec_file_load honor iomem
 reservations
To:     Marc Zyngier <maz@kernel.org>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
References: <20210531095720.77469-1-maz@kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <41ac1e4b-3779-4cb2-5b64-d638521e67c1@arm.com>
Date:   Fri, 4 Jun 2021 17:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210531095720.77469-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 31/05/2021 10:57, Marc Zyngier wrote:
> This series is a complete departure from the approach I initially sent
> almost a month ago[0]. Instead of trying to teach EFI, ACPI and other
> subsystem to use memblock, I've decided to stick with the iomem
> resource tree and use that exclusively for arm64.

> This means that my current approach is (despite what I initially
> replied to both Dave and Catalin) to provide an arm64-specific
> implementation of arch_kexec_locate_mem_hole() which walks the
> resource tree and excludes ranges of RAM that have been registered for
> any odd purpose. This is exactly what the userspace implementation
> does, and I don't really see a good reason to diverge from it.

Because in the ideal world we'd have only 'is it reserved' list to check against.
Memblock has been extended before. The resource-list is overly stringy, and I'm not sure
we can shove everything in the resource list.

Kexec already has problems on arm64 with memory hotplug. Fixing this for regular kexec in
/proc/iomem was rejected, and memblock's memblock_is_hotpluggable() is broken because
free_low_memory_core_early() does this:
|	memblock_clear_hotplug(0, -1)

Once that has been unpicked its clear kexec_file_load() can use
memblock_is_hotpluggable(). (its on the todo list, well, jira)


I'd prefer to keep kexec using memblock because it _shouldn't_ change after boot. Having
an "I want to reserve this and make it persistent over kexec" call that can happen at any
time can't work if the kexec image has already been loaded.
Practically, once user-space has started, you can't have new things you want to reserve
over kexec.


I don't see how the ACPI tables can escape short of a firmware bug. Could someone with an
affected platform boot with efi=debug and post the EFI memory map and the 'ACPI: FOO
0xphysicaladdress' stuff at the top of the boot log?


efi_mem_reserve_persistent() has one caller for the GIC ITS stuff.

For the ITS, the reservations look like they are behind irqchip_init(), which is well
before the arch_initcall() that updates the resource tree from memblock. Your v1's first
patch should be sufficient.


> Again, this allows my Synquacer board to reliably use kexec_file_load
> with as little as 256M, something that would always fail before as it
> would overwrite most of the reserved tables.
> 
> Although this series still targets 5.14, the initial patch is a
> -stable candidate, and disables non-kdump uses of kexec_file_load. I
> have limited it to 5.10, as earlier kernels will require a different,
> probably more invasive approach.
> 
> Catalin, Ard: although this series has changed a bit compared to v1,
> I've kept your AB/RB tags. Should anything seem odd, please let me
> know and I'll drop them.


Thanks,

James


[0] I'm pretty sure this is enough. (Not tested)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4b7ee3fa9224..3ed45153ce7f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -893,7 +893,7 @@ static int __init efi_memreserve_map_root(void)
        return 0;
 }

-static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
+static int __efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
 {
        struct resource *res, *parent;

@@ -911,6 +911,16 @@ static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
        return parent ? request_resource(parent, res) : 0;
 }

+static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
+{
+       int err = __efi_mem_reserve_iomem(addr, size);
+
+       if(IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK) && !err)
+               memblock_reserve(addr, size);
+
+       return err;
+}
+
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
        struct linux_efi_memreserve *rsv;
