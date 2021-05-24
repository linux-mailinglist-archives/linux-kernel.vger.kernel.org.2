Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D839138E8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhEXOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:41:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232882AbhEXOlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:41:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621867223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsiN7cWNdntgDWK3h28QehgGXHPlEvJ99p0lBf10Xt0=;
        b=HUMqb2cvsqjKr9sfA8K2mi72D8sTqKqZmRtfX5/neLtMgnR3n3/uQ6yEU1m8GDCcw6iSUa
        F7ADlQmhbG4cykSfWi4pY8Y88xCF0bdP2PWJbVE1W7+wmo9sPHX/SH+JYPFaYBt/Asulsb
        j698tXVdGymjTtabhRpGiZbCCzGLqqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621867223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsiN7cWNdntgDWK3h28QehgGXHPlEvJ99p0lBf10Xt0=;
        b=117eibmi5GKwIOSRVnwSWJDNZnhGgAd7AYnO0RyujSGhuczMaPp8HKYEYShnFqrZJKx9ky
        CSoTd2BSzgaOVeBQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15323ADE2;
        Mon, 24 May 2021 14:40:23 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-6-afaerber@suse.de> <87fsylvhck.wl-maz@kernel.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH RFC 5/9] arm64: dts: rockchip: rk1808k-toybrick-m0:
 Suppress vGIC interrupt
Message-ID: <f9523a3c-16a7-16d1-4d2e-9994c3fe03d9@suse.de>
Date:   Mon, 24 May 2021 16:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87fsylvhck.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 11:29, Marc Zyngier wrote:
> On Mon, 17 May 2021 00:05:47 +0100,
> Andreas Färber <afaerber@suse.de> wrote:
>>
>> Avoid the kernel getting stuck after:
>>
>> [    1.175956] kvm [1]: IPA Size Limit: 40 bits
>> [    1.177164] kvm [1]: vgic-v2@ff320000
>> [    1.177545] kvm [1]: GIC system register CPU interface enabled
>>
>> or when dropping GICV reg entry:
>>
>> [    1.176001] kvm [1]: IPA Size Limit: 40 bits
>> [    1.177191] kvm [1]: GICv3: no GICV resource entry
>> [    1.177664] kvm [1]: disabling GICv2 emulation
>> [    1.178115] kvm [1]: GIC system register CPU interface enabled
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts b/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
>> index 2f8075d2391c..15293a8576c6 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
>> @@ -48,6 +48,10 @@ &cpu1 {
>>  	cpu-supply = <&vdd_cpu>;
>>  };
>>  
>> +&gic {
>> +	/delete-property/ interrupts;
>> +};
>> +
>>  &uart2 {
>>  	status = "okay";
>>  	clocks = <&xin24m>;
> 
> As I said in my reply to the cover letter, this is not an acceptable
> outcome. Please add some debug to kvm_vgic_hyp_init() to understand
> where this is hanging and why.

Many thanks for that pointer.

So, as alternative to dropping the DT interrupts property above, I could
also work around this issue by commenting out
vgic-init.c:vgic_init_cpu_starting()'s enable_percpu_irq() call.

Otherwise I am seeing the following call flow:

cpuhp_setup_state() -> __cpuhp_setup_state_cpuslocked() ->
cpuhp_issue_call() -> cpuhp_invoke_ap_callback() -> __cpuhp_kick_ap() ->
wait_for_ap_thread() -> wait_for_completion() --- doesn't return

With kvm_info() / printk():

[    1.244079] kvm [1]: IPA Size Limit: 40 bits

[    1.245205] kvm [1]: vgic-v2@ff320000

[    1.245584] kvm [1]: GIC system register CPU interface enabled

[    1.246177] kvm [1]: before cpuhp_setup_state

[    1.246605] __cpuhp_setup_state_cpuslocked: kvm/arm/vgic:starting

[    1.247198] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    1.247933] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    1.248745] cpuhp_issue_call: before invoke

[    1.249154] cpuhp_issue_call: before AP invoke

[    1.249585] cpuhp_invoke_ap_callback

