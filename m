Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5E34010A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCRI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhCRI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616056168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvWpj5XGdJgXu1ybFR3vNMY483vapjXj4HuQs9Bpd9U=;
        b=GcNjNHZ1ra560cysI/flgAa8XJygWG9FV/zTfBsW3AIu2WGuGsoeNJRMpBK5AYd9riCcqc
        97LpzVZsJInUP/jZWledZhe55m6BOFR4NEpeY8urFjLP7kexQntMrKim3ehYeziQAmWjAx
        Yw+mMqhzXPxA2RkbmpydHrnWcwYKvSI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-WbcZg5FcNFGL0LskC7Hk1Q-1; Thu, 18 Mar 2021 04:29:26 -0400
X-MC-Unique: WbcZg5FcNFGL0LskC7Hk1Q-1
Received: by mail-wr1-f70.google.com with SMTP id b6so4391536wrq.22
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rvWpj5XGdJgXu1ybFR3vNMY483vapjXj4HuQs9Bpd9U=;
        b=sG3ypOtOeYO4YeI8Tr527aSc/wLxP6a76jWI339KOezxwJfBZmTcb7pvykdMw0iuVS
         KbWUDcRly+YrotkG/Hx0+vbLeWs+6GmznbBex7jtSseQF1Xd9LKkM/zSkbdR2H+RIUWm
         TQbLs3T0q93ZDyd92FnpAcyEKu+FLZZO6KKXBpZnYXvigwtjK1GYDinrA+CAFOxiah29
         eDmuZUwMoZGltJ5U0OBnDzQuokCImv9XQUtl4ucibnehdWxLtXz//dIhs/p4v7JMgiDe
         h6i0P1K5gR8Pbd7hB6kkGvvyoEc/Rzdekz8nFpyI9oOyNCLpIAhrxGCaDKyBeJWa/DiA
         dCIA==
X-Gm-Message-State: AOAM530/qZKdD660dg8hnfInEWMK0OApg39domgyNbjH/lzrLJijLxoz
        EEFSERX4lZxmkjGK3wIjQKMW7Vv/kwn66stS68LxD5k5SJqYYRkAeBzaUfJBUlaaTHS8oZ4himJ
        2XIlZeKcM5VjQkS2g89qIILUHNJQzEOP67q/3W68ZrffzV/H5RW2Kb85QKn5AD+dHQaKOcRUm97
        5C
X-Received: by 2002:a7b:c209:: with SMTP id x9mr2457514wmi.92.1616056164984;
        Thu, 18 Mar 2021 01:29:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJgnJ+zIsKcKnwxT/BMV3HEoT9DXs9ExrWjUBhqev6vBLZCKjdvISWvNQngTxbPSn+3FsSZQ==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr2457498wmi.92.1616056164807;
        Thu, 18 Mar 2021 01:29:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i17sm1856838wrp.77.2021.03.18.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:29:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for
 PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <87im5py1ty.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com>
 <20210219113101.967508-2-vkuznets@redhat.com>
 <87im5py1ty.fsf@nanos.tec.linutronix.de>
Date:   Thu, 18 Mar 2021 09:29:23 +0100
Message-ID: <87blbg7tlo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, Feb 19 2021 at 12:31, Vitaly Kuznetsov wrote:
>> Trying to offline/online CPU0 seems to work only once:
>>
>>  # echo 0 > /sys/devices/system/cpu/cpu0/online
>>  # echo 1 > /sys/devices/system/cpu/cpu0/online
>>  # echo 0 > /sys/devices/system/cpu/cpu0/online
>>  -bash: echo: write error: No space left on device
>>
>> with the following in dmesg:
>>
>>  [ ... ] CPU 0 has 4294967295 vectors, 589 available. Cannot disable CPU
>>
>> Clearly, we went negative with cm->allocated in irq_matrix and think that
>> there are too many vectors require re-assigning.
>>
>> The problem turns to be: lapic_assign_system_vectors() called from
>> native_init_IRQ() makes an exception for PIC_CASCADE_IR and doesn't
>> mark it in irq_matrix. Later, when x86_vector_alloc_irqs() called
>> from setup_IO_APIC() does clear_irq_vector() for all legacy entries,
>> it doesn't make an exception so we go negative.
>>
>> CPU0 offlining still works for the first time because some other vectors
>> get assigned and the overall balance remains positive (it's off-by-one, but
>> the check passes). When we online CPU0 back, no vectors get assigned and
>> the overall balance remains '-1'.
>>
>> The simplest solution seems to be to not make an exception for
>> PIC_CASCADE_IR. Nothing seems to blow up immediately.
>
> Well no. This does not make sense. Just a few lines above the code which
> you are fiddling with is:
>
> 	if (nr_legacy_irqs() > 1)
> 		lapic_assign_legacy_vector(PIC_CASCADE_IR, false);
>
> Which is there for a reason because this _MUST_ stay at exactly this
> place and not move randomly around.
>
> Even without looking at the machine I can tell you what's going on. MP
> config or ACPI has a pin assigned to IRQ 2 which I've not seen before.
> The code there is ignoring IRQ 2 because that's how the original code
> worked as well as it is reserved for the PIC_CASCADE_IRQ which should
> never fire and we actually want to catch an spurious interrupt on it.
>
> So depending on the overall configuration of that system and the
> resulting delivery modes this might be ok, but I'm really nervous about
> doing this wholesale as it might break old machines.
>
> Out of paranoia I'd rather ignore that IO/APIC pin completely if it
> claims to be IRQ2. I assume there is no device connected to it at all,
> right?

