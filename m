Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4491E3A4C72
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFLDhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFLDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:37:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E300C061767
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:35:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j2so11524602lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCeBQNr6icOysF7Nkzxw/gw9Ksd4H9stZ7+QUzEfhug=;
        b=P+z4J2NtJZe92adFLJ30hBvvBk+ojN/XSo9GQW34sNx7+5+JXc+DrFxU2C6WtTp0L2
         +ZUlHFwvuC75AsVFWpDpksuvy7zs/lyey4aVa5hno+B3uP+B3dJ+OC8zl0CsMOrtL0tv
         t8jNA6f9uwCVI4HFhXNALPu8pLKyULlFIt5GoMHZIuDOenXGG1heWoNyPfGB3XDu4MBn
         V2qHQLZwDaGJszd2b+DqL/c3GbsrdxZM6JSOA2TxoMbN/ZNulGUxJcnPYsPZyI93CTeW
         qyrvJQomCgQvx/lL0YzB3RJm8mNuV+kUmQXmL3KFn+qVXP7GiiQCq/PwhdwEmPaXdxFp
         AlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCeBQNr6icOysF7Nkzxw/gw9Ksd4H9stZ7+QUzEfhug=;
        b=jwW4OuWY5R7cHcWqT2muWc8IZqWjiuCHbLwRqjYqTGulH/79ZmFiZ1K81JQeB34wA2
         ERMPlbUjO3uj1IfkvSmf8I27VZWGUGYixPyCWxa1zXWm/khXlsGmq2j4YpB/0wpsc9Ls
         YWOKWf1k4DK/Itp/5RfHsbTvv1kVRFIJBI0J8D6vmGE8MQiWzx7O/vNiyYnSuRYztcao
         k1FDVWvTpUSd0fUwvFH6ySnS2l6qiJ76GFG/w7uJlPyodDPWKV1a66heZ3N9x96C6nCf
         xl1JdklC+FRLlFsahY/ow+JE61uP2b1yIpGTOEZ3nidmtsgowbAxQ0Vb8i2LctECZakW
         w29w==
X-Gm-Message-State: AOAM530B+avjT4jaOo7Pw7cOzkf18JpvHj6BguGVnWI0vKvsUva1Spaj
        puPm3WWTJBS765WtEEnxq14=
X-Google-Smtp-Source: ABdhPJxEPwbuFm+YQF4ySAOjVChnpAisa/z7Gfgl4mS5W6LRQV/KnBaoVNAjzO33HC0NvDiK8xkbng==
X-Received: by 2002:ac2:548d:: with SMTP id t13mr4618391lfk.568.1623468909578;
        Fri, 11 Jun 2021 20:35:09 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ydkw9h---3prwmt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:6897:4dff:feec:7495])
        by smtp.gmail.com with ESMTPSA id f19sm943250ljn.88.2021.06.11.20.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:35:09 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [RFC PATCH 3/5] pgo: Wire up the new more generic code for modules
Date:   Sat, 12 Jun 2021 06:24:24 +0300
Message-Id: <20210612032425.11425-4-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prf_open() now uses the inode->i_private to get
the prf_object for the file. This can be either
vmlinux.profraw or any module.profraw file.

The prf_vmlinux object is now added into prf_list and
allocate_node() scans the list and reserves vnodes
from corresponding prf_object(s).

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
note: There is no module notifier code yet,
so only vmlinux.profraw profile data
is available with this commit.

Another thing is that pgo/reset will only
reset vmlinux.profraw.
Profile data reset for modules may be added later:
maybe writing module's name into pgo/reset would reset only
the specified module's profile data?
Then writing "all" or zero would atomically reset everything.

I'm bit unsure about the new allocate_node() code since
it is the first place I had to put rcu_read_lock()
and the code is likely to change from this.
---
 kernel/pgo/fs.c         | 30 ++++++++++++++++++++-----
 kernel/pgo/instrument.c | 49 +++++++++++++++++++++++++++--------------
 kernel/pgo/pgo.h        |  2 ++
 3 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 7e269d69bcd7..84b36e61758b 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -32,8 +32,10 @@ static struct dentry *directory;
 struct prf_private_data {
 	void *buffer;
 	size_t size;
+	struct prf_object *core;
 };
 
+/* vmlinux's prf core */
 static struct prf_object prf_vmlinux;
 
 /*
@@ -281,7 +283,6 @@ static int prf_serialize(struct prf_object *po, struct prf_private_data *p, size
 	prf_serialize_values(po, &buffer);
 
 	return 0;
-
 }
 
 /* open() implementation for PGO. Creates a copy of the profiling data set. */
@@ -292,13 +293,21 @@ static int prf_open(struct inode *inode, struct file *file)
 	size_t buf_size;
 	int err = -EINVAL;
 
