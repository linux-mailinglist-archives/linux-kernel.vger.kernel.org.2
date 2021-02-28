Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EA327273
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhB1NXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 08:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhB1NXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 08:23:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327CFC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 05:22:34 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q23so16180604lji.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjsSH8a0NP4Eva+k2zeqQXaqqdYQ1WgwDe3nn7UlaQ0=;
        b=PTbC1q+a5z45i10RuUacMNmhQuBCl9GjJwsl3WUp/drIQWFldGT466qqiYvwfqp24z
         ViC/wKZnGABTlSntgWdmk0poZdltWQnMgUgRRUYy1OuErSLFhAAKcC2suqgDBPkDXCQx
         3GstuCqlLmjeXxY3XvS5tQhaZLBhrL6qwX9kq95/2PRJFYARt2l8TqQcIF1Hct30IPM3
         OVWSk3ZksCg1gv+U84RswHxx7B/xKExpFBiBANYhdgCNQ45hnxuOpHcO9OFKDse5lN+l
         g6uwyyRmpN5hIrRWIhzxzCIM2nNQxYnOo6iMwJyCZi1Vo23P9HK1ckr2MoMG00zeiFfj
         vWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjsSH8a0NP4Eva+k2zeqQXaqqdYQ1WgwDe3nn7UlaQ0=;
        b=ecvInRaOdt9o0mxVS22jX7sQtfpQ8JPBaUFMjaYa/03zYNIrRNW/gmKaUXM9rLAe88
         AdJNzkr4hrkwq5gnMiWpeddyEzURrAj8usopZLjc5ZZ5y/Dkck6nxSOqkpdxuk0t9m25
         S+yN6PIPh2CIzX0o7RLjdGxSJCHqlPFPYY10WKJ0iHrhLDDJwLAHFPdffwKCeOjs3+vV
         CJQrf6DmLv1fTXrKGmSL1YoJ3Lba6BednR0US+G6yZH+hy5GuarounUPXKiNgfbWIxvQ
         XmlRhmHhQmto1Izj4gDkQuN8GZdNMjGsL2ug6QMDPe8NZWsX5Cbmmnp9OsJ0Ta2S00+9
         ao4Q==
X-Gm-Message-State: AOAM533gjIe88c1PdbLgKUpz6F6bQjI2wc//Zz33B3Wl9tlJwHKTP2/t
        dfUc7VyAHQlZVI4K0FCpWqLdgYNHxNTImI4JsZUCMcEDJGcJPA==
X-Google-Smtp-Source: ABdhPJwpdcVfocGHRMOLyZeZdYa52saE1ILfL2qecFnen7M+1mh5FIYkLPKqPHrzdptChto8qRUWONXGBOou352aS9A=
X-Received: by 2002:a2e:760d:: with SMTP id r13mr6434833ljc.223.1614518552360;
 Sun, 28 Feb 2021 05:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20210126082834.2020-1-hdanton@sina.com> <CABXGCsNN+u2SqOvmw2JojTnESSLgxKgfJLQuB3Ne1fcNA47UZw@mail.gmail.com>
 <20210213030327.4992-1-hdanton@sina.com>
In-Reply-To: <20210213030327.4992-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 28 Feb 2021 18:22:21 +0500
Message-ID: <CABXGCsNAvXbOQxEWaHqf-iehX39OOOQwXBSJz7bZ6+68zn0tuA@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, MM <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Feb 2021 at 08:03, Hillf Danton <hdanton@sina.com> wrote:
>
> The comment below shows a race instance, though I failed to put things
> together to see how within two hours. Cut it and see what will come up.
>
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1129,19 +1129,22 @@ retry:
>         page = NULL;
>         if (can_sleep) {
>                 spin_lock(&pool->stale_lock);
> +               spin_lock(&pool->lock);
>                 zhdr = list_first_entry_or_null(&pool->stale,
>                                                 struct z3fold_header, buddy);
>                 /*
> -                * Before allocating a page, let's see if we can take one from
> +                * Before allocating a page, lets see if we can take one from
>                  * the stale pages list. cancel_work_sync() can sleep so we
>                  * limit this case to the contexts where we can sleep
>                  */
>                 if (zhdr) {
>                         list_del(&zhdr->buddy);
> +                       spin_unlock(&pool->lock);
>                         spin_unlock(&pool->stale_lock);
>                         cancel_work_sync(&zhdr->work);
>                         page = virt_to_page(zhdr);
>                 } else {
> +                       spin_unlock(&pool->lock);
>                         spin_unlock(&pool->stale_lock);
>                 }
>         }


