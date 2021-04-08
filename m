Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEF358EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhDHUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhDHUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:45:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388CC061760;
        Thu,  8 Apr 2021 13:45:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x9so2537409qto.8;
        Thu, 08 Apr 2021 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U95oVFeAb6Z+9NxJb1H5egs5hOsSECLN/kMVgmi9JOc=;
        b=huFby21ms17Ix5Si/C/jQCpbXW+zq+9B9dNfBmVO7xGIinnb/QyMwKOd8pg6UiGntB
         PtjJHAW7VermjmlZtfOsaFvRm7rTdHuLzuUMrzDilyqqimLKLFXllNu7sxyYhrl8neOY
         1jH8IZf3/qCe2t+wTkuJ/SA94OozCEDlcWUR/UcEy8WOOJA+YQxXuzCHyZW5VkfiUI/B
         nzMwHf916DWedGRfwKlHGp/7/S5sBUXM6+P9XcjOuqRtVdS85FQD+wHHa1kqZxrt9EZy
         FCXrZ5kapHYkIxFnFCM+6V4lXaHiZ6gK/BTO0sTOE+ZlVNVWzgDy9Vvg72BGMCyZT7BQ
         2vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U95oVFeAb6Z+9NxJb1H5egs5hOsSECLN/kMVgmi9JOc=;
        b=HBxB66vE7EkLNfU2kBf8tXYBo/j94aYx3f2AnRL3B/5fPp+24rNHOCeEROfRZW9WKy
         gzQoNyxRIO77gR0vZAxA9TkVlxLQLjzZuMowWrlWbs34DT0CrVcDuVvpq5qF1bx9Y2cs
         deWTZMY12/8hF3bEM0DKJzXDFPsQXy/kty84qm9jkq4S2kLz5ETA1QvUheLzn3XktvBK
         o3gpfq9IpwRFW+71nDXqqC3hAiwQ7Hr5WlD30I3bxaV8SQVu+WtLn222t7iUeuA0E4w3
         hDPsrkaa2rl4M8P/GGK9l1E0eKpwMnjEhEkkQ4xAO+0+Z4h3BxX7wmOcaIqHa2DPA0Ez
         izPA==
X-Gm-Message-State: AOAM531VUcyY4bTcqdyu0dwTsDBMhyLvtmUTL8+2zNp6CNnRj4tKkmDk
        v4LdXV9caxJHmn50f1FUQXQ=
X-Google-Smtp-Source: ABdhPJwWbwhRzk+mxAoy1ms4KMi+DBrV4iCK+WqKhB6zEWmC5C0PEtu8Ls6x5rfxZHJhLDf2dxE1mQ==
X-Received: by 2002:a05:622a:28c:: with SMTP id z12mr3880465qtw.57.1617914717344;
        Thu, 08 Apr 2021 13:45:17 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id i78sm355544qke.46.2021.04.08.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:45:17 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] of: unittest: overlay: ensure proper alignment of copied FDT
Date:   Thu,  8 Apr 2021 15:45:08 -0500
Message-Id: <20210408204508.2276230-1-frowand.list@gmail.com>
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

changes since version 3:
  - size of memory allocation and size of copy after pointer alignment
    differ, use separate variables with correct values for each case
  - edit comment to more clearly describe that ovcs->fdt is the allocated
    memory region, which may be different than where the aligned pointer points
  - remove unused parameter from of_overlay_apply()

 drivers/of/of_private.h |  2 ++
 drivers/of/overlay.c    | 27 +++++++++++++++++----------
 drivers/of/unittest.c   | 13 ++++++++++---
 3 files changed, 29 insertions(+), 13 deletions(-)

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
index 50bbe0edf538..ecf967c57900 100644
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
@@ -873,7 +873,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * internal documentation
  *
  * of_overlay_apply() - Create and apply an overlay changeset
- * @fdt:	the FDT that was unflattened to create @tree
+ * @fdt:	base of memory allocated to hold the aligned FDT
  * @tree:	Expanded overlay device tree
  * @ovcs_id:	Pointer to overlay changeset id
  *
@@ -913,7 +913,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  */
 
 static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+			    int *ovcs_id)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
@@ -953,7 +953,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	/*
 	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
 	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
-	 * and can not free fdt, aka ovcs->fdt
+	 * and can not free memory containing aligned fdt.  The aligned fdt
+	 * is contained within the memory at ovcs->fdt, possibly at an offset
+	 * from ovcs->fdt.
 	 */
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
@@ -1014,9 +1016,10 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 			 int *ovcs_id)
 {
-	const void *new_fdt;
+	void *new_fdt;
+	void *new_fdt_align;
 	int ret;
-	u32 size;
+	u32 size, size_alloc;
 	struct device_node *overlay_root;
 
 	*ovcs_id = 0;
@@ -1036,11 +1039,15 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
 	 * will create pointers to the passed in FDT in the unflattened tree.
 	 */
-	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
+	size_alloc = size + FDT_ALIGN_SIZE;
+	new_fdt = kmalloc(size_alloc, GFP_KERNEL);
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
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eb100627c186..b43a86cc2068 100644
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
@@ -1415,7 +1417,8 @@ static int __init unittest_data_add(void)
 	 */
 	extern uint8_t __dtb_testcases_begin[];
 	extern uint8_t __dtb_testcases_end[];
-	const int size = __dtb_testcases_end - __dtb_testcases_begin;
+	u32 size = __dtb_testcases_end - __dtb_testcases_begin;
+	u32 size_alloc;
 	int rc;
 
 	if (!size) {
@@ -1425,11 +1428,15 @@ static int __init unittest_data_add(void)
 	}
 
 	/* creating copy */
-	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
+	size_alloc = size + FDT_ALIGN_SIZE;
+	unittest_data = kmalloc(size_alloc, GFP_KERNEL);
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

