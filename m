Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935F73CA0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhGOOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:35:50 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00521C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:32:56 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id h5so3068910vsg.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vi8PzyjM9LyyPrLgDAtJUibTYUKjumr71RPU2S7jZOY=;
        b=t4PRTNjzG53YXUNvAh28OCDEIGERdcbkMgm0s/imsmghH6er9z6+TfPQ20m7oD7YIk
         8oDi2KVz/c2R51DYWYhymqSK1M4phFomRZd2Wy7lBMPOBhspiPgRRrQQHki/+nW39m07
         Qq97HmFtJN5JrgGXVgap8FRiFnwaDApZ6t1p2//+mYM00KzKZbLAMs65667cWrizYFbA
         CRrZ0MAGRBCTYoWmYP+69LhRXef02LRzOFl3NhFRUf+3Iesj58KqPOBYx6GlYUEbqCqk
         pkOUSBw8GiNLWxG0Da4IW9YVXF0aUqFT1OL2napufO+aGWrFGTNhT02lsFOlJ1SW1M6b
         lkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vi8PzyjM9LyyPrLgDAtJUibTYUKjumr71RPU2S7jZOY=;
        b=rgXLNr/5GoU7KcyGsdUxjLPFvpP6zEyvUTtyziBeQf3XaTD1EHTn4Wh3iCszP1dhIm
         i74X8ywUYwomx2YPvocFP5ZelS1UqiUPtXwB836r3YtofJZZiJDLM734iJW+G0y0d504
         yvg7Q9TCPmHIiVriJDkteJ5SVuYCDWyFKSm7hw3WlgzkYlZUa5dLMYDvmoNZ7nyQgXRd
         Ndyp/Z6GizeEKOA2Qtnc/3j1+noB3XQwQ9xL90laUFJXzt0K/ra+eUTh55Ff0SPCLP+V
         SpPPgq0K7+/HsVg5dmh3z8o2bdHZDFvLAKPUkx6glMbm6ioHx3jCchi04h2YeyGzrdcN
         tvyw==
X-Gm-Message-State: AOAM531OjfdIg4XrbIlIRC2NC/WVMWT0iofSC2hBv1ofA0TiZWVGlvxT
        jUULgDiGTEaoBBH6bglAE4u3p/D1l9DSdBV2AL/gAg8y350Trg==
X-Google-Smtp-Source: ABdhPJycb5ceHd9Z9UmRxaG/07R/invL3zOrMkHAbfCnnLa/S3i03y30zoxceyUqmSRgqHQR07wdCZCRlbdDVYtDS+8=
X-Received: by 2002:a67:fdc2:: with SMTP id l2mr6391753vsq.7.1626359575678;
 Thu, 15 Jul 2021 07:32:55 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Thu, 15 Jul 2021 08:32:29 -0600
Message-ID: <CAJfuBxxVEVwj=hGa+FoQUV6i7BtoUbiJwGunnRq26Fp=Ax2ziQ@mail.gmail.com>
Subject: 5.14.0-rc1 KASAN use after free
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

I noticed this report this morning, from 3 days ago,
about 10 minutes after boot.
Its easiest to ignore it, and I dont want to make a fuss,
but it looks useful to someone


[   33.663464] Bluetooth: RFCOMM ver 1.11
[  646.343628] ==================================================================
[  646.343649] BUG: KASAN: use-after-free in bfq_get_queue+0x47d/0x900
[  646.343680] Read of size 8 at addr ffff88810d864a00 by task
journal-offline/1639

[  646.343708] CPU: 2 PID: 1639 Comm: journal-offline Not tainted
5.14.0-rc1-lm1 #66
[  646.343730] Hardware name: TOSHIBA Satellite L55-C/06F4
               , BIOS 1.20 10/08/2015