+	if (WARN_ON(!inode->i_private)) {
+		/* bug: inode was not initialized by us */
+		return err;
+	}
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	/* Get prf_object of this inode */
+	data->core = inode->i_private;
+
 	/* Get initial buffer size. */
 	flags = prf_lock();
-	data->size = prf_buffer_size(&prf_vmlinux);
+	data->size = prf_buffer_size(data->core);
 	prf_unlock(flags);
 
 	do {
@@ -318,12 +327,13 @@ static int prf_open(struct inode *inode, struct file *file)
 		 * data length in data->size.
 		 */
 		flags = prf_lock();
-		err = prf_serialize(&prf_vmlinux, data, buf_size);
+		err = prf_serialize(data->core, data, buf_size);
 		prf_unlock(flags);
 		/* In unlikely case, try again. */
 	} while (err == -EAGAIN);
 
 	if (err < 0) {
+
 		if (data)
 			vfree(data->buffer);
 		kfree(data);
@@ -412,6 +422,8 @@ static const struct file_operations prf_reset_fops = {
 /* Create debugfs entries. */
 static int __init pgo_init(void)
 {
+	unsigned long flags;
+
 	/* Init profiler vmlinux core entry */
 	memset(&prf_vmlinux, 0, sizeof(prf_vmlinux));
 	prf_vmlinux.data = __llvm_prf_data_start;
@@ -430,19 +442,27 @@ static int __init pgo_init(void)
 	prf_vmlinux.vnds_num = prf_get_count(__llvm_prf_vnds_start,
 		__llvm_prf_vnds_end, sizeof(__llvm_prf_vnds_start[0]));
 
+	/* enable profiling */
+	flags = prf_list_lock();
+	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
+	prf_list_unlock(flags);
 
 	directory = debugfs_create_dir("pgo", NULL);
 	if (!directory)
 		goto err_remove;
 
-	if (!debugfs_create_file("vmlinux.profraw", 0600, directory, NULL,
-				 &prf_fops))
+	prf_vmlinux.file = debugfs_create_file("vmlinux.profraw",
+		0600, directory, &prf_vmlinux, &prf_fops);
+	if (!prf_vmlinux.file)
 		goto err_remove;
 
 	if (!debugfs_create_file("reset", 0200, directory, NULL,
 				 &prf_reset_fops))
 		goto err_remove;
 
+	/* show notice why the system slower: */
+	pr_notice("Clang PGO instrumentation is active.");
+
 	return 0;
 
 err_remove:
diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 24fdeb79b674..e214c9d7a113 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/rculist.h>
 #include "pgo.h"
 
 /*
@@ -56,22 +57,38 @@ void prf_unlock(unsigned long flags)
 static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 						 u32 index, u64 value)
 {
-	const int max_vnds = prf_get_count(__llvm_prf_vnds_start,
-		__llvm_prf_vnds_end, sizeof(struct llvm_prf_value_node));
-
-	/*
-	 * Check that p is within vmlinux __llvm_prf_data section.
-	 * If not, don't allocate since we can't handle modules yet.
-	 */
-	if (!memory_contains(__llvm_prf_data_start,
-		__llvm_prf_data_end, p, sizeof(*p)))
-		return NULL;
-
-	if (WARN_ON_ONCE(current_node >= max_vnds))
-		return NULL; /* Out of nodes */
-
-	/* reserve vnode for vmlinux */
-	return &__llvm_prf_vnds_start[current_node++];
+	struct llvm_prf_value_node *vnode = NULL;
+	struct prf_object *po;
+	struct llvm_prf_data *data_end;
+	int max_vnds;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(po, &prf_list, link) {
+		/* get section limits */
+		max_vnds = prf_vnds_count(po);
+		data_end = po->data + prf_data_count(po);
+
+		/*
+		 * Check that p is within:
+		 * [po->data, po->data + prf_data_count(po)] section.
+		 * If yes, allocate vnode from this prf_object.
+		 */
+		if (memory_contains(po->data, data_end, p, sizeof(*p))) {
+
+
+			if (WARN_ON_ONCE(po->current_node >= max_vnds))
+				return NULL; /* Out of nodes */
+
+			/* reserve the vnode */
+			vnode = &po->vnds[po->current_node++];
+			goto out;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	return vnode;
 }
 
 /*
diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
index 44d79e2861e1..59d0aa966fbe 100644
--- a/kernel/pgo/pgo.h
+++ b/kernel/pgo/pgo.h
@@ -19,6 +19,8 @@
 #ifndef _PGO_H
 #define _PGO_H
 
+#include <linux/rculist.h>
+
 /*
  * Note: These internal LLVM definitions must match the compiler version.
  * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
-- 
2.32.0

