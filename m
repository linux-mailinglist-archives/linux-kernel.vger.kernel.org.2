Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539245CB16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhKXRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhKXRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637775211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IP8Yoe2CveyfmUN1XBpDPmcPnmv5naDdiSwbhvdAWHA=;
        b=aOUicHQOWE161wYWfXWOLU2Xla7LOlrlEgTOt/+sF6fp0/44qAB+rezNPdbezNDuhigpUO
        o2tbIFtrh5GLcHpOp8c73W4Z81XKMTtHrNQmxvcH7aO2l5AYMu5GsNG/JGLYV8AIS6lZ5g
        O0vrU0rwfXqyEkux+qs7KRk/7VrZvqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-KmtYhIYBMamE123Lbxlj5A-1; Wed, 24 Nov 2021 12:33:30 -0500
X-MC-Unique: KmtYhIYBMamE123Lbxlj5A-1
Received: by mail-wr1-f70.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so667035wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 09:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IP8Yoe2CveyfmUN1XBpDPmcPnmv5naDdiSwbhvdAWHA=;
        b=NQdY1tJVAhxgCoAR4G3dX8V8QoVlg65giBFFacGuKNbdKej3SBR7t9HF5Cx8TBkiLJ
         4iD9CPi6lu4JdFv2BPaNWANUSMSFp6MJ7VZlHDxifpPOGS14D57LSN6olsLudU/EtW/W
         UAiPzF6fADrgi5j9xP8luMPIqYNgX3+1TYZLx5Tr08+tT/4tDaVFmmg79HHQvF9GB8d2
         X+ZObp6hhTMpYsGyHE0u8xPB4CQWZwSa3oAu3KhbKjVlp8ZGxQsWvaNP5kMoLgnvUKbU
         l4EQ3yrZ1qTuiZt7vMe7O+6sRHGERvnuE01rdE0evrudVW7rRU1jmRvNANbRnry7V77F
         jMnA==
X-Gm-Message-State: AOAM531WGv91j7RQT7ZE0TK8gcMBO75jy8L1pYHwt7nXK9N5Ec+HH7X7
        A+AJJGehFDwDW43+vuCHA2uCfaDBk9Sof+k7dbAA+H6Svi2aO1W2VXOtxOHFLIgF3HIdhQ/Q+UD
        sn4etbCJEbt0RtqNP6AKWL0U=
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr16836535wmh.60.1637775209295;
        Wed, 24 Nov 2021 09:33:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUblsCCFipRgSXi9nrHHfrrjyoF4dr8ESNtzH0TGliCuRLTQM4EM95iBNNs5gWHWgtvOzGag==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr16836491wmh.60.1637775209037;
        Wed, 24 Nov 2021 09:33:29 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h3sm386730wrv.69.2021.11.24.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:33:28 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     jeyu@kernel.org, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: [RFC PATCH] module: Introduce module unload taint tracking
Date:   Wed, 24 Nov 2021 17:33:27 +0000
Message-Id: <20211124173327.3878177-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the initial module that tainted the kernel is
recorded e.g. when an out-of-tree module is loaded.

So the purpose of this patch is to allow the kernel to maintain a record of
each unloaded module that taints the kernel. Now, in addition to displaying
a list of linked modules (see print_modules()) e.g. in the event of an
Oops, unloaded modules that carried a taint/or taints are also displayed.
If the previously unloaded module is loaded once again it will be removed
from the list only if the taints bitmask is the same.

The number of tracked modules is not fixed and can be modified accordingly.
This feature is disabled by default.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h |   5 ++
 init/Kconfig           |   9 ++++
 kernel/module.c        | 106 +++++++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c        |  10 ++++
 4 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8a298d820dbc..6f089953f28a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -672,6 +672,11 @@ static inline bool is_livepatch_module(struct module *mod)
 bool is_module_sig_enforced(void);
 void set_module_sig_enforced(void);
 
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+
+extern int tainted_list_max_count; /* for sysctl */
+
+#endif
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
diff --git a/init/Kconfig b/init/Kconfig
index bb0d6e6262b1..699c6cf948d8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2087,6 +2087,15 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
+config MODULE_UNLOAD_TAINT_TRACKING
+	bool "Tainted module unload tracking"
+	default n
+	help
+          This option allows you to maintain a record of each unloaded
+          module that taints the kernel. Now in addition to displaying a
+          list of linked modules e.g. in the event of an Oops, the
+          aforementioned details are also displayed. If unsure, say N.
+
 config MODVERSIONS
 	bool "Module versioning support"
 	help
diff --git a/kernel/module.c b/kernel/module.c
index ed13917ea5f3..11e10b571d64 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -90,6 +90,17 @@
  */
 static DEFINE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+static LIST_HEAD(unloaded_tainted_modules);
