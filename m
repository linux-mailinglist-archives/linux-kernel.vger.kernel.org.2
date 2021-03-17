Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0FB33EB50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCQIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCQIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:20:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22730C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:20:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x29so24334124pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+YIvsQNHBiEowjLaixSFjAqcdYjxsY3OeuT3qGmIrM=;
        b=F2GdluX97Af45M/MOMhZVK64XKb98gp9rUNslg3uIdN9lHrY/nNYfMq5SEn3y5Ay3S
         UHIZjVgZ9C4iJeUK23sYLpMBpI5oPAvoPKkN9x0OIhLB9zeIXx0LwVKPdVpZRy4zGDI0
         ldSfeWaB0vKOr7ibW1n299Rw8e6HJIXigfOOZyld9lJuogoX/qxFTNsbZeDxs6QWH+wB
         mhdnU8a7ZNM4+gOvXHRnCN3uClhGyprIzUBWzIuS1lilFxLXHF5K4jhDFIaNGSpYmJHG
         pXoKgwspSoocO6Cw3myaxEWpSTigpzFtF4dhTerBvkPBHklsPd4UHa0cabjaITUkXOlE
         hUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+YIvsQNHBiEowjLaixSFjAqcdYjxsY3OeuT3qGmIrM=;
        b=G9QM2RLtwBcJqi1AGOMO1f846Y6ccs7hmwChYvPo3uMiyc3WUZY+uaVCV/imm3DAGY
         YvSXBS0pJ+DUAiBAPu0l6jHngtcbaOTdMgyK3L+09Bz+Ur63nhQBQgTCTiNv2AUvk24g
         4zJy26XbELvXQzLZSHbG1DufmXeDVQYT7bh0yD+JfEOiohLDh2nzDaMJ4aIST6Auag0+
         UFAybbh2NWyVTe2qTssKfAyKrD+BaFnI23/JCM7X/xZwS2eGdvZueMYyC0bBEbybTjVf
         H9UlQIkqWvrPiANs5Lhe/5e+lZDMUIXqNxFnCa7b8Qz9T4I7FJTgrUqlJTYuihCwEcNC
         4jfA==
X-Gm-Message-State: AOAM531aUh3mCV8olMgfTW7ZyVjuqENtq6PeWmEaM1NseP/VyENXmruY
        V9I/erQ9oEId9iIoypKY1PjTnUasL2OXQQ==
X-Google-Smtp-Source: ABdhPJzPF4Aoqb0BPsfQ3vss96oIuldIOc8tD/cR7t7qmhmswHFPzCvC+ggsaszeKemUuItakMTR9g==
X-Received: by 2002:a63:1a51:: with SMTP id a17mr1641602pgm.125.1615969231734;
        Wed, 17 Mar 2021 01:20:31 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id o13sm19332153pgv.40.2021.03.17.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:20:31 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     christian@brauner.io, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] kernel:fork: Fix typo issue
Date:   Wed, 17 Mar 2021 16:20:31 +0800
Message-Id: <20210317082031.11692-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'ancestoral' to 'ancestral'
change 'reuseable' to 'reusable'
delete 'do' grammatically

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0acc8ed1076b..ba52ead9d288 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1139,7 +1139,7 @@ void mmput_async(struct mm_struct *mm)
  * invocations: in mmput() nobody alive left, in execve task is single
  * threaded. sys_prctl(PR_SET_MM_MAP/EXE_FILE) also needs to set the
  * mm->exe_file, but does so without using set_mm_exe_file() in order
- * to do avoid the need for any locks.
+ * to avoid the need for any locks.
  */
 void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 {
@@ -1737,7 +1737,7 @@ static int pidfd_release(struct inode *inode, struct file *file)
  * /proc/<pid>/status where Pid and NSpid are always shown relative to
  * the  pid namespace of the procfs instance. The difference becomes
  * obvious when sending around a pidfd between pid namespaces from a
- * different branch of the tree, i.e. where no ancestoral relation is
+ * different branch of the tree, i.e. where no ancestral relation is
  * present between the pid namespaces:
  * - create two new pid namespaces ns1 and ns2 in the initial pid
  *   namespace (also take care to create new mount namespaces in the
@@ -2726,8 +2726,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 		return false;
 
 	/*
-	 * - make the CLONE_DETACHED bit reuseable for clone3
-	 * - make the CSIGNAL bits reuseable for clone3
+	 * - make the CLONE_DETACHED bit reusable for clone3
+	 * - make the CSIGNAL bits reusable for clone3
 	 */
 	if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
 		return false;
-- 
2.25.1

