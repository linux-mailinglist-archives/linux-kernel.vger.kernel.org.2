Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDB38ACFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbhETLvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242869AbhETLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:42:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62CC061220
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:14:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v13so8735802ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vW+NDKKrDmGz5rlApX8ep8OaXVSO1OANXWobU/l/KoE=;
        b=e3hQSUfD7jXDXc5eAPdJT+yQ8odjfBlaYNU8hpSaOHHFZL1c68qjig6QHx6Mo1X7Pv
         T5IOcnIhSQuCrjlPWKj23MeTQpk6H4nh7wzfkX8IoM3nxEORH2gG9XPwyu8A4Fydc1bP
         7OB12q8N2+xBuRJwhCatqWoBscwHDI4hTDdOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vW+NDKKrDmGz5rlApX8ep8OaXVSO1OANXWobU/l/KoE=;
        b=I+laf7ItRwn06jYXy1KFNyyra57oIyCz+eNCVoZn28woAVYGUmL2gkFIgHySjmNquc
         1ZzfLFHkQoHAqLz3XsjrdYEzx6ouaBK2tQAX8OyVs9dMrokr++tbt/C+UW9Y3J61uclw
         /xiiyWDXoWJxSbQ05jutsgq1fnhdDOyYCtJd67OpeaoOX1Qz23htKrjtLDpZoUBx4GGj
         HRgLzOY27JygMsxyA6vUC/CRpDunq1zSlU4TXNx82E+Zs3YugCqztfotpgoVQ4xN7dEU
         YMe94oRXLcL8vrubeNCXdd233RcTxFrqV1LDvrYdvfUliRi3bVY94kLjPa/WmlAjCTUN
         yRGQ==
X-Gm-Message-State: AOAM5315Ku6M/my5KMhiGxg5Znon53sAT6n6pdi04TIZ3vNr7urYFeys
        Ys4zQ3BH6Z07LeEbklTCH/cSDA==
X-Google-Smtp-Source: ABdhPJxizqi4wH45Vq8i5YjkbM7BMFVHQPoIpzf32tRKYOjAIq9dYL6agsRJ/5a7C5ef2jbuLQHGHA==
X-Received: by 2002:a17:90a:b796:: with SMTP id m22mr4507385pjr.146.1621505667399;
        Thu, 20 May 2021 03:14:27 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:48db:abf:343e:b4f7])
        by smtp.gmail.com with ESMTPSA id a2sm1430989pfv.156.2021.05.20.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:14:26 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] wq: handle VM suspension in stall detection
Date:   Thu, 20 May 2021 19:14:22 +0900
Message-Id: <20210520101422.660054-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If VCPU is suspended (VM suspend) in wq_watchdog_timer_fn() then
once this VCPU resumes it will see the new jiffies value, while it
may take a while before IRQ detects PVCLOCK_GUEST_STOPPED on this
VCPU and updates all the watchdogs via pvclock_touch_watchdogs().
There is a small chance of misreported WQ stalls in the meantime,
because new jiffies is time_after() old 'ts + thresh'.

wq_watchdog_timer_fn()
{
	for_each_pool(pool, pi) {
		if (time_after(jiffies, ts + thresh)) {
			pr_emerg("BUG: workqueue lockup - pool");
		}
	}
}

Save jiffies at the beginning of this function and use that value
for stall detection. If VM gets suspended then we continue using
"old" jiffies value and old WQ touch timestamps. If IRQ at some
point restarts the stall detection cycle (pvclock_touch_watchdogs())
then old jiffies will always be before new 'ts + thresh'.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/workqueue.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b19d759e55a5..50142fc08902 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,6 +50,7 @@
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
+#include <linux/kvm_para.h>
 
 #include "workqueue_internal.h"
 
@@ -5772,6 +5773,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 {
 	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
 	bool lockup_detected = false;
+	unsigned long now = jiffies;
 	struct worker_pool *pool;
 	int pi;
 
@@ -5786,6 +5788,12 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		if (list_empty(&pool->worklist))
 			continue;
 
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like a stall.
+		 */
+		kvm_check_and_clear_guest_paused();
+
 		/* get the latest of pool and touched timestamps */
 		if (pool->cpu >= 0)
 			touched = READ_ONCE(per_cpu(wq_watchdog_touched_cpu, pool->cpu));
@@ -5799,12 +5807,12 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 			ts = touched;
 
 		/* did we stall? */
-		if (time_after(jiffies, ts + thresh)) {
+		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
 			pr_emerg("BUG: workqueue lockup - pool");
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n",
-				jiffies_to_msecs(jiffies - pool_ts) / 1000);
+				jiffies_to_msecs(now - pool_ts) / 1000);
 		}
 	}
 
-- 
2.31.1.751.gd2f1c929bd-goog

