Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577AE32D8EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhCDRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhCDRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:46:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C78CC0613E0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:45:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m1so10509817wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDH4J7SZQSpfvAWXs9TcScn8FkbkQLdueDYOLKxIe6w=;
        b=yHyha/eYbZDOx+kHdx8YDXvC7A5fWOXcB8Hp9T6I/n7oMtsW1Po+g4TO700Dvaoths
         4i1VjGFSigw3r455/97KkFnOUnR6l/ndmaaj9B6sZjVjDTruPYPK3hBBC2fi+kHGdA0B
         mz2Ilzw67rTZ/BublTzRXM5ibSDPWcSUQcgS9omru02wlZ3NatOotn6xbPsJMtmqNqS8
         iy58YznI48kHFdN9v+p+vU0pl7Ua97hIrr5evLSERIDgEdhaJygM1EnKtn+xko6qYmxt
         jHA1qfZS8YDh1L7SO7dWpaVLe825QJTtoLA3B8e0uK0quBQlJFHg0TG5Cj5Pdy51dnTk
         crBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDH4J7SZQSpfvAWXs9TcScn8FkbkQLdueDYOLKxIe6w=;
        b=Z+jNB1BS7BkzmQXCn4RkAab5AhzHn6PwxmcquCpBDCgWj42xbSOeOEpxlfFfOfInL8
         tzU15O80OYJHhuN88C3j8q8CA2F6yaKNLg1QS6BaB1K7Enk5Sn6w+IVA+q/hJKkub08d
         Tyrcnm4rhW/YONbMqIiyp2wc5MS7Q6vFthMN0j7qxd3GOamy3OqyuuN+CFXzde7C36UP
         H+Zm8vlp87pOJ4xkvsnnfWXYDtGZe7Cbk7MDxKRdEkc/gOIyAgaBppn7g+4LkT3UyJSz
         HJytntPIVhQlRvrJ+s/8L+Otrw9HU0BxvQmtcy4qxtLkd3XVBeoYoLX50src63XoUujc
         Kksw==
X-Gm-Message-State: AOAM530QfZTqO48zYgSHo15V37onb9WgLBns7VSNThC3WYUFWQxSisfV
        rWZZXIKqwCIHTshDjMEAe5rojQ==
X-Google-Smtp-Source: ABdhPJy3Br9YWrL8pTB2IvtICU1WoVDG6XWXnDgdCki+t/lGxLtpgmkmwmo0/R0uBQ+hmWh3iElPPA==
X-Received: by 2002:a1c:804e:: with SMTP id b75mr5112811wmd.113.1614879927639;
        Thu, 04 Mar 2021 09:45:27 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:27 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 2/6] block, bfq: put reqs of waker and woken in dispatch list
Date:   Thu,  4 Mar 2021 18:46:23 +0100
Message-Id: <20210304174627.161-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a new I/O request that arrives for a bfq_queue bfqq. If, when
this happens, the only active bfq_queues are bfqq and either its waker
bfq_queue or one of its woken bfq_queues, then there is no point in
queueing this new I/O request in bfqq for service. In fact, the
in-service queue and bfqq agree on serving this new I/O request as
soon as possible. So this commit puts this new I/O request directly
into the dispatch list.

Tested-by: Jan Kara <jack@suse.cz>
Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a83149407336..a9c1a14b64f4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5640,7 +5640,49 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
+
+	/*
+	 * Reqs with at_head or passthrough flags set are to be put
+	 * directly into dispatch list. Additional case for putting rq
+	 * directly into the dispatch queue: the only active
+	 * bfq_queues are bfqq and either its waker bfq_queue or one
+	 * of its woken bfq_queues. The rationale behind this
+	 * additional condition is as follows:
+	 * - consider a bfq_queue, say Q1, detected as a waker of
+	 *   another bfq_queue, say Q2
+	 * - by definition of a waker, Q1 blocks the I/O of Q2, i.e.,
+	 *   some I/O of Q1 needs to be completed for new I/O of Q2
+	 *   to arrive.  A notable example of waker is journald
+	 * - so, Q1 and Q2 are in any respect the queues of two
+	 *   cooperating processes (or of two cooperating sets of
+	 *   processes): the goal of Q1's I/O is doing what needs to
+	 *   be done so that new Q2's I/O can finally be
+	 *   issued. Therefore, if the service of Q1's I/O is delayed,
+	 *   then Q2's I/O is delayed too.  Conversely, if Q2's I/O is
+	 *   delayed, the goal of Q1's I/O is hindered.
+	 * - as a consequence, if some I/O of Q1/Q2 arrives while
+	 *   Q2/Q1 is the only queue in service, there is absolutely
+	 *   no point in delaying the service of such an I/O. The
+	 *   only possible result is a throughput loss
+	 * - so, when the above condition holds, the best option is to
+	 *   have the new I/O dispatched as soon as possible
+	 * - the most effective and efficient way to attain the above
+	 *   goal is to put the new I/O directly in the dispatch
+	 *   list
+	 * - as an additional restriction, Q1 and Q2 must be the only
+	 *   busy queues for this commit to put the I/O of Q2/Q1 in
+	 *   the dispatch list.  This is necessary, because, if also
+	 *   other queues are waiting for service, then putting new
+	 *   I/O directly in the dispatch list may evidently cause a
+	 *   violation of service guarantees for the other queues
+	 */
+	if (!bfqq ||
+	    (bfqq != bfqd->in_service_queue &&
+	     bfqd->in_service_queue != NULL &&
+	     bfq_tot_busy_queues(bfqd) == 1 + bfq_bfqq_busy(bfqq) &&
+	     (bfqq->waker_bfqq == bfqd->in_service_queue ||
+	      bfqd->in_service_queue->waker_bfqq == bfqq)) ||
+	    at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
-- 
2.20.1

