Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAED3C236A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhGIMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhGIMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:30:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6180C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 05:27:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b12so8573762pfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fE0Dne1h5bAxI4O1/CQzPMn/t0RrZprT0Cm6d5DM/Zs=;
        b=E5ff6SHHXOqKedBxsbjEoWoyB1JCax2IKfLx+Q7nq+RpHvUcgZdvB0FtgiI0gNpIbR
         61F5C5weVZsQNmuN1nFAiiPKBztcykQfdAnktW0JyW7XKdTClGfoJE1RxclHW1NWU8Sv
         98RT8gKPqv9CNMc80or06upJxbBmd7GT2If1dvdJgBpYVpbZbo1s5Dp5peEh6wRXI73W
         2+MuIZYFNJlsraqeUzIsSzwdsC+97QKmQd702aM9nEzgPyg8C2oOveH9Bk4gUjBSN2rT
         t8hdHC7ZMoKgkc2lzVonXOg+QkTF7enyOKYFMuKTsfCtgqxOQGk+GITOcWz3Z/IYs9+a
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fE0Dne1h5bAxI4O1/CQzPMn/t0RrZprT0Cm6d5DM/Zs=;
        b=FzUUsrRl2UxTg7hkQj0HiVHWZrNlTufCJCp7lk19DJceJG5PQvk+rNlDxBmiHg2Tc+
         reoc/fmozTgxQ1dysQZuITXtPhGWSSM3F6wrfGBbVyohWoRCi4CvDNrOVJCQJpNFsxRb
         d9ISuI4oORvZ4Vw/NO04MXWd5GKmMd1p6eN6/xsJ/Jmc6a+jqkx1eXc8kjnEaln8INYH
         PAwIQpGFr6VK5wkSuHJc1Cvlr04UKrCTJHVXG23TJuDE5W/LcgHu52GR5+I9Q961WDNs
         37tNek7FjDncseT+cLWvpCDDRsnEO3VcerSonGFqMM/fcNHAtXyAx4DfRz7WNy5X1GyT
         AkRQ==
X-Gm-Message-State: AOAM530Klqoa2LhORK/kX0Jrapt8d1o6p+hSKf1SvsPlWTrIu12SHgMs
        wW4/e5A3emy9t+/9qVNQ7TI=
X-Google-Smtp-Source: ABdhPJwJFVIItO27Z7piUEFt7/ryxpcK40iEMKLc5/nm1ZwQBuLckO8JKCPt0xFyLv3V5B020gOo5g==
X-Received: by 2002:a05:6a00:bd5:b029:328:92ef:d3d8 with SMTP id x21-20020a056a000bd5b029032892efd3d8mr4747415pfu.51.1625833643284;
        Fri, 09 Jul 2021 05:27:23 -0700 (PDT)
Received: from localhost.localdomain (f.a4.5177.ip4.static.sl-reverse.com. [119.81.164.15])
        by smtp.gmail.com with ESMTPSA id g7sm3885986pfm.5.2021.07.09.05.27.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jul 2021 05:27:23 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     axboe@kernel.dk, oleg@redhat.comm
Cc:     linux-kernel@vger.kernel.org, yaozhenguo@jd.com,
        yaozhenguo <yaozhenguo1@gmail.com>
Subject: [PATCH] task_work: return -EBUSY when adding same work
Date:   Fri,  9 Jul 2021 20:27:12 +0800
Message-Id: <20210709122712.42844-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when same work is added to task->task_works list one by one,
the list becomes endless loop. So return -EBUSY when this
situation happen.

Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
---
 kernel/task_work.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe..5061ebf 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -27,7 +27,7 @@
  * list is LIFO.
  *
  * RETURNS:
- * 0 if succeeds or -ESRCH.
+ * 0 if succeeds or -ESRCH, -EBUSY.
  */
 int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
@@ -41,6 +41,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		head = READ_ONCE(task->task_works);
 		if (unlikely(head == &work_exited))
 			return -ESRCH;
+		if (unlikely(head == work))
+			return -EBUSY;
 		work->next = head;
 	} while (cmpxchg(&task->task_works, head, work) != head);
 
-- 
1.8.3.1

