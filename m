Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121124568F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhKSEQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhKSEQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:16:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CCAC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:13:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v19so7135202plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkJr7D3eRBWMyEf12kTub/VW3BcE0Ew/aGYjvq0iqXI=;
        b=fsMJ3phTZGMNX103H++zeLMniFct1AvIUTUd9mAl75C8uwURHQmPnc1mJZxbfYl1Kx
         5StH7TD9TcghPbVMaCyd+mAkrBNTFANfR+f5rXUW54MN5C0s+gO/FFfBWshctoYVBeqp
         9ByprV6cZPjQzUU3bXWt71sJwB4wdGrtH3iK+Ap/cFd64ZDBtoH54zO5/8wfy8qj3PPp
         /2VLW/k44tdClUzFPMRxiMY6E/5l7eRdjksDbIAz7ixkhpe60WqgN/W+VPrwInP+yL0A
         Ha2tdxypX5Tp0DKhrHQjj1MxgvkL5P44F4njDF7cxkV7sR8hz2/3B/UMlADFQvYLxrOP
         gtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkJr7D3eRBWMyEf12kTub/VW3BcE0Ew/aGYjvq0iqXI=;
        b=IOQe9+ulry0GzTtLpVS/GFgo3ggYXX7kIiiHR2By5JjvI3gI9Q8vY4HiIiODC/vNE4
         gFOeiXZjYyW2MBLJdlKrY9x8JqQsJFjQImsza+nLbrRBVT5gb5qGUpTasxz3lq5iwtLp
         0oDkmVpBf87ZT87XcGBItyHPmT3VFqV7/9YMG28k5sXbjKpskXnjRkroMlrIjvC6p/ce
         9FvNQHTiuetwB1qQjP70VQe6yF/OPR+W4mgqfhAObSnziBt8m7rDhGKONYLwBc8iNFmG
         WskRzHvYyiPzdNUvr7EsKaG8ICP8oN4pjHVqcM/3/S3utql8+oub2V5+jyVePN2Ydxcc
         K2/A==
X-Gm-Message-State: AOAM532Shz6nHCeJJRJvrvCG5P7HG6RoeaEX2xLo9XF3+/JeEj/xwMZB
        /bbO35ax1vzDM8/UQa68jhNtHA==
X-Google-Smtp-Source: ABdhPJyzIbFJ03TmW8I57PetAOSK9TPQAjpqRd3Lkpsg9a7dXbK46d7OYuZZqGuwJ87vZCZVYaY70w==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr893046pju.77.1637295224478;
        Thu, 18 Nov 2021 20:13:44 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id u4sm868486pgg.24.2021.11.18.20.13.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 20:13:44 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] fs: proc: store PDE()->data into inode->i_private
Date:   Fri, 19 Nov 2021 12:11:04 +0800
Message-Id: <20211119041104.27662-1-songmuchun@bytedance.com>
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

