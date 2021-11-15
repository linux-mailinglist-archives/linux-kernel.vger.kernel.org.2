Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53749450000
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhKOId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:33:59 -0500
Received: from office.oderland.com ([91.201.60.5]:59548 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhKOId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:33:56 -0500
Received: from [193.180.18.161] (port=60136 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mmXOD-00Bzm6-7a; Mon, 15 Nov 2021 09:30:57 +0100
Message-ID: <3c296891-8f47-96e5-590c-102151c9af3f@oderland.se>
Date:   Mon, 15 Nov 2021 09:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: DEAD callback error for CPU, WARNING: CPU: 3 PID: 1134 at
 kernel/cpu.c:1163 _cpu_down+0x20a/0x3a0
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Colin King (gmail)" <colin.i.king@googlemail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f6a0f4be-ad53-489c-0036-09dead99f368@gmail.com>
 <YYjb0OZxlDJpA6wr@hirez.programming.kicks-ass.net>
 <4ab6e843-b902-24d2-14fe-c28133e52ea0@gmail.com>
 <11a0b52c-235d-4dcb-afe3-b18a8bea5917@oderland.se>
 <941c9027-4476-b66b-736d-6cec3301ef75@oderland.se>
 <d1a7dde4-bea2-26d4-2efa-82ad770d3804@linaro.org>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <d1a7dde4-bea2-26d4-2efa-82ad770d3804@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/21 23:20, Daniel Lezcano wrote:
> On 14/11/2021 21:00, Josef Johansson wrote:
>> On 11/14/21 11:32, Josef Johansson wrote:
>>> On 11/8/21 23:25, Colin King (gmail) wrote:
>>>> On 08/11/2021 08:12, Peter Zijlstra wrote:
>>>>> On Sun, Nov 07, 2021 at 11:59:17AM +0000, Colin King (gmail) wrote:
>>>>>> On a SMP system in a VM, a deadlock callback error can be reproduced
>>>>>> with
>>>>>> 5.15, tested from head at commit
>>>>>> d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> I think it is fixed
>
> https://lkml.org/lkml/2021/11/8/44
I tested this out and it works.
You can add Tested-By: josef@oderland.se if you'd like.

>>>>>> Didn't see this issue on 5.13
>>>>>>
>>>>>> How to reproduce:
>>>>>>
>>>>>> git clone https://github.com/ColinIanKing/stress-ng
>>>>>> cd stress-ng
>>>>>> make -j $(nproc)
>>>>>> sudo ./stress-ng --cpu-online 0 -t 15 --pathological
>>>>>>
>>>>>> Tested on a 8 thread virtual machine, 4MB of memory.
>>>>>>
>>>>>> [ 2239.378724] smpboot: CPU 6 is now offline
>>>>>> [ 2239.379443] smpboot: Booting Node 0 Processor 6 APIC 0x6
>>>>>> [ 2239.380169] kvm-clock: cpu 6, msr 79201181, secondary cpu clock
>>>>>> [ 2239.401652] ------------[ cut here ]------------
>>>>>> [ 2239.401658] DEAD callback error for CPU6
>>>>>> [ 2239.401721] WARNING: CPU: 3 PID: 1134 at kernel/cpu.c:1163
>>>>>> _cpu_down+0x20a/0x3a0
>>>>> Can you do the same with whatever magic is required to get the
>>>>> pr_debug() output from cpuhp_down_callbacks() included?
>>>>>
>>> I don't get this sentence at all. Is there some patch I should add?
>>>> reproducer is actually very easy:
>>>>
>>>> # echo 0 > /sys/devices/system/cpu/cpu7/online
>>>>
>>>>
>>>> [   75.258042] smpboot: CPU 7 is now offline
>>>> [   75.258093] CPU DOWN failed (-22) CPU 7 state padata:dead (39)
>>>> [   75.258193] smpboot: Booting Node 0 Processor 7 APIC 0x7
>>>> [   75.258380] kvm-clock: cpu 7, msr 1042011c1, secondary cpu clock
>>>> [   75.278828] ------------[ cut here ]------------
>>>> [   75.278830] DEAD callback error for CPU7
>>>> [   75.278856] WARNING: CPU: 1 PID: 1078 at kernel/cpu.c:1163
>>>> _cpu_down+0x20a/0x3a0
>>>> [   75.278865] Modules linked in: dm_multipath scsi_dh_rdac
>>>> scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common
>>>> snd_hda_codec_generic ledtrig_audio kvm_intel snd_hda_intel
>>>> snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm snd_hda_core
>>>> rapl input_leds snd_hwdep joydev snd_pcm snd_timer snd serio_raw
>>>> qemu_fw_cfg mac_hid soundcore sch_fq_codel msr virtio_rng ip_tables
>>>> x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456
>>>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>>>> raid6_pq libcrc32c raid1 raid0 multipath linear qxl drm_ttm_helper ttm
>>>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
>>>> hid_generic crct10dif_pclmul crc32_pclmul ghash_clmulni_intel cec
>>>> aesni_intel rc_core crypto_simd virtio_net net_failover usbhid
>>>> i2c_i801 ahci psmouse cryptd hid i2c_smbus drm lpc_ich libahci
>>>> virtio_blk failover
>>>> [   75.278920] CPU: 1 PID: 1078 Comm: bash Not tainted 5.15.0+ #1
>>>> [   75.278924] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>>>> BIOS 1.14.0-2 04/01/2014
>>>> [   75.278925] RIP: 0010:_cpu_down+0x20a/0x3a0
>>>> [   75.278927] Code: 8b 03 41 39 c6 7f 6f 39 45 c0 0f 8e 34 ff ff ff
>>>> 3d 96 00 00 00 0f 84 be 00 00 00 44 89 ee 48 c7 c7 f3 38 7a a4 e8 26
>>>> a2 f9 ff <0f> 0b e9 13 ff ff ff e8 3a bd 52 ff e9 2a ff ff ff f0 48 0f
>>>> b3 05
>>>> [   75.278929] RSP: 0018:ffffb12600d03c98 EFLAGS: 00010282
>>>> [   75.278930] RAX: 0000000000000000 RBX: ffff8e9d7bde0660 RCX:
>>>> 0000000000000000
>>>> [   75.278931] RDX: 0000000000000001 RSI: ffffffffa47b6099 RDI:
>>>> 00000000ffffffff
>>>> [   75.278932] RBP: ffffb12600d03cd8 R08: 0000000000000000 R09:
>>>> ffffb12600d03a88
>>>> [   75.278933] R10: ffffb12600d03a80 R11: ffffffffa5156908 R12:
>>>> 0000000000000000
>>>> [   75.278934] R13: 0000000000000007 R14: 0000000000000096 R15:
>>>> 00000000ffffffea
>>>> [   75.278935] FS:  00007f5b0014a740(0000) GS:ffff8e9d7bc40000(0000)
>>>> knlGS:0000000000000000
>>>> [   75.278937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   75.278937] CR2: 000055f4a4e58818 CR3: 0000000115042005 CR4:
>>>> 0000000000370ee0
>>>> [   75.278940] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [   75.278941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [   75.278942] Call Trace:
>>>> [   75.278943]  <TASK>
>>>> [   75.278950]  cpu_device_down+0x34/0x60
>>>> [   75.278953]  cpu_subsys_offline+0xe/0x10
>>>> [   75.278956]  device_offline+0xe6/0x110
>>>> [   75.278957]  online_store+0x53/0xc0
>>>> [   75.278959]  dev_attr_store+0x17/0x30
>>>> [   75.278962]  sysfs_kf_write+0x3e/0x50
>>>> [   75.278964]  kernfs_fop_write_iter+0x137/0x1c0
>>>> [   75.278966]  new_sync_write+0x117/0x1a0
>>>> [   75.278970]  vfs_write+0x211/0x2a0
>>>> [   75.278978]  ksys_write+0x67/0xe0
>>>> [   75.278982]  __x64_sys_write+0x19/0x20
>>>> [   75.278984]  do_syscall_64+0x5c/0xc0
>>>> [   75.279000]  ? irqentry_exit_to_user_mode+0x9/0x20
>>>> [   75.279002]  ? irqentry_exit+0x33/0x40
>>>> [   75.279004]  ? exc_page_fault+0x89/0x180
>>>> [   75.279005]  ? asm_exc_page_fault+0x8/0x30
>>>> [   75.279008]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [   75.279010] RIP: 0033:0x7f5b00264777
>>>> [   75.279016] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
>>>> 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
>>>> 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
>>>> 74 24
>>>> [   75.279018] RSP: 002b:00007ffed5e83b58 EFLAGS: 00000246 ORIG_RAX:
>>>> 0000000000000001
>>>> [   75.279020] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
>>>> 00007f5b00264777
>>>> [   75.279021] RDX: 0000000000000002 RSI: 000055d8774e0b10 RDI:
>>>> 0000000000000001
>>>> [   75.279022] RBP: 000055d8774e0b10 R08: 0000000000000000 R09:
>>>> 00007f5b00365cf0
>>>> [   75.279023] R10: 00007f5b00365cc0 R11: 0000000000000246 R12:
>>>> 0000000000000002
>>>> [   75.279024] R13: 00007f5b00366760 R14: 00007f5b00367560 R15:
>>>> 00007f5b00366960
>>>> [   75.279029]  </TASK>
>>>>
>>>> Colin
>>>>
>>>>
>>>>
>>>>
>>> Here is the same BUG but on Xen. I'm producing the error by suspending
>>> the laptop.
>>> For anyone following along, when you are bisecting this on Xen you need
>>> these two commits:
>>> 8aa83e6395ce047a506f0b16edca45f36c1ae7f8 ("x86/setup: Call
>>> early_reserve_memory() earlier")
>>> 96f5bd03e1be606987644b71899ea56a8d05f825 ("xen/balloon: fix balloon
>>> kthread freezing")
>>>
>>> ------------[ cut here ]------------
>>> DEAD callback error for CPU1
>>> WARNING: CPU: 2 PID: 21738 at kernel/cpu.c:1163 _cpu_down+0x143/0x230
>>> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wm>
>>> CPU: 2 PID: 21738 Comm: systemd-sleep Tainted: G        W         5.15.0-0.fc32.qubes.x86_64 #1
>>> Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
>>> RIP: e030:_cpu_down+0x143/0x230
>>> Code: 00 81 3b 96 00 00 00 7e a7 e9 75 ff ff ff 8b 03 44 39 f8 7d b2 3d 96 00 00 00 74 3f 89 ee 48 c7 c7 8b 4e 5e 82 e8 92 d3 f9 ff <0f> 0b eb 99 e8 c4 06 50 ff>
>>> RSP: e02b:ffffc9004273fd20 EFLAGS: 00010282
>>> RAX: 0000000000000000 RBX: ffff8881406606a0 RCX: ffff8881406a0a08
>>> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8881406a0a00
>>> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 000000000000001d R11: ffffffff834917cc R12: 00000000ffffffea
>>> R13: 0000000000000000 R14: 0000000000000001 R15: 00000000000000e4
>>> FS:  0000787200206b80(0000) GS:ffff888140680000(0000) knlGS:0000000000000000
>>> CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000059b42ea71da8 CR3: 0000000005ca0000 CR4: 0000000000050660
>>> Call Trace:
>>>  <TASK>
>>>  freeze_secondary_cpus.cold+0x3d/0x129
>>>  suspend_enter+0xb7/0x380
>>>  suspend_devices_and_enter+0x165/0x240
>>>  enter_state+0x125/0x176
>>>  pm_suspend.cold+0x20/0x6b
>>>  state_store+0x27/0x50
>>>  kernfs_fop_write_iter+0x124/0x1b0
>>>  new_sync_write+0x15c/0x1f0
>>>  vfs_write+0x1d2/0x270
>>>  ksys_write+0x67/0xe0
>>>  do_syscall_64+0x3b/0x90
>>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> RIP: 0033:0x7872013292f7
>>> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3>
>>> RSP: 002b:00007ffefc6d4718 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007872013292f7
>>> RDX: 0000000000000004 RSI: 00007ffefc6d4800 RDI: 0000000000000004
>>> RBP: 00007ffefc6d4800 R08: 00005817137c5ca0 R09: 000000000000000d
>>> R10: 00005817137c1eb0 R11: 0000000000000246 R12: 0000000000000004
>>> R13: 00005817137c12d0 R14: 0000000000000004 R15: 00007872013fb700
>>>  </TASK>
>>> ---[ end trace a9ab6f056496ed14 ]---
>>> Error taking CPU1 down: -22
>>>
>>> I'm actively bisecting this, ~6 iterations left, will propably have some more in ~6h or so.
>>>
>>> # git bisect log
>>> # bad: [0594c58161b6e0f3da8efa9c6e3d4ba52b652717] xen/x86: fix PV trap handling on secondary processors
>>> git bisect start 'HEAD'
>>> # good: [868c250bb4639531ff33b2d879fbef39c1d9ed39] x86/fpu: Include vmalloc.h for vzalloc()
>>> git bisect good 868c250bb4639531ff33b2d879fbef39c1d9ed39
>>> # bad: [6ab1d4839a486727fdd412bd8bab27417388d381] Merge tag 'platform-drivers-x86-v5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
>>> git bisect bad 6ab1d4839a486727fdd412bd8bab27417388d381
>>> # good: [84882cf72cd774cf16fd338bdbf00f69ac9f9194] Revert "net: avoid double accounting for pure zerocopy skbs"
>>> git bisect good 84882cf72cd774cf16fd338bdbf00f69ac9f9194
>>> # good: [79ef0c00142519bc34e1341447f3797436cc48bf] Merge tag 'trace-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
>>> git bisect good 79ef0c00142519bc34e1341447f3797436cc48bf
>>> # good: [e848c714dbda4d6f0ad17a4d374af0ce9fcd1615] Revert "drm/amd/display: Fix error in dmesg at boot"
>>> git bisect good e848c714dbda4d6f0ad17a4d374af0ce9fcd1615
>>> # good: [a64a325bf6313aa5cde7ecd691927e92892d1b7f] Merge tag 'afs-next-20211102' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
>>> git bisect good a64a325bf6313aa5cde7ecd691927e92892d1b7f
>>> # good: [d9bd054177fbd2c4762546aec40fc3071bfe4cc0] Merge tag 'amd-drm-next-5.16-2021-10-29' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
>>> git bisect good d9bd054177fbd2c4762546aec40fc3071bfe4cc0
>>> # bad: [833db72142b93a89211c1e43ca0a1e2e16457756] Merge tag 'pm-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>>> git bisect bad 833db72142b93a89211c1e43ca0a1e2e16457756
>>>
>>> Regards
>>> Josef
>>>
>> Here's the bad commit
>> 4570ddda43387e5a130dd85e71a1947b0c11da77 ("powercap/drivers/dtpm:
>> Encapsulate even more the code")
>>
>> Added CC: Lukasz Luba <lukasz.luba@arm.com> , Daniel Lezcano
>> <daniel.lezcano@linaro.org>
>>
>> Here's the bisect log:
>> # bad: [0594c58161b6e0f3da8efa9c6e3d4ba52b652717] xen/x86: fix PV trap
>> handling on secondary processors
>> git bisect start 'HEAD'
>> # good: [868c250bb4639531ff33b2d879fbef39c1d9ed39] x86/fpu: Include
>> vmalloc.h for vzalloc()
>> git bisect good 868c250bb4639531ff33b2d879fbef39c1d9ed39
>> # bad: [6ab1d4839a486727fdd412bd8bab27417388d381] Merge tag
>> 'platform-drivers-x86-v5.16-1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
>> git bisect bad 6ab1d4839a486727fdd412bd8bab27417388d381
>> # good: [84882cf72cd774cf16fd338bdbf00f69ac9f9194] Revert "net: avoid
>> double accounting for pure zerocopy skbs"
>> git bisect good 84882cf72cd774cf16fd338bdbf00f69ac9f9194
>> # good: [79ef0c00142519bc34e1341447f3797436cc48bf] Merge tag
>> 'trace-v5.16' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
>> git bisect good 79ef0c00142519bc34e1341447f3797436cc48bf
>> # good: [e848c714dbda4d6f0ad17a4d374af0ce9fcd1615] Revert
>> "drm/amd/display: Fix error in dmesg at boot"
>> git bisect good e848c714dbda4d6f0ad17a4d374af0ce9fcd1615
>> # good: [a64a325bf6313aa5cde7ecd691927e92892d1b7f] Merge tag
>> 'afs-next-20211102' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
>> git bisect good a64a325bf6313aa5cde7ecd691927e92892d1b7f
>> # good: [d9bd054177fbd2c4762546aec40fc3071bfe4cc0] Merge tag
>> 'amd-drm-next-5.16-2021-10-29' of
>> https://gitlab.freedesktop.org/agd5f/linux into drm-next
>> git bisect good d9bd054177fbd2c4762546aec40fc3071bfe4cc0
>> # bad: [833db72142b93a89211c1e43ca0a1e2e16457756] Merge tag
>> 'pm-5.16-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> git bisect bad 833db72142b93a89211c1e43ca0a1e2e16457756
>> # good: [33fb42636a938be01d951b4cee68127a59a1e7e4] Merge branch
>> 'ucount-fixes-for-v5.16' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
>> git bisect good 33fb42636a938be01d951b4cee68127a59a1e7e4
>> # good: [c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb] Merge tag
>> 'acpi-5.16-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> git bisect good c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb
>> # good: [b62b306469b36fae7030c0ad4ffa11de0c9b9957] Merge branch 'pm-sleep'
>> git bisect good b62b306469b36fae7030c0ad4ffa11de0c9b9957
>> # good: [8e5b4779f6c50d118b3056bbb07c886b9ff8d112] Merge branches
>> 'pm-cpufreq' and 'pm-cpuidle'
>> git bisect good 8e5b4779f6c50d118b3056bbb07c886b9ff8d112
>> # good: [e458716a92b57f854deb89bb40aa3554c2b6205e] PM: EM: Mark
>> inefficiencies in CPUFreq
>> git bisect good e458716a92b57f854deb89bb40aa3554c2b6205e
>> # good: [e458716a92b57f854deb89bb40aa3554c2b6205e] PM: EM: Mark
>> inefficiencies in CPUFreq
>> git bisect good e458716a92b57f854deb89bb40aa3554c2b6205e
>> # bad: [eb82bace893169b319c563b7f813c58a0a5a9f76] powercap/drivers/dtpm:
>> Scale the power with the load
>> git bisect bad eb82bace893169b319c563b7f813c58a0a5a9f76
>> # bad: [7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c] powercap/drivers/dtpm:
>> Simplify the dtpm table
>> git bisect bad 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
>>
>

