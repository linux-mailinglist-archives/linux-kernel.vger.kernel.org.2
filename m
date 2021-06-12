Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571A43A4C78
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFLDiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:38:24 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:40930 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFLDiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:38:21 -0400
Received: by mail-lf1-f45.google.com with SMTP id k40so11528875lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAt0n/YZuIs0ryLpqLVa8Tl4SvxdixVNh2wyhhwKoMg=;
        b=ZC/HeMEGH1nm8dtnpAhOtNYTUqENo7dtzxc+Spn/vbMEbzxxbyXN6BwSRY2VsEWau2
         hISboB6L20t1KVRQdKluNxQs2H9je5j0CjMjwIoqcfUaTIaKcQzKkBRI3qUt9u6ySA+E
         HHc8DX7EuU7fHyPgZLy0SHpHQ1H15EffyHKRyNtgZkhsG+oayaSxplq+kzFCs8fXQT/h
         QQPOVarYe+NMlE9P7nobjtcscrS62IS/hk925264w6BPxb3ZSkqeX0NkngAa1C4dWbsW
         VmNezJ+vNPvJ0oeIbxpFsgbjbZudSRBwXjrXxkgUiaCpxNvJZh5Wb2AsEKlYwyg7BhO2
         frUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAt0n/YZuIs0ryLpqLVa8Tl4SvxdixVNh2wyhhwKoMg=;
        b=XbLDyKF9Knrh5BP9ShMvkKYKbfDfrTNl4HRbHcbM1M5q6eN2AXyRY6WDkZc15d9Uqv
         v9JWoclh61G1xSytxBoQ5Jjq8Hk12ju6DRb2soXNVFZC9fwe1XQZ71/htrRrbTYC5+rc
         P8VN4/5KVCw9P+eZgvP+smpq0MgojDoQ2UMMNjs0lLBq2oda7Q/s1zE5MXu2bjhheRRY
         XsSjrElXbN8dSJsRoF8hziLd1Pi7DCQM2zW9HduTC4qfV2fcW4dCYTyVIuriQO5v65DC
         jH0KxWFcE9tCxqfARvGJUKO2rZ71Yx5bhpZDPOB70suUjApStfts6PdOOJ5n2YdCNzmQ
         QQ4g==
X-Gm-Message-State: AOAM530GuL0P0OOUAT4289KS29J7ZlD+rZVwDkjT3TPCplOy5giNo9n7
        ymz1PGz70D+y/SBZEwJtryg=
X-Google-Smtp-Source: ABdhPJy7KOlbqhwP/9SYRDeGArT9docEKvX0TF7WOy5eZhVTci1UJ967XVFLHD63idUENrz/Tk7qJQ==
X-Received: by 2002:a05:6512:33c2:: with SMTP id d2mr4477115lfg.443.1623468908205;
        Fri, 11 Jun 2021 20:35:08 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ydkw9h---3prwmt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:6897:4dff:feec:7495])
        by smtp.gmail.com with ESMTPSA id f19sm943250ljn.88.2021.06.11.20.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:35:07 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [RFC PATCH 2/5] pgo: Make serializing functions to take prf_object
Date:   Sat, 12 Jun 2021 06:24:23 +0300
Message-Id: <20210612032425.11425-3-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add struct prf_object to hold module sections in
  the new "prf_list" linked list.

* Rewrite serialization code such that they take struct
  prf_object as an argument and work on it instead
  of the global: __llvm_prf_{data,cnts,names,vnds} sections.

* No functional user visible changes yet.

The prf_vmlinux is initialized using vmlinux core sections.
This struct is then passed down into the serializing functions.

Idea here is that the profiling nor serialization code
doesn't need to care if the prf_object points into
vmlinux's core sections or into some loaded module's sections.

* The prf_list is RCU protected so that in following commits
  allocate_node() can walk the prf_list uninterupted.

* List updaters must take the new prf_list_lock() lock.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
This is the main commit of this patch series,
since it re-structures most of the pgo/fs.c around prf_object.

I have squashed a lot of stuff into this single commit.
---
 kernel/pgo/fs.c         | 105 +++++++++++++++++++++++++++++-----------
 kernel/pgo/instrument.c |   3 +-
 kernel/pgo/pgo.h        |  83 +++++++++++++++++++++++--------
 3 files changed, 142 insertions(+), 49 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 3c5aa7c2a4ce..7e269d69bcd7 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -34,6 +34,31 @@ struct prf_private_data {
 	size_t size;
 };
 
