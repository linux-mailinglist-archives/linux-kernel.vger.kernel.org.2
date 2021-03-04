Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3B32D8EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhCDRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbhCDRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:46:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B9C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:45:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u125so10479554wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpdNy3aVzBPLz4zskOuLUeTUqeMtI64LdXSnJTLPY1g=;
        b=GPkvXnFiKfBcww25//CHtxNQHCRJwuNcosNdpu4fIPtjSdJsiRTpdfPS7OdamfBEO5
         JbNRTznkyntl0F3NmCUPktJDKDXVvjv9892sOs8/9WUntPeef64/XAe82HKosaoJeWQR
         fPUZq94AX1RrLkujTJYL39lQGKoSYJGymoYluRIrOASVQNI22kv9UKU2TBCIEXSrYvfM
         nWq5UcU+IuoxseNVq908TpzcsaAOf/4+QhhnVWjbOOGzIvLE2VJcYknpJEZ81CTWr0Ja
         3PGkLPHvHccJgxaPZ2sAMUlIIf4t29n/B8oKSZxuZ3bYirE2NafJd+EJ4rFyTOSTqGmP
         yPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpdNy3aVzBPLz4zskOuLUeTUqeMtI64LdXSnJTLPY1g=;
        b=YzhIayLeiDrUSgsz8I06VKt3kDM/NtfKSLL171WFnl4lH9OP8J9cKY1OmO3N/T8Qyj
         AYmwFH/trp0ubCgXFeCmE4ZGtNB8AK6FcrJswAalVF3bwF9pfF6Ar8F6XmP2gWFgvP+W
         /EWZtQs759BVYlNqHTMRmz1YsxkV9g4NMmQUdCtEOOykL+0yn9lL8c4hpqkl4lTmedAl
         MvhI0e1IWquuAafL7DDHuRHfAZ4eLaPJJH713SEqs+oO2DO/t/x/lwrV/XnjkyhmoK9A
         mp5TFW1CNinYko9vTCb4jEUugCr/zHceq9NK8xMD756ITNhkL1wWo75AkCLSW4P89zY1
         FIeA==
X-Gm-Message-State: AOAM530u0eqy3qFCb4RTDPMUJFv9rVtKxFz+EJOiMlsuLtbUWa85YM3d
        bvgk2KJbNTF89juFVxJb4KGRKg==
X-Google-Smtp-Source: ABdhPJyJD+YF0j69T7Vwu87133tqy5JdmSjbivAHfFXRLXHtYkNix+8sy7MhVcPQIAlga48QsZSKDw==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr5180733wmk.82.1614879929196;
        Thu, 04 Mar 2021 09:45:29 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:28 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 3/6] block, bfq: make shared queues inherit wakers
Date:   Thu,  4 Mar 2021 18:46:24 +0100
Message-Id: <20210304174627.161-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a bfq_queue bfqq that is about to be merged with another
bfq_queue new_bfqq. The processes associated with bfqq are cooperators
of the processes associated with new_bfqq. So, if bfqq has a waker,
then it is reasonable (and beneficial for throughput) to assume that
all these processes will be happy to let bfqq's waker freely inject
I/O when they have no I/O. So this commit makes new_bfqq inherit
bfqq's waker.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a9c1a14b64f4..4b3d4849f3f5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2819,6 +2819,29 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		bfq_mark_bfqq_IO_bound(new_bfqq);
 	bfq_clear_bfqq_IO_bound(bfqq);
 
+	/*
+	 * The processes associated with bfqq are cooperators of the
+	 * processes associated with new_bfqq. So, if bfqq has a
+	 * waker, then assume that all these processes will be happy
+	 * to let bfqq's waker freely inject I/O when they have no
+	 * I/O.
+	 */
+	if (bfqq->waker_bfqq && !new_bfqq->waker_bfqq &&
+	    bfqq->waker_bfqq != new_bfqq) {
+		new_bfqq->waker_bfqq = bfqq->waker_bfqq;
+		new_bfqq->tentative_waker_bfqq = NULL;
+
+		/*
+		 * If the waker queue disappears, then
+		 * new_bfqq->waker_bfqq must be reset. So insert
+		 * new_bfqq into the woken_list of the waker. See
+		 * bfq_check_waker for details.
+		 */
+		hlist_add_head(&new_bfqq->woken_list_node,
+			       &new_bfqq->waker_bfqq->woken_list);
+
+	}
+
 	/*
 	 * If bfqq is weight-raised, then let new_bfqq inherit
 	 * weight-raising. To reduce false positives, neglect the case
@@ -6303,7 +6326,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq)) {
-			bfq_log_bfqq(bfqd, bfqq, "breaking apart bfqq");
+			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
@@ -6312,11 +6335,24 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
 
-			if (!bfqq)
+			if (!bfqq) {
 				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
 								 true, is_sync,
 								 NULL);
-			else
+				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
+				bfqq->tentative_waker_bfqq = NULL;
+
+				/*
+				 * If the waker queue disappears, then
+				 * new_bfqq->waker_bfqq must be
+				 * reset. So insert new_bfqq into the
+				 * woken_list of the waker. See
+				 * bfq_check_waker for details.
+				 */
+				if (bfqq->waker_bfqq)
+					hlist_add_head(&bfqq->woken_list_node,
+						       &bfqq->waker_bfqq->woken_list);
+			} else
 				bfqq_already_existing = true;
 		}
 	}
-- 
2.20.1

