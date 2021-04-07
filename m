Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F2356A43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351539AbhDGKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbhDGKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:47:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C9AC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:46:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so26851261ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ceeRfrhwPXQl8T9obtJijCgO+6zu91eCrXj3KHXyyyE=;
        b=Ubvl0+dxRREJ2wQv8MF/TBvsQOIiIXoDmmPJvfv9+dYMb6TfGsFbUhn4KO8NrQSRTZ
         U7P+ihGFECTlVxcFy/EZEhMUNZjOmrO1zlB43DXpfBaWJnkaoL2c4FSP8KOmCuT2WMih
         zYl3myZxQ3H3B8KIqXtg/fdlGqkyc1Vyc/3CzEyFWddlnpNQ04Aj1fOh8pAJR8iQ4nHO
         z8wz1spKBy0KHgXEO+ibTvD6mFYZ8A0mT7TmWZvDT2v0QT9hv9vU6RSvm3FPKs0k/P15
         B9hXq8Rcz4iHMatAh4sBwqoYv3PN6MBkEAbH98Lvy4l4Acq5/83ZNqq8wYtfX73DvnBL
         /X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ceeRfrhwPXQl8T9obtJijCgO+6zu91eCrXj3KHXyyyE=;
        b=qvCieJLqOZjrxgGeuX6CZS5tQYTzhTkIfV8fUP0xyuIQn2t6MRkVNvj7gPgMnDX5AA
         Yku5gmqsuY0TDY87llKZW8z0I3o909lnt7kbudlqNnDbKK9AmGEDpJEekam+XNIzzLBt
         Q418p+ntIdOfMO2ooYaSm56Xb6ZacESNfbK043c2eonrXokw9WXyICxXVsktqqaZ1Ipt
         CbVcC0MxPEkLuZ87xzxpUAIKxzd9mhkZG7GM61Nrd0ZNKHw/a4N8e86v2X6LvlBwfN33
         GuOBKSz1Q0zLIzjZKINYwE7wYyi5qSokV1czwiVhwWTSZbnEQJsQe1WKWhAYwCR3SmUw
         KFSw==
X-Gm-Message-State: AOAM5306o00/L0qWW+86USetP4Hig3Viset6hCXaV5tXn5MVTSRpjTa9
        XcqUSUJgBxVEQEigwhy6Glg=
X-Google-Smtp-Source: ABdhPJySz3Xilo7Nd7rOTemeViYu5zcsG4KFfTnRbQKRc2IUP448rTicLQi/yi1DgLuMiZehaxqudg==
X-Received: by 2002:a17:907:9614:: with SMTP id gb20mr2942082ejc.108.1617792408159;
        Wed, 07 Apr 2021 03:46:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0? ([2a02:908:1252:fb60:c8cb:bea6:b85a:47d0])
        by smtp.gmail.com with ESMTPSA id z4sm2611739edb.97.2021.04.07.03.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 03:46:47 -0700 (PDT)
Subject: Re: Unexpected multihop in swaput - likely driver bug.
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7d30982e-a893-858c-2237-a09a183ff2d0@gmail.com>
Date:   Wed, 7 Apr 2021 12:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What hardware are you using and how do you exactly trigger this?

Thanks,
Christian.

