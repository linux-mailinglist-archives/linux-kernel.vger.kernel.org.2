Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50DB353458
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhDCOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236621AbhDCOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:34:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE2761279;
        Sat,  3 Apr 2021 14:34:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lShM8-0040GN-3H; Sat, 03 Apr 2021 10:34:32 -0400
Message-ID: <20210403143431.982491171@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 03 Apr 2021 10:33:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-next][PATCH 4/4] ftrace: Simplify the calculation of page number for
 ftrace_page->records some more
References: <20210403143347.409590683@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit b40c6eabfcd40 ("ftrace: Simplify the calculation of page number for
ftrace_page->records") simplified the calculation of the number of pages
needed for each page group without having any empty pages, but it can be
simplified even further.

Link: https://lore.kernel.org/lkml/CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f7bef5a9ada9..057e962ca5ce 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3156,15 +3156,9 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	if (WARN_ON(!count))
 		return -EINVAL;
 
+	/* We want to fill as much as possible, with no empty pages */
 	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
-	order = get_count_order(pages);
-
-	/*
-	 * We want to fill as much as possible. No more than a page
-	 * may be empty.
-	 */
-	if (!is_power_of_2(pages))
-		order--;
+	order = fls(pages) - 1;
 
  again:
 	pg->records = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-- 
2.30.1


