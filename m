Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C735E3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbhDMQYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:24:19 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34350 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbhDMQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:24:10 -0400
Received: by mail-pg1-f173.google.com with SMTP id z16so12298218pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0NH091hlOEGo2k1LU5ohgxNdrJbRmnGLPhBDFB+CKg=;
        b=VfiO1Okw9IvrIfiX2ZwfXq/v62Njw/OjMUVCtg4KGkISVrnxMn0FKeJkqiBDfN2TRR
         JRfNbdDslcOGJ+nVbqlnwQlaAanw8tqOwoXn+OPMNOeWpc3TL/fXfZynAO6YyemKYLM2
         rVYjz02Ci/SeE9dTx9Vlw6O8jkaOb5DeN7iFXyST3fS+K+FoKnpxIdIBUOM98HVmK3JX
         q/0cn2IaAjT9uDYEKhxSgrBpQOiFJ3/boEH3EK0AjPvs67SsKgxrmA4WvAXe8LM0kVhH
         i/0FaGJTsFj/lhsGBisDZ3JcdCyzDtWKhwPuGW43e1PUpKsfQk2BvDQOrL1uW5Sp8T4Z
         Z1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0NH091hlOEGo2k1LU5ohgxNdrJbRmnGLPhBDFB+CKg=;
        b=QqIUsPZWgtBU6F4sNoHIaKj2rdHItrOe6jmVuNlH4IMMrTPMAoNRL3oX/1icZq4rPa
         +jCHjmPGjxq49c2ZYK7F5Yrvsh9uFuELqV7Ut8xlIZdAaKVimIMsDvyqCzAX18CJr39T
         rFUYdOFsoZhTlBOaqLq+3u1xLqCeHqTkkFvCZJvkseDi0ba1eI3ZiqJ/ZfDH6RvgiBAA
         e7e/9GQ7/caWCHy2kvb7q6RkQqnpyvYCF7fFZu7Y+0skUPTq/nEr3Ocg0E1/8tYUb4S7
         YWGnr9MibNaUHk0v/LeJZKO3DQ1bx3wB4YFtMBdZJhVm3di3F1i6tZaxqe45PlypMYB0
         32xw==
X-Gm-Message-State: AOAM533Z2NYhK9HyVrw/3V8SzFKezgIHgfCvrnj7jfwKF0EQEP7t/2XN
        TZABwpEn4nfYwdFQBuGAhtk=
X-Google-Smtp-Source: ABdhPJyJm4FnCbHXtYlooY+QR1QLo4IlPJV/pyF79KsxfXAbS9uj9JkzyRZaJnpWfO6v9KojT8Y3hw==
X-Received: by 2002:a63:4f0a:: with SMTP id d10mr33383231pgb.418.1618330970580;
        Tue, 13 Apr 2021 09:22:50 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:485b:46b2:8be1:2cdd])
        by smtp.gmail.com with ESMTPSA id l25sm15897591pgu.72.2021.04.13.09.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:22:50 -0700 (PDT)
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
Subject: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
Date:   Tue, 13 Apr 2021 09:22:39 -0700
Message-Id: <20210413162240.3131033-4-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413162240.3131033-1-eric.dumazet@gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
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

We can use faster put_user() and get_user().

32bit arches can be changed to use the ptr32 field,
since the padding field must always be zero.

v2: added ideas from Peter and Mathieu about making this
    generic, since my initial patch was only dealing with
    64bit arches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index cfe01ab5253c1c424c0e8b25acbb6a8e1b41a5b6..f2eee3f7f5d330688c81cb2e57d47ca6b843873e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -119,23 +119,46 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	return 0;
 }
 
+#ifdef CONFIG_64BIT
+static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
+			   const struct rseq __user *rseq)
+{
+	u64 ptr;
+
+	if (get_user(ptr, &rseq->rseq_cs.ptr64))
+		return -EFAULT;
+	*uptrp = (struct rseq_cs __user *)ptr;
+	return 0;
+}
+#else
+static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
+			   const struct rseq __user *rseq)
+{
+	u32 ptr;
+
+	if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
+		return -EFAULT;
+	*uptrp = (struct rseq_cs __user *)ptr;
+	return 0;
+}
+#endif
+
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
-	u64 ptr;
 	u32 __user *usig;
 	u32 sig;
 	int ret;
 
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
+	if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
 		return -EFAULT;
-	if (!ptr) {
+	if (!urseq_cs) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
-	if (ptr >= TASK_SIZE)
+	if ((unsigned long)urseq_cs >= TASK_SIZE)
 		return -EINVAL;
-	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
+
 	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
 		return -EFAULT;
 
@@ -211,9 +234,11 @@ static int clear_rseq_cs(struct task_struct *t)
 	 *
 	 * Set rseq_cs to NULL.
 	 */
-	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
-		return -EFAULT;
-	return 0;
+#ifdef CONFIG_64BIT
+	return put_user(0UL, &t->rseq->rseq_cs.ptr64);
+#else
+	return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
+#endif
 }
 
 /*
-- 
2.31.1.295.g9ea45b61b8-goog

