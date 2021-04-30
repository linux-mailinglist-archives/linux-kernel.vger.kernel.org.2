Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD836FA1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhD3M0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhD3M0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:26:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A55C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:25:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v13so22905122ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9JpNmPz9+A6Ds6QUoV6S8ikIWMpjgKdHINWt1h/gwng=;
        b=X9XNj76ML0b1qKgrgsV4pOWOns/E1Zr2YoFjUeRjCooUmozvxtDCqJ5f+EtISJ4sYU
         GcTwIEhvbhZs5g5VJRUndzjrGhPyDhLaKVCrAPEPHPm8g437kBIL6e/V2/i9zX3TTvmb
         R481ItI9LodJawfOAWPQ20ZMeP4/EXjdBh6BqyPUkYadwll5fFOdqN3zL+F/7/uMxoJm
         EFQDIW9XdR/7cf5Wyq109l+6TmCmfH9fbtD0dKfYU94YP7X17qXqRuDiYOgCHMdzUjSR
         6Gt4hKZ7t1RcF8FGIWyS5Ph0hu5BSN7Y7QQFD5D7bYUcAWq6k91NykPTubKEH6QrtFHx
         AM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9JpNmPz9+A6Ds6QUoV6S8ikIWMpjgKdHINWt1h/gwng=;
        b=nHF4EnVlBF4OpfwZAoblu+MDv8usN5825rufnVyJBILK/h5tyuQ6RREzi4KUjvnHmV
         /JUgXmBDULRQwLy1aKN+G/MB/bshEoK1zokAjRqM3AlxxYrfjpNb+WH8ONv2nQ80mpM8
         UMUJkEP8R795KM1w35PEGNmccED57PY+VjofwgMD4PkrNRyYT/hHyArDjtt25P//8Y5J
         it9qHm2pM/rSqE06xmJaMHN0hMYTgF5QzJirRn25WL/xcRTARyxihhMeqQonv7U3WWUo
         Cdf3qtVxnQJQbBzfSyjXWatY/CscLt9xGPP43PhSD9FKjR8Img7R2CnwWtKDY6sS/HL7
         0gjQ==
X-Gm-Message-State: AOAM530kp2BJlRK+WUSUxx51X2mlq9dcKj9n5vX5Xo9V/SwvyKBPfZD/
        Lt3dnfh5cGbQExFty7EbnBk=
X-Google-Smtp-Source: ABdhPJxzKPAOlKyFitPRSYeUcdTn0P0xeHrj8CJMOgAMGTYzpUxsjQq0ncd1SIj3HXp3wQ/uKxguPw==
X-Received: by 2002:a17:90a:e384:: with SMTP id b4mr15533666pjz.157.1619785527133;
        Fri, 30 Apr 2021 05:25:27 -0700 (PDT)
Received: from localhost.localdomain ([183.129.167.42])
        by smtp.gmail.com with ESMTPSA id j23sm2239785pfh.179.2021.04.30.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 05:25:26 -0700 (PDT)
From:   Mingzhe Yang <cainiao666999@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, yuxin.wooo@gmail.com,
        becausehan@gmail.com, huan.xie@suse.com,
        Mingzhe Yang <cainiao666999@gmail.com>
Subject: [PATCH] tasklets: simplify code in tasklet_action_common()
Date:   Fri, 30 Apr 2021 20:25:21 +0800
Message-Id: <20210430122521.13957-1-cainiao666999@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tasklet_is_disabled() to simplify the code in tasklet_action_common.

Signed-off-by: Mingzhe Yang <cainiao666999@gmail.com>
---
 include/linux/interrupt.h | 11 +++++++++++
 kernel/softirq.c          | 14 +++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850..b0fba4d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -721,6 +721,17 @@ static inline void tasklet_enable(struct tasklet_struct *t)
 	atomic_dec(&t->count);
 }
 
+static inline bool tasklet_is_enabled(struct tasklet_struct *t)
+{
+	smp_rmb();
+	return !atomic_read(&t->count);
+}
+
+static inline bool tasklet_is_disabled(struct tasklet_struct *t)
+{
+	return !tasklet_is_enabled(t);
+}
+
 extern void tasklet_kill(struct tasklet_struct *t);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4992853..ee36b15 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -778,16 +778,16 @@ static void tasklet_action_common(struct softirq_action *a,
 		list = list->next;
 
 		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
-						t->callback(t);
-					else
-						t->func(t->data);
-				}
+			if (tasklet_is_disabled(t) || !tasklet_clear_sched(t)) {
 				tasklet_unlock(t);
 				continue;
 			}
+
+			if (t->use_callback)
+				t->callback(t);
+			else
+				t->func(t->data);
+
 			tasklet_unlock(t);
 		}
 
-- 
1.8.3.1

