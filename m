Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7F3947BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhE1UGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1UGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:06:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:05:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so6979457lfr.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDXn5nAREC2MnG7P1yHKPsSirAIKNGRdyKGrRNWZ9wE=;
        b=sitbSCzyhZwF0zRikNRRVSuU+VdeIDX7VBnwcWzECD6Byc4URZ7uudw6/cVJ1Rkw9K
         QkbIKErXQHb+wQ/bI/vBEx/JveKjIYEn/Vx2mCC6rn9EjbDvj2ncHUBqCaOzvgEICN+w
         BsMyBt6x4a7qOJF69QosVZbjRPi/7AIUI9WPYQWOeNqDJrV1wvxmV0Kocng0Q1z37X7F
         NxnudLmSEmVMznLoP2e29njSRdWCdSuqppAsqCQ+da+WzMJ6Qx/q2xQCyzrvBI1CK4ja
         PX+rTREbPRHzQjFDYqw58U32a9O9ur1WVw5u+To2zxT3Hc4fPm55GwkeANW0/hJVwVs4
         54VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDXn5nAREC2MnG7P1yHKPsSirAIKNGRdyKGrRNWZ9wE=;
        b=TtVpzXnDdGiYaJduyGhxrDNGBz7F/vaQvnF1SjjCHzopj2hpIOCXFb+O0dHu9DJ2TG
         Nphv4aopCnpiC71MPbA2k5+8K2kzR3/vp0hwg98YTCEJPMI3Er30HY6MQxmOijBQGoRu
         3QTZjGQb7LS+if7QGkKBhtl0RF8r1jeAyJf8QhX51oWdqlXVtWLUcjyTxV+vi9fAHmZV
         0QNKSNgWnbkxNi/wMLA4Xn4xj3o9Iw25DCDP3hRUV1+VjYDzPC5HrTc0QH0h3iY6wgzA
         uo/VeOMkKbfrkfeNFW/q8u6RSPEhfCTjRcGnbTadwQKC/MFbAfs9BlKLV4DQtXKLPaeE
         v6qA==
X-Gm-Message-State: AOAM532If3DwSgekUt749GoAuHUNFtokOdcApkHoJlqfFiPFZvz6pPUU
        IrymGszKv2V08jog1uVoE68=
X-Google-Smtp-Source: ABdhPJxWTq93xACSOpP3YSTSWomk+88l6DSz3Htxgb7gyR41YMFUkhxzadLKTIv5K80TFFPDml7LWA==
X-Received: by 2002:a05:6512:3189:: with SMTP id i9mr6701994lfe.89.1622232301508;
        Fri, 28 May 2021 13:05:01 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yg81q1---xrfn1y-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:bcab:6bff:fe6e:22ea])
        by smtp.gmail.com with ESMTPSA id c7sm548414lfv.27.2021.05.28.13.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:05:00 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     samitolvanen@google.com
Cc:     wcw@google.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [PATCH 2/6] pgo: modules Add definitions in pgo/pgo.h for modules
Date:   Fri, 28 May 2021 23:04:32 +0300
Message-Id: <20210528200432.459120-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new function and struct definitions to pgo/pgo.h
Few functions are shared by the new machinery so mark them as extern.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/fs.c  | 13 ++++++++-----
 kernel/pgo/pgo.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 1678df3b7d64..575142735273 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -26,7 +26,7 @@
 #include <linux/vmalloc.h>
 #include "pgo.h"
 
-static struct dentry *directory;
+struct dentry *directory;
 
 struct prf_private_data {
 	void *buffer;
@@ -82,7 +82,7 @@ static void prf_copy_to_buffer(void **buffer, void *src, unsigned long size)
 	*buffer += size;
 }
 
-static u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds)
+u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds)
 {
 	struct llvm_prf_value_node **nodes =
 		(struct llvm_prf_value_node **)p->values;
@@ -140,7 +140,7 @@ static u32 prf_get_value_size(void)
 }
 
 /* Serialize the profiling's value. */
-static void prf_serialize_value(struct llvm_prf_data *p, void **buffer)
+void prf_serialize_value(struct llvm_prf_data *p, void **buffer)
 {
 	struct llvm_prf_value_data header;
 	struct llvm_prf_value_node **nodes =
@@ -254,7 +254,10 @@ static int prf_serialize(struct prf_private_data *p)
 	return err;
 }
 
-/* open() implementation for PGO. Creates a copy of the profiling data set. */
+/*
+ * open() implementation for PGO.
+ * Creates a copy of the profiling data set.
+ */
 static int prf_open(struct inode *inode, struct file *file)
 {
 	struct prf_private_data *data;
@@ -292,7 +295,7 @@ static ssize_t prf_read(struct file *file, char __user *buf, size_t count,
 	BUG_ON(!data);
 
 	return simple_read_from_buffer(buf, count, ppos, data->buffer,
-				       data->size);
+					   data->size);
 }
 
 /* release() implementation for PGO. Release resources allocated by open(). */
diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
index ddc8d3002fe5..a9ff51abbfd5 100644
--- a/kernel/pgo/pgo.h
+++ b/kernel/pgo/pgo.h
@@ -19,6 +19,11 @@
 #ifndef _PGO_H
 #define _PGO_H
 
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+
 /*
  * Note: These internal LLVM definitions must match the compiler version.
  * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
@@ -200,4 +205,38 @@ __DEFINE_PRF_SIZE(vnds);
 
 #undef __DEFINE_PRF_SIZE
 
+/* debugfs directory */
+extern struct dentry *directory;
+
+struct prf_mod_private_data {
+	struct list_head link;
+	struct rcu_head rcu;
+
+	void *buffer;
+	unsigned long size;
+
+	char mod_name[MODULE_NAME_LEN];
+	struct module *mod;
+	struct dentry *file;
+
+	int current_node;
+};
+
+/* Mutex protecting the prf_mod_list and entries */
+extern struct mutex prf_mod_lock;
+
+/* List of modules profiled */
+extern struct list_head prf_mod_list;
+
+extern void prf_modules_init(void);
+extern void prf_modules_exit(void);
+
+/* Update each modules snapshot of the profiling data. */
+extern int prf_modules_snapshot(void);
+
+/* below funcs are required by prf_modules_snapshot() */
+extern u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds);
+
+extern void prf_serialize_value(struct llvm_prf_data *p, void **buffer);
+
 #endif /* _PGO_H */
-- 
2.31.1

