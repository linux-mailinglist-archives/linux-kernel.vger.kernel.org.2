Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05803A4C71
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFLDha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:37:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:35:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m21so11504192lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ibhf5TupeDDF+e0/bn0bGPWU71FDw0je6Oife0cbLuU=;
        b=Z61aoTk438RBkL0rDaKWzUZZyczvJSbilVh1+7jTtNlbHp9dyGYKyhp9WXn15rlAv1
         BYQpEdACBR2kgdVE5LYqjbaLhxBdHZFvtu/LPR6PhalmZkhUjDyeTlVaMwWYse0BlMsb
         QmmcO71owEQ47nNMLSFH5a3groevPb2jt7l97EZkusF36m9T2apaBiO3gWOkdpNmAxt9
         uki5EBakwGY6Wei+U32ZCq4xyUDMgyPf9UAs/DfVsPRnS+Cl3vpShRVDh4FnR9OYiNaA
         OeYKhKYrrABXjNmvEPm5LPmTOxifAbiHSna5t9ED2lsmskbvpyv1Hg3pODrnXJ4ipHWy
         gUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ibhf5TupeDDF+e0/bn0bGPWU71FDw0je6Oife0cbLuU=;
        b=ddrrlYH0U17x5FPZzJ6h+gG6S0Mt7HQ5rGLF0cXM1YDQC+1lDIYXdK1C+x+iZsITSN
         2rAlnPxRhhuZBGkvxxCTuXeJCn4dI4INovXjwZJ/f1EophcoxFqD1Os74E/i2MhH8TDt
         Mg3VIcbGuRnmizvQSrSyqwI+xQpNmed36GVJgRVUTHSJ5fK81q3UZ1v8Jr4GrmeKDqsH
         NwrHNnFdkU4tmV3sFrCA6fNjD5qJA4Ii6Z2tum+kz7IIeqXsofcQQI67l6pUO5jNHmA5
         lXzL1GesdqG89neY3QS6xDm4lw62/mQykBT3zJcByXqsdA/VtXC9ooWL6ptdRQaOV9OB
         saJA==
X-Gm-Message-State: AOAM531jvzibmsaaOJUhLtF/q9gl1Mt8egbP48VHQgTuelRFGM6Xm4wa
        2V5DOOUz9LsfZEOT0JsIZWY=
X-Google-Smtp-Source: ABdhPJzreVvDGZ8fUqM7voQLUG+vQZUAlJWDoKWhiYprOiJY4o4jFKHwR1+fX9onuOdcXAPLvMsErg==
X-Received: by 2002:a05:6512:218d:: with SMTP id b13mr4791685lft.346.1623468911972;
        Fri, 11 Jun 2021 20:35:11 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ydkw9h---3prwmt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:6897:4dff:feec:7495])
        by smtp.gmail.com with ESMTPSA id f19sm943250ljn.88.2021.06.11.20.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:35:11 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [RFC PATCH 5/5] pgo: Cleanup code in pgo/fs.c
Date:   Sat, 12 Jun 2021 06:24:26 +0300
Message-Id: <20210612032425.11425-6-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups to comments and punctuation.
Cleanup return path in pgo_module_init.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/fs.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 98b982245b58..855d5e3050fa 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -294,7 +294,7 @@ static int prf_open(struct inode *inode, struct file *file)
 	int err = -EINVAL;
 
 	if (WARN_ON(!inode->i_private)) {
-		/* bug: inode was not initialized by us */
+		/* Bug: inode was not initialized by us. */
 		return err;
 	}
 
@@ -302,7 +302,7 @@ static int prf_open(struct inode *inode, struct file *file)
 	if (!data)
 		return -ENOMEM;
 
-	/* Get prf_object of this inode */
+	/* Get prf_object of this inode. */
 	data->core = inode->i_private;
 
 	/* Get initial buffer size. */
@@ -425,17 +425,17 @@ static void pgo_module_init(struct module *mod)
 	char fname[MODULE_NAME_LEN + 9]; /* +strlen(".profraw") */
 	unsigned long flags;
 
-	/* add new prf_object entry for the module */
+	/* Add new prf_object entry for the module. */
 	po = kzalloc(sizeof(*po), GFP_KERNEL);
 	if (!po)
-		goto out;
+		return; /* -ENOMEM */
 
 	po->mod_name = mod->name;
 
 	fname[0] = 0;
 	snprintf(fname, sizeof(fname), "%s.profraw", po->mod_name);
 
