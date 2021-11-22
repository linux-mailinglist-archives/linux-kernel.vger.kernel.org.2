Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83EE458966
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhKVGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:49:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:34315 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhKVGtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:49:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="221614709"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="221614709"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 22:46:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="508829387"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 22:46:09 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [syzbot] KCSAN: data-race in flush_tlb_batched_pending /
 try_to_unmap_one
References: <00000000000020805d05d110dc77@google.com>
        <YZZn4CPEK7pP4ohN@elver.google.com>
        <D32C44CD-2010-48C1-A213-9059A9D62C56@gmail.com>
Date:   Mon, 22 Nov 2021 14:46:06 +0800
In-Reply-To: <D32C44CD-2010-48C1-A213-9059A9D62C56@gmail.com> (Nadav Amit's
        message of "Fri, 19 Nov 2021 22:11:10 -0800")
Message-ID: <87bl2cg029.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <nadav.amit@gmail.com> writes:

>> On Nov 18, 2021, at 6:49 AM, Marco Elver <elver@google.com> wrote:
>> 
>> On Thu, Nov 18, 2021 at 06:20AM -0800, syzbot wrote:
>>> Hello,
>>> 
>>> syzbot found the following issue on:
>>> 
>>> HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13160026b00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a70237460d215073
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=aa5bebed695edaccf0df
>>> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
>>> 
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>> 
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com
>>> 
>>> ==================================================================
>>> BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
>>> 
>>> write to 0xffff8881072cfbbc of 1 bytes by task 17406 on cpu 1:
>>> flush_tlb_batched_pending+0x5f/0x80 mm/rmap.c:691
>>> madvise_free_pte_range+0xee/0x7d0 mm/madvise.c:594
>>> walk_pmd_range mm/pagewalk.c:128 [inline]
>>> walk_pud_range mm/pagewalk.c:205 [inline]
>>> walk_p4d_range mm/pagewalk.c:240 [inline]
>>> walk_pgd_range mm/pagewalk.c:277 [inline]
>>> __walk_page_range+0x981/0x1160 mm/pagewalk.c:379
>>> walk_page_range+0x131/0x300 mm/pagewalk.c:475
>>> madvise_free_single_vma mm/madvise.c:734 [inline]
>>> madvise_dontneed_free mm/madvise.c:822 [inline]
>>> madvise_vma mm/madvise.c:996 [inline]
>>> do_madvise+0xe4a/0x1140 mm/madvise.c:1202
>>> __do_sys_madvise mm/madvise.c:1228 [inline]
>>> __se_sys_madvise mm/madvise.c:1226 [inline]
>>> __x64_sys_madvise+0x5d/0x70 mm/madvise.c:1226
>>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>> do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> 
>>> write to 0xffff8881072cfbbc of 1 bytes by task 71 on cpu 0:
>>> set_tlb_ubc_flush_pending mm/rmap.c:636 [inline]
>>> try_to_unmap_one+0x60e/0x1220 mm/rmap.c:1515
>>> rmap_walk_anon+0x2fb/0x470 mm/rmap.c:2301
>>> try_to_unmap+0xec/0x110
>>> shrink_page_list+0xe91/0x2620 mm/vmscan.c:1719
>>> shrink_inactive_list+0x3fb/0x730 mm/vmscan.c:2394
>>> shrink_list mm/vmscan.c:2621 [inline]
>>> shrink_lruvec+0x3c9/0x710 mm/vmscan.c:2940
>>> shrink_node_memcgs+0x23e/0x410 mm/vmscan.c:3129
>>> shrink_node+0x8f6/0x1190 mm/vmscan.c:3252
>>> kswapd_shrink_node mm/vmscan.c:4022 [inline]
>>> balance_pgdat+0x702/0xd30 mm/vmscan.c:4213
>>> kswapd+0x200/0x340 mm/vmscan.c:4473
>>> kthread+0x2c7/0x2e0 kernel/kthread.c:327
>>> ret_from_fork+0x1f/0x30
>>> 
>>> value changed: 0x01 -> 0x00
>>> 
>>> Reported by Kernel Concurrency Sanitizer on:
>>> CPU: 0 PID: 71 Comm: kswapd0 Not tainted 5.16.0-rc1-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> ==================================================================
>> 
>> Reading 3ea277194daae, I can't quite determine if this is safe and
>> expected.
>> 
>> Per this observed write/write race, depending on interleaving
>> tlb_flush_batched can randomly be true or false after
>> set_tlb_ubc_flush_pending().
>> 
>> Is this safe?
>> 
>
> I do not think it is safe and I am not the only one.
>
> https://lore.kernel.org/linux-mm/20210131001132.3368247-21-namit@vmware.com/
>
> Perhaps Huang has the cycles to fix it.

Yes.  I will send out a fix to discuss this soon.  Sorry for long delay.

Best Regards,
Huang, Ying
