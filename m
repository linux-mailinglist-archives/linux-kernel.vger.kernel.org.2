Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED6030D6B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhBCJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhBCJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:51:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:51:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d13so14142346plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdtDx/f+DZWL8oxrtotv8ex8GlKmCh3tmTdne4YAUKA=;
        b=lVYaPiCq2tH1w2MA4OxQ8ttgEHtYm/7WsfxAgztam5y/PbgntGY8Y1bjApyIakzBbn
         G2VWloZL5p7wmv9eKjdUUUEYpwjBifyocJd72Xm1AIylwDYl8VRlqNoHL6QregDJ1ush
         C4EcDDT8V1meyn52pI0FtERzOp7v5cnXiBF0Lue4j/eBCoQ4xIYI2ew+UpyHoOgKe5Xq
         e16okhLVD7kKBM21O4O49dEuXpImS0VU8lwLpMIIA9jx9GE9TEGG51WU+PvbLG7EoDFj
         LrlfeeOf/hy+R02WxJcI18jRVRCTP1ewf7aTbRJS40PxTXpjYC6kXqLtGOx+jIIti1Ln
         hslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdtDx/f+DZWL8oxrtotv8ex8GlKmCh3tmTdne4YAUKA=;
        b=Vomgzeje23PfsdNwMGt2XPwRTsoAiHnCgv5wSOeGIyqOZL5fbIIBO3P+0ydztr6HHZ
         tuF+KnTs5uHwTajj6877zCTUtaBMWg68L5ImrQL5b0G4qPvNtQrHa3W94L17+KAK/4rW
         U+dQSYE1GVhJjIfRmcLysXpO9Je6CkdgiFX5WTSGrrEI9EEU+DiGSoODOjNh8XHx7D7A
         id6EfVo7APcq7UurENQfxhy4zqnnkoQpvRSkva1j3W6iGYI2Sh5KQp1Pk4g8lOIz6maE
         b5FrAGcy+6bnvtSQm6qJyd5plyCn8/9Z9eA6JsY+fvXAJnt3PdLyDrPjGU7Ym3aMzLYW
         SsbA==
X-Gm-Message-State: AOAM5303cbnbagYcGh/eqj0pdTR63Dlcsi5T0De62YaxQDGa0SJPJ4ML
        Qk7WBNUxux9MUSGvmPX+NNw=
X-Google-Smtp-Source: ABdhPJyr4iv3Z6rAfaB/HHTQiNnB4ZWutx1OSOiqRUQKY0cCRFEWnvHPdSjUQuirhNBZrsbxpC64NA==
X-Received: by 2002:a17:902:d506:b029:e1:17f4:37c0 with SMTP id b6-20020a170902d506b02900e117f437c0mr2437634plg.24.1612345862547;
        Wed, 03 Feb 2021 01:51:02 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id v19sm1473124pjh.37.2021.02.03.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:51:01 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] sched: Use SCHED_WARN_ON() instead of WARN_ON_ONCE() with CONFIG_SCHED_DEBUG
Date:   Wed,  3 Feb 2021 17:50:12 +0800
Message-Id: <20210203095012.627-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Since SCHED_WARN_ON() is provided as a wrapper for WARN_ON_ONCE().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/rt.c   | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8c54810..8f1f345 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5347,7 +5347,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
+	SCHED_WARN_ON(wake_flags & ~WF_SYNC);
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8f720b7..a90eab3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -114,9 +114,7 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_SCHED_DEBUG
-	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
-#endif
+	SCHED_WARN_ON(!rt_entity_is_task(rt_se));
 	return container_of(rt_se, struct task_struct, rt);
 }
 
-- 
1.9.1

