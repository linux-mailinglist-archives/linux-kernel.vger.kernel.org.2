Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F533C6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhCOTVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhCOTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:21:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:21:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q25so58641524lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy47D43oOL72YbeoX+eD8SpW9GzQquAlyVaKPa3cBbY=;
        b=X9MJ4UKx4oyxs8HzUqVHBkblgpklBzt4LF7Yr3dsqhY1YgX0cPg4T3qSFdBfKSMNFT
         mEvaueXnWq9Bqu0XS7o4kYvlW5pnjrkBK/daZmnKSIELMNgQf8ohGlMpxuWjHn++gQOg
         5OLfTzeHX4gLwwpozjjTIoYgmT39w436dPsF5pDsX+Ei7gd96eyu3K7qPQuUo0LqUPf6
         P/xQy62wblrBIGHWwrELBJ5XORIgyRbm/mFWFIhPFp9MFulIbYP7jxPCRB1PTdVLsOI8
         a2pmsYLfBk82mDeVzta/mK6oXH/cSAfghLB0HGaGvLWIxGPxut2kv7Cu5yOGGy2LlUop
         kcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy47D43oOL72YbeoX+eD8SpW9GzQquAlyVaKPa3cBbY=;
        b=I8uNIgdPfjS0Bl2NRpQmRrTq4IHdwLoSkLvL38xAnWUQohdFvjelLln6DI1UiLebjK
         Yw14oMafePQXKpVFWxuD5TNGdd8cCZewnheA2UM+mZTlirwihXI8mDqcbaILzf6BebXS
         yVtF+8LYZcQKpwJrJFUccAHOcSoh8qlbUmcKFV65XlSTFkz5BcUzUjiUVzRIOAZoJ+b6
         j9CMKSMMldOHeHTXb5lWV4d9hZmDKs5zI/+0g1zPMoedQHWSJlLt7iMaVXwIMtaR8u4u
         pqEZEhR4osU4ELkQDvggTX54oHFXX+FVK7gUL0gA77TMNSWId6ac7WMesVSY7iXO2dIK
         u+xg==
X-Gm-Message-State: AOAM533IbpukLP+P1xAP0+mbDU+iYPiv38KpQ4adZPSyxrzKjeWQVK3s
        IQb+rf4vTb9dp1P6F3uQ2F7Qq85euJRyfubXDNas2P8pZCcadw==
X-Google-Smtp-Source: ABdhPJz5kFMi+XjA6LHYquidteNdpODawLzC+N3idpz3Xl2daCpmgCMhp5Of2EhsiwxZUOjYOhJVipaHNQeF903EsXQ=
X-Received: by 2002:a05:6512:2019:: with SMTP id a25mr8558792lfb.166.1615836076337;
 Mon, 15 Mar 2021 12:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210126082834.2020-1-hdanton@sina.com> <CABXGCsNN+u2SqOvmw2JojTnESSLgxKgfJLQuB3Ne1fcNA47UZw@mail.gmail.com>
 <20210213030327.4992-1-hdanton@sina.com> <CABXGCsNAvXbOQxEWaHqf-iehX39OOOQwXBSJz7bZ6+68zn0tuA@mail.gmail.com>
 <20210301031107.1299-1-hdanton@sina.com> <CABXGCsNFW0XnGw5qn1f3LLYY_tqkn3CBES=iujS2arsuV7aLkQ@mail.gmail.com>
 <20210305142232.14680-1-hdanton@sina.com> <CABXGCsP0cvMAuG5A3EP8Nev1VxiL-hsGqHWrwgknckEe4vVZJQ@mail.gmail.com>
 <20210309023107.2172-1-hdanton@sina.com>
In-Reply-To: <20210309023107.2172-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 16 Mar 2021 00:21:05 +0500
Message-ID: <CABXGCsO7R3sgGhsu9Fo_ekCbELm6665mBcbfmJoe5Ttm-pX1DQ@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, MM <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 at 07:31, Hillf Danton <hdanton@sina.com> wrote:
> At the first glance, the zero pointer goes out of the box of race because
>
> 1/ the Call Trace shows it is the free path (of the supposed race victim),
>
> 2/ on the race winner side however either list_del or list_del_init
>    would not leave a null pointer behind - the list_add captured in this
>    report is under pool->lock.


No more ideas how to fix it?
Kernel panics continue happens again and again with you patches and
recent commits.

