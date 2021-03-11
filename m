Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27133766F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhCKPDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233597AbhCKPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615474984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lE4pGT2Jfo9FEFwa2ddm9JZM2vPQ1/amRC1p9RA+/ug=;
        b=WJlX2V2cyaQZi2aVbH9Y2Tg8CH66ZdalGKL0n/ThpagQ8sAbsz+UJii0XgjcoCYfOi2c2J
        Mblbyhd9KDUEUBH3HLXdoRSeyNggvf2rqNG5wnOR0nOhrQMZlm+mn7NzYeS9VkG8/1O8sF
        q7BTuViyQmV/AcuNy0HJ1mHg2Oss8RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-t1dHcwhPMV2OSRXhteR1jg-1; Thu, 11 Mar 2021 10:02:59 -0500
X-MC-Unique: t1dHcwhPMV2OSRXhteR1jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 082BC100C660;
        Thu, 11 Mar 2021 15:02:57 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2B6719C78;
        Thu, 11 Mar 2021 15:02:53 +0000 (UTC)
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
Date:   Thu, 11 Mar 2021 16:02:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 15:41, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> Booting kernels on certain AMD platforms takes 2-3 minutes with the patch in the subject.  Reverting it restores quick boot times (few seconds).  Any ideas?
> 

Hi,

We just discovered latent BUGs in ACPI code whereby ACPI tables are  
exposed to the page allocator as ordinary, free system RAM. With the  
patch you mention, the order in which pages get allocated from the page  
allocator are changed - which makes the BUG trigger more easily.

I could imagine that someone allocates and uses that memory on your  
platform, and I could imagine that such accesses are very slow.

I cannot tell if that is the root cause, but at least it would make sense.

See https://lore.kernel.org/patchwork/patch/1389314/

You might want to give that patch a try (not sure if it's the latest  
version). CCing George

Thanks