-	/* setup prf_object sections */
+	/* Setup prf_object sections. */
 	po->data = mod->prf_data;
 	po->data_num = prf_get_count(mod->prf_data,
 		(char *)mod->prf_data + mod->prf_data_size, sizeof(po->data[0]));
@@ -452,20 +452,19 @@ static void pgo_module_init(struct module *mod)
 	po->vnds_num = prf_get_count(mod->prf_vnds,
 		(char *)mod->prf_vnds + mod->prf_vnds_size, sizeof(po->vnds[0]));
 
-	/* create debugfs entry */
+	/* Create debugfs entry. */
 	po->file = debugfs_create_file(fname, 0600, directory, po, &prf_fops);
 	if (!po->file) {
 		pr_err("Failed to setup module pgo: %s", fname);
 		kfree(po);
-		goto out;
-	}
 
-	/* finally enable profiling for the module */
-	flags = prf_list_lock();
-	list_add_tail_rcu(&po->link, &prf_list);
-	prf_list_unlock(flags);
+	} else {
+		/* Finally enable profiling for the module. */
+		flags = prf_list_lock();
+		list_add_tail_rcu(&po->link, &prf_list);
+		prf_list_unlock(flags);
+	}
 
-out:
 	return;
 }
 
@@ -477,33 +476,33 @@ static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
 	unsigned long flags;
 
 	if (event == MODULE_STATE_LIVE) {
-		/* does the module have profiling info? */
+		/* Does the module have profiling info? */
 		if (mod->prf_data
 			&& mod->prf_cnts
 			&& mod->prf_names
 			&& mod->prf_vnds) {
 
-			/* setup module profiling */
+			/* Setup module profiling. */
 			pgo_module_init(mod);
 		}
 	}
 
 	if (event == MODULE_STATE_GOING) {
-		/* find the prf_object from the list */
+		/* Find the prf_object from the list. */
 		rcu_read_lock();
 
 		list_for_each_entry_rcu(po, &prf_list, link) {
 			if (strcmp(po->mod_name, mod->name) == 0)
 				goto out_unlock;
 		}
-		/* no such module */
+		/* No such module. */
 		po = NULL;
 
 out_unlock:
 		rcu_read_unlock();
 
 		if (po) {
-			/* remove from profiled modules */
+			/* Remove from profiled modules. */
 			flags = prf_list_lock();
 			list_del_rcu(&po->link);
 			prf_list_unlock(flags);
@@ -511,7 +510,7 @@ static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
 			debugfs_remove(po->file);
 			po->file = NULL;
 
-			/* cleanup memory */
+			/* Cleanup memory. */
 			kfree_rcu(po, rcu);
 		}
 	}
@@ -528,7 +527,7 @@ static int __init pgo_init(void)
 {
 	unsigned long flags;
 
-	/* Init profiler vmlinux core entry */
+	/* Init profiler vmlinux core entry. */
 	memset(&prf_vmlinux, 0, sizeof(prf_vmlinux));
 	prf_vmlinux.data = __llvm_prf_data_start;
 	prf_vmlinux.data_num = prf_get_count(__llvm_prf_data_start,
@@ -546,7 +545,7 @@ static int __init pgo_init(void)
 	prf_vmlinux.vnds_num = prf_get_count(__llvm_prf_vnds_start,
 		__llvm_prf_vnds_end, sizeof(__llvm_prf_vnds_start[0]));
 
-	/* enable profiling */
+	/* Enable profiling. */
 	flags = prf_list_lock();
 	prf_vmlinux.mod_name = "vmlinux";
 	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
@@ -565,10 +564,10 @@ static int __init pgo_init(void)
 				 &prf_reset_fops))
 		goto err_remove;
 
-	/* register module notifer */
+	/* Register module notifer. */
 	register_module_notifier(&pgo_module_nb);
 
-	/* show notice why the system slower: */
+	/* Show notice why the system slower: */
 	pr_notice("Clang PGO instrumentation is active.");
 
 	return 0;
@@ -581,7 +580,7 @@ static int __init pgo_init(void)
 /* Remove debugfs entries. */
 static void __exit pgo_exit(void)
 {
-	/* unsubscribe the notifier and do cleanup. */
+	/* Unsubscribe the notifier and do cleanup. */
 	unregister_module_notifier(&pgo_module_nb);
 
 	debugfs_remove_recursive(directory);
-- 
2.32.0

