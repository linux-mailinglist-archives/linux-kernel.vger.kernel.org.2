Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99F359634
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhDIHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhDIHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:17:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730FC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 00:17:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r9so7055610ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAgKFkUbajfTwkiBbjHCwLbY8LqpQ8PBmh7VA/cwU0E=;
        b=igEspD4oLTpM4o2jCwSGcYwjzgvaFDiBYrZde/yigoCOzASZ6Q36kFdOLTPk9+sEKA
         At9Rg6okYKLJenOHCVlutmLzuLAhyDZfgGBYJ66Oj8C6MPsS8wita034AoWkMFIgC25Z
         7hsoj7iGl8V5wzeL/wT3tqHTfrZTHkZwk5UBViKyHTywBmZFq0frm8mI3J2xlddZBmoE
         s8q8GSI2WepiZ10MAzwDGwDMtYCoPpkyTnDhEtIa1GyGDEw6k37Rs+HJ9yff6WL6sw1O
         4WqcJX+pPtmQilHkwSI8hffyk+1BcLWllcyd2nRmfoTOw/Abay7/0UE6y0hP+L+s4Qlb
         YxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAgKFkUbajfTwkiBbjHCwLbY8LqpQ8PBmh7VA/cwU0E=;
        b=t7SK7OPceOKhYtKxol1DrgJR/gY/1oiywnJWRSULInEIy34GE5uGeM42FYZtrjEnKX
         GQ/pOT+ImfouvZStczPVS37gvZ7MCXfIbICQXfFi+BSoXAAC2QRpe872TD5tmG5hp0Dd
         oO6ZohuuHMZEng/IxzLr3sKIfEwYUeo3qleJvEovqCD4TjBorOOpAfFFIOsbEAbKPCTi
         7p6NcRYx56HIz5KbURBtaR30mDToTxX9DbHDyWlN+9VRyRQJII0PsWsXwqHiaZ5f0XIp
         AOyv8ju+khBn6OxvPw6o44XBxVLyrzNBPD6cfswKiW+SWI3DfT80lGGjfqIMCNiSNnn6
         N5Gg==
X-Gm-Message-State: AOAM530zfb9oAarlpv6hYqUUD6koTr6aRyQkZtAYXbaowVGTNIdQjBw8
        G4RBUJvXJFahanN7Qmmt0KM=
X-Google-Smtp-Source: ABdhPJzQ2tCFOmAsi20Gal6ccZzgbiWTy3xs28H9Fe7zY+J/NCEjtr1WZzzVEoA6J7yNPFrn15rtkw==
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr15226911ejq.414.1617952646960;
        Fri, 09 Apr 2021 00:17:26 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:216f:9340:7a2b:4f98])
        by smtp.gmail.com with ESMTPSA id w1sm905369edt.89.2021.04.09.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 00:17:26 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ray.huang@amd.com, daniel@ffwll.ch, akpm@linux-foundation.org
Subject: [PATCH 1/2] mm/vmscan: add sync_shrinkers function
Date:   Fri,  9 Apr 2021 09:17:24 +0200
Message-Id: <20210409071725.1532-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to switch to a spinlock and reduce lock contention in the TTM
shrinker we don't want to hold a mutex while unmapping and freeing pages
from the pool.

But then we somehow need to prevent a race between (for example) the shrinker
trying to free pages and hotplug trying to remove the device which those pages
belong to.

Taking and releasing the shrinker semaphore on the write side after
unmapping and freeing all pages should make sure that no shrinker is running in
paralell any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/shrinker.h |  1 +
 mm/vmscan.c              | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..6b75dc372fce 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -92,4 +92,5 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int register_shrinker(struct shrinker *shrinker);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
+extern void sync_shrinkers(void);
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..46cd9c215d73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -408,6 +408,16 @@ void unregister_shrinker(struct shrinker *shrinker)
 }
 EXPORT_SYMBOL(unregister_shrinker);
 
+/**
+ * sync_shrinker - Wait for all running shrinkers to complete.
+ */
+void sync_shrinkers(void)
+{
+	down_write(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
+}
+EXPORT_SYMBOL(sync_shrinkers);
+
 #define SHRINK_BATCH 128
 
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
-- 
2.25.1

