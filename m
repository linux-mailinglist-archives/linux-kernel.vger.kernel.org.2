Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33433358803
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhDHPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhDHPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:17:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E3C061760;
        Thu,  8 Apr 2021 08:17:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x11so2501923qkp.11;
        Thu, 08 Apr 2021 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwUagkBJmOTqxtVIo/A1qVR4nfMneoglT2uqwGOZZcI=;
        b=cwQbgrSj4SgNTzIeaIiPiw+bBM0yja6JnT/kl71EKXgj/yhhqQscu7T49k+gUn2LvZ
         W0ICKLp5ccfYT4jBOYo/KgW0JLzyub6qYt9iDX/fwvt2ZFiKErewGThRBw2cMBL+STSa
         zOnCOuDZ5LmhvbjhvDFAKe/1D9TOLIEc64HPKaay+xAODWfXdpTnTkoyFGqOCT7zLIQX
         xbH8GEjk0WscMYLUyIqccB7jWzW2vUqIIz6NAUvZjH5MSZVdFTHfofIhfIcND53erJs+
         s1DqNc0c096XIKJUqLDd9BYNOXoAUSKr+E6jN+14bh5twec2Rra7B/e1erpeJalbhcf0
         YlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwUagkBJmOTqxtVIo/A1qVR4nfMneoglT2uqwGOZZcI=;
        b=mJ6hmy1m3UBofnace77htdZ4NiMvX6f2Z8yddgH1y08TMp7JalkRhA56Z0fnW00pWP
         0Q0TQP7cHuLawZVfMgkEDMvGvXP5fZ9NdXZ40EOXAWh98AN/bajDF/0YsC8uprDzPjUJ
         FnI2lTTYJqUD8dCmc5S2jCMrIiCOsD8RvCW3jXAFx1X6DrLt+eYjI32XRZNUizYo/3US
         nmebwXWfIW35mKQ7PVbcMNOhGITVy3JTd4JWkXi/c/M1DGYU24YPf8+ltGw0zXvHjZ9x
         P0tU24Ub+CLG+sa/gZLcPsbHoGD35BDn9EErDyWkWP3QAxuU88uCbHJOG6akgIc4SueF
         VqUg==
X-Gm-Message-State: AOAM530k53EeZcnv7KNwL3OKlNErR3dTUoZKg+ePkfYu6+TrjCNR1hl5
        XQkEQW0QZ9fvc3Rj7w07aIk=
X-Google-Smtp-Source: ABdhPJzZXTcS4fuMA1WmA+3VsWnbkNYEMciD+0KFxuJjcPXHxI/yDVFr08VyOUq/ZvTVn5JjvvDDtA==
X-Received: by 2002:a37:9fce:: with SMTP id i197mr8629964qke.155.1617895063542;
        Thu, 08 Apr 2021 08:17:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id q15sm18319570qtx.47.2021.04.08.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:17:43 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] of: unittest: overlay: ensure proper alignment of copied FDT
Date:   Thu,  8 Apr 2021 10:17:36 -0500
Message-Id: <20210408151736.2216238-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The Devicetree standard specifies an 8 byte alignment of the FDT.
Code in libfdt expects this alignment for an FDT image in memory.
kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
with kmalloc(), align pointer, memcpy() to get proper alignment.

The 4 byte alignment exposed a related bug which triggered a crash
on openrisc with:
commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
as reported in:
https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since version 1:
  - use pointer from kmalloc() for kfree() instead of using pointer that
    has been modified for FDT alignment

changes since version 2:
  - version 1 was a work in progress version, I failed to commit the following
    final changes
  - reorder first two arguments of of_overlay_apply()

 drivers/of/of_private.h |  2 ++
 drivers/of/overlay.c    | 28 +++++++++++++++++-----------
 drivers/of/unittest.c   | 12 +++++++++---
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d9e6a324de0a..d717efbd637d 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -8,6 +8,8 @@
  * Copyright (C) 1996-2005 Paul Mackerras.
  */
 
