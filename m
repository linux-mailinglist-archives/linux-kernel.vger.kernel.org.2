Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976683874A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347723AbhERJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:07:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4727 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347059AbhERJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:07:13 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fkql536JvzmjLv;
        Tue, 18 May 2021 17:02:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 17:05:53 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 10:05:51 +0100
Subject: Re: REGRESSION: kernel BUG at arch/arm64/kernel/alternative.c:157!
To:     Will Deacon <will@kernel.org>, John Stultz <john.stultz@linaro.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        "Amit Pundir" <amit.pundir@linaro.org>
References: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
 <20210518084900.GA7412@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8b0511de-1418-6d01-42cc-cc721c8e6ff6@huawei.com>
Date:   Tue, 18 May 2021 10:04:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210518084900.GA7412@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 09:49, Will Deacon wrote:
> Hi John,
> 
> On Mon, May 17, 2021 at 02:52:59PM -0700, John Stultz wrote:
>> With v5.13-rc2, I've been seeing an odd boot regression with the
>> DragonBoard 845c:
>>
>> Unfortunately, trying to bisect it down (v5.13-rc1 works ok) is giving
>> me inconsistent results so far. It feels a bit like maybe some config
>> option gets enabled moving forward, and then sticks around when we go
>> back.  I'll take another swing at bisecting it later today, but I have
>> to move on to some other work right now, so I figured I'd share (with
>> folks who better know the recent __apply_alternatives changes) in case
>> folks have a better idea:
> 
> Please can you try reverting af44068c581c and 0c6c2d3615ef?
> 
> Thanks,
> 
> Will
> 

I saw a crash yesterday evening on my Huawei D05 and D06, but it went 
away with a clean build...

Here's my draft mail:

I just noticed this this evening on my Huawei D06 and did not see same 
or similar reported elsewhere:

