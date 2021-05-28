Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41B03947CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhE1UKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhE1UKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:10:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E67C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:09:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p20so6755643ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Snrm7Eq0jd3azUjgEOUu9XxUkBvVLdhzgaRCxlCyX7k=;
        b=QgTYeUp+OrurYdfF4Lg9RS222b8Ez+CLXgYA5/rn0gPaRG630iHpK/Kh+c4RqCarkL
         HGxUYvff7oOVogmypnF1bc0OVIH6Kwhqn9kPhMeXswHFFpnIGF0F2/eIQt7yrFYsGdnr
         UPGnc3ArTFIlorEmpG9k1zDlpbyf4x91yKHxS4a2islaUNhZQ+KrB3pTKJAgFKJctX9A
         ATculzDqe1dmgq/LUXVWml7XjR9PS2S4CFWYq3AdoabVG7z2PF+yERMpmRUNPibDmdUE
         iKnWHEyfMNFZz5ebXkxnAyoDxJLtAyS3cQmH5KVTWvTOnB455K6oNcJ7S9zJ5HA4rHK0
         k/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Snrm7Eq0jd3azUjgEOUu9XxUkBvVLdhzgaRCxlCyX7k=;
        b=lGHM6VqDnDXwkFbF1RmPxK/c0v4ZniFY35fnhCFciOXlifCtYjVkv2aJthzLVdp3r2
         QRhO8LWRsKTBGBmm1FKrhutNQOi5gBrww75u2nbLduzlxHgLVRASuYNfGVq0urSAW2r9
         aBZbUMu7p61u8eOIPc65JD8xFBJ622dlks+4zPXT8gsFEf2KM2hSW+13sLS0XVxp2AQW
         wkMnFG8mdYQo0p+cB5VVSQHV9/EgMxPgZm7hpr3g38iXjidEWnVis+sTrjwj4Pr1hKz5
         0RjsVvRgrA61dnocRHS1q6jluAZmFg5BadlZXSqrroDrorEr5PlctXNlX3jTURiBP6WE
         pSuw==
X-Gm-Message-State: AOAM532vTTqavyZHSCJyiVNkEseI00jq1UR98rZvvElwCV4aAR4tjCwv
        sQTOr9dqUDCkXeaD42Tix3vVxZMcB/uS5Q==
X-Google-Smtp-Source: ABdhPJz/CCv8HDYNa0jPcdFUJhIjaHJEFnhaf46tbZ8QgzLoqCFQNWoE2vyzA6+7kYSIc5ZGfzYj1Q==
X-Received: by 2002:a2e:b5d5:: with SMTP id g21mr7799416ljn.157.1622232541309;
        Fri, 28 May 2021 13:09:01 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yg81q1---xrfn1y-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:bcab:6bff:fe6e:22ea])
        by smtp.gmail.com with ESMTPSA id n130sm601819lfa.10.2021.05.28.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:09:00 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     samitolvanen@google.com
Cc:     wcw@google.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [PATCH 3/6] pgo: modules Add module profile data export machinery.
Date:   Fri, 28 May 2021 23:08:21 +0300
Message-Id: <20210528200821.459214-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGO profile data is exported from the kernel by
creating debugfs files: pgo/<module>.profraw for each module.

Modules are register into the profiler via module notifier callback
similiar to gcov/base.c. Note that if module does not have __llvm_prf_xxx
sections required the module ignored.

Also there is no "reset" support for yet for these files.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/Makefile     |   2 +-
 kernel/pgo/fs.c         |  54 ++++--
 kernel/pgo/fs_mod.c     | 415 ++++++++++++++++++++++++++++++++++++++++
 kernel/pgo/instrument.c |  12 +-
 kernel/pgo/pgo.h        |  11 +-
 5 files changed, 466 insertions(+), 28 deletions(-)
 create mode 100644 kernel/pgo/fs_mod.c

diff --git a/kernel/pgo/Makefile b/kernel/pgo/Makefile
index 41e27cefd9a4..662b7dfdfbe9 100644
--- a/kernel/pgo/Makefile
+++ b/kernel/pgo/Makefile
@@ -2,4 +2,4 @@
 GCOV_PROFILE	:= n
 PGO_PROFILE	:= n
 
-obj-y	+= fs.o instrument.o
+obj-y	+= fs.o fs_mod.o instrument.o
diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 575142735273..5471d270a5bb 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -227,15 +227,15 @@ static unsigned long prf_buffer_size(void)
  * Serialize the profiling data into a format LLVM's tools can understand.
  * Note: caller *must* hold pgo_lock.
  */
