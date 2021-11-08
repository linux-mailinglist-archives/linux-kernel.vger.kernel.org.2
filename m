Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426EB449EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbhKHW21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 17:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbhKHW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 17:28:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CCAC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 14:25:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so867640wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Qge0eH1dUT1P7SjLTWeLmFH+igBLjVG/rAH5BlkFHvg=;
        b=RlUdf0k8Ix64uYJu1x8CLj6hrsGgpqcoesvrKqzl37i/daoKklVKNnQbE9N7NBVwzf
         IQ8x1/uXfL39U1iNM0jE/zIhz+CIRyEKGLTGyyDw5QVaKyzJ2Z5/VsArE8waZn/9ENs9
         chl0T/WHJEsLJbd5KrXeHZtWGIMippOT56vnM76ggXZdUwTj224uv2AE5FdBmsqPGbqL
         5Va+CiE3gnBxZx6Kig6E3KK3eWp4pUip4DdcSizSMqmeGjtN/cXm384MgPqt+XEhDnpg
         dy7YnZ0tuGE85Aqwmk0n7WPyc2eT3+mDeVMM2C+ab1yDe9lv/RL57njHvjkDqaR7cYFl
         2y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Qge0eH1dUT1P7SjLTWeLmFH+igBLjVG/rAH5BlkFHvg=;
        b=MJ6YSHCNinhIYO2c+EzaixY9pvXONd9tH9XEPOFacJjLjj20NyS/7VKkQv2dc12F18
         bATFGY/2mMNXIEcULj/I0Zxw6e7xSVY/JVw6/kytfRjnoL1Tm4qQhqgy6fjw2CbU69UC
         oE6d1IYoqRZRlP3HAK3yPsSvaYHIxwEXbqhL0Qcb/bb1N+foqhmlze0sPO9Vi5HImehR
         1UhD9aNoeI7ue02Ne1YMXfB96L09CJoQaflJrbgWnFJ4YW51vIcXVYjbM5CkbCk0y3uf
         2fN68fADic8xkpnCXBK4aF4UefjKpTqoCIaJ+vKYcovL3yVWdZmTWkK/puzAghtrcAJe
         fcZQ==
X-Gm-Message-State: AOAM5322Rp4i+eoGaXd2C+4wFY/qej+Ie4362VM90axMXGauy63pAUc6
        EargNMLjLDTK4w==
X-Google-Smtp-Source: ABdhPJzrBanuCyz18tAdLexlQHr3Dhc6onMrIHqL7vuyjPRHmKScYJ1tpL9rGQHEuA+yrvW2zYts2w==
X-Received: by 2002:a1c:447:: with SMTP id 68mr1789801wme.69.1636410338871;
        Mon, 08 Nov 2021 14:25:38 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id n13sm18214213wrt.44.2021.11.08.14.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 14:25:38 -0800 (PST)
From:   "Colin King (gmail)" <colin.i.king@googlemail.com>
X-Google-Original-From: "Colin King (gmail)" <colin.i.king@gmail.com>
Message-ID: <4ab6e843-b902-24d2-14fe-c28133e52ea0@gmail.com>
Date:   Mon, 8 Nov 2021 22:25:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: DEAD callback error for CPU, WARNING: CPU: 3 PID: 1134 at
 kernel/cpu.c:1163 _cpu_down+0x20a/0x3a0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Colin King (gmail)" <colin.i.king@googlemail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f6a0f4be-ad53-489c-0036-09dead99f368@gmail.com>
 <YYjb0OZxlDJpA6wr@hirez.programming.kicks-ass.net>
In-Reply-To: <YYjb0OZxlDJpA6wr@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2021 08:12, Peter Zijlstra wrote:
> On Sun, Nov 07, 2021 at 11:59:17AM +0000, Colin King (gmail) wrote:
>> On a SMP system in a VM, a deadlock callback error can be reproduced with
>> 5.15, tested from head at commit d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
>>
>> Didn't see this issue on 5.13
>>
>> How to reproduce:
>>
>> git clone https://github.com/ColinIanKing/stress-ng
>> cd stress-ng
>> make -j $(nproc)
>> sudo ./stress-ng --cpu-online 0 -t 15 --pathological
>>
>> Tested on a 8 thread virtual machine, 4MB of memory.
>>
>> [ 2239.378724] smpboot: CPU 6 is now offline
>> [ 2239.379443] smpboot: Booting Node 0 Processor 6 APIC 0x6
>> [ 2239.380169] kvm-clock: cpu 6, msr 79201181, secondary cpu clock
>> [ 2239.401652] ------------[ cut here ]------------
>> [ 2239.401658] DEAD callback error for CPU6
>> [ 2239.401721] WARNING: CPU: 3 PID: 1134 at kernel/cpu.c:1163
>> _cpu_down+0x20a/0x3a0
> 
> Can you do the same with whatever magic is required to get the
> pr_debug() output from cpuhp_down_callbacks() included?
>
reproducer is actually very easy:

