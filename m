Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C6444886
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKCSt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:49:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE009C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:47:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d8-20020a253608000000b005c202405f52so5276656yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jmjrIilQHP+skOfmaa+xe8HJHINvgaf5bkHoaKFVkNg=;
        b=h7FZte4wdxvX/GoE7wG+OGNM9Zqxq/HwQ3TPnFC+qbpYCRLo7Qjzkv/G5jwFEbNivt
         Pa2bdTQezVjZ3tH+fvzam8NRDVPHuIE58v2YiTeQmLsF1arGgOxkFVoAn3PtOO0KXP70
         scH4Qqf2J3pfmsLzHTAYLPBFHS/W4zN4GiLMfZ48Ww1zgKG5wmnXKz2Ylu57uGnhB3Zx
         Hj0nwNV/O8ctzUq9yMY+Gm/H0lk7SZHLJbgb0kK+dRHP/3EhSPsGgAFcxBW4CsneAZi8
         YU+FG5Y/8mbzLNhsmujJwM4uq5umblGerG9nYxHhNqIsL3c3wTfEnj02efYMIhXqkb+/
         wJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jmjrIilQHP+skOfmaa+xe8HJHINvgaf5bkHoaKFVkNg=;
        b=VYo4EIwaTpGxfHT4gmQjCWvQSWK/10mteNjTCEtJg57zrns21Hk3BgxMMISp89DVvB
         zuyhcGZ5lheYlwZhTJ4BxUXygQaABTVBbnirCAkjSqaaoRczxU6Gg2CjWlAcjNXH1eSi
         iV1RJAszAfxadmjvUaimR0+6p3JhntvHKVgYlWJPb7jgy9iAWjjhXVhMaTpbZWJ2Wbv3
         HUay94KG74ZgFZW9CghkiicRiKOueNg6rbCiz3id58SEUwgv0B8FSjk5orJl6pyhYr84
         p7GWqtV/zGReyf81TkhZd3IPqavjVrW8w50A8S7oLkMA68rBJao/2cJl11gk5vq41KFj
         o0Zg==
X-Gm-Message-State: AOAM532PpFrvq1IdLKnQCzHUYZIL2RRLT418dxMLhqE+G/X+Of1NSfsh
        /xaA0pffVw+Hui/pxlSqGAor1CJOIDJDkTI=
X-Google-Smtp-Source: ABdhPJwNeslSipsEvLSi3Fhb2ny7o66d0r2EFJoRjTL5psoKrdCYQq7OkcMHfZtRNguGpXypg9taTa0BWE4xIqQ=
X-Received: from jimmyshiu.ntc.corp.google.com ([2401:fa00:fc:202:61eb:5079:5daf:1c89])
 (user=jimmyshiu job=sendgmr) by 2002:a25:5057:: with SMTP id
 e84mr42245627ybb.299.1635965240974; Wed, 03 Nov 2021 11:47:20 -0700 (PDT)
Date:   Thu,  4 Nov 2021 02:47:03 +0800
Message-Id: <20211103184708.1778294-1-jimmyshiu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] SCHED: attribute page lock and waitqueue functions as sched
From:   Jimmy Shiu <jimmyshiu@google.com>
To:     mingo@redhat.com
Cc:     jimmyshiu@google.com, joaodias@google.com, wvw@google.com,
        Minchan Kim <minchan@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_sched_blocked_trace in CFS is really useful for debugging via
trace because it tell where the process was stuck on callstack.

For example,
           <...>-6143  ( 6136) [005] d..2    50.278987: sched_blocked_reason: pid=6136 iowait=0 caller=SyS_mprotect+0x88/0x208
           <...>-6136  ( 6136) [005] d..2    50.278990: sched_blocked_reason: pid=6142 iowait=0 caller=do_page_fault+0x1f4/0x3b0
           <...>-6142  ( 6136) [006] d..2    50.278996: sched_blocked_reason: pid=6144 iowait=0 caller=SyS_prctl+0x52c/0xb58
           <...>-6144  ( 6136) [006] d..2    50.279007: sched_blocked_reason: pid=6136 iowait=0 caller=vm_mmap_pgoff+0x74/0x104

