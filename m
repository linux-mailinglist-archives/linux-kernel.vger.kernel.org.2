Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC5350132
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhCaN1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235755AbhCaN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:27:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF05361968;
        Wed, 31 Mar 2021 13:27:12 +0000 (UTC)
Date:   Wed, 31 Mar 2021 09:27:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] ftrace: Check if pages were allocated before calling
 free_pages()
Message-ID: <20210331092711.2b23fcff@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Add check of order < 0 before calling free_pages()

The function addresses that are traced by ftrace are stored in pages,
and the size is held in a variable. If there's some error in creating
them, the allocate ones will be freed. In this case, it is possible that
the order of pages to be freed may end up being negative due to a size of
zero passed to get_count_order(), and then that negative number will cause
free_pages() to free a very large section. Make sure that does not happen.


Please pull the latest trace-v5.12-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12-rc5

Tag SHA1: 30ee29d701d2b6848cfa1c7a163745fb68aabd36
Head SHA1: 59300b36f85f254260c81d9dd09195fa49eb0f98


Steven Rostedt (VMware) (1):
      ftrace: Check if pages were allocated before calling free_pages()

----
 kernel/trace/ftrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---------------------------
commit 59300b36f85f254260c81d9dd09195fa49eb0f98
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Tue Mar 30 09:58:38 2021 -0400

    ftrace: Check if pages were allocated before calling free_pages()
    
    It is possible that on error pg->size can be zero when getting its order,
    which would return a -1 value. It is dangerous to pass in an order of -1
    to free_pages(). Check if order is greater than or equal to zero before
    calling free_pages().
    
    Link: https://lore.kernel.org/lkml/20210330093916.432697c7@gandalf.local.home/
    
    Reported-by: Abaci Robot <abaci@linux.alibaba.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..12223132eff4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3231,7 +3231,8 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	pg = start_pg;
 	while (pg) {
 		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		free_pages((unsigned long)pg->records, order);
+		if (order >= 0)
+			free_pages((unsigned long)pg->records, order);
 		start_pg = pg->next;
 		kfree(pg);
 		pg = start_pg;
@@ -6418,7 +6419,8 @@ void ftrace_release_mod(struct module *mod)
 		clear_mod_from_hashes(pg);
 
 		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		free_pages((unsigned long)pg->records, order);
+		if (order >= 0)
+			free_pages((unsigned long)pg->records, order);
 		tmp_page = pg->next;
 		kfree(pg);
 		ftrace_number_of_pages -= 1 << order;
@@ -6778,7 +6780,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		if (!pg->index) {
 			*last_pg = pg->next;
 			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-			free_pages((unsigned long)pg->records, order);
+			if (order >= 0)
+				free_pages((unsigned long)pg->records, order);
 			ftrace_number_of_pages -= 1 << order;
 			ftrace_number_of_groups--;
 			kfree(pg);
