Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97EB4066E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhIJFr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 01:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhIJFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 01:47:28 -0400
X-Greylist: delayed 138505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Sep 2021 22:46:17 PDT
Received: from lb2-smtp-cloud7.xs4all.net (lb2-smtp-cloud7.xs4all.net [IPv6:2001:888:0:108::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566AEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 22:46:17 -0700 (PDT)
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id OZMam4HtwpQdWOZMbmqNe0; Fri, 10 Sep 2021 07:46:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1631252773; bh=7pBReEtPBZIm6hOGKwoGcZ899/ehrtxwKBmlYQ75ErU=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=nZ4+/V2VmkWb9eTK81vPvBnFGxnLsp5vEaBHjbPrJW8nICl6/qZEOxqNYG4RKi3BV
         ptJ9sv9CJqKaRU8ZOr2B9OBIsHDIEeV7dti7EuhY3SnVL3W9geKkJ24vs2syC1Mq92
         2BtfmGbiM/W2+8z2yfleu9yPwqcIiUBCzDodxUhEyudC92EzReyn0r2P8B+nCRHz9/
         ZKoHtASgf7C/NXHi0Mn/YDdyFXC8kjZaiclxLN8VuHIFoAZhDzAtdOH/BR3JD6SI5a
         l/qIGiNqa3NJlshgfOZ3qhYRY6FQwHb2wp9wOgGOLYVZbK8Mcwz18FRMu3E0jSuFDX
         DFGbFaW6Cv4zQ==
Subject: Re: 5.13.14 page allocation failure
From:   Udo van den Heuvel <udovdh@xs4all.nl>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9166a3d3-bb22-bf23-453f-8507cc3dc500@xs4all.nl>
Organization: hierzo
Message-ID: <de041938-1440-d1c7-61a0-0be3cd28f8c4@xs4all.nl>
Date:   Fri, 10 Sep 2021 07:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9166a3d3-bb22-bf23-453f-8507cc3dc500@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEWlhGIq+cQJRHsusFCnnmToDsxmhBXs/wmBvf/sn0XsSDxz46W0MOfMB9djjiDvuYXet+8Q49DNjobSS1xcpL65mC84vWY/my2YQyulXSPAKzcdO6UG
 nS311N+dnSHPONkO3XUjy0wZIXngXR8A6KDcMpM5qKV3vWR4scBHr350dOUY8MtPdfyLWNA3Z3u6KRK2D+rFINMLvRoUbZ1UkGU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again:

Sep  9 15:06:03 surfplank2 rtkit-daemon[296496]: Successfully made 
thread 311799 of process 311302 (/usr/lib64/firefox/firefox) owned by 
'500' RT at priority 10.
Sep  9 15:12:41 knalp3 kernel: [120876.114705] warn_alloc: 2 callbacks 
suppressed
Sep  9 15:12:41 knalp3 kernel: [120876.114708] Web Content: page 
allocation failure: order:7, mode:0x40a20(GFP_ATOMIC|__GFP_COMP), 
nodemask=(null)
Sep  9 15:12:41 knalp3 kernel: [120876.114715] CPU: 12 PID: 312097 Comm: 
Web Content Not tainted 5.13.14 #5
Sep  9 15:12:41 knalp3 kernel: [120876.114717] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F34 07/08/2021
Sep  9 15:12:41 knalp3 kernel: [120876.114718] Call Trace:
Sep  9 15:12:41 knalp3 kernel: [120876.114721]  dump_stack+0x64/0x7c
Sep  9 15:12:41 knalp3 kernel: [120876.114725]  warn_alloc.cold+0x6f/0xd3
Sep  9 15:12:41 knalp3 kernel: [120876.114728] 
__alloc_pages_slowpath.constprop.0+0x6c3/0xa80
Sep  9 15:12:41 knalp3 kernel: [120876.114731]  ? 
get_page_from_freelist+0x223/0x9d0
Sep  9 15:12:41 knalp3 kernel: [120876.114733]  __alloc_pages+0x169/0x1d0
Sep  9 15:12:41 knalp3 kernel: [120876.114735] 
cache_alloc_refill+0x58f/0x810
Sep  9 15:12:41 knalp3 kernel: [120876.114737]  ? _raw_spin_unlock+0xd/0x20
Sep  9 15:12:41 knalp3 kernel: [120876.114740]  kmem_cache_alloc+0x109/0x120
Sep  9 15:12:41 knalp3 kernel: [120876.114742]  p_dump_task_f+0x19/0xf0 
[p_lkrg]
Sep  9 15:12:41 knalp3 kernel: [120876.114749] 
p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Sep  9 15:12:41 knalp3 kernel: [120876.114753] 
pre_handler_kretprobe+0x8a/0x160
Sep  9 15:12:41 knalp3 kernel: [120876.114756]  opt_pre_handler+0x4a/0x80
Sep  9 15:12:41 knalp3 kernel: [120876.114758]  optimized_callback+0xbe/0xf0
Sep  9 15:12:41 knalp3 kernel: [120876.114761]  0xffffffffc0076294
Sep  9 15:12:41 knalp3 kernel: [120876.114763]  ? wake_up_new_task+0x1/0x280
Sep  9 15:12:41 knalp3 kernel: [120876.114765]  ? kernel_clone+0xd6/0x380
Sep  9 15:12:41 knalp3 kernel: [120876.114768]  ? __do_sys_clone+0x60/0x80
Sep  9 15:12:41 knalp3 kernel: [120876.114769]  ? do_syscall_64+0x61/0x80
Sep  9 15:12:41 knalp3 kernel: [120876.114771]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Sep  9 15:12:41 knalp3 kernel: [120876.114773]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Sep  9 15:12:41 knalp3 kernel: [120876.114775] Mem-Info:
Sep  9 15:12:41 knalp3 kernel: [120876.114776] active_anon:2937 
inactive_anon:1070473 isolated_anon:0
Sep  9 15:12:41 knalp3 kernel: [120876.114776]  active_file:2166685 
inactive_file:4129380 isolated_file:0
Sep  9 15:12:41 knalp3 kernel: [120876.114776]  unevictable:6793 
dirty:773 writeback:0
Sep  9 15:12:41 knalp3 kernel: [120876.114776]  slab_reclaimable:58285 
slab_unreclaimable:200826
Sep  9 15:12:41 knalp3 kernel: [120876.114776]  mapped:263480 
shmem:109170 pagetables:10726 bounce:0
Sep  9 15:12:41 knalp3 kernel: [120876.114776]  free:116342 
free_pcp:7303 free_cma:0
Sep  9 15:12:41 knalp3 kernel: [120876.114779] Node 0 
active_anon:11748kB inactive_anon:4281892kB active_file:8666740kB 
inactive_file:16517520kB unevictable:27172kB isolated(anon):0kB 
isolated(file):0kB mapped:1053920kB dirty:3092kB writeback:0kB 
shmem:436680kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 13352
96kB writeback_tmp:0kB kernel_stack:26276kB pagetables:42904kB 
all_unreclaimable? no
Sep  9 15:12:41 knalp3 kernel: [120876.114782] DMA free:11264kB min:32kB 
low:44kB high:56kB reserved_highatomic:0KB active_anon:0kB 
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:15984kB managed:15360kB mlocked:0kB bounce:0kB 
free_pcp:0kB local_pcp:0kB free_cma:0kB
Sep  9 15:12:41 knalp3 kernel: [120876.114785] lowmem_reserve[]: 0 2357 
31506 31506
Sep  9 15:12:41 knalp3 kernel: [120876.114787] DMA32 free:118884kB 
min:5052kB low:7464kB high:9876kB reserved_highatomic:26624KB 
active_anon:4144kB inactive_anon:713188kB active_file:581608kB 
inactive_file:865364kB unevictable:0kB writepending:208kB 
present:2521312kB managed:2455776kB mlocked:0kB bounce:0kB free
_pcp:15980kB local_pcp:1344kB free_cma:0kB
Sep  9 15:12:41 knalp3 kernel: [120876.114790] lowmem_reserve[]: 0 0 
29148 29148
Sep  9 15:12:41 knalp3 kernel: [120876.114791] Normal free:335220kB 
min:64544kB low:94388kB high:124232kB reserved_highatomic:0KB 
active_anon:7604kB inactive_anon:3569388kB active_file:8085132kB 
inactive_file:15652668kB unevictable:27172kB writepending:2884kB 
present:30379008kB managed:29854648kB mlocked:24700kB
  bounce:0kB free_pcp:13080kB local_pcp:688kB free_cma:0kB
Sep  9 15:12:41 knalp3 kernel: [120876.114794] lowmem_reserve[]: 0 0 0 0
Sep  9 15:12:41 knalp3 kernel: [120876.114795] DMA: 0*4kB 0*8kB 0*16kB 
0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB 
(M) = 11264kB
Sep  9 15:12:41 knalp3 kernel: [120876.114801] DMA32: 2599*4kB (UM) 
4207*8kB (UM) 781*16kB (M) 144*32kB (M) 114*64kB (UM) 38*128kB (UM) 
20*256kB (UM) 15*512kB (UM) 2*1024kB (M) 5*2048kB (UM) 5*4096kB (M) = 
118884kB
Sep  9 15:12:41 knalp3 kernel: [120876.114807] Normal: 2676*4kB (UME) 
1619*8kB (UME) 5501*16kB (UME) 2818*32kB (UME) 867*64kB (UME) 455*128kB 
(UME) 78*256kB (UM) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 335544kB
Sep  9 15:12:41 knalp3 kernel: [120876.114813] Node 0 hugepages_total=0 
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Sep  9 15:12:41 knalp3 kernel: [120876.114814] 6409485 total pagecache pages
Sep  9 15:12:41 knalp3 kernel: [120876.114815] 2 pages in swap cache
Sep  9 15:12:41 knalp3 kernel: [120876.114816] Swap cache stats: add 
211, delete 209, find 61/84
Sep  9 15:12:41 knalp3 kernel: [120876.114817] Free swap  = 18873080kB
Sep  9 15:12:41 knalp3 kernel: [120876.114818] Total swap = 18874360kB
Sep  9 15:12:41 knalp3 kernel: [120876.114819] 8229076 pages RAM
Sep  9 15:12:41 knalp3 kernel: [120876.114819] 0 pages HighMem/MovableOnly
Sep  9 15:12:41 knalp3 kernel: [120876.114820] 147630 pages reserved
Sep  9 15:12:41 knalp3 kernel: [120876.114820] [p_lkrg] 
p_alloc_ed_pids() returned NULL for pid 312164 :(
Sep  9 15:12:41 knalp3 kernel: [120876.114822] [p_lkrg] <Exploit 
Detection> Error[-1] when trying to add process[312164 |Web Content] for 
tracking!
Sep  9 15:12:41 knalp3 kernel: [120876.184547] [p_lkrg] 
p_alloc_ed_pids() returned NULL for pid 312165 :(
Sep  9 15:12:41 knalp3 kernel: [120876.184551] [p_lkrg] <Exploit 
Detection> Error[-1] when trying to add process[312165 |Socket Thread] 
for tracking!
Sep  9 15:12:41 knalp3 kernel: warn_alloc: 2 callbacks suppressed



Udo


On 08-09-2021 17:17, Udo van den Heuvel wrote:
> Hello,
> 
> Ever since I recently migrated from AMD Ryzen 3400g to 5700g and went 
> from 16GB to 32GB we get these:
> 
> Sep  8 16:40:44 knalp3 kernel: chrome: page allocation failure: order:7, 
> mode:0x40a20(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
> Sep  8 16:40:44 knalp3 kernel: CPU: 0 PID: 156918 Comm: chrome Not 
> tainted 5.13.14 #5
> Sep  8 16:40:44 knalp3 kernel: Hardware name: Gigabyte Technology Co., 
> Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F34 07/08/2021
> Sep  8 16:40:44 knalp3 kernel: Call Trace:
> Sep  8 16:40:44 knalp3 kernel: dump_stack+0x64/0x7c
> Sep  8 16:40:44 knalp3 kernel: warn_alloc.cold+0x6f/0xd3
> Sep  8 16:40:44 knalp3 kernel: 
> __alloc_pages_slowpath.constprop.0+0x6c3/0xa80
> Sep  8 16:40:44 knalp3 kernel: ? get_page_from_freelist+0x223/0x9d0
> Sep  8 16:40:44 knalp3 kernel: __alloc_pages+0x169/0x1d0
> Sep  8 16:40:44 knalp3 kernel: cache_alloc_refill+0x58f/0x810
> Sep  8 16:40:44 knalp3 kernel: ? _raw_spin_unlock+0xd/0x20
> Sep  8 16:40:44 knalp3 kernel: kmem_cache_alloc+0x109/0x120
> Sep  8 16:40:44 knalp3 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
> Sep  8 16:40:44 knalp3 kernel: p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
> Sep  8 16:40:44 knalp3 kernel: pre_handler_kretprobe+0x8a/0x160
> Sep  8 16:40:44 knalp3 kernel: opt_pre_handler+0x4a/0x80
> Sep  8 16:40:44 knalp3 kernel: optimized_callback+0xbe/0xf0
> Sep  8 16:40:44 knalp3 kernel: 0xffffffffc0076294
> Sep  8 16:40:44 knalp3 kernel: ? wake_up_new_task+0x1/0x280
> Sep  8 16:40:44 knalp3 kernel: ? kernel_clone+0xd6/0x380
> Sep  8 16:40:44 knalp3 kernel: ? __do_sys_clone+0x60/0x80
> Sep  8 16:40:44 knalp3 kernel: ? do_syscall_64+0x61/0x80
> Sep  8 16:40:44 knalp3 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> Sep  8 16:40:44 knalp3 kernel: Mem-Info:
> Sep  8 16:40:44 knalp3 kernel: active_anon:5244 inactive_anon:1494070 
> isolated_anon:0#012 active_file:1098885 inactive_file:4703460 
> isolated_file:0#012 unevictable:639 dirty:948 writeback:0#012 
> slab_reclaimable:74606 slab_unreclaimable:245109#012 mapped:347626 
> shmem:160084 pagetables:16000 bounce:0#012 free:98085 free_pcp:4475 
> free_cma:0
> Sep  8 16:40:44 knalp3 kernel: Node 0 active_anon:20976kB 
> inactive_anon:5976280kB active_file:4395540kB inactive_file:18813840kB 
> unevictable:2556kB isolated(anon):0kB isolated(file):0kB 
> mapped:1390504kB dirty:3792kB writeback:0kB shmem:640336kB shmem_thp: 
> 0kB shmem_pmdmapped: 0kB anon_thp: 1681408kB writeback_tmp:0kB 
> kernel_stack:31376kB pagetables:64000kB all_unreclaimable? no
> Sep  8 16:40:44 knalp3 kernel: DMA free:11264kB min:32kB low:44kB 
> high:56kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
> present:15984kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB 
> local_pcp:0kB free_cma:0kB
> Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 2357 31506 31506
> Sep  8 16:40:44 knalp3 kernel: DMA32 free:118968kB min:5052kB low:7464kB 
> high:9876kB reserved_highatomic:16384KB active_anon:124kB 
> inactive_anon:772432kB active_file:166476kB inactive_file:1282188kB 
> unevictable:16kB writepending:368kB present:2521312kB managed:2455776kB 
> mlocked:16kB bounce:0kB free_pcp:3528kB local_pcp:0kB free_cma:0kB
> Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 0 29148 29148
> Sep  8 16:40:44 knalp3 kernel: Normal free:262612kB min:64544kB 
> low:94388kB high:124232kB reserved_highatomic:0KB active_anon:20488kB 
> inactive_anon:5202876kB active_file:4228640kB inactive_file:17532192kB 
> unevictable:2540kB writepending:3424kB present:30379008kB 
> managed:29854648kB mlocked:68kB bounce:0kB free_pcp:14248kB 
> local_pcp:64kB free_cma:0kB
> Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 0 0 0
> Sep  8 16:40:44 knalp3 kernel: DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
> 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11264kB
> Sep  8 16:40:44 knalp3 kernel: DMA32: 494*4kB (UM) 132*8kB (UM) 194*16kB 
> (M) 710*32kB (M) 224*64kB (UM) 24*128kB (UM) 18*256kB (UM) 13*512kB (M) 
> 6*1024kB (M) 9*2048kB (M) 9*4096kB (M) = 118968kB
> Sep  8 16:40:44 knalp3 kernel: Normal: 570*4kB (UME) 2546*8kB (UME) 
> 2503*16kB (UME) 1391*32kB (UME) 848*64kB (UME) 549*128kB (UME) 114*256kB 
> (U) 1*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 261448kB
> Sep  8 16:40:44 knalp3 kernel: Node 0 hugepages_total=0 hugepages_free=0 
> hugepages_surp=0 hugepages_size=2048kB
> Sep  8 16:40:44 knalp3 kernel: 5963328 total pagecache pages
> Sep  8 16:40:44 knalp3 kernel: 0 pages in swap cache
> Sep  8 16:40:44 knalp3 kernel: Swap cache stats: add 170, delete 169, 
> find 61/83
> Sep  8 16:40:44 knalp3 kernel: Free swap  = 18873848kB
> Sep  8 16:40:44 knalp3 kernel: Total swap = 18874360kB
> Sep  8 16:40:44 knalp3 kernel: 8229076 pages RAM
> Sep  8 16:40:44 knalp3 kernel: 0 pages HighMem/MovableOnly
> Sep  8 16:40:44 knalp3 kernel: 147630 pages reserved
> Sep  8 16:40:44 knalp3 kernel: [p_lkrg] p_alloc_ed_pids() returned NULL 
> for pid 156929 :(
> 
> This did not happen (unless there really was an OOM) when using 16GB of 
> RAM.
> 
> The RAM is from AMD's HCL for AMD Ryzen 3000+. The RAM was tested with 
> memtest86 with no errors. (only a night, but still)
> 
> How can I find out what is going on?
> Did I misconfigure my kernel?
> Do I make to configure something to use the 'immense' amount of 32GB 
> with no issues?
> 
> Please let me know.
> 
> 
> Kind regards,
> Udo