[    1.249936] cpuhp_invoke_ap_callback: after cpu_online

[    1.250435] cpuhp_invoke_ap_callback: before st->thread

[    1.250944] cpuhp_invoke_ap_callback: after st->thread

[    1.251445] __cpuhp_kick_ap

[    1.251731] __cpuhp_kick_ap: not returned

[    1.252140] vgic_init_cpu_starting: 9

[    1.252507] vgic_init_cpu_starting: done

[    1.255538] __cpuhp_kick_ap: wait_for_ap_thread


Full serial output below.

Regards,
Andreas

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd042]

[    0.000000] Linux version 5.13.0-rc3-next-20210524+ (andreas@ryzen)
(aarch64-suse-linux-gcc (SUSE Linux) 10.3.0, GNU ld (GNU Binutils;
openSUSE Tumbleweed) 2.36.1.20210326-3) #17 SMP PREEMPT Mon May 24
16:21:21 CEST 2021

[    0.000000] Machine model: Rockchip Toybrick TB-RK1808M0

[    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff550000 (options '')

[    0.000000] printk: bootconsole [uart8250] enabled

[    0.000000] efi: UEFI not found.

[    0.000000] Zone ranges:

[    0.000000]   DMA      [mem 0x0000000000600000-0x000000003fffffff]

[    0.000000]   DMA32    empty

[    0.000000]   Normal   empty

[    0.000000] Movable zone start for each node

[    0.000000] Early memory node ranges

[    0.000000]   node   0: [mem 0x0000000000600000-0x000000003fffffff]

[    0.000000] Initmem setup node 0 [mem
0x0000000000600000-0x000000003fffffff]

[    0.000000] cma: Reserved 16 MiB at 0x000000003dc00000

[    0.000000] psci: probing for conduit method from DT.

[    0.000000] psci: PSCIv1.0 detected in firmware.

[    0.000000] psci: Using standard PSCI v0.2 function IDs

[    0.000000] psci: Trusted OS migration not required

[    0.000000] psci: SMC Calling Convention v1.0

[    0.000000] percpu: Embedded 23 pages/cpu s55016 r8192 d31000 u94208

[    0.000000] Detected VIPT I-cache on CPU0

[    0.000000] CPU features: detected: GIC system register CPU interface

[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 256536

[    0.000000] __cpuhp_setup_state_cpuslocked: mm/page_alloc:dead

[    0.000000] Kernel command line: earlycon=uart8250,mmio32,0xff550000
console=ttyS2,1500000n8 rootwait

[    0.000000] Dentry cache hash table entries: 131072 (order: 8,
1048576 bytes, linear)

[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)

[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off

[    0.000000] Memory: 984916K/1042432K available (7168K kernel code,
770K rwdata, 2964K rodata, 1344K init, 331K bss, 41132K reserved, 16384K
cma-reserved)

[    0.000000] __cpuhp_setup_state_cpuslocked: slub:dead

[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1

[    0.000000] __cpuhp_setup_state_cpuslocked: lib/radix:dead

[    0.000000] rcu: Preemptible hierarchical RCU implementation.

[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to
nr_cpu_ids=2.

[    0.000000]  Trampoline variant of Tasks RCU enabled.

[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.

[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2

[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0

[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode

[    0.000000] GICv3: 256 SPIs implemented

[    0.000000] GICv3: 0 Extended SPIs implemented

[    0.000000] GICv3: Distributor has no Range Selector support

[    0.000000] Root IRQ handler: gic_handle_irq

[    0.000000] GICv3: 16 PPIs implemented

[    0.000000] GICv3: CPU0: found redistributor 0 region
0:0x00000000ff140000

[    0.000000] __cpuhp_setup_state_cpuslocked: irqchip/arm/gicv3:starting

[    0.000000] ITS [mem 0xff120000-0xff13ffff]

[    0.000000] ITS@0x00000000ff120000: allocated 65536 Devices @1880000
(flat, esz 8, psz 64K, shr 0)

[    0.000000] ITS: using cache flushing for cmd queue

[    0.000000] GICv3: using LPI property table @0x0000000001830000

[    0.000000] GIC: using cache flushing for LPI property table

[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x0000000001840000

[    0.000000] random: get_random_bytes called from
start_kernel+0x494/0x614 with crng_init=0

[    0.000000] __cpuhp_setup_state_cpuslocked:
clockevents/arm/arch_timer:starting

[    0.000000] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    0.000000] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    0.000000] cpuhp_issue_call: before invoke

[    0.000000] cpuhp_issue_call: before AP invoke

[    0.000000] cpuhp_invoke_ap_callback

[    0.000000] cpuhp_invoke_ap_callback: after cpu_online

[    0.000000] cpuhp_invoke_ap_callback: before st->thread

[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).

[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns

[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps
every 4398046511097ns

[    0.000968] Console: colour dummy device 80x25

[    0.001441] Calibrating delay loop (skipped), value calculated using
timer frequency.. 48.00 BogoMIPS (lpj=96000)

[    0.002476] pid_max: default: 32768 minimum: 301

[    0.002964] __cpuhp_setup_state_cpuslocked: fork:vm_stack_cache

[    0.003593] LSM: Security Framework initializing

[    0.004129] Mount-cache hash table entries: 2048 (order: 2, 16384
bytes, linear)

[    0.004857] Mountpoint-cache hash table entries: 2048 (order: 2,
16384 bytes, linear)

[    0.005933] __cpuhp_setup_state_cpuslocked: mm/writeback:online

[    0.006558] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    0.007254] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    0.008064] cpuhp_issue_call: before invoke

[    0.008473] cpuhp_issue_call: before AP invoke

[    0.008905] cpuhp_invoke_ap_callback

[    0.009256] cpuhp_invoke_ap_callback: after cpu_online

[    0.009754] cpuhp_invoke_ap_callback: before st->thread

[    0.010268] __cpuhp_setup_state_cpuslocked: mm/writeback:dead

[    0.012315] __cpuhp_setup_state_cpuslocked: mm/vmstat:dead

[    0.012868] __cpuhp_setup_state_cpuslocked: mm/vmstat:online

[    0.013611] __cpuhp_setup_state_cpuslocked: softirq:dead

[    0.014275] rcu: Hierarchical SRCU implementation.

[    0.015066] dyndbg: Ignore empty _ddebug table in a
CONFIG_DYNAMIC_DEBUG_CORE build

[    0.015882] Platform MSI: msi-controller@ff120000 domain created

[    0.016519] PCI/MSI:
/soc/interrupt-controller@ff100000/msi-controller@ff120000 domain created

[    0.017376] EFI services will not be available.

[    0.017819] __cpuhp_setup_state_cpuslocked:
clockevents/dummy_timer:starting

[    0.018505] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    0.019267] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    0.020079] cpuhp_issue_call: before invoke

[    0.020488] cpuhp_issue_call: before AP invoke

[    0.020920] cpuhp_invoke_ap_callback

[    0.021271] cpuhp_invoke_ap_callback: after cpu_online

[    0.021771] cpuhp_invoke_ap_callback: before st->thread

[    0.022283] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
state 0

[    0.023281] smp: Bringing up secondary CPUs ...

[    0.024485] Detected VIPT I-cache on CPU1

[    0.024531] GICv3: CPU1: found redistributor 1 region
0:0x00000000ff160000

[    0.024551] GICv3: CPU1: using allocated LPI pending table
@0x0000000001850000

[    0.024602] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]

[    0.024654] __cpuhp_kick_ap

[    0.027331] __cpuhp_kick_ap: not returned

[    0.027728] __cpuhp_kick_ap: wait_for_ap_thread

[    0.028171] __cpuhp_kick_ap: done

[    0.028502] smp: Brought up 1 node, 2 CPUs

[    0.028907] SMP: Total of 2 processors activated.

[    0.029368] CPU features: detected: 32-bit EL0 Support

[    0.029870] CPU features: detected: 32-bit EL1 Support

[    0.030372] CPU features: detected: CRC32 instructions

[    0.031717] CPU: All CPU(s) started at EL2

[    0.032156] alternatives: patching kernel code

[    0.032935] __cpuhp_setup_state_cpuslocked: fs/buffer:dead

[    0.034270] devtmpfs: initialized

[    0.037183] __cpuhp_setup_state_cpuslocked: arm64/fpsimd:dead

[    0.038017] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns

[    0.038982] futex hash table entries: 512 (order: 3, 32768 bytes, linear)

[    0.040375] pinctrl core: initialized pinctrl subsystem

[    0.041738] DMI not present or invalid.

[    0.042723] NET: Registered protocol family 16

[    0.043303] __cpuhp_setup_state_cpuslocked: arm64/debug_monitors:starting

[    0.043972] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    0.044665] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    0.045500] cpuhp_issue_call: before invoke

[    0.045910] cpuhp_issue_call: before AP invoke

[    0.046344] cpuhp_invoke_ap_callback

[    0.046694] cpuhp_invoke_ap_callback: after cpu_online

[    0.047193] cpuhp_invoke_ap_callback: before st->thread

[    0.047702] cpuhp_invoke_ap_callback: after st->thread

[    0.048202] __cpuhp_kick_ap

[    0.048477] __cpuhp_kick_ap: not returned

[    0.048880] __cpuhp_kick_ap: wait_for_ap_thread

[    0.049323] __cpuhp_kick_ap: done

[    0.049658] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
state 225

[    0.050352] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
before cpuhp_issue_call

[    0.051161] cpuhp_issue_call: before invoke

[    0.051569] cpuhp_issue_call: before AP invoke

[    0.052002] cpuhp_invoke_ap_callback

[    0.052352] cpuhp_invoke_ap_callback: after cpu_online

[    0.052851] cpuhp_invoke_ap_callback: before st->thread

[    0.053359] cpuhp_invoke_ap_callback: after st->thread

[    0.053867] __cpuhp_kick_ap

[    0.054142] __cpuhp_kick_ap: not returned

[    0.054556] __cpuhp_kick_ap: wait_for_ap_thread

[    0.054998] __cpuhp_kick_ap: done

[    0.056849] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic
allocations

[    0.057739] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations

[    0.058708] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations

[    0.059573] audit: initializing netlink subsys (disabled)

[    0.060384] audit: type=2000 audit(0.060:1): state=initialized
audit_enabled=0 res=1

[    0.061259] thermal_sys: Registered thermal governor 'step_wise'

[    0.061274] thermal_sys: Registered thermal governor 'power_allocator'

[    0.061967] cpuidle: using governor menu

[    0.063094] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.

[    0.063791] __cpuhp_setup_state_cpuslocked:
perf/arm64/hw_breakpoint:starting

[    0.064488] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    0.065181] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    0.065992] cpuhp_issue_call: before invoke

[    0.066401] cpuhp_issue_call: before AP invoke

[    0.066833] cpuhp_invoke_ap_callback

[    0.067184] cpuhp_invoke_ap_callback: after cpu_online

[    0.067682] cpuhp_invoke_ap_callback: before st->thread

[    0.068206] cpuhp_invoke_ap_callback: after st->thread

[    0.068707] __cpuhp_kick_ap

[    0.068981] __cpuhp_kick_ap: not returned

[    0.069402] __cpuhp_kick_ap: wait_for_ap_thread

[    0.069846] __cpuhp_kick_ap: done

[    0.070172] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
state 225

[    0.070864] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
before cpuhp_issue_call

[    0.071673] cpuhp_issue_call: before invoke

[    0.072081] cpuhp_issue_call: before AP invoke

[    0.072526] cpuhp_invoke_ap_callback

[    0.072876] cpuhp_invoke_ap_callback: after cpu_online

[    0.073377] cpuhp_invoke_ap_callback: before st->thread

[    0.073886] cpuhp_invoke_ap_callback: after st->thread

[    0.074384] __cpuhp_kick_ap

[    0.074658] __cpuhp_kick_ap: not returned

[    0.075058] __cpuhp_kick_ap: wait_for_ap_thread

[    0.075499] __cpuhp_kick_ap: done

[    0.075828] ASID allocator initialised with 65536 entries

[    0.076502] Serial: AMBA PL011 UART driver

[    0.076990] __cpuhp_setup_state_cpuslocked: iommu/iova:dead

[    0.087186] __cpuhp_setup_state_cpuslocked: mm/compaction:online

[    0.087978] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages

[    0.088643] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages

[    0.089294] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages

[    0.089946] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages

[    0.091249] __cpuhp_setup_state_cpuslocked: mm/memctrl:dead

[    0.091867] __cpuhp_setup_state_cpuslocked: io-wq/online

[    0.095436] __cpuhp_setup_state_cpuslocked: block/softirq:dead

[    0.096023] __cpuhp_setup_state_cpuslocked: block/mq:dead

[    0.096549] __cpuhp_setup_state_cpuslocked: block/mq:online

[    0.165312] raid6: neonx8   gen()  1270 MB/s

[    0.233458] raid6: neonx8   xor()  1007 MB/s

[    0.301610] raid6: neonx4   gen()  1289 MB/s

[    0.369761] raid6: neonx4   xor()   991 MB/s

[    0.437926] raid6: neonx2   gen()  1208 MB/s

[    0.506077] raid6: neonx2   xor()   932 MB/s

[    0.574228] raid6: neonx1   gen()  1068 MB/s

[    0.642354] raid6: neonx1   xor()   786 MB/s

[    0.710510] raid6: int64x8  gen()   470 MB/s

[    0.778636] raid6: int64x8  xor()   289 MB/s

[    0.846831] raid6: int64x4  gen()   602 MB/s

[    0.914893] raid6: int64x4  xor()   327 MB/s

[    0.983048] raid6: int64x2  gen()   788 MB/s

[    1.051164] raid6: int64x2  xor()   425 MB/s

[    1.119322] raid6: int64x1  gen()   652 MB/s

[    1.187434] raid6: int64x1  xor()   347 MB/s

[    1.187857] raid6: using algorithm neonx4 gen() 1289 MB/s

[    1.188383] raid6: .... xor() 991 MB/s, rmw enabled

[    1.188861] raid6: using neon recovery algorithm

[    1.190118] vdd_cpu: supplied by vcc3v3_pcie

[    1.190933] iommu: Default domain type: Translated

[    1.191731] vgaarb: loaded

[    1.192430] SCSI subsystem initialized

[    1.193060] usbcore: registered new interface driver usbfs

[    1.193644] usbcore: registered new interface driver hub

[    1.194208] usbcore: registered new device driver usb

[    1.194850] pps_core: LinuxPPS API ver. 1 registered

[    1.195336] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>

[    1.196291] PTP clock support registered

[    1.197222] __cpuhp_setup_state_cpuslocked: perf/arm/pmu:starting

[    1.198409] __cpuhp_setup_state_cpuslocked: net/dev:dead

[    1.199515] clocksource: Switched to clocksource arch_sys_counter

[    1.200460] VFS: Disk quotas dquot_6.6.0

[    1.200916] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)