[102491.134247] ------------[ cut here ]------------
[102491.134248] list_add corruption. next->prev should be prev
(ffffcc447ea60c78), but was ffffffff8a64ec20. (next=ffff8adc731d3f40).
[102491.134266] ODEBUG: free active (active state 0) object type:
work_struct hint: compact_page_work+0x0/0x10
[102491.134294] ------------[ cut here ]------------
[102491.134295] kernel BUG at lib/list_debug.c:23!
[102491.134299] invalid opcode: 0000 [#1] SMP NOPTI
[102491.134301] CPU: 22 PID: 863413 Comm: kworker/u64:0 Tainted: G
   W        --------- ---
5.12.0-0.rc2.20210310git05a59d79793d.168.fc35.x86_64 #1
[102491.134303] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[102491.134305] Workqueue: zswap3 compact_page_work
[102491.134309] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[102491.134312] Code: 48 c7 c6 34 a9 64 8b 48 89 ef 49 c7 c7 ea ff ff
ff e8 91 81 01 00 e9 ac f5 9c ff 4c 89 c1 48 c7 c7 00 aa 64 8b e8 67
fd fd ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 b0 aa 64 8b e8 50
fd fd
[102491.134313] RSP: 0018:ffffac4494cabde0 EFLAGS: 00010282
[102491.134315] RAX: 0000000000000075 RBX: ffffe6ed86ac8580 RCX:
0000000000000000
[102491.134316] RDX: ffff8ae3497e97a0 RSI: ffff8ae3497daae0 RDI:
ffff8ae3497daae0
[102491.134316] RBP: ffffcc447ea60c78 R08: 0000000000000000 R09:
0000000000000000
[102491.134317] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8adc4e317a08
[102491.134318] R13: ffff8adceb216010 R14: ffff8adc731d3f40 R15:
ffff8adceb216000
[102491.134319] FS:  0000000000000000(0000) GS:ffff8ae349600000(0000)
knlGS:0000000000000000
[102491.134320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[102491.134320] CR2: 0000376f1d60afe8 CR3: 00000003b1c28000 CR4:
0000000000350ee0
[102491.134321] Call Trace:
[102491.134324]  do_compact_page+0x28d/0xb60
[102491.134326]  ? debug_object_deactivate+0x55/0x140
[102491.134329]  ? lock_release+0x1ef/0x410
[102491.134331]  ? lock_release+0x1ef/0x410
[102491.134333]  process_one_work+0x2b0/0x5e0
[102491.134337]  worker_thread+0x55/0x3c0
[102491.134339]  ? process_one_work+0x5e0/0x5e0
[102491.134340]  kthread+0x13a/0x150
[102491.134342]  ? __kthread_bind_mask+0x60/0x60
[102491.134345]  ret_from_fork+0x22/0x30
[102491.134349] Modules linked in: snd_seq_dummy snd_hrtimer nls_utf8
isofs uas usb_storage tun uinput rfcomm netconsole nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib
[102491.134375] WARNING: CPU: 18 PID: 182 at lib/debugobjects.c:505
debug_print_object+0x6e/0x90
[102491.134380]  nft_reject_inet nf_reject_ipv4
[102491.134383] Modules linked in:
[102491.134385]  nf_reject_ipv6 nft_reject
[102491.134388]  snd_seq_dummy
[102491.134390]  nft_ct
[102491.134393]  snd_hrtimer
[102491.134395]  nft_chain_nat nf_nat
[102491.134398]  nls_utf8
[102491.134400]  nf_conntrack nf_defrag_ipv6
[102491.134403]  isofs
[102491.134405]  nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep
zstd sunrpc vfat fat hid_logitech_hidpp hid_logitech_dj intel_rapl_msr
intel_rapl_common uvcvideo videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 snd_hda_codec_realtek videobuf2_common mt76x2u
mt76x2_common snd_hda_codec_generic mt76x02_usb iwlmvm videodev
edac_mce_amd snd_usb_audio ledtrig_audio snd_hda_codec_hdmi mt76_usb
mt76x02_lib snd_usbmidi_lib kvm_amd snd_hda_intel mt76 snd_rawmidi
snd_intel_dspcfg mc joydev snd_intel_sdw_acpi mac80211 kvm
snd_hda_codec snd_hda_core iwlwifi btusb snd_hwdep btrtl snd_seq btbcm
btintel eeepc_wmi asus_wmi snd_seq_device irqbypass xpad sparse_keymap
bluetooth libarc4 rapl snd_pcm video ff_memless wmi_bmof ecdh_generic
ecc cfg80211 pcspkr snd_timer k10temp snd sp5100_tco i2c_piix4
soundcore rfkill acpi_cpufreq binfmt_misc ip_tables amdgpu
drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul
crc32_pclmul crc32c_intel cec igb drm nvme ghash_clmulni_intel dca ccp
[102491.134476]  nvme_core i2c_algo_bit wmi pinctrl_amd fuse
[102491.134484] ---[ end trace 562b0b01453e6613 ]---
[102491.134505] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[102491.134509] Code: 48 c7 c6 34 a9 64 8b 48 89 ef 49 c7 c7 ea ff ff
ff e8 91 81 01 00 e9 ac f5 9c ff 4c 89 c1 48 c7 c7 00 aa 64 8b e8 67
fd fd ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 b0 aa 64 8b e8 50
fd fd
[102491.134511] RSP: 0018:ffffac4494cabde0 EFLAGS: 00010282
[102491.134514] RAX: 0000000000000075 RBX: ffffe6ed86ac8580 RCX:
0000000000000000
[102491.134992]  uas usb_storage tun uinput rfcomm netconsole
nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
[102491.135036] RDX: ffff8ae3497e97a0 RSI: ffff8ae3497daae0 RDI:
ffff8ae3497daae0
[102491.135039] RBP: ffffcc447ea60c78 R08: 0000000000000000 R09:
0000000000000000
[102491.135040] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8adc4e317a08
[102491.135041] R13: ffff8adceb216010 R14: ffff8adc731d3f40 R15:
ffff8adceb216000
[102491.135042] FS:  0000000000000000(0000) GS:ffff8ae349600000(0000)
knlGS:0000000000000000
[102491.135047]  nf_conntrack nf_defrag_ipv6
[102491.135051] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[102491.135054]  nf_defrag_ipv4
[102491.135056] CR2: 0000376f1d60afe8 CR3: 00000003b1c28000 CR4:
0000000000350ee0
[102491.135059]  ip_set
[102491.135061] note: kworker/u64:0[863413] exited with preempt_count 2
[102491.135064]  nf_tables nfnetlink cmac bnep zstd sunrpc vfat fat
hid_logitech_hidpp hid_logitech_dj intel_rapl_msr intel_rapl_common
uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
snd_hda_codec_realtek videobuf2_common mt76x2u mt76x2_common
snd_hda_codec_generic mt76x02_usb iwlmvm videodev edac_mce_amd
snd_usb_audio ledtrig_audio snd_hda_codec_hdmi mt76_usb mt76x02_lib
snd_usbmidi_lib kvm_amd snd_hda_intel mt76 snd_rawmidi
snd_intel_dspcfg mc joydev snd_intel_sdw_acpi mac80211 kvm
snd_hda_codec snd_hda_core iwlwifi btusb snd_hwdep btrtl snd_seq btbcm
btintel eeepc_wmi asus_wmi snd_seq_device irqbypass xpad sparse_keymap
bluetooth libarc4 rapl snd_pcm video ff_memless wmi_bmof ecdh_generic
ecc cfg80211 pcspkr snd_timer k10temp snd sp5100_tco i2c_piix4
soundcore rfkill acpi_cpufreq binfmt_misc ip_tables amdgpu
drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul
crc32_pclmul crc32c_intel cec igb drm nvme ghash_clmulni_intel dca ccp
nvme_core i2c_algo_bit wmi
[102491.135357]  pinctrl_amd fuse
[102491.135366] CPU: 18 PID: 182 Comm: kcompactd0 Tainted: G      D W
      --------- ---
5.12.0-0.rc2.20210310git05a59d79793d.168.fc35.x86_64 #1
[102491.135369] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[102491.135372] RIP: 0010:debug_print_object+0x6e/0x90
[102491.135403] Code: 49 89 c1 8b 43 10 83 c2 01 8b 4b 14 48 c7 c7 e8
ab 64 8b 89 15 a7 0b 37 03 4c 8b 45 00 48 8b 14 c5 a0 80 2a 8b e8 50
4d 60 00 <0f> 0b 83 05 25 0e 99 01 01 48 83 c4 08 5b 5d c3 83 05 17 0e
99 01
[102491.135406] RSP: 0018:ffffac448080bb78 EFLAGS: 00010296
[102491.135409] RAX: 000000000000005e RBX: ffff8add6de5c7a8 RCX:
0000000000000027
[102491.135412] RDX: ffff8ae348fdaae8 RSI: 0000000000000001 RDI:
ffff8ae348fdaae0
[102491.135415] RBP: ffffffff8b221320 R08: 0000000000000000 R09:
0000000000000000
[102491.135417] R10: 0000000000000000 R11: 0000000000000000 R12:
dead000000000122
[102491.135419] R13: dead000000000100 R14: ffffffff8b221320 R15:
0000000000000005
[102491.135421] FS:  0000000000000000(0000) GS:ffff8ae348e00000(0000)
knlGS:0000000000000000
[102491.135441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[102491.135443] CR2: 00007f41b9ee7000 CR3: 00000003b1c28000 CR4:
0000000000350ee0
[102491.135446] Call Trace:
[102491.135451]  debug_check_no_obj_freed+0x1db/0x220
[102491.135455]  free_pcp_prepare+0x132/0x270
[102491.135459]  free_unref_page+0x18/0xd0
[102491.135463]  migrate_pages+0x8b9/0x1200
[102491.135467]  ? isolate_freepages_block+0x4a0/0x4a0
[102491.135471]  ? split_map_pages+0x160/0x160
[102491.135490]  compact_zone+0x680/0xfd0
[102491.135493]  ? __free_object+0x2b9/0x300
[102491.135496]  ? lock_release+0x1ef/0x410
[102491.135500]  proactive_compact_node+0x78/0xb0
[102491.135505]  kcompactd+0x38a/0x440
[102491.135509]  ? do_wait_intr_irq+0xd0/0xd0
[102491.135512]  ? kcompactd_do_work+0x3a0/0x3a0
[102491.135515]  kthread+0x13a/0x150
[102491.135520]  ? __kthread_bind_mask+0x60/0x60
[102491.135533]  ret_from_fork+0x22/0x30
[102491.135539] irq event stamp: 220
[102491.135541] hardirqs last  enabled at (219): [<ffffffff8ad62217>]
_raw_spin_unlock_irqrestore+0x37/0x40
[102491.135545] hardirqs last disabled at (220): [<ffffffff8ad5b9a9>]
__schedule+0x6e9/0xb20
[102491.135548] softirqs last  enabled at (0): [<ffffffff8a0dd990>]
copy_process+0x910/0x1e00
[102491.135552] softirqs last disabled at (0): [<0000000000000000>] 0x0
[102491.135555] ---[ end trace 562b0b01453e6614 ]---
[102494.954915] iwlwifi 0000:04:00.0: Error sending SCAN_REQ_UMAC:
time out after 2000ms.
[102494.954950] iwlwifi 0000:04:00.0: Current CMD queue read_ptr 93 write_ptr 94
[102494.956242] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[102494.956245] iwlwifi 0000:04:00.0: Status: 0x00000040, count: 6
[102494.956248] iwlwifi 0000:04:00.0: Loaded firmware version:
59.601f3a66.0 cc-a0-59.ucode
[102494.956251] iwlwifi 0000:04:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
[102494.956255] iwlwifi 0000:04:00.0: 0x00A022F0 | trm_hw_status0
[102494.956257] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[102494.956260] iwlwifi 0000:04:00.0: 0x004FAA36 | branchlink2
[102494.956262] iwlwifi 0000:04:00.0: 0x000145FA | interruptlink1
[102494.956265] iwlwifi 0000:04:00.0: 0x000145FA | interruptlink2
[102494.956268] iwlwifi 0000:04:00.0: 0x004F51B0 | data1
[102494.956270] iwlwifi 0000:04:00.0: 0x01000000 | data2
[102494.956272] iwlwifi 0000:04:00.0: 0x00000000 | data3
[102494.956275] iwlwifi 0000:04:00.0: 0x00000000 | beacon time
[102494.956277] iwlwifi 0000:04:00.0: 0xD78321C6 | tsf low
[102494.956279] iwlwifi 0000:04:00.0: 0x00000017 | tsf hi
[102494.956282] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[102494.956284] iwlwifi 0000:04:00.0: 0xD783784B | time gp2
[102494.956286] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[102494.956289] iwlwifi 0000:04:00.0: 0x0000003B | uCode version major
[102494.956291] iwlwifi 0000:04:00.0: 0x601F3A66 | uCode version minor
[102494.956294] iwlwifi 0000:04:00.0: 0x00000340 | hw version
[102494.956296] iwlwifi 0000:04:00.0: 0x00C89000 | board version
[102494.956299] iwlwifi 0000:04:00.0: 0x807DFD04 | hcmd
[102494.956302] iwlwifi 0000:04:00.0: 0x00020000 | isr0
[102494.956304] iwlwifi 0000:04:00.0: 0x01000000 | isr1
[102494.956306] iwlwifi 0000:04:00.0: 0x08F04002 | isr2
[102494.956309] iwlwifi 0000:04:00.0: 0x04C3000C | isr3
[102494.956312] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[102494.956315] iwlwifi 0000:04:00.0: 0x005C019C | last cmd Id
[102494.956318] iwlwifi 0000:04:00.0: 0x004F51B0 | wait_event
[102494.956320] iwlwifi 0000:04:00.0: 0x00004B99 | l2p_control
[102494.956322] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[102494.956325] iwlwifi 0000:04:00.0: 0x00000003 | l2p_mhvalid
[102494.956327] iwlwifi 0000:04:00.0: 0x00000000 | l2p_addr_match
[102494.956329] iwlwifi 0000:04:00.0: 0x0000000B | lmpm_pmg_sel
[102494.956332] iwlwifi 0000:04:00.0: 0x00000000 | timestamp
[102494.956334] iwlwifi 0000:04:00.0: 0x000080EC | flow_handler
[102494.956380] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[102494.956382] iwlwifi 0000:04:00.0: Status: 0x00000040, count: 7
[102494.956385] iwlwifi 0000:04:00.0: 0x20000066 | NMI_INTERRUPT_HOST
[102494.956387] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[102494.956390] iwlwifi 0000:04:00.0: 0x804568FC | umac branchlink2
[102494.956392] iwlwifi 0000:04:00.0: 0xC0084F3C | umac interruptlink1
[102494.956395] iwlwifi 0000:04:00.0: 0x80477750 | umac interruptlink2
[102494.956397] iwlwifi 0000:04:00.0: 0x01000000 | umac data1
[102494.956399] iwlwifi 0000:04:00.0: 0x80477750 | umac data2
[102494.956401] iwlwifi 0000:04:00.0: 0x00000000 | umac data3
[102494.956404] iwlwifi 0000:04:00.0: 0x0000003B | umac major
[102494.956406] iwlwifi 0000:04:00.0: 0x601F3A66 | umac minor
[102494.956408] iwlwifi 0000:04:00.0: 0xD7837848 | frame pointer
[102494.956411] iwlwifi 0000:04:00.0: 0xC0885F30 | stack pointer
[102494.956413] iwlwifi 0000:04:00.0: 0x005D010D | last host cmd
[102494.956415] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[102494.956430] iwlwifi 0000:04:00.0: IML/ROM dump:
[102494.956432] iwlwifi 0000:04:00.0: 0x00000003 | IML/ROM error/state
[102494.956446] iwlwifi 0000:04:00.0: 0x00005590 | IML/ROM data1
[102494.956460] iwlwifi 0000:04:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[102494.956470] iwlwifi 0000:04:00.0: Fseq Registers:
[102494.956475] iwlwifi 0000:04:00.0: 0x60000000 | FSEQ_ERROR_CODE
[102494.956480] iwlwifi 0000:04:00.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
[102494.956486] iwlwifi 0000:04:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
[102494.956491] iwlwifi 0000:04:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[102494.956496] iwlwifi 0000:04:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[102494.956502] iwlwifi 0000:04:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[102494.956507] iwlwifi 0000:04:00.0: 0x00100530 | FSEQ_CNVI_ID
[102494.956512] iwlwifi 0000:04:00.0: 0x00000532 | FSEQ_CNVR_ID
[102494.956518] iwlwifi 0000:04:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[102494.956525] iwlwifi 0000:04:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[102494.956532] iwlwifi 0000:04:00.0: 0x05B0905B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[102494.956540] iwlwifi 0000:04:00.0: 0x0000025B |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[102494.956762] iwlwifi 0000:04:00.0: WRT: Collecting data: ini trigger 4 fired.
[102494.956789] ieee80211 phy0: Hardware restart was requested
[102494.956816] iwlwifi 0000:04:00.0: Scan failed! ret -110
[102494.956925] ------------[ cut here ]------------
[102494.956928] WARNING: CPU: 30 PID: 930660 at
net/mac80211/scan.c:411 __ieee80211_scan_completed+0x2bb/0x520
[mac80211]
[102494.956962] Modules linked in: snd_seq_dummy snd_hrtimer nls_utf8
isofs uas usb_storage tun uinput rfcomm netconsole nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep
zstd sunrpc vfat fat hid_logitech_hidpp hid_logitech_dj intel_rapl_msr
intel_rapl_common uvcvideo videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 snd_hda_codec_realtek videobuf2_common mt76x2u
mt76x2_common snd_hda_codec_generic mt76x02_usb iwlmvm videodev
edac_mce_amd snd_usb_audio ledtrig_audio snd_hda_codec_hdmi mt76_usb
mt76x02_lib snd_usbmidi_lib kvm_amd snd_hda_intel mt76 snd_rawmidi
snd_intel_dspcfg mc joydev snd_intel_sdw_acpi mac80211 kvm
snd_hda_codec snd_hda_core iwlwifi btusb snd_hwdep btrtl snd_seq btbcm
btintel eeepc_wmi asus_wmi snd_seq_device irqbypass xpad sparse_keymap
bluetooth libarc4
[102494.957007]  rapl snd_pcm video ff_memless wmi_bmof ecdh_generic
ecc cfg80211 pcspkr snd_timer k10temp snd sp5100_tco i2c_piix4
soundcore rfkill acpi_cpufreq binfmt_misc ip_tables amdgpu
drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul
crc32_pclmul crc32c_intel cec igb drm nvme ghash_clmulni_intel dca ccp
nvme_core i2c_algo_bit wmi pinctrl_amd fuse
[102494.957036] CPU: 30 PID: 930660 Comm: kworker/u64:2 Tainted: G
 D W        --------- ---
5.12.0-0.rc2.20210310git05a59d79793d.168.fc35.x86_64 #1
[102494.957039] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[102494.957042] Workqueue: phy0 ieee80211_scan_work [mac80211]
[102494.957073] RIP: 0010:__ieee80211_scan_completed+0x2bb/0x520 [mac80211]
[102494.957826] Code: ca 0f 82 7d 01 00 00 48 89 ef e8 80 2f 00 00 e9
72 fe ff ff 0f 0b 48 83 bd d8 1c 00 00 00 41 be 01 00 00 00 0f 85 9e
fd ff ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 85 a0 1c 00 00
e9 69
[102494.957830] RSP: 0018:ffffac4495033db0 EFLAGS: 00010246
[102494.957834] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[102494.957836] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff8adc770f8e00
[102494.957839] RBP: ffff8adc770f8e00 R08: 0000000000000001 R09:
ffffffffc1395e40
[102494.957842] R10: ffffac4495033de8 R11: 0000000000000000 R12:
0000000000000001
[102494.957844] R13: 0000000000000000 R14: 0000000000000001 R15:
ffff8adc770f8e00
[102494.957847] FS:  0000000000000000(0000) GS:ffff8ae34a600000(0000)
knlGS:0000000000000000
[102494.957850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[102494.957853] CR2: 00003de20ab47000 CR3: 00000001346e0000 CR4:
0000000000350ee0
[102494.957856] Call Trace:
[102494.957862]  ieee80211_scan_work+0x15c/0x860 [mac80211]
[102494.957893]  ? debug_object_deactivate+0x55/0x140
[102494.957899]  ? lock_release+0x1ef/0x410
[102494.957913]  ? lock_release+0x1ef/0x410
[102494.957917]  process_one_work+0x2b0/0x5e0
[102494.957923]  worker_thread+0x55/0x3c0
[102494.957926]  ? process_one_work+0x5e0/0x5e0
[102494.957930]  kthread+0x13a/0x150
[102494.957934]  ? __kthread_bind_mask+0x60/0x60
[102494.957939]  ret_from_fork+0x22/0x30
[102494.957945] irq event stamp: 0
[102494.957948] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[102494.957951] hardirqs last disabled at (0): [<ffffffff8a0dd990>]
copy_process+0x910/0x1e00
[102494.957956] softirqs last  enabled at (0): [<ffffffff8a0dd990>]
copy_process+0x910/0x1e00
[102494.957959] softirqs last disabled at (0): [<0000000000000000>] 0x0
[102494.957962] ---[ end trace 562b0b01453e6615 ]---

Full kernel log is here: https://pastebin.com/A7dwr8ZV


--
Best Regards,
Mike Gavrilov.