# echo 0 > /sys/devices/system/cpu/cpu7/online


[   75.258042] smpboot: CPU 7 is now offline
[   75.258093] CPU DOWN failed (-22) CPU 7 state padata:dead (39)
[   75.258193] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   75.258380] kvm-clock: cpu 7, msr 1042011c1, secondary cpu clock
[   75.278828] ------------[ cut here ]------------
[   75.278830] DEAD callback error for CPU7
[   75.278856] WARNING: CPU: 1 PID: 1078 at kernel/cpu.c:1163 
_cpu_down+0x20a/0x3a0
[   75.278865] Modules linked in: dm_multipath scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua intel_rapl_msr intel_rapl_common snd_hda_codec_generic 
ledtrig_audio kvm_intel snd_hda_intel snd_intel_dspcfg 
snd_intel_sdw_acpi snd_hda_codec kvm snd_hda_core rapl input_leds 
snd_hwdep joydev snd_pcm snd_timer snd serio_raw qemu_fw_cfg mac_hid 
soundcore sch_fq_codel msr virtio_rng ip_tables x_tables autofs4 btrfs 
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 
raid0 multipath linear qxl drm_ttm_helper ttm drm_kms_helper syscopyarea 
sysfillrect sysimgblt fb_sys_fops hid_generic crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel cec aesni_intel rc_core crypto_simd 
virtio_net net_failover usbhid i2c_i801 ahci psmouse cryptd hid 
i2c_smbus drm lpc_ich libahci virtio_blk failover
[   75.278920] CPU: 1 PID: 1078 Comm: bash Not tainted 5.15.0+ #1
[   75.278924] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.14.0-2 04/01/2014
[   75.278925] RIP: 0010:_cpu_down+0x20a/0x3a0
[   75.278927] Code: 8b 03 41 39 c6 7f 6f 39 45 c0 0f 8e 34 ff ff ff 3d 
96 00 00 00 0f 84 be 00 00 00 44 89 ee 48 c7 c7 f3 38 7a a4 e8 26 a2 f9 
ff <0f> 0b e9 13 ff ff ff e8 3a bd 52 ff e9 2a ff ff ff f0 48 0f b3 05
[   75.278929] RSP: 0018:ffffb12600d03c98 EFLAGS: 00010282
[   75.278930] RAX: 0000000000000000 RBX: ffff8e9d7bde0660 RCX: 
0000000000000000
[   75.278931] RDX: 0000000000000001 RSI: ffffffffa47b6099 RDI: 
00000000ffffffff
[   75.278932] RBP: ffffb12600d03cd8 R08: 0000000000000000 R09: 
ffffb12600d03a88
[   75.278933] R10: ffffb12600d03a80 R11: ffffffffa5156908 R12: 
0000000000000000
[   75.278934] R13: 0000000000000007 R14: 0000000000000096 R15: 
00000000ffffffea
[   75.278935] FS:  00007f5b0014a740(0000) GS:ffff8e9d7bc40000(0000) 
knlGS:0000000000000000
[   75.278937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.278937] CR2: 000055f4a4e58818 CR3: 0000000115042005 CR4: 
0000000000370ee0
[   75.278940] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   75.278941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   75.278942] Call Trace:
[   75.278943]  <TASK>
[   75.278950]  cpu_device_down+0x34/0x60
[   75.278953]  cpu_subsys_offline+0xe/0x10
[   75.278956]  device_offline+0xe6/0x110
[   75.278957]  online_store+0x53/0xc0
[   75.278959]  dev_attr_store+0x17/0x30
[   75.278962]  sysfs_kf_write+0x3e/0x50
[   75.278964]  kernfs_fop_write_iter+0x137/0x1c0
[   75.278966]  new_sync_write+0x117/0x1a0
[   75.278970]  vfs_write+0x211/0x2a0
[   75.278978]  ksys_write+0x67/0xe0
[   75.278982]  __x64_sys_write+0x19/0x20
[   75.278984]  do_syscall_64+0x5c/0xc0
[   75.279000]  ? irqentry_exit_to_user_mode+0x9/0x20
[   75.279002]  ? irqentry_exit+0x33/0x40
[   75.279004]  ? exc_page_fault+0x89/0x180
[   75.279005]  ? asm_exc_page_fault+0x8/0x30
[   75.279008]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   75.279010] RIP: 0033:0x7f5b00264777
[   75.279016] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   75.279018] RSP: 002b:00007ffed5e83b58 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   75.279020] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f5b00264777
[   75.279021] RDX: 0000000000000002 RSI: 000055d8774e0b10 RDI: 
0000000000000001
[   75.279022] RBP: 000055d8774e0b10 R08: 0000000000000000 R09: 
00007f5b00365cf0
[   75.279023] R10: 00007f5b00365cc0 R11: 0000000000000246 R12: 
0000000000000002
[   75.279024] R13: 00007f5b00366760 R14: 00007f5b00367560 R15: 
00007f5b00366960
[   75.279029]  </TASK>

Colin


