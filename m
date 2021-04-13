Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082FE35E7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348228AbhDMUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348208AbhDMUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:34:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F880C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:33:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l76so12783511pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myAv69MaFRKWn2I2SW1R2lECVQNHL7kM1EUxjGkHBlQ=;
        b=mvmhxrtyWsGe9wdY6q/6VEGdr8j0Jr0G8sUVnZDRlJiI6qDUIhGWWZ1ITNlGgB6/6c
         K4kEiPBa4hvb2NE1GnkEpGvgIZ+v1t8V9y6jjXWqgfD8sMDd7rKzqhxR8BxREf0oxY70
         6QIrfAG88GvCIGgzNHUkdZG/hc/0QXfObTM7mbkGpZmjDw3i+MeGBKaJJV2bvmFEHW2K
         MgS8c5u8vvV47bbfzGrIPLsxrbcu00TWjmrveWYRGEbEZkaEDBNQRqJrfSZNCjS4kHZm
         3D2ORzENqKQcYUUdAV7WOCViuMbO9tdAHJEyipvaz4D1pSaKROiKx2BD4IBhsBnRDOki
         vZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myAv69MaFRKWn2I2SW1R2lECVQNHL7kM1EUxjGkHBlQ=;
        b=qjJyqFVrwpDkwH0qgHJTfJe2TbbCNYOck2aLdgAIDBWVKO/tkjl+ij/pa6z98cyNiW
         MYYKanplxN40G85K315LioOgFd6KlScWM6i53OZJU+ScfG3dah9ozEa9SAESjkOh+8Nc
         IaTm970tAqBf2siVB6Jy3O4TBi/OwUB+FvRM92iat1MyNmYbkh6EPPueoFFx09XWLWpR
         NwO192MLRpBiz69efcYjzdMpPTBeSOehKzKIpS56V/Iee7GzUVuZWTMLqyd22ve1xfUi
         7WfevYXmBssXpGbIjC4Wag61IoJEt9yjt5R9kk/bgvXGOBEV4X4ufx6AkIprI/Wd0Z6K
         Wm8A==
X-Gm-Message-State: AOAM531NeddN6nzJKMADDarCLxn+jChhyGap7BfBfh30ZN7NscJA3ALN
        fECgeqw9YWxxWo7j+L3Fgqo=
X-Google-Smtp-Source: ABdhPJwjfU1YdtM0M4g7+nwNxNu0XRXBxzO6Eqic+/P8yx7A/lcfX3NhB5Woqo6FyltLr3+o0hnNQw==
X-Received: by 2002:a62:7e41:0:b029:249:287:3706 with SMTP id z62-20020a627e410000b029024902873706mr18160638pfc.76.1618346037893;
        Tue, 13 Apr 2021 13:33:57 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:a476:17ee:13ea:2981])
        by smtp.gmail.com with ESMTPSA id 20sm89970pfw.40.2021.04.13.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:33:57 -0700 (PDT)
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
Subject: [PATCH v3 1/3] rseq: optimize rseq_update_cpu_id()
Date:   Tue, 13 Apr 2021 13:33:50 -0700
Message-Id: <20210413203352.71350-2-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413203352.71350-1-eric.dumazet@gmail.com>
References: <20210413203352.71350-1-eric.dumazet@gmail.com>
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

