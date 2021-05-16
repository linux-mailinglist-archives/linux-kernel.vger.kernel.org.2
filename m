Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7155382175
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhEPW25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 18:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 18:28:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 15:27:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x19so5994313lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6zSUpq17Q3hbB6x/r2Ulw8iemEPHaGDtCsIcW3uroUE=;
        b=Wm78ZoNkEliGmJHKCk9/Z0m2F6fg054DwYP55UZuLsOXEnNusprvd2/LRL7MnbWVgW
         zDj2FTTO044F1KRT6o3MN0sVcCIDauCGOELiY48s/jtn+zxeboi8o/3YYRdnvh2YKot7
         +jDo7HmMi5lrUl1+cWShVdiLdQokxWcQ9IePie//9s6qJUu+lpXvU8CxDlD40C9GQqEc
         ztAOXFiGxD/PGDSS9qVyPRvrCJHCOvVrXKgpDo0bMuAKk9Qc+TKcZwf1VNRpCC9gIpZd
         8zaWHDlzIresuFjnzusDWnn3J6rItx4TVHOkeDTiFTclIZNANJ/SHUTamawLbgswzNwL
         eK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6zSUpq17Q3hbB6x/r2Ulw8iemEPHaGDtCsIcW3uroUE=;
        b=fyicui/bL68jC8GzdAMIu9rnFJXk4+pReYrqVfYkb4BeaTAonfExi0+oAmMbRlKjDk
         Rw10vwpzHKrAy6xA0cUQqRJakaHDesHutkxm6mNA2KnnWTbe5Y5uwqGJAJvUx4SeSeca
         iBENeeSacGgumMDMiM19aGMRjpwrrMP/FGdCSQdIW4NuQUF+Wnt+C5XJRGXWNL5f6ePP
         nxoufSR9IWy9G5RPww7WveEoiEXU3GivDCu5ug5blNmLRVZgFuujxf5JMowH8J8rjM87
         ujZfmm5q3oQOKQfnjIgAcksU2Rr82fRDKNDFwVGrOYXwwU+50lgb8nA8ENJuAlTejstm
         YdmQ==
X-Gm-Message-State: AOAM532/VP1fwBUjMu9OeLsZL/BA6p9xyeaxKskVtUDr+CV1i0hhdePV
        1Jn+1bi926nWqkuPCZAZcibz6V/M3cEe3wJJz1ohOYk0NepL0A==
X-Google-Smtp-Source: ABdhPJzmh1piZvRIwD/V/eFTLPhGwX67kISLuLlnRkdobvw/J0vBL8J/eNw8gkAHga4QEWwstWRiVe8vCF1pFIlE9ao=
X-Received: by 2002:a05:6512:1044:: with SMTP id c4mr13907666lfb.66.1621204054230;
 Sun, 16 May 2021 15:27:34 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 17 May 2021 03:27:23 +0500
Message-ID: <CABXGCsMA4grweMDnN7_4jepk0w8hBbynMFfHUJv-PrM9STyZUw@mail.gmail.com>
Subject: [5.13-rc1][bug] often hangs for no reason
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.
5.13-rc1 after 5.13-rc0 is a disaster because it hangs and hangs again
after reboot.
All hang's have in common is that they all happens in
smp_call_function_many_cond function (I compared all trace [1], [2],
[3], [4], [5])
I do not know if this is a known problem or not, so I'm reporting here.

$ /usr/src/kernels/5.13.0-0.rc1.20210513gitc06a2ba62fc4.15.fc35.x86_64/scripts/faddr2line
/lib/debug/lib/modules/5.13.0-0.rc1.20210513gitc06a2ba62fc4.15.fc35.x86_64/vmlinux
smp_call_function_many_cond+0x14d/0x3c0
smp_call_function_many_cond+0x14d/0x3c0:
csd_lock_wait at kernel/smp.c:440
(inlined by) smp_call_function_many_cond at kernel/smp.c:967

