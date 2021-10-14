Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6427242D4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJNI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhJNI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:26:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 01:24:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so4261595pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Y1wcCJ10AMkbngtu0ZVsB2vKXfB5ndZJY8Kk89G1094=;
        b=Du7sLLmAp7rOYRynO6tGncdrjvNGW9V+5ICwMdQs4zj20vLCKphyt4oqz61sCfQa/M
         9ixj+l1NhjXgtiAQXDdhd6XnqCLLzpnCJ7Iljh//b/pmgESEgyh5GXeRl1Vn3sIOTQg+
         CUoF09sg3SfHW17Xd7AMZ7qHGyVh2Wd4GjHUwIQ7MzoVgjYrbQSI4jatpCpnmpVWHedA
         MqRif7sWQ9U1pKxi9v4UTLZktG6bMM5pgPkd1NRa8y2myhaTP5PGhmDHDjBkNx4wp/tS
         nlKpxul01nZTBwS8lhZUgV8z+nErQufQWM2ik4ksmkAU3yU4T3w2HqUxR+hnX2oHfOV/
         w5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y1wcCJ10AMkbngtu0ZVsB2vKXfB5ndZJY8Kk89G1094=;
        b=SsoGF62yJJ+UKn4lau0eyqPbFA/WaWysF1mNrQ0hwFIvJ2XvTEVbPXDLFhMSu5QJ7q
         45+GjdtRe0lHZWE5o2w07fBKlGGVCjwB7firlODmbSsZ37sI/jXQWo3Q0HJm0I1wyAdU
         ExIMSsYmSJRDKY3CUk5mHR16nzplhLYJyE00Ccf/YLYGDtchHnXUsha1JaipGjzUlfbn
         6fMTF40/avUON67bvxgJ5m+CKps+1X3Hdwf3ofslIoj7Cl0D6YWm4UESX6GGfgU0WBU9
         PSusfLEkFn+hoW2ooRPf5pU6yy4084Gu4EG2fqG4lROh8E1F8j4LK9So2oucq4IK446F
         4DQw==
X-Gm-Message-State: AOAM530PJfbiNPUK7BeBbVR3iUkn395g1EhEzUhH/p79my1hyuFw2qSN
        vz+PmTXhufvhL7bPGL5p3raDjBKJc0Za2pJs
X-Google-Smtp-Source: ABdhPJyQvTmIrEB/glBuN8GZ1dbA8a1pX+jcZclwX2WaLQOI2psDuW8hGGc7Z1DZI+vyhcv55h5p+g==
X-Received: by 2002:a17:90a:b105:: with SMTP id z5mr18438907pjq.64.1634199879137;
        Thu, 14 Oct 2021 01:24:39 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id r31sm8153943pjg.28.2021.10.14.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 01:24:38 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     akpm@linux-foundation.org, sunhao.th@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] mm: backing-dev: use kfree_rcu() instead of synchronize_rcu_expedited()
Date:   Thu, 14 Oct 2021 16:24:33 +0800
Message-Id: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<IRQ>
 __init_work+0x2d/0x50
 synchronize_rcu_expedited+0x3af/0x650
 bdi_remove_from_list [inline]
 bdi_unregister+0x17f/0x5c0
 release_bdi+0xa1/0xc0
 kref_put [inline]
 bdi_put+0x72/0xa0
 bdev_free_inode+0x11e/0x220
 i_callback+0x3f/0x70
 rcu_do_batch [inline]
 rcu_core+0x76d/0x16c0
 __do_softirq+0x1d7/0x93b
 invoke_softirq [inline]
 __irq_exit_rcu [inline]
 irq_exit_rcu+0xf2/0x130
 sysvec_apic_timer_interrupt+0x93/0xc0

The bdi_remove_from_list() is called in RCU softirq, however the
synchronize_rcu_expedited() will produce sleep action, use kfree_rcu()
instead of it.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 include/linux/backing-dev-defs.h | 1 +
 mm/backing-dev.c                 | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 33207004cfde..35a093384518 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -202,6 +202,7 @@ struct backing_dev_info {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debug_dir;
 #endif
+	struct rcu_head rcu;
 };
 
 enum {
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c878d995af06..45d866a3a4a2 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -935,8 +935,6 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 	rb_erase(&bdi->rb_node, &bdi_tree);
 	list_del_rcu(&bdi->bdi_list);
 	spin_unlock_bh(&bdi_lock);
-
-	synchronize_rcu_expedited();
 }
 
 void bdi_unregister(struct backing_dev_info *bdi)
@@ -969,7 +967,7 @@ static void release_bdi(struct kref *ref)
 		bdi_unregister(bdi);
 	WARN_ON_ONCE(bdi->dev);
 	wb_exit(&bdi->wb);
-	kfree(bdi);
+	kfree_rcu(bdi, rcu);
 }
 
 void bdi_put(struct backing_dev_info *bdi)
-- 
2.17.1