[    1.213721] NET: Registered protocol family 2

[    1.214283] IP idents hash table entries: 16384 (order: 5, 131072
bytes, linear)

[    1.216289] tcp_listen_portaddr_hash hash table entries: 512 (order:
2, 20480 bytes, linear)

[    1.217219] TCP established hash table entries: 8192 (order: 4, 65536
bytes, linear)

[    1.218045] TCP bind hash table entries: 8192 (order: 6, 262144
bytes, linear)

[    1.218924] TCP: Hash tables configured (established 8192 bind 8192)

[    1.219783] UDP hash table entries: 512 (order: 3, 49152 bytes, linear)

[    1.220483] UDP-Lite hash table entries: 512 (order: 3, 49152 bytes,
linear)

[    1.221370] NET: Registered protocol family 1

[    1.221831] PCI: CLS 0 bytes, default 64

[    1.222307] __cpuhp_setup_state_cpuslocked: arm64/cpuinfo:online

[    1.222898] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    1.223629] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    1.224445] cpuhp_issue_call: before invoke

[    1.224854] cpuhp_issue_call: before AP invoke

[    1.225287] cpuhp_invoke_ap_callback

[    1.225637] cpuhp_invoke_ap_callback: after cpu_online

[    1.226136] cpuhp_invoke_ap_callback: before st->thread

