Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF03186A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhBKI54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBKI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:57:04 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72306C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:57:49 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b16so6407872lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mKDPrL0AUKPGLPXFHdlOjTjtixGk/bVL0QkeITSngUs=;
        b=GnrLo56Vro3KcYduJYHimLgSjRvySJ/9wDihbcEg6h+v3VYarM8jBFxTP8KhrSphnd
         gY2Ox1qLTTh00roSdzyXGDaMsFR8nhERr32gaCVuHHFBQtI32fFQDFYmtyQ6LEcJPzsv
         W3/U/RSKKDOAeu4lMIkKTRWCZpeayLKvu0nu3bTYEfEN7eOC4TPAylcZBkbfKx/BcQqE
         GAh0dEcPq4qS8wv6EvxhmKashUidzQ7iebpoD6uSLqOKDUPLjXjapbGcVRyPAXeXiPDN
         VSP7swKzDcjCjAj4sGh0s/5RRjBCdFWruAq0Ks7S+0lloNI4RdshS5SMsXwnhnkxApA2
         QlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mKDPrL0AUKPGLPXFHdlOjTjtixGk/bVL0QkeITSngUs=;
        b=S41ezdbQafxN2FWFiqk9qn9sxAoKE06TA2ZT9u4jXbGCOFqnCO8A6UDqVMwuaAb1R5
         wVA98ffoWZh2bQWnJXtQJVgxMnla/+79rgwkIaU6VpiANvqAGCOXPXWsT0EQdi5/tWxE
         Uj5hniqElo2dwp8V6vadw7H/T1JTE7Rzb84WxenkxltI7SzuXu+pPW64VVQXbkRKElzF
         7JshmWTxJjBuNdT6ybJQEuMtPQEuXJQTK4Pv4ZxvtKH2gCgPClgfBsbThB0/mvfD4ktO
         NJ5cNS+o1jUseaBrvYV7U9LRS0MwjfbLVR/wtL9B9TVYApme2DD3SsWFUAb4fiUPz20e
         rDRQ==
X-Gm-Message-State: AOAM532JUnvaU+paiTd9fvPMu52+qx3BKxfgWqFXmxcRYUROzqEyqSpg
        ujwWJ/n/5LLGfBGoyWjKhAPI6v1WWz17IrjjdsJNLFmPXt1fRg==
X-Google-Smtp-Source: ABdhPJzEvlvjZ/EwJB8pVQikOndeklIOpBfI5N5L5XsONE/0Wcd6S1xO/PBQ3ebomGNIc35mNdONW+5YnUVpeAK1yRE=
X-Received: by 2002:a2e:8e77:: with SMTP id t23mr4493660ljk.52.1613033867865;
 Thu, 11 Feb 2021 00:57:47 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 11 Feb 2021 13:57:36 +0500
Message-ID: <CABXGCsNEUpv9x93UeCa-wOjE0LgUdTCY2FTABJeFL=gGq4SX_g@mail.gmail.com>
Subject: kernel BUG at mm/zswap.c:1275! (rc6 - git 61556703b610)
To:     sjenning@linux.vnet.ibm.com, song.bao.hua@hisilicon.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.
During the 5.11 test cycle I caught a rare but repeatable problem when
after a day uptime happens "BUG at mm/zswap.c:1275!". I am still not
having an idea how to reproduce it, but maybe the authors of this code
could explain what happens here?

$ grep "mm/zswap.c" dmesg*.txt
dmesg101.txt:[127850.513201] kernel BUG at mm/zswap.c:1275!
dmesg11.txt:[52211.962861] kernel BUG at mm/zswap.c:1275!
dmesg8.txt:[46610.641843] kernel BUG at mm/zswap.c:1275!

