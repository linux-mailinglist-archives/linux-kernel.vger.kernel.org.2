Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650C438F1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhEXQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEXQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:51:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:50:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 76so27577797qkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0E0ZYMx9zVp1EA7IEcXUSIPPu/SWADrbXHZiRrbfT8k=;
        b=Menxq7rUjK/9J2bWmNcvSDW13uYDzdN1Y4KZmCrQSyCm5ozJf+EYnCwalGxUwdazIo
         HNkwcwDBmIbAtFceQi58LYincXyHLo/h3FOEL6RBaq35mRlr4Vc5vzrao4OcXvoLZXPr
         bqzat/PJS6s1sl42C2LhPN4ESfQOd4GVM/z6+xXGFr5lauozutU7x8qGp7jKH1V/t1xQ
         oPHpvE4iK2F0kE4pIptTIim3+yJUh2M58lmSX0r2d+Enn5g1zaTZL2iBybR9KPwItheI
         MJTt8Q3SCNhaWF+cg0LBQfNyoXeZ0mjIAt9pjGL7eKQwia0XsX1XqWZa0RLtJtvbmI7t
         WUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=0E0ZYMx9zVp1EA7IEcXUSIPPu/SWADrbXHZiRrbfT8k=;
        b=IrJyHjN+K5iqY01zbG89nOGnjsu/p6BhJjx0n2DDt4BfGFCDQtsvru+CqDWPMaXNn5
         5Mj1MRw5Iy4akkyxhLFl6n0WqDmBuxJbaUYKq6ujDfuYONsOxYa0iwGSrrAcsBxtSiIN
         tget3ZtiEEa/TzsVPOi0PBM8QVkzTHtCvXdZgKcgilwWJr9XOJkPwQfPKx8ao9enWf0C
         2kIrjKQ2wAUx4tAYsAEMYY/9C6TS2rdEuJ3ws6bQzefAQQm1XHo9A6M3qfOBdDExdW/S
         HDJWpjWtJZXgAuvTaIh1ogPJtSMtAw1RPX5OuyUcGzoLcos3Mf4FzF+HDTd3Oh9p2s+d
         qfSQ==
X-Gm-Message-State: AOAM531D28Tm95j8X66OOUcU5A6T5/B/imyPULE3682YaMfvc35X4r0T
        08o+vWiNRbw6v6gQ1rHC/f0=
X-Google-Smtp-Source: ABdhPJyepvdbVyAo1h6RN0Esjpu4ndGeY1SJqRL0K8U69fcAFnv5pGYuETNO+0vEFDvG/dLmv8T/Eg==
X-Received: by 2002:a05:620a:3c3:: with SMTP id r3mr29477418qkm.35.1621875008732;
        Mon, 24 May 2021 09:50:08 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id m4sm10854676qtg.21.2021.05.24.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:50:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 24 May 2021 12:50:07 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue fixes for v5.13-rc3
Message-ID: <YKvZP+qDl1+NvbW3@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

One commit to fix spurious workqueue stall warnings across VM suspensions.

Thanks.

The following changes since commit c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727:

  Merge tag 'fs.idmapped.mount_setattr.v5.13-rc3' of gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux (2021-05-19 06:12:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.13-fixes

for you to fetch changes up to 940d71c6462e8151c78f28e4919aa8882ff2054e:

  wq: handle VM suspension in stall detection (2021-05-20 12:58:30 -0400)

----------------------------------------------------------------
Sergey Senozhatsky (1):
      wq: handle VM suspension in stall detection

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
 