Am 07.04.21 um 11:30 schrieb Mikhail Gavrilov:
> Hi!
> During the 5.12 testing cycle I observed the repeatable bug when
> launching heavy graphic applications.
> The kernel log is flooded with the message "Unexpected multihop in
> swaput - likely driver bug.".
>
> Trace:
> [ 8707.814899] ------------[ cut here ]------------
> [ 8707.814920] Unexpected multihop in swaput - likely driver bug.
> [ 8707.814998] WARNING: CPU: 19 PID: 28231 at
> drivers/gpu/drm/ttm/ttm_bo.c:1484 ttm_bo_swapout+0x40b/0x420 [ttm]
> [ 8707.815011] Modules linked in: tun uinput snd_seq_dummy rfcomm
> snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
> hid_logitech_dj intel_rapl_msr snd_hda_codec_realtek intel_rapl_common
> mt76x2u snd_hda_codec_generic mt76x2_common mt76x02_usb iwlmvm
> ledtrig_audio snd_hda_codec_hdmi mt76_usb mt76x02_lib snd_hda_intel
> mt76 snd_intel_dspcfg snd_intel_sdw_acpi mac80211 joydev snd_usb_audio
> snd_hda_codec uvcvideo edac_mce_amd videobuf2_vmalloc snd_hda_core
> snd_usbmidi_lib videobuf2_memops snd_hwdep iwlwifi snd_rawmidi btusb
> videobuf2_v4l2 kvm_amd snd_seq videobuf2_common btrtl btbcm videodev
> btintel snd_seq_device kvm mc cfg80211 bluetooth snd_pcm libarc4
> eeepc_wmi snd_timer asus_wmi irqbypass xpad sp5100_tco
> [ 8707.815065]  sparse_keymap ecdh_generic ff_memless video ecc
> wmi_bmof i2c_piix4 snd rapl k10temp soundcore rfkill acpi_cpufreq
> ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper
> crct10dif_pclmul crc32_pclmul crc32c_intel cec drm ghash_clmulni_intel
> igb ccp nvme dca nvme_core i2c_algo_bit wmi pinctrl_amd fuse
> [ 8707.815096] CPU: 19 PID: 28231 Comm: kworker/u64:1 Tainted: G
>   W        --------- ---  5.12.0-0.rc6.184.fc35.x86_64+debug #1
> [ 8707.815101] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 3603 03/20/2021
> [ 8707.815106] Workqueue: ttm_swap ttm_shrink_work [ttm]
> [ 8707.815114] RIP: 0010:ttm_bo_swapout+0x40b/0x420 [ttm]
> [ 8707.815122] Code: 10 00 00 48 c1 e2 0c 48 c1 e6 0c e8 3f 37 fa c8
> e9 71 fe ff ff 83 f8 b8 0f 85 a9 fe ff ff 48 c7 c7 28 32 37 c0 e8 02
> 2b 98 c9 <0f> 0b e9 96 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 00 0f
> [ 8707.815126] RSP: 0018:ffffa306d20e7d58 EFLAGS: 00010292
> [ 8707.815130] RAX: 0000000000000032 RBX: ffffffffc0379260 RCX: 0000000000000027
> [ 8707.815133] RDX: ffff918c091daae8 RSI: 0000000000000001 RDI: ffff918c091daae0
> [ 8707.815136] RBP: ffff918602210058 R08: 0000000000000000 R09: 0000000000000000
> [ 8707.815138] R10: ffffa306d20e7b90 R11: ffff918c2e2fffe8 R12: 00000000ffffffb8
> [ 8707.815141] R13: ffffffffc03792a0 R14: ffff9186022102c0 R15: 0000000000000001
> [ 8707.815145] FS:  0000000000000000(0000) GS:ffff918c09000000(0000)
> knlGS:0000000000000000
> [ 8707.815148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8707.815151] CR2: 0000325c84d12000 CR3: 0000000776c28000 CR4: 0000000000350ee0
> [ 8707.815154] Call Trace:
> [ 8707.815164]  ttm_shrink+0xa6/0xe0 [ttm]
> [ 8707.815171]  ttm_shrink_work+0x36/0x40 [ttm]
> [ 8707.815177]  process_one_work+0x2b0/0x5e0
> [ 8707.815185]  worker_thread+0x55/0x3c0
> [ 8707.815188]  ? process_one_work+0x5e0/0x5e0
> [ 8707.815192]  kthread+0x13a/0x150
> [ 8707.815196]  ? __kthread_bind_mask+0x60/0x60
> [ 8707.815199]  ret_from_fork+0x22/0x30
> [ 8707.815207] irq event stamp: 0
> [ 8707.815209] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 8707.815213] hardirqs last disabled at (0): [<ffffffff890ddafb>]
> copy_process+0x91b/0x1e10
> [ 8707.815218] softirqs last  enabled at (0): [<ffffffff890ddafb>]
> copy_process+0x91b/0x1e10
> [ 8707.815222] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 8707.815224] ---[ end trace 29252aa87289bbaa ]---
>
> Full kernel log: https://pastebin.com/mmAxwBYc
>
> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname
> -r`/kernel/drivers/gpu/drm/ttm/ttm.ko.debug ttm_bo_swapout+0x40b
> ttm_bo_swapout+0x40b/0x420:
> ttm_bo_swapout at
> /usr/src/debug/kernel-5.12-rc6/linux-5.12.0-0.rc6.184.fc35.x86_64/drivers/gpu/drm/ttm/ttm_bo.c:1484
> (discriminator 1)
>
>
> $ git blame drivers/gpu/drm/ttm/ttm_bo.c -L 1475,1494
> Blaming lines:   1% (20/1530), done.
> ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1475)
>           memset(&hop, 0, sizeof(hop));
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1476)
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1477)
>           evict_mem = bo->mem;
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1478)
>           evict_mem.mm_node = NULL;
> ce65b874001d7 (Christian König  2020-09-30 16:44:16 +0200 1479)
>           evict_mem.placement = 0;
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1480)
>           evict_mem.mem_type = TTM_PL_SYSTEM;
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1481)
> ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1482)
>           ret = ttm_bo_handle_move_mem(bo, &evict_mem, true, &ctx,
> &hop);
> ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1483)
>           if (unlikely(ret != 0)) {
> ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1484)
>                   WARN(ret == -EMULTIHOP, "Unexpected multihop in
> swaput - likely driver bug.\n");
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1485)
>                   goto out;
> ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1486)
>           }
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1487)         }
> ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1488)
> 61ede07055539 (Christian König  2016-06-06 10:17:57 +0200 1489)         /**
> 61ede07055539 (Christian König  2016-06-06 10:17:57 +0200 1490)
>    * Make sure BO is idle.
> 61ede07055539 (Christian König  2016-06-06 10:17:57 +0200 1491)          */
> 61ede07055539 (Christian König  2016-06-06 10:17:57 +0200 1492)
> 61ede07055539 (Christian König  2016-06-06 10:17:57 +0200 1493)
>   ret = ttm_bo_wait(bo, false, false);
> 61ede07055539 (Christian König  2016-06-06 10:17:57 +0200 1494)
>   if (unlikely(ret != 0))
>
>
>
>

