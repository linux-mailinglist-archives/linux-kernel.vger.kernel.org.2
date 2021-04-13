Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874FC35E3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbhDMQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:24:15 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33353 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245365AbhDMQYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:24:08 -0400
Received: by mail-pl1-f169.google.com with SMTP id c2so1058984plz.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIins1t6G3qvATuT/71pEz8vxAHrnk41wxK1CE65WVA=;
        b=kO90nuMNxO7c2S0a7CYdUuS/lTZoZa9A/BB4Y3ClD0Y29L+0OkC/p78JStH+nymGTI
         9B7dEhEWA32lzBBz1q8Sp0BLjlCNulpkkXJCkzINa8qVKwltN4qa0h56x9pG9AnisJIi
         GsL3tJTVHispos5GMOC+j6i1vALUg3AQ6Ge0HTx1ULV5325l1x94jBqOKyZ6rxnDrekY
         BRxO3L7h5i0LM9hoaYwMj/Du5t870xJhOIoza2XU3vtOjrHP6ija4hVbBv3LDyvEWnwS
         IVkm8mYmYjLRlgIJ3fst4B4PlAan6kaT5B3rh/6E4k+B5oRvCY9RhOlZsXxKkTXLekqf
         aCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIins1t6G3qvATuT/71pEz8vxAHrnk41wxK1CE65WVA=;
        b=SHxjA9iTZPJT8ciojdqm2SSLDDImvsHxs4q9A4W3RYuFY0Tq5NWOcbv2/304B4HIX1
         x6z0/CTdkT9kGZPjenBQC7AIYei9MgbMCBs1Nqwza2ddR9iBeRIy2ryGRvNQ1fHtXTke
         LdPICfCwIwWK2OeuP4EcJsAO3JlVFLPQUkpSQE9cv/XJCNDRtOb7f+C0sgwluawpDySp
         CG7Zci/xxJqns4AxjvDruGppwSQZDV8HUqakCuwAUHuR9nmaaYFtY6hR69otHy9/oG5b
         EmxL4tNQbmMpwbgwEtGOCp6Nj0GtaFhXWs9WnnqiC8ZsOzAaZyXZyeJLYtmXoi/bbf84
         bGdg==
X-Gm-Message-State: AOAM532mqo1FM8soWYzPibfL6kjW6t4XnTPD7wyCOo7DuinScRZTJntw
        7IUkkWOXwHnRzPwQaNXAX3A=
X-Google-Smtp-Source: ABdhPJyulaRnFFkt4pbSI6/Kmrc1csDL3KwPYlkEiy3LRTiyUvXKoNZ9kUk9HEqRKBRfO8MUSE0hQA==
X-Received: by 2002:a17:902:527:b029:ea:b5ef:689d with SMTP id 36-20020a1709020527b02900eab5ef689dmr19903813plf.19.1618330968811;
        Tue, 13 Apr 2021 09:22:48 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:485b:46b2:8be1:2cdd])
        by smtp.gmail.com with ESMTPSA id l25sm15897591pgu.72.2021.04.13.09.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:22:48 -0700 (PDT)
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
Subject: [PATCH v2 2/3] rseq: remove redundant access_ok()
Date:   Tue, 13 Apr 2021 09:22:38 -0700
Message-Id: <20210413162240.3131033-3-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413162240.3131033-1-eric.dumazet@gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

After commit 8f2817701492 ("rseq: Use get_user/put_user rather
than __get_user/__put_user") we no longer need
an access_ok() call from __rseq_handle_notify_resume()

Mathieu pointed out the same cleanup can be done
in rseq_syscall().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index f020f18f512a3f6241c3c9b104ce50e4d2c6188c..cfe01ab5253c1c424c0e8b25acbb6a8e1b41a5b6 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -273,8 +273,6 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
-	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
-		goto error;
 	ret = rseq_ip_fixup(regs);
 	if (unlikely(ret < 0))
 		goto error;
@@ -301,8 +299,7 @@ void rseq_syscall(struct pt_regs *regs)
 
 	if (!t->rseq)
 		return;
-	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
-	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
 		force_sig(SIGSEGV);
 }
 
-- 
2.31.1.295.g9ea45b61b8-goog