+static struct prf_object prf_vmlinux;
+
+/*
+ * This lock guards prf_list from concurrent access:
+ * - New module is registered.
+ * - Module is unloaded.
+ * It does *not* protect any PGO serialization functions.
+ */
+DEFINE_SPINLOCK(prf_reg_lock);
+LIST_HEAD(prf_list);
+
+static inline unsigned long prf_list_lock(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&prf_reg_lock, flags);
+
+	return flags;
+}
+
+static inline void prf_list_unlock(unsigned long flags)
+{
+	spin_unlock_irqrestore(&prf_reg_lock, flags);
+}
+
 /*
  * Raw profile data format:
  *
@@ -51,7 +76,7 @@ struct prf_private_data {
  *		...
  */
 
-static void prf_fill_header(void **buffer)
+static void prf_fill_header(struct prf_object *po, void **buffer)
 {
 	struct llvm_prf_header *header = *(struct llvm_prf_header **)buffer;
 
@@ -61,13 +86,13 @@ static void prf_fill_header(void **buffer)
 	header->magic = LLVM_INSTR_PROF_RAW_MAGIC_32;
 #endif
 	header->version = LLVM_VARIANT_MASK_IR_PROF | LLVM_INSTR_PROF_RAW_VERSION;
-	header->data_size = prf_data_count();
+	header->data_size = po->data_num;
 	header->padding_bytes_before_counters = 0;
-	header->counters_size = prf_cnts_count();
+	header->counters_size = po->cnts_num;
 	header->padding_bytes_after_counters = 0;
-	header->names_size = prf_names_count();
-	header->counters_delta = (u64)__llvm_prf_cnts_start;
-	header->names_delta = (u64)__llvm_prf_names_start;
+	header->names_size = po->names_num;
+	header->counters_delta = (u64)po->cnts;
+	header->names_delta = (u64)po->names;
 	header->value_kind_last = LLVM_INSTR_PROF_IPVK_LAST;
 
 	*buffer += sizeof(*header);
@@ -77,7 +102,7 @@ static void prf_fill_header(void **buffer)
  * Copy the source into the buffer, incrementing the pointer into buffer in the
  * process.
  */
-static void prf_copy_to_buffer(void **buffer, void *src, unsigned long size)
+static void prf_copy_to_buffer(void **buffer, const void *src, unsigned long size)
 {
 	memcpy(*buffer, src, size);
 	*buffer += size;
@@ -129,12 +154,13 @@ static u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds)
 	return size;
 }
 
-static u32 prf_get_value_size(void)
+static u32 prf_get_value_size(struct prf_object *po)
 {
 	u32 size = 0;
 	struct llvm_prf_data *p;
+	struct llvm_prf_data *end = po->data + po->data_num;
 
-	for (p = __llvm_prf_data_start; p < __llvm_prf_data_end; p++)
+	for (p = po->data; p < end; p++)
 		size += __prf_get_value_size(p, NULL);
 
 	return size;
@@ -201,11 +227,12 @@ static void prf_serialize_value(struct llvm_prf_data *p, void **buffer)
 	}
 }
 
-static void prf_serialize_values(void **buffer)
+static void prf_serialize_values(struct prf_object *po, void **buffer)
 {
 	struct llvm_prf_data *p;
+	struct llvm_prf_data *end = po->data + po->data_num;
 
-	for (p = __llvm_prf_data_start; p < __llvm_prf_data_end; p++)
+	for (p = po->data; p < end; p++)
 		prf_serialize_value(p, buffer);
 }
 
@@ -215,14 +242,14 @@ static inline unsigned long prf_get_padding(unsigned long size)
 }
 
 /* Note: caller *must* hold pgo_lock */
