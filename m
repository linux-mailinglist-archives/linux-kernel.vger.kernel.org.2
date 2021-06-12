Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C843A4C77
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFLDiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:38:11 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:45687 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFLDiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:38:10 -0400
Received: by mail-lf1-f48.google.com with SMTP id a1so11476992lfr.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOtwuICSd/k9ZnE0r7oKEW78fGTtl+Xe0V2OTIyFfGE=;
        b=NKgNwsRNczrlB3UQC1EDzizIG6NYEf54bFj+trINPhDQS8Bs4OCjIr8jFvkWqEVP5v
         zfu/yPUWNooXHeC+y8mn9oNPG4lbwiUmSv2FRqg1NiWblK6bx8CmetNFQykf6hOK+nn3
         3IwKPqHFr1ajd3VwWshamv/Kicu1WaiGOWR/GpPlJVo3Bd3I4gKNSMndaDlGi108T2a/
         aTMUWM5VZPD799+1jS+ca737t7PIA51N9fTJQEOCtVeyd2YUCj4zH/p5xAAc8Ld5IO1t
         FqFKdklSqZTBp6CsdJYPO19LU/bSu21s8eS0X+E9VZlwuNoCq/Xzq+M+ZVOTQX/mc5g/
         ZrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOtwuICSd/k9ZnE0r7oKEW78fGTtl+Xe0V2OTIyFfGE=;
        b=gRTvNB+6Y/tPob2g8NbtuZtF18xiDfvQICFQVgdt5tKMODy9WSJuehhd+rymgZoiLv
         0YOaSr56dAI3ltRf1+5gBhrtIyBkXNNK0LBbokgEU8BaJspikrgXsiNq51mPmDlPs85o
         JnvRyzDJ9Rmiyth3+8+JMR556OUJA9155dehbEIzOQ/B7Z2cRS2o/ipxH+Y7SfVpt0c3
         UVkdXdrpLGUjV9GtCfE1hwTc6aLueJjWXm+0O7OBrtiybqF4BsVenpWZmmiIfX/8z7tk
         DOWA84OrZuH9YHv0ugZ+znL1HUsCBt82nK7cXopLKoHu3enaYyU0//o0b2l/We3ylogK
         v4hA==
X-Gm-Message-State: AOAM533P+JgDEyiu2PSUSailfkKJlLrQhm3SYPDubSGVEByieaV4zlFo
        F5mQrUQW8wnTAdmOjkpClpo=
X-Google-Smtp-Source: ABdhPJwLaeM1NlBN2NUyC0JNgT3tYKR+wAGj7FuJcq27jNjGaX/MfUDoYGt5klhhRra7PFs0PEFv7A==
X-Received: by 2002:a19:ed18:: with SMTP id y24mr4795912lfy.359.1623468910825;
        Fri, 11 Jun 2021 20:35:10 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ydkw9h---3prwmt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:6897:4dff:feec:7495])
        by smtp.gmail.com with ESMTPSA id f19sm943250ljn.88.2021.06.11.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:35:10 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [RFC PATCH 4/5] pgo: Add module notifier machinery
Date:   Sat, 12 Jun 2021 06:24:25 +0300
Message-Id: <20210612032425.11425-5-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module notifier callback and register modules
into prf_list.

For each module that has __llvm_prf_{data,cnts,names,vnds} sections
The callback creates debugfs <module>.profraw entry and
links new prf_object into prf_list.

This enables profiling for all loaded modules.

* Moved rcu_read_lock() outside of allocate_node() in order
  to protect __llvm_profile_instrument_target() from module unload(s)

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
v2: Passed QEMU SMP boot test into minimal Arch Linux distro,
module loading and unloading work without warnings.
Module profile data looks ok. :-)
---
 kernel/pgo/fs.c         | 111 ++++++++++++++++++++++++++++++++++++++++
 kernel/pgo/instrument.c |  19 ++++---
 2 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 84b36e61758b..98b982245b58 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -419,6 +419,110 @@ static const struct file_operations prf_reset_fops = {
 	.llseek		= noop_llseek,
 };
 