[    1.226645] cpuhp_invoke_ap_callback: after st->thread

[    1.227145] __cpuhp_kick_ap

[    1.227421] __cpuhp_kick_ap: not returned

[    1.227896] __cpuhp_kick_ap: wait_for_ap_thread

[    1.228345] __cpuhp_kick_ap: done

[    1.228672] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
state 225

[    1.229365] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 1:
before cpuhp_issue_call

[    1.230174] cpuhp_issue_call: before invoke

[    1.230582] cpuhp_issue_call: before AP invoke

[    1.231015] cpuhp_invoke_ap_callback

[    1.231366] cpuhp_invoke_ap_callback: after cpu_online

[    1.231894] cpuhp_invoke_ap_callback: before st->thread

[    1.232404] cpuhp_invoke_ap_callback: after st->thread

[    1.232905] __cpuhp_kick_ap

[    1.233178] __cpuhp_kick_ap: not returned

[    1.233576] __cpuhp_kick_ap: wait_for_ap_thread

[    1.234018] __cpuhp_kick_ap: done

[    1.234645] cpuhp_issue_call: before invoke

[    1.235062] cpuhp_issue_call: before AP invoke

[    1.235536] cpuhp_invoke_ap_callback

[    1.235890] cpuhp_invoke_ap_callback: after cpu_online