+#define FDT_ALIGN_SIZE 8
+
 /**
  * struct alias_prop - Alias property in 'aliases' node
  * @link:	List node to link the structure in aliases_lookup list
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 50bbe0edf538..cf770452e1e5 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -57,7 +57,7 @@ struct fragment {
  * struct overlay_changeset
  * @id:			changeset identifier
  * @ovcs_list:		list on which we are located
- * @fdt:		FDT that was unflattened to create @overlay_tree
+ * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
  * @overlay_tree:	expanded device tree that contains the fragment nodes
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
@@ -719,8 +719,8 @@ static struct device_node *find_target(struct device_node *info_node)
 /**
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
  * @ovcs:	Overlay changeset to build
- * @fdt:	the FDT that was unflattened to create @tree
- * @tree:	Contains all the overlay fragments and overlay fixup nodes
+ * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
+ * @tree:	Contains the overlay fragments and overlay fixup nodes
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
  * the top level of @tree.  The relevant top level nodes are the fragment
@@ -873,7 +873,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * internal documentation
  *
  * of_overlay_apply() - Create and apply an overlay changeset
- * @fdt:	the FDT that was unflattened to create @tree
+ * @fdt:	base of memory allocated to hold *@fdt_align
+ * @fdt_align:	the FDT that was unflattened to create @tree, aligned
  * @tree:	Expanded overlay device tree
  * @ovcs_id:	Pointer to overlay changeset id
  *
@@ -912,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * id is returned to *ovcs_id.
  */
 
-static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+static int of_overlay_apply(const void *fdt, const void *fdt_align,
+		struct device_node *tree, int *ovcs_id)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
@@ -953,7 +954,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	/*
 	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
 	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
-	 * and can not free fdt, aka ovcs->fdt
+	 * and can not free memory containing aligned fdt, aka ovcs->fdt
 	 */
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
@@ -1014,7 +1015,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 			 int *ovcs_id)
 {
-	const void *new_fdt;
+	void *new_fdt;
+	void *new_fdt_align;
 	int ret;
 	u32 size;
 	struct device_node *overlay_root;
@@ -1036,18 +1038,22 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
 	 * will create pointers to the passed in FDT in the unflattened tree.
 	 */
-	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
+	size += FDT_ALIGN_SIZE;
+	new_fdt = kmalloc(size, GFP_KERNEL);
 	if (!new_fdt)
 		return -ENOMEM;
 
-	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
+	new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
+	memcpy(new_fdt_align, overlay_fdt, size);
+
+	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
 	if (!overlay_root) {
 		pr_err("unable to unflatten overlay_fdt\n");
 		ret = -EINVAL;
 		goto out_free_new_fdt;
 	}
 
-	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
+	ret = of_overlay_apply(new_fdt, new_fdt_align, overlay_root, ovcs_id);
 	if (ret < 0) {
 		/*
 		 * new_fdt and overlay_root now belong to the overlay
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eb100627c186..29081a8b32e6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/kernel.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
@@ -1408,6 +1409,7 @@ static void attach_node_and_children(struct device_node *np)
 static int __init unittest_data_add(void)
 {
 	void *unittest_data;
+	void *unittest_data_align;
 	struct device_node *unittest_data_node, *np;
 	/*
 	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
@@ -1415,7 +1417,7 @@ static int __init unittest_data_add(void)
 	 */
 	extern uint8_t __dtb_testcases_begin[];
 	extern uint8_t __dtb_testcases_end[];
-	const int size = __dtb_testcases_end - __dtb_testcases_begin;
+	u32 size = __dtb_testcases_end - __dtb_testcases_begin;
 	int rc;
 
 	if (!size) {
@@ -1425,11 +1427,15 @@ static int __init unittest_data_add(void)
 	}
 
 	/* creating copy */
-	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
+	size += FDT_ALIGN_SIZE;
+	unittest_data = kmalloc(size, GFP_KERNEL);
 	if (!unittest_data)
 		return -ENOMEM;
 
-	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
+	unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
+	memcpy(unittest_data_align, __dtb_testcases_begin, size);
+
+	of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
 		kfree(unittest_data);
-- 
Frank Rowand <frank.rowand@sony.com>

