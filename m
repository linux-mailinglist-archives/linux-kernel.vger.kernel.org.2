Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A214339DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhCMKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCMKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:43:17 -0500
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FB6C061574;
        Sat, 13 Mar 2021 02:43:17 -0800 (PST)
Received: by sf.home (Postfix, from userid 1000)
        id A91465A22061; Sat, 13 Mar 2021 10:43:13 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: fix format strings for err_inject
Date:   Sat, 13 Mar 2021 10:43:12 +0000
Message-Id: <20210313104312.1548232-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning with %lx / u64 mismatch:

  arch/ia64/kernel/err_inject.c: In function 'show_resources':
  arch/ia64/kernel/err_inject.c:62:22: warning:
    format '%lx' expects argument of type 'long unsigned int',
    but argument 3 has type 'u64' {aka 'long long unsigned int'}
     62 |  return sprintf(buf, "%lx\n", name[cpu]);   \
        |                      ^~~~~~~

CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/kernel/err_inject.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/ia64/kernel/err_inject.c b/arch/ia64/kernel/err_inject.c
index 8b5b8e6bc9d9..3d48f8766d78 100644
--- a/arch/ia64/kernel/err_inject.c
+++ b/arch/ia64/kernel/err_inject.c
@@ -59,7 +59,7 @@ show_##name(struct device *dev, struct device_attribute *attr,	\
 		char *buf)						\
 {									\
 	u32 cpu=dev->id;						\
-	return sprintf(buf, "%lx\n", name[cpu]);			\
+	return sprintf(buf, "%llx\n", name[cpu]);			\
 }
 
 #define store(name)							\
@@ -86,9 +86,9 @@ store_call_start(struct device *dev, struct device_attribute *attr,
 
 #ifdef ERR_INJ_DEBUG
 	printk(KERN_DEBUG "pal_mc_err_inject for cpu%d:\n", cpu);
-	printk(KERN_DEBUG "err_type_info=%lx,\n", err_type_info[cpu]);
-	printk(KERN_DEBUG "err_struct_info=%lx,\n", err_struct_info[cpu]);
-	printk(KERN_DEBUG "err_data_buffer=%lx, %lx, %lx.\n",
+	printk(KERN_DEBUG "err_type_info=%llx,\n", err_type_info[cpu]);
+	printk(KERN_DEBUG "err_struct_info=%llx,\n", err_struct_info[cpu]);
+	printk(KERN_DEBUG "err_data_buffer=%llx, %llx, %llx.\n",
 			  err_data_buffer[cpu].data1,
 			  err_data_buffer[cpu].data2,
 			  err_data_buffer[cpu].data3);
@@ -117,8 +117,8 @@ store_call_start(struct device *dev, struct device_attribute *attr,
 
 #ifdef ERR_INJ_DEBUG
 	printk(KERN_DEBUG "Returns: status=%d,\n", (int)status[cpu]);
-	printk(KERN_DEBUG "capabilities=%lx,\n", capabilities[cpu]);
-	printk(KERN_DEBUG "resources=%lx\n", resources[cpu]);
+	printk(KERN_DEBUG "capabilities=%llx,\n", capabilities[cpu]);
+	printk(KERN_DEBUG "resources=%llx\n", resources[cpu]);
 #endif
 	return size;
 }
@@ -131,7 +131,7 @@ show_virtual_to_phys(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	unsigned int cpu=dev->id;
-	return sprintf(buf, "%lx\n", phys_addr[cpu]);
+	return sprintf(buf, "%llx\n", phys_addr[cpu]);
 }
 
 static ssize_t
@@ -145,7 +145,7 @@ store_virtual_to_phys(struct device *dev, struct device_attribute *attr,
 	ret = get_user_pages_fast(virt_addr, 1, FOLL_WRITE, NULL);
 	if (ret<=0) {
 #ifdef ERR_INJ_DEBUG
-		printk("Virtual address %lx is not existing.\n",virt_addr);
+		printk("Virtual address %llx is not existing.\n", virt_addr);
 #endif
 		return -EINVAL;
 	}
@@ -163,7 +163,7 @@ show_err_data_buffer(struct device *dev,
 {
 	unsigned int cpu=dev->id;
 
-	return sprintf(buf, "%lx, %lx, %lx\n",
+	return sprintf(buf, "%llx, %llx, %llx\n",
 			err_data_buffer[cpu].data1,
 			err_data_buffer[cpu].data2,
 			err_data_buffer[cpu].data3);
@@ -178,13 +178,13 @@ store_err_data_buffer(struct device *dev,
 	int ret;
 
 #ifdef ERR_INJ_DEBUG
-	printk("write err_data_buffer=[%lx,%lx,%lx] on cpu%d\n",
+	printk("write err_data_buffer=[%llx,%llx,%llx] on cpu%d\n",
 		 err_data_buffer[cpu].data1,
 		 err_data_buffer[cpu].data2,
 		 err_data_buffer[cpu].data3,
 		 cpu);
 #endif
-	ret=sscanf(buf, "%lx, %lx, %lx",
+	ret = sscanf(buf, "%llx, %llx, %llx",
 			&err_data_buffer[cpu].data1,
 			&err_data_buffer[cpu].data2,
 			&err_data_buffer[cpu].data3);
-- 
2.30.2

