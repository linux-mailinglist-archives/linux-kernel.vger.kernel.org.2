Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22DE35E7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348246AbhDMUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348236AbhDMUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:34:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DDEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:34:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k8so12785755pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81y+EC7pIF8y5UKkIQSpeq/KDuFtEJPwnzsco6+4ni4=;
        b=awMMzC/CCkUo6Ao0tgUm3H8lBruMsIP08vOYC+uTTmvDaF5I+OvfP5ZiaIv5AGjley
         Bx+qXOYcZVteKvz+JYdhOfBo2MQTO0xPS1jHqzzhO8t1mRZNuDkZwHemG+OLd50ZlJkO
         y8tT64x9lJj+pZcct51S2MLsFP8HrGNWWBJSPte7KOjLhprbESfEo2O/+olRe680WMMi
         z28qwP3mnFDpDYyxzkpFVqr3KPaFq6VsN7dW9hFuR37zSN5Pzk2gTrTqWhmcFLTJycvm
         AYZn5u0EhWtjG5MqEMhIrhhU2cfOuotsfKvtmX3T7KSdBKrqSvj0/bwc8SnX8+Cid1rM
         3X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81y+EC7pIF8y5UKkIQSpeq/KDuFtEJPwnzsco6+4ni4=;
        b=BpupPuRd6+Dl0G0b6V4WQeA+S4kWjLBqWHbg51DfT8peFbt6R6kq/7YHFTH34YAuZq
         fR86q8MVRO/qee4VFcyFC23JjWTb3bE36Bfw89mS/f0k/FbO5HHxl3VkRdHWLIyWwzV4
         B1jmS3cfHvgliPXeZDYnafUlL+M6fXnl2gxluSKXaQ49iBuftHKPkV0YzAaMl3rmYAhD
         vI3n/sOoFPOL5e7lwmu4sBYwz12PnBB3cxFW9zW0DPDfHWmJy3mtsxk5jOUG6XqEW/mI
         f2PeI5S3nnkGbns+TDJth3JBNHT6ch1Pm09buN5mmwslaeTBVGUbxzcWooa1SA8jWfzf
         z3Aw==
X-Gm-Message-State: AOAM532L4WIY8gIfVXAuWXRp2bEDYXvyFLXuxtHjULz3l2AeJjMrbCC6
        HSmBjfKr055kfPfH04HPSeQ=
X-Google-Smtp-Source: ABdhPJxeWuK/UJOP/lEAJrPNpzI1wRlIWumXRXZMqylG4p8LvUdpADREUjVmUBw9kjZcsr2M76P5FA==
X-Received: by 2002:a63:b59:: with SMTP id a25mr33705878pgl.235.1618346042896;
        Tue, 13 Apr 2021 13:34:02 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:a476:17ee:13ea:2981])
        by smtp.gmail.com with ESMTPSA id 20sm89970pfw.40.2021.04.13.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:34:02 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH v3 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
Date:   Tue, 13 Apr 2021 13:33:52 -0700
Message-Id: <20210413203352.71350-4-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413203352.71350-1-eric.dumazet@gmail.com>
References: <20210413203352.71350-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
update includes") added regressions for our servers.

Using copy_from_user() and clear_user() for 64bit values
is suboptimal.

We can use faster put_user() and get_user() on 64bit arches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index cfe01ab5253c1c424c0e8b25acbb6a8e1b41a5b6..35f7bd0fced0e2dd8aed819e054dac03f024388a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -127,8 +127,13 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
+#ifdef CONFIG_64BIT
+	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
+		return -EFAULT;
+#else
 	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
 		return -EFAULT;
+#endif
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
@@ -211,9 +216,13 @@ static int clear_rseq_cs(struct task_struct *t)
 	 *
 	 * Set rseq_cs to NULL.
 	 */
+#ifdef CONFIG_64BIT
+	return put_user(0UL, &t->rseq->rseq_cs.ptr64);
+#else
 	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
 		return -EFAULT;
 	return 0;
+#endif
 }
 
 /*
-- 
2.31.1.295.g9ea45b61b8-goog