[  646.343745] Call Trace:
[  646.343757]  dump_stack_lvl+0x46/0x5a
[  646.343781]  print_address_description.constprop.0+0x1f/0x140
[  646.343808]  ? bfq_get_queue+0x47d/0x900
[  646.343829]  kasan_report.cold+0x7f/0x11b
[  646.343854]  ? bfq_init_bfqq+0x2a0/0x330
[  646.343873]  ? bfq_get_queue+0x47d/0x900
[  646.343895]  bfq_get_queue+0x47d/0x900
[  646.343918]  ? bfq_merge_bfqqs+0x7a0/0x7a0
[  646.343939]  ? _raw_write_unlock_bh+0x30/0x30
[  646.343965]  bfq_get_bfqq_handle_split+0xa1/0x240
[  646.343991]  bfq_init_rq+0x1e0/0x15e0
[  646.344013]  ? submit_bio_noacct+0x7f0/0x7f0
[  646.344036]  ? percpu_counter_add_batch+0x1f/0x90
[  646.344059]  ? bfq_get_bfqq_handle_split+0x240/0x240
[  646.344082]  ? btrfs_map_bio+0x404/0x830
[  646.344100]  ? elv_rqhash_find+0x42/0x180
[  646.344121]  ? _raw_spin_lock_irq+0x71/0xb0
[  646.344142]  ? _raw_write_lock_irq+0xb0/0xb0
[  646.344164]  bfq_insert_requests+0xe2/0x2a10
[  646.344190]  ? btrfs_submit_data_bio+0x186/0x340
[  646.344215]  ? submit_one_bio+0x81/0xc0
[  646.344235]  ? bfq_request_merged+0x110/0x110
[  646.344256]  ? blk_status_to_errno+0x20/0x30
[  646.344279]  ? extent_write_locked_range+0x360/0x360
[  646.344302]  ? btrfs_use_block_rsv+0x320/0x320
[  646.344324]  blk_mq_sched_insert_requests+0xa6/0x1a0
[  646.344347]  blk_mq_flush_plug_list+0x1fa/0x2f0
[  646.344374]  ? blk_mq_insert_requests+0x1a0/0x1a0
[  646.344399]  ? __filemap_fdatawrite_range+0x176/0x1c0
[  646.344423]  blk_flush_plug_list+0x1d4/0x200
[  646.344449]  ? blk_insert_cloned_request+0x170/0x170
[  646.344476]  blk_finish_plug+0x3c/0x60
[  646.344500]  start_ordered_ops.constprop.0+0xc3/0xf0
[  646.344525]  ? btrfs_file_write_iter+0x5b0/0x5b0
[  646.344554]  btrfs_sync_file+0x135/0x880
[  646.344578]  ? rwsem_mark_wake+0x460/0x460
[  646.344601]  ? start_ordered_ops.constprop.0+0xf0/0xf0
[  646.344628]  ? vfs_fsync_range+0x86/0x100
[  646.344650]  __x64_sys_fsync+0x3f/0x70
[  646.344672]  do_syscall_64+0x3b/0x90
[  646.344696]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  646.344720] RIP: 0033:0x7f6eedeecebb
[  646.344738] Code: 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48
83 ec 18 89 7c 24 0c e8 53 f7 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 b1 f7 ff ff
8b 44
[  646.344760] RSP: 002b:00007f6ee919ca10 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  646.344784] RAX: ffffffffffffffda RBX: 00005614c6093620 RCX: 00007f6eedeecebb
[  646.344801] RDX: 0000000000000002 RSI: 00007f6eee1cb9e2 RDI: 0000000000000017
[  646.344815] RBP: 00007f6eee1cd610 R08: 0000000000000000 R09: 00007f6ee919d640
[  646.344830] R10: 0000000000000002 R11: 0000000000000293 R12: 0000000000000002
[  646.344843] R13: 00007ffec2aede3f R14: 0000000000000000 R15: 00007f6ee919d640

