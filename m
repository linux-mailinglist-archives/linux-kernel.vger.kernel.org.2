Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108D3356812
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350125AbhDGJbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhDGJbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:31:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77AAC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:31:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u10so19858330lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+1lQQRHMQmQK3JPiwjjGqfTiWnnXp5QCuqUSJOuvsAs=;
        b=RQE5xHsdSF/IBV9UgeYo4ucuSIMcXfRRO+mnhPh61x+TyTwFZj4K4vYuTTuiFEdz4q
         x4jvPIJ3Kh0oX4vz1yREJDqVxh7Xac0+hp9dvEYr7o1YrN8+AzgKImx9p/Lbb3gmcFZc
         Iyu2tSG2MLQP7kia9xD3heLkA7cVUEZV+p2Pl1LsLQ86UESi3S7SEErJwKjgz4/pMj9s
         wF7gVOlBHjoeC2e2yO9eNifEYk28CSDbT3V2eDyTr/K9J8SVcaY1s2O8iPQMH5W79WOv
         qKFTM+ay/0az6tp7NKuFWAL8p6J8xUoWzscZY7QTasEXFniCvkStF7cTciz7gbmBmncL
         TG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+1lQQRHMQmQK3JPiwjjGqfTiWnnXp5QCuqUSJOuvsAs=;
        b=SHjJXEA0kc91b0yzEXM4z59wa/Oa4eoNzkcxFogTsTBJ3M0nmjLz7n6ABAakgsoz0b
         GemFvMrJY9OEfIPtY1NMXyQIt6shymZPNEOt30OWnatrMJ7FnqZuH9w4Xgu1GIvKyVso
         CooLDa4/hP5ejTevXClwoeeJ04q3VAYIBDHYbMVH7zB+dE317OUfi6MaEVhiznLgO6Ug
         io/6DIdo2VDj3SSJKcNNN03UhDZer70nimIiYNcEGFDuQleaOL+z/veaDUBzRFUEypd1
         FUjghIamYDfIq6RKK3IppsJ1MGufGXCerF0sUu/zLio05x3LexTugWX51AT0iQ7L5kO+
         QFtw==
X-Gm-Message-State: AOAM533P7a1KhViiyi5OV3cYf6IsO1Nx0IARK2TwKXgeqfRJ93JaxO8N
        sTXCm34TNnVbm+iiFej2Rxlx9kbedOrq8TCPjc4=
X-Google-Smtp-Source: ABdhPJyolWukA42wvqCqIKbaEMUd/wY1sRqyYkWN+Vsaxn2NvKohmgi7GfTPi56rlq7lPaQFCKFFGkmjvLkcidVlo8I=
X-Received: by 2002:a2e:b0d3:: with SMTP id g19mr16311ljl.223.1617787862414;
 Wed, 07 Apr 2021 02:31:02 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 7 Apr 2021 14:30:49 +0500
Message-ID: <CABXGCsPAdv6wCWmzh6OQmDX1LOf_FEu_wH=4K9HDd_rToTdwrQ@mail.gmail.com>
Subject: Unexpected multihop in swaput - likely driver bug.
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
During the 5.12 testing cycle I observed the repeatable bug when
launching heavy graphic applications.
The kernel log is flooded with the message "Unexpected multihop in
swaput - likely driver bug.".

Trace:
[ 8707.814899] ------------[ cut here ]------------
[ 8707.814920] Unexpected multihop in swaput - likely driver bug.
[ 8707.814998] WARNING: CPU: 19 PID: 28231 at
drivers/gpu/drm/ttm/ttm_bo.c:1484 ttm_bo_swapout+0x40b/0x420 [ttm]
[ 8707.815011] Modules linked in: tun uinput snd_seq_dummy rfcomm
snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
hid_logitech_dj intel_rapl_msr snd_hda_codec_realtek intel_rapl_common
mt76x2u snd_hda_codec_generic mt76x2_common mt76x02_usb iwlmvm
ledtrig_audio snd_hda_codec_hdmi mt76_usb mt76x02_lib snd_hda_intel
mt76 snd_intel_dspcfg snd_intel_sdw_acpi mac80211 joydev snd_usb_audio
snd_hda_codec uvcvideo edac_mce_amd videobuf2_vmalloc snd_hda_core
snd_usbmidi_lib videobuf2_memops snd_hwdep iwlwifi snd_rawmidi btusb
videobuf2_v4l2 kvm_amd snd_seq videobuf2_common btrtl btbcm videodev
btintel snd_seq_device kvm mc cfg80211 bluetooth snd_pcm libarc4
eeepc_wmi snd_timer asus_wmi irqbypass xpad sp5100_tco
[ 8707.815065]  sparse_keymap ecdh_generic ff_memless video ecc
wmi_bmof i2c_piix4 snd rapl k10temp soundcore rfkill acpi_cpufreq
ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper
crct10dif_pclmul crc32_pclmul crc32c_intel cec drm ghash_clmulni_intel
igb ccp nvme dca nvme_core i2c_algo_bit wmi pinctrl_amd fuse
[ 8707.815096] CPU: 19 PID: 28231 Comm: kworker/u64:1 Tainted: G
 W        --------- ---  5.12.0-0.rc6.184.fc35.x86_64+debug #1
