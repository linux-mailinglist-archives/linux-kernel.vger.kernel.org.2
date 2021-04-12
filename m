Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8DD35D2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbhDLWFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbhDLWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:05:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:05:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p23so13505954ljn.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/4qcPJV5s4/eIgJ6PIpee8H1MiM+0gCMlsb8z+L93LM=;
        b=TeHzDkOmNlrQ3luD6Z0PJEQHmYGBdFbvQOt9W2oB4LM7Igdr/VXsO+3xw9S+bPBBLP
         SaJn+m+fIO47aTkqet65omaz2Ynwz5fcNbt/AwTaM/rbxT1GfwaCiIm+2IoxzVgsecML
         /0xqXHbjEregT2bgQCPUJqtxpvD2LyNxGHweUArgskNK0rCC9MxGHQJUesmhUvgn+g6X
         m/B9jGNMhP6zsk7TW/Y7uRsNQqdOXkpgc6q5D5N9LxHklsMJ8Ej68fPnGGEVR2rXTrHu
         TJzrdMNIdcsEfE58CPGfyZi8Ep85tN/RnbD3vvXV+8KJjHMu6T1Fm6TkNqLYjkXzDCkj
         RT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/4qcPJV5s4/eIgJ6PIpee8H1MiM+0gCMlsb8z+L93LM=;
        b=LKg3Mxc/n4Tfvg+KzeoSrtXPxxuGuMjXGZmKNjjRW3PemLgQyL0oBiBV7nAOFXisUZ
         f1mOpeC04fqyY3aziGl6OzpkZ2vAq+ZfV7K+A+DruEP7Iv7iYjABXwoCxmikMJGH7Diq
         aKUAxeiM3c1T7EJPxxlGEejuE+xjGf6uiC519EDcg+mvZRbyGPHA7r0yaEroZF+YMQU/
         9J4HtYKu1FlGcmnLX/2LSyu+Smn7ZJLS2QNr2e1dRbcRX4Zo/rLO5EFwa7b53k4lXxy6
         7MCLYY9SmvbQa4QZ9UEHierP8/yby0uE3p1xint9o4bzuzHE4LB9ZyHn5fy9AnD0IQdv
         4SiQ==
X-Gm-Message-State: AOAM530X38Plujqa3f0wWFMaMzNQ8fjrgF2YknIxlzFY68WuGRd/AoA3
        RojECGjuMbTsuaG2zMHgU51L1YVVifU+gGg1OVYSDT/Sx/7jaA==
X-Google-Smtp-Source: ABdhPJwcPCGAF8fwfDDDUbYMKd77kWENOzuPcdWDknQaQHei578CIyzkOp6zhicNDd3wITqY7V36q1s2fGnlZdRJHSs=
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr3885446ljo.370.1618265114929;
 Mon, 12 Apr 2021 15:05:14 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 13 Apr 2021 03:05:03 +0500
Message-ID: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
Subject: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video demonstration: https://youtu.be/3nkvUeB0GSw

How looks kernel traces.

