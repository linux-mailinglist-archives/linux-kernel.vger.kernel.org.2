Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0322426645
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJHI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:57:48 -0400
Received: from srv6.fidu.org ([159.69.62.71]:37710 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhJHI5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:57:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id CBB21C8008E;
        Fri,  8 Oct 2021 10:55:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7OLv8TX-x2nF; Fri,  8 Oct 2021 10:55:50 +0200 (CEST)
Received: from [192.168.178.82] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 19924C80082;
        Fri,  8 Oct 2021 10:55:50 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH RESEND] x86/resource: Do not exclude regions that are
 marked as MMIO in EFI memmap
To:     mika.westerberg@linux.intel.com
Cc:     benoitg@coeus.ca, bhelgaas@google.com, bp@alien8.de, hpa@zytor.com,
        juhapekka.heikkila@gmail.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
References: <20200617164734.84845-1-mika.westerberg@linux.intel.com>
Message-ID: <1c225d72-44dc-1ddb-3284-a5d19e0db882@tuxedocomputers.com>
Date:   Fri, 8 Oct 2021 10:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20200617164734.84845-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space") made the resource allocation code to avoid all regions that are
> in E820 table. This prevents the kernel to assign MMIO resources to
> regions that may be real RAM for example.
>
> However, at least with Lenovo Yoca C940 and S740 this causes problems
> when allocating resources for PCIe devices behind Thunderbolt port(s).
>
> On Yoga S740 the E820 table contains an entry like this:
>
>   BIOS-e820: [mem 0x000000002bc50000-0x00000000cfffffff] reserved
>
> and ACPI _CRS method for the host bridge returns these windows:
>
>   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>   pci_bus 0000:00: root bus resource [mem 0x45400000-0xbfffffff window]
>   pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
>
> Note that the 0x45400000-0xbfffffff entry is also included in the E820
> table and marked as "reserved".
>
> When Thunderbolt device is connected and the PCIe gets tunneled PCI core
> tries to allocate memory for the new devices but it fails because all
> the resources are inside this reserved region so arch_remove_reservations()
> clips them which makes the resource assignment fail as in below log:
>
>   pci 0000:00:07.0: PCI bridge to [bus 01-2a]
>   pci 0000:00:07.0:   bridge window [mem 0x46000000-0x521fffff]
>   pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
>   ...
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 07-2a] add_size 100000 add_align 100000
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07-2a] add_size 100000 add_align 100000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 02-2a] add_size 100000 add_align 100000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 02-2a] add_size 100000 add_align 100000
>   pci 0000:01:00.0: bridge window [io  0x1000-0x5fff] shrunken by 0x0000000000004000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff] extended by 0x000000000bd00000
>   pci 0000:01:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] extended by 0x000000001bb00000
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] extended by 0x000000000bd00000
>   pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] extended by 0x000000001bb00000
>   pci 0000:01:00.0: BAR 8: no space for [mem size 0x0c200000]
>   pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x0c200000]
>   pci 0000:01:00.0: BAR 9: assigned [mem 0x6000000000-0x601bffffff 64bit pref]
>   pci 0000:01:00.0: BAR 7: assigned [io  0x4000-0x4fff]
>
> The 01:00.0 is the upstream port of the PCIe switch that is connected to
> the PCIe root port (00:07.1) over Thunderbolt link.
>
> If I add "efi=debug" to the command line I can see that the EFI memory
> map actually contains several entries:
>
>   [Reserved           |   |  |  |  |  |  |  | |   |WB|WT|WC|UC] range=[0x000000002bc50000-0x000000003fffffff] (323MB)
>   [Reserved           |   |  |  |  |  |  |  | |   |WB|  |  |UC] range=[0x0000000040000000-0x0000000040ffffff] (16MB)
>   [Reserved           |   |  |  |  |  |  |  | |   |  |  |  |  ] range=[0x0000000041000000-0x00000000453fffff] (68MB)
>   [Memory Mapped I/O  |RUN|  |  |  |  |  |  | |   |  |  |  |UC] range=[0x0000000045400000-0x00000000cfffffff] (2220MB)
>
> I think the EFI stub merges these consecutive entries into that single
> E820 entry showed above. The last region marked as EFI_MEMORY_MAPPED_IO
> actually covers the PCI host bridge window entirely. However, since
> there is corresponding E820 type for this it is simply marked as
> E820_TYPE_RESERVED.
>
> All in all, I think we can fix this by modifying arch_remove_reservations()
> to check the EFI type as well and if it is EFI_MEMORY_MAPPED_IO skip the
> clipping in that case.
>
> Reported-by: Benoit Grégoire <benoitg@coeus.ca>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206459 <https://bugzilla.kernel.org/show_bug.cgi?id=206459>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/kernel/resource.c <https://lore.kernel.org/lkml/20200617164734.84845-1-mika.westerberg@linux.intel.com/#Z31arch:x86:kernel:resource.c> | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff
> <https://lore.kernel.org/lkml/20200617164734.84845-1-mika.westerberg@linux.intel.com/#iZ31arch:x86:kernel:resource.c>
> --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c index 9b9fb7882c20..c0bc9117dd7d 100644 ---
> a/arch/x86/kernel/resource.c +++ b/arch/x86/kernel/resource.c @@ -1,4 +1,5 @@  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/efi.h>  #include <linux/ioport.h>
>  #include <asm/e820/api.h>
>  
> @@ -36,6 +37,36 @@ static void remove_e820_regions(struct resource *avail)  	}
>  }
>  
> +#ifdef CONFIG_EFI +static bool efi_mmio_mem(const struct resource *avail) +{ + resource_size_t start, end; +
> efi_memory_desc_t desc; + + if (!efi_enabled(EFI_MEMMAP) || + efi_mem_desc_lookup(avail->start, &desc)) + return
> false; + + start = desc.phys_addr; + end = desc.phys_addr + (desc.num_pages << EFI_PAGE_SHIFT) - 1; + + /* + * No need
> to clip the resource if it is fully contained in an + * EFI memory mapped region. + */ + if (avail->start >= start &&
> avail->end <= end && + desc.type == EFI_MEMORY_MAPPED_IO) + return true; + + return false; +} +#else +static inline
> bool efi_mmio_mem(const struct resource *avail) +{ + return false; +} +#endif +  void arch_remove_reservations(struct resource *avail)
>  {
>  	/*
> @@ -46,6 +77,7 @@ void arch_remove_reservations(struct resource *avail)  	if (avail->flags & IORESOURCE_MEM) {
>  		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
>  
> - remove_e820_regions(avail); + if (!efi_mmio_mem(avail)) + remove_e820_regions(avail);  	}
>  }
> -- 
> 2.27.0.rc2
Greetings,

Is there any update on this matter? Also happens on discrete Thunderbolt 4 chips:
https://bugzilla.kernel.org/show_bug.cgi?id=214259

Kind Regards,

Werner Sembach

