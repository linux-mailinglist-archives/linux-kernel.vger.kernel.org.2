Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3147635D910
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbhDMHhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbhDMHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292FAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t22so11347449pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCKRFEgUpiSZnyvhqWbfeUOxEPSplouj1i6gzC00/Qo=;
        b=sZmPDpuGq8P6JHiVP10ktXD3J1hHUjjBWdc5MuRltZLVTLQSevwcIQWZh14wbs201g
         VzR/mKQKoOyJ9drr+Nub86FDeU/IKDNzZ4nqVbjprIFrrPWrbPmjuT0UMOw0opHuwJ+2
         PRuKYFpG9+BAsT3/J0w6eydnlSGKyQ7D8FTSWxxBjUoCwsdUJbWjuml1UnghgoSGC4Wr
         d/HJwhtnfk7ihORKxdigAOSfJdWdVP5FtVFI/WfgveprmB4kjG/O0t9xSq3CFue6iiC1
         OY5F/qEjq7OaRIuiePAm0iwDGbh1zL9YDpMwStoLm1XIuToWpmhwy47ShPO9qsBpq6vS
         dVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCKRFEgUpiSZnyvhqWbfeUOxEPSplouj1i6gzC00/Qo=;
        b=fdF2/Zau2ciHOyn8S1y4HeDkCoz79+rHbuEnr9ILUY1YhyDZCmBSP9yYbYXDXuQUIb
         hZk5rvflUlmMwAefF4olgTb2+yZUAUPhpDyvTrSMEFZrolSmYMyHM1agAUKrg3xVh59R
         HLRUKOvWqpPAsiIzLtj5LOB6999nssmiHyCqFLgRAFeJNdula9Hf3VSCYBt6QHCB65lC
         7W9d3xZ219z/lWoTtCUoxh42sCf7YDFeVeVQvK5/XOIKCI2fS86BLQrcKk6ekEM4re6q
         FUE7Z0Kn6UeubSDT5q5CaKWpUeJrwS1/18T9jgS6yIXE+RO410KfnYiPnSpE1GOZOEXU
         nIzA==
X-Gm-Message-State: AOAM53063u4bn4fDgipnDHKdZGE+wFt4zgH126TZ57Tnti3d/U7mVbPo
        L4JJ8qArc/TkUuDbr3yf7+k=
X-Google-Smtp-Source: ABdhPJyAvcovQ/pdTtRLlUrG/7tY7en9bVfTPSmBVlsId646VKyTaWufGjGPpH0HyUM24sSMgllMJw==
X-Received: by 2002:a63:770e:: with SMTP id s14mr29883864pgc.377.1618299429697;
        Tue, 13 Apr 2021 00:37:09 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:71d7:d843:bfe8:bec7])
        by smtp.gmail.com with ESMTPSA id a3sm1349068pjq.36.2021.04.13.00.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:37:09 -0700 (PDT)
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
Subject: [PATCH 3/3] rseq: optimise for 64bit arches
Date:   Tue, 13 Apr 2021 00:36:57 -0700
Message-Id: <20210413073657.2308450-4-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413073657.2308450-1-eric.dumazet@gmail.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
update includes") added regressions for our servers.

Using copy_from_user() and clear_user() for 64bit values
on 64bit arches is suboptimal.

We might revisit this patch once all 32bit arches support
get_user() and/or put_user() for 8 bytes values.

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
index 57344f9abb43905c7dd2b6081205ff508d963e1e..18a75a804008d2f564d1f7789f09216f1a8760bd 100644
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
+	return put_user(0ULL, &t->rseq->rseq_cs.ptr64);
+#else
 	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
 		return -EFAULT;
 	return 0;
+#endif
 }
 
 /*
-- 
2.31.1.295.g9ea45b61b8-goog

