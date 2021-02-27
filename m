Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2E326E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhB0RHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 12:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhB0RCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 12:02:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FAC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 09:01:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h98so11607900wrh.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqXGV7zjXw1rNw/jHveNt81v2NuoqJy6tipiJjF8GcQ=;
        b=KKSaA5547YrwPdvV9eYBziv0bTqz86hbZvOQcvPGIm7Cg1UCTtk55fABOqV3HsnDeQ
         73rNztZ90cpVFJ4vjLuudasiUway7iRjAVL9xvazHgnG1SlxlOROCjHm8dLD9p+sorhi
         BYGLQJHHXBwSLUvlcppgrGkJHMVAkII1R/IzxRlkPGqWtdqrm3CmvvbRPg59Y8qVaZhN
         p8eSojTFo3X2sMyQoCCWudZuy2dFyvi3xbzldg/Adntow2/aPbzi2bbDVVSh8zEuAWKo
         P17lFrFveoDl0urqJhlmqEcn3Dso5f+yv1AXKZJ+Wgu3/2Yge0ApzDwScTteB5qlStn3
         /aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqXGV7zjXw1rNw/jHveNt81v2NuoqJy6tipiJjF8GcQ=;
        b=C+zc6CFoAGMjXPiDwC4G3CgCemc9oPuSg+EFjzfzajmKkSMjoSU1EdW+oTMXFpFYHA
         oL50A9ncpNsCr2MIlMmXa1SNtjQc4KUo3c8xdSpocZiVqpgayJFtY4+H/V3pTDKh6qW9
         XfKj1ZFepqhhPq5MKHUJ9/a3h2vFPDUnMFVxqDyXSDMnPoykeNku0bsBxAcNy0HJ4azy
         C3ApsxgCeVNrh793sogt3J6SwJhVpFlgdfIZdivHEDDaPi1SgHmkOHexJ5anNVCVS4h0
         5D6D+S6iwVXAi4snb73LUn45iOuT1qArqcX1RurtkIeIsLYKI8qKlCHgR8qFjqa4sHc6
         bhLA==
X-Gm-Message-State: AOAM5315rLAECwMDTHWfYSPK7HgzttH7NYVXRGb8YU/LIQU0YCGYvfMp
        kxxt9upoFy8K825Dsp10YNo=
X-Google-Smtp-Source: ABdhPJzkNScUo/Wr7yoKnSzbvmTWoEh93ni1deVG8FbMmjiClNzW4RCGmO/d8bPLuuit6ApH2iVrcw==
X-Received: by 2002:adf:ed90:: with SMTP id c16mr8686352wro.215.1614445288512;
        Sat, 27 Feb 2021 09:01:28 -0800 (PST)
Received: from localhost.localdomain ([149.74.155.145])
        by smtp.gmail.com with ESMTPSA id c6sm18578661wrt.26.2021.02.27.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 09:01:28 -0800 (PST)
From:   Javier Contreras <contreras.javi.0@gmail.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Javier Contreras <contreras.javi.0@gmail.com>
Subject: [PATCH] init: init_task.c: fixed two spaces coding style issue
Date:   Sat, 27 Feb 2021 18:01:18 +0100
Message-Id: <20210227170118.24056-1-contreras.javi.0@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two spaces coding style issue.

Signed-off-by: Javier Contreras <contreras.javi.0@gmail.com>
---
 init/init_task.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/init/init_task.c b/init/init_task.c
index 3711cdaafed2..85d6b045ef7a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -71,24 +71,24 @@ struct task_struct init_task
 	.thread_info	= INIT_THREAD_INFO(init_task),
 	.stack_refcount	= REFCOUNT_INIT(1),
 #endif
-	.state		= 0,
-	.stack		= init_stack,
-	.usage		= REFCOUNT_INIT(2),
-	.flags		= PF_KTHREAD,
-	.prio		= MAX_PRIO - 20,
-	.static_prio	= MAX_PRIO - 20,
-	.normal_prio	= MAX_PRIO - 20,
-	.policy		= SCHED_NORMAL,
-	.cpus_ptr	= &init_task.cpus_mask,
-	.cpus_mask	= CPU_MASK_ALL,
-	.nr_cpus_allowed= NR_CPUS,
-	.mm		= NULL,
-	.active_mm	= &init_mm,
-	.restart_block	= {
+	.state		 = 0,
+	.stack		 = init_stack,
+	.usage		 = REFCOUNT_INIT(2),
+	.flags		 = PF_KTHREAD,
+	.prio		 = MAX_PRIO - 20,
+	.static_prio	 = MAX_PRIO - 20,
+	.normal_prio	 = MAX_PRIO - 20,
+	.policy		 = SCHED_NORMAL,
+	.cpus_ptr	 = &init_task.cpus_mask,
+	.cpus_mask	 = CPU_MASK_ALL,
+	.nr_cpus_allowed = NR_CPUS,
+	.mm		 = NULL,
+	.active_mm	 = &init_mm,
+	.restart_block	 = {
 		.fn = do_no_restart_syscall,
 	},
 	.se		= {
-		.group_node 	= LIST_HEAD_INIT(init_task.se.group_node),
+		.group_node	= LIST_HEAD_INIT(init_task.se.group_node),
 	},
 	.rt		= {
 		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
-- 
2.30.1

