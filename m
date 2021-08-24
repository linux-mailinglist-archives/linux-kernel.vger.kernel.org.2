Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286DA3F58AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhHXHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhHXHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:08:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C70C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:07:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so424367pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YpxgUDpNqJwNmcekPJDyqgCHxebh+qy9G6z5R23ieyo=;
        b=AjBPUi8FvoSXrRAICxvmHBXlIrdTts7KJdW7pUIFWKL00cNSIwU1RLIKQoIxWINdSD
         zqFeoajvhy0mSapSKU0gWuLoNlrPgIGnVFjxHaRKPhVDLODYMd5CzFD1XA6yRUzzzPZh
         4A8GuuJS07vrGPCrE7RR2yUkqL6LgS2+pjJ3TyDECyJdD28E+//BrufWSZXcHNfF4s2L
         dx+wasMZWHk1MxY3sXdgmHBTycwQfmtb9kXwko8hkQxs7mEKZ9oFLNluglvJzV8Aqrul
         YOkerFzo2r3Cqr2Ouy2whPKcaaJQa9Mr3+1lZCWYXHETTIzzI1do/OuSLRv9cSbRmQdn
         FB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YpxgUDpNqJwNmcekPJDyqgCHxebh+qy9G6z5R23ieyo=;
        b=C31u5MVy0dYpmbWEWgay02tiXHZmTD8LXTdLWxUZpo0Dql2ytYMOk5dyt0nF0jPVe4
         Z6L021Mcp46jwhxJW25bNslf2600Mt61A63eH0vT1iDsy0wefB+0bBb1ls8tH533lLn4
         n4kSSMi+kriWEb/6rzyO8xOlLZJc68kVj7rOeX2Jd/HqfGTaWTtiD1fzwhGMWpKuI766
         od9zxpoLeYLLtqzLsgniZnGJQrnk27FonnC34Tgv4jP6ZgF1a4tFNlJC7BVwdgnTMpI/
         RvoIAgZNJtcn7GuVOxnlH5xNQqW74wIjxPfUlJMVq8OsTTXA9w3P/WDuOTH/gacD4c+j
         K1cg==
X-Gm-Message-State: AOAM53062N56lqtiOiUB8HsE30ka117H6xRsY+XOH4AxWbJBLfsozD8Z
        1gbEUwQKRV2aVtiqVDqHFc7qWGhB6Q==
X-Google-Smtp-Source: ABdhPJwZ4an/IStOF6BmHckyHgaJwuSbzZQSzr6OsUdiAzpovvVnN8hMq+Px/BQZYc+pTB1DKZ8FYA==
X-Received: by 2002:a65:67c9:: with SMTP id b9mr35365561pgs.430.1629788842465;
        Tue, 24 Aug 2021 00:07:22 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12sm7466943pfe.79.2021.08.24.00.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:07:22 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Subject: [PATCH] kernel/cpu: fix spelling mistake of cpuhp_thread_run()
Date:   Tue, 24 Aug 2021 15:07:07 +0800
Message-Id: <20210824070707.5731-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the name of cpuhp_should_run(), cpuhp_thread_fun() should
be a spelling mistake.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 804b847912dc..581d08c0efb6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -521,7 +521,7 @@ static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st)
 	st->result = 0;
 	/*
 	 * Make sure the above stores are visible before should_run becomes
-	 * true. Paired with the mb() above in cpuhp_thread_fun()
+	 * true. Paired with the mb() above in cpuhp_thread_run()
 	 */
 	smp_mb();
 	st->should_run = true;
@@ -723,7 +723,7 @@ static int cpuhp_should_run(unsigned int cpu)
  *
  * When complete or on error, should_run is cleared and the completion is fired.
  */
-static void cpuhp_thread_fun(unsigned int cpu)
+static void cpuhp_thread_run(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 	bool bringup = st->bringup;
@@ -863,7 +863,7 @@ static struct smp_hotplug_thread cpuhp_threads = {
 	.store			= &cpuhp_state.thread,
 	.create			= &cpuhp_create,
 	.thread_should_run	= cpuhp_should_run,
-	.thread_fn		= cpuhp_thread_fun,
+	.thread_fn		= cpuhp_thread_run,
 	.thread_comm		= "cpuhp/%u",
 	.selfparking		= true,
 };
-- 
2.29.2

