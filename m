Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07910349F63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCZCPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCZCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:15:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:15:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y2so3265827qtw.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5RD2ALBTArU+Fx318pIUzeJQfn55V/ad6+bFm9zOfg=;
        b=Msd0AbzU20IaVOz4xOWBmb5wbMCKOAR+q52K6BVYPuRv/2t85I94QkckPKA2nImUg6
         DwergGRyQTAzb+oxmQQvUhbIK6krWfgXSIMFt8t3nG//SUgYGf4nK6T2yAlJIYGjPsfk
         02oZg2HYVot6oT79B6+3z3A/H2aldSeO6a7SN5hc1qghGoiiYNpDZK7q1Nt61hBf49yj
         9LGrbNpvgbec7ZweQmISQw6P/NVVEMdO7kqI3KxY7+QxblvS81mk/i3fHSr/uMQcT1I1
         kYOo2MMqWwZ0t67KtxNkmW0gjppaWqO3G/Z4CApOjkudTBLGviyB+m+qLdiKXkzcjPkS
         Wgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5RD2ALBTArU+Fx318pIUzeJQfn55V/ad6+bFm9zOfg=;
        b=eM70XZUiRbAP0sbR1qA6T0lfMn9cfTAXVTorUSBwsXfm60/Oo9EPBYFC7Sbr6dw7xy
         8b4HztuJFIGFUO2h+OkN3Qa2xn3AK5D2lxCemMMPMCr4LgHmpkxkvw3GpvPz5fseyQ6M
         bF1Y/29OQFy5sNNJQ4+0S6DaYXG4sRTYUbzj2ucex2e2xitnKp3ypg6CBYOWh8bG5d9X
         +JXSNc3m9nm8JQhi0bDm4sMO7tvEguY8L1ZRM6VgzLm+ylAFi7UZq8a5UJUx+0Xr7Ig6
         Ws5VcWclb9whokqKf1gr8I5yt9pDVUp9gh8ICf9tCoh9xMuvaJTIHlPmE2W2gCSz3FNE
         KiYw==
X-Gm-Message-State: AOAM530ks9s6FiQFZ/TGsDgst/4nS1eqiAe9tGOw/UB3GKEUd4jZv095
        i+S7zpItMuxzJv+oZVs0Qb8=
X-Google-Smtp-Source: ABdhPJyC4zp+cWUyI79M89I+mF6cQh9/wzjj6e3pAWZhbz4nnO5lfW18gtNgk21fx7Fykhtegwt2RQ==
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr10286338qtd.104.1616724905979;
        Thu, 25 Mar 2021 19:15:05 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id n3sm4926623qtd.93.2021.03.25.19.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:15:05 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gustavoars@kernel.org, akpm@linux-foundation.org,
        adobriyan@gmail.com, unixbhaskar@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ipc/sec.c: Mundane typo fixes
Date:   Fri, 26 Mar 2021 07:42:54 +0530
Message-Id: <20210326021254.29388-1-unixbhaskar@gmail.com>
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

