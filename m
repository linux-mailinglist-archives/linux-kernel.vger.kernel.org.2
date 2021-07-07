Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659F03BE05D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGGAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 20:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGAvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 20:51:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AD1C61CAA;
        Wed,  7 Jul 2021 00:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625618910;
        bh=DEZxtfFYNrZg/jII4gqRxKxGS5aUsk7IDjvFNcOk6OI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gnKnVoeZeyKFS71Skt1/EwjF3gZKjZJ/K2KZRXAbYn/H7icxkhrxaijo/U0llkq/A
         2LqiPAqwCyBkfTA8RlWYu3cv7/VmYaPPT9zYAr0W7L6WyGiB5i3oRs5QAESfjG/6Os
         pUl25WTuD3wHmo/u5iqU4FZ4MFwZxQjAkZjXukOrtuBrjEqwYhe/bFKULvxaBS9S5n
         azbrRdcCE3e26uXPphcJq4cr2W82/nJCgl+DGXctZm+OtR6ctBe36h6f9UdfPIdUjV
         +u3Meo0cYqTw4IqcZwDflfx5i7nE2EcjfO2ACxAL/HHVsUUtVf1cUjmbzKo3J/Cf0O
         S9KsuXru9kpbw==
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
To:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org> <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
 <20210706091211.GR3840@techsingularity.net>
From:   Chao Yu <chao@kernel.org>
Message-ID: <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
Date:   Wed, 7 Jul 2021 08:48:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706091211.GR3840@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/6 17:12, Mel Gorman wrote:
> On Mon, Jul 05, 2021 at 07:45:26PM +0100, Matthew Wilcox wrote:
>> I'm not really familiar with the compaction code.  Mel, I see a call
>> to post_alloc_hook() in split_map_pages().  Are there other ways of
>> getting the compaction code to allocate a page which don't go through
>> split_map_pages()?
> 
> I don't *think* so but I didn't look too hard as I had limited time
> available before a meeting. compaction_alloc calls isolate_freepages
> and that calls split_map_pages whether fast or slow isolating pages. The
> problem *may* be in split_page because only the head page gets order set
> to 0 but it's a bad fit because tail pages should be cleared of private
> state by del_page_from_free_list. It might be worth adding a debugging
> patch to split_pages that prints a warning once if a tail page has private
> state and dump the contents of private to see if it looks like an order.

Thanks for your hint!

---
  mm/page_alloc.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..be87c4be481f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3515,8 +3515,13 @@ void split_page(struct page *page, unsigned int order)
  	VM_BUG_ON_PAGE(PageCompound(page), page);
  	VM_BUG_ON_PAGE(!page_count(page), page);

-	for (i = 1; i < (1 << order); i++)
-		set_page_refcounted(page + i);
+	for (i = 1; i < (1 << order); i++) {
+		struct page *tail_page = page + i;
+
+		set_page_refcounted(tail_page);
+		if (WARN_ON_ONCE(tail_page->private))
+			pr_info("order:%x, tailpage.private:%x", order, tail_page->private);
+	}
  	split_page_owner(page, 1 << order);
  	split_page_memcg(page, 1 << order);
  }
-- 
2.22.1

With above diff, I got this:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 57 at mm/page_alloc.c:3363 split_page.cold+0x8/0x3b
CPU: 3 PID: 57 Comm: kcompactd0 Tainted: G           O      5.13.0-rc1+ #67
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
RIP: 0010:split_page.cold+0x8/0x3b
Code: 83 05 a9 1a 32 02 01 48 c7 05 16 5f 32 02 00 00 00 00 48 c7 05 1b 5f 32 02 01 00 00 00 e9 3c ff ff ff 48 83 05 6e 2c 32 02 01 <0f> 0b 48 83 05 6c 2c 32 02 01 48 c7 c7 38 b2 b1 82 89 ce 89 4d dc
RSP: 0018:ffffc90000227bc0 EFLAGS: 00010202
RAX: 0000000000001f80 RBX: ffffea0004942600 RCX: 0000000000000007
RDX: 00000000000d0000 RSI: 0000000000000007 RDI: ffffea0004942000
RBP: ffffc90000227be8 R08: 0000000000000081 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000125200 R12: ffffea0004944000
R13: 0000000000000080 R14: ffffea0004942000 R15: ffffc90000227c00
FS:  0000000000000000(0000) GS:ffff888217b80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94ed9bef80 CR3: 0000000002e12001 CR4: 00000000000706e0
Call Trace:
  split_map_pages+0x11d/0x190
  isolate_freepages+0x355/0x3f0
  ? free_unref_page+0xd0/0x110
  ? trace_hardirqs_on+0x52/0x200
  compaction_alloc+0x61/0x80
  migrate_pages+0x36a/0xf30
  ? move_freelist_tail+0x140/0x140
  ? isolate_freepages+0x3f0/0x3f0
  compact_zone+0x221/0xaa0
  kcompactd_do_work+0x1ef/0x590
  kcompactd+0x115/0x5c0
  ? woken_wake_function+0x40/0x40
  kthread+0x17d/0x1e0
  ? proactive_compact_node+0xe0/0xe0
  ? kthread_insert_work_sanity_check+0xf0/0xf0
  ret_from_fork+0x22/0x30
irq event stamp: 389337
hardirqs last  enabled at (389343): [<ffffffff811755ea>] console_unlock+0x4da/0x690
hardirqs last disabled at (389348): [<ffffffff811755d0>] console_unlock+0x4c0/0x690
softirqs last  enabled at (277616): [<ffffffff824005bf>] __do_softirq+0x5bf/0x6c4
softirqs last disabled at (277605): [<ffffffff810bc47b>] irq_exit_rcu+0x12b/0x1b0
---[ end trace 910306ade44b0b3d ]---
order:7, tailpage.private:d0000
order:7, tailpage.private:d0000
order:7, tailpage.private:d0000
order:7, tailpage.private:200000
order:7, tailpage.private:d0000
order:7, tailpage.private:d0000
order:7, tailpage.private:d0000

So how about adding set_page_private(page, 0) in split_page() to clear
stall data left in tailpages' private field?

Thanks,

> 