[    0.000000] Booting Linux on physical CPU 0x0000080000 [0x481fd010]
[    0.000000] Linux version 5.13.0-rc2 (john@htsatcamb-server) 
(aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 
8.3-2019.03 (arm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain for the 
A-profile Arc
hitecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321) #260 SMP PREEMPT 
Mon May 17 19:58:51 BST 2021
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: ACPI 2.0=0x2f870000 SMBIOS 3.0=0x2f7e0000 
MEMATTR=0x31ad1018 ESRT=0x31b17718 MEMRESERVE=0x2f795d18
[    0.000000] esrt: Reserving ESRT space from 0x0000000031b17718 to 
0x0000000031b17750.
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000002F870000 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x000000002F860000 0000AC (v01 HISI   HIP08 
00000000      01000013)
[    0.000000] ACPI: FACP 0x000000002F330000 000114 (v06 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: DSDT 0x000000002F0A0000 00CE0E (v02 HISI   HIP08 
00000000 INTL 20181213)
[    0.000000] ACPI: PCCT 0x000000002F850000 00008A (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SSDT 0x000000002F840000 00E56A (v02 HISI   HIP07 
00000000 INTL 20181213)
[    0.000000] ACPI: BERT 0x000000002F780000 000030 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: HEST 0x000000002F760000 00058C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: ERST 0x000000002F720000 000230 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: EINJ 0x000000002F710000 000170 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: GTDT 0x000000002F310000 00007C (v02 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SDEI 0x000000002F2F0000 000030 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: MCFG 0x000000002F0F0000 00003C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SLIT 0x000000002F0E0000 00003C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SPCR 0x000000002F0D0000 000050 (v02 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SRAT 0x000000002F0C0000 000A10 (v03 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: APIC 0x000000002F0B0000 00286C (v04 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: IORT 0x000000002F090000 001678 (v00 HISI   HIP08 
00000000 INTL 20181213)
[    0.000000] ACPI: PPTT 0x000000002E6F0000 0041D0 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SPMI 0x000000002E6E0000 000041 (v05 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SPCR: console: uart,mmio,0x3f00002f8,115200
[    0.000000] earlycon: uart0 at MMIO 0x00000003f00002f8 (options '115200')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x27ffffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x2800000000-0x2fffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x202000000000-0x2027ffffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x202800000000-0x202fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x27ffffdc00-0x27ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x2fffffdc00-0x2fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x2027ffffdc00-0x2027ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x202feffffc00-0x202ff0001fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000202fffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000000ffff]
[    0.000000]   node   0: [mem 0x0000000000010000-0x000000002f0fffff]
[    0.000000]   node   0: [mem 0x000000002f100000-0x000000002f2effff]
[    0.000000]   node   0: [mem 0x000000002f2f0000-0x000000002f2fffff]
[    0.000000]   node   0: [mem 0x000000002f300000-0x000000002f30ffff]
[    0.000000]   node   0: [mem 0x000000002f310000-0x000000002f31ffff]
[    0.000000]   node   0: [mem 0x000000002f320000-0x000000002f32ffff]
[    0.000000]   node   0: [mem 0x000000002f330000-0x000000002f33ffff]
[    0.000000]   node   0: [mem 0x000000002f340000-0x000000002f41ffff]
[    0.000000]   node   0: [mem 0x000000002f420000-0x000000002f46ffff]
[    0.000000]   node   0: [mem 0x000000002f470000-0x000000002f50ffff]
[    0.000000]   node   0: [mem 0x000000002f510000-0x000000002f52ffff]
[    0.000000]   node   0: [mem 0x000000002f530000-0x000000002f66ffff]
[    0.000000]   node   0: [mem 0x000000002f670000-0x000000002f72ffff]
[    0.000000]   node   0: [mem 0x000000002f730000-0x000000002f731fff]
[    0.000000]   node   0: [mem 0x000000002f732000-0x000000002f73ffff]
[    0.000000]   node   0: [mem 0x000000002f740000-0x000000002f740fff]
[    0.000000]   node   0: [mem 0x000000002f741000-0x000000002f74ffff]
[    0.000000]   node   0: [mem 0x000000002f750000-0x000000002f751fff]
[    0.000000]   node   0: [mem 0x000000002f752000-0x000000002f76ffff]
[    0.000000]   node   0: [mem 0x000000002f770000-0x000000002f771fff]
[    0.000000]   node   0: [mem 0x000000002f772000-0x000000002f78ffff]
[    0.000000]   node   0: [mem 0x000000002f790000-0x000000002f790fff]
[    0.000000]   node   0: [mem 0x000000002f791000-0x000000002f7cffff]
[    0.000000]   node   0: [mem 0x000000002f7d0000-0x000000002f7f0fff]
[    0.000000]   node   0: [mem 0x000000002f7f1000-0x000000002f87ffff]
[    0.000000]   node   0: [mem 0x000000002f880000-0x000000002fb1ffff]
[    0.000000]   node   0: [mem 0x000000002fb20000-0x000000003eecffff]
[    0.000000]   node   0: [mem 0x000000003eed0000-0x000000003eefffff]
[    0.000000]   node   0: [mem 0x000000003ef00000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000043ffffff]
[    0.000000]   node   0: [mem 0x0000000044030000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000050000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000027ffffffff]
[    0.000000]   node   1: [mem 0x0000002800000000-0x0000002fffffffff]
[    0.000000]   node   2: [mem 0x0000202000000000-0x00002027ffffffff]
[    0.000000]   node   3: [mem 0x0000202800000000-0x0000202fffffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x00000027ffffffff]
[    0.000000] Initmem setup node 1 [mem 
0x0000002800000000-0x0000002fffffffff]
[    0.000000] Initmem setup node 2 [mem 
0x0000202000000000-0x00002027ffffffff]
[    0.000000] Initmem setup node 3 [mem 
0x0000202800000000-0x0000202fffffffff]
[    0.000000] cma: Reserved 32 MiB at 0x000000007e000000
[    0.000000] crashkernel reserved: 0x0000000002000000 - 
0x0000000012000000 (256 MB)
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x80000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x80100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x80200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x80300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x90000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x90100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x90200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x90300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xa0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xa0100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xa0200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xa0300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xb0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xb0100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xb0200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xb0300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xc0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xc0100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xc0200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xc0300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xd0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xd0100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xd0200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xd0300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xe0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xe0100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xe0200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xe0300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xf0000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xf0100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xf0200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xf0300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x180000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x180100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x180200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x180300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x190000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x190100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x190200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x190300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1a0000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1a0100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1a0200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1a0300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1b0000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1b0100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1b0200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1b0300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1c0000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1c0100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1c0200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1c0300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1d0000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1d0100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1d0200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1d0300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1e0000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1e0100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1e0200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1e0300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1f0000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1f0100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1f0200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x1f0300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x280000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x280100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x280200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x280300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x290000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x290100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x290200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x290300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2a0000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2a0100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2a0200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2a0300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2b0000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2b0100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2b0200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2b0300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2c0000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2c0100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2c0200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2c0300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2d0000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2d0100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2d0200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2d0300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2e0000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2e0100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2e0200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2e0300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2f0000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2f0100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2f0200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x2f0300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x380000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x380100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x380200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x380300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x390000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x390100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x390200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x390300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3a0000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3a0100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3a0200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3a0300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3b0000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3b0100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3b0200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3b0300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3c0000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3c0100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3c0200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3c0300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3d0000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3d0100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3d0200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3d0300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3e0000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3e0100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3e0200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3e0300 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3f0000 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3f0100 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3f0200 -> Node 3
[    0.000000] ACPI: NUMA: SRAT: PXM 3 -> MPIDR 0x3f0300 -> Node 3
000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] alternatives: patching kernel code
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 
33029088
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init 
crashkernel=256M@32M console=ttyAMA0,115200 earlycon acpi=force 
pcie_aspm=off noinitrd root=/dev/sda2 rw log_buf_len=16M user_debug=1 iommu
.strict=0 nvme.use_threaded_interrupts=1 irqchip.gicv3_pseudo_nmi=1
[    0.000000] PCIe ASPM is disabled
[    0.000000] printk: log_buf_len: 16777216 bytes
[    0.000000] printk: early log buf free: 112920(86%)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 
0x000000007a000000-0x000000007e000000] (64MB)
[    0.000000] Memory: 131103648K/134213440K available (14592K kernel 
code, 3038K rwdata, 8012K rodata, 6080K init, 500K bss, 3077024K 
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128, Nodes=4
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to 
nr_cpu_ids=128.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, 
nr_cpu_ids=128
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 640 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: GICv4 features: DirectLPI
[    0.000000] GICv3: CPU0: found redistributor 80000 region 
0:0x00000000ae100000
[    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
[    0.000000] SRAT: PXM 2 -> ITS 1 -> Node 2
[    0.000000] ITS [mem 0x202100000-0x20211ffff]
[    0.000000] ITS@0x0000000202100000: Using ITS number 0
[    0.000000] ITS@0x0000000202100000: allocated 65536 Devices 
@2080280000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x0000000202100000: allocated 65536 Virtual CPUs 
@2080300000 (flat, esz 16, psz 4K, shr 1)
[    0.000000] ITS@0x0000000202100000: allocated 256 Interrupt 
Collections @208026b000 (flat, esz 16, psz 4K, shr 1)
[    0.000000] ITS [mem 0x200202100000-0x20020211ffff]
[    0.000000] ITS@0x0000200202100000: Using ITS number 1
[    0.000000] ITS@0x0000200202100000: allocated 65536 Devices 
@202000080000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x0000200202100000: allocated 65536 Virtual CPUs 
@202000100000 (flat, esz 16, psz 4K, shr 1)
[    0.000000] ITS@0x0000200202100000: allocated 256 Interrupt 
Collections @202000002000 (flat, esz 16, psz 4K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000002080800000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv3: CPU0: using allocated LPI pending table 
@0x0000002080820000
[    0.000000] random: get_random_bytes called from 
start_kernel+0x350/0x538 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000000] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns
[    0.009117] Console: colour dummy device 80x25
[    0.014107] mempolicy: Enabling automatic NUMA balancing. Configure 
with numa_balancing= or the kernel.numa_balancing sysctl
[    0.026557] ACPI: Core revision 20210331
[    0.031087] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.042656] pid_max: default: 131072 minimum: 1024
[    0.048014] LSM: Security Framework initializing
[    0.063347] Dentry cache hash table entries: 8388608 (order: 14, 
67108864 bytes, vmalloc)
[    0.077708] Inode-cache hash table entries: 4194304 (order: 13, 
33554432 bytes, vmalloc)
[    0.086871] Mount-cache hash table entries: 131072 (order: 8, 1048576 
bytes, vmalloc)
[    0.095713] Mountpoint-cache hash table entries: 131072 (order: 8, 
1048576 bytes, vmalloc)
645] Platform MSI: ITS@0x200202100000 domain created
[    0.125919] PCI/MSI: ITS@0x202100000 domain created
[    0.131424] PCI/MSI: ITS@0x200202100000 domain created
[    0.137120] fsl-mc MSI: ITS@0x202100000 domain created
[    0.142816] fsl-mc MSI: ITS@0x200202100000 domain created
[    0.148809] Remapping and enabling EFI services.
[    0.154135] efi: memattr: Entry attributes invalid: RO and XP bits 
both cleared
[    0.162239] efi: memattr: ! 0x000000000000-0x00000000ffff [Runtime 
Code|RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ]
[    0.175264] smp: Bringing up secondary CPUs ...
[    0.180420] Detected VIPT I-cache on CPU1
[    0.180428] GICv3: CPU1: found redistributor 80100 region 
1:0x00000000ae140000
[    0.180438] GICv3: CPU1: using allocated LPI pending table 
@0x0000002080830000
[    0.180477] CPU1: Booted secondary processor 0x0000080100 [0x481fd010]
[    0.181300] Insufficient stack space to handle exception!
[    0.181301] ESR: 0x96000044 -- DABT (current EL)
[    0.181302] FAR: 0x0000000000000100
[    0.181303] Task stack:     [0xffff8000125b0000..0xffff8000125b4000]
[    0.181303] IRQ stack:      [0xffff800010008000..0xffff80001000c000]
[    0.181304] Overflow stack: [0xffff0027dfb372b0..0xffff0027dfb382b0]
[    0.181305] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-rc2 #260
[    0.181306] pstate: 400003c9 (nZcv DAIF -PAN -UAO -TCO BTYPE=--)
[    0.181306] pc : el1_sync+0x0/0x100
[    0.181307] lr : el1_irq+0xb8/0x150
[    0.181308] sp : 0000000000000100
[    0.181308] x29: ffff8000125b3f10 x28: ffff0020872f8e00 x27: 
0000000000000000
[    0.181311] x26: 0000000000004000 x25: 0000000000000000 x24: 
ffff800011c29b04
[    0.181313] x23: 0000000040000009 x22: ffff800010e283c0 x21: 
ffff8000125b3f30
[    0.181314] x20: 0000000000000002 x19: ffff8000125b3de0 x18: 
0000000000000030
[    0.181316] x17: 000c0400bb44ffff x16: 004000b5b5503510 x15: 
ffffffffffffffff
[    0.181318] x14: ffff800011c29948 x13: ffff202fceb259a6 x12: 
ffff202fceb2599b
[    0.181320] x11: 0000000000000040 x10: 00000000000009c0 x9 : 
ffff8000125b3ea0
[    0.181322] x8 : ffff0020872f9820 x7 : 0000000000000000 x6 : 
ffff0020872f8e00
[    0.181323] x5 : ffff0027dfb448c0 x4 : ffff0027dfb449e0 x3 : 
0000000000000000
[    0.181325] x2 : 0000000000000006 x1 : ffff8000104c5058 x0 : 
ffff8000125b3de0
[    0.181327] Kernel panic - not syncing: kernel stack overflow
[    0.181327] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-rc2 #260
[    0.181328] Call trace:
[    0.181329]  dump_backtrace+0x0/0x1b0
[    0.181376] SMP: stopping secondary CPUs

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
> 

