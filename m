Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61BD349FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCZCZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhCZCY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:24:57 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58454C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:24:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dc12so2267065qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eN2DVfJpzciL5icd4D570Si09TZ6JhHZavdnzkjc+Bo=;
        b=nDh0JlQXUtVcRbjVsmroLj63CC6lllB/djlxdc59UrAFqP3DvDhqEuv7r4mdT+SIu0
         7TYYhnf3p0N0PmansNZKxIqGn3xkoNHNHegUC5qyh+ht2B4Ngzh+7/2SM8aR70f0v0C/
         fjWLyU0QQ7bPDV65VuAoE09quimI3HVii7KXhM8tnMJbXS39SVArgvDCpUW2Zq/KTamk
         QFgKdJPuLRkR4gqcMqiDZRGNl1nHwCxBcTbF5aAs8qR0yndbYnPko4b8vz5QAOy2P04w
         wD4XqovV8j7s85toTojZB24yzMpyOPySY8Y04gdTBn4HXisoLKwSeVeP9l6HGTynh81J
         DqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eN2DVfJpzciL5icd4D570Si09TZ6JhHZavdnzkjc+Bo=;
        b=WcHvhzlqw4jIxSvrwbq5UUGNnwdkXJbpIsuW9mW8JodOH9LMaV7dA54LgZ6tYJZLcH
         N5cfu5EWH0ZARl1K8DKOo0H0hBIc7QdcXeR39uGSsY0Hsh5+meD5XpzpAIrSc32A/L6o
         4wdG3OpSiV0IryrmSAwsJ27RuwGEdnonLov04cDOyHF/ak6u5Xp+KGHE9hGcwBFv8NYJ
         /KNhqWaQFu/DvPnUAxFqqw3qZCP6IgtszrTg9CvxacZwS8uhSjmjED+Gm4jfSCALkzTZ
         zrrK0WaKzfsIZEkGdkMwIF5YzVH9wzclOmQDM1+8u/QplfEMmQN++7LLzg38cholzoEB
         fHyQ==
X-Gm-Message-State: AOAM530221HyfIrIlKCw4K00xi9taJFPry4OM+MHFAMCdWLsazmSpSr+
        KTZ9hlKTKfRYuFuLQKAq+Qk=
X-Google-Smtp-Source: ABdhPJz19EYeSDo9wxpf5aH3fgd7ajh6KTPxRXA4N1nYaQUtT2U6vYXhLOelBRVPR+BROS6QRWQPAQ==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr10976201qvb.37.1616725496628;
        Thu, 25 Mar 2021 19:24:56 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id v7sm4881377qtw.51.2021.03.25.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:24:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, akpm@linux-foundation.org,
        gustavoars@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] ipc/sem.c: Mundane typo fixes
Date:   Fri, 26 Mar 2021 07:52:40 +0530
Message-Id: <20210326022240.26375-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/runtine/runtime/
s/AQUIRE/ACQUIRE/
s/seperately/separately/
s/wont/won\'t/
s/succesfull/successful/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Wrongly spelt filename in the subject line, corrected.

 ipc/sem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85dadf..0897dac27f43 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -36,7 +36,7 @@
  * - two Linux specific semctl() commands: SEM_STAT, SEM_INFO.
  * - undo adjustments at process exit are limited to 0..SEMVMX.
  * - namespace are supported.
- * - SEMMSL, SEMMNS, SEMOPM and SEMMNI can be configured at runtine by writing
+ * - SEMMSL, SEMMNS, SEMOPM and SEMMNI can be configured at runtime by writing
  *   to /proc/sys/kernel/sem.
  * - statistics about the usage are reported in /proc/sysvipc/sem.
  *
@@ -224,7 +224,7 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
  * Setting it to a result code is a RELEASE, this is ensured by both a
  * smp_store_release() (for case a) and while holding sem_lock()
  * (for case b).
- * The AQUIRE when reading the result code without holding sem_lock() is
+ * The ACQUIRE when reading the result code without holding sem_lock() is
  * achieved by using READ_ONCE() + smp_acquire__after_ctrl_dep().
  * (case a above).
  * Reading the result code while holding sem_lock() needs no further barriers,
@@ -821,7 +821,7 @@ static inline int check_restart(struct sem_array *sma, struct sem_queue *q)

 	/* It is impossible that someone waits for the new value:
 	 * - complex operations always restart.
-	 * - wait-for-zero are handled seperately.
+	 * - wait-for-zero are handled separately.
 	 * - q is a previously sleeping simple operation that
 	 *   altered the array. It must be a decrement, because
 	 *   simple increments never sleep.
@@ -1046,7 +1046,7 @@ static void do_smart_update(struct sem_array *sma, struct sembuf *sops, int nsop
 			 * - No complex ops, thus all sleeping ops are
 			 *   decrease.
 			 * - if we decreased the value, then any sleeping
-			 *   semaphore ops wont be able to run: If the
+			 *   semaphore ops won't be able to run: If the
 			 *   previous value was too small, then the new
 			 *   value will be too small, too.
 			 */
@@ -2108,7 +2108,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	queue.dupsop = dupsop;

 	error = perform_atomic_semop(sma, &queue);
-	if (error == 0) { /* non-blocking succesfull path */
+	if (error == 0) { /* non-blocking successful path */
 		DEFINE_WAKE_Q(wake_q);

 		/*
--
2.26.2