> Thanks,
> 
> Alex
> 
> [    0.000000] Linux version 5.11.0-7490c004ae7e (jenkins@24dbd4b4380b) (gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #20210308 SMP Sun Mar 7 20:04:05 UTC 2021
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-7490c004ae7e root=UUID=459758f3-5106-4173-b9bc-cf9d528828ec ro resume=UUID=23390f67-bbaf-42c1-b31d-64ef7288e39e amd_iommu=off nokaslr
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f10fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000009f11000-0x000000006c56efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006c56f000-0x000000006c56ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000006c570000-0x000000007877efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007877f000-0x000000007af7efff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000007af7f000-0x000000007cf7efff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000007cf7f000-0x000000007cffefff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000007cfff000-0x000000007cffffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007d000000-0x000000007dffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000007fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000a0000000-0x00000000a00fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec01fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed81fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000feddffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff080000-0x00000000ffddffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023f37ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000023f380000-0x000000027fffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x6a275018-0x6a283857] usable ==> usable
> [    0.000000] e820: update [mem 0x6a275018-0x6a283857] usable ==> usable
> [    0.000000] e820: update [mem 0x6c572018-0x6c57c657] usable ==> usable
> [    0.000000] e820: update [mem 0x6c572018-0x6c57c657] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000bffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009afffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000009e00000-0x0000000009efffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f10fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000009f11000-0x000000006a275017] usable
> [    0.000000] reserve setup_data: [mem 0x000000006a275018-0x000000006a283857] usable
> [    0.000000] reserve setup_data: [mem 0x000000006a283858-0x000000006c56efff] usable
> [    0.000000] reserve setup_data: [mem 0x000000006c56f000-0x000000006c56ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000006c570000-0x000000006c572017] usable
> [    0.000000] reserve setup_data: [mem 0x000000006c572018-0x000000006c57c657] usable
> [    0.000000] reserve setup_data: [mem 0x000000006c57c658-0x000000007877efff] usable
> [    0.000000] reserve setup_data: [mem 0x000000007877f000-0x000000007af7efff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000007af7f000-0x000000007cf7efff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000007cf7f000-0x000000007cffefff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x000000007cfff000-0x000000007cffffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000007d000000-0x000000007dffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000007f000000-0x000000007fffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000a0000000-0x00000000a00fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec01fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed81fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fedc0000-0x00000000feddffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff080000-0x00000000ffddffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000023f37ffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000023f380000-0x000000027fffffff] reserved
> [    0.000000] efi: EFI v2.70 by INSYDE Corp.
> [    0.000000] efi: ACPI=0x7cffe000 ACPI 2.0=0x7cffe014 SMBIOS=0x7970c000 SMBIOS 3.0=0x7970a000 ESRT=0x7970d618 MEMATTR=0x74959018 RNG=0x7970d798
> [    0.000000] efi: seeding entropy pool
> [    0.000000] SMBIOS 3.1.1 present.
> [    0.000000] DMI: AMD Chachani-VN/Chachani-VN, BIOS WCH1304N 03/04/2021
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2400.092 MHz processor
> [    0.000011] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000014] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000021] last_pfn = 0x23f380 max_arch_pfn = 0x400000000
> [    0.000026] MTRR default type: uncachable
> [    0.000027] MTRR fixed ranges enabled:
> [    0.000028]   00000-9FFFF write-back
> [    0.000029]   A0000-BFFFF uncachable
> [    0.000030]   C0000-FFFFF write-through
> [    0.000031] MTRR variable ranges enabled:
> [    0.000032]   0 base 000000000000 mask FFFF80000000 write-back
> [    0.000034]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
> [    0.000035]   2 base 000100000000 mask FFFFFF000000 write-protect
> [    0.000036]   3 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
> [    0.000038]   4 base 0000FF000000 mask FFFFFFF80000 write-protect
> [    0.000039]   5 disabled
> [    0.000039]   6 disabled
> [    0.000040]   7 disabled
> [    0.000040] TOM2: 0000000280000000 aka 10240M
> [    0.000262] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000770] last_pfn = 0x7d000 max_arch_pfn = 0x400000000
> [    0.004754] esrt: Reserving ESRT space from 0x000000007970d618 to 0x000000007970d650.
> [    0.004765] check: Scanning 1 areas for low memory corruption
> [    0.004772] Using GB pages for direct mapping
> [    0.005629] Secure boot disabled
> [    0.005630] RAMDISK: [mem 0x3d2bb000-0x3fffdfff]
> [    0.005640] ACPI: Early table checksum verification disabled
> [    0.005645] ACPI: RSDP 0x000000007CFFE014 000024 (v02 AMDYDE)
> [    0.005649] ACPI: XSDT 0x000000007CFCE188 0000FC (v01 AMDYDE Celadon  00000002      01000013)
> [    0.005656] ACPI: FACP 0x000000007CFEF000 00010C (v05 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005661] ACPI: DSDT 0x000000007CFE0000 007717 (v01 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005664] ACPI: FACS 0x000000007BF1F000 000040
> [    0.005667] ACPI: UEFI 0x000000007CF7E000 000236 (v01 AMDYDE Celadon  00000001 ACPI 00040000)
> [    0.005670] ACPI: SDEV 0x000000007CFFC000 00014E (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005673] ACPI: SSDT 0x000000007CFFB000 0001DE (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005676] ACPI: SSDT 0x000000007CFF3000 007237 (v02 AMD    Celadon  00000002 ACPI 00040000)
> [    0.005679] ACPI: ASF! 0x000000007CFF1000 0000A5 (v32 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005682] ACPI: BOOT 0x000000007CFF0000 000028 (v01 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005685] ACPI: HPET 0x000000007CFEE000 000038 (v01 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005688] ACPI: APIC 0x000000007CFED000 000138 (v03 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005691] ACPI: MCFG 0x000000007CFEC000 00003C (v01 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005694] ACPI: SLIC 0x000000007CFEB000 000176 (v01 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005697] ACPI: WSMT 0x000000007CFE8000 000028 (v01 AMDYDE Celadon  00000002 ACPI 00040000)
> [    0.005700] ACPI: SSDT 0x000000007CFDF000 000099 (v01 AMDyde Celadon  00000002 ACPI 00040000)
> [    0.005703] ACPI: VFCT 0x000000007CFD4000 00A684 (v01 AMDYDE Celadon  00000001 ACPI 00040000)
> [    0.005706] ACPI: SSDT 0x000000007CFD3000 0000F8 (v01 AMD    Celadon  00001000 ACPI 00040000)
> [    0.005709] ACPI: SSDT 0x000000007CFD1000 001D0C (v02 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005712] ACPI: CRAT 0x000000007CFD0000 0007E8 (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005715] ACPI: CDIT 0x000000007CFCF000 000029 (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005718] ACPI: SSDT 0x000000007CFFD000 000735 (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005721] ACPI: SSDT 0x000000007CFCC000 0014AE (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005723] ACPI: SSDT 0x000000007CFCA000 001525 (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005726] ACPI: SSDT 0x000000007CFC4000 0051E8 (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005730] ACPI: FPDT 0x000000007CFC3000 000044 (v01 AMD    Celadon  00000002 ACPI 00040000)
> [    0.005732] ACPI: SSDT 0x000000007CFEA000 00008D (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005735] ACPI: SSDT 0x000000007CFC0000 0013CA (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005738] ACPI: SSDT 0x000000007CFE9000 000C4D (v01 AMD    Celadon  00000001 ACPI 00040000)
> [    0.005741] ACPI: BGRT 0x000000007CFC2000 000038 (v01 AMDYDE Celadon  00000001 ACPI 00040000)
> [    0.005748] ACPI: Local APIC address 0xfee00000
> [    0.005855] No NUMA configuration found
> [    0.005856] Faking a node at [mem 0x0000000000000000-0x000000023f37ffff]
> [    0.005869] NODE_DATA(0) allocated [mem 0x23f355000-0x23f37ffff]
> [    0.006126] Zone ranges:
> [    0.006127]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.006129]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.006130]   Normal   [mem 0x0000000100000000-0x000000023f37ffff]
> [    0.006132]   Device   empty
> [    0.006133] Movable zone start for each node
> [    0.006135] Early memory node ranges
> [    0.006135]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.006137]   node   0: [mem 0x0000000000100000-0x0000000009afffff]
> [    0.006138]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]
> [    0.006139]   node   0: [mem 0x0000000009f11000-0x000000006c56efff]
> [    0.006140]   node   0: [mem 0x000000006c570000-0x000000007877efff]
> [    0.006141]   node   0: [mem 0x000000007cfff000-0x000000007cffffff]
> [    0.006142]   node   0: [mem 0x0000000100000000-0x000000023f37ffff]
> [    0.006360] Zeroed struct page in unavailable ranges: 34932 pages
> [    0.006361] Initmem setup node 0 [mem 0x0000000000001000-0x000000023f37ffff]
> [    0.006363] On node 0 totalpages: 1800076
> [    0.006365]   DMA zone: 64 pages used for memmap
> [    0.006366]   DMA zone: 21 pages reserved
> [    0.006366]   DMA zone: 3998 pages, LIFO batch:0
> [    0.006388]   DMA32 zone: 7634 pages used for memmap
> [    0.006389]   DMA32 zone: 488558 pages, LIFO batch:63
> [    0.009789]   Normal zone: 20430 pages used for memmap
> [    0.009794]   Normal zone: 1307520 pages, LIFO batch:63
> [    0.019234] ACPI: PM-Timer IO Port: 0x408
> [    0.019240] ACPI: Local APIC address 0xfee00000
> [    0.019247] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.019248] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.019249] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.019250] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.019251] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.019252] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.019253] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.019254] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.019255] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.019256] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
> [    0.019257] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
> [    0.019258] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
> [    0.019258] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
> [    0.019259] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
> [    0.019260] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
> [    0.019261] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
> [    0.019276] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
> [    0.019282] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
> [    0.019284] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.019286] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.019288] ACPI: IRQ0 used by override.
> [    0.019289] ACPI: IRQ9 used by override.
> [    0.019291] Using ACPI (MADT) for SMP configuration information
> [    0.019293] ACPI: HPET id: 0x10228210 base: 0xfed00000
> [    0.019307] e820: update [mem 0x7495e000-0x7499ffff] usable ==> reserved
> [    0.019319] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
> [    0.019363] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.019365] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000bffff]
> [    0.019367] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
> [    0.019369] PM: hibernation: Registered nosave memory: [mem 0x09b00000-0x09dfffff]
> [    0.019372] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f10fff]
> [    0.019374] PM: hibernation: Registered nosave memory: [mem 0x6a275000-0x6a275fff]
> [    0.019377] PM: hibernation: Registered nosave memory: [mem 0x6a283000-0x6a283fff]
> [    0.019379] PM: hibernation: Registered nosave memory: [mem 0x6c56f000-0x6c56ffff]
> [    0.019381] PM: hibernation: Registered nosave memory: [mem 0x6c572000-0x6c572fff]
> [    0.019384] PM: hibernation: Registered nosave memory: [mem 0x6c57c000-0x6c57cfff]
> [    0.019386] PM: hibernation: Registered nosave memory: [mem 0x7495e000-0x7499ffff]
> [    0.019389] PM: hibernation: Registered nosave memory: [mem 0x7877f000-0x7af7efff]
> [    0.019390] PM: hibernation: Registered nosave memory: [mem 0x7af7f000-0x7cf7efff]
> [    0.019391] PM: hibernation: Registered nosave memory: [mem 0x7cf7f000-0x7cffefff]
> [    0.019393] PM: hibernation: Registered nosave memory: [mem 0x7d000000-0x7dffffff]
> [    0.019394] PM: hibernation: Registered nosave memory: [mem 0x7e000000-0x7effffff]
> [    0.019395] PM: hibernation: Registered nosave memory: [mem 0x7f000000-0x7fffffff]
> [    0.019396] PM: hibernation: Registered nosave memory: [mem 0x80000000-0x9fffffff]
> [    0.019397] PM: hibernation: Registered nosave memory: [mem 0xa0000000-0xa00fffff]
> [    0.019398] PM: hibernation: Registered nosave memory: [mem 0xa0100000-0xefffffff]
> [    0.019399] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
> [    0.019400] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfebfffff]
> [    0.019400] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec01fff]
> [    0.019401] PM: hibernation: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
> [    0.019402] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
> [    0.019403] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfec1ffff]
> [    0.019404] PM: hibernation: Registered nosave memory: [mem 0xfec20000-0xfec20fff]
> [    0.019405] PM: hibernation: Registered nosave memory: [mem 0xfec21000-0xfed7ffff]
> [    0.019406] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed81fff]
> [    0.019407] PM: hibernation: Registered nosave memory: [mem 0xfed82000-0xfedbffff]
> [    0.019408] PM: hibernation: Registered nosave memory: [mem 0xfedc0000-0xfeddffff]
> [    0.019409] PM: hibernation: Registered nosave memory: [mem 0xfede0000-0xfedfffff]
> [    0.019409] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.019410] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff07ffff]
> [    0.019411] PM: hibernation: Registered nosave memory: [mem 0xff080000-0xffddffff]
> [    0.019412] PM: hibernation: Registered nosave memory: [mem 0xffde0000-0xffffffff]
> [    0.019414] [mem 0xa0100000-0xefffffff] available for PCI devices
> [    0.019416] Booting paravirtualized kernel on bare hardware
> [    0.019419] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.019427] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
> [    0.020118] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> [    0.020134] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> [    0.020136] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
> [    0.020184] Built 1 zonelists, mobility grouping on.  Total pages: 1771927
> [    0.020186] Policy zone: Normal
> [    0.020188] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-7490c004ae7e root=UUID=459758f3-5106-4173-b9bc-cf9d528828ec ro resume=UUID=23390f67-bbaf-42c1-b31d-64ef7288e39e amd_iommu=off nokaslr
> [    0.021100] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.021540] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.021602] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.044181] Memory: 6858688K/7200304K available (14345K kernel code, 9659K rwdata, 4980K rodata, 2484K init, 12292K bss, 341360K reserved, 0K cma-reserved)
> [    0.044191] random: get_random_u64 called from __kmem_cache_create+0x32/0x490 with crng_init=0
> [    0.047655] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> [    0.048264] ftrace: allocating 45990 entries in 180 pages
> [    0.095132] ftrace: allocated 180 pages with 4 groups
> [    0.100306] rcu: Hierarchical RCU implementation.
> [    0.100307] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
> [    0.100309] 	Rude variant of Tasks RCU enabled.
> [    0.100310] 	Tracing variant of Tasks RCU enabled.
> [    0.100311] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.100312] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> [    0.151286] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
> [    0.156315] Console: colour dummy device 80x25
> [    0.180522] printk: console [tty0] enabled
> [    0.181285] ACPI: Core revision 20201113
> [    0.184147] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.184339] APIC: Switch to symmetric I/O mode setup
> [    0.184420] Switched APIC routing to physical flat.
> [    0.186071] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.204327] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22988e400ed, max_idle_ns: 440795239148 ns
> [    0.204490] Calibrating delay loop (skipped), value calculated using timer frequency.. 4800.18 BogoMIPS (lpj=9600368)
> [    0.204650] pid_max: default: 32768 minimum: 301
> [    0.214025] LSM: Security Framework initializing
> [    0.214417] Yama: becoming mindful.
> [    0.216632] AppArmor: AppArmor initialized
> [    0.216726] TOMOYO Linux initialized
> [    0.219575] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.221160] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.230464] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.230691] LVT offset 1 assigned for vector 0xf9
> [    0.230835] LVT offset 2 assigned for vector 0xf4
> [    0.230926] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.231010] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
> [    0.231100] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.231250] Spectre V2 : Mitigation: Full AMD retpoline
> [    0.231329] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.231475] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.231563] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.231711] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> [    0.231799] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.232159] Freeing SMP alternatives memory: 40K
> [    0.353153] smpboot: CPU0: AMD Eng Sample: 100-000000405-03_35/24_N (family: 0x17, model: 0x90, stepping: 0x1)
> [    0.382538] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [    0.383259] ... version:                0
> [    0.383638] ... bit width:              48
> [    0.384029] ... generic registers:      6
> [    0.384410] ... value mask:             0000ffffffffffff
> [    0.384868] ... max period:             00007fffffffffff
> [    0.385316] ... fixed-purpose events:   0
> [    0.385700] ... event mask:             000000000000003f
> [    0.396831] rcu: Hierarchical SRCU implementation.
> [    0.510479] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.559253] smp: Bringing up secondary CPUs ...
> [    0.583839] x86: Booting SMP configuration:
> [    0.584209] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> [    0.773093] smp: Brought up 1 node, 8 CPUs
> [    0.773952] smpboot: Max logical packages: 2
> [    0.774378] smpboot: Total of 8 processors activated (38401.47 BogoMIPS)
> [    0.928885] devtmpfs: initialized
> [    0.948835] x86/mm: Memory block size: 128MB
> [    1.370091] PM: Registering ACPI NVS region [mem 0x09f00000-0x09f10fff] (69632 bytes)
> [    1.373025] PM: Registering ACPI NVS region [mem 0x7af7f000-0x7cf7efff] (33554432 bytes)
> [    2.425485] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    2.426427] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    2.461378] pinctrl core: initialized pinctrl subsystem
> [    2.504080] PM: RTC time: 09:55:41, date: 2021-03-09
> [    2.552705] NET: Registered protocol family 16
> [    2.598329] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
> [    2.599715] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    2.601224] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    2.603875] audit: initializing netlink subsys (disabled)
> [    2.608758] audit: type=2000 audit(1615283741.424:1): state=initialized audit_enabled=0 res=1
> [    2.662309] thermal_sys: Registered thermal governor 'fair_share'
> [    2.662437] thermal_sys: Registered thermal governor 'bang_bang'
> [    2.662943] thermal_sys: Registered thermal governor 'step_wise'
> [    2.663454] thermal_sys: Registered thermal governor 'user_space'
> [    2.665093] cpuidle: using governor ladder
> [    2.666132] cpuidle: using governor menu
> [    2.674855] Simple Boot Flag at 0x44 set to 0x80
> [    2.678087] ACPI: bus type PCI registered
> [    2.678469] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    2.729254] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    2.730117] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> [    2.732759] PCI: Using configuration type 1 for base access
> [    3.525622] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    3.526211] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    3.755679] ACPI: Added _OSI(Module Device)
> [    3.756085] ACPI: Added _OSI(Processor Device)
> [    3.756523] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    3.756957] ACPI: Added _OSI(Processor Aggregator Device)
> [    3.757730] ACPI: Added _OSI(Linux-Dell-Video)
> [    3.758596] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    3.759372] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [   16.177983] ACPI: 13 ACPI AML tables successfully acquired and loaded
> [   17.099316] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [   18.969959] ACPI: EC: EC started
> [   18.970292] ACPI: EC: interrupt blocked
> [   19.157370] ACPI: EC: EC_CMD/EC_SC=0x666, EC_DATA=0x662
> [   19.158218] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
> [   19.158937] ACPI: Interpreter enabled
> [   19.162768] ACPI: (supports S0 S3 S4 S5)
> [   19.163144] ACPI: Using IOAPIC for interrupt routing
> [   19.252572] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [   19.595919] ACPI: Enabled 5 GPEs in block 00 to 1F
> [   26.272348] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [   26.273544] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   26.413384] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> [   26.554340] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [   26.558378] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-7f] only partially covers this bridge
> [   26.722525] PCI host bridge to bus 0000:00
> [   26.723146] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [   26.723996] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [   26.724748] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [   26.725684] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
> [   26.726634] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
> [   26.727575] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> [   26.728664] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> [   26.729603] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> [   26.730542] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [   26.731489] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [   26.732433] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [   26.733474] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [   26.734428] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [   26.735380] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> [   26.736320] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> [   26.737260] pci_bus 0000:00: root bus resource [mem 0x80000000-0xefffffff window]
> [   26.738208] pci_bus 0000:00: root bus resource [mem 0xf8000000-0xfeafffff window]
> [   26.739154] pci_bus 0000:00: root bus resource [mem 0xfed45000-0xfed814ff window]
> [   26.740097] pci_bus 0000:00: root bus resource [mem 0xfed81900-0xfed81fff window]
> [   26.740739] pci_bus 0000:00: root bus resource [mem 0xfedc0000-0xfedc0fff window]
> [   26.741698] pci_bus 0000:00: root bus resource [mem 0xfedc6000-0xfedc6fff window]
> [   26.742645] pci_bus 0000:00: root bus resource [mem 0x2a0200000-0xf6ffffffff window]
> [   26.743621] pci_bus 0000:00: root bus resource [bus 00-ff]
> [   26.747142] pci 0000:00:00.0: [1022:1645] type 00 class 0x060000
> [   26.770689] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
> [   26.793856] pci 0000:00:01.2: [1022:1647] type 01 class 0x060400
> [   26.796430] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
> [   26.839179] pci 0000:00:01.3: [1022:1647] type 01 class 0x060400
> [   26.841752] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
> [   26.884369] pci 0000:00:01.6: [1022:1647] type 01 class 0x060400
> [   26.886841] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
> [   26.934008] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
> [   26.957168] pci 0000:00:08.1: [1022:1648] type 01 class 0x060400
> [   26.958050] pci 0000:00:08.1: enabling Extended Tags
> [   26.960219] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [   27.001530] pci 0000:00:08.2: [1022:1648] type 01 class 0x060400
> [   27.002418] pci 0000:00:08.2: enabling Extended Tags
> [   27.004599] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
> [   27.036289] pci 0000:00:08.3: [1022:1648] type 01 class 0x060400
> [   27.037176] pci 0000:00:08.3: enabling Extended Tags
> [   27.039327] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
> [   27.080252] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [   27.113024] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [   27.146020] pci 0000:00:18.0: [1022:1660] type 00 class 0x060000
> [   27.169355] pci 0000:00:18.1: [1022:1661] type 00 class 0x060000
> [   27.192762] pci 0000:00:18.2: [1022:1662] type 00 class 0x060000
> [   27.216299] pci 0000:00:18.3: [1022:1663] type 00 class 0x060000
> [   27.239509] pci 0000:00:18.4: [1022:1664] type 00 class 0x060000
> [   27.267198] pci 0000:00:18.5: [1022:1665] type 00 class 0x060000
> [   27.290470] pci 0000:00:18.6: [1022:1666] type 00 class 0x060000
> [   27.313671] pci 0000:00:18.7: [1022:1667] type 00 class 0x060000
> [   27.355414] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> [   27.356233] pci 0000:01:00.0: reg 0x10: [mem 0x80700000-0x80703fff 64bit]
> [   27.361199] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:01.2 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [   27.386170] pci 0000:00:01.2: PCI bridge to [bus 01]
> [   27.386774] pci 0000:00:01.2:   bridge window [mem 0x80700000-0x807fffff]
> [   27.399116] pci 0000:02:00.0: [10ec:522a] type 00 class 0xff0000
> [   27.399856] pci 0000:02:00.0: reg 0x10: [mem 0x80600000-0x80600fff]
> [   27.403515] pci 0000:02:00.0: supports D1 D2
> [   27.404028] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
> [   27.430150] pci 0000:00:01.3: PCI bridge to [bus 02]
> [   27.430754] pci 0000:00:01.3:   bridge window [mem 0x80600000-0x806fffff]
> [   27.438978] pci 0000:03:00.0: [8086:10d3] type 00 class 0x020000
> [   27.439729] pci 0000:03:00.0: reg 0x10: [mem 0x80580000-0x8059ffff]
> [   27.440401] pci 0000:03:00.0: reg 0x14: [mem 0x80500000-0x8057ffff]
> [   27.440982] pci 0000:03:00.0: reg 0x18: [io  0x2000-0x201f]
> [   27.441613] pci 0000:03:00.0: reg 0x1c: [mem 0x805a0000-0x805a3fff]
> [   27.442347] pci 0000:03:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> [   27.445736] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> [   27.461459] pci 0000:00:01.6: PCI bridge to [bus 03]
> [   27.462057] pci 0000:00:01.6:   bridge window [io  0x2000-0x2fff]
> [   27.462691] pci 0000:00:01.6:   bridge window [mem 0x80500000-0x805fffff]
> [   27.498456] pci 0000:04:00.0: [1002:163f] type 00 class 0x030000
> [   27.499227] pci 0000:04:00.0: reg 0x10: [mem 0xf6e0000000-0xf6efffffff 64bit pref]
> [   27.500055] pci 0000:04:00.0: reg 0x18: [mem 0xf6f0000000-0xf6f01fffff 64bit pref]
> [   27.500600] pci 0000:04:00.0: reg 0x20: [io  0x1000-0x10ff]
> [   27.501234] pci 0000:04:00.0: reg 0x24: [mem 0x80400000-0x8047ffff]
> [   27.501949] pci 0000:04:00.0: enabling Extended Tags
> [   27.504771] pci 0000:04:00.0: BAR 0: assigned to efifb
> [   27.505955] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
> [   27.507098] pci 0000:04:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
> [   27.537744] pci 0000:04:00.1: [1002:1640] type 00 class 0x040300
> [   27.538486] pci 0000:04:00.1: reg 0x10: [mem 0x80488000-0x8048bfff]
> [   27.539324] pci 0000:04:00.1: enabling Extended Tags
> [   27.542293] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
> [   27.572303] pci 0000:04:00.2: [1022:1649] type 00 class 0x108000
> [   27.573075] pci 0000:04:00.2: reg 0x18: [mem 0x80300000-0x803fffff]
> [   27.573788] pci 0000:04:00.2: reg 0x24: [mem 0x8048e000-0x8048ffff]
> [   27.574497] pci 0000:04:00.2: enabling Extended Tags
> [   27.605119] pci 0000:04:00.3: [1022:163a] type 00 class 0x0c03fe
> [   27.605883] pci 0000:04:00.3: reg 0x10: [mem 0x80000000-0x800fffff 64bit]
> [   27.606721] pci 0000:04:00.3: enabling Extended Tags
> [   27.609705] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> [   27.639931] pci 0000:04:00.4: [1022:163b] type 00 class 0x0c0330
> [   27.640653] pci 0000:04:00.4: reg 0x10: [mem 0x80100000-0x801fffff 64bit]
> [   27.641533] pci 0000:04:00.4: enabling Extended Tags
> [   27.644589] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
> [   27.674917] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300
> [   27.675658] pci 0000:04:00.6: reg 0x10: [mem 0x80480000-0x80487fff]
> [   27.676516] pci 0000:04:00.6: enabling Extended Tags
> [   27.679536] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
> [   27.710697] pci 0000:04:00.7: [1022:164a] type 00 class 0x118000
> [   27.711507] pci 0000:04:00.7: reg 0x18: [mem 0x80200000-0x802fffff]
> [   27.712229] pci 0000:04:00.7: reg 0x24: [mem 0x8048c000-0x8048dfff]
> [   27.712669] pci 0000:04:00.7: enabling Extended Tags
> [   27.747484] pci 0000:00:08.1: PCI bridge to [bus 04]
> [   27.748084] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
> [   27.748581] pci 0000:00:08.1:   bridge window [mem 0x80000000-0x804fffff]
> [   27.749264] pci 0000:00:08.1:   bridge window [mem 0xf6e0000000-0xf6f01fffff 64bit pref]
> [   27.762044] pci 0000:05:00.0: [1022:145a] type 00 class 0x130000
> [   27.762984] pci 0000:05:00.0: enabling Extended Tags
> [   27.766374] pci 0000:05:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:08.2 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
> [   27.789319] pci 0000:00:08.2: PCI bridge to [bus 05]
> [   27.801787] pci 0000:06:00.0: [1022:145a] type 00 class 0x130000
> [   27.802726] pci 0000:06:00.0: enabling Extended Tags
> [   27.806135] pci 0000:06:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:08.3 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
> [   27.831474] pci 0000:00:08.3: PCI bridge to [bus 06]
> [   28.069099] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.110655] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.148042] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.188354] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.227337] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.259694] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.292094] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 6 10 11) *0, disabled.
> [   28.324581] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 6 10 11) *0, disabled.
> [   29.417622] ACPI: EC: interrupt unblocked
> [   29.418001] ACPI: EC: event unblocked
> [   29.418379] ACPI: EC: EC_CMD/EC_SC=0x666, EC_DATA=0x662
> [   29.418833] ACPI: EC: GPE=0x5
> [   29.419377] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
> [   29.420207] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
> [   29.473872] iommu: Default domain type: Translated
> [   29.481739] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [   29.481739] pci 0000:04:00.0: vgaarb: bridge control possible
> [   29.481739] pci 0000:04:00.0: vgaarb: setting as boot device
> [   29.481739] vgaarb: loaded
> [   29.594672] SCSI subsystem initialized
> [   29.603325] libata version 3.00 loaded.
> [   29.610306] ACPI: bus type USB registered
> [   29.616273] usbcore: registered new interface driver usbfs
> [   29.619914] usbcore: registered new interface driver hub
> [   29.624498] usbcore: registered new device driver usb
> [   29.644598] EDAC MC: Ver: 3.0.0
> [   29.674756] Registered efivars operations
> [   29.768923] NetLabel: Initializing
> [   29.769254] NetLabel:  domain hash size = 128
> [   29.769649] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [   29.774392] NetLabel:  unlabeled traffic allowed by default
> [   29.782109] PCI: Using ACPI for IRQ routing
> [   29.803810] PCI: pci_cache_line_size set to 64 bytes
> [   29.804738] Expanded resource Reserved due to conflict with PCI Bus 0000:00
> [   29.805292] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
> [   29.805613] e820: reserve RAM buffer [mem 0x09b00000-0x0bffffff]
> [   29.805937] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
> [   29.806261] e820: reserve RAM buffer [mem 0x6a275018-0x6bffffff]
> [   29.806579] e820: reserve RAM buffer [mem 0x6c56f000-0x6fffffff]
> [   29.806898] e820: reserve RAM buffer [mem 0x6c572018-0x6fffffff]
> [   29.807218] e820: reserve RAM buffer [mem 0x7495e000-0x77ffffff]
> [   29.807538] e820: reserve RAM buffer [mem 0x7877f000-0x7bffffff]
> [   29.807860] e820: reserve RAM buffer [mem 0x7d000000-0x7fffffff]
> [   29.808171] e820: reserve RAM buffer [mem 0x23f380000-0x23fffffff]
> [   29.815914] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [   29.816545] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [   29.835286] clocksource: Switched to clocksource tsc-early
> [   34.928553] VFS: Disk quotas dquot_6.6.0
> [   34.948109] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [   35.035328] AppArmor: AppArmor Filesystem Enabled
> [   35.041686] pnp: PnP ACPI init
> [   35.118495] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reserved
> [   35.119509] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
> [   35.120526] system 00:00: [mem 0xa0000000-0xa00fffff] has been reserved
> [   35.121736] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   35.181981] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
> [   35.193164] pnp 00:02: Plug and Play ACPI device, IDs FUJ7401 PNP0303 (active)
> [   35.209188] system 00:03: [io  0x0400-0x04cf] has been reserved
> [   35.210159] system 00:03: [io  0x04d0-0x04d1] has been reserved
> [   35.211133] system 00:03: [io  0x04d6] has been reserved
> [   35.212069] system 00:03: [io  0x0c00-0x0c01] has been reserved
> [   35.213060] system 00:03: [io  0x0c14] has been reserved
> [   35.214122] system 00:03: [io  0x0c50-0x0c52] has been reserved
> [   35.215089] system 00:03: [io  0x0c6c] has been reserved
> [   35.216019] system 00:03: [io  0x0c6f] has been reserved
> [   35.217054] system 00:03: [io  0x0cd0-0x0cdb] has been reserved
> [   35.218240] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   35.248980] system 00:04: [mem 0x000e0000-0x000fffff] could not be reserved
> [   35.250025] system 00:04: [mem 0xfe000000-0xffffffff] could not be reserved
> [   35.251251] system 00:04: Plug and Play ACPI device, IDs PNP0c01 (active)
> [   35.703324] pnp: PnP ACPI: found 5 devices
> [   36.244872] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   36.280333] NET: Registered protocol family 2
> [   36.326627] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
> [   36.327674] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [   36.328747] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [   36.329554] TCP: Hash tables configured (established 65536 bind 65536)
> [   36.343994] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
> [   36.345026] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
> [   36.383054] NET: Registered protocol family 1
> [   36.384592] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
> [   36.385809] pci 0000:00:01.2: PCI bridge to [bus 01]
> [   36.386335] pci 0000:00:01.2:   bridge window [mem 0x80700000-0x807fffff]
> [   36.386991] pci 0000:00:01.3: PCI bridge to [bus 02]
> [   36.387517] pci 0000:00:01.3:   bridge window [mem 0x80600000-0x806fffff]
> [   36.388341] pci 0000:03:00.0: BAR 6: assigned [mem 0x805c0000-0x805fffff pref]
> [   36.389105] pci 0000:00:01.6: PCI bridge to [bus 03]
> [   36.389618] pci 0000:00:01.6:   bridge window [io  0x2000-0x2fff]
> [   36.390216] pci 0000:00:01.6:   bridge window [mem 0x80500000-0x805fffff]
> [   36.390888] pci 0000:00:08.1: PCI bridge to [bus 04]
> [   36.391404] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
> [   36.392008] pci 0000:00:08.1:   bridge window [mem 0x80000000-0x804fffff]
> [   36.392645] pci 0000:00:08.1:   bridge window [mem 0xf6e0000000-0xf6f01fffff 64bit pref]
> [   36.393427] pci 0000:00:08.2: PCI bridge to [bus 05]
> [   36.393999] pci 0000:00:08.3: PCI bridge to [bus 06]
> [   36.394560] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [   36.395152] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [   36.395749] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [   36.396371] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
> [   36.397012] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
> [   36.397641] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
> [   36.398265] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
> [   36.398896] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
> [   36.399529] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
> [   36.400162] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
> [   36.400808] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
> [   36.401442] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
> [   36.402073] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
> [   36.402706] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
> [   36.403336] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
> [   36.403967] pci_bus 0000:00: resource 19 [mem 0x80000000-0xefffffff window]
> [   36.404615] pci_bus 0000:00: resource 20 [mem 0xf8000000-0xfeafffff window]
> [   36.405246] pci_bus 0000:00: resource 21 [mem 0xfed45000-0xfed814ff window]
> [   36.405884] pci_bus 0000:00: resource 22 [mem 0xfed81900-0xfed81fff window]
> [   36.406522] pci_bus 0000:00: resource 23 [mem 0xfedc0000-0xfedc0fff window]
> [   36.407159] pci_bus 0000:00: resource 24 [mem 0xfedc6000-0xfedc6fff window]
> [   36.407796] pci_bus 0000:00: resource 25 [mem 0x2a0200000-0xf6ffffffff window]
> [   36.408529] pci_bus 0000:01: resource 1 [mem 0x80700000-0x807fffff]
> [   36.409125] pci_bus 0000:02: resource 1 [mem 0x80600000-0x806fffff]
> [   36.409722] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
> [   36.410287] pci_bus 0000:03: resource 1 [mem 0x80500000-0x805fffff]
> [   36.410886] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
> [   36.411451] pci_bus 0000:04: resource 1 [mem 0x80000000-0x804fffff]
> [   36.412048] pci_bus 0000:04: resource 2 [mem 0xf6e0000000-0xf6f01fffff 64bit pref]
> [   36.438984] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
> [   36.565740] pci 0000:04:00.4: quirk_usb_early_handoff+0x0/0x6a0 took 123044 usecs
> [   36.566608] PCI: CLS 64 bytes, default 64
> [   36.575383] Trying to unpack rootfs image as initramfs...
> [   44.594348] Initramfs unpacking failed: Decoding failed
> [   44.765141] Freeing initrd memory: 46348K
> [   44.765563] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   44.766063] software IO TLB: mapped [mem 0x00000000700c0000-0x00000000740c0000] (64MB)
> [   44.776211] amd_uncore: 4  amd_df counters detected
> [   44.782528] amd_uncore: 6  amd_l3 counters detected
> [   44.790192] LVT offset 0 assigned for vector 0x400
> [   44.805032] perf: AMD IBS detected (0x000003ff)
> [   44.812927] check: Scanning for low memory corruption every 60 seconds
> [   45.009748] Initialise system trusted keyrings
> [   45.011340] Key type blacklist registered
> [   45.016556] workingset: timestamp_bits=36 max_order=21 bucket_order=0
> [   45.792097] zbud: loaded
> [   45.812602] tsc: Refined TSC clocksource calibration: 2399.999 MHz
> [   45.813491] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2298364cab5, max_idle_ns: 440795214892 ns
> [   45.814913] clocksource: Switched to clocksource tsc
> [   46.015712] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [   46.082078] fuse: init (API version 7.33)
> [   48.209690] Key type asymmetric registered
> [   48.210112] Asymmetric key parser 'x509' registered
> [   48.212275] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [   48.218484] io scheduler mq-deadline registered
> [   48.333963] pcieport 0000:00:01.2: PME: Signaling with IRQ 25
> [   48.348018] pcieport 0000:00:01.2: AER: enabled with IRQ 25
> [   48.359083] pcieport 0000:00:01.2: DPC: enabled with IRQ 25
> [   48.359612] pcieport 0000:00:01.2: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
> [   48.387391] pcieport 0000:00:01.3: PME: Signaling with IRQ 26
> [   48.398700] pcieport 0000:00:01.3: AER: enabled with IRQ 26
> [   48.409855] pcieport 0000:00:01.3: DPC: enabled with IRQ 26
> [   48.410386] pcieport 0000:00:01.3: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
> [   48.438202] pcieport 0000:00:01.6: PME: Signaling with IRQ 27
> [   48.449512] pcieport 0000:00:01.6: AER: enabled with IRQ 27
> [   48.460554] pcieport 0000:00:01.6: DPC: enabled with IRQ 27
> [   48.461083] pcieport 0000:00:01.6: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
> [   48.488872] pcieport 0000:00:08.1: PME: Signaling with IRQ 28
> [   48.544608] pcieport 0000:00:08.2: PME: Signaling with IRQ 29
> [   48.596913] pcieport 0000:00:08.3: PME: Signaling with IRQ 30
> [   48.643731] efifb: probing for efifb
> [   48.645664] efifb: framebuffer at 0xf6e0000000, using 5120k, total 5120k
> [   48.646236] efifb: mode is 1280x1024x32, linelength=5120, pages=1
> [   48.646818] efifb: scrolling: redraw
> [   48.647177] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [   48.693813] Console: switching to colour frame buffer device 160x64
> [   48.712600] fb0: EFI VGA frame buffer device
> [   48.950402] ACPI: AC Adapter [ACAD] (on-line)
> [   48.967860] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [   48.977448] ACPI: Power Button [PWRB]
> [   48.993680] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
> [   49.003119] ACPI: Lid Switch [LID]
> [   49.018444] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [   49.026711] ACPI: Power Button [PWRF]
> [   49.040147] Monitor-Mwait will be used to enter C-1 state
> [   49.040746] ACPI: \_SB_.PLTF.C000: Found 3 idle states
> [   49.076019] ACPI: \_SB_.PLTF.C001: Found 3 idle states
> [   49.111046] ACPI: \_SB_.PLTF.C002: Found 3 idle states
> [   49.146270] ACPI: \_SB_.PLTF.C003: Found 3 idle states
> [   49.181579] ACPI: \_SB_.PLTF.C004: Found 3 idle states
> [   49.216686] ACPI: \_SB_.PLTF.C005: Found 3 idle states
> [   49.251683] ACPI: \_SB_.PLTF.C006: Found 3 idle states
> [   49.286676] ACPI: \_SB_.PLTF.C007: Found 3 idle states
> [   49.355993] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [   49.358136] battery: ACPI: Battery Slot [BATT] (battery absent)
> [   49.368227] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   50.007393] Linux agpgart interface v0.103
> [   51.790820] loop: module loaded
> [   51.878717] libphy: Fixed MDIO Bus: probed
> [   51.879250] tun: Universal TUN/TAP device driver, 1.6
> [   51.887109] PPP generic driver version 2.4.2
> [   51.897614] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   51.898791] ehci-pci: EHCI PCI platform driver
> [   51.901645] ehci-platform: EHCI generic platform driver
> [   51.904158] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   51.905212] ohci-pci: OHCI PCI platform driver
> [   51.908400] ohci-platform: OHCI generic platform driver
> [   51.910826] uhci_hcd: USB Universal Host Controller Interface driver
> [   51.940921] xhci_hcd 0000:04:00.4: xHCI Host Controller
> [   51.942860] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 1
> [   51.949371] xhci_hcd 0000:04:00.4: hcc params 0x0128ffe5 hci version 0x110 quirks 0x0000000200000410
> [   52.067036] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
> [   52.067981] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   52.068863] usb usb1: Product: xHCI Host Controller
> [   52.069529] usb usb1: Manufacturer: Linux 5.11.0-7490c004ae7e xhci-hcd
> [   52.070285] usb usb1: SerialNumber: 0000:04:00.4
> [   52.121718] hub 1-0:1.0: USB hub found
> [   52.143260] hub 1-0:1.0: 6 ports detected
> [   52.299837] xhci_hcd 0000:04:00.4: xHCI Host Controller
> [   52.320570] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 2
> [   52.340824] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperSpeed
> [   52.363486] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [   52.392918] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
> [   52.413221] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   52.433211] usb usb2: Product: xHCI Host Controller
> [   52.453144] usb usb2: Manufacturer: Linux 5.11.0-7490c004ae7e xhci-hcd
> [   52.473003] usb usb2: SerialNumber: 0000:04:00.4
> [   52.524611] hub 2-0:1.0: USB hub found
> [   52.545959] hub 2-0:1.0: 2 ports detected
> [   52.624616] usb 1-6: new high-speed USB device number 2 using xhci_hcd
> [   52.633771] i8042: PNP: PS/2 Controller [PNP0303:KBC0] at 0x60,0x64 irq 1
> [   52.653272] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [   52.683054] i8042: Warning: Keylock active
> [   52.704869] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   52.745524] mousedev: PS/2 mouse device common for all mice
> [   52.793278] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
> [   52.794725] usb 1-6: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
> [   52.808792] usb 1-6: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   52.808859] rtc_cmos 00:01: RTC can wake from S4
> [   52.816448] usb 1-6: Product: USB 2.0 Hub
> [   52.872834] hub 1-6:1.0: USB hub found
> [   52.881101] hub 1-6:1.0: 4 ports detected
> [   52.895180] rtc_cmos 00:01: registered as rtc0
> [   52.915634] rtc_cmos 00:01: setting system clock to 2021-03-09T09:56:32 UTC (1615283792)
> [   52.942083] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram, hpet irqs
> [   52.966158] i2c /dev entries driver
> [   53.006298] device-mapper: uevent: version 1.0.3
> [   53.048534] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
> [   53.074343] ledtrig-cpu: registered to indicate activity on CPUs
> [   53.096789] EFI Variables Facility v0.08 2004-May-17
> [   53.300603] usb 1-6.1: new full-speed USB device number 3 using xhci_hcd
> [   53.444711] NET: Registered protocol family 10
> [   53.549283] usb 1-6.1: New USB device found, idVendor=0b95, idProduct=6804, bcdDevice= 0.12
> [   53.558046] usb 1-6.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   53.566388] usb 1-6.1: Product: AX68004
> [   53.574558] usb 1-6.1: Manufacturer: ASIX Electronics
> [   53.582847] usb 1-6.1: SerialNumber: 00000001
> [   53.610327] Segment Routing with IPv6
> [   53.635742] NET: Registered protocol family 17
> [   53.658447] hub 1-6.1:1.0: USB hub found
> [   53.664105] Key type dns_resolver registered
> [   53.668253] hub 1-6.1:1.0: 7 ports detected
> [   53.916662] usb 1-6.4: new full-speed USB device number 4 using xhci_hcd
> [   53.946315] microcode: CPU0: patch_level=0x08900103
> [   53.955483] microcode: CPU1: patch_level=0x08900103
> [   53.965080] microcode: CPU2: patch_level=0x08900103
> [   53.973919] microcode: CPU3: patch_level=0x08900103
> [   53.982410] microcode: CPU4: patch_level=0x08900103
> [   53.990532] microcode: CPU5: patch_level=0x08900103
> [   54.011626] microcode: CPU6: patch_level=0x08900103
> [   54.019879] microcode: CPU7: patch_level=0x08900103
> [   54.035199] microcode: Microcode Update Driver: v2.2.
> [   54.035331] IPI shorthand broadcast: enabled
> [   54.079090] sched_clock: Marking stable (54046365506, 30131209)->(54079268378, -2771663)
> [   54.111824] registered taskstats version 1
> [   54.135117] Loading compiled-in X.509 certificates
> [   54.146211] usb 1-6.4: New USB device found, idVendor=1a86, idProduct=7523, bcdDevice= 2.64
> [   54.163143] usb 1-6.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [   54.171304] usb 1-6.4: Product: USB Serial
> [   54.194473] Loaded X.509 cert 'Build time autogenerated kernel key: dbcbf20b6db11cace3e8c1706a7d7af9eab0838a'
> [   54.216619] usb 1-6.1.1: new full-speed USB device number 5 using xhci_hcd
> [   54.279605] zswap: loaded using pool lzo/zbud
> [   54.316898] kmemleak: Automatic memory scanning thread started
> [   54.316878] kmemleak: Kernel memory leak detector initialized (mem pool available: 15125)
> [   54.353527] Key type ._fscrypt registered
> [   54.375466] usb 1-6.1.1: New USB device found, idVendor=046d, idProduct=c534, bcdDevice=29.01
> [   54.376973] Key type .fscrypt registered
> [   54.398297] usb 1-6.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   54.421576] Key type fscrypt-provisioning registered
> [   54.443108] usb 1-6.1.1: Product: USB Receiver
> [   54.488776] usb 1-6.1.1: Manufacturer: Logitech
> [   54.490248] Key type encrypted registered
> [   54.534239] AppArmor: AppArmor sha1 policy hashing enabled
> [   54.558198] ima: No TPM chip found, activating TPM-bypass!
> [   54.581807] ima: Allocated hash algorithm: sha1
> [   54.607409] ima: No architecture policies found
> [   54.632983] evm: Initialising EVM extended attributes:
> [   54.656076] evm: security.selinux
> [   54.678028] evm: security.SMACK64
> [   54.699821] evm: security.SMACK64EXEC
> [   54.721547] evm: security.SMACK64TRANSMUTE
> [   54.742999] evm: security.SMACK64MMAP
> [   54.764326] evm: security.apparmor
> [   54.785553] evm: security.ima
> [   54.806619] evm: security.capability
> [   54.827660] evm: HMAC attrs: 0x1
> [   55.050373] PM:   Magic number: 13:500:929
> [   55.071161] acpi STK00034:00: hash matches
> [   55.139431] acpi_cpufreq: overriding BIOS provided _PSD data
> [   55.341705] RAS: Correctable Errors collector initialized.
> [   55.888435] Freeing unused decrypted memory: 2036K
> [   55.940524] Freeing unused kernel image (initmem) memory: 2484K
> [   55.969099] Write protecting the kernel read-only data: 22528k
> [   56.039908] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [   56.074340] Freeing unused kernel image (rodata/data gap) memory: 1164K
> [   61.208997] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   61.231719] Run /init as init process
> [   61.251507]   with arguments:
> [   61.251637]     /init
> [   61.251792]     nokaslr
> [   61.251934]   with environment:
> [   61.252075]     HOME=/
> [   61.252223]     TERM=linux
> [   61.252370]     BOOT_IMAGE=/boot/vmlinuz-5.11.0-7490c004ae7e
> [   61.856220] hid: raw HID events driver (C) Jiri Kosina
> [   61.888080] ACPI: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
> [   61.959307] acpi device:16: registered as cooling_device8
> [   61.979135] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:15/LNXVIDEO:01/input/input4
> [   62.002377] dwc3-pci 0000:04:00.3: enabling device (0000 -> 0002)
> [   62.039238] pps_core: LinuxPPS API ver. 1 registered
> [   62.049970] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [   62.064809] rtsx_pci 0000:02:00.0: enabling device (0000 -> 0002)
> [   62.082367] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [   62.091350] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
> [   62.121079] usbcore: registered new interface driver usbhid
> [   62.121416] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> [   62.132863] usbhid: USB HID core driver
> [   62.232843] nvme nvme0: pci function 0000:01:00.0
> [   62.276181] PTP clock support registered
> [   62.305884] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.0/0003:046D:C534.0001/input/input5
> [   62.374657] hid-generic 0003:046D:C534.0001: input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:04:00.4-6.1.1/input0
> [   62.386164] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/input/input6
> [   62.403095] nvme nvme0: missing or invalid SUBNQN field.
> [   62.408777] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/input/input7
> [   62.442952] nvme nvme0: Shutdown timeout set to 8 seconds
> [   62.484441] e1000e: Intel(R) PRO/1000 Network Driver
> [   62.494619] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   62.504780] e1000e 0000:03:00.0: enabling device (0000 -> 0002)
> [   62.510246] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/input/input8
> [   62.523073] e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   62.541681] hid-generic 0003:046D:C534.0002: input,hiddev0,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:04:00.4-6.1.1/input1
> [   62.564847] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
> [   62.577132] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 3
> [   62.589323] xhci-hcd xhci-hcd.2.auto: hcc params 0x0110ffe5 hci version 0x110 quirks 0x0000000000010010
> [   62.598823] e1000e 0000:03:00.0 0000:03:00.0 (uninitialized): registered PHC clock
> [   62.600583] xhci-hcd xhci-hcd.2.auto: irq 40, io mem 0x80000000
> [   62.623436] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
> [   62.635901] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   62.648103] usb usb3: Product: xHCI Host Controller
> [   62.660409] usb usb3: Manufacturer: Linux 5.11.0-7490c004ae7e xhci-hcd
> [   62.667913] e1000e 0000:03:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 6c:b3:11:0f:44:ad
> [   62.672744] usb usb3: SerialNumber: xhci-hcd.2.auto
> [   62.677121] hub 3-0:1.0: USB hub found
> [   62.684959] e1000e 0000:03:00.0 eth0: Intel(R) PRO/1000 Network Connection
> [   62.697039] hub 3-0:1.0: 1 port detected
> [   62.708806] e1000e 0000:03:00.0 eth0: MAC: 3, PHY: 8, PBA No: E42641-005
> [   62.722389] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
> [   62.751242] e1000e 0000:03:00.0 eno1: renamed from eth0
> [   62.759973] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 4
> [   62.784717] xhci-hcd xhci-hcd.2.auto: Host supports USB 3.1 Enhanced SuperSpeed
> [   62.798323] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [   62.810764] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
> [   62.822098] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   62.828185] nvme nvme0: 16/0/0 default/read/poll queues
> [   62.833492] usb usb4: Product: xHCI Host Controller
> [   62.833498] usb usb4: Manufacturer: Linux 5.11.0-7490c004ae7e xhci-hcd
> [   62.833500] usb usb4: SerialNumber: xhci-hcd.2.auto
> [   62.837027] hub 4-0:1.0: USB hub found
> [   62.909305] hub 4-0:1.0: 1 port detected
> [   63.031972] logitech-djreceiver 0003:046D:C534.0001: hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:04:00.4-6.1.1/input0
> [   63.050794]  nvme0n1: p1 p2 p3
> [   63.099868] random: fast init done
> [   63.300016] logitech-djreceiver 0003:046D:C534.0002: hiddev0,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:04:00.4-6.1.1/input1
> [   63.386444] logitech-djreceiver 0003:046D:C534.0002: device of type eQUAD nano Lite (0x0a) connected on slot 1
> [   63.399889] input: Logitech Wireless Keyboard PID:4023 Keyboard as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/0003:046D:4023.0003/input/input11
> [   63.425410] logitech-djreceiver 0003:046D:C534.0002: device of type eQUAD nano Lite (0x0a) connected on slot 2
> [   63.439666] input: Logitech Wireless Keyboard PID:4023 Consumer Control as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/0003:046D:4023.0003/input/input12
> [   63.467167] input: Logitech Wireless Keyboard PID:4023 System Control as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/0003:046D:4023.0003/input/input13
> [   63.501551] hid-generic 0003:046D:4023.0003: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Keyboard PID:4023] on usb-0000:04:00.4-6.1.1/input1:1
> [   63.515821] input: Logitech Wireless Mouse PID:4054 Mouse as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/0003:046D:4054.0004/input/input18
> [   63.546342] hid-generic 0003:046D:4054.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech Wireless Mouse PID:4054] on usb-0000:04:00.4-6.1.1/input1:2
> [   65.032580] logitech-hidpp-device 0003:046D:4023.0003: HID++ 2.0 device connected.
> [   66.861517] input: Logitech Wireless Keyboard PID:4023 as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/0003:046D:4023.0003/input/input22
> [   66.897595] logitech-hidpp-device 0003:046D:4023.0003: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Keyboard PID:4023] on usb-0000:04:00.4-6.1.1/input1:1
> [   67.026724] input: Logitech Wireless Mouse as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb1/1-6/1-6.1/1-6.1.1/1-6.1.1:1.1/0003:046D:C534.0002/0003:046D:4054.0004/input/input23
> [   67.065173] logitech-hidpp-device 0003:046D:4054.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech Wireless Mouse] on usb-0000:04:00.4-6.1.1/input1:2
> [   67.803566] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [   72.903702] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> [   74.381038] systemd[1]: Inserted module 'autofs4'
> [   76.754611] systemd[1]: systemd 245.4-4ubuntu3.2 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [   76.872587] systemd[1]: Detected architecture x86-64.
> [   77.625608] systemd[1]: Set hostname to <scbu-Chachani>.
> [   80.353431] systemd[1]: /lib/systemd/system/dbus.socket:5: ListenStream= references a path below legacy directory /var/run/, updating /var/run/dbus/system_bus_socket → /run/dbus/system_bus_socket; please update the unit file accordingly.
> [   82.552892] systemd[1]: Created slice system-modprobe.slice.
> [   82.788950] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [   83.015834] systemd[1]: Created slice User and Session Slice.
> [   83.128137] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   83.275007] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [   83.382905] systemd[1]: Reached target User and Group Name Lookups.
> [   83.487113] systemd[1]: Reached target Remote File Systems.
> [   83.591400] systemd[1]: Reached target Slices.
> [   83.709971] systemd[1]: Listening on Syslog Socket.
> [   83.826474] systemd[1]: Listening on fsck to fsckd communication Socket.
> [   83.936934] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [   84.062844] systemd[1]: Listening on Journal Audit Socket.
> [   84.177872] systemd[1]: Listening on Journal Socket (/dev/log).
> [   84.295185] systemd[1]: Listening on Journal Socket.
> [   84.409567] systemd[1]: Listening on udev Control Socket.
> [   84.517738] systemd[1]: Listening on udev Kernel Socket.
> [   85.019421] systemd[1]: Mounting Huge Pages File System...
> [   85.386033] systemd[1]: Mounting POSIX Message Queue File System...
> [   85.755988] systemd[1]: Mounting Kernel Debug File System...
> [   86.124942] systemd[1]: Mounting Kernel Trace File System...
> [   86.559129] systemd[1]: Starting Journal Service...
> [   86.932746] systemd[1]: Starting Set the console keyboard layout...
> [   87.570562] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [   87.915311] systemd[1]: Starting Load Kernel Module drm...
> [   88.021354] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [   88.056239] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
> [   88.372381] systemd[1]: Starting Load Kernel Modules...
> [   88.415451] lp: driver loaded but no devices found
> [   88.422760] ppdev: user-space parallel port driver
> [   88.798562] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   88.814129] EXT4-fs (nvme0n1p3): re-mounted. Opts: errors=remount-ro. Quota mode: none.
> [   89.161086] systemd[1]: Starting udev Coldplug all Devices...
> [   89.513616] systemd[1]: Starting Uncomplicated firewall...
> [   89.721739] systemd[1]: Started Journal Service.
> [   92.172886] systemd-journald[296]: Received client request to flush runtime journal.
> [   94.180700] random: crng init done
> [   94.977263] loop0: detected capacity change from 113424 to 0
> [   95.318120] loop1: detected capacity change from 113592 to 0
> [   95.671148] loop2: detected capacity change from 446248 to 0
> [   96.027039] loop3: detected capacity change from 448496 to 0
> [   96.399907] loop4: detected capacity change from 127160 to 0
> [   96.754497] loop5: detected capacity change from 132648 to 0
> [   97.084115] loop6: detected capacity change from 104496 to 0
> [   97.436738] loop7: detected capacity change from 104536 to 0
> [   97.846291] loop8: detected capacity change from 63664 to 0
> [   98.259944] loop9: detected capacity change from 66104 to 0
> [   99.556164] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [   99.556167] AMD-Vi: AMD IOMMUv2 functionality not available on this system
> [   99.771529] usbcore: registered new interface driver usbserial_generic
> [   99.771584] usbserial: USB Serial support registered for generic
> [   99.795261] usbcore: registered new interface driver ch341
> [   99.795359] usbserial: USB Serial support registered for ch341-uart
> [   99.795421] ch341 1-6.4:1.0: ch341-uart converter detected
> [   99.842472] pstore: Using crash dump compression: deflate
> [   99.842529] pstore: Registered efi as persistent store backend
> [   99.854877] usb 1-6.4: ch341-uart converter now attached to ttyUSB0
> [   99.863142] [drm] amdgpu kernel modesetting enabled.
> [   99.865063] amdgpu: Virtual CRAT table created for CPU
> [   99.865336] amdgpu: Topology: Add CPU node
> [   99.865875] checking generic (f6e0000000 500000) vs hw (f6e0000000 10000000)
> [   99.865879] fb0: switching to amdgpudrmfb from EFI VGA
> [   99.924145] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
> [   99.924156] RAPL PMU: hw unit of domain package 2^-16 Joules
> [   99.927595] Console: switching to colour dummy device 80x25
> [   99.928030] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
> [   99.930017] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
> [   99.930720] [drm] initializing kernel modesetting (VANGOGH 0x1002:0x163F 0x1002:0x0123 0xAE).
> [   99.930727] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
> [   99.976436] [drm] register mmio base: 0x80400000
> [   99.976449] [drm] register mmio size: 524288
> [   99.976462] [drm] PCIE atomic ops is not supported
> [   99.983708] [drm] add ip block number 0 <nv_common>
> [   99.983714] [drm] add ip block number 1 <gmc_v10_0>
> [   99.983717] [drm] add ip block number 2 <navi10_ih>
> [   99.983718] [drm] add ip block number 3 <psp>
> [   99.983721] [drm] add ip block number 4 <smu>
> [   99.983724] [drm] add ip block number 5 <dm>
> [   99.983725] [drm] add ip block number 6 <gfx_v10_0>
> [   99.983726] [drm] add ip block number 7 <sdma_v5_2>
> [   99.983727] [drm] add ip block number 8 <vcn_v3_0>
> [   99.983731] [drm] add ip block number 9 <jpeg_v3_0>
> [   99.983800] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
> [   99.983833] amdgpu: ATOM BIOS: 113-AMDAerith-004
> [   99.983886] [drm] VCN(0) decode is enabled in VM mode
> [   99.983888] [drm] VCN(0) encode is enabled in VM mode
> [   99.984429] [drm] JPEG decode is enabled in VM mode
> [   99.984816] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> [   99.984958] amdgpu 0000:04:00.0: amdgpu: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
> [   99.984961] amdgpu 0000:04:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
> [   99.984962] amdgpu 0000:04:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
> [   99.984978] [drm] Detected VRAM RAM=1024M, BAR=1024M
> [   99.984981] [drm] RAM width 256bits DDR5
> [   99.985223] [drm] amdgpu: 1024M of VRAM memory ready
> [   99.985233] [drm] amdgpu: 3072M of GTT memory ready.
> [   99.985260] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   99.985962] [drm] PCIE GART of 512M enabled (table at 0x000000F400500000).
> [  100.034916] [drm] Loading DMUB firmware via PSP: version=0x00000000
> [  100.047953] cryptd: max_cpu_qlen set to 1000
> [  100.065682] AVX2 version of gcm_enc/dec engaged.
> [  100.065686] AES CTR mode by8 optimization enabled
> [  100.095359] [drm] use_doorbell being set to: [true]
> [  100.101223] [drm] Found VCN firmware Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 10
> [  100.101268] [drm] PSP loading VCN firmware
> [  100.224123] [drm] reserve 0xa00000 from 0xf43f400000 for PSP TMR
> [  100.332303] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
> [  100.335073] [drm] Display Core initialized with v3.2.125!
> [  100.353279] [drm] DMUB hardware initialized: version=0x03000002
> [  100.534708] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
> [  100.649058] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
> [  100.704229] kvm: Nested Virtualization enabled
> [  100.704324] SVM: kvm: Nested Paging enabled
> [  100.704327] SVM: Virtual VMLOAD VMSAVE supported
> [  100.704327] SVM: Virtual GIF supported
> [  100.711981] MCE: In-kernel MCE decoding enabled.
> [  100.735988] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
> [  100.778717] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input24
> [  100.780329] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input25
> [  100.782580] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input26
> [  100.784150] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input27
> [  100.859594] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC701: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [  100.859607] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [  100.859610] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [  100.859612] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [  100.859614] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
> [  100.859618] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [  100.859621] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x1b
> [  100.859624] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
> [  100.873822] intel_rapl_common: Found RAPL domain package
> [  100.873982] intel_rapl_common: Found RAPL domain core
> [  101.080660] [drm:dce110_edp_wait_for_hpd_ready [amdgpu]] *ERROR* dce110_edp_wait_for_hpd_ready: wait timed out!
> [  101.101954] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> [  101.868338] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input28
> [  101.870255] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input29
> [  102.016684] [drm:dce110_edp_wait_for_hpd_ready [amdgpu]] *ERROR* dce110_edp_wait_for_hpd_ready: wait timed out!
> [  102.369355] Adding 12695548k swap on /dev/nvme0n1p2.  Priority:-2 extents:1 across:12695548k SSFS
> [  102.624659] [drm:dce110_edp_wait_for_hpd_ready [amdgpu]] *ERROR* dce110_edp_wait_for_hpd_ready: wait timed out!
> [  102.685439] [drm] kiq ring mec 2 pipe 1 q 0
> [  102.694880] [drm] VCN decode and encode initialized successfully(under DPG Mode).
> [  102.695097] [drm] JPEG decode initialized successfully.
> [  102.696009] kfd kfd: Allocated 3969056 bytes on gart
> [  102.696385] amdgpu: Virtual CRAT table created for GPU
> [  102.697116] amdgpu: Topology: Add dGPU node [0x163f:0x1002]
> [  102.697124] kfd kfd: added device 1002:163f
> [  102.699235] [drm] fb mappable at 0x2407C6000
> [  102.699240] [drm] vram apper at 0x240000000
> [  102.699240] [drm] size 5242880
> [  102.699241] [drm] fb depth is 24
> [  102.699243] [drm]    pitch is 5120
> [  102.700470] fbcon: amdgpudrmfb (fb0) is primary device
> [  102.838112] Console: switching to colour frame buffer device 160x64
> [  102.858778] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [  104.270272] audit: type=1400 audit(1615283843.851:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=550 comm="apparmor_parser"
> [  104.270319] audit: type=1400 audit(1615283843.851:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=547 comm="apparmor_parser"
> [  104.271511] audit: type=1400 audit(1615283843.851:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=553 comm="apparmor_parser"
> [  104.274094] audit: type=1400 audit(1615283843.855:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=548 comm="apparmor_parser"
> [  104.275109] audit: type=1400 audit(1615283843.855:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=549 comm="apparmor_parser"
> [  104.277256] audit: type=1400 audit(1615283843.859:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=556 comm="apparmor_parser"
> [  104.277575] audit: type=1400 audit(1615283843.859:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=551 comm="apparmor_parser"
> [  104.279021] audit: type=1400 audit(1615283843.859:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=552 comm="apparmor_parser"
> [  104.279057] audit: type=1400 audit(1615283843.859:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=552 comm="apparmor_parser"
> [  104.283944] audit: type=1400 audit(1615283843.863:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=554 comm="apparmor_parser"
> [  124.588634] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0]
> [  124.588731] Modules linked in: nls_iso8859_1 fjes(-) intel_rapl_msr intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi edac_mce_amd kvm_amd ccp snd_hda_intel kvm irqbypass snd_intel_dspcfg crct10dif_pclmul snd_hda_codec snd_hda_core ghash_clmulni_intel snd_hwdep snd_pcm aesni_intel crypto_simd snd_seq_midi snd_seq_midi_event cryptd glue_helper joydev snd_rawmidi input_leds snd_seq rapl ch341 snd_seq_device usbserial amdgpu(+) serio_raw snd_timer efi_pstore snd iommu_v2 soundcore gpu_sched drm_ttm_helper ttm drm_kms_helper i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt ucsi_acpi typec_ucsi typec cm32181 industrialio mac_hid sch_fq_codel parport_pc ppdev lp parport drm ip_tables x_tables autofs4 hid_logitech_hidpp xhci_plat_hcd hid_logitech_dj e1000e dwc3 ulpi hid_generic rtsx_pci_sdmmc udc_core ptp nvme usbhid crc32_pclmul i2c_piix4 nvme_core rtsx_pci pps_core dwc3_pci i2c_hid video hid
> [  124.588818] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.11.0-7490c004ae7e #20210308
> [  124.588822] Hardware name: AMD Chachani-VN/Chachani-VN, BIOS WCH1304N 03/04/2021
> [  124.588823] RIP: 0010:finish_task_switch+0xae/0x290
> [  124.588831] Code: 50 08 48 89 df 48 c7 00 00 00 00 00 e8 4b 5f d3 00 4d 85 e4 4c 89 e0 75 e2 48 89 df c6 07 00 0f 1f 40 00 fb 66 0f 1f 44 00 00 <65> 48 8b 04 25 c0 7b 01 00 0f 1f 44 00 00 4d 85 ed 74 21 65 48 8b
> [  124.588833] RSP: 0018:ffffc900000dfe28 EFLAGS: 00000246
> [  124.588835] RAX: 0000000000000000 RBX: ffff888237c6be00 RCX: 0000000000000000
> [  124.588836] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888237c6be00
> [  124.588837] RBP: ffffc900000dfe50 R08: 0000000000000002 R09: 000000000002b680
> [  124.588838] R10: ffffc90000feb930 R11: 0000000000000000 R12: ffff888100974800
> [  124.588839] R13: 0000000000000000 R14: ffff888107543000 R15: 0000000000000002
> [  124.588840] FS:  0000000000000000(0000) GS:ffff888237c40000(0000) knlGS:0000000000000000
> [  124.588841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  124.588842] CR2: 00005647dd4d33d8 CR3: 000000010767e000 CR4: 0000000000350ee0
> [  124.588843] Call Trace:
> [  124.588846]  __schedule+0x2c1/0x830
> [  124.588850]  schedule_idle+0x22/0x40
> [  124.588854]  do_idle+0x18f/0x2b0
> [  124.588857]  cpu_startup_entry+0x1d/0x20
> [  124.588859]  start_secondary+0x11f/0x160
> [  124.588867]  secondary_startup_64_no_verify+0xb0/0xbb
> [  135.183179] irq 9: nobody cared (try booting with the "irqpoll" option)
> [  135.183254] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W    L    5.11.0-7490c004ae7e #20210308
> [  135.183257] Hardware name: AMD Chachani-VN/Chachani-VN, BIOS WCH1304N 03/04/2021
> [  135.183258] Call Trace:
> [  135.183259]  <IRQ>
> [  135.183261]  dump_stack+0x74/0x92
> [  135.183266]  __report_bad_irq+0x35/0xc0
> [  135.183271]  note_interrupt+0x24b/0x2a0
> [  135.183272]  handle_irq_event_percpu+0x54/0x80
> [  135.183276]  handle_irq_event+0x3b/0x60
> [  135.183278]  handle_fasteoi_irq+0x7c/0x130
> [  135.183279]  asm_call_irq_on_stack+0x12/0x20
> [  135.183283]  </IRQ>
> [  135.183287]  common_interrupt+0xc7/0x150
> [  135.183290]  asm_common_interrupt+0x1e/0x40
> [  135.183294] RIP: 0010:finish_task_switch+0xae/0x290
> [  135.183300] Code: 50 08 48 89 df 48 c7 00 00 00 00 00 e8 4b 5f d3 00 4d 85 e4 4c 89 e0 75 e2 48 89 df c6 07 00 0f 1f 40 00 fb 66 0f 1f 44 00 00 <65> 48 8b 04 25 c0 7b 01 00 0f 1f 44 00 00 4d 85 ed 74 21 65 48 8b
> [  135.183302] RSP: 0018:ffffc900000dfe28 EFLAGS: 00000246
> [  135.183304] RAX: 0000000000000000 RBX: ffff888237c6be00 RCX: 0000000000000000
> [  135.183306] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888237c6be00
> [  135.183306] RBP: ffffc900000dfe50 R08: 0000000000000002 R09: 000000000002b680
> [  135.183307] R10: ffffc90000feb930 R11: 0000000000000000 R12: ffff888100974800
> [  135.183308] R13: 0000000000000000 R14: ffff888107543000 R15: 0000000000000002
> [  135.183310]  ? __switch_to_asm+0x36/0x70
> [  135.183314]  __schedule+0x2c1/0x830
> [  135.183317]  schedule_idle+0x22/0x40
> [  135.183318]  do_idle+0x18f/0x2b0
> [  135.183321]  cpu_startup_entry+0x1d/0x20
> [  135.183324]  start_secondary+0x11f/0x160
> [  135.183327]  secondary_startup_64_no_verify+0xb0/0xbb
> [  135.183330] handlers:
> [  135.183360] [<000000008388e1d9>] acpi_irq
> [  135.183405] Disabling IRQ #9
> [  135.185531] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
> [  135.185538] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> [  135.185540] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> [  135.185541] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> [  135.185543] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> [  135.185544] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> [  135.185545] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> [  135.185546] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> [  135.185548] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> [  135.185551] amdgpu 0000:04:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> [  135.185554] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
> [  135.185558] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 1
> [  135.185560] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 1
> [  135.185561] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 1
> [  135.185562] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 1
> [  136.758216] [drm] Initialized amdgpu 3.41.0 20150101 for 0000:04:00.0 on minor 0
> [  147.972000] loop10: detected capacity change from 8 to 0
> [  156.171702] kauditd_printk_skb: 25 callbacks suppressed
> [  156.171712] audit: type=1400 audit(1615283895.751:37): apparmor="DENIED" operation="capable" profile="/usr/sbin/cups-browsed" pid=832 comm="cups-browsed" capability=23  capname="sys_nice"
> [  160.206322] e1000e 0000:03:00.0 eno1: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [  160.207256] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
> [  175.036396] rfkill: input handler disabled
> 


-- 
Thanks,

David / dhildenb

