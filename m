Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9432E4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhCEJdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhCEJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:33:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF89C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:33:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r25so1884051ljk.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phFig5u+CI3MTR4VVWOk77YgRqbmjGuvPGaNiI8vC6c=;
        b=IVp5zewrAtXTX3ggknXj7Y/i5/BBiBefNLPno/o4zzTnxIM5KXnV5M9h5yrUk4gHnV
         Mco8Le+G45xE25pIJeEM/+9Blkn7o1/V2qZivVSjNQ7SBFCicxm/hwdL3ta9ITWI2dMl
         ox28DBctzNCPT+7QY+mGcyeSCdLp2JUq6p4kO49HrPUurGU4yqXORFmoxJ0ofeAGNWu4
         X6iom9aZPhpVRmszHpHaX7b5i2IIU6qt0HuvRp46Kmeyz/X5sVdu1551tZ57wjLgh4+x
         SfJJ7Ej6X+BdezCxtODzSJ5G5V03ncDIvWdryr+6+yI+vkhhEJ75QhNbWi5FWQO+Qw0R
         ToGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phFig5u+CI3MTR4VVWOk77YgRqbmjGuvPGaNiI8vC6c=;
        b=pcN3ft/RlSR8BLbgFyjesy5FTXzwtfEjAhiegvvLjD8WXP/Vk2h0n20xAxyhpgSQo3
         PbK2Zjvmi8vKPZ+6d7yezxdb6+3lE3AK0P/6TbwOERSMexg3SftO7dXY/uJvir58o6cD
         7K/GRkLGQYaexhprV2wsqy89G75EBbbGfw8BjPNhQoILOex6tfrE6BIRHIGEJhKuo7rw
         ul3L26p26DE/0mBJyS95jNE5LuzSs17p9WYmObT2oKjn5j0ewPw1U/jPhSH/+PQkeYt9
         gRU1U9GKR9+WFy4hBEu2tABeoW6Ls8M+po292mpdXh2g9GZxoj0dMN73u44/rETIdseg
         ppAA==
X-Gm-Message-State: AOAM532FlIJezdzyw/X63tFINQSf886qqxYaLJQkyLU0hz3tOHTGKPUh
        7/ZtKPZ5Am78PsVvhpxBanaE12/w0Cz/hoGsHjE=
X-Google-Smtp-Source: ABdhPJzq86WQe6NIQgki4Q9qwkzAy2BIFxwaVgeXksR0ITC3Umr8kNSSDy7ygBntsBWAkei9M//35AvOheVWsQQikV4=
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr1118702ljo.223.1614936805199;
 Fri, 05 Mar 2021 01:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20210126082834.2020-1-hdanton@sina.com> <CABXGCsNN+u2SqOvmw2JojTnESSLgxKgfJLQuB3Ne1fcNA47UZw@mail.gmail.com>
 <20210213030327.4992-1-hdanton@sina.com> <CABXGCsNAvXbOQxEWaHqf-iehX39OOOQwXBSJz7bZ6+68zn0tuA@mail.gmail.com>
 <20210301031107.1299-1-hdanton@sina.com>