-static unsigned long prf_buffer_size(void)
+static unsigned long prf_buffer_size(struct prf_object *po)
 {
-	return sizeof(struct llvm_prf_header) +
-			prf_data_size()	+
-			prf_cnts_size() +
-			prf_names_size() +
-			prf_get_padding(prf_names_size()) +
-			prf_get_value_size();
+	return sizeof(struct llvm_prf_header)	+
+			prf_data_size(po)	+
+			prf_cnts_size(po)	+
+			prf_names_size(po)	+
+			prf_get_padding(prf_names_size(po)) +
+			prf_get_value_size(po);
 }
 
 /*
@@ -232,12 +259,12 @@ static unsigned long prf_buffer_size(void)
  * area of at least prf_buffer_size() in size.
  * Note: caller *must* hold pgo_lock.
  */
-static int prf_serialize(struct prf_private_data *p, size_t buf_size)
+static int prf_serialize(struct prf_object *po, struct prf_private_data *p, size_t buf_size)
 {
 	void *buffer;
 
 	/* get buffer size, again. */
-	p->size = prf_buffer_size();
+	p->size = prf_buffer_size(po);
 
 	/* check for unlikely overflow. */
 	if (p->size > buf_size)
@@ -245,15 +272,16 @@ static int prf_serialize(struct prf_private_data *p, size_t buf_size)
 
 	buffer = p->buffer;
 
-	prf_fill_header(&buffer);
-	prf_copy_to_buffer(&buffer, __llvm_prf_data_start,  prf_data_size());
-	prf_copy_to_buffer(&buffer, __llvm_prf_cnts_start,  prf_cnts_size());
-	prf_copy_to_buffer(&buffer, __llvm_prf_names_start, prf_names_size());
-	buffer += prf_get_padding(prf_names_size());
+	prf_fill_header(po, &buffer);
+	prf_copy_to_buffer(&buffer, po->data,  prf_data_size(po));
+	prf_copy_to_buffer(&buffer, po->cnts,  prf_cnts_size(po));
+	prf_copy_to_buffer(&buffer, po->names, prf_names_size(po));
+	buffer += prf_get_padding(prf_names_size(po));
 
-	prf_serialize_values(&buffer);
+	prf_serialize_values(po, &buffer);
 
 	return 0;
+
 }
 
 /* open() implementation for PGO. Creates a copy of the profiling data set. */
@@ -270,7 +298,7 @@ static int prf_open(struct inode *inode, struct file *file)
 
 	/* Get initial buffer size. */
 	flags = prf_lock();
-	data->size = prf_buffer_size();
+	data->size = prf_buffer_size(&prf_vmlinux);
 	prf_unlock(flags);
 
 	do {
@@ -290,7 +318,7 @@ static int prf_open(struct inode *inode, struct file *file)
 		 * data length in data->size.
 		 */
 		flags = prf_lock();
-		err = prf_serialize(data, buf_size);
+		err = prf_serialize(&prf_vmlinux, data, buf_size);
 		prf_unlock(flags);
 		/* In unlikely case, try again. */
 	} while (err == -EAGAIN);
