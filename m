Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5457C35E7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbhDMUeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348222AbhDMUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:34:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:34:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so5429848pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIins1t6G3qvATuT/71pEz8vxAHrnk41wxK1CE65WVA=;
        b=geAtD0LJYX39l2E4cr88oVxDEzv2ZGHSkz/qA3gw7fvD1eNkGzxBMjrvHXehj9tAHn
         xyR66T5DLrkXg+LlAY8GxpalkTnkaoNVjS1a2bs//2UefBehFj6h55Xkxkxq7hHOP1DC
         +35Cm0JoXKxrswupdkmK9AagSlklLAnEoLVXAz/OCGYEyPQq34qu1w6yQtjMlR6u+xeW
         xbw9bKUJeyTJieQmqhF3jBxyvvDEsV2UlmZcryit5MsQAsZHRrrgjF5Jdzt4a01645ud
         bSiIzn/yMfOTevAoebRJefC6j6S7G3leZbxq2yxUHl7vuZc+Kajs/4CSkHsHjgfOFRRM
         1QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIins1t6G3qvATuT/71pEz8vxAHrnk41wxK1CE65WVA=;
        b=ar1Ib+j56XdzVwBOQZqhNlgvultELpHdAryaDKU4mxpimR0ggBrxjs9lHDY7zVj0fn
         Um3uwbsgtlLa/gGZNzJHjmTL9JLbKXYBxgKdFffrQuyPuqsfjXWJYVPr60+HuNy3gzDA
         UU21AOIrlULAVEXZNKb6kOt/rn7OocHNmZYyGs3aooaCs4eiffsfeFVE4i0c3gMcxTOy
         93Zt20CenfpuwJeb8IdWEVGPekxdo4M4Jaw9aePp2zYCrCAko7SvhgqGx5bBq1VSwvE0
         0+4HPW6xnC2KXHK9HISH4B62wSoXb0p620FmlzE/1c9vt6qzItn1PI3fBSZk0ZS1deqY
         dbEQ==
X-Gm-Message-State: AOAM532XIRC87aKZyaS0DN54RVmfLnoyR8HKaEGZUo+/6by31WPWzo5S
        1MA0a90x4v2Wdnu1N+sw1OY=
X-Google-Smtp-Source: ABdhPJz+7HCEkslk4Q3WF5saPL70YBvye6bDA7kma53zxcn2HSyVyzqZ6egrHQz2EBoXJGtcmXgAAQ==
X-Received: by 2002:a17:90a:f402:: with SMTP id ch2mr1852856pjb.171.1618346040122;
        Tue, 13 Apr 2021 13:34:00 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:a476:17ee:13ea:2981])
        by smtp.gmail.com with ESMTPSA id 20sm89970pfw.40.2021.04.13.13.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:33:59 -0700 (PDT)
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
Subject: [PATCH v3 2/3] rseq: remove redundant access_ok()
Date:   Tue, 13 Apr 2021 13:33:51 -0700
Message-Id: <20210413203352.71350-3-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413203352.71350-1-eric.dumazet@gmail.com>
References: <20210413203352.71350-1-eric.dumazet@gmail.com>
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