[ 8707.815101] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3603 03/20/2021
[ 8707.815106] Workqueue: ttm_swap ttm_shrink_work [ttm]
[ 8707.815114] RIP: 0010:ttm_bo_swapout+0x40b/0x420 [ttm]
[ 8707.815122] Code: 10 00 00 48 c1 e2 0c 48 c1 e6 0c e8 3f 37 fa c8
e9 71 fe ff ff 83 f8 b8 0f 85 a9 fe ff ff 48 c7 c7 28 32 37 c0 e8 02
2b 98 c9 <0f> 0b e9 96 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
00 0f
[ 8707.815126] RSP: 0018:ffffa306d20e7d58 EFLAGS: 00010292
[ 8707.815130] RAX: 0000000000000032 RBX: ffffffffc0379260 RCX: 00000000000=
00027
[ 8707.815133] RDX: ffff918c091daae8 RSI: 0000000000000001 RDI: ffff918c091=
daae0
[ 8707.815136] RBP: ffff918602210058 R08: 0000000000000000 R09: 00000000000=
00000
[ 8707.815138] R10: ffffa306d20e7b90 R11: ffff918c2e2fffe8 R12: 00000000fff=
fffb8
[ 8707.815141] R13: ffffffffc03792a0 R14: ffff9186022102c0 R15: 00000000000=
00001
[ 8707.815145] FS:  0000000000000000(0000) GS:ffff918c09000000(0000)
knlGS:0000000000000000
[ 8707.815148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8707.815151] CR2: 0000325c84d12000 CR3: 0000000776c28000 CR4: 00000000003=
50ee0
[ 8707.815154] Call Trace:
[ 8707.815164]  ttm_shrink+0xa6/0xe0 [ttm]
[ 8707.815171]  ttm_shrink_work+0x36/0x40 [ttm]
[ 8707.815177]  process_one_work+0x2b0/0x5e0
[ 8707.815185]  worker_thread+0x55/0x3c0
[ 8707.815188]  ? process_one_work+0x5e0/0x5e0
[ 8707.815192]  kthread+0x13a/0x150
[ 8707.815196]  ? __kthread_bind_mask+0x60/0x60
[ 8707.815199]  ret_from_fork+0x22/0x30
[ 8707.815207] irq event stamp: 0
[ 8707.815209] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 8707.815213] hardirqs last disabled at (0): [<ffffffff890ddafb>]
copy_process+0x91b/0x1e10
[ 8707.815218] softirqs last  enabled at (0): [<ffffffff890ddafb>]
copy_process+0x91b/0x1e10
[ 8707.815222] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 8707.815224] ---[ end trace 29252aa87289bbaa ]---

Full kernel log: https://pastebin.com/mmAxwBYc

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname
-r`/kernel/drivers/gpu/drm/ttm/ttm.ko.debug ttm_bo_swapout+0x40b
ttm_bo_swapout+0x40b/0x420:
ttm_bo_swapout at
/usr/src/debug/kernel-5.12-rc6/linux-5.12.0-0.rc6.184.fc35.x86_64/drivers/g=
pu/drm/ttm/ttm_bo.c:1484
(discriminator 1)


$ git blame drivers/gpu/drm/ttm/ttm_bo.c -L 1475,1494
Blaming lines:   1% (20/1530), done.
ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1475)
         memset(&hop, 0, sizeof(hop));
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1476)
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1477)
         evict_mem =3D bo->mem;
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1478)
         evict_mem.mm_node =3D NULL;
ce65b874001d7 (Christian K=C3=B6nig  2020-09-30 16:44:16 +0200 1479)
         evict_mem.placement =3D 0;
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1480)
         evict_mem.mem_type =3D TTM_PL_SYSTEM;
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1481)
ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1482)
         ret =3D ttm_bo_handle_move_mem(bo, &evict_mem, true, &ctx,
&hop);
ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1483)
         if (unlikely(ret !=3D 0)) {
ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1484)
                 WARN(ret =3D=3D -EMULTIHOP, "Unexpected multihop in
swaput - likely driver bug.\n");
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1485)
                 goto out;
ebdf565169af0 (Dave Airlie      2020-10-29 13:58:52 +1000 1486)
         }
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1487)         }
ba4e7d973dd09 (Thomas Hellstrom 2009-06-10 15:20:19 +0200 1488)
61ede07055539 (Christian K=C3=B6nig  2016-06-06 10:17:57 +0200 1489)       =
  /**
61ede07055539 (Christian K=C3=B6nig  2016-06-06 10:17:57 +0200 1490)
  * Make sure BO is idle.
61ede07055539 (Christian K=C3=B6nig  2016-06-06 10:17:57 +0200 1491)       =
   */
61ede07055539 (Christian K=C3=B6nig  2016-06-06 10:17:57 +0200 1492)
61ede07055539 (Christian K=C3=B6nig  2016-06-06 10:17:57 +0200 1493)
 ret =3D ttm_bo_wait(bo, false, false);
61ede07055539 (Christian K=C3=B6nig  2016-06-06 10:17:57 +0200 1494)
 if (unlikely(ret !=3D 0))




--=20
Best Regards,
Mike Gavrilov.
