Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A314433126D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:42:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:42:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u4so21735532lfs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zz1ygsea08ErKMownEWrNiQzwNd2MPMW6QStZC6ar80=;
        b=Zh3OybuwSDxNRtNCijibw6qv4/Xx8eKgTiL9bGc6Nw9gLZ8GFqN0UfDgYaXKpPRz86
         /X8m7xcbEEflEbjFkc4HtdDqY3SybilgNps6QrW3FP7WWHd6sR48sD2TAoyGwgj1FTX1
         lFRGR7iP4g6SsQm8ssXCCBvapMWaaAbLonai3FX59C5oZqqLy8EP/DDqU94P7W30fu3i
         GP6F3F+qazrp7wyYLaKnoz7LSEbDJiw9omY6gFCpvVQGysUEK8K/rLQ5c2LTp17huoqd
         YEXhg6CmIougErKv7aC10v9/aWmhnUKvkVjDe/Q2samtBSnxwrCFMGVt/0RauLO1Rd2s
         xNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zz1ygsea08ErKMownEWrNiQzwNd2MPMW6QStZC6ar80=;
        b=Nmr4ffwOFVXvCmeLpAZlIPOY77JTgbZk84W6v1qneHcBmmfy6mYIhXvqneiW2+FrBQ
         c4U9Hw/b39RZQluM6P4yUOLnVMIVMvkImQGrtSKY+NvxwzXBOBpSgEEjyYJjk7KICe+L
         neCGTKM5/BuZUtZvwKwNqQCl4Ncxqy4KI6imElqjkw3u7dZQ1XfVoGQUpClD9Cr8keYH
         LEv1A8t1L0oP/DrZiGT4/lhQfs9aHDtwmsEkl9FWgrQe8VBHlY1WytFtM/3WSBBGW42l
         QXPWzyGln+KgSjpxvULHrBF1MfKxbzn71aIL6NBhciPuv65Es//m1FFItSdg0kHL8Thz
         sAyw==
X-Gm-Message-State: AOAM5331CMxgQaH3xLef+ODcSZaCGJcXDk82qJRAqUbEZgGaw/dDuhal
        nPiuyxE2/DP8quLhl0WpID1aknuZHXJepK5jP/k=
X-Google-Smtp-Source: ABdhPJwd/3KdpIQ/QqEUflXdjMGJC+1p6H+PgY5JoVgNAOEdmUXyB1ThY4TvjbfINQaFDTyrARP82FqcvrvCJbaz5YQ=
X-Received: by 2002:a05:6512:504:: with SMTP id o4mr14453300lfb.438.1615218173289;
 Mon, 08 Mar 2021 07:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20210126082834.2020-1-hdanton@sina.com> <CABXGCsNN+u2SqOvmw2JojTnESSLgxKgfJLQuB3Ne1fcNA47UZw@mail.gmail.com>
 <20210213030327.4992-1-hdanton@sina.com> <CABXGCsNAvXbOQxEWaHqf-iehX39OOOQwXBSJz7bZ6+68zn0tuA@mail.gmail.com>
 <20210301031107.1299-1-hdanton@sina.com> <CABXGCsNFW0XnGw5qn1f3LLYY_tqkn3CBES=iujS2arsuV7aLkQ@mail.gmail.com>
 <20210305142232.14680-1-hdanton@sina.com>