In-Reply-To: <20210301031107.1299-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 5 Mar 2021 14:33:14 +0500
Message-ID: <CABXGCsNFW0XnGw5qn1f3LLYY_tqkn3CBES=iujS2arsuV7aLkQ@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, MM <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 at 08:11, Hillf Danton <hdanton@sina.com> wrote:
>
> What we learn from your reports is
>
> 1/ in z3fold_free(), kref_put() creates the ground zero for the race
> cases reported,
>
> 2/ the stale_lock in combination with lock makes things more
> complicated than thought.
>
> Instead of dropping something in the zero spot, the fix below goes the
> road mentioned before in this mail thread - add another list_head in
> parallel to the buddy and s/buddy/stale_node/ under every case of
> stale_lock.
>
> --- x/mm/z3fold.c
> +++ y/mm/z3fold.c
> @@ -127,6 +127,7 @@ struct z3fold_header {
>         unsigned short first_num:2;
>         unsigned short mapped_count:2;
>         unsigned short foreign_handles:2;
> +       struct list_head stale_node;
>  };
>
>  /**
> @@ -429,6 +430,7 @@ static struct z3fold_header *init_z3fold
>         zhdr->slots = slots;
>         zhdr->pool = pool;
>         INIT_LIST_HEAD(&zhdr->buddy);
> +       INIT_LIST_HEAD(&zhdr->stale_node);
>         INIT_WORK(&zhdr->work, compact_page_work);
>         return zhdr;
>  }
> @@ -556,7 +558,7 @@ static void __release_z3fold_page(struct
>                 z3fold_page_unlock(zhdr);
>
>         spin_lock(&pool->stale_lock);
> -       list_add(&zhdr->buddy, &pool->stale);
> +       list_add(&zhdr->stale_node, &pool->stale);
>         queue_work(pool->release_wq, &pool->work);
>         spin_unlock(&pool->stale_lock);
>  }
> @@ -598,10 +600,10 @@ static void free_pages_work(struct work_
>         spin_lock(&pool->stale_lock);
>         while (!list_empty(&pool->stale)) {
>                 struct z3fold_header *zhdr = list_first_entry(&pool->stale,
> -                                               struct z3fold_header, buddy);
> +                                               struct z3fold_header, stale_node);
>                 struct page *page = virt_to_page(zhdr);
>
> -               list_del(&zhdr->buddy);
> +               list_del(&zhdr->stale_node);
>                 if (WARN_ON(!test_bit(PAGE_STALE, &page->private)))
>                         continue;
>                 spin_unlock(&pool->stale_lock);
> @@ -1140,14 +1142,14 @@ retry:
>         if (can_sleep) {
>                 spin_lock(&pool->stale_lock);
>                 zhdr = list_first_entry_or_null(&pool->stale,
> -                                               struct z3fold_header, buddy);
> +                                               struct z3fold_header, stale_node);
>                 /*
>                  * Before allocating a page, let's see if we can take one from
>                  * the stale pages list. cancel_work_sync() can sleep so we
>                  * limit this case to the contexts where we can sleep
>                  */
>                 if (zhdr) {
> -                       list_del(&zhdr->buddy);
> +                       list_del(&zhdr->stale_node);
>                         spin_unlock(&pool->stale_lock);
>                         cancel_work_sync(&zhdr->work);
>                         page = virt_to_page(zhdr);
> --

The computer with patch above worked for a record time (3 days)
without freezing.
https://postimg.cc/VShF5cJN


But after 3 days hangs with follow trace:


[263314.718807] general protection fault, probably for non-canonical
address 0x72c1224000000000: 0000 [#1] SMP NOPTI
[263314.718828] CPU: 3 PID: 476750 Comm: Chrome_IOThread Tainted: G
    W        --------- ---  5.12.0-0.rc1.162.fc35.x86_64+debug #1
[263314.718831] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[263314.718835] RIP: 0010:__list_add_valid+0x3/0x40
[263314.718841] Code: e9 5d ff ff ff b8 f4 ff ff ff e9 53 ff ff ff 48
c7 00 00 00 00 00 c7 40 08 00 00 00 00 e9 6b ff ff ff cc cc cc cc cc
49 89 d0 <48> 8b 52 08 48 39 f2 0f 85 03 cf 62 00 4c 8b 0a 4d 39 c1 0f
85 1f
[263314.718845] RSP: 0018:ffffae4345b5fac0 EFLAGS: 00010282
[263314.718849] RAX: 00000000000003c0 RBX: ffffed09c02ade80 RCX:
0000000000000000
[263314.718851] RDX: 72c1224000000000 RSI: ffffce433c462004 RDI:
ffff9d414ab7a000
[263314.718853] RBP: ffffce433c462004 R08: 72c1224000000000 R09:
0000000000000000
[263314.718856] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9d4253053008
[263314.718858] R13: ffff9d414ab7a010 R14: 72c1224000000000 R15:
ffff9d414ab7a000
[263314.718860] FS:  00007f8ef636f640(0000) GS:ffff9d4947000000(0000)
knlGS:0000000000000000
[263314.718863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[263314.718865] CR2: 000055634cbef560 CR3: 00000002dbdbc000 CR4:
0000000000350ee0
[263314.718867] Call Trace:
[263314.718875]  do_compact_page+0x28d/0xb60
[263314.718884]  ? z3fold_zpool_free+0x3a8/0x590
[263314.718888]  zswap_free_entry+0x43/0x70
[263314.718892]  zswap_frontswap_invalidate_page+0x8c/0x90
[263314.718895]  __frontswap_invalidate_page+0x5d/0x90
[263314.718898]  swap_range_free+0xcd/0xf0
[263314.718901]  swapcache_free_entries+0x128/0x1a0
[263314.718904]  free_swap_slot+0xbb/0xd0
[263314.718907]  __swap_entry_free+0x7a/0xa0
[263314.718910]  free_swap_and_cache+0x35/0x80
[263314.718913]  shmem_undo_range+0x188/0x7e0
[263314.718919]  ? ldsem_down_read+0x1f/0x40
[263314.718925]  shmem_evict_inode+0xe6/0x290
[263314.718928]  ? lock_release+0x1ef/0x410
[263314.718932]  ? var_wake_function+0x20/0x20
[263314.718936]  evict+0xcf/0x1d0
[263314.718940]  __dentry_kill+0xe8/0x190
[263314.718943]  ? dput+0x20/0x480
[263314.718946]  dput+0x2b8/0x480
[263314.718949]  __fput+0x102/0x260
[263314.718952]  task_work_run+0x5c/0xa0
[263314.718957]  exit_to_user_mode_prepare+0x232/0x240
[263314.718960]  syscall_exit_to_user_mode+0x27/0x70
[263314.718964]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[263314.718967] RIP: 0033:0x7f8f0b15d16b
[263314.718972] Code: 8b 15 09 7d 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 7c 0c 00 f7 d8 64 89
01 48
[263314.718974] RSP: 002b:00007f8ef636d308 EFLAGS: 00000246 ORIG_RAX:
000000000000000b
[263314.718977] RAX: 0000000000000000 RBX: 00003e1813862928 RCX:
00007f8f0b15d16b
[263314.718979] RDX: 0000000000000000 RSI: 0000000000a4e000 RDI:
00007f8e5b43e000
[263314.718981] RBP: 00007f8ef636d320 R08: 0000000000000000 R09:
0000000000000000
[263314.718983] R10: 0000000000000000 R11: 0000000000000246 R12:
00007f8e5b43e000
[263314.718985] R13: 00003e18138628e0 R14: 00007f8ef636d330 R15:
00007f8ef636d330
[263314.718989] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib tun snd_seq_dummy snd_hrtimer uinput nls_utf8
isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep zstd sunrpc vfat
fat hid_logitech_hidpp hid_logitech_dj snd_hda_codec_realtek
snd_hda_codec_generic mt76x2u mt76x2_common ledtrig_audio mt76x02_usb
mt76_usb snd_hda_codec_hdmi mt76x02_lib intel_rapl_msr
intel_rapl_common iwlmvm mt76 snd_hda_intel snd_intel_dspcfg
soundwire_intel soundwire_generic_allocation snd_soc_core edac_mce_amd
joydev mac80211 snd_compress snd_pcm_dmaengine snd_usb_audio
soundwire_cadence kvm_amd snd_hda_codec btusb btrtl btbcm btintel
snd_hda_core snd_usbmidi_lib uvcvideo ac97_bus snd_seq iwlwifi kvm
snd_rawmidi bluetooth snd_hwdep videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 videobuf2_common
[263314.719032]  eeepc_wmi snd_seq_device asus_wmi snd_pcm videodev
sparse_keymap xpad ecdh_generic mc libarc4 irqbypass wmi_bmof
ff_memless cfg80211 video ecc snd_timer rapl sp5100_tco snd i2c_piix4
k10temp soundcore rfkill acpi_cpufreq binfmt_misc uas usb_storage
amdgpu drm_ttm_helper ttm iommu_v2 crct10dif_pclmul gpu_sched
crc32_pclmul crc32c_intel drm_kms_helper cec drm ghash_clmulni_intel
ccp igb nvme dca nvme_core i2c_algo_bit wmi pinctrl_amd fuse [last
unloaded: ip_tables]
[263314.719079] ---[ end trace ba885cda1af90fb7 ]---
[263314.719081] RIP: 0010:__list_add_valid+0x3/0x40
[263314.719084] Code: e9 5d ff ff ff b8 f4 ff ff ff e9 53 ff ff ff 48
c7 00 00 00 00 00 c7 40 08 00 00 00 00 e9 6b ff ff ff cc cc cc cc cc
49 89 d0 <48> 8b 52 08 48 39 f2 0f 85 03 cf 62 00 4c 8b 0a 4d 39 c1 0f
85 1f
[263314.719086] RSP: 0018:ffffae4345b5fac0 EFLAGS: 00010282
[263314.719089] RAX: 00000000000003c0 RBX: ffffed09c02ade80 RCX:
0000000000000000
[263314.719091] RDX: 72c1224000000000 RSI: ffffce433c462004 RDI:
ffff9d414ab7a000
[263314.719093] RBP: ffffce433c462004 R08: 72c1224000000000 R09:
0000000000000000
[263314.719095] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9d4253053008
[263314.719097] R13: ffff9d414ab7a010 R14: 72c1224000000000 R15:
ffff9d414ab7a000
[263314.719099] FS:  00007f8ef636f640(0000) GS:ffff9d4947000000(0000)
knlGS:0000000000000000
[263314.719101] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[263314.719104] CR2: 000055634cbef560 CR3: 00000002dbdbc000 CR4:
0000000000350ee0
[263314.719106] note: Chrome_IOThread[476750] exited with preempt_count 5
[263341.868981] watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
[ThreadPoolForeg:513140]
[263341.868991] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib tun snd_seq_dummy snd_hrtimer uinput nls_utf8
isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep zstd sunrpc vfat
fat hid_logitech_hidpp hid_logitech_dj snd_hda_codec_realtek
snd_hda_codec_generic mt76x2u mt76x2_common ledtrig_audio mt76x02_usb
mt76_usb snd_hda_codec_hdmi mt76x02_lib intel_rapl_msr
intel_rapl_common iwlmvm mt76 snd_hda_intel snd_intel_dspcfg
soundwire_intel soundwire_generic_allocation snd_soc_core edac_mce_amd
joydev mac80211 snd_compress snd_pcm_dmaengine snd_usb_audio
soundwire_cadence kvm_amd snd_hda_codec btusb btrtl btbcm btintel
snd_hda_core snd_usbmidi_lib uvcvideo ac97_bus snd_seq iwlwifi kvm
snd_rawmidi bluetooth snd_hwdep videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 videobuf2_common
[263341.869025]  eeepc_wmi snd_seq_device asus_wmi snd_pcm videodev
sparse_keymap xpad ecdh_generic mc libarc4 irqbypass wmi_bmof
ff_memless cfg80211 video ecc snd_timer rapl sp5100_tco snd i2c_piix4
k10temp soundcore rfkill acpi_cpufreq binfmt_misc uas usb_storage
amdgpu drm_ttm_helper ttm iommu_v2 crct10dif_pclmul gpu_sched
crc32_pclmul crc32c_intel drm_kms_helper cec drm ghash_clmulni_intel
ccp igb nvme dca nvme_core i2c_algo_bit wmi pinctrl_amd fuse [last
unloaded: ip_tables]
[263341.869052] irq event stamp: 0
[263341.869054] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[263341.869057] hardirqs last disabled at (0): [<ffffffffa80dd962>]
copy_process+0x902/0x1df0
[263341.869061] softirqs last  enabled at (0): [<ffffffffa80dd962>]
copy_process+0x902/0x1df0
[263341.869064] softirqs last disabled at (0): [<0000000000000000>] 0x0
[263341.869067] CPU: 0 PID: 513140 Comm: ThreadPoolForeg Tainted: G
  D W        --------- ---  5.12.0-0.rc1.162.fc35.x86_64+debug #1
[263341.869070] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[263341.869073] RIP: 0010:native_queued_spin_lock_slowpath+0x1ce/0x200
[263341.869076] Code: c1 ef 12 83 e0 03 83 ef 01 48 c1 e0 05 48 63 ff
48 05 00 f3 1e 00 48 03 04 fd 20 d9 6e a9 48 89 08 8b 41 08 85 c0 75
09 f3 90 <8b> 41 08 85 c0 74 f7 48 8b 39 48 85 ff 0f 84 56 ff ff ff 0f
0d 0f
[263341.869079] RSP: 0000:ffffae435505bbf0 EFLAGS: 00000246
[263341.869082] RAX: 0000000000000000 RBX: 0000000000e6c4f7 RCX:
ffff9d4946bef300
[263341.869084] RDX: ffff9d424197e4e8 RSI: 0000000000040000 RDI:
0000000000000014
[263341.869087] RBP: ffff9d424197e4e8 R08: 0000000000040000 R09:
0000000000000000
[263341.869089] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9d424197e500
[263341.869091] R13: ffff9d424197e4e8 R14: ffffffffa9e87020 R15:
ffff9d424197e4e0
[263341.869094] FS:  00007ff2de694640(0000) GS:ffff9d4946a00000(0000)
knlGS:0000000000000000
[263341.869096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[263341.869099] CR2: 00000070bfa4d3c0 CR3: 00000002f2878000 CR4:
0000000000350ef0
[263341.869101] Call Trace:
[263341.869104]  do_raw_spin_lock+0x94/0xa0
[263341.869107]  _raw_spin_lock+0x63/0x80
[263341.869111]  zswap_frontswap_load+0x30/0x2f0
[263341.869115]  ? trace_hardirqs_on+0x1b/0xe0
[263341.869120]  __frontswap_load+0xc3/0x160
[263341.869123]  swap_readpage+0x25b/0x440
[263341.869127]  swapin_readahead+0x450/0x4e0
[263341.869130]  ? lock_release+0x1ef/0x410
[263341.869134]  do_swap_page+0x4a4/0x900
[263341.869137]  __handle_mm_fault+0xbd6/0x1610
[263341.869140]  ? lock_acquire+0x177/0x3a0
[263341.869145]  handle_mm_fault+0xa2/0x270
[263341.869148]  do_user_addr_fault+0x1ea/0x6b0
[263341.869152]  exc_page_fault+0x67/0x2a0
[263341.869155]  ? asm_exc_page_fault+0x8/0x30
[263341.869158]  asm_exc_page_fault+0x1e/0x30
[263341.869161] RIP: 0033:0x55e1b76f7713
[263341.869164] Code: 8b 9f c8 00 00 00 4d 8b b7 d0 00 00 00 4c 39 f3
74 5a 4c 8d 25 8e 18 3c 05 4c 8d 2d aa 59 e6 fb 0f 1f 80 00 00 00 00
48 8b 3b <48> 8b 07 48 89 c1 4c 29 e1 48 c1 c9 03 48 81 f9 9f 00 00 00
0f 87
[263341.869166] RSP: 002b:00007ff2de693430 EFLAGS: 00010287
[263341.869169] RAX: 0000000000000000 RBX: 00007ff2de693568 RCX:
00000070c00c7be0
[263341.869171] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
00000070bfa4d3c0
[263341.869174] RBP: 00007ff2de693480 R08: 0000000000000000 R09:
00000000000000ca
[263341.869176] R10: 00007fff78981080 R11: 00007fff78981090 R12:
000055e1bcab8f90
[263341.869178] R13: 000055e1b355d0b3 R14: 00007ff2de693578 R15:
00007ff2de693500
[263341.870981] watchdog: BUG: soft lockup - CPU#1 stuck for 23s!
[steamwebhelper:3496089]
[263341.870987] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib tun snd_seq_dummy snd_hrtimer uinput nls_utf8
isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep zstd sunrpc vfat
fat hid_logitech_hidpp hid_logitech_dj snd_hda_codec_realtek
snd_hda_codec_generic mt76x2u mt76x2_common ledtrig_audio mt76x02_usb
mt76_usb snd_hda_codec_hdmi mt76x02_lib intel_rapl_msr
intel_rapl_common iwlmvm mt76 snd_hda_intel snd_intel_dspcfg
soundwire_intel soundwire_generic_allocation snd_soc_core edac_mce_amd
joydev mac80211 snd_compress snd_pcm_dmaengine snd_usb_audio
soundwire_cadence kvm_amd snd_hda_codec btusb btrtl btbcm btintel
snd_hda_core snd_usbmidi_lib uvcvideo ac97_bus snd_seq iwlwifi kvm
snd_rawmidi bluetooth snd_hwdep videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 videobuf2_common
[263341.871021]  eeepc_wmi snd_seq_device asus_wmi snd_pcm videodev
sparse_keymap xpad ecdh_generic mc libarc4 irqbypass wmi_bmof
ff_memless cfg80211 video ecc snd_timer rapl sp5100_tco snd i2c_piix4
k10temp soundcore rfkill acpi_cpufreq binfmt_misc uas usb_storage
amdgpu drm_ttm_helper ttm iommu_v2 crct10dif_pclmul gpu_sched
crc32_pclmul crc32c_intel drm_kms_helper cec drm ghash_clmulni_intel
ccp igb nvme dca nvme_core i2c_algo_bit wmi pinctrl_amd fuse [last
unloaded: ip_tables]
[263341.871048] irq event stamp: 0
[263341.871050] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[263341.871054] hardirqs last disabled at (0): [<ffffffffa80dd962>]
copy_process+0x902/0x1df0
[263341.871058] softirqs last  enabled at (0): [<ffffffffa80dd962>]
copy_process+0x902/0x1df0
[263341.871061] softirqs last disabled at (0): [<0000000000000000>] 0x0
[263341.871064] CPU: 1 PID: 3496089 Comm: steamwebhelper Tainted: G
  D W    L   --------- ---  5.12.0-0.rc1.162.fc35.x86_64+debug #1
[263341.871067] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[263341.871069] RIP: 0010:native_queued_spin_lock_slowpath+0x137/0x200
[263341.871073] Code: e0 a9 1d 00 eb cb 41 83 c0 01 c1 e6 10 41 c1 e0
12 44 09 c6 89 f0 c1 e8 10 66 87 42 02 89 c7 c1 e7 10 75 73 31 ff eb
02 f3 90 <8b> 02 66 85 c0 75 f7 41 89 c0 66 45 31 c0 44 39 c6 0f 84 9b
00 00
[263341.871076] RSP: 0018:ffffae43549eb5f8 EFLAGS: 00000202
[263341.871078] RAX: 00000000000c0101 RBX: ffff9d414bc00000 RCX:
ffff9d4946def300
[263341.871081] RDX: ffff9d4253053008 RSI: 0000000000080000 RDI:
0000000000000000
[263341.871083] RBP: ffff9d4253053008 R08: 0000000000080000 R09:
0000000000000000
[263341.871085] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff9d4253053020
[263341.871088] R13: ffff9d414bc00010 R14: 0000000000000000 R15:
ffffed09c02f0000
[263341.871090] FS:  00007f725d561d40(0000) GS:ffff9d4946c00000(0000)
knlGS:0000000000000000
[263341.871093] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[263341.871095] CR2: 0000366b51ea6fe8 CR3: 00000003865f2000 CR4:
0000000000350ee0
[263341.871098] Call Trace:
[263341.871101]  do_raw_spin_lock+0x94/0xa0
[263341.871104]  _raw_spin_lock+0x63/0x80
[263341.871107]  z3fold_page_isolate+0xbd/0x1b0
[263341.871112]  isolate_movable_page+0x94/0x180
[263341.871115]  isolate_migratepages_block+0x5db/0x1120
[263341.871120]  ? lock_release+0x1ef/0x410
[263341.871124]  compact_zone+0x5a4/0xfd0
[263341.871129]  compact_zone_order+0xaa/0xf0
[263341.871134]  try_to_compact_pages+0x111/0x3b0
[263341.871138]  __alloc_pages_direct_compact+0x79/0x210
[263341.871142]  __alloc_pages_slowpath.constprop.0+0x1d0/0xf90
[263341.871147]  ? __alloc_pages_nodemask+0x2e3/0x400
[263341.871151]  ? lock_release+0x1ef/0x410
[263341.871154]  __alloc_pages_nodemask+0x37d/0x400
[263341.871159]  ttm_pool_alloc+0x2a3/0x630 [ttm]
[263341.871167]  ttm_tt_populate+0x37/0xe0 [ttm]
[263341.871172]  ttm_bo_handle_move_mem+0x13a/0x170 [ttm]
[263341.871179]  ttm_bo_validate+0x15f/0x1b0 [ttm]
[263341.871184]  ? lock_release+0x1ef/0x410
[263341.871189]  ttm_bo_init_reserved+0x2f7/0x3e0 [ttm]
[263341.871195]  amdgpu_bo_do_create+0x1a8/0x630 [amdgpu]
[263341.871312]  ? amdgpu_bo_subtract_pin_size+0x50/0x50 [amdgpu]
[263341.871422]  amdgpu_bo_create+0x30/0x2e0 [amdgpu]
[263341.871531]  ? lock_acquire+0x177/0x3a0
[263341.871535]  ? trace_hardirqs_on+0x1b/0xe0
[263341.871539]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[263341.871543]  ? lock_release+0x1ef/0x410
[263341.871547]  amdgpu_gem_create_ioctl+0x10e/0x370 [amdgpu]
[263341.871664]  ? amdgpu_gem_force_release+0x130/0x130 [amdgpu]
[263341.871774]  drm_ioctl_kernel+0x89/0xe0 [drm]
[263341.871797]  drm_ioctl+0x20f/0x3c0 [drm]
[263341.871816]  ? amdgpu_gem_force_release+0x130/0x130 [amdgpu]
[263341.871927]  ? selinux_file_ioctl+0x147/0x200
[263341.871931]  ? lock_acquired+0x200/0x390
[263341.871934]  ? lock_release+0x1ef/0x410
[263341.871937]  ? trace_hardirqs_on+0x1b/0xe0
[263341.871940]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[263341.871944]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[263341.872053]  __x64_sys_ioctl+0x82/0xb0
[263341.872058]  do_syscall_64+0x33/0x40
[263341.872061]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[263341.872065] RIP: 0033:0x7f72610b22bb
[263341.872068] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d
4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 bb 0c 00 f7 d8 64 89
01 48
[263341.872071] RSP: 002b:00007ffcd94a01f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[263341.872074] RAX: ffffffffffffffda RBX: 00007ffcd94a0250 RCX:
00007f72610b22bb
[263341.872076] RDX: 00007ffcd94a0250 RSI: 00000000c0206440 RDI:
0000000000000016
[263341.872078] RBP: 00000000c0206440 R08: 0000000000000009 R09:
00000000000000b8
[263341.872081] R10: 00007ffcd9568080 R11: 0000000000000246 R12:
000008c86f1ae3c0
[263341.872083] R13: 0000000000000016 R14: 0000000000200000 R15:
00000000019c6000
[263341.872983] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [kswapd0:288]
[263341.872991] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib tun snd_seq_dummy snd_hrtimer uinput nls_utf8
isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep zstd sunrpc vfat
fat hid_logitech_hidpp hid_logitech_dj snd_hda_codec_realtek
snd_hda_codec_generic mt76x2u mt76x2_common ledtrig_audio mt76x02_usb
mt76_usb snd_hda_codec_hdmi mt76x02_lib intel_rapl_msr
intel_rapl_common iwlmvm mt76 snd_hda_intel snd_intel_dspcfg
soundwire_intel soundwire_generic_allocation snd_soc_core edac_mce_amd
joydev mac80211 snd_compress snd_pcm_dmaengine snd_usb_audio
soundwire_cadence kvm_amd snd_hda_codec btusb btrtl btbcm btintel
snd_hda_core snd_usbmidi_lib uvcvideo ac97_bus snd_seq iwlwifi kvm
snd_rawmidi bluetooth snd_hwdep videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 videobuf2_common
[263341.873025]  eeepc_wmi snd_seq_device asus_wmi snd_pcm videodev
sparse_keymap xpad ecdh_generic mc libarc4 irqbypass wmi_bmof
ff_memless cfg80211 video ecc snd_timer rapl sp5100_tco snd i2c_piix4
k10temp soundcore rfkill acpi_cpufreq binfmt_misc uas usb_storage
amdgpu drm_ttm_helper ttm iommu_v2 crct10dif_pclmul gpu_sched
crc32_pclmul crc32c_intel drm_kms_helper cec drm ghash_clmulni_intel
ccp igb nvme dca nvme_core i2c_algo_bit wmi pinctrl_amd fuse [last
unloaded: ip_tables]
[263341.873052] irq event stamp: 36
[263341.873054] hardirqs last  enabled at (35): [<ffffffffa8d61117>]
_raw_spin_unlock_irqrestore+0x37/0x40
[263341.873059] hardirqs last disabled at (36): [<ffffffffa8d5a8a9>]
__schedule+0x6e9/0xb20
[263341.873063] softirqs last  enabled at (0): [<ffffffffa80dd962>]
copy_process+0x902/0x1df0
[263341.873066] softirqs last disabled at (0): [<0000000000000000>] 0x0
[263341.873069] CPU: 2 PID: 288 Comm: kswapd0 Tainted: G      D W    L
  --------- ---  5.12.0-0.rc1.162.fc35.x86_64+debug #1
[263341.873073] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[263341.873075] RIP: 0010:native_queued_spin_lock_slowpath+0x1ce/0x200
[263341.873079] Code: c1 ef 12 83 e0 03 83 ef 01 48 c1 e0 05 48 63 ff
48 05 00 f3 1e 00 48 03 04 fd 20 d9 6e a9 48 89 08 8b 41 08 85 c0 75
09 f3 90 <8b> 41 08 85 c0 74 f7 48 8b 39 48 85 ff 0f 84 56 ff ff ff 0f
0d 0f
[263341.873082] RSP: 0018:ffffae4340943898 EFLAGS: 00000246
[263341.873085] RAX: 0000000000000000 RBX: ffff9d4253053000 RCX:
ffff9d4946fef300
[263341.873087] RDX: ffff9d4253053008 RSI: 00000000000c0000 RDI:
0000000000000001
[263341.873090] RBP: ffff9d4253053008 R08: 00000000000c0000 R09:
0000000000000000
[263341.873092] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9d4253053020
[263341.873094] R13: 0000000000000003 R14: 0000000000000003 R15:
ffff9d41760b2000
[263341.873097] FS:  0000000000000000(0000) GS:ffff9d4946e00000(0000)
knlGS:0000000000000000
[263341.873099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[263341.873102] CR2: 0000021509b13000 CR3: 00000004130c8000 CR4:
0000000000350ee0
[263341.873104] Call Trace:
[263341.873107]  do_raw_spin_lock+0x94/0xa0
[263341.873110]  _raw_spin_lock+0x63/0x80
[263341.873114]  __z3fold_alloc+0x78/0x3d0
[263341.873118]  z3fold_zpool_malloc+0x4a5/0x7c0
[263341.873121]  ? _raw_spin_unlock+0x1f/0x30
[263341.873125]  zswap_frontswap_store+0x43e/0x890
[263341.873130]  __frontswap_store+0xc8/0x170
[263341.873134]  swap_writepage+0x39/0x70
[263341.873137]  pageout+0x125/0x540
[263341.873142]  shrink_page_list+0x131b/0x1bb0
[263341.873147]  shrink_inactive_list+0x12a/0x440
[263341.873152]  shrink_lruvec+0x4aa/0x6d0
[263341.873158]  shrink_node+0x2d1/0x700
[263341.873163]  balance_pgdat+0x2f5/0x650
[263341.873169]  kswapd+0x21d/0x4d0
[263341.873172]  ? do_wait_intr_irq+0xd0/0xd0
[263341.873176]  ? balance_pgdat+0x650/0x650
[263341.873179]  kthread+0x13a/0x150
[263341.873183]  ? __kthread_bind_mask+0x60/0x60
[263341.873187]  ret_from_fork+0x22/0x30


It related?


Full kernel log is here: https://pastebin.com/x0KbXN9L


-- 
Best Regards,
Mike Gavrilov.
