Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F5445FD73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 09:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbhK0Iqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 03:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbhK0Iom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 03:44:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B4C061574;
        Sat, 27 Nov 2021 00:41:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so48520611edc.6;
        Sat, 27 Nov 2021 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=ZjTLLS0tgzf2tcO0mnLgM6Iz7XSh8abj1waqwGXjY9U=;
        b=aUY41r2gz5ONoL+S/qyGC9c8k2GDkMfxq9y8BagYIGPz+3auysbt1EiCOJLZB3X9re
         /YCcOxsLH59s0xcSrYnGgEXc9JC4k2CPTcD8QEbSeNtDYM24qIMfnwXXDy8CAL/FOO4/
         FNKqAZrZtdck8nYiIJcpq/g6dWmKYmvNBtI58RyU2NypDBeD8ZGoyv3jJe59xCx1T8gb
         yyywjqpXysVTdw1H/MaQwOc97LQt6yuU/vFNIc3BCjaM2TgwzTki1glJrPaN3SncsYha
         LLVfWurU0xHpdYa8qDW8iAxXKvhChPgM6YQGRrtzNz8siuT1NvEQCwq57/cxAFKd/c5u
         rs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=ZjTLLS0tgzf2tcO0mnLgM6Iz7XSh8abj1waqwGXjY9U=;
        b=FP4JQ0dLZ73986rmJlVbX1/+bm0QIhfc6Y95XS7RZzNpnQkUZXXj4sf7RjODurPHPk
         8YL7HLv097JAZpK+p1aHlkTR8fEGFXM0SujfcUzzGxFs1cmpE5p0wR2T1/+MG3RskTht
         3pNQJ/6/CfOTWbrc7xR6ApvJexvultd4O2agIKpq8DgqAZt43doWgm+xnqaDWfNZIHVP
         fOOamotjuhn57iqE2kIIGGhjqc5fSqlKdSOR4TUMHloyvzUd+hmm/+0XimGzN8JzT2cq
         ELLJ76MC7VY6C6JiW7Ctsxw8Yl/iJ374JnmJ6selEw29MR1V8fJK0pmAqoIYAnT2lVEF
         FwXw==
X-Gm-Message-State: AOAM533d/dhm6rSoO2fKHBrgHTDFCx4Le+mnJRwiXpjn335LfDWcsjuA
        Texc8AWnvKG57M6O6FXJa0Q=
X-Google-Smtp-Source: ABdhPJy01qWfUK2DwqZutpppfbH588QuZsnkqxmlappjmQPryxkgFiPIeG5OAtPbop23euhYsHkbSg==
X-Received: by 2002:a50:955c:: with SMTP id v28mr52935809eda.293.1638002486487;
        Sat, 27 Nov 2021 00:41:26 -0800 (PST)
Received: from [192.168.123.240] (static.235.156.203.116.clients.your-server.de. [116.203.156.235])
        by smtp.gmail.com with ESMTPSA id t3sm5096790edr.63.2021.11.27.00.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 00:41:26 -0800 (PST)
Message-ID: <6d82e674-76dc-f3b0-2e53-a92eeb249eff@gmail.com>
Date:   Sat, 27 Nov 2021 16:41:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH 2/3] mm: page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-3-pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, corbet@lwn.net,
        will@kernel.org, rppt@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, masahiroy@kernel.org,
        samitolvanen@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, frederic@kernel.org, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com
From:   Fusion Future <qydwhotmail@gmail.com>
In-Reply-To: <20211123214814.3756047-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems after updating to linux-next-20211125, my system is crashing 
frequently due to "kernel BUG at mm/page_table_check.c:101".

linux-next-20211124 does not have the issue.

A bug was also reported on
https://bugzilla.opensuse.org/show_bug.cgi?id=1193125

journactl output before sysrq reboot:

```
11月 27 15:13:10 ZHAN66 kernel: ------------[ cut here ]------------
11月 27 15:13:10 ZHAN66 kernel: kernel BUG at mm/page_table_check.c:101!
11月 27 15:13:10 ZHAN66 kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
11月 27 15:13:10 ZHAN66 kernel: CPU: 0 PID: 75 Comm: kcompactd0 Not 
tainted 5.16.0-rc2-next-20211125-1.ga5a7188-vanilla #1 
3000d4f4dc38a6eb529f948e10865da4957e57dc
11月 27 15:13:10 ZHAN66 kernel: Hardware name: HP HP ZHAN 66 Pro A 14 
G3/876B, BIOS S81 Ver. 01.03.01 10/23/2020
11月 27 15:13:10 ZHAN66 kernel: RIP: 
0010:page_table_check_clear.part.0+0xbb/0xd0
11月 27 15:13:10 ZHAN66 kernel: Code: d8 0f 0b f7 c3 ff 0f 00 00 75 97 48 
8b 13 f7 c2 00 00 01 00 74 8c 48 8b 53 48 4c 8d 62 ff 83 e2 01 4c 0f 44 
e3 e9 78 ff ff ff <0f> 0b 0f 0b 0f 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 
00 00 00 00 0f
11月 27 15:13:10 ZHAN66 kernel: RSP: 0018:ffffb784403e7a80 EFLAGS: 00010202
11月 27 15:13:10 ZHAN66 kernel: RAX: ffff987f419362e0 RBX: 
fffff1cf842d8b80 RCX: 0000000000000000
11月 27 15:13:10 ZHAN66 kernel: RDX: ffff987f419362e8 RSI: 
0000000000000001 RDI: 0000000000000001
11月 27 15:13:10 ZHAN66 kernel: RBP: 0000000000000001 R08: 
00000000ffffffff R09: 0000000000000825
11月 27 15:13:10 ZHAN66 kernel: R10: 0000000000000067 R11: 
000000000003a878 R12: fffff1cf842d8b80
11月 27 15:13:10 ZHAN66 kernel: R13: ffff987f468e9100 R14: 
ffff98801df1e960 R15: 03ffffffffffffff
11月 27 15:13:10 ZHAN66 kernel: FS:  0000000000000000(0000) 
GS:ffff98823f400000(0000) knlGS:0000000000000000
11月 27 15:13:10 ZHAN66 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
11月 27 15:13:10 ZHAN66 kernel: CR2: 00007f9b8591bd20 CR3: 
0000000161d0c000 CR4: 0000000000350ef0
11月 27 15:13:10 ZHAN66 kernel: Call Trace:
11月 27 15:13:10 ZHAN66 kernel:  <TASK>
11月 27 15:13:10 ZHAN66 kernel:  ptep_clear_flush+0x7e/0x80
11月 27 15:13:10 ZHAN66 kernel:  try_to_migrate_one+0x1b5/0x9e0
11月 27 15:13:10 ZHAN66 kernel:  ? __mod_memcg_lruvec_state+0x41/0x80
11月 27 15:13:10 ZHAN66 kernel:  rmap_walk_anon+0x121/0x270
11月 27 15:13:10 ZHAN66 kernel:  try_to_migrate+0x129/0x1c0
11月 27 15:13:10 ZHAN66 kernel:  ? try_to_unmap_one+0x1010/0x1010
11月 27 15:13:10 ZHAN66 kernel:  ? anon_vma_ctor+0x40/0x40
11月 27 15:13:10 ZHAN66 kernel:  ? page_get_anon_vma+0xc0/0xc0
11月 27 15:13:10 ZHAN66 kernel:  ? invalid_mkclean_vma+0x20/0x20
11月 27 15:13:10 ZHAN66 kernel:  migrate_pages+0x10f3/0x16e0
11月 27 15:13:10 ZHAN66 kernel:  ? isolate_freepages_block+0x460/0x460
11月 27 15:13:10 ZHAN66 kernel:  ? move_freelist_tail+0xc0/0xc0
11月 27 15:13:10 ZHAN66 kernel:  ? migrate_page+0xe0/0xe0
11月 27 15:13:10 ZHAN66 kernel:  compact_zone+0x5ec/0xe70
11月 27 15:13:10 ZHAN66 kernel:  ? finish_task_switch.isra.0+0xb4/0x2c0
11月 27 15:13:10 ZHAN66 kernel:  proactive_compact_node+0x88/0xc0
11月 27 15:13:10 ZHAN66 kernel:  kcompactd+0x1c4/0x410
11月 27 15:13:10 ZHAN66 kernel:  ? wait_woken+0x70/0x70
11月 27 15:13:10 ZHAN66 kernel:  ? kcompactd_do_work+0x290/0x290
11月 27 15:13:10 ZHAN66 kernel:  kthread+0x15a/0x180
11月 27 15:13:10 ZHAN66 kernel:  ? set_kthread_struct+0x40/0x40
11月 27 15:13:10 ZHAN66 kernel:  ret_from_fork+0x1f/0x30
11月 27 15:13:10 ZHAN66 kernel:  </TASK>
11月 27 15:13:10 ZHAN66 kernel: Modules linked in: uinput rfcomm 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device af_packet r8153_ecm 
cdc_ether usbnet cmac algif_hash algif_skcipher af_alg nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib r8152 mii nft_reject_inet nf_reje>
11月 27 15:13:10 ZHAN66 kernel:  snd_hda_core snd_compress 
snd_pcm_dmaengine snd_pci_acp6x snd_hwdep snd_pcm cfg80211 r8169 
snd_timer ucsi_acpi snd realtek typec_ucsi snd_pci_acp5x mdio_devres 
snd_rn_pci_acp3x typec soundcore snd_pci_acp3x libphy roles rfkill 
nls_iso88>
11月 27 15:13:10 ZHAN66 kernel: ---[ end trace 7dff3b4592ed7de0 ]---
11月 27 15:13:10 ZHAN66 kernel: RIP: 
0010:page_table_check_clear.part.0+0xbb/0xd0
11月 27 15:13:10 ZHAN66 kernel: Code: d8 0f 0b f7 c3 ff 0f 00 00 75 97 48 
8b 13 f7 c2 00 00 01 00 74 8c 48 8b 53 48 4c 8d 62 ff 83 e2 01 4c 0f 44 
e3 e9 78 ff ff ff <0f> 0b 0f 0b 0f 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 
00 00 00 00 0f
11月 27 15:13:10 ZHAN66 kernel: RSP: 0018:ffffb784403e7a80 EFLAGS: 00010202
11月 27 15:13:10 ZHAN66 kernel: RAX: ffff987f419362e0 RBX: 
fffff1cf842d8b80 RCX: 0000000000000000
11月 27 15:13:10 ZHAN66 kernel: RDX: ffff987f419362e8 RSI: 
0000000000000001 RDI: 0000000000000001
11月 27 15:13:10 ZHAN66 kernel: RBP: 0000000000000001 R08: 
00000000ffffffff R09: 0000000000000825
11月 27 15:13:10 ZHAN66 kernel: R10: 0000000000000067 R11: 
000000000003a878 R12: fffff1cf842d8b80
11月 27 15:13:10 ZHAN66 kernel: R13: ffff987f468e9100 R14: 
ffff98801df1e960 R15: 03ffffffffffffff
11月 27 15:13:10 ZHAN66 kernel: FS:  0000000000000000(0000) 
GS:ffff98823f400000(0000) knlGS:0000000000000000
11月 27 15:13:10 ZHAN66 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
11月 27 15:13:10 ZHAN66 kernel: CR2: 00007f9b8591bd20 CR3: 
0000000161d0c000 CR4: 0000000000350ef0
11月 27 15:13:10 ZHAN66 kernel: note: kcompactd0[75] exited with 
preempt_count 1
11月 27 15:13:13 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:13 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:13 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-contrast-client-protocol.h"
11月 27 15:13:15 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:15 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:15 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-blur-server-protocol.h"
11月 27 15:13:22 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:22 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:22 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-slide-client-protocol.h"
11月 27 15:13:30 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:30 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:30 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-shadow-client-protocol.h"
11月 27 15:13:33 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:33 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:33 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-fake-input-server-protocol.h"
11月 27 15:13:36 ZHAN66 kernel: watchdog: BUG: soft lockup - CPU#4 stuck 
for 22s! [plasmashell:6294]
11月 27 15:13:36 ZHAN66 kernel: Modules linked in: uinput rfcomm 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device af_packet r8153_ecm 
cdc_ether usbnet cmac algif_hash algif_skcipher af_alg nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib r8152 mii nft_reject_inet nf_reje>
11月 27 15:13:36 ZHAN66 kernel:  snd_hda_core snd_compress 
snd_pcm_dmaengine snd_pci_acp6x snd_hwdep snd_pcm cfg80211 r8169 
snd_timer ucsi_acpi snd realtek typec_ucsi snd_pci_acp5x mdio_devres 
snd_rn_pci_acp3x typec soundcore snd_pci_acp3x libphy roles rfkill 
nls_iso88>
11月 27 15:13:36 ZHAN66 kernel: CPU: 4 PID: 6294 Comm: plasmashell 
Tainted: G      D           5.16.0-rc2-next-20211125-1.ga5a7188-vanilla 
#1 3000d4f4dc38a6eb529f948e10865da4957e57dc
11月 27 15:13:36 ZHAN66 kernel: Hardware name: HP HP ZHAN 66 Pro A 14 
G3/876B, BIOS S81 Ver. 01.03.01 10/23/2020
11月 27 15:13:36 ZHAN66 kernel: RIP: 
0010:native_queued_spin_lock_slowpath+0x5c/0x1d0
11月 27 15:13:36 ZHAN66 kernel: Code: 0f ba 2a 08 0f 92 c1 8b 02 0f b6 c9 
c1 e1 08 30 e4 09 c8 a9 00 01 ff ff 0f 85 11 01 00 00 85 c0 74 0e 8b 02 
84 c0 74 08 f3 90 <8b> 02 84 c0 75 f8 b8 01 00 00 00 66 89 02 c3 8b 37 
b9 00 02 00 00
11月 27 15:13:36 ZHAN66 kernel: RSP: 0000:ffffb78441ca3d48 EFLAGS: 00000202
11月 27 15:13:36 ZHAN66 kernel: RAX: 0000000000000101 RBX: 
0000000000000028 RCX: 0000000000000000
11月 27 15:13:36 ZHAN66 kernel: RDX: fffff1cf88a25ca8 RSI: 
0000000000000000 RDI: fffff1cf88a25ca8
11月 27 15:13:36 ZHAN66 kernel: RBP: ffffb78441ca3e00 R08: 
0000000000000028 R09: fffff1cf88a25ca8
11月 27 15:13:36 ZHAN66 kernel: R10: 0000000000000000 R11: 
0000000000000000 R12: 00007fac2d8f0000
11月 27 15:13:36 ZHAN66 kernel: R13: 0000000000000000 R14: 
fffff1cf8a86d200 R15: ffff987f48994af0
11月 27 15:13:36 ZHAN66 kernel: FS:  00007fac28a23e40(0000) 
GS:ffff98823f500000(0000) knlGS:0000000000000000
11月 27 15:13:36 ZHAN66 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
11月 27 15:13:36 ZHAN66 kernel: CR2: 00007fac2d8f0c60 CR3: 
000000010b950000 CR4: 0000000000350ee0
11月 27 15:13:36 ZHAN66 kernel: Call Trace:
11月 27 15:13:36 ZHAN66 kernel:  <TASK>
11月 27 15:13:36 ZHAN66 kernel:  _raw_spin_lock+0x21/0x30
11月 27 15:13:36 ZHAN66 kernel:  filemap_map_pages+0x2f6/0x690
11月 27 15:13:36 ZHAN66 kernel:  __handle_mm_fault+0xcbd/0x1550
11月 27 15:13:10 ZHAN66 kernel:  compact_zone+0x5ec/0xe70
11月 27 15:13:10 ZHAN66 kernel:  ? finish_task_switch.isra.0+0xb4/0x2c0
11月 27 15:13:10 ZHAN66 kernel:  proactive_compact_node+0x88/0xc0
11月 27 15:13:10 ZHAN66 kernel:  kcompactd+0x1c4/0x410
11月 27 15:13:10 ZHAN66 kernel:  ? wait_woken+0x70/0x70
11月 27 15:13:10 ZHAN66 kernel:  ? kcompactd_do_work+0x290/0x290
11月 27 15:13:10 ZHAN66 kernel:  kthread+0x15a/0x180
11月 27 15:13:10 ZHAN66 kernel:  ? set_kthread_struct+0x40/0x40
11月 27 15:13:10 ZHAN66 kernel:  ret_from_fork+0x1f/0x30
11月 27 15:13:10 ZHAN66 kernel:  </TASK>
11月 27 15:13:10 ZHAN66 kernel: Modules linked in: uinput rfcomm 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device af_packet r8153_ecm 
cdc_ether usbnet cmac algif_hash algif_skcipher af_alg nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib r8152 mii nft_reject_inet nf_reje>
11月 27 15:13:10 ZHAN66 kernel:  snd_hda_core snd_compress 
snd_pcm_dmaengine snd_pci_acp6x snd_hwdep snd_pcm cfg80211 r8169 
snd_timer ucsi_acpi snd realtek typec_ucsi snd_pci_acp5x mdio_devres 
snd_rn_pci_acp3x typec soundcore snd_pci_acp3x libphy roles rfkill 
nls_iso88>
11月 27 15:13:10 ZHAN66 kernel: ---[ end trace 7dff3b4592ed7de0 ]---
11月 27 15:13:10 ZHAN66 kernel: RIP: 
0010:page_table_check_clear.part.0+0xbb/0xd0
11月 27 15:13:10 ZHAN66 kernel: Code: d8 0f 0b f7 c3 ff 0f 00 00 75 97 48 
8b 13 f7 c2 00 00 01 00 74 8c 48 8b 53 48 4c 8d 62 ff 83 e2 01 4c 0f 44 
e3 e9 78 ff ff ff <0f> 0b 0f 0b 0f 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 
00 00 00 00 0f
11月 27 15:13:10 ZHAN66 kernel: RSP: 0018:ffffb784403e7a80 EFLAGS: 00010202
11月 27 15:13:10 ZHAN66 kernel: RAX: ffff987f419362e0 RBX: 
fffff1cf842d8b80 RCX: 0000000000000000
11月 27 15:13:10 ZHAN66 kernel: RDX: ffff987f419362e8 RSI: 
0000000000000001 RDI: 0000000000000001
11月 27 15:13:10 ZHAN66 kernel: RBP: 0000000000000001 R08: 
00000000ffffffff R09: 0000000000000825
11月 27 15:13:10 ZHAN66 kernel: R10: 0000000000000067 R11: 
000000000003a878 R12: fffff1cf842d8b80
11月 27 15:13:10 ZHAN66 kernel: R13: ffff987f468e9100 R14: 
ffff98801df1e960 R15: 03ffffffffffffff
11月 27 15:13:10 ZHAN66 kernel: FS:  0000000000000000(0000) 
GS:ffff98823f400000(0000) knlGS:0000000000000000
11月 27 15:13:10 ZHAN66 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
11月 27 15:13:10 ZHAN66 kernel: CR2: 00007f9b8591bd20 CR3: 
0000000161d0c000 CR4: 0000000000350ef0
11月 27 15:13:10 ZHAN66 kernel: note: kcompactd0[75] exited with 
preempt_count 1
11月 27 15:13:13 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:13 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:13 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-contrast-client-protocol.h"
11月 27 15:13:15 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:15 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:15 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-blur-server-protocol.h"
11月 27 15:13:22 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:22 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:22 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-slide-client-protocol.h"
11月 27 15:13:30 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:30 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:30 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-shadow-client-protocol.h"
11月 27 15:13:33 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:33 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:33 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-fake-input-server-protocol.h"
11月 27 15:13:36 ZHAN66 kernel: watchdog: BUG: soft lockup - CPU#4 stuck 
for 22s! [plasmashell:6294]
11月 27 15:13:36 ZHAN66 kernel: Modules linked in: uinput rfcomm 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device af_packet r8153_ecm 
cdc_ether usbnet cmac algif_hash algif_skcipher af_alg nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib r8152 mii nft_reject_inet nf_reje>
11月 27 15:13:36 ZHAN66 kernel:  snd_hda_core snd_compress 
snd_pcm_dmaengine snd_pci_acp6x snd_hwdep snd_pcm cfg80211 r8169 
snd_timer ucsi_acpi snd realtek typec_ucsi snd_pci_acp5x mdio_devres 
snd_rn_pci_acp3x typec soundcore snd_pci_acp3x libphy roles rfkill 
nls_iso88>
11月 27 15:13:36 ZHAN66 kernel: CPU: 4 PID: 6294 Comm: plasmashell 
Tainted: G      D           5.16.0-rc2-next-20211125-1.ga5a7188-vanilla 
#1 3000d4f4dc38a6eb529f948e10865da4957e57dc
11月 27 15:13:36 ZHAN66 kernel: Hardware name: HP HP ZHAN 66 Pro A 14 
G3/876B, BIOS S81 Ver. 01.03.01 10/23/2020
11月 27 15:13:36 ZHAN66 kernel: RIP: 
0010:native_queued_spin_lock_slowpath+0x5c/0x1d0
11月 27 15:13:36 ZHAN66 kernel: Code: 0f ba 2a 08 0f 92 c1 8b 02 0f b6 c9 
c1 e1 08 30 e4 09 c8 a9 00 01 ff ff 0f 85 11 01 00 00 85 c0 74 0e 8b 02 
84 c0 74 08 f3 90 <8b> 02 84 c0 75 f8 b8 01 00 00 00 66 89 02 c3 8b 37 
b9 00 02 00 00
11月 27 15:13:36 ZHAN66 kernel: RSP: 0000:ffffb78441ca3d48 EFLAGS: 00000202
11月 27 15:13:36 ZHAN66 kernel: RAX: 0000000000000101 RBX: 
0000000000000028 RCX: 0000000000000000
11月 27 15:13:36 ZHAN66 kernel: RDX: fffff1cf88a25ca8 RSI: 
0000000000000000 RDI: fffff1cf88a25ca8
11月 27 15:13:36 ZHAN66 kernel: RBP: ffffb78441ca3e00 R08: 
0000000000000028 R09: fffff1cf88a25ca8
11月 27 15:13:36 ZHAN66 kernel: R10: 0000000000000000 R11: 
0000000000000000 R12: 00007fac2d8f0000
11月 27 15:13:36 ZHAN66 kernel: R13: 0000000000000000 R14: 
fffff1cf8a86d200 R15: ffff987f48994af0
11月 27 15:13:36 ZHAN66 kernel: FS:  00007fac28a23e40(0000) 
GS:ffff98823f500000(0000) knlGS:0000000000000000
11月 27 15:13:36 ZHAN66 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
11月 27 15:13:36 ZHAN66 kernel: CR2: 00007fac2d8f0c60 CR3: 
000000010b950000 CR4: 0000000000350ee0
11月 27 15:13:36 ZHAN66 kernel: Call Trace:
11月 27 15:13:36 ZHAN66 kernel:  <TASK>
11月 27 15:13:36 ZHAN66 kernel:  _raw_spin_lock+0x21/0x30
11月 27 15:13:36 ZHAN66 kernel:  filemap_map_pages+0x2f6/0x690
11月 27 15:13:36 ZHAN66 kernel:  __handle_mm_fault+0xcbd/0x1550
11月 27 15:13:36 ZHAN66 kernel:  ? _copy_to_user+0x1c/0x30
11月 27 15:13:36 ZHAN66 kernel:  handle_mm_fault+0xb2/0x280
11月 27 15:13:36 ZHAN66 kernel:  do_user_addr_fault+0x1ba/0x690
11月 27 15:13:36 ZHAN66 kernel:  ? do_syscall_64+0x69/0x80
11月 27 15:13:36 ZHAN66 kernel:  exc_page_fault+0x68/0x150
11月 27 15:13:36 ZHAN66 kernel:  ? asm_exc_page_fault+0x8/0x30
11月 27 15:13:36 ZHAN66 kernel:  asm_exc_page_fault+0x1e/0x30
11月 27 15:13:36 ZHAN66 kernel: RIP: 0033:0x7fac2d8f0c60
11月 27 15:13:36 ZHAN66 kernel: Code: Unable to access opcode bytes at 
RIP 0x7fac2d8f0c36.
11月 27 15:13:36 ZHAN66 kernel: RSP: 002b:00007fff1c421988 EFLAGS: 00010206
11月 27 15:13:36 ZHAN66 kernel: RAX: 0000000000000001 RBX: 
000055bed54aecb8 RCX: 000055bed54ce290
11月 27 15:13:36 ZHAN66 kernel: RDX: 000055bed54ce290 RSI: 
000055bed7361ca8 RDI: 000055bed7315ba0
11月 27 15:13:36 ZHAN66 kernel: RBP: 000055bed7315ba0 R08: 
0000000000000000 R09: 00007fac2b71f620
11月 27 15:13:36 ZHAN66 kernel: R10: 00007fff1c4a7080 R11: 
9a5279bc9b9622a2 R12: 000055bed54aecc8
11月 27 15:13:36 ZHAN66 kernel: R13: 000055bed75d6980 R14: 
000055bed55d58b0 R15: 00007fff1c421a40
11月 27 15:13:36 ZHAN66 kernel:  </TASK>
11月 27 15:13:39 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:39 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:39 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-fake-input-client-protocol.h"
11月 27 15:13:43 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:43 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:43 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-blur-client-protocol.h"
11月 27 15:13:46 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: 
clang_parseTranslationUnit2 return with error code 4
11月 27 15:13:46 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang:   (start 
KDevelop with `KDEV_CLANG_DISPLAY_DIAGS=1 kdevelop` to see more diagnostics)
11月 27 15:13:46 ZHAN66 kdevelop[3039]: kdevelop.plugins.clang: Failed to 
parse translation unit: 
"/home/qydw/文档/osc/KDE/kwayland/build/src/server/wayland-dpms-server-protocol.h"
-- Boot 2c685d4adc43478f9350816f24a67c6d --

```