1.
[ 7315.156460] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault
(src_id:0 ring:0 vmid:6 pasid:32779, for process obs pid 23963 thread
obs:cs0 pid 23977)
[ 7315.156490] amdgpu 0000:0b:00.0: amdgpu:   in page starting at
address 0x80011fdf5000 from client 18
[ 7315.156495] amdgpu 0000:0b:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00641A51
[ 7315.156500] amdgpu 0000:0b:00.0: amdgpu: Faulty UTCL2 client ID: VCN1 (0xd)
[ 7315.156503] amdgpu 0000:0b:00.0: amdgpu: MORE_FAULTS: 0x1
[ 7315.156505] amdgpu 0000:0b:00.0: amdgpu: WALKER_ERROR: 0x0
[ 7315.156509] amdgpu 0000:0b:00.0: amdgpu: PERMISSION_FAULTS: 0x5
[ 7315.156510] amdgpu 0000:0b:00.0: amdgpu: MAPPING_ERROR: 0x0
[ 7315.156513] amdgpu 0000:0b:00.0: amdgpu: RW: 0x1
[ 7315.156545] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault
(src_id:0 ring:0 vmid:6 pasid:32779, for process obs pid 23963 thread
obs:cs0 pid 23977)
[ 7315.156549] amdgpu 0000:0b:00.0: amdgpu:   in page starting at
address 0x80011fdf6000 from client 18
[ 7315.156551] amdgpu 0000:0b:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00641A51
[ 7315.156554] amdgpu 0000:0b:00.0: amdgpu: Faulty UTCL2 client ID: VCN1 (0xd)
[ 7315.156556] amdgpu 0000:0b:00.0: amdgpu: MORE_FAULTS: 0x1
[ 7315.156559] amdgpu 0000:0b:00.0: amdgpu: WALKER_ERROR: 0x0
[ 7315.156561] amdgpu 0000:0b:00.0: amdgpu: PERMISSION_FAULTS: 0x5
[ 7315.156564] amdgpu 0000:0b:00.0: amdgpu: MAPPING_ERROR: 0x0
[ 7315.156566] amdgpu 0000:0b:00.0: amdgpu: RW: 0x1

This is a harmless panic, but nevertheless VAAPI does not work and the
application that tried to use the encoder crashed.