Hi,
It happened again with the patch above.
Is anything cleared up now?

[32451.229358] list_add corruption. next->prev should be prev
(ffffd08fbc661cd0), but was ffffffffa7643650. (next=ffff9e4d2848f1c0).
[32451.229395] ------------[ cut here ]------------
[32451.229398] kernel BUG at lib/list_debug.c:23!
[32451.229408] invalid opcode: 0000 [#1] SMP NOPTI
[32451.229414] CPU: 4 PID: 80665 Comm: kworker/u64:0 Tainted: G
W        --------- ---  5.11.0-155.fc35.x86_64+debug #1
[32451.229420] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[32451.229424] Workqueue: zswap3 compact_page_work
[32451.229433] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[32451.229439] Code: 48 c7 c6 24 26 64 a8 48 89 ef 49 c7 c7 ea ff ff
ff e8 e8 71 01 00 e9 fa 10 9e ff 4c 89 c1 48 c7 c7 f0 26 64 a8 e8 50
12 fe ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 a0 27 64 a8 e8 39
12 fe
[32451.229444] RSP: 0018:ffffb08fd553fde0 EFLAGS: 00010286
[32451.229449] RAX: 0000000000000075 RBX: ffffe16d871550c0 RCX: 0000000000000000
[32451.229453] RDX: ffff9e53c73e9f60 RSI: ffff9e53c73db2a0 RDI: ffff9e53c73db2a0
[32451.229457] RBP: ffffd08fbc661cd0 R08: 0000000000000000 R09: ffffb08fd553fc20
[32451.229460] R10: ffffb08fd553fc18 R11: 0000000000000000 R12: ffff9e4ce4e29008
[32451.229464] R13: ffff9e4d85543010 R14: ffff9e4d2848f1c0 R15: ffff9e4d85543000
[32451.229468] FS:  0000000000000000(0000) GS:ffff9e53c7200000(0000)
knlGS:0000000000000000
[32451.229472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32451.229476] CR2: 00000fb21455dfe8 CR3: 0000000142968000 CR4: 0000000000350ee0
[32451.229480] Call Trace:
[32451.229485]  do_compact_page+0x28d/0xb60
[32451.229492]  ? debug_object_deactivate+0x55/0x140
[32451.229499]  ? lock_release+0x1e9/0x400
[32451.229505]  ? lock_release+0x1e9/0x400
[32451.229511]  process_one_work+0x2b0/0x5e0
[32451.229519]  worker_thread+0x55/0x3c0
[32451.229524]  ? process_one_work+0x5e0/0x5e0
[32451.229531]  kthread+0x13a/0x150
[32451.229540]  ? __kthread_bind_mask+0x60/0x60
[32451.229548]  ret_from_fork+0x22/0x30
[32451.229558] Modules linked in: snd_seq_dummy snd_hrtimer tun uinput
nls_utf8 isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep zstd sunrpc xpad ff_memless vfat fat
hid_logitech_hidpp hid_logitech_dj joydev snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc snd_hda_intel videobuf2_memops videobuf2_v4l2
snd_intel_dspcfg mt76x2u soundwire_intel mt76x2_common
videobuf2_common mt76x02_usb soundwire_generic_allocation mt76_usb
intel_rapl_msr intel_rapl_common iwlmvm snd_soc_core snd_usb_audio
videodev snd_compress mt76x02_lib btusb snd_usbmidi_lib
snd_pcm_dmaengine mt76 soundwire_cadence btrtl snd_rawmidi btbcm
snd_hda_codec mc btintel edac_mce_amd mac80211 kvm_amd snd_hda_core
uas bluetooth ac97_bus
[32451.229628]  iwlwifi snd_hwdep usb_storage kvm snd_seq libarc4
snd_seq_device ecdh_generic cfg80211 ecc irqbypass snd_pcm rapl
eeepc_wmi asus_wmi sparse_keymap snd_timer rfkill snd video sp5100_tco
wmi_bmof i2c_piix4 k10temp soundcore acpi_cpufreq binfmt_misc
ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel cec drm igb
ghash_clmulni_intel nvme ccp dca nvme_core i2c_algo_bit wmi
pinctrl_amd fuse
[32451.229696] ---[ end trace 80d86d6942435514 ]---
[32451.229701] RIP: 0010:__list_add_valid.cold+0xf/0x3f
[32451.229706] Code: 48 c7 c6 24 26 64 a8 48 89 ef 49 c7 c7 ea ff ff
ff e8 e8 71 01 00 e9 fa 10 9e ff 4c 89 c1 48 c7 c7 f0 26 64 a8 e8 50
12 fe ff <0f> 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 a0 27 64 a8 e8 39
12 fe
[32451.229710] RSP: 0018:ffffb08fd553fde0 EFLAGS: 00010286
[32451.229715] RAX: 0000000000000075 RBX: ffffe16d871550c0 RCX: 0000000000000000
[32451.229721] RDX: ffff9e53c73e9f60 RSI: ffff9e53c73db2a0 RDI: ffff9e53c73db2a0
[32451.229725] RBP: ffffd08fbc661cd0 R08: 0000000000000000 R09: ffffb08fd553fc20
[32451.229729] R10: ffffb08fd553fc18 R11: 0000000000000000 R12: ffff9e4ce4e29008
[32451.229732] R13: ffff9e4d85543010 R14: ffff9e4d2848f1c0 R15: ffff9e4d85543000
[32451.229736] FS:  0000000000000000(0000) GS:ffff9e53c7200000(0000)
knlGS:0000000000000000
[32451.229740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32451.229744] CR2: 00000fb21455dfe8 CR3: 0000000142968000 CR4: 0000000000350ee0
[32451.229748] note: kworker/u64:0[80665] exited with preempt_count 2
[32476.846645] watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
[vivaldi-bin:6991]
[32476.846658] Modules linked in: snd_seq_dummy snd_hrtimer tun uinput
nls_utf8 isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep zstd sunrpc xpad ff_memless vfat fat
hid_logitech_hidpp hid_logitech_dj joydev snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc snd_hda_intel videobuf2_memops videobuf2_v4l2
snd_intel_dspcfg mt76x2u soundwire_intel mt76x2_common
videobuf2_common mt76x02_usb soundwire_generic_allocation mt76_usb
intel_rapl_msr intel_rapl_common iwlmvm snd_soc_core snd_usb_audio
videodev snd_compress mt76x02_lib btusb snd_usbmidi_lib
snd_pcm_dmaengine mt76 soundwire_cadence btrtl snd_rawmidi btbcm
snd_hda_codec mc btintel edac_mce_amd mac80211 kvm_amd snd_hda_core
uas bluetooth ac97_bus
[32476.846704]  iwlwifi snd_hwdep usb_storage kvm snd_seq libarc4
snd_seq_device ecdh_generic cfg80211 ecc irqbypass snd_pcm rapl
eeepc_wmi asus_wmi sparse_keymap snd_timer rfkill snd video sp5100_tco
wmi_bmof i2c_piix4 k10temp soundcore acpi_cpufreq binfmt_misc
ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel cec drm igb
ghash_clmulni_intel nvme ccp dca nvme_core i2c_algo_bit wmi
pinctrl_amd fuse
[32476.846874] irq event stamp: 0
[32476.846877] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[32476.846883] hardirqs last disabled at (0): [<ffffffffa70ddccb>]
copy_process+0x8fb/0x1de0
[32476.846889] softirqs last  enabled at (0): [<ffffffffa70ddccb>]
copy_process+0x8fb/0x1de0
[32476.846892] softirqs last disabled at (0): [<0000000000000000>] 0x0
[32476.846896] CPU: 0 PID: 6991 Comm: vivaldi-bin Tainted: G      D W
      --------- ---  5.11.0-155.fc35.x86_64+debug #1
[32476.846900] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[32476.846904] RIP: 0010:native_queued_spin_lock_slowpath+0x1ce/0x200
[32476.846909] Code: c1 ef 12 83 e0 03 83 ef 01 48 c1 e0 05 48 63 ff
48 05 80 f1 1e 00 48 03 04 fd 00 39 6e a8 48 89 08 8b 41 08 85 c0 75
09 f3 90 <8b> 41 08 85 c0 74 f7 48 8b 39 48 85 ff 0f 84 56 ff ff ff 0f
0d 0f
[32476.846913] RSP: 0000:ffffb08fd2937c10 EFLAGS: 00000246
[32476.846917] RAX: 0000000000000000 RBX: ffffe16d9e844240 RCX: ffff9e53c6bef180
[32476.846920] RDX: ffff9e4cc11a3d28 RSI: 0000000000040000 RDI: 000000000000000d
[32476.846923] RBP: ffff9e4cc11a3d28 R08: 0000000000040000 R09: 0000000000000000
[32476.846926] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9e4cc11a3d40
[32476.846929] R13: ffff9e4cc11a3d28 R14: ffff9e4cc11a3d20 R15: 0000000000ddd8d8
[32476.846932] FS:  00007f4b852a0300(0000) GS:ffff9e53c6a00000(0000)
knlGS:0000000000000000
[32476.846935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32476.846939] CR2: 00003d0509d83000 CR3: 000000017733a000 CR4: 0000000000350ef0
[32476.846942] Call Trace:
[32476.846946]  do_raw_spin_lock+0x94/0xa0
[32476.846951]  _raw_spin_lock+0x63/0x80
[32476.846955]  zswap_frontswap_load+0x2f/0x2f0
[32476.846960]  ? psi_group_change+0x27d/0x290
[32476.846965]  __frontswap_load+0xc3/0x160
[32476.846969]  swap_readpage+0x1ca/0x3a0
[32476.846974]  swapin_readahead+0x2ee/0x4e0
[32476.846979]  do_swap_page+0x4a4/0x900
[32476.846983]  ? lock_release+0x1e9/0x400
[32476.846987]  ? trace_hardirqs_on+0x1b/0xe0
[32476.846992]  handle_mm_fault+0xe7d/0x19d0
[32476.846997]  do_user_addr_fault+0x1c7/0x4c0
[32476.847003]  exc_page_fault+0x67/0x2a0
[32476.847007]  ? asm_exc_page_fault+0x8/0x30
[32476.847011]  asm_exc_page_fault+0x1e/0x30
[32476.847015] RIP: 0033:0x55a5d9c33379
[32476.847018] Code: 00 00 4d 89 75 00 4c 89 f0 48 25 00 00 fc ff 48
8b 40 08 41 c7 46 03 03 00 00 00 49 8b 4d 00 44 89 61 07 49 8b 5d 00
4d 8b 37 <44> 89 73 0b a9 00 00 04 00 75 1a 83 e0 18 48 85 c0 74 12 49
8b 45
[32476.847022] RSP: 002b:00007fff34882340 EFLAGS: 00010206
[32476.847025] RAX: 0000000000000012 RBX: 00003d0509d82ff5 RCX: 00003d0509d82ff5
[32476.847028] RDX: 000055a5dbb578bb RSI: 0000000000000001 RDI: 0000000000000000
[32476.847031] RBP: 00007fff34882370 R08: 0000000000000000 R09: 0000000000000000
[32476.847034] R10: 00003d0500000000 R11: ffffffff00000000 R12: 0000000000000023
[32476.847037] R13: 0000376895df40a0 R14: 00003d0509d82f7d R15: 0000376895df4080
[32476.849645] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
[Chrome_ChildIOT:5472]
[32476.849652] Modules linked in: snd_seq_dummy snd_hrtimer tun uinput
nls_utf8 isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep zstd sunrpc xpad ff_memless vfat fat
hid_logitech_hidpp hid_logitech_dj joydev snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc snd_hda_intel videobuf2_memops videobuf2_v4l2
snd_intel_dspcfg mt76x2u soundwire_intel mt76x2_common
videobuf2_common mt76x02_usb soundwire_generic_allocation mt76_usb
intel_rapl_msr intel_rapl_common iwlmvm snd_soc_core snd_usb_audio
videodev snd_compress mt76x02_lib btusb snd_usbmidi_lib
snd_pcm_dmaengine mt76 soundwire_cadence btrtl snd_rawmidi btbcm
snd_hda_codec mc btintel edac_mce_amd mac80211 kvm_amd snd_hda_core
uas bluetooth ac97_bus
[32476.849687]  iwlwifi snd_hwdep usb_storage kvm snd_seq libarc4
snd_seq_device ecdh_generic cfg80211 ecc irqbypass snd_pcm rapl
eeepc_wmi asus_wmi sparse_keymap snd_timer rfkill snd video sp5100_tco
wmi_bmof i2c_piix4 k10temp soundcore acpi_cpufreq binfmt_misc
ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel cec drm igb
ghash_clmulni_intel nvme ccp dca nvme_core i2c_algo_bit wmi
pinctrl_amd fuse
[32476.849713] irq event stamp: 0
[32476.849715] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[32476.849719] hardirqs last disabled at (0): [<ffffffffa70ddccb>]
copy_process+0x8fb/0x1de0
[32476.849723] softirqs last  enabled at (0): [<ffffffffa70ddccb>]
copy_process+0x8fb/0x1de0
[32476.849726] softirqs last disabled at (0): [<0000000000000000>] 0x0
[32476.849728] CPU: 1 PID: 5472 Comm: Chrome_ChildIOT Tainted: G
D W    L   --------- ---  5.11.0-155.fc35.x86_64+debug #1
[32476.849732] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[32476.849734] RIP: 0010:native_queued_spin_lock_slowpath+0x1ce/0x200
[32476.849738] Code: c1 ef 12 83 e0 03 83 ef 01 48 c1 e0 05 48 63 ff
48 05 80 f1 1e 00 48 03 04 fd 00 39 6e a8 48 89 08 8b 41 08 85 c0 75
09 f3 90 <8b> 41 08 85 c0 74 f7 48 8b 39 48 85 ff 0f 84 56 ff ff ff 0f
0d 0f
[32476.849741] RSP: 0000:ffffb08fc6c4bc10 EFLAGS: 00000246
[32476.849744] RAX: 0000000000000000 RBX: ffffe16d96c11140 RCX: ffff9e53c6def180
[32476.849746] RDX: ffff9e4cc11a3d28 RSI: 0000000000080000 RDI: 0000000000000016
[32476.849749] RBP: ffff9e4cc11a3d28 R08: 0000000000080000 R09: 0000000000000000
[32476.849751] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9e4cc11a3d40
[32476.849753] R13: ffff9e4cc11a3d28 R14: ffff9e4cc11a3d20 R15: 0000000000f89940
[32476.849756] FS:  00007f9a02233640(0000) GS:ffff9e53c6c00000(0000)
knlGS:0000000000000000
[32476.849758] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32476.849761] CR2: 00002312fd44ecd8 CR3: 00000001618f6000 CR4: 0000000000350ee0
[32476.849763] Call Trace:
[32476.849766]  do_raw_spin_lock+0x94/0xa0
[32476.849769]  _raw_spin_lock+0x63/0x80
[32476.849772]  zswap_frontswap_load+0x2f/0x2f0
[32476.849775]  ? psi_group_change+0x27d/0x290
[32476.849779]  __frontswap_load+0xc3/0x160
[32476.849782]  swap_readpage+0x1ca/0x3a0
[32476.849786]  swapin_readahead+0x450/0x4e0
[32476.849789]  ? lock_release+0x1e9/0x400
[32476.849793]  do_swap_page+0x4a4/0x900
[32476.849796]  ? lock_release+0x1e9/0x400
[32476.849799]  ? trace_hardirqs_on+0x1b/0xe0
[32476.849802]  handle_mm_fault+0xe7d/0x19d0
[32476.849807]  do_user_addr_fault+0x1c7/0x4c0
[32476.849810]  exc_page_fault+0x67/0x2a0
[32476.849813]  ? asm_exc_page_fault+0x8/0x30
[32476.849816]  asm_exc_page_fault+0x1e/0x30
[32476.849819] RIP: 0033:0x555d3e644fe2
[32476.849822] Code: c3 cc cc cc cc cc cc cc 55 48 89 e5 41 57 41 56
53 48 83 ec 68 49 89 fe 4c 8b 3f 48 8b 05 76 4d bd 08 49 8b 1f 48 31
c3 74 67 <48> 33 43 08 49 39 c7 74 4e c7 45 b8 04 00 00 00 c7 45 c8 04
00 00
[32476.849824] RSP: 002b:00007f9a02231ab0 EFLAGS: 00010202
[32476.849827] RAX: fffffffd55160cdb RBX: 00002312fd44ecd0 RCX: 0000000000000005
[32476.850461] RDX: 0000000000000000 RSI: 0000000000000005 RDI: 00002312fcd3f2a0
[32476.850463] RBP: 00007f9a02231b30 R08: 00002312fcfa4003 R09: 00007ffd204a88d0
[32476.850465] R10: 0000000000000000 R11: 0000000000000246 R12: 0000555d3e492590
[32476.850467] R13: 0000555d3e4cd840 R14: 00002312fcd3f2a0 R15: 00002312fd2481e0
[32476.850644] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [brave:5451]
[32476.850652] Modules linked in: snd_seq_dummy snd_hrtimer tun uinput
nls_utf8 isofs rfcomm netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep zstd sunrpc xpad ff_memless vfat fat
hid_logitech_hidpp hid_logitech_dj joydev snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc snd_hda_intel videobuf2_memops videobuf2_v4l2
snd_intel_dspcfg mt76x2u soundwire_intel mt76x2_common
videobuf2_common mt76x02_usb soundwire_generic_allocation mt76_usb
intel_rapl_msr intel_rapl_common iwlmvm snd_soc_core snd_usb_audio
videodev snd_compress mt76x02_lib btusb snd_usbmidi_lib
snd_pcm_dmaengine mt76 soundwire_cadence btrtl snd_rawmidi btbcm
snd_hda_codec mc btintel edac_mce_amd mac80211 kvm_amd snd_hda_core
uas bluetooth ac97_bus
[32476.850687]  iwlwifi snd_hwdep usb_storage kvm snd_seq libarc4
snd_seq_device ecdh_generic cfg80211 ecc irqbypass snd_pcm rapl
eeepc_wmi asus_wmi sparse_keymap snd_timer rfkill snd video sp5100_tco
wmi_bmof i2c_piix4 k10temp soundcore acpi_cpufreq binfmt_misc
ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched
crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel cec drm igb
ghash_clmulni_intel nvme ccp dca nvme_core i2c_algo_bit wmi
pinctrl_amd fuse
[32476.850714] irq event stamp: 0
[32476.850716] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[32476.850719] hardirqs last disabled at (0): [<ffffffffa70ddccb>]
copy_process+0x8fb/0x1de0
[32476.850723] softirqs last  enabled at (0): [<ffffffffa70ddccb>]
copy_process+0x8fb/0x1de0
[32476.850726] softirqs last disabled at (0): [<0000000000000000>] 0x0


Full kernel log is here: https://pastebin.com/4SbhNp7V

-- 
Best Regards,
Mike Gavrilov.