[  646.344874] Allocated by task 1626:
[  646.344886]  kasan_save_stack+0x1b/0x40
[  646.344906]  __kasan_slab_alloc+0x61/0x80
[  646.344924]  kmem_cache_alloc_node+0x151/0x2d0
[  646.344942]  bfq_get_queue+0x209/0x900
[  646.344961]  bfq_get_bfqq_handle_split+0xa1/0x240
[  646.344982]  bfq_init_rq+0x1e0/0x15e0
[  646.345001]  bfq_insert_requests+0xe2/0x2a10
[  646.345020]  blk_mq_sched_insert_requests+0xa6/0x1a0
[  646.345039]  blk_mq_flush_plug_list+0x1fa/0x2f0
[  646.345060]  blk_flush_plug_list+0x1d4/0x200
[  646.345082]  blk_finish_plug+0x3c/0x60
[  646.345103]  start_ordered_ops.constprop.0+0xc3/0xf0
[  646.345124]  btrfs_sync_file+0x135/0x880
[  646.345144]  __x64_sys_fsync+0x3f/0x70
[  646.345163]  do_syscall_64+0x3b/0x90
[  646.345183]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  646.345212] The buggy address belongs to the object at ffff88810d864810
                which belongs to the cache bfq_queue of size 560
[  646.345229] The buggy address is located 496 bytes inside of
                560-byte region [ffff88810d864810, ffff88810d864a40)
[  646.345248] The buggy address belongs to the page:
[  646.345258] page:0000000040e75441 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff88810d864810 pfn:0x10d864
[  646.345280] head:0000000040e75441 order:2 compound_mapcount:0
compound_pincount:0
[  646.345296] flags:
0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  646.345326] raw: 0017ffffc0010200 0000000000000000 dead000000000122
ffff88810145b400
[  646.345345] raw: ffff88810d864810 000000008017000f 00000001ffffffff
0000000000000000
[  646.345357] page dumped because: kasan: bad access detected

[  646.345375] Memory state around the buggy address:
[  646.345387]  ffff88810d864900: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  646.345403]  ffff88810d864980: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  646.345417] >ffff88810d864a00: fb fb fb fb fb fb fb fb fc fc fc fc
fc fc fc fc
[  646.345428]                    ^
[  646.345441]  ffff88810d864a80: fc fc fc fc fc fc fc fc fb fb fb fb
fb fb fb fb
[  646.345455]  ffff88810d864b00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  646.345467] ==================================================================
[  646.345476] Disabling lock debugging due to kernel taint
[20632.749805] rfkill: input handler enabled
[20636.319701] rfkill: input handler disabled
[22201.638710] perf: interrupt took too long (2514 > 2500), lowering
kernel.perf_event_max_sample_rate to 79000
[22539.009414] perf: interrupt took too long (3145 > 3142), lowering
kernel.perf_event_max_sample_rate to 63000
[23091.879235] perf: interrupt took too long (3960 > 3931), lowering
kernel.perf_event_max_sample_rate to 50000
[24206.193740] perf: interrupt took too long (4972 > 4950), lowering
kernel.perf_event_max_sample_rate to 40000
[25306.264832] L1TF CPU bug present and SMT on, data leak possible.
See CVE-2018-3646 and
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html
for details.
[38172.611967] nf_conntrack: default automatic helper assignment has
been turned off for security reasons and CT-based firewall rule not
found. Use the iptables CT target to attach helpers instead.
[123082.553154] psmouse serio2: bad data from KBC - timeout
[211716.941601] ------------[ cut here ]------------
[211716.941610] cfs_rq->avg.load_avg || cfs_rq->avg.util_avg ||
cfs_rq->avg.runnable_avg
[211716.941619] WARNING: CPU: 4 PID: 33 at kernel/sched/fair.c:3307
update_blocked_averages+0xb7c/0xbf0
[211716.941641] Modules linked in: uinput rfcomm xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp
bridge stp llc ccm nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set
nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter cmac
bnep sunrpc vfat iwlmvm fat snd_hda_codec_hdmi intel_rapl_msr mac80211
snd_hda_codec_conexant at24 snd_hda_codec_generic ledtrig_audio
iTCO_wdt intel_pmc_bxt mei_hdcp iTCO_vendor_support libarc4
intel_wmi_thunderbolt wmi_bmof uvcvideo btusb snd_hda_intel btrtl
btbcm snd_intel_dspcfg videobuf2_vmalloc videobuf2_memops btintel
videobuf2_v4l2 videobuf2_common intel_rapl_common snd_hda_codec
x86_pkg_temp_thermal iwlwifi
[211716.941813]  intel_powerclamp videodev coretemp snd_hwdep rapl
snd_hda_core bluetooth intel_cstate snd_seq mc intel_uncore joydev
snd_seq_device ecdh_generic cfg80211 ecc pcspkr snd_pcm snd_timer
mei_me snd toshiba_acpi i2c_i801 mei sparse_keymap soundcore
industrialio i2c_smbus toshiba_bluetooth rfkill wmi acpi_pad ip_tables
rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul i915
crc32c_intel i2c_algo_bit ttm ghash_clmulni_intel serio_raw r8169
drm_kms_helper cec rtsx_pci drm video fuse
[211716.941897] CPU: 4 PID: 33 Comm: ksoftirqd/4 Tainted: G    B
      5.14.0-rc1-lm1 #66
