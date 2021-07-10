Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F353C33AB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGJIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 04:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhGJIOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 04:14:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D867613BF;
        Sat, 10 Jul 2021 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625904700;
        bh=80vkX1XEmaWnY9YWGGJrbpCeJVSm+nQLZW7RcdCPUx0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mHbog3l2LduSeGAF3DzD/KSd70LZKz97K4+e0OK+p9Q7A46+y/P74ea+Ih6l2e8tG
         xHTneVNBxZaNZgaDfUrT1O/pC5xe0WiRXJkthCZVXjAIHgvZIhWiGd2WiXJMvBp0U8
         2A78yXIrmqimkTlSxVPVvqvr3jJEKQ+w6ahNdq2c0fF05IX1hJ+Z6Qmdi4hWOmHyoP
         WvFFYTONAY/ql2803JuvGxJyZrgKiUyIBUmOmWruou+sFB4rd8VJpuwx7fe8VMprHK
         5zfwtrgUhZ6/YOEaNUc6EMrEVXOI8zfFCuUegITcLFTzI6efeApaOvDGbYZ/7ZUUdH
         4cLOVQ/LQi6Mg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org> <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
 <20210706091211.GR3840@techsingularity.net>
 <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
 <20210707095706.GT3840@techsingularity.net>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fc0de0c2-a3b6-df91-5b90-524768a85d82@kernel.org>
Date:   Sat, 10 Jul 2021 16:11:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707095706.GT3840@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/7 17:57, Mel Gorman wrote:
> I think it would work but it would be preferable to find out why the
> tail page has an order set in the first place. I've looked over

Agreed.

> mm/page_alloc.c and mm/compaction.c a few times and did not spot where
> set_private_page(page, 0) is missed when it should be covered by
> clear_page_guard or del_page_from_free_list :(

I didn't enable CONFIG_DEBUG_PAGEALLOC, so we will expect page private
should be cleared by del_page_from_free_list(), but I guess it only clears
the buddy's private field rather than original page's, so I added below
diff and check the dmesg, it looks stall private value in original page
will be left commonly... Let me know if I missed something?

---
  mm/page_alloc.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a06bcfe6f786..1e7031ff548e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1029,6 +1029,7 @@ static inline void __free_one_page(struct page *page,
  	unsigned long combined_pfn;
  	unsigned int max_order;
  	struct page *buddy;
+	struct page *orig_page = page;
  	bool to_tail;

  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
@@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,

  done_merging:
  	set_buddy_order(page, order);
+	if (orig_page != page) {
+		if (WARN_ON_ONCE(orig_page->private))
+			pr_info("2order:%x, origpage.private:%x", order, orig_page->private);
+	}

  	if (fpi_flags & FPI_TO_TAIL)
  		to_tail = true;
-- 
2.22.1



> 
