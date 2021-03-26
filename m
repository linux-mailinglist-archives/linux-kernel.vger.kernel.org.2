Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1779034ABFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCZPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhCZPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:52:14 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k8so5828846iop.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxQIrqL1e1bv0TRTUopnjE8m4DjY4XOhdCxrLXbG/MQ=;
        b=Ryt6S/JZtVfje1gjWOS/t0o0Wh1W0sKRoPp86aSmIEzuLprM33JiAcTE8SCHUpn8bU
         GxwTJC5xSyGSNDdEFKQoXnx7M0etduPePYTTLsLX3Q3gqvAkmLqkv/V0Y32iYqlK+U2p
         59UYoFxpZjJqaRX/YGLHK4v842D7mbC4Pif+1t3OqAncjMq7igH+y/zmm5VeGB6OpZz4
         yNyovWpB2VzkHc60Mi1iMjrUb7qjrQ7BcGdddY9aR08bX0JqGotZZ1LGcU8HAL6N5WrB
         sOEcN/bk3ljBw9Jrq4d+qhtFYee7iOqQlC0Q76Q3tfYfRxti61s1hoD04CmSWHkyC23u
         SboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxQIrqL1e1bv0TRTUopnjE8m4DjY4XOhdCxrLXbG/MQ=;
        b=LHlJmeRApWrhXkfPFh0+iMKcOfheGRR7HFwxjIlj8Cjo/MkdIAz+2DYU7+Fhjorp2b
         wktLKcYGb+Yg+9CW4Gl5Mx5NkMYcSZEX0Jpj+dTz1CjUUPex3JVsot4aYpysBTPmB/gv
         PPJpOm4qaUl/i8J4khem8oGgrUroDqIlEnNu4kkWRVZ4SVXe3Tt+IjCC1Fd39gx39fNL
         rfnSzX4MAFPx7mjAAzNYhdtd5nIeznnTTA1/WqtWiZYv84bhm9d7DtF+qwXNuDJaepqA
         wRawf7frVtN1Bz986ndAJwQ+NvON+FpeAt70ZOWhNGvcXrYbSl3a/53dc6cOEuYZ5hAq
         3UkQ==
X-Gm-Message-State: AOAM531400ZXr9WTPChpmkrz7QBfTAype3qKPv2chm3gemYJoJTNHYu/
        /LB1RBWnXA5ZV91g29PDsqstiaGW1Dd0Yg==
X-Google-Smtp-Source: ABdhPJxxGXzjendQFH5f3P7Q/JmG83kJRw4+RWa9A+cP3R9et+07qPBusau4Y00kjMT+xXF8fisl8w==
X-Received: by 2002:a05:6638:2101:: with SMTP id n1mr12853547jaj.7.1616773933951;
        Fri, 26 Mar 2021 08:52:13 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm4456337ilj.64.2021.03.26.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:52:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/10] io_uring: do post-completion chore on t-out cancel
Date:   Fri, 26 Mar 2021 09:51:26 -0600
Message-Id: <20210326155128.1057078-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
References: <20210326155128.1057078-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Don't forget about io_commit_cqring() + io_cqring_ev_posted() after
exit/exec cancelling timeouts. Both functions declared only after
io_kill_timeouts(), so to avoid tons of forward declarations move
it down.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/72ace588772c0f14834a6a4185d56c445a366fb4.1616696997.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4d0cb2548a67..69896ae204d6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1262,26 +1262,6 @@ static void io_kill_timeout(struct io_kiocb *req, int status)
 	}
 }
 
-/*
- * Returns true if we found and killed one or more timeouts
- */
-static bool io_kill_timeouts(struct io_ring_ctx *ctx, struct task_struct *tsk,
-			     struct files_struct *files)
-{
-	struct io_kiocb *req, *tmp;
-	int canceled = 0;
-
-	spin_lock_irq(&ctx->completion_lock);
-	list_for_each_entry_safe(req, tmp, &ctx->timeout_list, timeout.list) {
-		if (io_match_task(req, tsk, files)) {
-			io_kill_timeout(req, -ECANCELED);
-			canceled++;
-		}
-	}
-	spin_unlock_irq(&ctx->completion_lock);
-	return canceled != 0;
-}
-
 static void __io_queue_deferred(struct io_ring_ctx *ctx)
 {
 	do {
@@ -8612,6 +8592,28 @@ static void io_ring_exit_work(struct work_struct *work)
 	io_ring_ctx_free(ctx);
 }
 
+/* Returns true if we found and killed one or more timeouts */
+static bool io_kill_timeouts(struct io_ring_ctx *ctx, struct task_struct *tsk,
+			     struct files_struct *files)
+{
+	struct io_kiocb *req, *tmp;
+	int canceled = 0;
+
+	spin_lock_irq(&ctx->completion_lock);
+	list_for_each_entry_safe(req, tmp, &ctx->timeout_list, timeout.list) {
+		if (io_match_task(req, tsk, files)) {
+			io_kill_timeout(req, -ECANCELED);
+			canceled++;
+		}
+	}
+	io_commit_cqring(ctx);
+	spin_unlock_irq(&ctx->completion_lock);
+
+	if (canceled != 0)
+		io_cqring_ev_posted(ctx);
+	return canceled != 0;
+}
+
 static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 {
 	unsigned long index;
-- 
2.31.0

