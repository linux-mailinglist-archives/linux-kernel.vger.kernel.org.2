Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F3441ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhKAQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:52:10 -0400
Received: from smtpq2.tb.ukmail.iss.as9143.net ([212.54.57.97]:36124 "EHLO
        smtpq2.tb.ukmail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhKAQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:52:09 -0400
Received: from [212.54.57.111] (helo=csmtp7.tb.ukmail.iss.as9143.net)
        by smtpq2.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1mhaV4-0002Nk-Dv
        for linux-kernel@vger.kernel.org; Mon, 01 Nov 2021 17:49:34 +0100
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id haV4m52e3ufb4haV4mcQ1I; Mon, 01 Nov 2021 17:49:34 +0100
X-Originating-IP: [81.97.236.130]
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=FOAIesks c=1 sm=1 tr=0 ts=61801a9e cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=vIxV3rELxO4A:10 a=NLZqzBF-AAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8
 a=8EzCPyvk55XG-KLq250A:9 a=QEXdDO2ut3YA:10 a=EhREHt0NWk05MfjoEe8A:9
 a=GzpgQ729mgL5Z3cG:21 a=CjuIK1q_8ugA:10 a=wW_WBVUImv98JQXhvVPZ:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1635785374;
        bh=o4Fjp5ofoQ34/FdKfLCAC88GZR2xaa8Br1OV9aFAtZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j/gfwQe0LWfioBZEIUAV4THkNPDgDXPPqxBfe2HUbYA3r4xi/yOCGI9SBh4QCgi15
         PiAiFqilVVaf/owf31+CZ5tU4juWfQZQ11tbxac7jw4OhYfQZ05jhtCSKI+osjmhBU
         M2BKbU/dv23GB2l0lCkaL0MiLLSjswdDBPxwKujKB688KrrPltf8s/PiQEw1JunHy5
         FHVedfZTiYLeW1nBl6eE8ScYHuwZ2CHRsCU5/qQOxI7WD2fxSPYLql+OEwIvRqLMZx
         6V9b2xOUKFq+BS6S2T3n1bnTk/ebqiN0sXj4T667yYlwYF2JxC8f+OQQC0Zunc54EO
         RWKs3pqHcJKvA==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 6C7B460C4A; Mon,  1 Nov 2021 16:49:33 +0000 (GMT)
Date:   Mon, 1 Nov 2021 16:49:33 +0000
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     "Zhu, James" <James.Zhu@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: amdgpu hang on picasso
Message-ID: <YYAandieODqdEuXe@llamedos.localdomain>
References: <YX2UbO4jlKZqUBWd@llamedos.localdomain>
 <DM5PR12MB18844749E4B5A6F0604A4F85E48A9@DM5PR12MB1884.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JxzpfejiTv9OLo93"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB18844749E4B5A6F0604A4F85E48A9@DM5PR12MB1884.namprd12.prod.outlook.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
X-CMAE-Envelope: MS4xfI4T6A4ZfSn39CouqTSQUkcV8Bg4K/Wc6KUggPzKVSio/D4nwoyuHy1NjLGkZWVxu+ryurKhxnWoUi2UVppUALW1yWI8yAA+xnNuAIWYIYDuAJO2/gms
 Lm1l2yDucjJYIN8SIfVe32CL3UTzSAGZSd6cJv5iCxGzeW9ZRlKg2r/9df9WsxjKfAQLlGrndI6k654lNGxzG6UVf/8hZc5HdGe3S60WXOoWBnsyJL1Ky+JK
 PIzP6frIYmvw3ZzK4KjXQL03BJkUgkxqOlstc5Nam4GJ5pc8qEqTdt0Xe89m0PakoQVc94ANwmUlDwOLIZCSgMtt0FclVwdztyhIcujouNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JxzpfejiTv9OLo93
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit

On Mon, Nov 01, 2021 at 03:20:43PM +0000, Zhu, James wrote:
> [AMD Official Use Only]
> 
> Hi Ken
> 
> can you share the entire dmesg log?
> 
> 
> Thanks & Best Regards!
> 
> 
> James Zhu
> 

I'm attaching it - booted vanilla rc7, saved dmesg, then ran startx
and did an emergency sync.  At that point I tried to change to a
different tty, and to my surprise managed that by some sort of
random hit ctrl-alt-Fn sequence (i.e. it didn't work at first, then
the screen blanked and I got to a tty login prompt.

So here's the second version with some more messages at the end.

ĸen
> ________________________________
> From: Ken Moffat <zarniwhoop@ntlworld.com>
> Sent: Saturday, October 30, 2021 2:52 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: amdgpu hang on picasso
> 
> When I tried 5.15-rc7 on my picasso APU (Ryzen 5 3400G), trying to
> run 'startx' (I'm using X11 and logging in to a tty) the output
> messages from X11 stopped after a few lines (normally, the desktop
> shows before I can read anything) and keyboard/mouse were
> inoperative - had to use Magic SysRQ to sync and reboot.
> 
> The log showed
> Oct 28 03:02:21 deluxe klogd: [   31.347235] amdgpu 0000:09:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
> Oct 28 03:02:34 deluxe klogd: [   44.280185] amdgpu 0000:09:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
> 
> I started bisecting after confireming that linus' tree with head at
> f25a5481af12 still showed the problem.  That identified the
> following commit, which reverts cleanly and allows Xorg to start:
> 
> commit 714d9e4574d54596973ee3b0624ee4a16264d700
> Author: Yifan Zhang <yifan1.zhang@amd.com>
> Date:   Tue Sep 28 15:42:35 2021 +0800
> 
>     drm/amdgpu: init iommu after amdkfd device init
> 
>     This patch is to fix clinfo failure in Raven/Picasso:
> 
>     Number of platforms: 1
>       Platform Profile: FULL_PROFILE
>       Platform Version: OpenCL 2.2 AMD-APP (3364.0)
>       Platform Name: AMD Accelerated Parallel Processing
>       Platform Vendor: Advanced Micro Devices, Inc.
>       Platform Extensions: cl_khr_icd cl_amd_event_callback
> 
>       Platform Name: AMD Accelerated Parallel Processing Number of devices: 0
> 
>     Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>     Reviewed-by: James Zhu <James.Zhu@amd.com>
>     Tested-by: James Zhu <James.Zhu@amd.com>
>     Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> I've got a laptop with raven, I'll try to find time to test it that
> also shows he problem in the next few days.
> 
> ĸen

-- 
Vetinari smiled. "Can you keep a secret, Mister Lipwig?"
"Oh, yes, sir. I've kept lots."
"Capital. And the point is, so can I. You do not need to know.”

--JxzpfejiTv9OLo93
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.picasso"

[    0.000000] Linux version 5.15.0-rc7 (ken@deluxe) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.37) #1 SMP PREEMPT Thu Oct 28 02:53:44 BST 2021
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.15.0-rc7-sda11 root=/dev/sda11 ro resume=/dev/sda13
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009dfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20b000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000005b608fff] usable
[    0.000000] BIOS-e820: [mem 0x000000005b609000-0x000000005b759fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005b75a000-0x000000005b8dbfff] usable
[    0.000000] BIOS-e820: [mem 0x000000005b8dc000-0x000000005bcf0fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005bcf1000-0x000000005cc07fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005cc08000-0x000000005effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000005f000000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000081f33ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.2.1 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. A320M-S2H V2/A320M-S2H V2-CF, BIOS F31 04/15/2019
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x81f340 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0x5f000 max_arch_pfn = 0x400000000
[    0.000000] Using GB pages for direct mapping
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05A0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000005BC6D0A0 0000C4 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000005BC73688 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000005BC6D200 006488 (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x000000005BCD9E00 000040
[    0.000000] ACPI: APIC 0x000000005BC737A0 00015E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000005BC73900 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x000000005BC73948 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000005BC739E8 000094 (v02 ALASKA A M I    01072009 AMI  01072009)
[    0.000000] ACPI: SSDT 0x000000005BC73A80 005419 (v02 ALASKA A M I    00000002 MSFT 02000002)
[    0.000000] ACPI: SSDT 0x000000005BC78EA0 003096 (v01 ALASKA A M I    00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x000000005BC7BF38 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x000000005BC7BF78 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x000000005BC7BFB0 000042 (v01 ALASKA A M I    00000002      01000013)
[    0.000000] ACPI: IVRS 0x000000005BC7BFF8 0000D0 (v02 ALASKA A M I    00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x000000005BC7C0C8 00119C (v01 ALASKA A M I    00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x000000005BC7D268 000810 (v01 ALASKA A M I    00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x000000005BC7DA78 000029 (v01 ALASKA A M I    00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000005BC7DAA8 000C34 (v01 ALASKA A M I    00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000005BC7E6E0 0010AC (v01 ALASKA A M I    00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000005BC7F790 001CE5 (v01 ALASKA A M I    00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000005BC81478 0000BF (v01 ALASKA A M I    00001000 INTL 20120913)
[    0.000000] ACPI: WSMT 0x000000005BC81538 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000005BC81560 0010AF (v01 ALASKA A M I    00000001 INTL 20120913)
[    0.000000] ACPI: Reserving FACP table memory at [mem 0x5bc73688-0x5bc7379b]
[    0.000000] ACPI: Reserving DSDT table memory at [mem 0x5bc6d200-0x5bc73687]
[    0.000000] ACPI: Reserving FACS table memory at [mem 0x5bcd9e00-0x5bcd9e3f]
[    0.000000] ACPI: Reserving APIC table memory at [mem 0x5bc737a0-0x5bc738fd]
[    0.000000] ACPI: Reserving FPDT table memory at [mem 0x5bc73900-0x5bc73943]
[    0.000000] ACPI: Reserving FIDT table memory at [mem 0x5bc73948-0x5bc739e3]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc739e8-0x5bc73a7b]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc73a80-0x5bc78e98]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc78ea0-0x5bc7bf35]
[    0.000000] ACPI: Reserving MCFG table memory at [mem 0x5bc7bf38-0x5bc7bf73]
[    0.000000] ACPI: Reserving HPET table memory at [mem 0x5bc7bf78-0x5bc7bfaf]
[    0.000000] ACPI: Reserving UEFI table memory at [mem 0x5bc7bfb0-0x5bc7bff1]
[    0.000000] ACPI: Reserving IVRS table memory at [mem 0x5bc7bff8-0x5bc7c0c7]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc7c0c8-0x5bc7d263]
[    0.000000] ACPI: Reserving CRAT table memory at [mem 0x5bc7d268-0x5bc7da77]
[    0.000000] ACPI: Reserving CDIT table memory at [mem 0x5bc7da78-0x5bc7daa0]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc7daa8-0x5bc7e6db]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc7e6e0-0x5bc7f78b]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc7f790-0x5bc81474]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc81478-0x5bc81536]
[    0.000000] ACPI: Reserving WSMT table memory at [mem 0x5bc81538-0x5bc8155f]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x5bc81560-0x5bc8260e]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000081f33ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009dfffff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.000000]   node   0: [mem 0x000000000a20b000-0x000000000affffff]
[    0.000000]   node   0: [mem 0x000000000b020000-0x000000005b608fff]
[    0.000000]   node   0: [mem 0x000000005b75a000-0x000000005b8dbfff]
[    0.000000]   node   0: [mem 0x000000005cc08000-0x000000005effffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000081f33ffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000081f33ffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 99 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 11 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 337 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 4908 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 3264 pages in unavailable ranges
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: 32 Processors exceeds NR_CPUS limit of 8
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x09e00000-0x09ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20afff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0b000000-0x0b01ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x5b609000-0x5b759fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x5b8dc000-0x5bcf0fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x5bcf1000-0x5cc07fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x5f000000-0xdfffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfcffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xffffffff]
[    0.000000] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] percpu: Embedded 49 pages/cpu s162584 r8192 d29928 u262144
[    0.000000] pcpu-alloc: s162584 r8192 d29928 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 7728229
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-5.15.0-rc7-sda11 root=/dev/sda11 ro resume=/dev/sda13
[    0.000000] Unknown command line parameters: BOOT_IMAGE=/vmlinuz-5.15.0-rc7-sda11
[    0.000000] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 30766024K/31404240K available (14351K kernel code, 2340K rwdata, 3324K rodata, 1480K init, 844K bss, 637956K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1032, preallocated irqs: 16
[    0.000000] random: crng done (trusting CPU's manufacturer)
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] ACPI: Core revision 20210730
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.008000] tsc: Unable to calibrate against PIT
[    0.008000] tsc: using HPET reference calibration
[    0.008000] tsc: Detected 3692.493 MHz processor
[    0.000003] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6a7342ba1e4, max_idle_ns: 881590490671 ns
[    0.000151] Calibrating delay loop (skipped), value calculated using timer frequency.. 7384.98 BogoMIPS (lpj=3692493)
[    0.000293] pid_max: default: 32768 minimum: 301
[    0.000391] LSM: Security Framework initializing
[    0.000544] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.001213] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.001704] LVT offset 1 assigned for vector 0xf9
[    0.001843] LVT offset 2 assigned for vector 0xf4
[    0.001950] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.002049] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.002155] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.002286] Spectre V2 : Mitigation: Full AMD retpoline
[    0.002378] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.002501] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.002625] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.003832] Freeing SMP alternatives memory: 36K
[    0.106219] smpboot: CPU0: AMD Ryzen 5 3400G with Radeon Vega Graphics (family: 0x17, model: 0x18, stepping: 0x1)
[    0.106494] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.106622] ... version:                0
[    0.106717] ... bit width:              48
[    0.106813] ... generic registers:      6
[    0.106907] ... value mask:             0000ffffffffffff
[    0.107014] ... max period:             00007fffffffffff
[    0.107121] ... fixed-purpose events:   0
[    0.107151] ... event mask:             000000000000003f
[    0.107311] rcu: Hierarchical SRCU implementation.
[    0.107492] MCE: In-kernel MCE decoding enabled.
[    0.107673] smp: Bringing up secondary CPUs ...
[    0.107853] x86: Booting SMP configuration:
[    0.107955] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.118181] smp: Brought up 1 node, 8 CPUs
[    0.118370] smpboot: Max logical packages: 4
[    0.118455] smpboot: Total of 8 processors activated (59079.88 BogoMIPS)
[    0.119699] devtmpfs: initialized
[    0.119699] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20afff] (45056 bytes)
[    0.120153] ACPI: PM: Registering ACPI NVS region [mem 0x5b8dc000-0x5bcf0fff] (4280320 bytes)
[    0.120330] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.120471] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.120625] pinctrl core: initialized pinctrl subsystem
[    0.120777] PM: RTC time: 16:35:27, date: 2021-11-01
[    0.120969] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.121226] thermal_sys: Registered thermal governor 'step_wise'
[    0.121227] thermal_sys: Registered thermal governor 'user_space'
[    0.121337] cpuidle: using governor menu
[    0.121337] ACPI: bus type PCI registered
[    0.121359] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.121497] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.121614] PCI: Using configuration type 1 for base access
[    0.123376] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.124162] cryptomgr_test (58) used greatest stack depth: 15656 bytes left
[    0.124284] cryptomgr_test (64) used greatest stack depth: 15240 bytes left
[    0.126191] ACPI: Added _OSI(Module Device)
[    0.126289] ACPI: Added _OSI(Processor Device)
[    0.126380] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.126380] ACPI: Added _OSI(Processor Aggregator Device)
[    0.126380] ACPI: Added _OSI(Linux-Dell-Video)
[    0.126380] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.126430] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.133048] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.134364] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.136161] ACPI: Interpreter enabled
[    0.136278] ACPI: PM: (supports S0 S3 S4 S5)
[    0.136371] ACPI: Using IOAPIC for interrupt routing
[    0.136809] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.137305] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.144246] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.144370] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.144632] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.144866] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
[    0.144981] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.145296] PCI host bridge to bus 0000:00
[    0.145387] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.145495] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.145602] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.145709] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.145816] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.145935] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.146053] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
[    0.146151] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.146269] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.146411] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.146650] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.146886] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.147121] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.147185] pci 0000:00:01.2: enabling Extended Tags
[    0.147334] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.147626] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.147853] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.147994] pci 0000:00:08.1: enabling Extended Tags
[    0.148195] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.148466] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.148613] pci 0000:00:08.2: enabling Extended Tags
[    0.148752] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.149039] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.149324] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.149584] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.149751] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.149920] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.150091] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.150214] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.150385] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.150555] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.150728] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.150953] pci 0000:01:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.151168] pci 0000:01:00.0: reg 0x10: [mem 0xfcea0000-0xfcea7fff 64bit]
[    0.151316] pci 0000:01:00.0: enabling Extended Tags
[    0.151477] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.151693] pci 0000:01:00.1: [1022:43b7] type 00 class 0x010601
[    0.151846] pci 0000:01:00.1: reg 0x24: [mem 0xfce80000-0xfce9ffff]
[    0.151964] pci 0000:01:00.1: reg 0x30: [mem 0xfce00000-0xfce7ffff pref]
[    0.152082] pci 0000:01:00.1: enabling Extended Tags
[    0.152192] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.152375] pci 0000:01:00.2: [1022:43b2] type 01 class 0x060400
[    0.152527] pci 0000:01:00.2: enabling Extended Tags
[    0.152673] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.152877] pci 0000:00:01.2: PCI bridge to [bus 01-08]
[    0.152979] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.153083] pci 0000:00:01.2:   bridge window [mem 0xfcd00000-0xfcefffff]
[    0.153154] pci 0000:00:01.2:   bridge window [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.153341] pci 0000:02:00.0: [1022:43b4] type 01 class 0x060400
[    0.153493] pci 0000:02:00.0: enabling Extended Tags
[    0.153649] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.153864] pci 0000:02:01.0: [1022:43b4] type 01 class 0x060400
[    0.154018] pci 0000:02:01.0: enabling Extended Tags
[    0.154210] pci 0000:02:01.0: PME# supported from D3hot D3cold
[    0.154424] pci 0000:02:04.0: [1022:43b4] type 01 class 0x060400
[    0.154587] pci 0000:02:04.0: enabling Extended Tags
[    0.154743] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    0.154952] pci 0000:02:05.0: [1022:43b4] type 01 class 0x060400
[    0.155111] pci 0000:02:05.0: enabling Extended Tags
[    0.155210] pci 0000:02:05.0: PME# supported from D3hot D3cold
[    0.155419] pci 0000:02:06.0: [1022:43b4] type 01 class 0x060400
[    0.155578] pci 0000:02:06.0: enabling Extended Tags
[    0.155734] pci 0000:02:06.0: PME# supported from D3hot D3cold
[    0.155944] pci 0000:02:07.0: [1022:43b4] type 01 class 0x060400
[    0.156198] pci 0000:02:07.0: enabling Extended Tags
[    0.157210] pci 0000:02:07.0: PME# supported from D3hot D3cold
[    0.157413] pci 0000:01:00.2: PCI bridge to [bus 02-08]
[    0.157522] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.157627] pci 0000:01:00.2:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    0.158154] pci 0000:01:00.2:   bridge window [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.158313] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.158460] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.158601] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.158739] pci 0000:02:05.0: PCI bridge to [bus 06]
[    0.158877] pci 0000:02:06.0: PCI bridge to [bus 07]
[    0.159151] pci 0000:08:00.0: [10ec:8168] type 00 class 0x020000
[    0.159282] pci 0000:08:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.159433] pci 0000:08:00.0: reg 0x18: [mem 0xfcd00000-0xfcd00fff 64bit]
[    0.159566] pci 0000:08:00.0: reg 0x20: [mem 0xf0300000-0xf0303fff 64bit pref]
[    0.159834] pci 0000:08:00.0: supports D1 D2
[    0.159934] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.160183] pci 0000:02:07.0: PCI bridge to [bus 08]
[    0.160284] pci 0000:02:07.0:   bridge window [io  0xf000-0xffff]
[    0.160387] pci 0000:02:07.0:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    0.160497] pci 0000:02:07.0:   bridge window [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.160719] pci 0000:09:00.0: [1002:15d8] type 00 class 0x030000
[    0.160840] pci 0000:09:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.160966] pci 0000:09:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.161090] pci 0000:09:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.161157] pci 0000:09:00.0: reg 0x24: [mem 0xfcc00000-0xfcc7ffff]
[    0.161271] pci 0000:09:00.0: enabling Extended Tags
[    0.161436] pci 0000:09:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.161648] pci 0000:09:00.1: [1002:15de] type 00 class 0x040300
[    0.161766] pci 0000:09:00.1: reg 0x10: [mem 0xfcc88000-0xfcc8bfff]
[    0.161912] pci 0000:09:00.1: enabling Extended Tags
[    0.162053] pci 0000:09:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.162230] pci 0000:09:00.2: [1022:15df] type 00 class 0x108000
[    0.162355] pci 0000:09:00.2: reg 0x18: [mem 0xfcb00000-0xfcbfffff]
[    0.162477] pci 0000:09:00.2: reg 0x24: [mem 0xfcc8c000-0xfcc8dfff]
[    0.162591] pci 0000:09:00.2: enabling Extended Tags
[    0.162801] pci 0000:09:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.162927] pci 0000:09:00.3: reg 0x10: [mem 0xfca00000-0xfcafffff 64bit]
[    0.163072] pci 0000:09:00.3: enabling Extended Tags
[    0.163197] pci 0000:09:00.3: PME# supported from D0 D3hot D3cold
[    0.163378] pci 0000:09:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.163494] pci 0000:09:00.4: reg 0x10: [mem 0xfc900000-0xfc9fffff 64bit]
[    0.163636] pci 0000:09:00.4: enabling Extended Tags
[    0.163774] pci 0000:09:00.4: PME# supported from D0 D3hot D3cold
[    0.163958] pci 0000:09:00.6: [1022:15e3] type 00 class 0x040300
[    0.164070] pci 0000:09:00.6: reg 0x10: [mem 0xfcc80000-0xfcc87fff]
[    0.164194] pci 0000:09:00.6: enabling Extended Tags
[    0.164329] pci 0000:09:00.6: PME# supported from D0 D3hot D3cold
[    0.164513] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.164613] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.164721] pci 0000:00:08.1:   bridge window [mem 0xfc900000-0xfccfffff]
[    0.164838] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.165018] pci 0000:0a:00.0: [1022:7901] type 00 class 0x010601
[    0.165193] pci 0000:0a:00.0: reg 0x24: [mem 0xfcf00000-0xfcf007ff]
[    0.165307] pci 0000:0a:00.0: enabling Extended Tags
[    0.165459] pci 0000:0a:00.0: PME# supported from D3hot D3cold
[    0.165638] pci 0000:00:08.2: PCI bridge to [bus 0a]
[    0.165735] pci 0000:00:08.2:   bridge window [mem 0xfcf00000-0xfcffffff]
[    0.165861] pci_bus 0000:00: on NUMA node 0
[    0.166189] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.166334] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.166464] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.166608] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.166743] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.166870] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.166997] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.167130] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.168756] iommu: Default domain type: Passthrough 
[    0.169169] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    0.169262] pci 0000:09:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.169388] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.169388] vgaarb: loaded
[    0.169388] SCSI subsystem initialized
[    0.169388] libata version 3.00 loaded.
[    0.169388] ACPI: bus type USB registered
[    0.169388] usbcore: registered new interface driver usbfs
[    0.169388] usbcore: registered new interface driver hub
[    0.169468] usbcore: registered new device driver usb
[    0.169569] pps_core: LinuxPPS API ver. 1 registered
[    0.170151] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.170293] PTP clock support registered
[    0.170383] EDAC MC: Ver: 3.0.0
[    0.170543] Advanced Linux Sound Architecture Driver Initialized.
[    0.170543] NetLabel: Initializing
[    0.170543] NetLabel:  domain hash size = 128
[    0.170543] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.171159] NetLabel:  unlabeled traffic allowed by default
[    0.171260] PCI: Using ACPI for IRQ routing
[    0.173246] PCI: pci_cache_line_size set to 64 bytes
[    0.173302] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    0.173401] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.173403] e820: reserve RAM buffer [mem 0x09e00000-0x0bffffff]
[    0.173404] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.173405] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.173406] e820: reserve RAM buffer [mem 0x5b609000-0x5bffffff]
[    0.173406] e820: reserve RAM buffer [mem 0x5b8dc000-0x5bffffff]
[    0.173407] e820: reserve RAM buffer [mem 0x5f000000-0x5fffffff]
[    0.173408] e820: reserve RAM buffer [mem 0x81f340000-0x81fffffff]
[    0.173422] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.173511] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.175480] clocksource: Switched to clocksource tsc-early
[    0.180500] VFS: Disk quotas dquot_6.6.0
[    0.180625] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.180773] pnp: PnP ACPI init
[    0.180941] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.181091] system 00:01: [mem 0x60000000-0xdfffffff window] has been reserved
[    0.181374] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    0.181478] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.181576] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    0.181805] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.181908] system 00:04: [io  0x040b] has been reserved
[    0.182001] system 00:04: [io  0x04d6] has been reserved
[    0.182094] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.182192] system 00:04: [io  0x0c14] has been reserved
[    0.182290] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.182389] system 00:04: [io  0x0c52] has been reserved
[    0.182483] system 00:04: [io  0x0c6c] has been reserved
[    0.182577] system 00:04: [io  0x0c6f] has been reserved
[    0.182679] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    0.182771] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    0.182863] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    0.182956] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    0.183048] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.183140] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.183232] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.183325] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.183418] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.183510] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.183603] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.183702] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.183800] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.183897] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.183993] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.184092] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.184189] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.184553] pnp: PnP ACPI: found 5 devices
[    0.190073] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.190212] NET: Registered PF_INET protocol family
[    0.190541] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.191926] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.192076] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.192483] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.192714] TCP: Hash tables configured (established 262144 bind 65536)
[    0.192847] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.193012] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.193223] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.193431] RPC: Registered named UNIX socket transport module.
[    0.193527] RPC: Registered udp transport module.
[    0.193612] RPC: Registered tcp transport module.
[    0.193696] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.193915] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.194017] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.194111] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.194205] pci 0000:02:05.0: PCI bridge to [bus 06]
[    0.194300] pci 0000:02:06.0: PCI bridge to [bus 07]
[    0.194395] pci 0000:02:07.0: PCI bridge to [bus 08]
[    0.194482] pci 0000:02:07.0:   bridge window [io  0xf000-0xffff]
[    0.194578] pci 0000:02:07.0:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    0.194678] pci 0000:02:07.0:   bridge window [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.194790] pci 0000:01:00.2: PCI bridge to [bus 02-08]
[    0.194878] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.194974] pci 0000:01:00.2:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    0.195073] pci 0000:01:00.2:   bridge window [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.195185] pci 0000:00:01.2: PCI bridge to [bus 01-08]
[    0.195274] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.195370] pci 0000:00:01.2:   bridge window [mem 0xfcd00000-0xfcefffff]
[    0.195469] pci 0000:00:01.2:   bridge window [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.195581] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.195668] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.195763] pci 0000:00:08.1:   bridge window [mem 0xfc900000-0xfccfffff]
[    0.195861] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.195972] pci 0000:00:08.2: PCI bridge to [bus 0a]
[    0.196060] pci 0000:00:08.2:   bridge window [mem 0xfcf00000-0xfcffffff]
[    0.197607] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.197701] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.197795] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.197889] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.197982] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.198081] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.198178] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[    0.198277] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.198377] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.198467] pci_bus 0000:01: resource 1 [mem 0xfcd00000-0xfcefffff]
[    0.198561] pci_bus 0000:01: resource 2 [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.198667] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.198757] pci_bus 0000:02: resource 1 [mem 0xfcd00000-0xfcdfffff]
[    0.198851] pci_bus 0000:02: resource 2 [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.198956] pci_bus 0000:08: resource 0 [io  0xf000-0xffff]
[    0.199046] pci_bus 0000:08: resource 1 [mem 0xfcd00000-0xfcdfffff]
[    0.199141] pci_bus 0000:08: resource 2 [mem 0xf0300000-0xf03fffff 64bit pref]
[    0.199241] pci_bus 0000:09: resource 0 [io  0xe000-0xefff]
[    0.199324] pci_bus 0000:09: resource 1 [mem 0xfc900000-0xfccfffff]
[    0.199414] pci_bus 0000:09: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.199511] pci_bus 0000:0a: resource 1 [mem 0xfcf00000-0xfcffffff]
[    0.199765] pci 0000:09:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.199881] pci 0000:09:00.1: D0 power state depends on 0000:09:00.0
[    0.199993] pci 0000:09:00.3: extending delay after power-on from D3hot to 20 msec
[    0.200170] pci 0000:09:00.4: extending delay after power-on from D3hot to 20 msec
[    0.200322] PCI: CLS 64 bytes, default 64
[    0.201394] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.201518] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.201605] pci 0000:00:00.2: PCI INT A: not connected
[    0.201700] pci 0000:00:01.0: Adding to iommu group 0
[    0.201784] pci 0000:00:01.2: Adding to iommu group 1
[    0.201872] pci 0000:00:08.0: Adding to iommu group 2
[    0.201956] pci 0000:00:08.1: Adding to iommu group 3
[    0.202038] pci 0000:00:08.2: Adding to iommu group 2
[    0.202125] pci 0000:00:14.0: Adding to iommu group 4
[    0.202208] pci 0000:00:14.3: Adding to iommu group 4
[    0.202308] pci 0000:00:18.0: Adding to iommu group 5
[    0.202391] pci 0000:00:18.1: Adding to iommu group 5
[    0.202473] pci 0000:00:18.2: Adding to iommu group 5
[    0.202555] pci 0000:00:18.3: Adding to iommu group 5
[    0.202637] pci 0000:00:18.4: Adding to iommu group 5
[    0.202719] pci 0000:00:18.5: Adding to iommu group 5
[    0.202802] pci 0000:00:18.6: Adding to iommu group 5
[    0.202884] pci 0000:00:18.7: Adding to iommu group 5
[    0.202973] pci 0000:01:00.0: Adding to iommu group 6
[    0.203056] pci 0000:01:00.1: Adding to iommu group 6
[    0.203140] pci 0000:01:00.2: Adding to iommu group 6
[    0.203219] pci 0000:02:00.0: Adding to iommu group 6
[    0.203299] pci 0000:02:01.0: Adding to iommu group 6
[    0.203380] pci 0000:02:04.0: Adding to iommu group 6
[    0.203458] pci 0000:02:05.0: Adding to iommu group 6
[    0.203538] pci 0000:02:06.0: Adding to iommu group 6
[    0.203617] pci 0000:02:07.0: Adding to iommu group 6
[    0.203696] pci 0000:08:00.0: Adding to iommu group 6
[    0.203787] pci 0000:09:00.0: Adding to iommu group 7
[    0.203885] pci 0000:09:00.1: Adding to iommu group 8
[    0.203970] pci 0000:09:00.2: Adding to iommu group 8
[    0.204056] pci 0000:09:00.3: Adding to iommu group 8
[    0.204140] pci 0000:09:00.4: Adding to iommu group 8
[    0.204226] pci 0000:09:00.6: Adding to iommu group 8
[    0.204305] pci 0000:0a:00.0: Adding to iommu group 2
[    0.204665] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.204744] AMD-Vi: Extended features (0x4f77ef22294ada): PPR NX GT IA GA PC GA_vAPIC
[    0.204925] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.205014] software IO TLB: mapped [mem 0x0000000057609000-0x000000005b609000] (64MB)
[    0.205126] amd_uncore: 4  amd_df counters detected
[    0.205194] amd_uncore: 6  amd_l3 counters detected
[    0.205383] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.205523] kvm: Nested Virtualization enabled
[    0.205593] SVM: kvm: Nested Paging enabled
[    0.205662] SVM: Virtual VMLOAD VMSAVE supported
[    0.205728] SVM: Virtual GIF supported
[    0.209900] Initialise system trusted keyrings
[    0.210036] workingset: timestamp_bits=62 max_order=23 bucket_order=0
[    0.218280] Key type asymmetric registered
[    0.218389] Asymmetric key parser 'x509' registered
[    0.218486] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.218616] io scheduler bfq registered
[    0.218835] pcieport 0000:00:01.2: PME: Signaling with IRQ 26
[    0.218991] pcieport 0000:00:01.2: AER: enabled with IRQ 26
[    0.219183] pcieport 0000:00:08.1: PME: Signaling with IRQ 27
[    0.219412] pcieport 0000:00:08.2: PME: Signaling with IRQ 28
[    0.220343] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.220466] ACPI: button: Power Button [PWRB]
[    0.220562] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.222075] ACPI: button: Power Button [PWRF]
[    0.222240] ACPI: video: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
[    0.222519] acpi device:10: registered as cooling_device0
[    0.222633] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0f/LNXVIDEO:01/input/input2
[    0.222783] Monitor-Mwait will be used to enter C-1 state
[    0.222787] ACPI: \_PR_.C000: Found 2 idle states
[    0.222933] ACPI: \_PR_.C002: Found 2 idle states
[    0.223078] ACPI: \_PR_.C004: Found 2 idle states
[    0.223219] ACPI: \_PR_.C006: Found 2 idle states
[    0.223380] ACPI: \_PR_.C001: Found 2 idle states
[    0.223541] ACPI: \_PR_.C003: Found 2 idle states
[    0.223715] ACPI: \_PR_.C005: Found 2 idle states
[    0.223878] ACPI: \_PR_.C007: Found 2 idle states
[    0.224079] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.224465] Non-volatile memory driver v1.3
[    0.224560] Linux agpgart interface v0.103
[    0.224833] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.226204] loop: module loaded
[    0.226319] ahci 0000:01:00.1: version 3.0
[    0.226409] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    0.226531] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    0.226640] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    0.227119] scsi host0: ahci
[    0.227276] scsi host1: ahci
[    0.227421] scsi host2: ahci
[    0.227540] scsi host3: ahci
[    0.227665] scsi host4: ahci
[    0.227780] scsi host5: ahci
[    0.227910] scsi host6: ahci
[    0.228023] scsi host7: ahci
[    0.228112] ata1: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80100 irq 40
[    0.228211] ata2: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80180 irq 40
[    0.228309] ata3: DUMMY
[    0.228373] ata4: DUMMY
[    0.228437] ata5: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80300 irq 40
[    0.228534] ata6: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80380 irq 40
[    0.228629] ata7: DUMMY
[    0.228695] ata8: DUMMY
[    0.239388] ahci 0000:0a:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    0.239490] ahci 0000:0a:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    0.239728] scsi host8: ahci
[    0.239819] ata9: SATA max UDMA/133 abar m2048@0xfcf00000 port 0xfcf00100 irq 42
[    0.240014] libphy: Fixed MDIO Bus: probed
[    0.245723] kworker/u16:9 (131) used greatest stack depth: 14704 bytes left
[    0.245769] libphy: r8169: probed
[    0.246015] r8169 0000:08:00.0 eth0: RTL8168g/8111g, b4:2e:99:63:1f:ae, XID 4c0, IRQ 43
[    0.246123] r8169 0000:08:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    0.246283] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.246372] ehci-pci: EHCI PCI platform driver
[    0.246455] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.246541] ohci-pci: OHCI PCI platform driver
[    0.246624] uhci_hcd: USB Universal Host Controller Interface driver
[    0.246765] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    0.246893] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    0.302320] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000010048000410
[    0.302647] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    0.302763] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    0.302881] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    0.303029] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.303167] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.303287] usb usb1: Product: xHCI Host Controller
[    0.303394] usb usb1: Manufacturer: Linux 5.15.0-rc7 xhci-hcd
[    0.303497] usb usb1: SerialNumber: 0000:01:00.0
[    0.303650] hub 1-0:1.0: USB hub found
[    0.303743] hub 1-0:1.0: 10 ports detected
[    0.304011] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.305676] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    0.305800] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.305914] usb usb2: Product: xHCI Host Controller
[    0.306005] usb usb2: Manufacturer: Linux 5.15.0-rc7 xhci-hcd
[    0.306103] usb usb2: SerialNumber: 0000:01:00.0
[    0.306244] hub 2-0:1.0: USB hub found
[    0.306335] hub 2-0:1.0: 4 ports detected
[    0.306466] usb: port power management may be unreliable
[    0.306645] xhci_hcd 0000:09:00.3: xHCI Host Controller
[    0.306778] xhci_hcd 0000:09:00.3: new USB bus registered, assigned bus number 3
[    0.307033] xhci_hcd 0000:09:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
[    0.307369] xhci_hcd 0000:09:00.3: xHCI Host Controller
[    0.307474] xhci_hcd 0000:09:00.3: new USB bus registered, assigned bus number 4
[    0.307582] xhci_hcd 0000:09:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.307708] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.307821] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.307926] usb usb3: Product: xHCI Host Controller
[    0.308012] usb usb3: Manufacturer: Linux 5.15.0-rc7 xhci-hcd
[    0.308106] usb usb3: SerialNumber: 0000:09:00.3
[    0.308240] hub 3-0:1.0: USB hub found
[    0.308329] hub 3-0:1.0: 4 ports detected
[    0.308649] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.308772] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    0.308887] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.308993] usb usb4: Product: xHCI Host Controller
[    0.309078] usb usb4: Manufacturer: Linux 5.15.0-rc7 xhci-hcd
[    0.309172] usb usb4: SerialNumber: 0000:09:00.3
[    0.309303] hub 4-0:1.0: USB hub found
[    0.309389] hub 4-0:1.0: 4 ports detected
[    0.309745] xhci_hcd 0000:09:00.4: xHCI Host Controller
[    0.309870] xhci_hcd 0000:09:00.4: new USB bus registered, assigned bus number 5
[    0.310095] xhci_hcd 0000:09:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
[    0.310377] xhci_hcd 0000:09:00.4: xHCI Host Controller
[    0.310481] xhci_hcd 0000:09:00.4: new USB bus registered, assigned bus number 6
[    0.310588] xhci_hcd 0000:09:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.310715] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.310827] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.310933] usb usb5: Product: xHCI Host Controller
[    0.311019] usb usb5: Manufacturer: Linux 5.15.0-rc7 xhci-hcd
[    0.311113] usb usb5: SerialNumber: 0000:09:00.4
[    0.311247] hub 5-0:1.0: USB hub found
[    0.311334] hub 5-0:1.0: 1 port detected
[    0.311457] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.311577] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    0.311689] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.311801] usb usb6: Product: xHCI Host Controller
[    0.311887] usb usb6: Manufacturer: Linux 5.15.0-rc7 xhci-hcd
[    0.311977] usb usb6: SerialNumber: 0000:09:00.4
[    0.312105] hub 6-0:1.0: USB hub found
[    0.312187] hub 6-0:1.0: 1 port detected
[    0.312316] usbcore: registered new interface driver usblp
[    0.312417] usbcore: registered new interface driver usb-storage
[    0.312518] i8042: PNP: No PS/2 controller found.
[    0.312625] mousedev: PS/2 mouse device common for all mice
[    0.312778] rtc_cmos 00:02: RTC can wake from S4
[    0.313036] rtc_cmos 00:02: registered as rtc0
[    0.313128] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.313268] hid: raw HID events driver (C) Jiri Kosina
[    0.313380] usbcore: registered new interface driver usbhid
[    0.313462] usbhid: USB HID core driver
[    0.314436] Initializing XFRM netlink socket
[    0.314573] NET: Registered PF_INET6 protocol family
[    0.314836] Segment Routing with IPv6
[    0.314929] In-situ OAM (IOAM) with IPv6
[    0.315023] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.315184] NET: Registered PF_PACKET protocol family
[    0.315335] Key type dns_resolver registered
[    0.315975] microcode: CPU0: patch_level=0x08108102
[    0.316068] microcode: CPU1: patch_level=0x08108102
[    0.316156] microcode: CPU2: patch_level=0x08108102
[    0.316245] microcode: CPU3: patch_level=0x08108102
[    0.316341] microcode: CPU4: patch_level=0x08108102
[    0.316427] microcode: CPU5: patch_level=0x08108102
[    0.316511] microcode: CPU6: patch_level=0x08108102
[    0.316595] microcode: CPU7: patch_level=0x08108102
[    0.316687] microcode: Microcode Update Driver: v2.2.
[    0.316693] IPI shorthand broadcast: enabled
[    0.316701] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:09:00.1/sound/card0/input3
[    0.316803] sched_clock: Marking stable (323909536, -7849966)->(329804206, -13744636)
[    0.316888] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:09:00.1/sound/card0/input4
[    0.317252] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:09:00.1/sound/card0/input5
[    0.317264] Loading compiled-in X.509 certificates
[    0.317388] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:09:00.1/sound/card0/input6
[    0.317931] PM:   Magic number: 13:830:589
[    0.318101] printk: console [netcon0] enabled
[    0.318177] netconsole: network logging started
[    0.318414] acpi_cpufreq: overriding BIOS provided _PSD data
[    0.318793] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    0.318981] kworker/u16:9 (137) used greatest stack depth: 14128 bytes left
[    0.319298] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    0.319411] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    0.319533] cfg80211: failed to load regulatory.db
[    0.325697] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    0.325827] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    0.325925] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    0.326021] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    0.326108] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x11/0x0
[    0.326191] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    0.326273] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[    0.326357] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[    0.326441] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[    0.344031] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input7
[    0.344168] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input8
[    0.344295] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input9
[    0.344426] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input10
[    0.344555] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:09:00.6/sound/card1/input11
[    0.546435] usb 1-5: new high-speed USB device number 2 using xhci_hcd
[    0.554797] ata9: SATA link down (SStatus 0 SControl 300)
[    0.696801] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.697122] usb 1-5: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=77.63
[    0.697172] ata1.00: supports DRM functions and may not be fully accessible
[    0.697251] usb 1-5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    0.697360] ata1.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT03B6Q, max UDMA/133
[    0.697470] usb 1-5: Product: USB2.0 Hub
[    0.698099] ata1.00: disabling queued TRIM support
[    0.698102] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.699813] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    0.700273] ata1.00: supports DRM functions and may not be fully accessible
[    0.700856] ata1.00: disabling queued TRIM support
[    0.702488] ata1.00: configured for UDMA/133
[    0.702645] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 860  3B6Q PQ: 0 ANSI: 5
[    0.702897] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.702900] ata1.00: Enabling discard_zeroes_data
[    0.703127] hub 1-5:1.0: USB hub found
[    0.703133] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    0.703337] sd 0:0:0:0: [sda] Write Protect is off
[    0.703429] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.703437] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.703748] ata1.00: Enabling discard_zeroes_data
[    0.706430]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
[    0.706876] ata1.00: Enabling discard_zeroes_data
[    0.707026] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.707979] hub 1-5:1.0: 4 ports detected
[    0.842385] usb 1-7: new low-speed USB device number 3 using xhci_hcd
[    0.984476] usb 1-7: device descriptor read/64, error -71
[    1.015520] ata2: SATA link down (SStatus 0 SControl 300)
[    1.160745] usb 1-5.1: new low-speed USB device number 4 using xhci_hcd
[    1.239466] tsc: Refined TSC clocksource calibration: 3696.214 MHz
[    1.239593] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a8eb9fe25e, max_idle_ns: 881590828916 ns
[    1.239790] clocksource: Switched to clocksource tsc
[    1.325916] ata5: SATA link down (SStatus 0 SControl 300)
[    1.402652] usb 1-5.1: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
[    1.404205] usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.404328] usb 1-5.1: Product: USB Optical Mouse
[    1.404417] usb 1-5.1: Manufacturer: Logitech
[    1.432671] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5.1/1-5.1:1.0/0003:046D:C077.0001/input/input12
[    1.432989] hid-generic 0003:046D:C077.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:01:00.0-5.1/input0
[    1.464505] usb 1-7: new low-speed USB device number 5 using xhci_hcd
[    1.606300] usb 1-7: device descriptor read/64, error -71
[    1.711533] usb usb1-port7: attempt power cycle
[    1.783545] usb 1-5.2: new low-speed USB device number 6 using xhci_hcd
[    1.799353] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.802974] ata6.00: ATAPI: ATAPI   iHAS124   E, 4L08, max UDMA/100
[    1.803892] ata6.00: configured for UDMA/100
[    1.805522] scsi 5:0:0:0: CD-ROM            ATAPI    iHAS124   E      4L08 PQ: 0 ANSI: 5
[    1.848735] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.848886] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.869871] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    1.869971] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    1.870415] PM: Image not found (code -22)
[    1.870433] ALSA device list:
[    1.870515]   #0: HD-Audio Generic at 0xfcc88000 irq 71
[    1.870618]   #1: HD-Audio Generic at 0xfcc80000 irq 72
[    1.872179] EXT4-fs (sda11): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    1.872335] VFS: Mounted root (ext4 filesystem) readonly on device 8:11.
[    1.873114] devtmpfs: mounted
[    1.873417] Freeing unused kernel image (initmem) memory: 1480K
[    1.875180] Write protecting the kernel read-only data: 20480k
[    1.875663] Freeing unused kernel image (text/rodata gap) memory: 2032K
[    1.875923] Freeing unused kernel image (rodata/data gap) memory: 772K
[    1.876040] Run /sbin/init as init process
[    1.876135]   with arguments:
[    1.876136]     /sbin/init
[    1.876136]   with environment:
[    1.876137]     HOME=/
[    1.876137]     TERM=linux
[    1.876138]     BOOT_IMAGE=/vmlinuz-5.15.0-rc7-sda11
[    1.904723] wc (154) used greatest stack depth: 13920 bytes left
[    1.907349] stty (158) used greatest stack depth: 13408 bytes left
[    1.913975] dmesg (165) used greatest stack depth: 13312 bytes left
[    1.959836] ip (234) used greatest stack depth: 12344 bytes left
[    1.974177] udevd[265]: starting version 3.2.10
[    1.988900] udevd[266]: starting eudev-3.2.10
[    2.007170] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc' as unstable because the skew is too large:
[    2.007181] clocksource:                       'hpet' wd_nsec: 504292794 wd_now: 1c9ec43 wd_last: 15bbef8 mask: ffffffff
[    2.007189] clocksource:                       'tsc' cs_nsec: 503862639 cs_now: 12dbc02b2c cs_last: 126cbe725a mask: ffffffffffffffff
[    2.007193] clocksource:                       'tsc' is current clocksource.
[    2.007200] tsc: Marking TSC unstable due to clocksource watchdog
[    2.007359] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
[    2.007363] sched_clock: Marking unstable (2015209217, -7850083)<-(2021103594, -13744636)
[    2.007641] clocksource: Checking clocksource tsc synchronization from CPU 3 to CPUs 0,5-7.
[    2.007688] clocksource: Switched to clocksource hpet
[    2.018913] r8169 0000:08:00.0 enp8s0: renamed from eth0
[    2.024454] usb 1-5.2: New USB device found, idVendor=1a2c, idProduct=0e24, bcdDevice= 1.10
[    2.024458] usb 1-5.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.024460] usb 1-5.2: Product: USB Keyboard
[    2.024461] usb 1-5.2: Manufacturer: SEM
[    2.056625] input: SEM USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5.2/1-5.2:1.0/0003:1A2C:0E24.0002/input/input13
[    2.105032] [drm] amdgpu kernel modesetting enabled.
[    2.108293] hid-generic 0003:1A2C:0E24.0002: input,hidraw1: USB HID v1.10 Keyboard [SEM USB Keyboard] on usb-0000:01:00.0-5.2/input0
[    2.109029] amdgpu: Topology: Add APU node [0x0:0x0]
[    2.109069] amdgpu 0000:09:00.0: vgaarb: deactivate vga console
[    2.110026] Console: switching to colour dummy device 100x25
[    2.110099] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x1002:0x15D8 0xC8).
[    2.110102] amdgpu 0000:09:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[    2.110108] [drm] register mmio base: 0xFCC00000
[    2.110109] [drm] register mmio size: 524288
[    2.110118] [drm] add ip block number 0 <soc15_common>
[    2.110119] [drm] add ip block number 1 <gmc_v9_0>
[    2.110120] [drm] add ip block number 2 <vega10_ih>
[    2.110121] [drm] add ip block number 3 <psp>
[    2.110122] [drm] add ip block number 4 <gfx_v9_0>
[    2.110123] [drm] add ip block number 5 <sdma_v4_0>
[    2.110123] [drm] add ip block number 6 <powerplay>
[    2.110124] [drm] add ip block number 7 <dm>
[    2.110125] [drm] add ip block number 8 <vcn_v1_0>
[    2.129752] input: SEM USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5.2/1-5.2:1.1/0003:1A2C:0E24.0003/input/input14
[    2.135025] [drm] BIOS signature incorrect 5b 7
[    2.135046] amdgpu 0000:09:00.0: amdgpu: Fetched VBIOS from ROM BAR
[    2.135048] amdgpu: ATOM BIOS: 113-PICASSO-114
[    2.135298] [drm] VCN decode is enabled in VM mode
[    2.135299] [drm] VCN encode is enabled in VM mode
[    2.135299] [drm] JPEG decode is enabled in VM mode
[    2.135317] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.135323] amdgpu 0000:09:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    2.135325] amdgpu 0000:09:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    2.135327] amdgpu 0000:09:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    2.135331] [drm] Detected VRAM RAM=2048M, BAR=2048M
[    2.135332] [drm] RAM width 64bits DDR4
[    2.135384] [drm] amdgpu: 2048M of VRAM memory ready
[    2.135385] [drm] amdgpu: 3072M of GTT memory ready.
[    2.135388] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.135522] [drm] PCIE GART of 1024M enabled.
[    2.135523] [drm] PTB located at 0x000000F400900000
[    2.135852] amdgpu 0000:09:00.0: Direct firmware load for amdgpu/picasso_ta.bin failed with error -2
[    2.135854] amdgpu 0000:09:00.0: amdgpu: psp v10.0: Failed to load firmware "amdgpu/picasso_ta.bin"
[    2.135856] amdgpu 0000:09:00.0: amdgpu: PSP runtime database doesn't exist
[    2.138794] [drm] CP firmware version too old, please update!
[    2.139717] amdgpu: hwmgr_sw_init smu backed is smu10_smu
[    2.140922] [drm] Found VCN firmware Version: 1.73 Family ID: 18
[    2.140926] amdgpu 0000:09:00.0: amdgpu: Will use PSP to load VCN firmware
[    2.161737] [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
[    2.182253] input: SEM USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5.2/1-5.2:1.1/0003:1A2C:0E24.0003/input/input15
[    2.182325] hid-generic 0003:1A2C:0E24.0003: input,hidraw2: USB HID v1.10 Device [SEM USB Keyboard] on usb-0000:01:00.0-5.2/input1
[    2.222200] [drm] kiq ring mec 2 pipe 1 q 0
[    2.222733] [drm] DM_PPLIB: values for F clock
[    2.222735] [drm] DM_PPLIB:	 400000 in kHz, 3099 in mV
[    2.222736] [drm] DM_PPLIB:	 933000 in kHz, 3574 in mV
[    2.222737] [drm] DM_PPLIB:	 1200000 in kHz, 4399 in mV
[    2.222737] [drm] DM_PPLIB:	 1333000 in kHz, 4399 in mV
[    2.222739] [drm] DM_PPLIB: values for DCF clock
[    2.222739] [drm] DM_PPLIB:	 300000 in kHz, 3099 in mV
[    2.222740] [drm] DM_PPLIB:	 600000 in kHz, 3574 in mV
[    2.222741] [drm] DM_PPLIB:	 626000 in kHz, 4250 in mV
[    2.222741] [drm] DM_PPLIB:	 654000 in kHz, 4399 in mV
[    2.222958] [drm] Display Core initialized with v3.2.149!
[    2.239191] usb usb1-port7: Cannot enable. Maybe the USB cable is bad?
[    2.269555] snd_hda_intel 0000:09:00.1: bound 0000:09:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    2.307659] [drm] VCN decode and encode initialized successfully(under SPG Mode).
[    2.308676] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    2.308790] amdgpu: Topology: Add APU node [0x15d8:0x1002]
[    2.308792] kfd kfd: amdgpu: added device 1002:15d8
[    2.308871] amdgpu 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x10438a380 flags=0x0070]
[    2.308957] amdgpu 0000:09:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 11
[    2.310218] [drm] fb mappable at 0x60BC2000
[    2.310219] [drm] vram apper at 0x60000000
[    2.310220] [drm] size 8294400
[    2.310220] [drm] fb depth is 24
[    2.310221] [drm]    pitch is 7680
[    2.310271] fbcon: amdgpu (fb0) is primary device
[    2.313178] usb 1-5.4: new full-speed USB device number 8 using xhci_hcd
[    2.354831] Console: switching to colour frame buffer device 160x49
[    2.375027] amdgpu 0000:09:00.0: [drm] fb0: amdgpu frame buffer device
[    2.380227] amdgpu 0000:09:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[    2.380229] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.380230] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.380232] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[    2.380233] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[    2.380234] amdgpu 0000:09:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[    2.380235] amdgpu 0000:09:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[    2.380236] amdgpu 0000:09:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[    2.380237] amdgpu 0000:09:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[    2.380239] amdgpu 0000:09:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[    2.380240] amdgpu 0000:09:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[    2.380241] amdgpu 0000:09:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[    2.380242] amdgpu 0000:09:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[    2.380243] amdgpu 0000:09:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[    2.380245] amdgpu 0000:09:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[    2.385224] [drm] Initialized amdgpu 3.42.0 20150101 for 0000:09:00.0 on minor 0
[    2.609177] usb 1-7: new low-speed USB device number 9 using xhci_hcd
[    2.617491] usb 1-5.4: New USB device found, idVendor=0d8c, idProduct=013c, bcdDevice= 1.00
[    2.617494] usb 1-5.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.617495] usb 1-5.4: Product: USB PnP Sound Device
[    2.617496] usb 1-5.4: Manufacturer: C-Media Electronics Inc.      
[    2.637098] usb 1-7: Device not responding to setup address.
[    2.669360] input: C-Media Electronics Inc.       USB PnP Sound Device as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5.4/1-5.4:1.3/0003:0D8C:013C.0004/input/input16
[    2.721885] hid-generic 0003:0D8C:013C.0004: input,hidraw3: USB HID v1.00 Device [C-Media Electronics Inc.       USB PnP Sound Device] on usb-0000:01:00.0-5.4/input3
[    2.847749] usb 1-7: device not accepting address 9, error -71
[    2.847918] usb usb1-port7: unable to enumerate USB device
[    3.033862] udevd (289) used greatest stack depth: 10568 bytes left
[    3.229295] Adding 16777212k swap on /dev/sda13.  Priority:-2 extents:1 across:16777212k SS
[    3.239221] EXT4-fs (sda11): re-mounted. Opts: discard. Quota mode: none.
[    3.290144] EXT4-fs (sda11): re-mounted. Opts: discard. Quota mode: none.
[    3.303950] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: discard. Quota mode: none.
[    3.311446] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: discard. Quota mode: none.
[    3.319696] EXT4-fs (sda14): mounted filesystem with ordered data mode. Opts: discard. Quota mode: none.
[    4.387173] Generic FE-GE Realtek PHY r8169-0-800:00: attached PHY driver (mii_bus:phy_addr=r8169-0-800:00, irq=MAC)
[    4.552659] r8169 0000:08:00.0 enp8s0: Link is Down
[    7.441469] r8169 0000:08:00.0 enp8s0: Link is Up - 1Gbps/Full - flow control off
[    7.441488] IPv6: ADDRCONF(NETDEV_CHANGE): enp8s0: link becomes ready
[  117.019262] amdgpu 0000:09:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
[  129.969194] amdgpu 0000:09:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
[  142.964196] amdgpu 0000:09:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
[  150.440513] sysrq: Emergency Sync
[  150.443732] Emergency Sync complete
[  155.894244] amdgpu 0000:09:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
[  169.260280] amdgpu 0000:09:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
[  181.965194] amdgpu 0000:09:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

--JxzpfejiTv9OLo93--
