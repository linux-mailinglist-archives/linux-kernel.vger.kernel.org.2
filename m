Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34FC36879A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhDVUDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbhDVUDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:03:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F8C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y3so18648749eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1S/25Adlc7Pk29dJA+1TNqcXCCzU+HSnSsbA/vO+Ww=;
        b=AtOk4yNzB2JPe08H8kDDVBiX2/dX32ADRcZuAYvMkQ/qCAJ25nOr9lyKmNkND1Dwpo
         yjU7kW7Rv4T9rxtqh2lkY05QhfbP/O3hj/MusxVk4ir91WOt64pdKGy7TwaVyKrxMpml
         mGOLMFfm8T6Sttxpoe9nVL/7pvyRPwLwsofFmz8EEN5MXya7xlopZrChEyhJalcVmAzH
         lUlEFl059X4WkRb1iTNNb/O8g1IoG5w30KDarNwrXYWz3LtOLbZKJ6yGRJmU6JJCv0iC
         3+E2+ocQ1l7rd1/GCw5UAyxMHKxdI9xHjBbhUnv2dYIJYuMPrr6H6C9WZHwhXQ79mi92
         9Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1S/25Adlc7Pk29dJA+1TNqcXCCzU+HSnSsbA/vO+Ww=;
        b=oeb7zluG84iPBCEbh6gPN44bWBf5oMqrF7v+463XGK6PcaKSB9KsXPvE4A1McyXa0V
         LbhFI8J/0dLkg9S+QeOXgxbB/imBLFTQUepy92UshuRngJGj67blORhP5YIxz4hDluIX
         0lNu7JkgW9bkZvFG876mKiIXL/sEyudgDVyPUGKJXhMozjQ+osrKmam6KZzs+pQt1SO2
         fvRnAOud/db/lIejHzibsv4PSW5js7gegVwHXoGgeSmQ8HcD6gEXIh7yGCVfbA//g/ya
         sGqsnxIvzgSIuwOu0CW4EW9aQ0fipLf1VcBb8LauJloXfEhI1VgXNYq29d3sWP7HLIkG
         30mA==
X-Gm-Message-State: AOAM5313wdhSMQvBXZoTKrDqGldYqhuPz5k0wrEiwOgoEg/5+5Bfgomy
        y4PU5pjkPLJNQCtG21rplA==
X-Google-Smtp-Source: ABdhPJwsLXbco0GIF19I9R0572+De3danW9pDNImEYrdQySEfrI6q4wQTfOe35gRBltFuMHn9fvnxg==
X-Received: by 2002:a50:ec97:: with SMTP id e23mr236660edr.98.1619121766247;
        Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.145])
        by smtp.gmail.com with ESMTPSA id u15sm2936199edx.34.2021.04.22.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 3/4] sched: make nr_iowait_cpu() return 32-bit
Date:   Thu, 22 Apr 2021 23:02:27 +0300
Message-Id: <20210422200228.1423391-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422200228.1423391-1-adobriyan@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runqueue ->nr_iowait counters are 32-bit anyway.

Propagate 32-bitness into other code, but don't try too hard.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 drivers/cpuidle/governors/menu.c | 6 +++---
 include/linux/sched/stat.h       | 2 +-
 kernel/sched/core.c              | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b0a7ad566081..ddaaa36af290 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,7 +117,7 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
+static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
 {
 	int bucket = 0;
 
@@ -150,7 +150,7 @@ static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters)
+static inline int performance_multiplier(unsigned int nr_iowaiters)
 {
 	/* for IO wait tasks (per cpu!) we add 10x each */
 	return 1 + 10 * nr_iowaiters;
@@ -270,7 +270,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	u64 predicted_ns;
 	u64 interactivity_req;
-	unsigned long nr_iowaiters;
+	unsigned int nr_iowaiters;
 	ktime_t delta_next;
 	int i, idx;
 
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 8a5b27ae7937..0319bc227c4d 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -19,7 +19,7 @@ extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned int nr_iowait(void);
-extern unsigned long nr_iowait_cpu(int cpu);
+extern unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2cc8d81cdc75..c2012f0ea7a0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4378,7 +4378,7 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned long nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
-- 
2.30.2

