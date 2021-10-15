Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3F42E592
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhJOA6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhJOA6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:58:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E099DC061760
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:56:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m14so6935118pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf0YEF0ffs7JzSE/VN26A0DuF3TU/TTCNqKkcWANbFg=;
        b=acGdJwLdUzEZKhKOIq696wCosceAlV5D86IYNJfArazzWo1VscUmSdzHD9YNLrLoRW
         IefG4LXQEuWvRnJSlk3bBCBMUJbFpL5n2tubsqWztc8nDnAqrRhkQQatqbUzbLobZrRd
         9P+1RB/2Th4JHzJ5Q8oBu66IttX8uAx+3kKfhXVRa+uzF4xAH/Mg2ypYqhg3EU6JWDqg
         XN5rd72ZfW77YKiqn/nZcbFT7V+CC6xYyoDUuzmK9GnNBEttPjc3n2dytYj75ani9Wu2
         Tz+vAkcUO1ieVkFP0h7JdURHPU4V277hgxIJix7RgqPFK5Zec/S50zLlhLakhQHnpXEj
         FLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf0YEF0ffs7JzSE/VN26A0DuF3TU/TTCNqKkcWANbFg=;
        b=e9Wcb/+E2VXkvwRpo6rJxbZjKKhSFM4+uwR/YYxKvkJFeXpst8us8fZKuxCe9NMM+O
         6x0N8AHMFkqaIo/Csnxd6IbP5uRQpVCZHgy49/kYxtPR/nkY/QGOw4gqvQmZZUSehLf5
         S5bDs4x9OXKTNrGF9gLI1FUzqkzsdZeJSy3j+CJk7xxKxrU6yoGhDPoGD811HSoBDm7R
         67h1d7cPDRgIZ84do5ShUFKlyHJqvnOKJr8V/yFR8+QLWvkWtaNN/lPgiwk0TFMb6ETF
         djCdufNn31xMywXhFICKU8Ufs4uJu0j/OvHkDfB6Nlx5cuq0/Hs+EJplw6kNLH4ofZ1J
         mrHA==
X-Gm-Message-State: AOAM533fe/MfbJKZ3n6UklXC+nYIk4S7zPAkEkS/MIY+lVA/6UY/U4eS
        7YnOuvIUSu62lGjYwkIeWiU=
X-Google-Smtp-Source: ABdhPJxmDAT8V2DIbTuAi6Hw2tzGCYsfAc7K8ijxMl0O7Hi8g4dFhXPaatfoklww/2n3Y97jACBkHg==
X-Received: by 2002:a62:800a:0:b0:447:b73e:6e18 with SMTP id j10-20020a62800a000000b00447b73e6e18mr8390273pfd.28.1634259362429;
        Thu, 14 Oct 2021 17:56:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id k9sm3510745pfa.88.2021.10.14.17.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 17:56:01 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     ying.huang@intel.com, dave.hansen@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: make demotion knob depend on migration
Date:   Thu, 14 Oct 2021 17:55:59 -0700
Message-Id: <20211015005559.246709-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory demotion needs to call migrate_pages() to do the jobs.  And
it is controlled by a knob, however, the knob doesn't depend on
CONFIG_MIGRATION.  The knob could be truned on even though MIGRATION is
disabled, this will not cause any crash since migrate_pages() would just
return -ENOSYS.  But it is definitely not optimal to go through demotion
path then retry regular swap every time.

And it doesn't make too much sense to have the knob visible to the users
when !MIGRATION.  Move the related code from mempolicy.[h|c] to migrate.[h|c].

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/mempolicy.h |  4 ---
 include/linux/migrate.h   |  4 +++
 mm/mempolicy.c            | 61 ---------------------------------------
 mm/migrate.c              | 61 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 4091692bed8c..2bcb524dc339 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -184,8 +184,6 @@ extern bool vma_migratable(struct vm_area_struct *vma);
 extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
 extern void mpol_put_task_policy(struct task_struct *);
 