However, sometime it gives pointless information like this.
    RenderThread-2322  ( 1805) [006] d.s3    50.319046: sched_blocked_reason: pid=6136 iowait=1 caller=__lock_page_killable+0x17c/0x220
     logd.writer-594   (  587) [002] d.s3    50.334011: sched_blocked_reason: pid=6126 iowait=1 caller=wait_on_page_bit+0x194/0x208
  kworker/u16:13-333   (  333) [007] d.s4    50.343161: sched_blocked_reason: pid=6136 iowait=1 caller=__lock_page_killable+0x17c/0x220

Such wait_on_page_bit, __lock_page_killable are pointless because it doesn't
carry on higher information to identify the callstack.

The reason is page_lock and waitqueue are special synchronization method unlike
other normal locks(mutex, spinlock).
Let's mark them as "__sched" so get_wchan which used in trace_sched_blocked_trace
could detect it and skip them. It will produce more meaningful callstack
function like this.

           <...>-2867  ( 1068) [002] d.h4   124.209701: sched_blocked_reason: pid=329 iowait=0 caller=worker_thread+0x378/0x470
           <...>-2867  ( 1068) [002] d.s3   124.209763: sched_blocked_reason: pid=8454 iowait=1 caller=__filemap_fdatawait_range+0xa0/0x104
           <...>-2867  ( 1068) [002] d.s4   124.209803: sched_blocked_reason: pid=869 iowait=0 caller=worker_thread+0x378/0x470
 ScreenDecoratio-2364  ( 1867) [002] d.s3   124.209973: sched_blocked_reason: pid=8454 iowait=1 caller=f2fs_wait_on_page_writeback+0x84/0xcc
 ScreenDecoratio-2364  ( 1867) [002] d.s4   124.209986: sched_blocked_reason: pid=869 iowait=0 caller=worker_thread+0x378/0x470
           <...>-329   (  329) [000] d..3   124.210435: sched_blocked_reason: pid=538 iowait=0 caller=worker_thread+0x378/0x470
  kworker/u16:13-538   (  538) [007] d..3   124.210450: sched_blocked_reason: pid=6 iowait=0 caller=worker_thread+0x378/0x470

Test: build pass and boot to home.
Bug: 144961676
Bug: 144713689
Bug: 172212772
Signed-off-by: Minchan Kim <minchan@google.com>
Signed-off-by: Jimmy Shiu <jimmyshiu@google.com>
(cherry picked from commit 1e4de875d9e0cfaccf5131bcc709ae8646cdc168)
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 include/linux/pagemap.h | 17 +++++++++--------
 kernel/sched/wait.c     |  8 +++++---
 mm/filemap.c            | 14 +++++++-------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index db2c3e3eb1cf..12e82ff7686a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
 #include <linux/hugetlb_inline.h>
+#include <linux/sched/debug.h>
 
 struct pagevec;
 
@@ -687,7 +688,7 @@ static inline void folio_lock(struct folio *folio)
 /*
  * lock_page may only be called if we have the page's inode pinned.
  */
-static inline void lock_page(struct page *page)
+static inline __sched void lock_page(struct page *page)
 {
 	struct folio *folio;
 	might_sleep();
@@ -697,7 +698,7 @@ static inline void lock_page(struct page *page)
 		__folio_lock(folio);
 }
 