[211716.941903] Hardware name: TOSHIBA Satellite L55-C/06F4
                , BIOS 1.20 10/08/2015
[211716.941907] RIP: 0010:update_blocked_averages+0xb7c/0xbf0
[211716.941916] Code: c0 5e ab 90 c6 05 98 15 a7 02 01 e8 21 48 14 01
0f 0b e9 13 f6 ff ff 48 c7 c7 20 5f ab 90 c6 05 7a 15 a7 02 01 e8 07
48 14 01 <0f> 0b 48 8b 7c 24 20 e8 38 61 31 00 45 8b af 38 01 00 00 e9
e3 f9
[211716.941921] RSP: 0018:ffff888100fefc58 EFLAGS: 00010082
[211716.941926] RAX: 0000000000000000 RBX: ffff88821bb334c0 RCX:
0000000000000000
[211716.941930] RDX: 0000000000000027 RSI: 0000000000000004 RDI:
ffffed10201fdf81
[211716.941934] RBP: ffff88821bb32de0 R08: ffffffff8f3f445e R09:
ffff88821bb20a8b
[211716.941937] R10: ffffed1043764151 R11: 0000000000000001 R12:
ffffffff927d77c0
[211716.941941] R13: 0000000000000001 R14: ffff88821bb33728 R15:
ffff88821bb32d40
[211716.941945] FS:  0000000000000000(0000) GS:ffff88821bb00000(0000)
knlGS:0000000000000000
[211716.941949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[211716.941952] CR2: 0000556174b0d040 CR3: 0000000140414001 CR4:
00000000003726e0
[211716.941956] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[211716.941959] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[211716.941963] Call Trace:
[211716.941968]  newidle_balance+0x34d/0x6b0
[211716.941974]  ? update_cfs_group+0x1e/0x150
[211716.941980]  ? load_balance+0x1290/0x1290
[211716.941985]  ? update_min_vruntime+0x44/0xc0
[211716.941991]  pick_next_task_fair+0x59/0x660
[211716.941997]  __schedule+0x225/0xeb0
[211716.942005]  ? io_schedule_timeout+0xb0/0xb0
[211716.942011]  ? __do_softirq+0x209/0x373
[211716.942017]  schedule+0x6d/0x120
[211716.942023]  smpboot_thread_fn+0x1b7/0x250
[211716.942030]  ? smpboot_register_percpu_thread+0x190/0x190
[211716.942036]  kthread+0x1d2/0x200
[211716.942041]  ? set_kthread_struct+0x80/0x80
[211716.942046]  ret_from_fork+0x22/0x30
[211716.942055] ---[ end trace ee8f02e72a76fda7 ]---
[256577.295169] show_signal_msg: 4 callbacks suppressed
[256577.295176] gnome-shell[2236]: segfault at 18 ip 00007f16ab0563ee
sp 00007ffcd6601570 error 4 in libgjs.so.0.0.0[7f16ab025000+92000]
[256577.295205] Code: ec 30 64 48 8b 04 25 28 00 00 00 48 89 44 24 28
31 c0 e8 05 32 00 00 48 89 c3 e8 8d 36 fd ff 48 89 c7 e8 c5 30 fd ff
48 89 c5 <48> 8b 43 18 48 85 c0 0f 84 85 00 00 00 48 8b 50 18 48 8d 45
18 49
[256588.051436] rfkill: input handler enabled
