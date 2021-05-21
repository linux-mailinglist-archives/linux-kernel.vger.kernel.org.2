Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9198B38CA79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhEUP6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhEUP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:58:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C670C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:56:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d78so14345114pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FU6Xt3Q0npwd76ndNbqtS7CA/D4kpjpW7DA7NbFpzmA=;
        b=C3Rg3mYeETpx5hrBgo9uz/N2Ly+1d98Z7CHaaLznqPmJMO6uv5L9ShAzH80RC+wBbo
         p5Uo8i1qMtiM5qxcqzXJReulf7RSjt9AXpR4dyqWX93HN2IQGIinJlwNSFCHDA72hnQV
         TA8uj3zjo4657XpAdwHKyJf1tXDblCpHfUr4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FU6Xt3Q0npwd76ndNbqtS7CA/D4kpjpW7DA7NbFpzmA=;
        b=Rcj6xcWtLjAijaa9djOnVAdRI+tI/kd46id/z6boeB+B9dKzLId6G+YYn31STAuRQt
         7i4QfAuLr+abROnQkYlL6Jj6MRXpSuCxD7rpeKmbRcio7va8+w/C5u/luKcXaM56rjUI
         bj6GdItLPh1cWqZjS7kNolFkI9BIPJbOMJxe/KHf39lz58QC2zaSlV5fXH+6zAKK2UiM
         VktVXg5PXCYYcdMePQBPfc4HDqji9JTF+EBRVC6zHPOWHKUpSmr1JMv5EyMBGa0C/2Bj
         02wDPm3g9FV9LHdx1x7D+rnQl5mygbelT2UX+sSmOBQyFy+BBuVKBq8OXUvb84wBJdjE
         EyWA==
X-Gm-Message-State: AOAM531+4dyK2+sYoLu73duMy37+yNKrgzxGGb1DpOMgQGc45xYgxkQi
        FSh+tBYvCG5lBgyoYOGbX/p9Yw==
X-Google-Smtp-Source: ABdhPJwYpfe9/4eKUBoPdc8xy2I0ri+MklwAsL9NUU/7V7lzUz7roAnIpqEpBQs6amn8bel/cOnn3A==
X-Received: by 2002:a63:af0f:: with SMTP id w15mr10597776pge.295.1621612597912;
        Fri, 21 May 2021 08:56:37 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id k15sm4767123pfi.0.2021.05.21.08.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:56:37 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] rcu: do not disable gp stall detection in rcu_cpu_stall_reset()
Date:   Sat, 22 May 2021 00:56:24 +0900
Message-Id: <20210521155624.174524-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210521155624.174524-1-senozhatsky@chromium.org>
References: <20210521155624.174524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_cpu_stall_reset() is one of the functions virtual CPUs
execute during VM resume in order to handle jiffies skew
that can trigger false positive stall warnings. Paul has
pointed out that this approach is problematic because
rcu_cpu_stall_reset() disables RCU grace period stall-detection
virtually forever, while in fact it can just restart the
stall-detection timeout.

Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/rcu/tree_stall.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index bc689911a81d..b9b52f91e5b8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -119,17 +119,14 @@ static void panic_on_rcu_stall(void)
 }
 
 /**
- * rcu_cpu_stall_reset - prevent further stall warnings in current grace period
- *
- * Set the stall-warning timeout way off into the future, thus preventing
- * any RCU CPU stall-warning messages from appearing in the current set of
- * RCU grace periods.
+ * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
  *
  * The caller must disable hard irqs.
  */
 void rcu_cpu_stall_reset(void)
 {
-	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
+	WRITE_ONCE(rcu_state.jiffies_stall,
+		   jiffies + rcu_jiffies_till_stall_check());
 }
 
 //////////////////////////////////////////////////////////////////////////////
-- 
2.31.1.818.g46aad6cb9e-goog