-static inline int folio_lock_killable(struct folio *folio)
+static inline __sched int folio_lock_killable(struct folio *folio)
 {
 	might_sleep();
 	if (!folio_trylock(folio))
@@ -710,7 +711,7 @@ static inline int folio_lock_killable(struct folio *folio)
  * signals.  It returns 0 if it locked the page and -EINTR if it was
  * killed while waiting.
  */
-static inline int lock_page_killable(struct page *page)
+static inline __sched int lock_page_killable(struct page *page)
 {
 	return folio_lock_killable(page_folio(page));
 }
@@ -722,7 +723,7 @@ static inline int lock_page_killable(struct page *page)
  * Return value and mmap_lock implications depend on flags; see
  * __folio_lock_or_retry().
  */
-static inline bool lock_page_or_retry(struct page *page, struct mm_struct *mm,
+static inline __sched bool lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				     unsigned int flags)
 {
 	struct folio *folio;
@@ -746,25 +747,25 @@ int folio_wait_bit_killable(struct folio *folio, int bit_nr);
  * ie with increased "page->count" so that the folio won't
  * go away during the wait..
  */
-static inline void folio_wait_locked(struct folio *folio)
+static inline __sched void folio_wait_locked(struct folio *folio)
 {
 	if (folio_test_locked(folio))
 		folio_wait_bit(folio, PG_locked);
 }
 
-static inline int folio_wait_locked_killable(struct folio *folio)
+static inline __sched int folio_wait_locked_killable(struct folio *folio)
 {
 	if (!folio_test_locked(folio))
 		return 0;
 	return folio_wait_bit_killable(folio, PG_locked);
 }
 
-static inline void wait_on_page_locked(struct page *page)
+static inline __sched void wait_on_page_locked(struct page *page)
 {
 	folio_wait_locked(page_folio(page));
 }
 
-static inline int wait_on_page_locked_killable(struct page *page)
+static inline __sched int wait_on_page_locked_killable(struct page *page)
 {
 	return folio_wait_locked_killable(page_folio(page));
 }
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 76577d1642a5..a5975579a741 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -404,7 +404,8 @@ void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_en
 }
 EXPORT_SYMBOL(finish_wait);
 
-int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
+__sched int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
+				     int sync, void *key)
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
@@ -440,7 +441,7 @@ static inline bool is_kthread_should_stop(void)
  * }						smp_mb(); // C
  * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |= WQ_FLAG_WOKEN;
  */
-long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
+__sched long wait_woken(struct wait_queue_entry *wq_entry, unsigned int mode, long timeout)
 {
 	/*
 	 * The below executes an smp_mb(), which matches with the full barrier
@@ -465,7 +466,8 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 }
 EXPORT_SYMBOL(wait_woken);
 
-int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
+__sched int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
+				int sync, void *key)
 {
 	/* Pairs with the smp_store_mb() in wait_woken(). */
 	smp_mb(); /* C */
diff --git a/mm/filemap.c b/mm/filemap.c
index bfcef6ff7a27..ad4268ee1bf1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1271,7 +1271,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
-static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
+static inline __sched int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
 	wait_queue_head_t *q = folio_waitqueue(folio);
@@ -1411,13 +1411,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
-void folio_wait_bit(struct folio *folio, int bit_nr)
+__sched void folio_wait_bit(struct folio *folio, int bit_nr)
 {
 	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
 }
 EXPORT_SYMBOL(folio_wait_bit);
 
-int folio_wait_bit_killable(struct folio *folio, int bit_nr)
+__sched int folio_wait_bit_killable(struct folio *folio, int bit_nr)
 {
 	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED);
 }
@@ -1628,21 +1628,21 @@ EXPORT_SYMBOL_GPL(page_endio);
  * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
  * @folio: The folio to lock
  */
-void __folio_lock(struct folio *folio)
+__sched void __folio_lock(struct folio *folio)
 {
 	folio_wait_bit_common(folio, PG_locked, TASK_UNINTERRUPTIBLE,
 				EXCLUSIVE);
 }
 EXPORT_SYMBOL(__folio_lock);
 
-int __folio_lock_killable(struct folio *folio)
+__sched int __folio_lock_killable(struct folio *folio)
 {
 	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
 					EXCLUSIVE);
 }
 EXPORT_SYMBOL_GPL(__folio_lock_killable);
 
-static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
+static __sched int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 {
 	struct wait_queue_head *q = folio_waitqueue(folio);
 	int ret = 0;
@@ -1679,7 +1679,7 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
  * with the folio locked and the mmap_lock unperturbed.
  */
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
+__sched bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 			 unsigned int flags)
 {
 	if (fault_flag_allow_retry_first(flags)) {
-- 
2.34.0.rc0.344.g81b53c2807-goog

