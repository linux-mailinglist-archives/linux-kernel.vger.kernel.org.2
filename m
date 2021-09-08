Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08422403C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348450AbhIHPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:19:03 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:34319 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235024AbhIHPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:19:01 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id NzKdmyfysy7WyNzKemMiXh; Wed, 08 Sep 2021 17:17:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1631114269; bh=Dzx0tLnEK2TlgZYGo0a6z4YrbhLR9se6BQEeumBXNYA=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=W3hMGycXqYiqmItWxaNfEmCLag3eadpMZKk2ioH2LCTjj1j0TvGCa94KiasrFveoC
         BwupawrzCS6X4NFAlnDt7ql0vtzKe6sKLhkMdKNKFqaTFqcT0MatApf9JeYaIYP3/S
         91RpT5/Xt7PGct+7lOLIgVQ++jRsL7q0hza/JOIgSUcmi3BOuyp2yXX59nJuI6oTgk
         jgsV1XIsBqmrbrC7evmzuomtza/P4Ky6EIowKbC4tCXg3CTRwWXFrExF++DZ2AcQA1
         RS7uar/RTYd6oMIbh6orRC5lC3zfkgq3Yso3jW+oKZi+fIROOgfhcaQLt4YR7FU0U3
         jS6PX5JJBqiCg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Organization: hierzo
Subject: 5.13.14 page allocation failure
Message-ID: <9166a3d3-bb22-bf23-453f-8507cc3dc500@xs4all.nl>
Date:   Wed, 8 Sep 2021 17:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCUU5M2j/fgIGe21Ncnh4dhIeTBTf1L3IfdXVQs0h4xe8nTCn87+iaPz789AG1AgGCD/+StKLhiXJ0UY3ZLS0Y4WWlRn6kT/L9MFGHZ1zC61NWJY00wj
 N6qyTPRSUHWlijPtRQhWmVcPZ5Beq4urjTFhpYdKl9vqmD/LGxnHtQVJ7XJz1hNrG6QgWXb5Ad/PAczO4fcYXt+WiEoJxQrpwe8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ever since I recently migrated from AMD Ryzen 3400g to 5700g and went 
from 16GB to 32GB we get these:

