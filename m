Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA837F40A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhEMIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEMIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:31:09 -0400
X-Greylist: delayed 81 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 May 2021 01:29:58 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:29:58 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7D0552E1646;
        Thu, 13 May 2021 11:28:32 +0300 (MSK)
Received: from sas1-9d43635d01d6.qloud-c.yandex.net (sas1-9d43635d01d6.qloud-c.yandex.net [2a02:6b8:c08:793:0:640:9d43:635d])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id DRnUePjphG-SW0K3JeK;
        Thu, 13 May 2021 11:28:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1620894512; bh=Re5L6IH5sRAPrdMu6Ln7MBbzAnKR1RoRYEJdsPrY9mQ=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=BytwSAFaccYIxnorKknoKWG1tTIIkwZ44b6CPRoQ3i0QM0cxvm8StQpmbGXeXTYMV
         1G1moHbhv8EKOiI9whjYqO1511quLztCovY04DjmvarFgr8zBnyNu2LjaweNP2v/vz
         UFbt0+jw4A+NmH0tTUoBzqm+1emHbEwCpiJUacJg=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-9d43635d01d6.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id X7bKlnxYz2-SWpKVh3F;
        Thu, 13 May 2021 11:28:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, tj@kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] blk-throttle: fix race between submitter and throttler thread
Date:   Thu, 13 May 2021 08:28:27 +0000
Message-Id: <20210513082827.1818-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we call bio_set_flag(bio, BIO_THROTTLED) unconditionally
at the end of blk_throtl_bio w/o queue_lock. But once we drop queue_lock,
bio may already be processed by thottler thread, so both threads
may update bio->flags concurently

Dipite that race window is tiny, it happens in real life under heavy load.
It looks like follows:

SUBMITTER_THREAD (CPU1)                  THROTTLER_THREAD (CPU2)
 ->blk_throtl_bio
   ->throtl_add_bio_tg
(1)   bio_set_flag(bio, BIO_THROTTLED);
   spin_unlock_irq(q->queue_lock);
                                         ->blk_throtl_dispatch_work_fn
                                          (2)spin_lock_irq(q->queue_lock);
					   ->generic_make_request
					     ->blk_queue_split
                                               (3)bio_set_flag(bio, BIO_CHAINED)

(4) bio_set_flag(bio, BIO_THROTTLED);

Since bio->bi_flags is not atomic it will be cached on each CPU
CPU1 will cache it at the step (1), and changes from step(3) is not visiable,
so BIO_CHAINED flag will be lost and rewritten at step(4).
This result in ->bi_end_io() will be called multiple times once for each
chained bio and once for parent bio.

Bug#2: submit_bio_checks() call blkcg_bio_issue_init() for throttled bio,
but at this moment bio may be already be completed and freed by throttler thread

In order to fix both issues we should modify throttled bio under queue_lock only.

Fixes: 111be88398174 ("block-throttle: avoid double charge")
Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

diff --git a/block/bio.c b/block/bio.c
index 50e579088aca..96e6cf7793f2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -277,6 +277,8 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
 
+	BUG_ON(!bio_flagged(parent, BIO_CHAIN));
+
 	if (bio->bi_status && !parent->bi_status)
 		parent->bi_status = bio->bi_status;
 	bio_put(bio);
diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..edc49e097ba1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -886,7 +886,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		create_task_io_context(current, GFP_ATOMIC, q->node);
 
 	if (blk_throtl_bio(bio)) {
-		blkcg_bio_issue_init(bio);
 		return false;
 	}
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b1b22d863bdf..5808bbd7df26 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2170,10 +2170,19 @@ static void throtl_update_latency_buckets(struct throtl_data *td)
 			td->avg_buckets[WRITE][i].latency,
 			td->avg_buckets[WRITE][i].valid);
 }
+
+static inline void throtl_bio_skip_latency(struct bio *bio)
+{
+	bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
+}
 #else
 static inline void throtl_update_latency_buckets(struct throtl_data *td)
 {
 }
+
+static inline void throtl_bio_skip_latency(struct bio *bio)
+{
+}
 #endif
 
 bool blk_throtl_bio(struct bio *bio)
@@ -2187,20 +2196,26 @@ bool blk_throtl_bio(struct bio *bio)
 	bool throttled = false;
 	struct throtl_data *td = tg->td;
 
-	rcu_read_lock();
+	if (!td->track_bio_latency)
+		throtl_bio_skip_latency(bio);
 
 	/* see throtl_charge_bio() */
 	if (bio_flagged(bio, BIO_THROTTLED))
-		goto out;
+		return false;
 
+	rcu_read_lock();
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
 		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
 		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
 	}
 
-	if (!tg->has_rules[rw])
-		goto out;
+
+	if (!tg->has_rules[rw]) {
+		bio_set_flag(bio, BIO_THROTTLED);
+		rcu_read_unlock();
+		return false;
+	}
 
 	spin_lock_irq(&q->queue_lock);
 
@@ -2270,6 +2285,8 @@ bool blk_throtl_bio(struct bio *bio)
 
 	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
+	blkcg_bio_issue_init(bio);
+	throtl_bio_skip_latency(bio);
 	throttled = true;
 
 	/*
@@ -2284,15 +2301,15 @@ bool blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
+	if (!bio_flagged(bio, BIO_THROTTLED))
+		bio_set_flag(bio, BIO_THROTTLED);
+	/*
+	 * Once we drop ->queue_lock it is unsafe to touch current bio,
+	 * because it may be already handled by throttler thread.
+	 */
 	spin_unlock_irq(&q->queue_lock);
-out:
-	bio_set_flag(bio, BIO_THROTTLED);
-
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (throttled || !td->track_bio_latency)
-		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
-#endif
 	rcu_read_unlock();
+
 	return throttled;
 }
 
-- 
2.7.4

