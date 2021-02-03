Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34D30DF6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhBCQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234914AbhBCQHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7DD64FA0;
        Wed,  3 Feb 2021 16:05:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf7-009J75-9v; Wed, 03 Feb 2021 11:05:49 -0500
Message-ID: <20210203160549.192549926@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 04/15] ring-buffer: Remove cpu_buffer argument from the rb_inc_page()
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

The cpu_buffer argument is not used inside the rb_inc_page() after
commit 3adc54fa82a6 ("ring-buffer: make the buffer a true circular link
list").
And cpu_buffer argument is not used inside the two functions too,
rb_is_head_page/rb_set_list_to_head.

Link: https://lkml.kernel.org/r/20201225140356.23008-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ec08f948dd80..8fccee76a5f3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1112,8 +1112,7 @@ static struct list_head *rb_list_head(struct list_head *list)
  * its flags will be non zero.
  */
 static inline int
-rb_is_head_page(struct ring_buffer_per_cpu *cpu_buffer,
-		struct buffer_page *page, struct list_head *list)
+rb_is_head_page(struct buffer_page *page, struct list_head *list)
 {
 	unsigned long val;
 
@@ -1142,8 +1141,7 @@ static bool rb_is_reader_page(struct buffer_page *page)
 /*
  * rb_set_list_to_head - set a list_head to be pointing to head.
  */
-static void rb_set_list_to_head(struct ring_buffer_per_cpu *cpu_buffer,
-				struct list_head *list)
+static void rb_set_list_to_head(struct list_head *list)
 {
 	unsigned long *ptr;
 
@@ -1166,7 +1164,7 @@ static void rb_head_page_activate(struct ring_buffer_per_cpu *cpu_buffer)
 	/*
 	 * Set the previous list pointer to have the HEAD flag.
 	 */
-	rb_set_list_to_head(cpu_buffer, head->list.prev);
+	rb_set_list_to_head(head->list.prev);
 }
 
 static void rb_list_head_clear(struct list_head *list)
@@ -1241,8 +1239,7 @@ static int rb_head_page_set_normal(struct ring_buffer_per_cpu *cpu_buffer,
 				old_flag, RB_PAGE_NORMAL);
 }
 
-static inline void rb_inc_page(struct ring_buffer_per_cpu *cpu_buffer,
-			       struct buffer_page **bpage)
+static inline void rb_inc_page(struct buffer_page **bpage)
 {
 	struct list_head *p = rb_list_head((*bpage)->list.next);
 
@@ -1274,11 +1271,11 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	for (i = 0; i < 3; i++) {
 		do {
-			if (rb_is_head_page(cpu_buffer, page, page->list.prev)) {
+			if (rb_is_head_page(page, page->list.prev)) {
 				cpu_buffer->head_page = page;
 				return page;
 			}
-			rb_inc_page(cpu_buffer, &page);
+			rb_inc_page(&page);
 		} while (page != head);
 	}
 
@@ -1824,7 +1821,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cond_resched();
 
 		to_remove_page = tmp_iter_page;
-		rb_inc_page(cpu_buffer, &tmp_iter_page);
+		rb_inc_page(&tmp_iter_page);
 
 		/* update the counters */
 		page_entries = rb_page_entries(to_remove_page);
@@ -2271,7 +2268,7 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	if (iter->head_page == cpu_buffer->reader_page)
 		iter->head_page = rb_set_head_page(cpu_buffer);
 	else
-		rb_inc_page(cpu_buffer, &iter->head_page);
+		rb_inc_page(&iter->head_page);
 
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
@@ -2374,7 +2371,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	 * want the outer most commit to reset it.
 	 */
 	new_head = next_page;
-	rb_inc_page(cpu_buffer, &new_head);
+	rb_inc_page(&new_head);
 
 	ret = rb_head_page_set_head(cpu_buffer, new_head, next_page,
 				    RB_PAGE_NORMAL);
@@ -2526,7 +2523,7 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	next_page = tail_page;
 
-	rb_inc_page(cpu_buffer, &next_page);
+	rb_inc_page(&next_page);
 
 	/*
 	 * If for some reason, we had an interrupt storm that made
@@ -2552,7 +2549,7 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * the buffer, unless the commit page is still on the
 	 * reader page.
 	 */
-	if (rb_is_head_page(cpu_buffer, next_page, &tail_page->list)) {
+	if (rb_is_head_page(next_page, &tail_page->list)) {
 
 		/*
 		 * If the commit is not on the reader page, then
@@ -2879,7 +2876,7 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 			return;
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
-		rb_inc_page(cpu_buffer, &cpu_buffer->commit_page);
+		rb_inc_page(&cpu_buffer->commit_page);
 		/* add barrier to keep gcc from optimizing too much */
 		barrier();
 	}
@@ -3638,14 +3635,14 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 	 * Because the commit page may be on the reader page we
 	 * start with the next page and check the end loop there.
 	 */
-	rb_inc_page(cpu_buffer, &bpage);
+	rb_inc_page(&bpage);
 	start = bpage;
 	do {
 		if (bpage->page == (void *)addr) {
 			local_dec(&bpage->entries);
 			return;
 		}
-		rb_inc_page(cpu_buffer, &bpage);
+		rb_inc_page(&bpage);
 	} while (bpage != start);
 
 	/* commit not part of this buffer?? */
@@ -4367,7 +4364,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->pages = reader->list.prev;
 
 	/* The reader page will be pointing to the new head */
-	rb_set_list_to_head(cpu_buffer, &cpu_buffer->reader_page->list);
+	rb_set_list_to_head(&cpu_buffer->reader_page->list);
 
 	/*
 	 * We want to make sure we read the overruns after we set up our
@@ -4406,7 +4403,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * Now make the new head point back to the reader page.
 	 */
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
-	rb_inc_page(cpu_buffer, &cpu_buffer->head_page);
+	rb_inc_page(&cpu_buffer->head_page);
 
 	local_inc(&cpu_buffer->pages_read);
 
-- 
2.29.2


