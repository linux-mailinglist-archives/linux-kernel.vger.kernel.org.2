Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E790E3E2C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhHFOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:11:34 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:58633 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234249AbhHFOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:11:13 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id C0YmmDo74kUPmC0Ynm1K7h; Fri, 06 Aug 2021 16:10:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1628259053; bh=EK4eEAtkp6+B57QnD04FoJFavdpIdeaIdmsi7yAg6T0=;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=DwQ1UJ3Uua/fBJdLMRUf/cfPmS65v0GAP4OiD77UTnpLqG5GXmYhhCLGQkns05pt4
         DfXj57wtZn0dil0m9kUQoSpo6J2pKB398tKRX1YzmbT9z69rtjz/ZAGyj8XDHLt67B
         DVaFLtVSVwKBihqiWBRmoz4J0XcQkDq7/3FTMwRqLQNKbs+kaHWZBrrh5lODzA9nxa
         /WDYnMUev1l+XMJKUhvJORnZCRf7Xjp9z5n53ppOZx5Ww9twKlORouL62U6UkH9+mp
         f4oHwMKFN86G5o2rhNUAtxLy25wesnIoNpL1Ya3WFr7HSpp0NCfx814MeuBOeyI22s
         NH4mVkeYv556Q==
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.12.19 WARNING: CPU: 4 PID: 170452 at kernel/rcu/tree_plugin.h:297
 rcu_note_context_switch+0x37/0x3d0
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Organization: hierzo
Message-ID: <16b6e686-ffb1-7e44-4afc-230ed4d84512@xs4all.nl>
Date:   Fri, 6 Aug 2021 16:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFaa5FQ8quDHSKf1cH5Q3gJLVoL0RkB0Q/cWqkOMpL9/aya54sJgueKdVLwIkh43fZqVxAyc3GLDQ6rKYJ2ko0g5BTYzu5cYusV5zz2nzZVdqKKzoFcU
 bITk2cxG+Huss1wXMRzASjx8gjNnzM9MJVFnbDXVvcGSunxm3DtmaHjoWG09fgt/e3hFV+cbJJoQOPwRtjhMnr/dShvZEl9lYJA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please disregard the prevoious message, subject is now correct.
Found the warning below in my dmesg.
What happened?

Udo


[107610.034111] ------------[ cut here ]------------
[107610.034118] WARNING: CPU: 4 PID: 170452 at 
kernel/rcu/tree_plugin.h:297 rcu_note_context_switch+0x37/0x3d0
[107610.034133] Modules linked in: snd_seq_dummy mq_deadline 
xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 
xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 
ip6table_filter hwmon_vid ip6_tables msr uvcvideo snd_usb_audio 
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_hwdep videodev 
snd_hda_codec_realtek cdc_acm snd_usbmidi_lib videobuf2_common 
snd_hda_codec_generic snd_rawmidi lzo_rle snd_hda_intel lzo_compress 
snd_intel_dspcfg snd_hda_codec snd_seq snd_hda_core k10temp 
snd_seq_device bfq snd_pcm snd_timer snd i2c_piix4 evdev acpi_cpufreq 
p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables x_tables sr_mod 
aesni_intel cdrom amdgpu drm_ttm_helper ttm gpu_sched hid_generic usbhid 
i2c_dev autofs4
[107610.034218] CPU: 4 PID: 170452 Comm: bash Not tainted 5.12.19 #21
[107610.034225] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS 
PRO/X570 AORUS PRO, BIOS F33h 04/23/2021
[107610.034229] RIP: 0010:rcu_note_context_switch+0x37/0x3d0
[107610.034237] Code: 02 00 65 4c 8b 2c 25 00 6c 01 00 e8 a3 f2 6a 00 89 
c0 48 03 1c c5 20 65 ee b2 40 84 ed 75 0d 41 8b 95 fc 02 00 00 85 d2 7e 
02 <0f> 0b 65 48 8b 04 25 00 6c 01 00 8b 80 fc 02 00 00 85 c0 7e 0a 41
[107610.034242] RSP: 0000:ffffb8fdc5237c50 EFLAGS: 00010002
[107610.034248] RAX: 0000000000000004 RBX: ffff95a6ff120a00 RCX: 
0000000000000000
[107610.034253] RDX: 0000000000000001 RSI: ffffffffb2e6cb51 RDI: 
ffffffffb2e7cf7e
[107610.034256] RBP: 0000000000000000 R08: 0000000000000001 R09: 
ffff95a3feced118
[107610.034259] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff95a6ff11fd40
[107610.034263] R13: ffff95a3cb5cc1c0 R14: ffff95a3cb5cc1c0 R15: 
ffffffffb30084a8
[107610.034266] FS:  00007f4009fb0740(0000) GS:ffff95a6ff100000(0000) 
knlGS:0000000000000000
[107610.034271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[107610.034275] CR2: 000055acc46b2350 CR3: 00000001015e4000 CR4: 
00000000003506e0
[107610.034279] Call Trace:
[107610.034284]  __schedule+0x86/0x7d0
[107610.034294]  schedule+0x40/0xe0
[107610.034300]  io_schedule+0x3d/0x60
[107610.034307]  wait_on_page_bit_common+0x11b/0x390
[107610.034315]  ? __filemap_set_wb_err+0x10/0x10
[107610.034321]  __lock_page_or_retry+0x13f/0x1d0
[107610.034327]  do_swap_page+0x35e/0x670
[107610.034335]  __handle_mm_fault+0x926/0x1180
[107610.034341]  handle_mm_fault+0x6c/0x1b0
[107610.034346]  ? find_vma+0x11/0x70
[107610.034350]  do_user_addr_fault+0x1b8/0x5e0
[107610.034358]  exc_page_fault+0x5b/0x80
[107610.034364]  ? asm_exc_page_fault+0x8/0x30
[107610.034369]  asm_exc_page_fault+0x1e/0x30
[107610.034374] RIP: 0033:0x55acc27763b0
[107610.034379] Code: 00 00 48 8b 44 24 28 48 8b 5c 24 20 48 83 7c 24 18 
00 48 8b 00 0f 95 44 24 0f 48 8b 1c d8 48 85 db 0f 84 83 00 00 00 0f 1f 
00 <48> 8b 7b 10 48 8b 4c 24 10 b8 01 00 00 00 48 89 3c 24 48 85 c9 74
[107610.034384] RSP: 002b:00007ffcd6c53390 EFLAGS: 00010202
[107610.034388] RAX: 000055acc45d6fd0 RBX: 000055acc46b2340 RCX: 
000055acc26c6bf0
[107610.034391] RDX: 000055acc45d3690 RSI: 000055acc26c6bf0 RDI: 
000055acc467de20
[107610.034394] RBP: 000055acc460f750 R08: 000055acc460c840 R09: 
000055acc45d0010
[107610.034397] R10: 00007f400a176a00 R11: 0000000000000003 R12: 
00000000000002c8
[107610.034400] R13: 000055acc26c6bf0 R14: 0000000000000000 R15: 
000055acc460c840
[107610.034406] ---[ end trace bc84e30ad6b9cfbe ]---