In-Reply-To: <20210305142232.14680-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 8 Mar 2021 20:42:42 +0500
Message-ID: <CABXGCsP0cvMAuG5A3EP8Nev1VxiL-hsGqHWrwgknckEe4vVZJQ@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, MM <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 at 19:22, Hillf Danton <hdanton@sina.com> wrote:
>
> Yes, it is the same race as we saw before. But after cutting the race
> between poo->stale_lock and pool->lock with the patch above, the race
> between the free path and isolate/putback path came up.
>
> Try the diff below in combination with the patch above
>
> --- x/mm/z3fold.c
> +++ y/mm/z3fold.c
> @@ -1676,8 +1676,10 @@ static void z3fold_page_putback(struct p
>         pool = zhdr_to_pool(zhdr);
>
>         z3fold_page_lock(zhdr);
> +       spin_lock(&pool->lock);
>         if (!list_empty(&zhdr->buddy))
>                 list_del_init(&zhdr->buddy);
> +       spin_unlock(&pool->lock);
>         INIT_LIST_HEAD(&page->lru);
>         if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>                 atomic64_dec(&pool->pages_nr);

Unfortunately even with combination of two latest patches computer
hanged again after two days uptime.

[185000.747401] list_add corruption. next->prev should be prev
(ffffe0c1bea61f40), but was 0000000000000000. (next=ffff9bb90b444000).
[185000.747438] ------------[ cut here ]------------
[185000.747441] kernel BUG at lib/list_debug.c:23!
[185000.747449] invalid opcode: 0000 [#1] SMP NOPTI
[185000.747454] CPU: 22 PID: 1588003 Comm: Web Content Tainted: G
  W        --------- ---
5.12.0-0.rc1.20210305git280d542f6ffa.164.fc35.x86_64 #1
[185000.747458] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[185000.747462] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[185000.747469] Code: 48 c7 c6 7c a9 64 84 48 89 ef 49 c7 c7 ea ff ff
ff e8 9d 81 01 00 e9 5f ee 9c ff 4c 89 c1 48 c7 c7 48 aa 64 84 e8 74
fd fd ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 f8 aa 64 84 e8 5d
fd fd
[185000.747472] RSP: 0000:ffffc0c1c61cfc10 EFLAGS: 00010286
[185000.747476] RAX: 0000000000000075 RBX: fffffa0d596b0a40 RCX:
0000000000000000
[185000.747479] RDX: ffff9bbc097e97a0 RSI: ffff9bbc097daae0 RDI:
ffff9bbc097daae0
[185000.747482] RBP: ffffe0c1bea61f40 R08: 0000000000000000 R09:
ffffc0c1c61cfa58
[185000.747485] R10: ffffc0c1c61cfa50 R11: 0000000000000000 R12:
ffff9bb537b4f008
[185000.747488] R13: ffff9bba5ac29010 R14: ffff9bb90b444000 R15:
ffff9bba5ac29000
[185000.747491] FS:  00007f198ea257c0(0000) GS:ffff9bbc09600000(0000)
knlGS:0000000000000000
[185000.747495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[185000.747498] CR2: 00000fe3aa523500 CR3: 000000012f870000 CR4:
0000000000350ee0
[185000.747501] Call Trace:
[185000.747504]  do_compact_page+0x28d/0xb60
[185000.747509]  ? _raw_spin_unlock+0x1f/0x30
[185000.747514]  ? z3fold_zpool_free+0x3a8/0x590
[185000.747518]  zswap_free_entry+0x43/0x70
[185000.747523]  zswap_frontswap_invalidate_page+0x8c/0x90
[185000.747527]  __frontswap_invalidate_page+0x5d/0x90
[185000.747531]  swap_range_free+0xcd/0xf0
[185000.747535]  swapcache_free_entries+0x128/0x1a0
[185000.747539]  free_swap_slot+0xbb/0xd0
[185000.747543]  __swap_entry_free+0x7a/0xa0
[185000.747547]  do_swap_page+0x393/0x900
[185000.747551]  __handle_mm_fault+0xbd6/0x1610
[185000.747557]  handle_mm_fault+0xa2/0x270
[185000.747561]  do_user_addr_fault+0x1ea/0x6b0
[185000.747566]  exc_page_fault+0x67/0x2a0
[185000.747570]  ? asm_exc_page_fault+0x8/0x30
[185000.747574]  asm_exc_page_fault+0x1e/0x30
[185000.747578] RIP: 0033:0x7f198eb8be30
[185000.747582] Code: 9d 48 81 fa 80 00 00 00 77 19 c5 fe 7f 07 c5 fe
7f 47 20 c5 fe 7f 44 17 e0 c5 fe 7f 44 17 c0 c5 f8 77 c3 48 8d 8f 80
00 00 00 <c5> fe 7f 07 48 83 e1 80 c5 fe 7f 44 17 e0 c5 fe 7f 47 20 c5
fe 7f
[185000.747585] RSP: 002b:00007ffea7e406e8 EFLAGS: 00010202
[185000.747589] RAX: 00000fe3aa523500 RBX: 00007ffea7e40738 RCX:
00000fe3aa523580
[185000.747592] RDX: 0000000000004000 RSI: 00000000000000fa RDI:
00000fe3aa523500
[185000.747594] RBP: 0000600000000000 R08: 00007f195295a000 R09:
ffffffffffffffff
[185000.747597] R10: 0000556a267402c8 R11: 0000000000000206 R12:
00007f195295a800
[185000.747600] R13: fffffc0000000000 R14: 00007ffea7e40738 R15:
00007f195295a7f0
[185000.747605] Modules linked in: crypto_user tun snd_seq_dummy
snd_hrtimer uinput nls_utf8 isofs rfcomm netconsole nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep
zstd sunrpc vfat fat hid_logitech_hidpp usblp hid_logitech_dj
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi intel_rapl_msr mt76x2u joydev intel_rapl_common
snd_hda_intel mt76x2_common iwlmvm snd_intel_dspcfg mt76x02_usb
uvcvideo snd_intel_sdw_acpi snd_usb_audio mt76_usb snd_hda_codec
edac_mce_amd videobuf2_vmalloc mt76x02_lib videobuf2_memops
videobuf2_v4l2 snd_hda_core mt76 videobuf2_common snd_usbmidi_lib
kvm_amd btusb snd_hwdep snd_rawmidi videodev btrtl mac80211 kvm
snd_seq btbcm btintel snd_seq_device irqbypass libarc4 eeepc_wmi xpad
mc bluetooth rapl ff_memless snd_pcm
[185000.747647]  iwlwifi asus_wmi sparse_keymap video snd_timer
ecdh_generic ecc wmi_bmof pcspkr snd cfg80211 soundcore sp5100_tco
k10temp i2c_piix4 rfkill acpi_cpufreq binfmt_misc ip_tables uas
usb_storage amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
crct10dif_pclmul drm_kms_helper crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel ccp igb nvme dca nvme_core i2c_algo_bit wmi
pinctrl_amd fuse
[185000.747878] ---[ end trace df51d3d2498d767d ]---
[185000.747882] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[185000.747886] Code: 48 c7 c6 7c a9 64 84 48 89 ef 49 c7 c7 ea ff ff
ff e8 9d 81 01 00 e9 5f ee 9c ff 4c 89 c1 48 c7 c7 48 aa 64 84 e8 74
fd fd ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 f8 aa 64 84 e8 5d
fd fd
[185000.747889] RSP: 0000:ffffc0c1c61cfc10 EFLAGS: 00010286
[185000.747893] RAX: 0000000000000075 RBX: fffffa0d596b0a40 RCX:
0000000000000000
[185000.747895] RDX: ffff9bbc097e97a0 RSI: ffff9bbc097daae0 RDI:
ffff9bbc097daae0
[185000.747898] RBP: ffffe0c1bea61f40 R08: 0000000000000000 R09:
ffffc0c1c61cfa58
[185000.747901] R10: ffffc0c1c61cfa50 R11: 0000000000000000 R12:
ffff9bb537b4f008
[185000.747904] R13: ffff9bba5ac29010 R14: ffff9bb90b444000 R15:
ffff9bba5ac29000
[185000.747907] FS:  00007f198ea257c0(0000) GS:ffff9bbc09600000(0000)
knlGS:0000000000000000
[185000.747910] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[185000.747913] CR2: 00000fe3aa523500 CR3: 000000012f870000 CR4:
0000000000350ee0
[185000.747916] note: Web Content[1588003] exited with preempt_count 6
[185026.580248] watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
[Chrome_ChildIOT:1951362]
[185026.580262] Modules linked in: crypto_user tun snd_seq_dummy
snd_hrtimer uinput nls_utf8 isofs rfcomm netconsole nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink cmac bnep
zstd sunrpc vfat fat hid_logitech_hidpp usblp hid_logitech_dj
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi intel_rapl_msr mt76x2u joydev intel_rapl_common
snd_hda_intel mt76x2_common iwlmvm snd_intel_dspcfg mt76x02_usb
uvcvideo snd_intel_sdw_acpi snd_usb_audio mt76_usb snd_hda_codec
edac_mce_amd videobuf2_vmalloc mt76x02_lib videobuf2_memops
videobuf2_v4l2 snd_hda_core mt76 videobuf2_common snd_usbmidi_lib
kvm_amd btusb snd_hwdep snd_rawmidi videodev btrtl mac80211 kvm
snd_seq btbcm btintel snd_seq_device irqbypass libarc4 eeepc_wmi xpad
mc bluetooth rapl ff_memless snd_pcm
[185026.580306]  iwlwifi asus_wmi sparse_keymap video snd_timer
ecdh_generic ecc wmi_bmof pcspkr snd cfg80211 soundcore sp5100_tco
k10temp i2c_piix4 rfkill acpi_cpufreq binfmt_misc ip_tables uas
usb_storage amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
crct10dif_pclmul drm_kms_helper crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel ccp igb nvme dca nvme_core i2c_algo_bit wmi
pinctrl_amd fuse
[185026.580334] irq event stamp: 0
[185026.580337] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[185026.580342] hardirqs last disabled at (0): [<ffffffff830dd962>]
copy_process+0x902/0x1df0
[185026.580349] softirqs last  enabled at (0): [<ffffffff830dd962>]
copy_process+0x902/0x1df0
[185026.580353] softirqs last disabled at (0): [<0000000000000000>] 0x0
[185026.580357] CPU: 0 PID: 1951362 Comm: Chrome_ChildIOT Tainted: G
   D W        --------- ---
5.12.0-0.rc1.20210305git280d542f6ffa.164.fc35.x86_64 #1
[185026.580362] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[185026.580365] RIP: 0010:native_queued_spin_lock_slowpath+0x1ce/0x200
[185026.580370] Code: c1 ef 12 83 e0 03 83 ef 01 48 c1 e0 05 48 63 ff
48 05 00 f3 1e 00 48 03 04 fd 20 d9 6e 84 48 89 08 8b 41 08 85 c0 75
09 f3 90 <8b> 41 08 85 c0 74 f7 48 8b 39 48 85 ff 0f 84 56 ff ff ff 0f
0d 0f
[185026.580374] RSP: 0000:ffffc0c1d596fbf0 EFLAGS: 00000246
[185026.580379] RAX: 0000000000000000 RBX: 0000000000f10bea RCX:
ffff9bbc06bef300
[185026.580382] RDX: ffff9bb500b9fb48 RSI: 0000000000040000 RDI:
0000000000000013
[185026.580385] RBP: ffff9bb500b9fb48 R08: 0000000000040000 R09:
0000000000000000
[185026.580388] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9bb500b9fb60
[185026.580391] R13: ffff9bb500b9fb48 R14: ffffffff84e87020 R15:
ffff9bb500b9fb40
[185026.580394] FS:  00007f2e2ffe6640(0000) GS:ffff9bbc06a00000(0000)
knlGS:0000000000000000
[185026.580398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[185026.580401] CR2: 00002a8e6ef59188 CR3: 0000000306082000 CR4:
0000000000350ef0
[185026.580405] Call Trace:
[185026.580408]  do_raw_spin_lock+0x94/0xa0
[185026.580665]  _raw_spin_lock+0x63/0x80
[185026.580670]  zswap_frontswap_load+0x30/0x2f0
[185026.580676]  ? trace_hardirqs_on+0x1b/0xe0
[185026.580681]  __frontswap_load+0xc3/0x160
[185026.580685]  swap_readpage+0x257/0x430
[185026.580689]  swapin_readahead+0x450/0x4e0
[185026.580693]  ? lock_release+0x1ef/0x410
[185026.580698]  do_swap_page+0x4a4/0x900
[185026.580703]  __handle_mm_fault+0xbd6/0x1610
[185026.580795]  handle_mm_fault+0xa2/0x270
[185026.580799]  do_user_addr_fault+0x1ea/0x6b0
[185026.580804]  exc_page_fault+0x67/0x2a0
[185026.580808]  ? asm_exc_page_fault+0x8/0x30
[185026.580889]  asm_exc_page_fault+0x1e/0x30
[185026.580893] RIP: 0033:0x55d9d6466038
[185026.580897] Code: cc cc 55 48 89 e5 48 89 7f 10 48 89 7f 18 5d c3
cc cc 55 48 89 e5 48 8b 47 10 48 8b 4f 18 48 89 41 10 48 8b 47 10 48
8b 4f 18 <48> 89 48 18 0f 57 c0 0f 11 47 10 5d c3 cc cc cc cc cc cc cc
cc cc
[185026.580900] RSP: 002b:00007f2e2ffe46b0 EFLAGS: 00010246
[185026.580968] RAX: 00002a8e6ef59170 RBX: 00002a8e6ef40420 RCX:
00002a8e6ef4e370
[185026.580972] RDX: 00002a8e6d6715e0 RSI: 00002a8e6dcb02e0 RDI:
00002a8e6ef40420
[185026.580974] RBP: 00007f2e2ffe46b0 R08: 0000000000000000 R09:
00007fff260af5d0
[185026.581039] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000020
[185026.581042] R13: 00002a8e6dcb02e0 R14: 000055d9deb9b1e0 R15:
00002a8e6dcb02e0

Full kernel log is here: https://pastebin.com/WmBLJ3MR

-- 
Best Regards,
Mike Gavrilov.
