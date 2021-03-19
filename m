Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD62342899
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCSWSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:17:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78ABC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:17:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so8025130qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yg3+pA+XMstw5/j4OTt6hsq/DC35NJ/2Jvf5NSNYYGk=;
        b=tU7N00e59acokWvuJkegFKxkQxCUzTOGL976geI4/29H6xN3RMXLmSRAm7Utr62KEJ
         IVvEqAK7LRyaDVc79jpGw5mDwdTnRlpxw6xnxk44+OMSqAxr6xPDGgOtqq38/MBrJHG3
         tNe8tLM1oFjVy7FVY0yxoSwj3BHmVEz1iJB6ZoIQ8bxqilvG/q0oWEzZip2z1r4gq2J5
         AUDHR7/fgq6vlM59EF/sxvMe2USzO+cDqnbLsyVU+SqK4BDZLS8dcRdW4LoD0g2xBoiJ
         MVNXYGB1P1lhyq5Te89SY/qZk/RM/yueZqMnQyTDvwERmTDGx6CCitTiBnfviZipGSaB
         FuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yg3+pA+XMstw5/j4OTt6hsq/DC35NJ/2Jvf5NSNYYGk=;
        b=V1yO1ef5qY7XHEVmq9Cd/j0Kff+08cDmLJMryPUY0pBzQ5x966DtVH/6ZrrKQ1dh7L
         dzUAj5xiWVBlK/YMkVs99criGh+JLddLlI0UnYrzgbeTcO1wt7mllhhWpwqA2AlJMnYJ
         uRFwg7TwG0LdKjh626ElMszjRbQ2ZtUFAA1i7TT8vmox/TTjywj9MWK3MA2fEE9n9uRM
         sX5lgnoP/+O9BInDIhIAOBe+nFYn9VGCIjbgZcDuC1QXcLy711W07D6aVsMgom/xo+qc
         kZJx2Ikcq/ACVrLqZYqlGzpIXiNvwmGMQUqC4CVbn99jy0B86E3EOvU5qHcvkHHzS1uK
         ul3Q==
X-Gm-Message-State: AOAM5330UwlerGy/vehNDerc0Y3LEAuuLGSgbMjlCsZcD0/kB+n0XCBU
        Bku7az2Najo4A+g3zPBsgek=
X-Google-Smtp-Source: ABdhPJyFsim3WgtQyawm5/VN97UNTpMsDXFHEibEpcVWcKuyP43v8qB3nG4kjlnOVUlQN9ZY0o6TYA==
X-Received: by 2002:ac8:4510:: with SMTP id q16mr797413qtn.241.1616192262918;
        Fri, 19 Mar 2021 15:17:42 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id e2sm4757762qto.50.2021.03.19.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:17:42 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, akpm@linux-foundation.org,
        gustavoars@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ipc/sem.c: Couple of spelling fixes
Date:   Sat, 20 Mar 2021 03:44:33 +0530
Message-Id: <20210319221432.26631-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/purpuse/purpose/
s/seperately/separately/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 ipc/sem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85dadf..780d75eff8c6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -786,7 +786,7 @@ static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int error,
 {
 	get_task_struct(q->sleeper);

-	/* see SEM_BARRIER_2 for purpuse/pairing */
+	/* see SEM_BARRIER_2 for purpose/pairing */
 	smp_store_release(&q->status, error);

 	wake_q_add_safe(wake_q, q->sleeper);
@@ -821,7 +821,7 @@ static inline int check_restart(struct sem_array *sma, struct sem_queue *q)

 	/* It is impossible that someone waits for the new value:
 	 * - complex operations always restart.
-	 * - wait-for-zero are handled seperately.
+	 * - wait-for-zero are handled separately.
 	 * - q is a previously sleeping simple operation that
 	 *   altered the array. It must be a decrement, because
 	 *   simple increments never sleep.
--
2.26.2