+static int tainted_list_count;
+int __read_mostly tainted_list_max_count = 20;
+
+struct mod_unloaded_taint {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	unsigned long taints;
+};
+#endif
 
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
@@ -310,6 +321,47 @@ int unregister_module_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+
+static int try_add_tainted_module(struct module *mod)
+{
+	struct mod_unload_taint *mod_taint;
+
+	module_assert_mutex_or_preempt();
+
+	if (tainted_list_max_count >= 0 && mod->taints) {
+		if (!tainted_list_max_count &&
+			tainted_list_count >= tainted_list_max_count) {
+			pr_warn_once("%s: limit reached on the unloaded tainted modules list (count: %d).\n",
+				     mod->name, tainted_list_count);
+			goto out;
+		}
+
+		mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
+		if (unlikely(!mod_taint))
+			return -ENOMEM;
+		else {
+			strlcpy(mod_taint->name, mod->name,
+				MODULE_NAME_LEN);
+			mod_taint->taints = mod->taints;
+			list_add_rcu(&mod_taint->list,
+				&unloaded_tainted_modules);
+			tainted_list_count++;
+		}
+out:
+	}
+	return 0;
+}
+
+#else /* MODULE_UNLOAD_TAINT_TRACKING */
+
+static int try_add_tainted_module(struct module *mod)
+{
+	return 0;
+}
+
+#endif /* MODULE_UNLOAD_TAINT_TRACKING */
+
 /*
  * We require a truly strong try_module_get(): 0 means success.
  * Otherwise an error is returned due to ongoing or failed
@@ -579,6 +631,23 @@ struct module *find_module(const char *name)
 {
 	return find_module_all(name, strlen(name), false);
 }
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+struct mod_unload_taint *find_mod_unload_taint(const char *name, size_t len,
+					    unsigned long taints)
+{
+	struct mod_unload_taint *mod_taint;
+
+	module_assert_mutex_or_preempt();
+
+	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
+				lockdep_is_held(&module_mutex)) {
+		if (strlen(mod_taint->name) == len && !memcmp(mod_taint->name,
+			name, len) && mod_taint->taints & taints) {
+			return mod_taint;
+		}
+	}
+	return NULL;
+#endif
 
 #ifdef CONFIG_SMP
 
@@ -1121,13 +1190,13 @@ static inline int module_unload_init(struct module *mod)
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
-static size_t module_flags_taint(struct module *mod, char *buf)
+static size_t module_flags_taint(unsigned long taints, char *buf)
 {
 	size_t l = 0;
 	int i;
 
 	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		if (taint_flags[i].module && test_bit(i, &mod->taints))
+		if (taint_flags[i].module && test_bit(i, &taints))
 			buf[l++] = taint_flags[i].c_true;
 	}
 
@@ -1194,7 +1263,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
 {
 	size_t l;
 
-	l = module_flags_taint(mk->mod, buffer);
+	l = module_flags_taint(mk->mod->taints, buffer);
 	buffer[l++] = '\n';
 	return l;
 }
@@ -2193,6 +2262,9 @@ static void free_module(struct module *mod)
 	module_bug_cleanup(mod);
 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
+	if (try_add_tainted_module(mod))
+		pr_error("%s: adding tainted module to the unloaded tainted modules list failed.\n",
+			 mod->name);
 	mutex_unlock(&module_mutex);
 
 	/* Clean up CFI for the module. */
@@ -3670,6 +3742,9 @@ static noinline int do_init_module(struct module *mod)
 {
 	int ret = 0;
 	struct mod_initfree *freeinit;
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	struct mod_unload_taint *old;
+#endif
 
 	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
 	if (!freeinit) {
@@ -3703,6 +3778,16 @@ static noinline int do_init_module(struct module *mod)
 	mod->state = MODULE_STATE_LIVE;
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_LIVE, mod);
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	mutex_lock(&module_mutex);
+	old = find_mod_unload_taint(mod->name, strlen(mod->name),
+				mod->taints);
+	if (old) {
+		list_del_rcu(&old->list);
+		synchronize_rcu();
+	}
+	mutex_unlock(&module_mutex);
+#endif
 
 	/* Delay uevent until module has finished its init routine */
 	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
@@ -4511,7 +4596,7 @@ static char *module_flags(struct module *mod, char *buf)
 	    mod->state == MODULE_STATE_GOING ||
 	    mod->state == MODULE_STATE_COMING) {
 		buf[bx++] = '(';
-		bx += module_flags_taint(mod, buf + bx);
+		bx += module_flags_taint(mod->taints, buf + bx);
 		/* Show a - for module-is-being-unloaded */
 		if (mod->state == MODULE_STATE_GOING)
 			buf[bx++] = '-';
@@ -4735,6 +4820,10 @@ void print_modules(void)
 {
 	struct module *mod;
 	char buf[MODULE_FLAGS_BUF_SIZE];
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	struct mod_unload_taint *mod_taint;
+	size_t l;
+#endif
 
 	printk(KERN_DEFAULT "Modules linked in:");
 	/* Most callers should already have preempt disabled, but make sure */
@@ -4744,6 +4833,15 @@ void print_modules(void)
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
 	}
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	printk(KERN_DEFAULT "\nUnloaded tainted modules:");
+	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
+				list) {
+		l = module_flags_taint(mod_taint->taints, buf);
+		buf[l++] = '\0';
+		pr_cont(" %s(%s)", mod_taint->name, buf);
+	}
+#endif
 	preempt_enable();
 	if (last_unloaded_module[0])
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 272f4a272f8c..290ffaa5b553 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2078,6 +2078,16 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	{
+		.procname	= "tainted_list_max_count",
+		.data		= &tainted_list_max_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &neg_one,
+	},
+#endif
 #endif
 #ifdef CONFIG_UEVENT_HELPER
 	{
-- 
2.31.1