@@ -346,7 +374,7 @@ static ssize_t reset_write(struct file *file, const char __user *addr,
 {
 	struct llvm_prf_data *data;
 
-	memset(__llvm_prf_cnts_start, 0, prf_cnts_size());
+	memset(__llvm_prf_cnts_start, 0, prf_cnts_size(&prf_vmlinux));
 
 	for (data = __llvm_prf_data_start; data < __llvm_prf_data_end; data++) {
 		struct llvm_prf_value_node **vnodes;
@@ -384,6 +412,25 @@ static const struct file_operations prf_reset_fops = {
 /* Create debugfs entries. */
 static int __init pgo_init(void)
 {
+	/* Init profiler vmlinux core entry */
+	memset(&prf_vmlinux, 0, sizeof(prf_vmlinux));
+	prf_vmlinux.data = __llvm_prf_data_start;
+	prf_vmlinux.data_num = prf_get_count(__llvm_prf_data_start,
+		__llvm_prf_data_end, sizeof(__llvm_prf_data_start[0]));
+
+	prf_vmlinux.cnts = __llvm_prf_cnts_start;
+	prf_vmlinux.cnts_num = prf_get_count(__llvm_prf_cnts_start,
+		__llvm_prf_cnts_end, sizeof(__llvm_prf_cnts_start[0]));
+
+	prf_vmlinux.names = __llvm_prf_names_start;
+	prf_vmlinux.names_num = prf_get_count(__llvm_prf_names_start,
+		__llvm_prf_names_end, sizeof(__llvm_prf_names_start[0]));
+
+	prf_vmlinux.vnds = __llvm_prf_vnds_start;
+	prf_vmlinux.vnds_num = prf_get_count(__llvm_prf_vnds_start,
+		__llvm_prf_vnds_end, sizeof(__llvm_prf_vnds_start[0]));
+
+
 	directory = debugfs_create_dir("pgo", NULL);
 	if (!directory)
 		goto err_remove;
diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 8b54fb6be336..24fdeb79b674 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -56,7 +56,8 @@ void prf_unlock(unsigned long flags)
 static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 						 u32 index, u64 value)
 {
-	const int max_vnds = prf_vnds_count();
+	const int max_vnds = prf_get_count(__llvm_prf_vnds_start,
+		__llvm_prf_vnds_end, sizeof(struct llvm_prf_value_node));
 
 	/*
 	 * Check that p is within vmlinux __llvm_prf_data section.
diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
index ba3f8499254a..44d79e2861e1 100644
--- a/kernel/pgo/pgo.h
+++ b/kernel/pgo/pgo.h
@@ -185,27 +185,72 @@ void __llvm_profile_instrument_range(u64 target_value, void *data,
 void __llvm_profile_instrument_memop(u64 target_value, void *data,
 				     u32 counter_index);
 
-#define __DEFINE_PRF_SIZE(s) \
-	static inline unsigned long prf_ ## s ## _size(void)		\
-	{								\
-		unsigned long start =					\
-			(unsigned long)__llvm_prf_ ## s ## _start;	\
-		unsigned long end =					\
-			(unsigned long)__llvm_prf_ ## s ## _end;	\
-		return roundup(end - start,				\
-				sizeof(__llvm_prf_ ## s ## _start[0]));	\
-	}								\
-	static inline unsigned long prf_ ## s ## _count(void)		\
-	{								\
-		return prf_ ## s ## _size() /				\
-			sizeof(__llvm_prf_ ## s ## _start[0]);		\
+/*
+ * profiler object:
+ * maintain profiler internal state
+ * of vmlinux or any instrumented module.
+ */
+struct prf_object {
+	struct list_head link;
+	struct rcu_head rcu;
+
+	/*
+	 * module name of this prf_object
+	 * refers to struct module::name
+	 * or "vmlinux"
+	 */
+	const char *mod_name;
+
+	/* debugfs file of this profile data set */
+	struct dentry *file;
+
+	int current_node;
+
+	struct llvm_prf_data *data;
+	int data_num;
+	u64 *cnts;
+	int cnts_num;
+	const char *names;
+	int names_num;
+	struct llvm_prf_value_node *vnds;
+	int vnds_num;
+};
+
+/*
+ * List of profiled modules and vmlinux.
+ * Readers must take rcu_read_lock() and
+ * updaters must take prf_list_lock() mutex.
+ */
+extern struct list_head prf_list;
+
+/*
+ * define helpers to get __llvm_prf_xxx sections bounds
+ */
+#define __DEFINE_PRF_OBJ_SIZE(s) \
+	static inline unsigned long prf_ ## s ## _size(struct prf_object *po) \
+	{ \
+		return po->s ## _num * sizeof(po->s[0]); \
+	} \
+	static inline unsigned long prf_ ## s ## _count(struct prf_object *po) \
+	{ \
+		return po->s ## _num; \
 	}
 
-__DEFINE_PRF_SIZE(data);
-__DEFINE_PRF_SIZE(cnts);
-__DEFINE_PRF_SIZE(names);
-__DEFINE_PRF_SIZE(vnds);
+__DEFINE_PRF_OBJ_SIZE(data);
+__DEFINE_PRF_OBJ_SIZE(cnts);
+__DEFINE_PRF_OBJ_SIZE(names);
+__DEFINE_PRF_OBJ_SIZE(vnds);
+
+#undef __DEFINE_PRF_OBJ_SIZE
+
+/* count number of items in range */
+static inline unsigned int prf_get_count(const void *_start, const void *_end,
+	unsigned int objsize)
+{
+	unsigned long start = (unsigned long)_start;
+	unsigned long end =	(unsigned long)_end;
 
-#undef __DEFINE_PRF_SIZE
+	return roundup(end - start, objsize) / objsize;
+}
 
 #endif /* _PGO_H */
-- 
2.32.0

