Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5176380F52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhENRzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhENRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:55:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:54:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so45772725ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zrr864vz4HEG8mmnJ6sAZEaMqhc6jwYzzB0gzj1AsQk=;
        b=f9w1z2UFK3cXoxX+uGAI+yxQPgovx1gBLSYG6MiwRkK9c+FKBplwYXvNngH7k6IFVy
         LRBo1Bhu9pDcnu+WSeeCOMmRrmvIuWe4k7H6fQ3uOyNVVtkKMhQ69RNpvD/GOzUbwKYh
         tXlS45TzSznmhApagsheroDycWlxwJAdbHvZNaNVKrh6F6eHlFlcMHfwqPNckQroXsSQ
         ZKywuOSYE0fTZfrjcZRVctDvgPuuXb1Eqrk4Ei0/BXGkLXDQgaqeJiJEcGZWj8tfoQgi
         LSkoBKq2PzyGpuwYQm/uExEPCDKLLrT5WIHFaxGYHsTrCkG7eW0c7fKmqGowHW41fP/N
         l9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zrr864vz4HEG8mmnJ6sAZEaMqhc6jwYzzB0gzj1AsQk=;
        b=XISaMtzDJOmRWeIpJYJJnSpTZ1GBj93Ec0Psfs+YJVxU5v9MnRx1l9gawUYXR3JT9q
         LQQSgjBXkOz7QxGm8nU+GIx0d31AExA91A6R5kOiBCN9+T9Dr3GtKFLGEon3Vjr5hRXM
         wiFdW+RP58/DPxs027+DKcWWPA1DQSLz3GuHV9RbsEv5GAXnlwS/m/rpbQ4itRK89oS5
         r3xiediMUyOr7XqBzdgBvgpte6baJEVPpoDWg7+U6zGhm7iBYjj5Oy6ACxf3GYINqmyZ
         N3fvubNubiI/W6FZUxgrUED073uBTK6rrDhYYgZK2yCST7KQVt3vzpIxZK7EHYF4Fi7e
         6hRQ==
X-Gm-Message-State: AOAM533e2MXB3iC0v3Q0VkBS0EF5FTEQRpYUyqqqPKJ+sMJDXdCFeWP5
        f4tSyuF7MBunYoM/3ITXLEuu+XwC7eWNfPbL
X-Google-Smtp-Source: ABdhPJypxcPfURuyN+TnDw5wb+bTR5mXJML7zl7q7DTvrVDJ/g08GHoKsjfYLmNqBqcG05I55tBFww==
X-Received: by 2002:a17:907:a076:: with SMTP id ia22mr49566009ejc.233.1621014842189;
        Fri, 14 May 2021 10:54:02 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970469005bb43495a574ac97.dip0.t-ipconnect.de. [2003:d9:9704:6900:5bb4:3495:a574:ac97])
        by smtp.googlemail.com with ESMTPSA id q16sm5028009edv.61.2021.05.14.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 10:54:01 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] ipc/sem.c: use READ_ONCE()/WRITE_ONCE() for use_global_lock
Date:   Fri, 14 May 2021 19:53:19 +0200
Message-Id: <20210514175319.12195-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch solves two weaknesses in ipc/sem.c:

1) The initial read of use_global_lock in sem_lock() is an
intentional race. KCSAN detects these accesses and prints
a warning.

2) The code assumes that plain C read/writes are not
mangled by the CPU or the compiler.

To solve both issues, use READ_ONCE()/WRITE_ONCE().
Plain C reads are used in code that owns sma->sem_perm.lock.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/sem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index bf534c74293e..a0ad3a3edde2 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -217,6 +217,8 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
  * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
  * is inside a spin_lock() and after a write from 0 to non-zero a
  * spin_lock()+spin_unlock() is done.
+ * To prevent the compiler/cpu temporarily writing 0 to use_global_lock,
+ * READ_ONCE()/WRITE_ONCE() is used.
  *
  * 2) queue.status: (SEM_BARRIER_2)
  * Initialization is done while holding sem_lock(), so no further barrier is
@@ -342,10 +344,10 @@ static void complexmode_enter(struct sem_array *sma)
 		 * Nothing to do, just reset the
 		 * counter until we return to simple mode.
 		 */
-		sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
+		WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
 		return;
 	}
-	sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
+	WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
 
 	for (i = 0; i < sma->sem_nsems; i++) {
 		sem = &sma->sems[i];
@@ -371,7 +373,8 @@ static void complexmode_tryleave(struct sem_array *sma)
 		/* See SEM_BARRIER_1 for purpose/pairing */
 		smp_store_release(&sma->use_global_lock, 0);
 	} else {
-		sma->use_global_lock--;
+		WRITE_ONCE(sma->use_global_lock,
+				sma->use_global_lock-1);
 	}
 }
 
@@ -412,7 +415,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
 	 * Initial check for use_global_lock. Just an optimization,
 	 * no locking, no memory barrier.
 	 */
-	if (!sma->use_global_lock) {
+	if (!READ_ONCE(sma->use_global_lock)) {
 		/*
 		 * It appears that no complex operation is around.
 		 * Acquire the per-semaphore lock.
-- 
2.31.1

