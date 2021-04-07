Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737B7357655
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhDGUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhDGUvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:51:37 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F954C061760;
        Wed,  7 Apr 2021 13:51:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id fn8so4935294qvb.5;
        Wed, 07 Apr 2021 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jd0yqIKV3bGFH4tOMYBXCdLTdlJ3rucUciwxMqvzciQ=;
        b=VCVDoQQZw4ha/n6q2dKCETsUtUv0JqJ2MhG+kJvagziKejcXzYlMHPcQqzkX0JtDb0
         1amXDJPInPbUo4WZCiZRkt+f+CXNQhbihPqsZge/ZR95b7JtENK/KEYDVWyXl41bTVfH
         kX3sEDz5npe0NizZhaupr/pWajGOtyMxcCid7irjtQUotL6b7ilRBheHS4QIo7f/fNPb
         YlD1izi5q+XXSrKf/087Pp3Sng5C72WWVM8e152zTNp3qZsLmX3rK38Z80ZDI5w1pKPw
         Wa/bk7ExetfiFCTAhstcZsMbfOWUmofl1b7vFKHsXNEoWgOVx+W/dDdQRgFSdV8Mvm0u
         UQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jd0yqIKV3bGFH4tOMYBXCdLTdlJ3rucUciwxMqvzciQ=;
        b=Hc1UHcZRYwaGe7R31CcwHzsCy9RyraRiJAEdE+tTuSedXcImAa3GnY9iLlSiy6OErw
         nTQEyMHflmqWbchCMoVr+GebxbP1b3I7C5sXZJ+8ei+scLCPhSdxlMWaNV3P4uhm0Or1
         1l37qk3O6RAX76BGZnw+usbN85PLmt/tRAI3rlkRQJaRzj/3o0vU9JMDhTf5FslmuZt6
         dqPVLWTPWHkz35i2Cb5P+zZcmUvu2E7eQxFJSy/Wr1sX27z7TLtkNjVF67cCUVs7Ge4j
         5Riz0aZbHHl7lcXaAQTTZ8u24RLkf1/u0q6I1VmnGKGvErnhekP9B3DxxL6g1hEiuENT
         YKXA==
X-Gm-Message-State: AOAM533dPgU4oCWLpZghb66NB1PLfXIgdl9k8R/biWxxwQHamcdH3Mru
        iNxsMcmSTrhmRnH82b9xzAA=
X-Google-Smtp-Source: ABdhPJzCeAm4XPsh392+HiHwKIEpHzVT6ZABMLc6nWVp9sbMH6PAkSt5dxS7aXXmD/UY/u69YCmrEQ==
X-Received: by 2002:ad4:4cca:: with SMTP id i10mr5435275qvz.49.1617828685571;
        Wed, 07 Apr 2021 13:51:25 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id c5sm19564370qkg.105.2021.04.07.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 13:51:25 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: overlay: ensure proper alignment of copied FDT
Date:   Wed,  7 Apr 2021 15:51:10 -0500
Message-Id: <20210407205110.2173976-1-frowand.list@gmail.com>
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
 drivers/of/of_private.h | 2 ++
 drivers/of/overlay.c    | 8 ++++++--
 drivers/of/unittest.c   | 9 +++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

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
index 50bbe0edf538..8b40711ed202 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1014,7 +1014,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 			 int *ovcs_id)
 {
-	const void *new_fdt;
+	void *new_fdt;
 	int ret;
 	u32 size;
 	struct device_node *overlay_root;
@@ -1036,10 +1036,14 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
 	 * will create pointers to the passed in FDT in the unflattened tree.
 	 */
-	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
+	size += FDT_ALIGN_SIZE;
+	new_fdt = kmalloc(size, GFP_KERNEL);
 	if (!new_fdt)
 		return -ENOMEM;
 
+	new_fdt = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
+	memcpy(new_fdt, overlay_fdt, size);
+
 	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
 	if (!overlay_root) {
 		pr_err("unable to unflatten overlay_fdt\n");
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eb100627c186..edd6ce807691 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/kernel.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
@@ -1415,7 +1416,7 @@ static int __init unittest_data_add(void)
 	 */
 	extern uint8_t __dtb_testcases_begin[];
 	extern uint8_t __dtb_testcases_end[];
-	const int size = __dtb_testcases_end - __dtb_testcases_begin;
+	u32 size = __dtb_testcases_end - __dtb_testcases_begin;
 	int rc;
 
 	if (!size) {
@@ -1425,10 +1426,14 @@ static int __init unittest_data_add(void)
 	}
 
 	/* creating copy */
-	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
+	size += FDT_ALIGN_SIZE;
+	unittest_data = kmalloc(size, GFP_KERNEL);
 	if (!unittest_data)
 		return -ENOMEM;
 
+	unittest_data = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
+	memcpy(unittest_data, __dtb_testcases_begin, size);
+
 	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
-- 
Frank Rowand <frank.rowand@sony.com>

