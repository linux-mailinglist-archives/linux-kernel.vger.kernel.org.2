Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C645B67A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbhKXI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbhKXI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:27:32 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB13C061714
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r5so1470260pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh4bFpXitwvwfzL1uavztuA77mG2atBzn/Q6uoVIX8E=;
        b=F83JF60W+TL49b+riCj0C5lZZ345XtooTCJQUbC1YgGtkWCbrtKtK+3oyyO1PgEQFq
         i12fOrjzADaa59rVdPpRXojmmoUk3N2Juf5eowucMvtVISyNCz8dKN0Ge65EuhpibJxG
         nR5oTVb2Cs14FE1yHzf8orDM5snHb57ca38bagNzJ5ODPENr/90W6tDR0y4hYFO9cyOU
         rVBH2sX3fRXySDxY+s+kRLxu1TmtH+RJeaqQEUfl5PcU04AZThD8Tf4icAjewbSSxIGN
         TfzggPOA/jDhYMPLi942gy+k15ZtJTEPejaJaHwhomnLQ5VGELGNZxOkThyd9K7Py5Jp
         QD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh4bFpXitwvwfzL1uavztuA77mG2atBzn/Q6uoVIX8E=;
        b=I1IznUfTlsA6BwZnEEm2jaeF1G1pDB1KRVasT4MzpfyyAmIZlhroTxZ8j5HSZpLUfO
         Ip1mnU0q6z/BME4DEc3cDeS90mcjstMRUnaKzo8C+pkdoJUm9ZFpeYe50oyVq1yhuGtL
         fbMyNkhDleAsYQ+Q0zYgajXU6DxyMHSuIqKnyzTwp8XMlFkUfdsGk0zoDLV8y6fn2Y+2
         axOQ0Ad5YLgpm80AZJuCWPOGiY07Y3Po+uC8mozvPyryN8yQWvkcZggJ3/GZxQXL37I2
         K4994Zwvbk+F5wn0lBbwZk79AH1A5pL+xk14vUEdhfZRujVXCKmJMVlqrstA5mlSD1WB
         gCLw==
X-Gm-Message-State: AOAM531Cbhk5+AJSC9yJTwgGeL7bEP4hVOcVdS7Ad1ZZgRivdsoYe+Q4
        rhUhPhdtgJNBZWqIYSuIcaeDiw==
X-Google-Smtp-Source: ABdhPJxegH4TLPUklmcdkD4ZL9rXYwWjn/75sESDo5rRm4C7C38X9J/qtGWmA+hPGL/nguRTwdIYwA==
X-Received: by 2002:a62:5142:0:b0:4a3:4d13:e7da with SMTP id f63-20020a625142000000b004a34d13e7damr4105793pfb.84.1637742262009;
        Wed, 24 Nov 2021 00:24:22 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id v38sm10451521pgl.38.2021.11.24.00.24.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 00:24:21 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/2] fs: proc: store PDE()->data into inode->i_private
Date:   Wed, 24 Nov 2021 16:19:55 +0800
Message-Id: <20211124081956.87711-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDE_DATA(inode) is introduced to get user private data and hide the
layout of struct proc_dir_entry. The inode->i_private is used to do
the same thing as well. Save a copy of user private data to inode->
i_private when proc inode is allocated. This means the user also can
get their private data by inode->i_private.

Introduce pde_data() to wrap inode->i_private so that we can remove
PDE_DATA() from fs/proc/generic.c and make PTE_DATE() as a wrapper
of pde_data(). It will be easier if we decide to remove PDE_DATE()
in the future.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changes in v3:
 - Replace PDE_DATA() with pde_data().

Changes in v2:
 - Drop all drivers related changes (do not remove PDE_DATA() completely).
 - Introduce pde_data() suggested by Andrew.

 v1: https://lkml.org/lkml/2021/11/1/575

 fs/proc/generic.c       |  6 ------
 fs/proc/inode.c         |  1 +
 fs/proc/internal.h      |  5 -----
 include/linux/proc_fs.h | 13 ++++++++++++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5b78739e60e4..f2132407e133 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -791,12 +791,6 @@ void proc_remove(struct proc_dir_entry *de)
 }
 EXPORT_SYMBOL(proc_remove);
 
-void *PDE_DATA(const struct inode *inode)
-{
-	return __PDE_DATA(inode);
-}
-EXPORT_SYMBOL(PDE_DATA);
-
 /*
  * Pull a user buffer into memory and pass it to the file's write handler if
  * one is supplied.  The ->write() method is permitted to modify the
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 599eb724ff2d..f84355c5a36d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -650,6 +650,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 		return NULL;
 	}
 
+	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	PROC_I(inode)->pde = de;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 03415f3fb3a8..06a80f78433d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -115,11 +115,6 @@ static inline struct proc_dir_entry *PDE(const struct inode *inode)
 	return PROC_I(inode)->pde;
 }
 
-static inline void *__PDE_DATA(const struct inode *inode)
-{
-	return PDE(inode)->data;
-}
-
 static inline struct pid *proc_pid(const struct inode *inode)
 {
 	return PROC_I(inode)->pid;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 069c7fd95396..b32fb0ef3308 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -110,7 +110,18 @@ extern struct proc_dir_entry *proc_create_data(const char *, umode_t,
 struct proc_dir_entry *proc_create(const char *name, umode_t mode, struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
 extern void proc_set_size(struct proc_dir_entry *, loff_t);
 extern void proc_set_user(struct proc_dir_entry *, kuid_t, kgid_t);
-extern void *PDE_DATA(const struct inode *);
+
+/*
+ * Obtain the private data passed by user through proc_create_data() or
+ * related.
+ */
+static inline void *pde_data(const struct inode *inode)
+{
+	return inode->i_private;
+}
+
+#define PDE_DATA(i)	pde_data(i)
+
 extern void *proc_get_parent_data(const struct inode *);
 extern void proc_remove(struct proc_dir_entry *);
 extern void remove_proc_entry(const char *, struct proc_dir_entry *);
-- 
2.11.0