The original issue was observed on Amazon's r5d.xlarge instance
type. Your assumption seems to be correct, I don't see any device on
IRQ2.

>
> Can you please provide a dmesg with apic=verbose on the command line?
>

Here you go, attached.

-- 
Vitaly


--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=dmesg.txt

[    0.000000] Linux version 5.12.0-rc3+ (root@virtlab519.virt.lab.eng.bos.redhat.com) (gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9), GNU ld version 2.34-3.fc32) #272 SMP Tue Mar 16 09:13:18 EDT 2021
[    0.000000] Command line: BOOT_IMAGE=(hd0,gpt2)/boot/vmlinuz-5.12.0-rc3+ root=UUID=949779ce-46aa-434e-8eb0-852514a5d69e ro console=ttyS0,115200n8 console=tty0 net.ifnames=0 rd.blacklist=nouveau nvme_core.io_timeout=4294967295 crashkernel=auto apic=verbose
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfff9fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfffa000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e03fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008229fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000822a00000-0x000000083fffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Amazon EC2 r5d.xlarge/, BIOS 1.0 10/16/2017
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 45a201001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 5794653794 cycles
[    0.000001] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000005] tsc: Detected 2499.998 MHz processor
[    0.000408] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000412] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000416] last_pfn = 0x822a00 max_arch_pfn = 0x400000000
[    0.000451] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000458] last_pfn = 0xbfffa max_arch_pfn = 0x400000000
[    0.000460] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000482] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000501] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.007360] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.007390] kexec: Reserving the low 1M of memory for crashkernel
[    0.007415] Using GB pages for direct mapping
[    0.007685] RAMDISK: [mem 0x34672000-0x36330fff]
[    0.007702] ACPI: Early table checksum verification disabled
[    0.007705] ACPI: RSDP 0x00000000000F8E00 000014 (v00 AMAZON)
[    0.007713] ACPI: RSDT 0x00000000BFFFE270 00003C (v01 AMAZON AMZNRSDT 00000001 AMZN 00000001)
[    0.007718] ACPI: FACP 0x00000000BFFFFF80 000074 (v01 AMAZON AMZNFACP 00000001 AMZN 00000001)
[    0.007723] ACPI: DSDT 0x00000000BFFFE2B0 0010E9 (v01 AMAZON AMZNDSDT 00000001 AMZN 00000001)
[    0.007726] ACPI: FACS 0x00000000BFFFFF40 000040
[    0.007728] ACPI: SSDT 0x00000000BFFFF600 00093C (v01 AMAZON AMZNSSDT 00000001 AMZN 00000001)
[    0.007731] ACPI: APIC 0x00000000BFFFF500 000086 (v01 AMAZON AMZNAPIC 00000001 AMZN 00000001)
[    0.007734] ACPI: SRAT 0x00000000BFFFF440 0000C0 (v01 AMAZON AMZNSRAT 00000001 AMZN 00000001)
[    0.007737] ACPI: SLIT 0x00000000BFFFF3D0 00006C (v01 AMAZON AMZNSLIT 00000001 AMZN 00000001)
[    0.007740] ACPI: WAET 0x00000000BFFFF3A0 000028 (v01 AMAZON AMZNWAET 00000001 AMZN 00000001)
[    0.007746] ACPI: Local APIC address 0xfee00000
[    0.007754] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.007781] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.007784] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.007786] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.007788] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.007791] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xbfffffff]
[    0.007795] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83fffffff]
[    0.007807] NUMA: Initialized distance table, cnt=1
[    0.007809] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x8229fffff] -> [mem 0x00000000-0x8229fffff]
[    0.007819] NODE_DATA(0) allocated [mem 0x8229d4000-0x8229fefff]
[    0.007854] crashkernel: memory value expected
[    0.061830] Zone ranges:
[    0.061839]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.061843]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.061845]   Normal   [mem 0x0000000100000000-0x00000008229fffff]
[    0.061846]   Device   empty
[    0.061848] Movable zone start for each node
[    0.061850] Early memory node ranges
[    0.061851]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.061853]   node   0: [mem 0x0000000000100000-0x00000000bfff9fff]
[    0.061855]   node   0: [mem 0x0000000100000000-0x00000008229fffff]
[    0.061859] Initmem setup node 0 [mem 0x0000000000001000-0x00000008229fffff]
[    0.061861] On node 0 totalpages: 8268184
[    0.061863]   DMA zone: 64 pages used for memmap
[    0.061864]   DMA zone: 158 pages reserved
[    0.061864]   DMA zone: 3998 pages, LIFO batch:0
[    0.062131]   DMA zone: 28770 pages in unavailable ranges
[    0.062133]   DMA32 zone: 12224 pages used for memmap
[    0.062135]   DMA32 zone: 782330 pages, LIFO batch:63
[    0.067315]   DMA32 zone: 6 pages in unavailable ranges
[    0.067319]   Normal zone: 116904 pages used for memmap
[    0.067320]   Normal zone: 7481856 pages, LIFO batch:63
[    0.116987]   Normal zone: 22016 pages in unavailable ranges
[    0.117396] ACPI: PM-Timer IO Port: 0xb008
[    0.117399] ACPI: Local APIC address 0xfee00000
[    0.117410] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.117440] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.117444] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.117447] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.117449] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.117450] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.117452] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.117454] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.117455] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.117456] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.117458] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 00
[    0.117459] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.117460] Int: type 0, pol 0, trig 0, bus 00, IRQ 02, APIC ID 0, APIC INT 02
[    0.117462] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.117463] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.117464] ACPI: IRQ5 used by override.
[    0.117465] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.117466] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.117467] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.117469] ACPI: IRQ9 used by override.
[    0.117469] ACPI: IRQ10 used by override.
[    0.117470] ACPI: IRQ11 used by override.
[    0.117470] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.117472] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.117473] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.117474] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.117476] Using ACPI (MADT) for SMP configuration information
[    0.117478] TSC deadline timer available
[    0.117479] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.117485] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.117507] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.117511] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.117513] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.117515] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.117518] PM: hibernation: Registered nosave memory: [mem 0xbfffa000-0xbfffffff]
[    0.117521] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xdfffffff]
[    0.117523] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xe03fffff]
[    0.117525] PM: hibernation: Registered nosave memory: [mem 0xe0400000-0xfffbffff]
[    0.117527] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.117531] [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.117533] Booting paravirtualized kernel on KVM
[    0.117536] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.122887] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.123225] percpu: Embedded 54 pages/cpu s184320 r8192 d28672 u524288
[    0.123231] pcpu-alloc: s184320 r8192 d28672 u524288 alloc=1*2097152
[    0.123235] pcpu-alloc: [0] 0 1 2 3 
[    0.123757] kvm-guest: stealtime: cpu 0, msr 802c2c080
[    0.123763] Built 1 zonelists, mobility grouping on.  Total pages: 8138834
[    0.123765] Policy zone: Normal
[    0.123767] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/boot/vmlinuz-5.12.0-rc3+ root=UUID=949779ce-46aa-434e-8eb0-852514a5d69e ro console=ttyS0,115200n8 console=tty0 net.ifnames=0 rd.blacklist=nouveau nvme_core.io_timeout=4294967295 crashkernel=auto apic=verbose
[    0.128459] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.130751] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.130798] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.213680] Memory: 32370920K/33072736K available (14345K kernel code, 2561K rwdata, 4736K rodata, 2208K init, 5216K bss, 701556K reserved, 0K cma-reserved)
[    0.213693] random: get_random_u64 called from __kmem_cache_create+0x2a/0x560 with crng_init=0
[    0.213781] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.213791] Kernel/User page tables isolation: enabled
[    0.213808] ftrace: allocating 42230 entries in 165 pages
[    0.227722] ftrace: allocated 165 pages with 4 groups
[    0.227808] rcu: Hierarchical RCU implementation.
[    0.227809] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.227811] 	Rude variant of Tasks RCU enabled.
[    0.227813] 	Tracing variant of Tasks RCU enabled.
[    0.227813] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.227814] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.231127] NR_IRQS: 16640, nr_irqs: 456, preallocated irqs: 16
[    0.231277] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.338581] Console: colour VGA+ 80x25
[    0.729074] printk: console [tty0] enabled
[    0.872627] printk: console [ttyS0] enabled
[    0.875276] ACPI: Core revision 20210105
[    0.877851] APIC: Switch to symmetric I/O mode setup
[    0.880877] x2apic enabled
[    0.922866] Switched APIC routing to physical x2apic.
[    0.925759] masked ExtINT on CPU#0
[    0.928965] ENABLING IO-APIC IRQs
[    0.931305] init IO_APIC IRQs
[    0.931312] IOAPIC[0]: Preconfigured routing entry (0-0 -> IRQ 0 Level:0 ActiveLow:0)
[    0.931316] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
[    0.931320] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 2 Level:0 ActiveLow:0)
[    0.931324] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
[    0.931327] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
[    0.931329] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
[    0.931332] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
[    0.931334] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
[    0.931337] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
[    0.931340] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
[    0.931343] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
[    0.931347] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
[    0.931352] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
[    0.931355] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
[    0.931358] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
[    0.931360] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
[    0.931361]  apic 0 pin 16 not connected
[    0.931362]  apic 0 pin 17 not connected
[    0.931363]  apic 0 pin 18 not connected
[    0.931363]  apic 0 pin 19 not connected
[    0.931364]  apic 0 pin 20 not connected
[    0.931364]  apic 0 pin 21 not connected
[    0.931365]  apic 0 pin 22 not connected
[    0.931365]  apic 0 pin 23 not connected
[    0.931368] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x240937b9988, max_idle_ns: 440795218083 ns
[    0.937150] Calibrating delay loop (skipped) preset value.. 4999.99 BogoMIPS (lpj=2499998)
[    0.938147] pid_max: default: 32768 minimum: 301
[    0.938147] LSM: Security Framework initializing
[    0.938147] Yama: becoming mindful.
[    0.938147] SELinux:  Initializing.
[    0.938147] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.938147] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.938147] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.938147] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.938147] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.938147] Spectre V2 : Mitigation: Full generic retpoline
[    0.938147] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.938147] Speculative Store Bypass: Vulnerable
[    0.938147] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.938147] Freeing SMP alternatives memory: 36K
[    0.938147] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1351
[    0.938147] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8259CL CPU @ 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
[    0.938276] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
[    0.939197] rcu: Hierarchical SRCU implementation.
[    0.940471] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.941223] smp: Bringing up secondary CPUs ...
[    0.942245] x86: Booting SMP configuration:
[    0.943151] .... node  #0, CPUs:      #1
[    0.706863] kvm-clock: cpu 1, msr 45a201041, secondary cpu clock
[    0.706863] masked ExtINT on CPU#1
[    0.945668] kvm-guest: stealtime: cpu 1, msr 802cac080
[    0.949172]  #2
[    0.706863] kvm-clock: cpu 2, msr 45a201081, secondary cpu clock
[    0.706863] masked ExtINT on CPU#2
[    0.951782] kvm-guest: stealtime: cpu 2, msr 802d2c080
[    0.955207] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.956261]  #3
[    0.706863] kvm-clock: cpu 3, msr 45a2010c1, secondary cpu clock
[    0.706863] masked ExtINT on CPU#3
[    0.958648] kvm-guest: stealtime: cpu 3, msr 802dac080
[    0.961174] smp: Brought up 1 node, 4 CPUs
[    0.962153] smpboot: Max logical packages: 1
[    0.963153] smpboot: Total of 4 processors activated (19999.98 BogoMIPS)
[    0.965467] devtmpfs: initialized
[    0.967203] x86/mm: Memory block size: 128MB
[    0.972249] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.977161] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.981234] pinctrl core: initialized pinctrl subsystem
[    0.984367] PM: RTC time: 08:20:55, date: 2021-03-18
[    0.987284] NET: Registered protocol family 16
[    0.990265] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.994158] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.999160] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    1.004160] audit: initializing netlink subsys (disabled)
[    1.007175] audit: type=2000 audit(1616055654.068:1): state=initialized audit_enabled=0 res=1
[    1.007237] thermal_sys: Registered thermal governor 'fair_share'
[    1.012153] thermal_sys: Registered thermal governor 'bang_bang'
[    1.015151] thermal_sys: Registered thermal governor 'step_wise'
[    1.018152] thermal_sys: Registered thermal governor 'user_space'
[    1.022172] cpuidle: using governor menu
[    1.027295] ACPI: bus type PCI registered
[    1.030152] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.034275] PCI: Using configuration type 1 for base access
[    1.038654] Kprobes globally optimized
[    1.039177] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.040155] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.325318] cryptd: max_cpu_qlen set to 1000
[    1.327191] alg: No test for 842 (842-generic)
[    1.330165] alg: No test for 842 (842-scomp)
[    1.335294] ACPI: Added _OSI(Module Device)
[    1.338159] ACPI: Added _OSI(Processor Device)
[    1.340153] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.343151] ACPI: Added _OSI(Processor Aggregator Device)
[    1.346152] ACPI: Added _OSI(Linux-Dell-Video)
[    1.349151] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.352151] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.355943] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    1.359868] ACPI: Interpreter enabled
[    1.362160] ACPI: (supports S0 S4 S5)
[    1.365151] ACPI: Using IOAPIC for interrupt routing
[    1.368163] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.373387] ACPI: Enabled 16 GPEs in block 00 to 0F
[    1.377966] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.381154] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    1.386158] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    1.392418] acpiphp: Slot [3] registered
[    1.395172] acpiphp: Slot [4] registered
[    1.398165] acpiphp: Slot [5] registered
[    1.400164] acpiphp: Slot [6] registered
[    1.403165] acpiphp: Slot [7] registered
[    1.406163] acpiphp: Slot [8] registered
[    1.408164] acpiphp: Slot [9] registered
[    1.411164] acpiphp: Slot [10] registered
[    1.413164] acpiphp: Slot [11] registered
[    1.416164] acpiphp: Slot [12] registered
[    1.419164] acpiphp: Slot [13] registered
[    1.421165] acpiphp: Slot [14] registered
[    1.424164] acpiphp: Slot [15] registered
[    1.426162] acpiphp: Slot [16] registered
[    1.429163] acpiphp: Slot [17] registered
[    1.432163] acpiphp: Slot [18] registered
[    1.434163] acpiphp: Slot [19] registered
[    1.437169] acpiphp: Slot [20] registered
[    1.439167] acpiphp: Slot [21] registered
[    1.442165] acpiphp: Slot [22] registered
[    1.445169] acpiphp: Slot [23] registered
[    1.447164] acpiphp: Slot [24] registered
[    1.450164] acpiphp: Slot [25] registered
[    1.453164] acpiphp: Slot [26] registered
[    1.455167] acpiphp: Slot [27] registered
[    1.458166] acpiphp: Slot [28] registered
[    1.460164] acpiphp: Slot [29] registered
[    1.463166] acpiphp: Slot [30] registered
[    1.466163] acpiphp: Slot [31] registered
[    1.468159] PCI host bridge to bus 0000:00
[    1.471151] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.474150] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.478151] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.483150] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    1.487151] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.490183] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.494518] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.498059] pci 0000:00:01.3: [8086:7113] type 00 class 0x000000
[    1.501863] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    1.507164] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB
[    1.511200] pci 0000:00:01.3: PIIX4 devres E PIO at fff0-ffff
[    1.514164] pci 0000:00:01.3: PIIX4 devres F MMIO at ffc00000-ffffffff
[    1.517164] pci 0000:00:01.3: PIIX4 devres G PIO at fff0-ffff
[    1.520164] pci 0000:00:01.3: PIIX4 devres H MMIO at ffc00000-ffffffff
[    1.524164] pci 0000:00:01.3: PIIX4 devres I PIO at fff0-ffff
[    1.527167] pci 0000:00:01.3: PIIX4 devres J PIO at fff0-ffff
[    1.530151] pci 0000:00:01.3: quirk_piix4_acpi+0x0/0x170 took 27343 usecs
[    1.533402] pci 0000:00:03.0: [1d0f:1111] type 00 class 0x030000
[    1.537432] pci 0000:00:03.0: reg 0x10: [mem 0xfe400000-0xfe7fffff pref]
[    1.541926] pci 0000:00:03.0: reg 0x30: [mem 0xfebd0000-0xfebdffff pref]
[    1.545400] pci 0000:00:04.0: [1d0f:8061] type 00 class 0x010802
[    1.550151] pci 0000:00:04.0: reg 0x10: [mem 0xfebf0000-0xfebf3fff]
[    1.557635] pci 0000:00:05.0: [1d0f:ec20] type 00 class 0x020000
[    1.561978] pci 0000:00:05.0: reg 0x10: [mem 0xfebf4000-0xfebf7fff]
[    1.566532] pci 0000:00:05.0: reg 0x18: [mem 0xfe800000-0xfe8fffff pref]
[    1.571151] pci 0000:00:05.0: reg 0x20: [mem 0xfebe0000-0xfebeffff]
[    1.576734] pci 0000:00:1f.0: [1d0f:cd01] type 00 class 0x010802
[    1.580574] pci 0000:00:1f.0: reg 0x10: [mem 0xfebf8000-0xfebfbfff]
[    1.584820] pci 0000:00:1f.0: reg 0x18: [mem 0xfe900000-0xfe901fff pref]
[    1.590158] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.593246] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.596235] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.599236] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.602192] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.606180] iommu: Default domain type: Translated 
[    1.609172] pci 0000:00:03.0: vgaarb: setting as boot VGA device
[    1.610147] pci 0000:00:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.617155] pci 0000:00:03.0: vgaarb: bridge control possible
[    1.620150] vgaarb: loaded
[    1.622276] SCSI subsystem initialized
[    1.625167] libata version 3.00 loaded.
[    1.625188] ACPI: bus type USB registered
[    1.628165] usbcore: registered new interface driver usbfs
[    1.631162] usbcore: registered new interface driver hub
[    1.634159] usbcore: registered new device driver usb
[    1.637168] pps_core: LinuxPPS API ver. 1 registered
[    1.640150] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.645153] PTP clock support registered
[    1.648168] EDAC MC: Ver: 3.0.0
[    1.650332] NetLabel: Initializing
[    1.653151] NetLabel:  domain hash size = 128
[    1.656150] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.659164] NetLabel:  unlabeled traffic allowed by default
[    1.662153] PCI: Using ACPI for IRQ routing
[    1.757157] PCI: pci_cache_line_size set to 64 bytes
[    1.757284] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.757286] e820: reserve RAM buffer [mem 0xbfffa000-0xbfffffff]
[    1.757287] e820: reserve RAM buffer [mem 0x822a00000-0x823ffffff]
[    1.757298] clocksource: Switched to clocksource kvm-clock
[    1.769940] VFS: Disk quotas dquot_6.6.0
[    1.772541] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.776078] pnp: PnP ACPI init
[    1.778427] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.778455] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.778473] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.778518] pnp 00:03: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.778556] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.778734] pnp: PnP ACPI: found 5 devices
[    1.787842] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.793317] NET: Registered protocol family 2
[    1.796186] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    1.801537] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    1.806890] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    1.811891] TCP: Hash tables configured (established 262144 bind 65536)
[    1.815357] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    1.818998] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    1.824044] NET: Registered protocol family 1
[    1.826777] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.830057] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.833323] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.836800] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    1.840341] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.843579] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.846896] pci 0000:00:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.852133] PCI: CLS 0 bytes, default 64
[    1.854753] Unpacking initramfs...
[    2.253857] Freeing initrd memory: 29436K
[    2.256486] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.259901] software IO TLB: mapped [mem 0x00000000bbffa000-0x00000000bfffa000] (64MB)
[    2.265057] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x240937b9988, max_idle_ns: 440795218083 ns
[    2.270792] clocksource: Switched to clocksource tsc
[    2.274247] Initialise system trusted keyrings
[    2.277003] Key type blacklist registered
[    2.279669] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    2.284138] zbud: loaded
[    2.294065] NET: Registered protocol family 38
[    2.296823] Key type asymmetric registered
[    2.299451] Asymmetric key parser 'x509' registered
[    2.302311] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    2.307538] io scheduler mq-deadline registered
[    2.310402] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    2.314093] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.317660] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.322622] ACPI: button: Power Button [PWRF]
[    2.325416] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    2.330365] ACPI: button: Sleep Button [SLPF]
[    2.333467] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.337013] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.343447] Non-volatile memory driver v1.3
[    2.346128] Linux agpgart interface v0.103
[    2.349163] libphy: Fixed MDIO Bus: probed
[    2.351808] e1000e: Intel(R) PRO/1000 Network Driver
[    2.354693] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.357959] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.361334] ehci-pci: EHCI PCI platform driver
[    2.364097] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.367363] ohci-pci: OHCI PCI platform driver
[    2.370108] uhci_hcd: USB Universal Host Controller Interface driver
[    2.373481] usbcore: registered new interface driver usbserial_generic
[    2.376886] usbserial: USB Serial support registered for generic
[    2.380123] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    2.385464] i8042: Warning: Keylock active
[    2.388883] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.391778] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.394805] mousedev: PS/2 mouse device common for all mice
[    2.398043] rtc_cmos 00:00: RTC can wake from S4
[    2.401540] rtc_cmos 00:00: registered as rtc0
[    2.404472] rtc_cmos 00:00: setting system clock to 2021-03-18T08:20:56 UTC (1616055656)
[    2.409589] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
[    2.412899] device-mapper: uevent: version 1.0.3
[    2.415754] device-mapper: ioctl: 4.44.0-ioctl (2021-02-01) initialised: dm-devel@redhat.com
[    2.421042] intel_pstate: P-states controlled by the platform
[    2.424254] hid: raw HID events driver (C) Jiri Kosina
[    2.427234] usbcore: registered new interface driver usbhid
[    2.430303] usbhid: USB HID core driver
[    2.432913] drop_monitor: Initializing network drop monitor service
[    2.436316] Initializing XFRM netlink socket
[    2.439097] NET: Registered protocol family 10
[    2.444539] Segment Routing with IPv6
[    2.447074] mip6: Mobile IPv6
[    2.449322] NET: Registered protocol family 17
[    2.452485] IPI shorthand broadcast: enabled
[    2.455250] ... APIC ID:      00000000 (0)
[    2.456249] ... APIC VERSION: 00050014
[    2.456249] 0000000000000000000000000000000000000000000000000000000000000000
[    2.456249] 0000000000000000000000000000000000000000000000000000000000000000
[    2.456249] 0000000000000000000000000000000000000000000000000000000000001000