[127850.513193] ------------[ cut here ]------------
[127850.513201] kernel BUG at mm/zswap.c:1275!
[127850.513210] invalid opcode: 0000 [#1] SMP NOPTI
[127850.513214] CPU: 6 PID: 485132 Comm: brave Tainted: G        W
   --------- ---  5.11.0-0.rc6.20210204git61556703b610.145.fc34.x86_64
#1
[127850.513218] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[127850.513221] RIP: 0010:zswap_frontswap_load+0x258/0x260
[127850.513228] Code: ab 83 aa f0 2f 00 00 01 65 ff 0d c3 73 cd 54 eb
88 48 8d 7b 10 e8 78 b9 9f 00 c7 43 10 00 00 00 00 44 8b 63 70 e9 4a
ff ff ff <0f> 0b 0f 0b 0f 0b 66 90 0f 1f 44 00 00 41 57 31 c0 b9 0c 00
00 00
[127850.513231] RSP: 0000:ffffa92e866c7c48 EFLAGS: 00010282
[127850.513235] RAX: 0000000000000006 RBX: ffffc92e7ca61830 RCX:
0000000000000001
[127850.513238] RDX: 0000000000000000 RSI: ffffffffab3429fe RDI:
ffff97f4d0393010
[127850.513240] RBP: ffff97ee5544d1c0 R08: 0000000000000001 R09:
0000000000000000
[127850.513242] R10: 0000000000000000 R11: 0000000000000000 R12:
00000000ffffffea
[127850.513244] R13: ffff97ee016800c8 R14: ffff97ee016800c0 R15:
ffffffffc0d54020
[127850.513247] FS:  00007fcbe628de40(0000) GS:ffff97f507600000(0000)
knlGS:0000000000000000
[127850.513249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[127850.513252] CR2: 0000381208c29250 CR3: 00000001c54ea000 CR4:
0000000000350ee0
[127850.513254] Call Trace:
[127850.513261]  __frontswap_load+0xc3/0x160
[127850.513265]  swap_readpage+0x1ca/0x3a0
[127850.513270]  swapin_readahead+0x2ee/0x4e0
[127850.513276]  do_swap_page+0x4a4/0x900
[127850.513279]  ? lock_release+0x1e9/0x400
[127850.513283]  ? trace_hardirqs_on+0x1b/0xe0
[127850.513288]  handle_mm_fault+0xe7d/0x19d0
[127850.513294]  do_user_addr_fault+0x1c7/0x4c0
[127850.513299]  exc_page_fault+0x67/0x2a0
[127850.513304]  ? asm_exc_page_fault+0x8/0x30
[127850.513307]  asm_exc_page_fault+0x1e/0x30
[127850.513310] RIP: 0033:0x560297642f44
[127850.513314] Code: 64 75 07 45 8b 76 03 4d 03 f5 45 8b 56 ff 4d 03
d5 66 41 81 7a 07 83 00 0f 85 4f 01 00 00 8b 5f 13 49 03 dd 8b 5b 03
49 03 dd <8b> 4b ff 49 03 cd 66 81 79 07 a5 00 0f 85 0f 00 00 00 8b 4b
0f f6
[127850.513317] RSP: 002b:00007ffc04cd4b30 EFLAGS: 00010202
[127850.513320] RAX: 0000000000000000 RBX: 0000381208c29251 RCX:
0000560297642f00
[127850.513322] RDX: 00003812080423b1 RSI: 0000381209b11231 RDI:
0000381209b1141d
[127850.513323] RBP: 00007ffc04cd4b90 R08: 0000000000000043 R09:
0000000000000024
[127850.513325] R10: 0000381208042a1d R11: 0000381209b1141f R12:
0000000009b1141d
[127850.513327] R13: 0000381200000000 R14: 0000381208b368ed R15:
00003d2fb6b7da10
[127850.513333] Modules linked in: tun snd_seq_dummy snd_hrtimer
uinput rfcomm nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set
nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter cmac
bnep zstd sunrpc vfat fat hid_logitech_hidpp hid_logitech_dj
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg soundwire_intel
soundwire_generic_allocation mt76x2u mt76x2_common snd_soc_core
mt76x02_usb snd_compress mt76_usb snd_pcm_dmaengine soundwire_cadence
intel_rapl_msr intel_rapl_common iwlmvm snd_hda_codec uvcvideo
mt76x02_lib snd_usb_audio videobuf2_vmalloc snd_hda_core mt76
videobuf2_memops videobuf2_v4l2 videobuf2_common
[127850.513395]  edac_mce_amd snd_usbmidi_lib ac97_bus snd_hwdep
videodev mac80211 btusb snd_seq kvm_amd snd_rawmidi btrtl btbcm mc
joydev btintel snd_seq_device kvm bluetooth snd_pcm iwlwifi eeepc_wmi
snd_timer asus_wmi xpad irqbypass sparse_keymap ecdh_generic snd
libarc4 ff_memless sp5100_tco rapl video ecc pcspkr wmi_bmof cfg80211
soundcore i2c_piix4 k10temp rfkill acpi_cpufreq binfmt_misc ip_tables
amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched crct10dif_pclmul
crc32_pclmul crc32c_intel drm_kms_helper igb cec nvme dca
ghash_clmulni_intel drm i2c_algo_bit ccp nvme_core wmi pinctrl_amd
fuse
[127850.513453] ---[ end trace 9d733ab8d8b8c1f2 ]---
[127850.513456] RIP: 0010:zswap_frontswap_load+0x258/0x260
[127850.513459] Code: ab 83 aa f0 2f 00 00 01 65 ff 0d c3 73 cd 54 eb
88 48 8d 7b 10 e8 78 b9 9f 00 c7 43 10 00 00 00 00 44 8b 63 70 e9 4a
ff ff ff <0f> 0b 0f 0b 0f 0b 66 90 0f 1f 44 00 00 41 57 31 c0 b9 0c 00
00 00
[127850.513462] RSP: 0000:ffffa92e866c7c48 EFLAGS: 00010282
[127850.513465] RAX: 0000000000000006 RBX: ffffc92e7ca61830 RCX:
0000000000000001
[127850.513467] RDX: 0000000000000000 RSI: ffffffffab3429fe RDI:
ffff97f4d0393010
[127850.513469] RBP: ffff97ee5544d1c0 R08: 0000000000000001 R09:
0000000000000000
[127850.513471] R10: 0000000000000000 R11: 0000000000000000 R12:
00000000ffffffea
[127850.513473] R13: ffff97ee016800c8 R14: ffff97ee016800c0 R15:
ffffffffc0d54020
[127850.513475] FS:  00007fcbe628de40(0000) GS:ffff97f507600000(0000)
knlGS:0000000000000000
[127850.513478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[127850.513480] CR2: 0000381208c29250 CR3: 00000001c54ea000 CR4:
0000000000350ee0

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux zswap_frontswap_load+0x258
zswap_frontswap_load+0x258/0x260:
zswap_frontswap_load at mm/zswap.c:1275 (discriminator 1)

$ git blame mm/zswap.c -L 1265,1285
Blaming lines:   1% (21/1470), done.
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1265)
 acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1266)
 mutex_lock(acomp_ctx->mutex);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1267)
 sg_init_one(&input, src, entry->length);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1268)
 sg_init_table(&output, 1);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1269)
 sg_set_page(&output, page, PAGE_SIZE, 0);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1270)
 acomp_request_set_params(acomp_ctx->req, &input, &output,
entry->length, dlen);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1271)
 ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),
&acomp_ctx->wait);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1272)
 mutex_unlock(acomp_ctx->mutex);
1ec3b5fe6eec7 (Barry Song         2020-12-14 19:14:18 -0800 1273)
f1c54846ee450 (Dan Streetman      2015-09-09 15:35:19 -0700 1274)
 zpool_unmap_handle(entry->pool->zpool, entry->handle);
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1275)
 BUG_ON(ret);
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1276)
a85f878b443f8 (Srividya Desireddy 2018-01-31 16:15:59 -0800 1277) freeentry:
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1278)
 spin_lock(&tree->lock);
0ab0abcf51154 (Weijie Yang        2013-11-12 15:08:27 -0800 1279)
 zswap_entry_put(tree, entry);
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1280)
 spin_unlock(&tree->lock);
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1281)
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1282)
 return 0;
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1283) }
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1284)
2b2811178e855 (Seth Jennings      2013-07-10 16:05:03 -0700 1285) /*
frees an entry in zswap */

Full kernel log is here: https://pastebin.com/Zqe0FYYD

-- 
Best Regards,
Mike Gavrilov.