-static int prf_serialize(struct prf_private_data *p)
+static int prf_serialize(struct prf_private_data *p, unsigned long *buf_size)
 {
 	int err = 0;
 	void *buffer;
 
-	p->size = prf_buffer_size();
-	p->buffer = vzalloc(p->size);
+	/* re-check buffer size */
+	*buf_size = prf_buffer_size();
 
-	if (!p->buffer) {
+	if (p->size < *buf_size || !p->buffer) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -262,7 +262,8 @@ static int prf_open(struct inode *inode, struct file *file)
 {
 	struct prf_private_data *data;
 	unsigned long flags;
-	int err;
+	unsigned long buf_size;
+	int err = 0;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -270,18 +271,41 @@ static int prf_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	/* estimate amount of memory needed:
+	 * can't vzalloc() while prf_lock() is held:
+	 * CONFIG_DEBUG_ATOMIC_SLEEP complains.
+	 * So first get buffer size, release the lock,
+	 * vzalloc(), re-lock and try serialize.
+	 */
 	flags = prf_lock();
+	buf_size = prf_buffer_size();
 
-	err = prf_serialize(data);
-	if (unlikely(err)) {
-		kfree(data);
-		goto out_unlock;
-	}
+	do {
+		prf_unlock(flags);
 
-	file->private_data = data;
+		/* resize buffer */
+		if (data->size < buf_size && data->buffer) {
+			vfree(data->buffer);
+			data->buffer = NULL;
+		}
+
+		if (!data->buffer) {
+			data->size = buf_size;
+			data->buffer = vzalloc(data->size);
 
-out_unlock:
+			if (!data->buffer) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+		/* try serialize */
+		flags = prf_lock();
+	} while (prf_serialize(data, &buf_size));
 	prf_unlock(flags);
+
+	data->size = buf_size;
+	file->private_data = data;
+
 out:
 	return err;
 }
@@ -363,6 +387,8 @@ static const struct file_operations prf_reset_fops = {
 /* Create debugfs entries. */
 static int __init pgo_init(void)
 {
+	pr_notice("Clang PGO profile data available.");
+
 	directory = debugfs_create_dir("pgo", NULL);
 	if (!directory)
 		goto err_remove;
@@ -375,6 +401,8 @@ static int __init pgo_init(void)
 				 &prf_reset_fops))
 		goto err_remove;
 
+	prf_modules_init();
+
 	return 0;
 
 err_remove:
@@ -385,6 +413,8 @@ static int __init pgo_init(void)
 /* Remove debugfs entries. */
 static void __exit pgo_exit(void)
 {
+	prf_modules_exit();
+
 	debugfs_remove_recursive(directory);
 }
 
diff --git a/kernel/pgo/fs_mod.c b/kernel/pgo/fs_mod.c
new file mode 100644
index 000000000000..0808d44227f1
--- /dev/null
+++ b/kernel/pgo/fs_mod.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Jarmo Tiitto
+ *
+ * Author:
+ *	Jarmo Tiitto <jarmo.tiitto@gmail.com>
+ *
+ * Based on the clang PGO kernel patch by:
+ *  Sami Tolvanen <samitolvanen@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define pr_fmt(fmt)	"pgo: " fmt
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include "pgo.h"
+
+/*
+ * PGO profile data reporting for modules:
+ * We maintain one debugfs pgo/<module>.profraw file per module.
+ */
+
+
+DEFINE_MUTEX(prf_mod_lock);
+LIST_HEAD(prf_mod_list);
+
+struct prf_mod_data {
+	void *buffer;
+	unsigned long size;
+};
+
+/* these are trivial, but each one differs a bit */
+static inline unsigned long prf_mod_data_size(struct module *mod)
+{
+	return mod->prf_data_size;
+}
+
+static inline unsigned long prf_mod_data_count(struct module *mod)
+{
+	return mod->prf_data_size / sizeof(struct llvm_prf_data);
+}
+
+static inline unsigned long prf_mod_cnts_size(struct module *mod)
+{
+	return mod->prf_cnts_num * sizeof(mod->prf_cnts[0]);
+}
+
+static inline unsigned long prf_mod_cnts_count(struct module *mod)
+{
+	return mod->prf_cnts_num;
+}
+
+static inline unsigned long prf_mod_names_size(struct module *mod)
+{
+	return mod->prf_names_num * sizeof(mod->prf_names[0]);
+}
+
+static inline unsigned long prf_mod_names_count(struct module *mod)
+{
+	return mod->prf_names_num;
+}
+
+static inline unsigned long prf_mod_vnds_size(struct module *mod)
+{
+	return mod->prf_vnds_size;
+}
+
+static inline unsigned long prf_mod_vnds_count(struct module *mod)
+{
+	return mod->prf_vnds_size / sizeof(struct llvm_prf_value_node);
+}
+
+/*
+ * Raw profile data format:
+ *
+ *	- llvm_prf_header
+ *	- __llvm_prf_data
+ *	- __llvm_prf_cnts
+ *	- __llvm_prf_names
+ *	- zero padding to 8 bytes
+ *	- for each llvm_prf_data in __llvm_prf_data:
+ *		- llvm_prf_value_data
+ *			- llvm_prf_value_record + site count array
+ *				- llvm_prf_value_node_data
+ *				...
+ *			...
+ *		...
+ */
+
+static void prf_module_fill_header(struct module *mod, void **buffer)
+{
+	struct llvm_prf_header *header = *(struct llvm_prf_header **)buffer;
+
+#ifdef CONFIG_64BIT
+	header->magic = LLVM_INSTR_PROF_RAW_MAGIC_64;
+#else
+	header->magic = LLVM_INSTR_PROF_RAW_MAGIC_32;
+#endif
+	header->version = LLVM_VARIANT_MASK_IR_PROF | LLVM_INSTR_PROF_RAW_VERSION;
+	header->data_size = prf_mod_data_count(mod);
+	header->padding_bytes_before_counters = 0;
+	header->counters_size = prf_mod_cnts_count(mod);
+	header->padding_bytes_after_counters = 0;
+	header->names_size = prf_mod_names_count(mod);
+	header->counters_delta = (u64)mod->prf_cnts;
+	header->names_delta = (u64)mod->prf_names;
+	header->value_kind_last = LLVM_INSTR_PROF_IPVK_LAST;
+
+	*buffer += sizeof(*header);
+}
+
+/*
+ * Copy the source into the buffer, incrementing the pointer into buffer in the
+ * process.
+ */
+static void prf_copy_to_buffer(void **buffer, const void *src, unsigned long size)
+{
+	memcpy(*buffer, src, size);
+	*buffer += size;
+}
+
+/* extern u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds) */
+
+static u32 prf_module_get_value_size(struct module *mod)
+{
+	u32 size = 0;
+	struct llvm_prf_data *p;
+	struct llvm_prf_data *start = mod->prf_data;
+	struct llvm_prf_data *end = start + prf_mod_data_count(mod);
+
+	for (p = start; p < end; p++)
+		size += __prf_get_value_size(p, NULL);
+
+	return size;
+}
+
+/* Serialize the profiling's value.
+ * extern void prf_serialize_value(struct llvm_prf_data *p, void **buffer)
+ */
+
+static void prf_module_serialize_values(struct module *mod, void **buffer)
+{
+	struct llvm_prf_data *p;
+	struct llvm_prf_data *start = mod->prf_data;
+	struct llvm_prf_data *end = start + prf_mod_data_count(mod);
+
+	for (p = start; p < end; p++)
+		prf_serialize_value(p, buffer);
+}
+
+static inline unsigned long prf_get_padding(unsigned long size)
+{
+	return 7 & (sizeof(u64) - size % sizeof(u64));
+}
+
+static unsigned long prf_module_buffer_size(struct module *mod)
+{
+	return sizeof(struct llvm_prf_header) +
+			prf_mod_data_size(mod)	+
+			prf_mod_cnts_size(mod) +
+			prf_mod_names_size(mod) +
+			prf_get_padding(prf_mod_names_size(mod)) +
+			prf_module_get_value_size(mod);
+}
+
+/*
+ * Serialize the profiling data into a format LLVM's tools can understand.
+ * Note: caller *must* hold pgo_lock and hold reference to the module.
+ */
+static int prf_module_serialize(struct module *mod, struct prf_mod_data *p, unsigned long *buf_size)
+{
+	int err = 0;
+	void *buffer;
+
+	/* re-check buffer size */
+	*buf_size = prf_module_buffer_size(mod);
+
+	if (p->size < *buf_size || !p->buffer) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	buffer = p->buffer;
+
+	prf_module_fill_header(mod, &buffer);
+	prf_copy_to_buffer(&buffer, mod->prf_data,  prf_mod_data_size(mod));
+	prf_copy_to_buffer(&buffer, mod->prf_cnts,  prf_mod_cnts_size(mod));
+	prf_copy_to_buffer(&buffer, mod->prf_names, prf_mod_names_size(mod));
+	buffer += prf_get_padding(prf_mod_names_size(mod));
+
+	prf_module_serialize_values(mod, &buffer);
+
+out:
+	return err;
+}
+
+/* open() implementation for module PGO. */
+static int prf_module_open(struct inode *inode, struct file *file)
+{
+	struct prf_mod_private_data *data;
+	struct prf_mod_data *pinfo;
+	struct module *mod;
+	unsigned long flags;
+	unsigned long buf_size = 0;
+	int err = 0;
+
+	mutex_lock(&prf_mod_lock);
+	data = inode->i_private; /* see: pgo_module_notifier() */
+
+	BUG_ON(!data);
+
+	/* grab the module */
+	mod = READ_ONCE(data->mod);
+	if (mod && try_module_get(mod)) {
+		// Is it live?
+		if (mod->state != MODULE_STATE_LIVE) {
+			err = -EAGAIN;
+			goto put_unlock;
+		}
+
+		pinfo = kzalloc(sizeof(*pinfo), GFP_KERNEL);
+		if (!pinfo) {
+			err = -ENOMEM;
+			goto put_unlock;
+		}
+
+		mutex_unlock(&prf_mod_lock);
+
+		/* estimate amount of memory needed:
+		 * can't vzalloc() while prf_lock() is held
+		 * and prf_module_buffer_size() only works while it is held..
+		 */
+		flags = prf_lock();
+		buf_size = prf_module_buffer_size(mod);
+		do {
+			prf_unlock(flags);
+
+			/* resize buffer */
+			if (pinfo->size < buf_size && pinfo->buffer) {
+				vfree(pinfo->buffer);
+				pinfo->buffer = NULL;
+			}
+
+			if (!pinfo->buffer) {
+				pinfo->size = buf_size;
+				pinfo->buffer = vzalloc(pinfo->size);
+
+				if (!pinfo->buffer) {
+					err = -ENOMEM;
+					goto out;
+				}
+			}
+
+			/* try serialize */
+			flags = prf_lock();
+
+		} while (prf_module_serialize(mod, pinfo, &buf_size));
+
+		prf_unlock(flags);
+
+		/* success! */
+		pinfo->size = buf_size;
+		file->private_data = pinfo;
+
+		module_put(mod);
+		return err;
+	}
+
+put_unlock:
+	module_put(mod);
+	mutex_unlock(&prf_mod_lock);
+out:
+	return err;
+}
+
+/* read() implementation for PGO. */
+static ssize_t prf_module_read(struct file *file, char __user *buf, size_t count,
+			loff_t *ppos)
+{
+	struct prf_mod_data *pinfo = file->private_data;
+
+	BUG_ON(!pinfo);
+
+	return simple_read_from_buffer(buf, count, ppos, pinfo->buffer,
+					   pinfo->size);
+}
+
+/* release() implementation for PGO. Release resources allocated by open(). */
+static int prf_module_release(struct inode *inode, struct file *file)
+{
+	struct prf_mod_data *pinfo = file->private_data;
+
+	if (pinfo) {
+		vfree(pinfo->buffer);
+		kfree(pinfo);
+		file->private_data = 0;
+	}
+	return 0;
+}
+
+static const struct file_operations prf_mod_fops = {
+	.owner		= THIS_MODULE,
+	.open		= prf_module_open,
+	.read		= prf_module_read,
+	.llseek		= default_llseek,
+	.release	= prf_module_release
+};
+
+static void prf_module_free(struct rcu_head *rcu)
+{
+	struct prf_mod_private_data *data;
+
+	data = container_of(rcu, struct prf_mod_private_data, rcu);
+
+	debugfs_remove(data->file);
+
+	kfree(data);
+}
+
+static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
+				void *pdata)
+{
+	struct module *mod = pdata;
+	struct prf_mod_private_data *data;
+	char fsname[MODULE_NAME_LEN + 9]; // +strlen(".profraw")
+
+	if (event == MODULE_STATE_LIVE) {
+		/* does the module have profiling info? */
+		if (mod->prf_data
+			  && mod->prf_cnts
+			  && mod->prf_names
+			  && mod->prf_vnds) {
+			/* add module prf_mod_private_data entry */
+			data = kzalloc(sizeof(*data), GFP_KERNEL);
+
+			fsname[0] = 0;
+			snprintf(fsname, sizeof(fsname), "%s.profraw", mod->name);
+
+			mutex_lock(&prf_mod_lock);
+
+			data->file = debugfs_create_file(fsname, 0600, directory, data, &prf_mod_fops);
+			if (!data->file) {
+				pr_err("Failed setup module pgo: %s", fsname);
+				kfree(data);
+				mutex_unlock(&prf_mod_lock);
+				return NOTIFY_OK;
+			}
+
+			WRITE_ONCE(data->mod, mod);
+
+			list_add_tail_rcu(&data->link, &prf_mod_list);
+			mutex_unlock(&prf_mod_lock);
+		}
+	}
+	if (event == MODULE_STATE_GOING) {
+		/* remove module from the list */
+		rcu_read_lock();
+		list_for_each_entry_rcu(data, &prf_mod_list, link) {
+			if (strcmp(data->mod->name, mod->name) == 0) {
+
+				mutex_lock(&prf_mod_lock);
+				/* remofe from profiled modules */
+				list_del_rcu(&data->link);
+				/* mark it stale */
+				WRITE_ONCE(data->mod, NULL);
+				mutex_unlock(&prf_mod_lock);
+				call_rcu(&data->rcu, prf_module_free);
+				break;
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pgo_module_nb = {
+	.notifier_call = pgo_module_notifier
+};
+
+void prf_modules_init(void)
+{
+	register_module_notifier(&pgo_module_nb);
+}
+
+void prf_modules_exit(void)
+{
+	struct prf_mod_private_data *p;
+
+	/* unsubscribe the notifier and do cleanup. */
+	unregister_module_notifier(&pgo_module_nb);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(p, &prf_mod_list, link) {
+		/* delete nodes */
+		list_del(&p->link);
+		WRITE_ONCE(p->mod, NULL);
+		call_rcu(&p->rcu, prf_module_free);
+	}
+	rcu_read_unlock();
+}
\ No newline at end of file
diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 464b3bc77431..98cfa11a7b76 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -139,11 +139,11 @@ EXPORT_SYMBOL(__llvm_profile_instrument_target);
 
 /* Counts the number of times a range of targets values are seen. */
 void __llvm_profile_instrument_range(u64 target_value, void *data,
-				     u32 index, s64 precise_start,
-				     s64 precise_last, s64 large_value);
+					 u32 index, s64 precise_start,
+					 s64 precise_last, s64 large_value);
 void __llvm_profile_instrument_range(u64 target_value, void *data,
-				     u32 index, s64 precise_start,
-				     s64 precise_last, s64 large_value)
+					 u32 index, s64 precise_start,
+					 s64 precise_last, s64 large_value)
 {
 	if (large_value != S64_MIN && (s64)target_value >= large_value)
 		target_value = large_value;
@@ -176,9 +176,9 @@ static u64 inst_prof_get_range_rep_value(u64 value)
  * defined in compiler-rt/include/profile/InstrProfData.inc.
  */
 void __llvm_profile_instrument_memop(u64 target_value, void *data,
-				     u32 counter_index);
+					 u32 counter_index);
 void __llvm_profile_instrument_memop(u64 target_value, void *data,
-				     u32 counter_index)
+					 u32 counter_index)
 {
 	u64 rep_value;
 
diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
index a9ff51abbfd5..2840da63c7cd 100644
--- a/kernel/pgo/pgo.h
+++ b/kernel/pgo/pgo.h
@@ -212,17 +212,13 @@ struct prf_mod_private_data {
 	struct list_head link;
 	struct rcu_head rcu;
 
-	void *buffer;
-	unsigned long size;
-
-	char mod_name[MODULE_NAME_LEN];
 	struct module *mod;
 	struct dentry *file;
 
 	int current_node;
 };
 
-/* Mutex protecting the prf_mod_list and entries */
+/* Mutex protecting the prf_mod_list */
 extern struct mutex prf_mod_lock;
 
 /* List of modules profiled */
@@ -231,10 +227,7 @@ extern struct list_head prf_mod_list;
 extern void prf_modules_init(void);
 extern void prf_modules_exit(void);
 
-/* Update each modules snapshot of the profiling data. */
-extern int prf_modules_snapshot(void);
-
-/* below funcs are required by prf_modules_snapshot() */
+/* below funcs are required by prf_modules */
 extern u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds);
 
 extern void prf_serialize_value(struct llvm_prf_data *p, void **buffer);
-- 
2.31.1