Sep  8 16:40:44 knalp3 kernel: chrome: page allocation failure: order:7, 
mode:0x40a20(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
Sep  8 16:40:44 knalp3 kernel: CPU: 0 PID: 156918 Comm: chrome Not 
tainted 5.13.14 #5
Sep  8 16:40:44 knalp3 kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F34 07/08/2021
Sep  8 16:40:44 knalp3 kernel: Call Trace:
Sep  8 16:40:44 knalp3 kernel: dump_stack+0x64/0x7c
Sep  8 16:40:44 knalp3 kernel: warn_alloc.cold+0x6f/0xd3
Sep  8 16:40:44 knalp3 kernel: 
__alloc_pages_slowpath.constprop.0+0x6c3/0xa80
Sep  8 16:40:44 knalp3 kernel: ? get_page_from_freelist+0x223/0x9d0
Sep  8 16:40:44 knalp3 kernel: __alloc_pages+0x169/0x1d0
Sep  8 16:40:44 knalp3 kernel: cache_alloc_refill+0x58f/0x810
Sep  8 16:40:44 knalp3 kernel: ? _raw_spin_unlock+0xd/0x20
Sep  8 16:40:44 knalp3 kernel: kmem_cache_alloc+0x109/0x120
Sep  8 16:40:44 knalp3 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Sep  8 16:40:44 knalp3 kernel: p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Sep  8 16:40:44 knalp3 kernel: pre_handler_kretprobe+0x8a/0x160
Sep  8 16:40:44 knalp3 kernel: opt_pre_handler+0x4a/0x80
Sep  8 16:40:44 knalp3 kernel: optimized_callback+0xbe/0xf0
Sep  8 16:40:44 knalp3 kernel: 0xffffffffc0076294
Sep  8 16:40:44 knalp3 kernel: ? wake_up_new_task+0x1/0x280
Sep  8 16:40:44 knalp3 kernel: ? kernel_clone+0xd6/0x380
Sep  8 16:40:44 knalp3 kernel: ? __do_sys_clone+0x60/0x80
Sep  8 16:40:44 knalp3 kernel: ? do_syscall_64+0x61/0x80
Sep  8 16:40:44 knalp3 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Sep  8 16:40:44 knalp3 kernel: Mem-Info:
Sep  8 16:40:44 knalp3 kernel: active_anon:5244 inactive_anon:1494070 
isolated_anon:0#012 active_file:1098885 inactive_file:4703460 
isolated_file:0#012 unevictable:639 dirty:948 writeback:0#012 
slab_reclaimable:74606 slab_unreclaimable:245109#012 mapped:347626 
shmem:160084 pagetables:16000 bounce:0#012 free:98085 free_pcp:4475 
free_cma:0
Sep  8 16:40:44 knalp3 kernel: Node 0 active_anon:20976kB 
inactive_anon:5976280kB active_file:4395540kB inactive_file:18813840kB 
unevictable:2556kB isolated(anon):0kB isolated(file):0kB 
mapped:1390504kB dirty:3792kB writeback:0kB shmem:640336kB shmem_thp: 
0kB shmem_pmdmapped: 0kB anon_thp: 1681408kB writeback_tmp:0kB 
kernel_stack:31376kB pagetables:64000kB all_unreclaimable? no
Sep  8 16:40:44 knalp3 kernel: DMA free:11264kB min:32kB low:44kB 
high:56kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:15984kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 2357 31506 31506
Sep  8 16:40:44 knalp3 kernel: DMA32 free:118968kB min:5052kB low:7464kB 
high:9876kB reserved_highatomic:16384KB active_anon:124kB 
inactive_anon:772432kB active_file:166476kB inactive_file:1282188kB 
unevictable:16kB writepending:368kB present:2521312kB managed:2455776kB 
mlocked:16kB bounce:0kB free_pcp:3528kB local_pcp:0kB free_cma:0kB
Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 0 29148 29148
Sep  8 16:40:44 knalp3 kernel: Normal free:262612kB min:64544kB 
low:94388kB high:124232kB reserved_highatomic:0KB active_anon:20488kB 
inactive_anon:5202876kB active_file:4228640kB inactive_file:17532192kB 
unevictable:2540kB writepending:3424kB present:30379008kB 
managed:29854648kB mlocked:68kB bounce:0kB free_pcp:14248kB 
local_pcp:64kB free_cma:0kB
Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 0 0 0
Sep  8 16:40:44 knalp3 kernel: DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11264kB
Sep  8 16:40:44 knalp3 kernel: DMA32: 494*4kB (UM) 132*8kB (UM) 194*16kB 
(M) 710*32kB (M) 224*64kB (UM) 24*128kB (UM) 18*256kB (UM) 13*512kB (M) 
6*1024kB (M) 9*2048kB (M) 9*4096kB (M) = 118968kB
Sep  8 16:40:44 knalp3 kernel: Normal: 570*4kB (UME) 2546*8kB (UME) 
2503*16kB (UME) 1391*32kB (UME) 848*64kB (UME) 549*128kB (UME) 114*256kB 
(U) 1*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 261448kB
Sep  8 16:40:44 knalp3 kernel: Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
Sep  8 16:40:44 knalp3 kernel: 5963328 total pagecache pages
Sep  8 16:40:44 knalp3 kernel: 0 pages in swap cache
Sep  8 16:40:44 knalp3 kernel: Swap cache stats: add 170, delete 169, 
find 61/83
Sep  8 16:40:44 knalp3 kernel: Free swap  = 18873848kB
Sep  8 16:40:44 knalp3 kernel: Total swap = 18874360kB
Sep  8 16:40:44 knalp3 kernel: 8229076 pages RAM
Sep  8 16:40:44 knalp3 kernel: 0 pages HighMem/MovableOnly
Sep  8 16:40:44 knalp3 kernel: 147630 pages reserved
Sep  8 16:40:44 knalp3 kernel: [p_lkrg] p_alloc_ed_pids() returned NULL 
for pid 156929 :(

This did not happen (unless there really was an OOM) when using 16GB of RAM.

The RAM is from AMD's HCL for AMD Ryzen 3000+. The RAM was tested with 
memtest86 with no errors. (only a night, but still)

How can I find out what is going on?
Did I misconfigure my kernel?
Do I make to configure something to use the 'immense' amount of 32GB 
with no issues?

Please let me know.


Kind regards,
Udo