-extern bool numa_demotion_enabled;
-
 static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 {
 	return  (pol->mode == MPOL_PREFERRED_MANY);
@@ -301,8 +299,6 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 	return NULL;
 }
 
-#define numa_demotion_enabled	false
-
 static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 {
 	return  false;
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c8077e936691..eb8960683058 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -57,6 +57,8 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+
+extern bool numa_demotion_enabled;
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
@@ -82,6 +84,8 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 {
 	return -ENOSYS;
 }
+
+#define numa_demotion_enabled	false
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1592b081c58e..8f45d4191b5b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2981,64 +2981,3 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
-
-bool numa_demotion_enabled = false;
-
-#ifdef CONFIG_SYSFS
-static ssize_t numa_demotion_enabled_show(struct kobject *kobj,
-					  struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%s\n",
-			  numa_demotion_enabled? "true" : "false");
-}
-
-static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
-					   struct kobj_attribute *attr,
-					   const char *buf, size_t count)
-{
-	if (!strncmp(buf, "true", 4) || !strncmp(buf, "1", 1))
-		numa_demotion_enabled = true;
-	else if (!strncmp(buf, "false", 5) || !strncmp(buf, "0", 1))
-		numa_demotion_enabled = false;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static struct kobj_attribute numa_demotion_enabled_attr =
-	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
-	       numa_demotion_enabled_store);
-
-static struct attribute *numa_attrs[] = {
-	&numa_demotion_enabled_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group numa_attr_group = {
-	.attrs = numa_attrs,
-};
-
-static int __init numa_init_sysfs(void)
-{
-	int err;
-	struct kobject *numa_kobj;
-
-	numa_kobj = kobject_create_and_add("numa", mm_kobj);
-	if (!numa_kobj) {
-		pr_err("failed to create numa kobject\n");
-		return -ENOMEM;
-	}
-	err = sysfs_create_group(numa_kobj, &numa_attr_group);
-	if (err) {
-		pr_err("failed to register numa group\n");
-		goto delete_obj;
-	}
-	return 0;
-
-delete_obj:
-	kobject_put(numa_kobj);
-	return err;
-}
-subsys_initcall(numa_init_sysfs);
-#endif
diff --git a/mm/migrate.c b/mm/migrate.c
index a6a7743ee98f..55dccb995cfe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3294,3 +3294,64 @@ static int __init migrate_on_reclaim_init(void)
 }
 late_initcall(migrate_on_reclaim_init);
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+bool numa_demotion_enabled = false;
+
+#ifdef CONFIG_SYSFS
+static ssize_t numa_demotion_enabled_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  numa_demotion_enabled? "true" : "false");
+}
+
+static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	if (!strncmp(buf, "true", 4) || !strncmp(buf, "1", 1))
+		numa_demotion_enabled = true;
+	else if (!strncmp(buf, "false", 5) || !strncmp(buf, "0", 1))
+		numa_demotion_enabled = false;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static struct kobj_attribute numa_demotion_enabled_attr =
+	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
+	       numa_demotion_enabled_store);
+
+static struct attribute *numa_attrs[] = {
+	&numa_demotion_enabled_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group numa_attr_group = {
+	.attrs = numa_attrs,
+};
+
+static int __init numa_init_sysfs(void)
+{
+	int err;
+	struct kobject *numa_kobj;
+
+	numa_kobj = kobject_create_and_add("numa", mm_kobj);
+	if (!numa_kobj) {
+		pr_err("failed to create numa kobject\n");
+		return -ENOMEM;
+	}
+	err = sysfs_create_group(numa_kobj, &numa_attr_group);
+	if (err) {
+		pr_err("failed to register numa group\n");
+		goto delete_obj;
+	}
+	return 0;
+
+delete_obj:
+	kobject_put(numa_kobj);
+	return err;
+}
+subsys_initcall(numa_init_sysfs);
+#endif
-- 
2.26.2