[    2.462608] number of MP IRQ sources: 16.
[    2.462610] number of IO-APIC #0 registers: 24.
[    2.462611] testing the IO APIC.......................
[    2.465591] IO APIC #0......
[    2.465593] .... register #00: 00000000
[    2.465593] .......    : physical APIC id: 00
[    2.465594] .......    : Delivery Type: 0
[    2.465595] .......    : LTS          : 0
[    2.465595] .... register #01: 00170011
[    2.465596] .......     : max redirection entries: 17
[    2.465596] .......     : PRQ implemented: 0
[    2.465597] .......     : IO APIC version: 11
[    2.465597] .... register #02: 00000000
[    2.465598] .......     : arbitration: 00
[    2.465599] .... IRQ redirection table:
[    2.465599] IOAPIC 0:
[    2.465609]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465616]  pin01, enabled , edge , high, V(21), IRR(0), S(0), physical, D(0002), M(0)
[    2.465625]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465631]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465640]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465647]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465656]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465662]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465671]  pin08, enabled , edge , high, V(21), IRR(0), S(0), physical, D(0001), M(0)
[    2.465678]  pin09, enabled , level, high, V(21), IRR(0), S(0), physical, D(0000), M(0)
[    2.465687]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465693]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465702]  pin0c, enabled , edge , high, V(22), IRR(0), S(0), physical, D(0000), M(0)
[    2.465709]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465718]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465724]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465733]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465740]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465749]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465755]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465764]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465771]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465780]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465786]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[    2.465787] IRQ to pin mappings:
[    2.465789] IRQ0 -> 0:0
[    2.465790] IRQ1 -> 0:1
[    2.465792] IRQ2 -> 0:2
[    2.465793] IRQ3 -> 0:3
[    2.465794] IRQ4 -> 0:4
[    2.465796] IRQ5 -> 0:5
[    2.465797] IRQ6 -> 0:6
[    2.465798] IRQ7 -> 0:7
[    2.465799] IRQ8 -> 0:8
[    2.465800] IRQ9 -> 0:9
[    2.465802] IRQ10 -> 0:10
[    2.465803] IRQ11 -> 0:11
[    2.465804] IRQ12 -> 0:12
[    2.465806] IRQ13 -> 0:13
[    2.465807] IRQ14 -> 0:14
[    2.465808] IRQ15 -> 0:15
[    2.465810] .................................... done.
[    2.468769] AVX2 version of gcm_enc/dec engaged.
[    2.471661] AES CTR mode by8 optimization enabled
[    2.489637] sched_clock: Marking stable (1783764532, 705863102)->(2595325738, -105698104)
[    2.494921] registered taskstats version 1
[    2.497569] Loading compiled-in X.509 certificates
[    2.500488] zswap: loaded using pool lzo/zbud
[    2.503280] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    2.508814] Key type ._fscrypt registered
[    2.511514] Key type .fscrypt registered
[    2.514134] Key type fscrypt-provisioning registered
[    2.519235] Key type encrypted registered
[    2.521853] ima: No TPM chip found, activating TPM-bypass!
[    2.524927] ima: Allocated hash algorithm: sha1
[    2.527733] ima: No architecture policies found
[    2.530714] PM:   Magic number: 13:451:321
[    2.533456] tty tty46: hash matches
[    2.535990] memory memory175: hash matches
[    2.538796] RAS: Correctable Errors collector initialized.
[    2.542897] Freeing unused decrypted memory: 2036K
[    2.546264] Freeing unused kernel image (initmem) memory: 2208K
[    2.556164] Write protecting the kernel read-only data: 22528k
[    2.559961] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    2.563767] Freeing unused kernel image (rodata/data gap) memory: 1408K
[    2.644395] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.647819] rodata_test: all tests were successful
[    2.650738] x86/mm: Checking user space page tables
[    2.727948] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.731327] Run /init as init process
[    2.733819]   with arguments:
[    2.733821]     /init
[    2.733822]   with environment:
[    2.733822]     HOME=/
[    2.733823]     TERM=linux
[    2.733823]     BOOT_IMAGE=(hd0,gpt2)/boot/vmlinuz-5.12.0-rc3+
[    2.733824]     crashkernel=auto
[    2.741408] systemd[1]: systemd 239 (239-41.el8_3) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=legacy)
[    2.753725] systemd[1]: Detected virtualization kvm.
[    2.756708] systemd[1]: Detected architecture x86-64.
[    2.759662] systemd[1]: Running in initial RAM disk.
[    2.777408] systemd[1]: No hostname configured.
[    2.780166] systemd[1]: Set hostname to <localhost>.
[    2.783159] systemd[1]: Initializing machine ID from KVM UUID.
[    2.829470] random: systemd: uninitialized urandom read (16 bytes read)
[    2.832979] systemd[1]: Reached target Local File Systems.
[    2.838386] random: systemd: uninitialized urandom read (16 bytes read)
[    2.841842] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    2.849459] random: systemd: uninitialized urandom read (16 bytes read)
[    2.852893] systemd[1]: Reached target Swap.
[    2.904656] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    3.554632] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input4
[    3.858634] ena 0000:00:05.0: ENA device version: 0.10
[    3.862179] ena 0000:00:05.0: ENA controller version: 0.0.1 implementation version 1
[    3.880365] nvme nvme0: pci function 0000:00:04.0
[    3.884144] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    3.888622] nvme nvme1: pci function 0000:00:1f.0
[    3.897772] nvme nvme0: 2/0/0 default/read/poll queues
[    3.905994] nvme nvme1: 4/0/0 default/read/poll queues
[    3.907239] ena 0000:00:05.0: Elastic Network Adapter (ENA) found at mem febf4000, mac addr 0a:82:97:cd:ec:be
[    3.917009]  nvme0n1: p1 p2
[    4.126713] random: fast init done
[    4.450339] SGI XFS with security attributes, no debug enabled
[    4.475617] XFS (nvme0n1p2): Mounting V5 Filesystem
[    4.516940] XFS (nvme0n1p2): Ending clean mount
[    4.895076] systemd-journald[230]: Received SIGTERM from PID 1 (systemd).
[    4.916442] printk: systemd: 30 output lines suppressed due to ratelimiting
[    5.074234] audit: type=1404 audit(1616055659.169:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
[    5.256129] SELinux:  Permission watch in class filesystem not defined in policy.
[    5.261169] SELinux:  Permission watch in class file not defined in policy.
[    5.264685] SELinux:  Permission watch_mount in class file not defined in policy.
[    5.269577] SELinux:  Permission watch_sb in class file not defined in policy.
[    5.274474] SELinux:  Permission watch_with_perm in class file not defined in policy.
[    5.279449] SELinux:  Permission watch_reads in class file not defined in policy.
[    5.284324] SELinux:  Permission watch in class dir not defined in policy.
[    5.287770] SELinux:  Permission watch_mount in class dir not defined in policy.
[    5.292613] SELinux:  Permission watch_sb in class dir not defined in policy.
[    5.296154] SELinux:  Permission watch_with_perm in class dir not defined in policy.
[    5.301109] SELinux:  Permission watch_reads in class dir not defined in policy.
[    5.305962] SELinux:  Permission watch in class lnk_file not defined in policy.
[    5.310783] SELinux:  Permission watch_mount in class lnk_file not defined in policy.
[    5.315779] SELinux:  Permission watch_sb in class lnk_file not defined in policy.
[    5.320699] SELinux:  Permission watch_with_perm in class lnk_file not defined in policy.
[    5.325817] SELinux:  Permission watch_reads in class lnk_file not defined in policy.
[    5.330762] SELinux:  Permission watch in class chr_file not defined in policy.
[    5.335578] SELinux:  Permission watch_mount in class chr_file not defined in policy.
[    5.340533] SELinux:  Permission watch_sb in class chr_file not defined in policy.
[    5.345433] SELinux:  Permission watch_with_perm in class chr_file not defined in policy.
[    5.350549] SELinux:  Permission watch_reads in class chr_file not defined in policy.
[    5.355544] SELinux:  Permission watch in class blk_file not defined in policy.
[    5.360361] SELinux:  Permission watch_mount in class blk_file not defined in policy.
[    5.365359] SELinux:  Permission watch_sb in class blk_file not defined in policy.
[    5.370260] SELinux:  Permission watch_with_perm in class blk_file not defined in policy.
[    5.375333] SELinux:  Permission watch_reads in class blk_file not defined in policy.
[    5.380302] SELinux:  Permission watch in class sock_file not defined in policy.
[    5.385151] SELinux:  Permission watch_mount in class sock_file not defined in policy.
[    5.390141] SELinux:  Permission watch_sb in class sock_file not defined in policy.
[    5.395091] SELinux:  Permission watch_with_perm in class sock_file not defined in policy.
[    5.400207] SELinux:  Permission watch_reads in class sock_file not defined in policy.
[    5.405194] SELinux:  Permission watch in class fifo_file not defined in policy.
[    5.410053] SELinux:  Permission watch_mount in class fifo_file not defined in policy.
[    5.415045] SELinux:  Permission watch_sb in class fifo_file not defined in policy.
[    5.419946] SELinux:  Permission watch_with_perm in class fifo_file not defined in policy.
[    5.425056] SELinux:  Permission watch_reads in class fifo_file not defined in policy.
[    5.430092] SELinux:  Permission perfmon in class capability2 not defined in policy.
[    5.435025] SELinux:  Permission bpf in class capability2 not defined in policy.
[    5.439856] SELinux:  Permission checkpoint_restore in class capability2 not defined in policy.
[    5.445112] SELinux:  Permission perfmon in class cap2_userns not defined in policy.
[    5.450064] SELinux:  Permission bpf in class cap2_userns not defined in policy.
[    5.454894] SELinux:  Permission checkpoint_restore in class cap2_userns not defined in policy.
[    5.460175] SELinux:  Class perf_event not defined in policy.
[    5.463289] SELinux:  Class lockdown not defined in policy.
[    5.466344] SELinux:  Class anon_inode not defined in policy.
[    5.469447] SELinux: the above unknown classes and permissions will be allowed
[    5.476618] SELinux:  policy capability network_peer_controls=1
[    5.479809] SELinux:  policy capability open_perms=1
[    5.482704] SELinux:  policy capability extended_socket_class=1
[    5.485866] SELinux:  policy capability always_check_network=0
[    5.489019] SELinux:  policy capability cgroup_seclabel=1
[    5.492030] SELinux:  policy capability nnp_nosuid_transition=1
[    5.495197] SELinux:  policy capability genfs_seclabel_symlinks=0
[    5.532485] audit: type=1403 audit(1616055659.627:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
[    5.534920] systemd[1]: Successfully loaded SELinux policy in 462.163ms.
[    5.593259] systemd[1]: Relabelled /dev, /run and /sys/fs/cgroup in 17.446ms.
[    5.693569] systemd[1]: systemd 239 (239-41.el8_3) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=legacy)
[    5.705671] systemd[1]: Detected virtualization kvm.
[    5.708569] systemd[1]: Detected architecture x86-64.
[    5.729083] systemd[1]: Set hostname to <ip-172-31-38-195.eu-central-1.compute.internal>.
[    6.250876] systemd[1]: systemd-journald.service: Succeeded.
[    6.254983] systemd[1]: initrd-switch-root.service: Succeeded.
[    6.258435] systemd[1]: Stopped Switch Root.
[    6.263894] systemd[1]: systemd-journald.service: Service has no hold-off time (RestartSec=0), scheduling restart.
[    6.269790] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    6.275097] systemd[1]: Stopped Journal Service.
[    6.386727] xfs filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
[    6.558622] systemd-journald[518]: Received request to flush runtime journal from PID 1
[    6.664952] audit: type=1400 audit(1616055660.759:4): avc:  denied  { fowner } for  pid=566 comm="auditd" capability=3  scontext=system_u:system_r:auditd_t:s0 tcontext=system_u:system_r:auditd_t:s0 tclass=capability permissive=0
[    6.676876] audit: type=1400 audit(1616055660.759:5): avc:  denied  { fowner } for  pid=566 comm="auditd" capability=3  scontext=system_u:system_r:auditd_t:s0 tcontext=system_u:system_r:auditd_t:s0 tclass=capability permissive=0
[    6.688713] audit: type=1400 audit(1616055660.759:6): avc:  denied  { fowner } for  pid=566 comm="auditd" capability=3  scontext=system_u:system_r:auditd_t:s0 tcontext=system_u:system_r:auditd_t:s0 tclass=capability permissive=0
[    6.699469] audit: type=1400 audit(1616055660.759:7): avc:  denied  { fowner } for  pid=566 comm="auditd" capability=3  scontext=system_u:system_r:auditd_t:s0 tcontext=system_u:system_r:auditd_t:s0 tclass=capability permissive=0
[    6.711396] audit: type=1400 audit(1616055660.759:8): avc:  denied  { fowner } for  pid=566 comm="auditd" capability=3  scontext=system_u:system_r:auditd_t:s0 tcontext=system_u:system_r:auditd_t:s0 tclass=capability permissive=0
[    6.722301] audit: type=1305 audit(1616055660.763:9): op=set audit_pid=566 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[    6.879000] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0xb100, revision 255
[    8.657170] random: crng init done
[    8.659985] random: 7 urandom warning(s) missed due to ratelimiting
[   10.346161] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--=-=-=--