[    1.236391] cpuhp_invoke_ap_callback: before st->thread

[    1.236899] cpuhp_invoke_ap_callback: after st->thread

[    1.237399] __cpuhp_kick_ap

[    1.237672] __cpuhp_kick_ap: not returned

[    1.238100] __cpuhp_kick_ap: wait_for_ap_thread

[    1.238544] __cpuhp_kick_ap: done

[    1.238870] cpuhp_issue_call: before invoke

[    1.239277] cpuhp_issue_call: before AP invoke

[    1.239759] cpuhp_invoke_ap_callback

[    1.240111] cpuhp_invoke_ap_callback: after cpu_online

[    1.240609] cpuhp_invoke_ap_callback: before st->thread

[    1.241117] cpuhp_invoke_ap_callback: after st->thread

[    1.241617] __cpuhp_kick_ap

[    1.241891] __cpuhp_kick_ap: not returned

[    1.242289] __cpuhp_kick_ap: wait_for_ap_thread

[    1.242732] __cpuhp_kick_ap: done

[    1.243083] hw perfevents: enabled with armv8_cortex_a35 PMU driver,
7 counters available

[    1.244079] kvm [1]: IPA Size Limit: 40 bits

[    1.245205] kvm [1]: vgic-v2@ff320000

[    1.245584] kvm [1]: GIC system register CPU interface enabled

[    1.246177] kvm [1]: before cpuhp_setup_state

[    1.246605] __cpuhp_setup_state_cpuslocked: kvm/arm/vgic:starting

[    1.247198] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
state 225

[    1.247933] __cpuhp_setup_state_cpuslocked: for_each_present_cpu 0:
before cpuhp_issue_call

[    1.248745] cpuhp_issue_call: before invoke

[    1.249154] cpuhp_issue_call: before AP invoke

[    1.249585] cpuhp_invoke_ap_callback

[    1.249936] cpuhp_invoke_ap_callback: after cpu_online

[    1.250435] cpuhp_invoke_ap_callback: before st->thread

[    1.250944] cpuhp_invoke_ap_callback: after st->thread

[    1.251445] __cpuhp_kick_ap

[    1.251731] __cpuhp_kick_ap: not returned

[    1.252140] vgic_init_cpu_starting: 9

[    1.252507] vgic_init_cpu_starting: done

[    1.255538] __cpuhp_kick_ap: wait_for_ap_thread


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
