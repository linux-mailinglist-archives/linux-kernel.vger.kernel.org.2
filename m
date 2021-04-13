Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6F35E3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbhDMQYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:24:14 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42588 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbhDMQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:24:05 -0400
Received: by mail-pg1-f180.google.com with SMTP id g35so12270524pgg.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myAv69MaFRKWn2I2SW1R2lECVQNHL7kM1EUxjGkHBlQ=;
        b=oGJsz6THEkUmu6g0msyh2jGLGrJu8yfMEfsQK09Pcppqy1roF2NR0hk5Lb/mnInxkM
         Mb9bvlJoqJ9fJ9aekXnq0qAE9jcQVe8f+FqaJjr3rJugVJIiKy+E4jt6+VThoSmbvQbb
         7L31Bbfce313S9AaK1/uiTtDi01lNrXXSLuRSpblDTihdTBeIVvAyV1V19U46Q/7AZf5
         q9TbnDFYuTmJpx5k9zRyvsUojW1pPBRhy2+ilZErVt64qmYyjWd4NEdX531aWLtNTK4+
         ovuObeCfVBPiP6dxx38R+G5MseGGiWNuvLQcKhmnXowOXh7M9AeKw80E99QNmmK1GyCt
         EQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myAv69MaFRKWn2I2SW1R2lECVQNHL7kM1EUxjGkHBlQ=;
        b=uYUuVLkPES18jHnIwOsxLrDUWmYLfezrCK25oI2kOiHSlfu0guCZQEjAk5urSTvS/l
         Tc+J3tK9uGk5sU6JqotjwAJoUDR3YlB3yarOylUO11TguHCto1sBLQRDsuJwkv6UNRnk
         xhSBLfvV76xWf/XtDEUlDinlN5FMpRedDyXyc56Ad8tbtiy1K3AX3HsXyLDGuTHXpCmu
         XNLZbc3YjBopn+6etFjgBHCHoa2v0lz021KxKiGHqsljctNLZIbRFBUw0rfQIG5dXRzo
         R2UvJVRPADB2Y/YFAZNklOciDlH5bE5cZ1dHG2KprlOhayreAW0W6NXO/U9rHhGoy00X
         Lang==
X-Gm-Message-State: AOAM532bp/hbrLuEJ7UXiUSknOgLsIu5i8LIYCMS21WwH2sKo8sOD+w3
        N/mPPwXdMD4JOHSav/d7EMQ=
X-Google-Smtp-Source: ABdhPJwQi9mr5U6edH0lo57bbRVeP6zWUW8Dx5z496iCDv2DmUIXXoUrNrWjTTeU13+CMVszBc/pug==
X-Received: by 2002:a63:4c4:: with SMTP id 187mr33036304pge.187.1618330966051;
        Tue, 13 Apr 2021 09:22:46 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:485b:46b2:8be1:2cdd])
        by smtp.gmail.com with ESMTPSA id l25sm15897591pgu.72.2021.04.13.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:22:45 -0700 (PDT)
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
Subject: [PATCH v2 1/3] rseq: optimize rseq_update_cpu_id()
Date:   Tue, 13 Apr 2021 09:22:37 -0700
Message-Id: <20210413162240.3131033-2-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413162240.3131033-1-eric.dumazet@gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Two put_user() in rseq_update_cpu_id() are replaced
by a pair of unsafe_put_user() with appropriate surroundings.

This removes one stac/clac pair on x86 in fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937cdfa2f13d1dcc9be863c1943d06f..f020f18f512a3f6241c3c9b104ce50e4d2c6188c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -84,13 +84,20 @@
 static int rseq_update_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id = raw_smp_processor_id();
+	struct rseq __user *rseq = t->rseq;
 
-	if (put_user(cpu_id, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	if (put_user(cpu_id, &t->rseq->cpu_id))
-		return -EFAULT;
+	if (!user_write_access_begin(rseq, sizeof(*rseq)))
+		goto efault;
+	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
+	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	user_write_access_end();
 	trace_rseq_update(t);
 	return 0;
+
+efault_end:
+	user_write_access_end();
+efault:
+	return -EFAULT;
 }
 
 static int rseq_reset_rseq_cpu_id(struct task_struct *t)
-- 
2.31.1.295.g9ea45b61b8-goog