+static void pgo_module_init(struct module *mod)
+{
+	struct prf_object *po;
+	char fname[MODULE_NAME_LEN + 9]; /* +strlen(".profraw") */
+	unsigned long flags;
+
+	/* add new prf_object entry for the module */
+	po = kzalloc(sizeof(*po), GFP_KERNEL);
+	if (!po)
+		goto out;
+
+	po->mod_name = mod->name;
+
+	fname[0] = 0;
+	snprintf(fname, sizeof(fname), "%s.profraw", po->mod_name);
+
+	/* setup prf_object sections */
+	po->data = mod->prf_data;
+	po->data_num = prf_get_count(mod->prf_data,
+		(char *)mod->prf_data + mod->prf_data_size, sizeof(po->data[0]));
+
+	po->cnts = mod->prf_cnts;
+	po->cnts_num = prf_get_count(mod->prf_cnts,
+		(char *)mod->prf_cnts + mod->prf_cnts_size, sizeof(po->cnts[0]));
+
+	po->names = mod->prf_names;
+	po->names_num = prf_get_count(mod->prf_names,
+		(char *)mod->prf_names + mod->prf_names_size, sizeof(po->names[0]));
+
+	po->vnds = mod->prf_vnds;
+	po->vnds_num = prf_get_count(mod->prf_vnds,
+		(char *)mod->prf_vnds + mod->prf_vnds_size, sizeof(po->vnds[0]));
+
+	/* create debugfs entry */
+	po->file = debugfs_create_file(fname, 0600, directory, po, &prf_fops);
+	if (!po->file) {
+		pr_err("Failed to setup module pgo: %s", fname);
+		kfree(po);
+		goto out;
+	}
+
+	/* finally enable profiling for the module */
+	flags = prf_list_lock();
+	list_add_tail_rcu(&po->link, &prf_list);
+	prf_list_unlock(flags);
+
+out:
+	return;
+}
+
+static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
+				void *pdata)
+{
+	struct module *mod = pdata;
+	struct prf_object *po;
+	unsigned long flags;
+
+	if (event == MODULE_STATE_LIVE) {
+		/* does the module have profiling info? */
+		if (mod->prf_data
+			&& mod->prf_cnts
+			&& mod->prf_names
+			&& mod->prf_vnds) {
+
+			/* setup module profiling */
+			pgo_module_init(mod);
+		}
+	}
+
+	if (event == MODULE_STATE_GOING) {
+		/* find the prf_object from the list */
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(po, &prf_list, link) {
+			if (strcmp(po->mod_name, mod->name) == 0)
+				goto out_unlock;
+		}
+		/* no such module */
+		po = NULL;
+
+out_unlock:
+		rcu_read_unlock();
+
+		if (po) {
+			/* remove from profiled modules */
+			flags = prf_list_lock();
+			list_del_rcu(&po->link);
+			prf_list_unlock(flags);
+
+			debugfs_remove(po->file);
+			po->file = NULL;
+
+			/* cleanup memory */
+			kfree_rcu(po, rcu);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pgo_module_nb = {
+	.notifier_call = pgo_module_notifier
+};
+
 /* Create debugfs entries. */
 static int __init pgo_init(void)
 {
@@ -444,6 +548,7 @@ static int __init pgo_init(void)
 
 	/* enable profiling */
 	flags = prf_list_lock();
+	prf_vmlinux.mod_name = "vmlinux";
 	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
 	prf_list_unlock(flags);
 
@@ -460,6 +565,9 @@ static int __init pgo_init(void)
 				 &prf_reset_fops))
 		goto err_remove;
 
+	/* register module notifer */
+	register_module_notifier(&pgo_module_nb);
+
 	/* show notice why the system slower: */
 	pr_notice("Clang PGO instrumentation is active.");
 
@@ -473,6 +581,9 @@ static int __init pgo_init(void)
 /* Remove debugfs entries. */
 static void __exit pgo_exit(void)
 {
+	/* unsubscribe the notifier and do cleanup. */
+	unregister_module_notifier(&pgo_module_nb);
+
 	debugfs_remove_recursive(directory);
 }
 
diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index e214c9d7a113..70bab7e4c153 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -33,7 +33,6 @@
  * ensures that we don't try to serialize data that's only partially updated.
  */
 static DEFINE_SPINLOCK(pgo_lock);
-static int current_node;
 
 unsigned long prf_lock(void)
 {
@@ -62,8 +61,6 @@ static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 	struct llvm_prf_data *data_end;
 	int max_vnds;
 
-	rcu_read_lock();
-
 	list_for_each_entry_rcu(po, &prf_list, link) {
 		/* get section limits */
 		max_vnds = prf_vnds_count(po);
@@ -76,7 +73,6 @@ static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 		 */
 		if (memory_contains(po->data, data_end, p, sizeof(*p))) {
 
-
 			if (WARN_ON_ONCE(po->current_node >= max_vnds))
 				return NULL; /* Out of nodes */
 
@@ -87,7 +83,6 @@ static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 	}
 
 out:
-	rcu_read_unlock();
 	return vnode;
 }
 
@@ -108,8 +103,14 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
 	u8 values = 0;
 	unsigned long flags;
 
+	/*
+	 * lock the underlying prf_object(s) in place,
+	 * so they won't vanish while we are operating on it.
+	 */
+	rcu_read_lock();
+
 	if (!p || !p->values)
-		return;
+		goto rcu_unlock;
 
 	counters = (struct llvm_prf_value_node **)p->values;
 	curr = counters[index];
@@ -117,7 +118,7 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
 	while (curr) {
 		if (target_value == curr->value) {
 			curr->count++;
-			return;
+			goto rcu_unlock;
 		}
 
 		if (curr->count < min_count) {
@@ -136,7 +137,7 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
 			curr->value = target_value;
 			curr->count++;
 		}
-		return;
+		goto rcu_unlock;
 	}
 
 	/* Lock when updating the value node structure. */
@@ -156,6 +157,8 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
 
 out:
 	prf_unlock(flags);
+rcu_unlock:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(__llvm_profile_instrument_target);
 
-- 
2.32.0