2.
If we tries again and again encode 4K stream through VAAPI we can
encounter the next trace:
[12341.860944] ------------[ cut here ]------------
[12341.860961] kernel BUG at drivers/dma-buf/dma-resv.c:287!
[12341.860968] invalid opcode: 0000 [#1] SMP NOPTI
[12341.860972] CPU: 28 PID: 18261 Comm: kworker/28:0 Tainted: G
W        --------- ---  5.12.0-0.rc5.180.fc35.x86_64+debug #1
[12341.860977] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[12341.860981] Workqueue: events amdgpu_irq_handle_ih_soft [amdgpu]
[12341.861102] RIP: 0010:dma_resv_add_shared_fence+0x2ab/0x2c0
[12341.861108] Code: fd ff ff be 01 00 00 00 e8 e2 74 dc ff e9 ac fd
ff ff 48 83 c4 18 be 03 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c5
74 dc ff <0f> 0b 31 ed e9 73 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
90 0f
[12341.861112] RSP: 0018:ffffb2f084c87bb0 EFLAGS: 00010246
[12341.861115] RAX: 0000000000000002 RBX: ffff9f9551184998 RCX: 0000000000000000
[12341.861119] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9f9551184a50
[12341.861122] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[12341.861124] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f91b9a18140
[12341.861127] R13: ffff9f91c9020740 R14: ffff9f91c9020768 R15: 0000000000000000
[12341.861130] FS:  0000000000000000(0000) GS:ffff9f984a200000(0000)
knlGS:0000000000000000
[12341.861133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12341.861136] CR2: 0000144e080d8000 CR3: 000000010e98c000 CR4: 0000000000350ee0
[12341.861139] Call Trace:
[12341.861143]  amdgpu_vm_sdma_commit+0x182/0x220 [amdgpu]
[12341.861251]  amdgpu_vm_bo_update_mapping.constprop.0+0x278/0x3c0 [amdgpu]
[12341.861356]  amdgpu_vm_handle_fault+0x145/0x290 [amdgpu]
[12341.861461]  gmc_v10_0_process_interrupt+0xb3/0x250 [amdgpu]
[12341.861571]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[12341.861577]  ? lock_acquire+0x179/0x3a0
[12341.861583]  ? lock_acquire+0x179/0x3a0
[12341.861587]  ? amdgpu_irq_dispatch+0xc6/0x240 [amdgpu]
[12341.861692]  amdgpu_irq_dispatch+0xc6/0x240 [amdgpu]
[12341.861796]  amdgpu_ih_process+0x90/0x110 [amdgpu]
[12341.861900]  process_one_work+0x2b0/0x5e0
[12341.861906]  worker_thread+0x55/0x3c0
[12341.861910]  ? process_one_work+0x5e0/0x5e0
[12341.861915]  kthread+0x13a/0x150
[12341.861918]  ? __kthread_bind_mask+0x60/0x60
[12341.861922]  ret_from_fork+0x22/0x30
[12341.861928] Modules linked in: uinput snd_seq_dummy rfcomm
snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
joydev hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb mt76_usb
mt76x02_lib intel_rapl_msr intel_rapl_common mt76 iwlmvm mac80211
snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi btusb kvm_amd snd_hda_intel btrtl snd_intel_dspcfg
btbcm snd_intel_sdw_acpi snd_usb_audio uvcvideo btintel snd_hda_codec
videobuf2_vmalloc snd_usbmidi_lib videobuf2_memops iwlwifi kvm
bluetooth snd_rawmidi snd_hda_core snd_seq videobuf2_v4l2 snd_hwdep
videobuf2_common snd_seq_device eeepc_wmi snd_pcm videodev asus_wmi
sparse_keymap libarc4 mc irqbypass snd_timer ecdh_generic cfg80211
video
[12341.861969]  wmi_bmof rapl ecc snd sp5100_tco k10temp i2c_piix4
soundcore rfkill acpi_cpufreq ip_tables amdgpu drm_ttm_helper ttm
iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul cec crc32_pclmul
crc32c_intel drm ghash_clmulni_intel igb nvme ccp dca nvme_core
i2c_algo_bit wmi pinctrl_amd fuse
[12341.862012] ---[ end trace 3503913ed2bda6ad ]---
[12341.862018] RIP: 0010:dma_resv_add_shared_fence+0x2ab/0x2c0
[12341.862024] Code: fd ff ff be 01 00 00 00 e8 e2 74 dc ff e9 ac fd
ff ff 48 83 c4 18 be 03 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c5
74 dc ff <0f> 0b 31 ed e9 73 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
90 0f
[12341.862028] RSP: 0018:ffffb2f084c87bb0 EFLAGS: 00010246
[12341.862035] RAX: 0000000000000002 RBX: ffff9f9551184998 RCX: 0000000000000000
[12341.862039] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9f9551184a50
[12341.862045] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[12341.862049] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f91b9a18140
[12341.862053] R13: ffff9f91c9020740 R14: ffff9f91c9020768 R15: 0000000000000000
[12341.862057] FS:  0000000000000000(0000) GS:ffff9f984a200000(0000)
knlGS:0000000000000000
[12341.862062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12341.862066] CR2: 0000144e080d8000 CR3: 000000010e98c000 CR4: 0000000000350ee0
[12341.862072] note: kworker/28:0[18261] exited with preempt_count 1
[12392.114261] BUG: workqueue lockup - pool cpus=28 node=0 flags=0x0
nice=0 stuck for 50s!
[12392.114276] Showing busy workqueues and worker pools:
[12392.114279] workqueue events: flags=0x0
[12392.114283]   pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=12/256 refcnt=14
[12392.114289]     in-flight: 26978:amdgpu_irq_handle_ih_soft [amdgpu]
[12392.114411]     pending: amdgpu_irq_handle_ih_soft [amdgpu],
free_work, kfree_rcu_monitor, free_obj_work, psi_avgs_work,
psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
drm_mode_rmfb_work_fn [drm] BAR(2588), event_mall_stutter [amdgpu]
[12392.114679]   pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=12/256 refcnt=13
[12392.114684]     pending: psi_avgs_work, psi_avgs_work,
psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
psi_avgs_work, psi_avgs_work
[12392.114704]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[12392.114708]     pending: kfree_rcu_monitor
[12392.114727] workqueue mm_percpu_wq: flags=0x8
[12392.114730]   pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[12392.114734]     pending: vmstat_update
[12392.114739]   pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[12392.114742]     pending: vmstat_update
[12392.114826] pool 56: cpus=28 node=0 flags=0x0 nice=0 hung=50s
workers=3 idle: 25238 14400
[12394.038243] watchdog: BUG: soft lockup - CPU#27 stuck for 22s! [obs:27017]
[12394.038262] Modules linked in: uinput snd_seq_dummy rfcomm
snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
joydev hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb mt76_usb
mt76x02_lib intel_rapl_msr intel_rapl_common mt76 iwlmvm mac80211
snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi btusb kvm_amd snd_hda_intel btrtl snd_intel_dspcfg
btbcm snd_intel_sdw_acpi snd_usb_audio uvcvideo btintel snd_hda_codec
videobuf2_vmalloc snd_usbmidi_lib videobuf2_memops iwlwifi kvm
bluetooth snd_rawmidi snd_hda_core snd_seq videobuf2_v4l2 snd_hwdep
videobuf2_common snd_seq_device eeepc_wmi snd_pcm videodev asus_wmi
sparse_keymap libarc4 mc irqbypass snd_timer ecdh_generic cfg80211
video
[12394.038306]  wmi_bmof rapl ecc snd sp5100_tco k10temp i2c_piix4
soundcore rfkill acpi_cpufreq ip_tables amdgpu drm_ttm_helper ttm
iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul cec crc32_pclmul
crc32c_intel drm ghash_clmulni_intel igb nvme ccp dca nvme_core
i2c_algo_bit wmi pinctrl_amd fuse
[12394.038328] irq event stamp: 0
[12394.038331] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[12394.038337] hardirqs last disabled at (0): [<ffffffffaa0ddafb>]
copy_process+0x91b/0x1e10
[12394.038343] softirqs last  enabled at (0): [<ffffffffaa0ddafb>]
copy_process+0x91b/0x1e10
[12394.038347] softirqs last disabled at (0): [<0000000000000000>] 0x0

This is much more dangerous and, as a rule, leads to system freezing.

Full traces uploaded here:
[1] https://pastebin.com/aAeazCP8
[2] https://pastebin.com/ZLUP8Xvs

It curious why ffmpeg does not cause such issues.
For example such command not cause kernel panic:
$ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0 -vf
'format=nv12,hwupload' -vaapi_device /dev/dri/renderD128 -vcodec
h264_vaapi output3.mp4

1. Anyway, the user app shouldn't break the kernel.
2. Command above not working as expected because framerate is not 60
on result video. The ended video is looking as grabbed at 1 frame per
second or even less.

My hardware:
$ inxi -bM
System:    Host: fedora Kernel:
5.12.0-0.rc6.20210408git454859c552da.186.fc35.x86_64 x86_64 bits: 64
Desktop: GNOME 40.0
           Distro: Fedora release 35 (Rawhide)
Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
v: Rev X.0x serial: <superuser required>
           UEFI: American Megatrends v: 3603 date: 03/20/2021
Battery:   ID-1: hidpp_battery_0 charge: N/A condition: N/A
CPU:       Info: 16-Core (2-Die) AMD Ryzen 9 3950X [MT MCP MCM] speed:
3433 MHz min/max: 2200/3500 MHz
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
           Device-2: AVerMedia Live Streamer CAM 513 type: USB driver:
hid-generic,usbhid,uvcvideo
           Device-3: AVerMedia Live Gamer Ultra-Video type: USB
driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
           Display: wayland server: X.Org 1.21.1 driver: loaded:
amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
           resolution: 3840x2160~60Hz
           OpenGL: renderer: AMD SIENNA_CICHLID (DRM 3.40.0
5.12.0-0.rc6.20210408git454859c552da.186.fc35.x86_64 LLVM 12.0.0)
           v: 4.6 Mesa 21.1.0-devel
Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
           Device-2: Intel I211 Gigabit Network driver: igb
Drives:    Local Storage: total: 11.36 TiB used: 10.84 TiB (95.4%)
Info:      Processes: 766 Uptime: 5h 12m Memory: 62.63 GiB used: 36.93
GiB (59.0%) Shell: Bash inxi: 3.3.03


-- 
Best Regards,
Mike Gavrilov.