[64738.149826] watchdog: BUG: soft lockup - CPU#2 stuck for 26s!
[ThreadPoolForeg:368382]
[64738.150206] Modules linked in: tun xfs uinput snd_seq_dummy
snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
nft_compat nf_nat_tftp nf_conntrack_tftp nft_counter bridge stp llc
netconsole nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink
bnep zstd sunrpc vfat fat intel_rapl_msr intel_rapl_common
snd_hda_codec_realtek snd_hda_codec_generic edac_mce_amd mt76x2u
ledtrig_audio snd_hda_codec_hdmi mt76x2_common mt76x02_usb
snd_hda_intel mt76_usb snd_intel_dspcfg snd_intel_sdw_acpi mt76x02_lib
iwlmvm uvcvideo snd_hda_codec kvm_amd mt76 btusb videobuf2_vmalloc
videobuf2_memops snd_usb_audio btrtl snd_hda_core videobuf2_v4l2 btbcm
snd_usbmidi_lib mac80211 snd_hwdep kvm iwlwifi btintel
videobuf2_common ucsi_ccg snd_rawmidi eeepc_wmi snd_seq videodev
joydev snd_seq_device
[64738.150248]  asus_wmi irqbypass typec_ucsi xpad sparse_keymap
bluetooth libarc4 ff_memless rapl wmi_bmof video pcspkr mc typec
k10temp snd_pcm cfg80211 i2c_piix4 ecdh_generic ecc snd_timer snd
soundcore rfkill acpi_cpufreq binfmt_misc ip_tables hid_logitech_hidpp
hid_logitech_dj uas igb usb_storage dca amdgpu drm_ttm_helper ttm
iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit crc32_pclmul
crc32c_intel drm_kms_helper cec nvme ghash_clmulni_intel drm ccp
sp5100_tco nvme_core wmi fuse
[64738.150278] irq event stamp: 0
[64738.150280] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[64738.150285] hardirqs last disabled at (0): [<ffffffffb50de7b9>]
copy_process+0x769/0x1e40
[64738.150290] softirqs last  enabled at (0): [<ffffffffb50de7b9>]
copy_process+0x769/0x1e40
[64738.150293] softirqs last disabled at (0): [<0000000000000000>] 0x0
[64738.150295] CPU: 2 PID: 368382 Comm: ThreadPoolForeg Tainted: G
   W        --------- ---
5.13.0-0.rc1.20210512git88b06399c9c7.15.fc35.x86_64 #1
[64738.150299] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3801 04/07/2021
[64738.150302] RIP: 0010:smp_call_function_many_cond+0x14d/0x3c0
[64738.150306] Code: 8b 75 08 e8 75 d2 59 00 3b 05 c3 f1 0b 02 89 c7
73 22 48 63 c7 48 8b 4d 00 48 03 0c c5 20 c9 6f b6 8b 41 08 a8 01 74
0a f3 90 <8b> 51 08 83 e2 01 75 f6 eb cb 48 83 c4 38 5b 5d 41 5c 41 5d
41 5e
[64738.150309] RSP: 0018:ffffad1f5d1e3cb8 EFLAGS: 00000202
[64738.150312] RAX: 0000000000000011 RBX: 0000000000000001 RCX: ffff8cef29bf6fc0
[64738.150314] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000018
[64738.150316] RBP: ffff8cef26fefe00 R08: 0000000000000000 R09: 0000000000000000
[64738.150318] R10: 0000000000000018 R11: 0000000000000000 R12: 0000000000000000
[64738.150320] R13: ffff8cef26fee0c0 R14: 0000000000000002 R15: ffff8cef26fefe00
[64738.150322] FS:  00007f290331e640(0000) GS:ffff8cef26e00000(0000)
knlGS:0000000000000000
[64738.150325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[64738.150327] CR2: 00001aa50ae35000 CR3: 000000020de8e000 CR4: 0000000000350ee0
[64738.150329] Call Trace:
[64738.150333]  ? switch_mm+0x70/0x70
[64738.150338]  on_each_cpu_cond_mask+0x20/0x30
[64738.150341]  flush_tlb_mm_range+0xec/0x150
[64738.150345]  tlb_finish_mmu+0x113/0x1a0
[64738.150348]  zap_page_range+0x145/0x1a0
[64738.150354]  do_madvise.part.0+0x982/0xf50
[64738.150360]  ? __x64_sys_futex+0x63/0x1a0
[64738.150362]  ? switch_fpu_return+0xf7/0x150
[64738.150366]  ? __x64_sys_madvise+0x56/0x70
[64738.150369]  __x64_sys_madvise+0x56/0x70
[64738.150372]  do_syscall_64+0x40/0x80
[64738.150377]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[64738.150381] RIP: 0033:0x7f2936a0b25b
[64738.150384] Code: c3 66 0f 1f 44 00 00 48 8b 15 11 7c 0c 00 f7 d8
64 89 02 b8 ff ff ff ff eb bc 0f 1f 44 00 00 f3 0f 1e fa b8 1c 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 7b 0c 00 f7 d8 64 89
01 48
[64738.150386] RSP: 002b:00007f290331cea8 EFLAGS: 00000216 ORIG_RAX:
000000000000001c
[64738.150389] RAX: ffffffffffffffda RBX: 0000109c276d8000 RCX: 00007f2936a0b25b
[64738.150391] RDX: 0000000000000004 RSI: 0000000000010000 RDI: 0000109c276d8000
[64738.150393] RBP: 00007f290331ced0 R08: 0000109c27118f00 R09: 000000000000002e
[64738.150395] R10: 0000000000000000 R11: 0000000000000216 R12: 000055f5c00ea6d0
[64738.150397] R13: 0000109c276016c0 R14: 0000000000010000 R15: 0000000000000001


Full logs here:
[1] https://pastebin.com/u7SkKGDT
[2] https://pastebin.com/fNae4dSL
[3] https://pastebin.com/jEDMjQDy
[4] https://pastebin.com/vEMhWGgE
[5] https://pastebin.com/fvWx5ctR

-- 
Best Regards,
Mike Gavrilov.
