Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9283930F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhE0Oew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:34:52 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15907 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhE0Oeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1622125997; x=1653661997;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Xw6jpOdmbc21EPQMK/nYugR0NKgc021xW/xLhzqVfjU=;
  b=iPkpQQzQ8MuLUZ3Jw3kkVejaE2T/Bj4kcitzkCHZq58Udk4lSu9sz0ng
   tXtZahYr9CW7fYiO7XQNEfUleR6wnwlyk3ehgW6sZsuFSby/slPrDj6VM
   qFdAUtpswfHzdbTuOXcE6jSZwYgrB5w3sJM9WSImKXp3EjveDSeEsvz+u
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2021 07:33:17 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2021 07:33:16 -0700
Received: from [10.111.161.43] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 27 May
 2021 07:33:14 -0700
Subject: Re: Arm64 crash while reading memory sysfs
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
Date:   Thu, 27 May 2021 10:33:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK9e0LgDOfCFo6TM@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03f.na.qualcomm.com (10.85.0.47) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2021 4:56 AM, Mike Rapoport wrote:
> Let's drop memblock=debug for now and add this instead:

[    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
[    0.000000][    T0] Linux version 5.13.0-rc3-next-20210526+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #31 SMP Thu May 27 12:32:40 UTC 2021
[    0.000000][    T0] efi: EFI v2.70 by American Megatrends
[    0.000000][    T0] efi: ACPI 2.0=0x9ff5b40000 SMBIOS 3.0=0x9ff686fd98 ESRT=0x9ff1d18298 MEMRESERVE=0x9fe6dbed98
[    0.000000][    T0] esrt: Reserving ESRT space from 0x0000009ff1d18298 to 0x0000009ff1d182f8.
[    0.000000][    T0] ACPI: Early table checksum verification disabled
[    0.000000][    T0] ACPI: RSDP 0x0000009FF5B40000 000024 (v02 ALASKA)
[    0.000000][    T0] ACPI: XSDT 0x0000009FF5B40028 000094 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000][    T0] ACPI: FACP 0x0000009FF5B400C0 000114 (v06 Ampere eMAG     00000003 INTL 20190509)
[    0.000000][    T0] ACPI: DSDT 0x0000009FF5B401D8 00765A (v05 ALASKA A M I    00000001 INTL 20190509)
[    0.000000][    T0] ACPI: FIDT 0x0000009FF5B47838 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000][    T0] ACPI: DBG2 0x0000009FF5B478D8 000061 (v00 Ampere eMAG     00000000 INTL 20190509)
[    0.000000][    T0] ACPI: GTDT 0x0000009FF5B47940 000108 (v02 Ampere eMAG     00000001 INTL 20190509)
[    0.000000][    T0] ACPI: IORT 0x0000009FF5B47A48 000BCC (v00 Ampere eMAG     00000000 INTL 20190509)
[    0.000000][    T0] ACPI: MCFG 0x0000009FF5B48618 0000AC (v01 Ampere eMAG     00000001 INTL 20190509)
[    0.000000][    T0] ACPI: SSDT 0x0000009FF5B486C8 00002D (v02 Ampere eMAG     00000001 INTL 20190509)
[    0.000000][    T0] ACPI: SPMI 0x0000009FF5B486F8 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000][    T0] ACPI: APIC 0x0000009FF5B48740 000A68 (v04 Ampere eMAG     00000004      01000013)
[    0.000000][    T0] ACPI: PCCT 0x0000009FF5B491A8 0005D0 (v01 Ampere eMAG     00000003      01000013)
[    0.000000][    T0] ACPI: BERT 0x0000009FF5B49778 000030 (v01 Ampere eMAG     00000003 INTL 20190509)
[    0.000000][    T0] ACPI: HEST 0x0000009FF5B497A8 000328 (v01 Ampere eMAG     00000003 INTL 20190509)
[    0.000000][    T0] ACPI: SPCR 0x0000009FF5B49AD0 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000D)
[    0.000000][    T0] ACPI: PPTT 0x0000009FF5B49B20 000CB8 (v01 Ampere eMAG     00000003      01000013)
[    0.000000][    T0] ACPI: SPCR: console: pl011,mmio32,0x12600000,115200
[    0.000000][    T0] earlycon: pl11 at MMIO32 0x0000000012600000 (options '115200')
[    0.000000][    T0] printk: bootconsole [pl11] enabled
[    0.000000][    T0] NUMA: Failed to initialise from firmware
[    0.000000][    T0] NUMA: Faking a node at [mem 0x0000000090000000-0x0000009fffffffff]
[    0.000000][    T0] NUMA: NODE_DATA [mem 0x9ffefbabc0-0x9ffefbffff]
[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   Normal   [mem 0x0000000090000000-0x0000009fffffffff]
[    0.000000][    T0] Movable zone start for each node
[    0.000000][    T0] Early memory node ranges
[    0.000000][    T0]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
[    0.000000][    T0]   node   0: [mem 0x0000000092000000-0x00000000928fffff]
[    0.000000][    T0]   node   0: [mem 0x0000000092900000-0x00000000fffbffff]
[    0.000000][    T0]   node   0: [mem 0x00000000fffc0000-0x00000000ffffffff]
[    0.000000][    T0]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
[    0.000000][    T0]   node   0: [mem 0x0000008800000000-0x0000009ff5aeffff]
[    0.000000][    T0]   node   0: [mem 0x0000009ff5af0000-0x0000009ff5b2ffff]
[    0.000000][    T0]   node   0: [mem 0x0000009ff5b30000-0x0000009ff5baffff]
[    0.000000][    T0]   node   0: [mem 0x0000009ff5bb0000-0x0000009ff7deffff]
[    0.000000][    T0]   node   0: [mem 0x0000009ff7df0000-0x0000009ff7e5ffff]
[    0.000000][    T0]   node   0: [mem 0x0000009ff7e60000-0x0000009ff7ffffff]
[    0.000000][    T0]   node   0: [mem 0x0000009ff8000000-0x0000009fffffffff]
[    0.000000][    T0] Initmem setup node 0 [mem 0x0000000090000000-0x0000009fffffffff]
[    0.000000][    T0] kasan: KernelAddressSanitizer initialized
[    0.000000][    T0] psci: probing for conduit method from ACPI.
[    0.000000][    T0] psci: PSCIv1.0 detected in firmware.
[    0.000000][    T0] psci: Using standard PSCI v0.2 function IDs
[    0.000000][    T0] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000][    T0] psci: SMC Calling Convention v65535.65535
[    0.000000][    T0] ACPI: SRAT not present
[    0.000000][    T0] percpu: Embedded 10 pages/cpu s584592 r8192 d62576 u655360
[    0.000000][    T0] Detected PIPT I-cache on CPU0
[    0.000000][    T0] CPU features: detected: GIC system register CPU interface
[    0.000000][    T0] CPU features: detected: Spectre-v2
[    0.000000][    T0] CPU features: detected: Spectre-v4
[    0.000000][    T0] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 2091012
[    0.000000][    T0] Policy zone: Normal
[    0.000000][    T0] Kernel command line: BOOT_IMAGE=/vmlinuz-5.13.0-rc3-next-20210526+ root=/dev/mapper/ubuntu--vg-ubuntu--lv ro cma=1024M iommu.passthrough=1 earlycon mminit_loglevel=4
[    0.000000][    T0] Unknown command line parameters: BOOT_IMAGE=/vmlinuz-5.13.0-rc3-next-20210526+ cma=1024M mminit_loglevel=4
[    0.000000][    T0] Dentry cache hash table entries: 8388608 (order: 10, 67108864 bytes, linear)
[    0.000000][    T0] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes, linear)
[    0.000000][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000][    T0] MEMBLOCK configuration:
[    0.000000][    T0]  memory size = 0x0000001ff0000000 reserved size = 0x0000000421e33ae8
[    0.000000][    T0]  memory.cnt  = 0xc
[    0.000000][    T0]  memory[0x0]     [0x0000000090000000-0x0000000091ffffff], 0x0000000002000000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  memory[0x1]     [0x0000000092000000-0x00000000928fffff], 0x0000000000900000 bytes on node 0 flags: 0x4
[    0.000000][    T0]  memory[0x2]     [0x0000000092900000-0x00000000fffbffff], 0x000000006d6c0000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  memory[0x3]     [0x00000000fffc0000-0x00000000ffffffff], 0x0000000000040000 bytes on node 0 flags: 0x4
[    0.000000][    T0]  memory[0x4]     [0x0000000880000000-0x0000000fffffffff], 0x0000000780000000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  memory[0x5]     [0x0000008800000000-0x0000009ff5aeffff], 0x00000017f5af0000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  memory[0x6]     [0x0000009ff5af0000-0x0000009ff5b2ffff], 0x0000000000040000 bytes on node 0 flags: 0x4
[    0.000000][    T0]  memory[0x7]     [0x0000009ff5b30000-0x0000009ff5baffff], 0x0000000000080000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  memory[0x8]     [0x0000009ff5bb0000-0x0000009ff7deffff], 0x0000000002240000 bytes on node 0 flags: 0x4
[    0.000000][    T0]  memory[0x9]     [0x0000009ff7df0000-0x0000009ff7e5ffff], 0x0000000000070000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  memory[0xa]     [0x0000009ff7e60000-0x0000009ff7ffffff], 0x00000000001a0000 bytes on node 0 flags: 0x4
[    0.000000][    T0]  memory[0xb]     [0x0000009ff8000000-0x0000009fffffffff], 0x0000000008000000 bytes on node 0 flags: 0x0
[    0.000000][    T0]  reserved.cnt  = 0x16
[    0.000000][    T0]  reserved[0x0]   [0x000000088b7c0000-0x000000088fffffff], 0x0000000004840000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x1]   [0x0000009be0000000-0x0000009be07fffff], 0x0000000000800000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x2]   [0x0000009be0da0000-0x0000009be819ffff], 0x0000000007400000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x3]   [0x0000009be81c0000-0x0000009f6c800255], 0x0000000384640256 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x4]   [0x0000009f6c810000-0x0000009fe6daffff], 0x000000007a5a0000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x5]   [0x0000009fe6dbed98-0x0000009fe6dbeda7], 0x0000000000000010 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x6]   [0x0000009fe6dc0000-0x0000009ff1d0ffff], 0x000000000af50000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x7]   [0x0000009ff1d18298-0x0000009ff1d182f7], 0x0000000000000060 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x8]   [0x0000009ff1d1c600-0x0000009ff1d1c61f], 0x0000000000000020 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x9]   [0x0000009ff1d1c640-0x0000009ff1d1ce47], 0x0000000000000808 bytes flags: 0x0
[    0.000000][    T0]  reserved[0xa]   [0x0000009ff1d1ce80-0x0000009ff1d1d70f], 0x0000000000000890 bytes flags: 0x0
[    0.000000][    T0]  reserved[0xb]   [0x0000009ff1d1d740-0x0000009ff1d1e787], 0x0000000000001048 bytes flags: 0x0
[    0.000000][    T0]  reserved[0xc]   [0x0000009ff1d1e7c0-0x0000009ff1d1f84f], 0x0000000000001090 bytes flags: 0x0
[    0.000000][    T0]  reserved[0xd]   [0x0000009ff1d1f880-0x0000009ff1d1fb1f], 0x00000000000002a0 bytes flags: 0x0
[    0.000000][    T0]  reserved[0xe]   [0x0000009ff1d1fb40-0x0000009ff1d1fcc7], 0x0000000000000188 bytes flags: 0x0
[    0.000000][    T0]  reserved[0xf]   [0x0000009ff1d1fd00-0x0000009ff5aeffff], 0x0000000003dd0300 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x10]  [0x0000009ff5b30000-0x0000009ff5baffff], 0x0000000000080000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x11]  [0x0000009ff7df0000-0x0000009ff7e5ffff], 0x0000000000070000 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x12]  [0x0000009ff8000000-0x0000009ffefa0007], 0x0000000006fa0008 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x13]  [0x0000009ffefa0040-0x0000009ffefa00d0], 0x0000000000000091 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x14]  [0x0000009ffefa0100-0x0000009ffefa0190], 0x0000000000000091 bytes flags: 0x0
[    0.000000][    T0]  reserved[0x15]  [0x0000009ffefa01c0-0x0000009fffffffff], 0x000000000105fe40 bytes flags: 0x0
[    0.000000][    T0] Memory: 777216K/133955584K available (17984K kernel code, 118722K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)

> Sorry, I've missed that the BUG is apparently triggered for pfn + i. Can
> you please try this instead:

[  259.216661][ T1417] test_pages_in_a_zone: pfn 8000 is not valid
[  259.226547][ T1417] page:00000000f4aa8c5c is uninitialized and poisoned
[  259.226560][ T1417] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
