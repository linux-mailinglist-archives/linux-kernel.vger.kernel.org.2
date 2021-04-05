Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4A353B10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhDED3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhDED27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:28:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD0C061756;
        Sun,  4 Apr 2021 20:28:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x14so10408402qki.10;
        Sun, 04 Apr 2021 20:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5zoCpQQgqYkNOGYJOccBJdCJJ5AFJ90QjvmwK7K4GtA=;
        b=M2WFkMiiSMsNOC1tr/AXr89zcG54uiSPWUj527kuiVCVfUs5XlbnMa+rejVUIjzssu
         wcPBsv+LmyIJwCu92Esx1Gtl4rK1P3yPSaX0GVqtYadvJr99u2OJngNEzcgZCTvYknRz
         kpFmJbL/Mx5ROBltLPRRZsN8x2AqZr4QCrnHTAz03qXsyF5cAI0m2E4YJB2AySIL/XIg
         NYt3ibfQuCpawOT+aa7fYRy31fO5aTiRJZkeKZ8qAlGYwUf1OmU86yZIgzR8qGiBjrrY
         WNCHeXgRW1m8josbe65DAxNBCtwZDllGvGLcdWt/gFiDOLOvm7iQJwjBH6f/mAzpJ3bz
         bplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5zoCpQQgqYkNOGYJOccBJdCJJ5AFJ90QjvmwK7K4GtA=;
        b=quZ3Wa2ikOBzwhnfbXIhduukjXdWS5qX1a1zxwyTlIUMDyRChJclro8of8RqCasGtF
         bM5o1AmvgEW70Hzj3EXy/Vg40gR4CwC62fwSl421QT0r4m+ZaAv+Y8d/MQcApr9zQDLw
         DIBkXRY2y0lMj8vXD48OFHSebSW6uKNVcN015PBfa2JbZpKPz9tKuptehz72VrPDOCH3
         /KstXBNgoHpNe+zZ7cHJ2DGBAbCEQx8JAb7OFy5CVH7Lo+qGtLsDLdC88T9C8pt+qW8J
         MomuiNXVGw1IVl9NeWya/+0PGyKUE/fZ0/oElt5ZAFb6N2yup71poZp5FIFizqa1ULm0
         HJnA==
X-Gm-Message-State: AOAM530TM3OgxEE0/cG7mBH5J44/JnbFWQvu8cDxSll+kj93VUSSAeGm
        Fo11Cfj6NVQwI24Uk0XJadg=
X-Google-Smtp-Source: ABdhPJzXeldqkRXnmVvc0Rfmw2UoOgpCcPgXbcs9rB5mLkfwUQfAbhYuxfa2QnQwRiqoaxGsTy7d1g==
X-Received: by 2002:a37:a48a:: with SMTP id n132mr21899027qke.359.1617593333181;
        Sun, 04 Apr 2021 20:28:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id a20sm12680402qkg.61.2021.04.04.20.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 20:28:52 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: properly check for error returned by fdt_get_name()
Date:   Sun,  4 Apr 2021 22:28:45 -0500
Message-Id: <20210405032845.1942533-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

fdt_get_name() returns error values via a parameter pointer
instead of in function return.  Fix check for this error value
in populate_node() and callers of populate_node().

Chasing up the caller tree showed callers of various functions
failing to initialize the value of pointer parameters that
can return error values.  Initialize those values to NULL.

The bug was introduced by
commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
but this patch can not be backported directly to that commit
because the relevant code has further been restructured by
commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")

The bug became visible by triggering a crash on openrisc with:
commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
as reported in:
https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/

Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>

---

This patch papers over the unaligned pointer passed to
of_fdt_unflatten_tree() bug that Guenter reported in
https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/

I will create a separate patch to fix that problem.

 drivers/of/fdt.c      | 36 +++++++++++++++++++++++-------------
 drivers/of/overlay.c  |  2 +-
 drivers/of/unittest.c | 15 ++++++++++-----
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a..adb26aff481d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -205,7 +205,7 @@ static void populate_properties(const void *blob,
 		*pprev = NULL;
 }
 
-static bool populate_node(const void *blob,
+static int populate_node(const void *blob,
 			  int offset,
 			  void **mem,
 			  struct device_node *dad,
@@ -214,24 +214,24 @@ static bool populate_node(const void *blob,
 {
 	struct device_node *np;
 	const char *pathp;
-	unsigned int l, allocl;
+	int len;
 
-	pathp = fdt_get_name(blob, offset, &l);
+	pathp = fdt_get_name(blob, offset, &len);
 	if (!pathp) {
 		*pnp = NULL;
-		return false;
+		return len;
 	}
 
-	allocl = ++l;
+	len++;
 
-	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + allocl,
+	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + len,
 				__alignof__(struct device_node));
 	if (!dryrun) {
 		char *fn;
 		of_node_init(np);
 		np->full_name = fn = ((char *)np) + sizeof(*np);
 
-		memcpy(fn, pathp, l);
+		memcpy(fn, pathp, len);
 
 		if (dad != NULL) {
 			np->parent = dad;
@@ -295,6 +295,7 @@ static int unflatten_dt_nodes(const void *blob,
 	struct device_node *nps[FDT_MAX_DEPTH];
 	void *base = mem;
 	bool dryrun = !base;
+	int ret;
 
 	if (nodepp)
 		*nodepp = NULL;
@@ -322,9 +323,10 @@ static int unflatten_dt_nodes(const void *blob,
 		    !of_fdt_device_is_available(blob, offset))
 			continue;
 
-		if (!populate_node(blob, offset, &mem, nps[depth],
-				   &nps[depth+1], dryrun))
-			return mem - base;
+		ret = populate_node(blob, offset, &mem, nps[depth],
+				   &nps[depth+1], dryrun);
+		if (ret < 0)
+			return ret;
 
 		if (!dryrun && nodepp && !*nodepp)
 			*nodepp = nps[depth+1];
@@ -372,6 +374,10 @@ void *__unflatten_device_tree(const void *blob,
 {
 	int size;
 	void *mem;
+	int ret;
+
+	if (mynodes)
+		*mynodes = NULL;
 
 	pr_debug(" -> unflatten_device_tree()\n");
 
@@ -392,7 +398,7 @@ void *__unflatten_device_tree(const void *blob,
 
 	/* First pass, scan for size */
 	size = unflatten_dt_nodes(blob, NULL, dad, NULL);
-	if (size < 0)
+	if (size <= 0)
 		return NULL;
 
 	size = ALIGN(size, 4);
@@ -410,12 +416,16 @@ void *__unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_nodes(blob, mem, dad, mynodes);
+	ret = unflatten_dt_nodes(blob, mem, dad, mynodes);
+
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warn("End of tree marker overwritten: %08x\n",
 			be32_to_cpup(mem + size));
 
-	if (detached && mynodes) {
+	if (ret <= 0)
+		return NULL;
+
+	if (detached && mynodes && *mynodes) {
 		of_node_set_flag(*mynodes, OF_DETACHED);
 		pr_debug("unflattened tree is detached\n");
 	}
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 50bbe0edf538..e12c643b6ba8 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1017,7 +1017,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	const void *new_fdt;
 	int ret;
 	u32 size;
-	struct device_node *overlay_root;
+	struct device_node *overlay_root = NULL;
 
 	*ovcs_id = 0;
 	ret = 0;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eb100627c186..f9b5b698249f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1408,7 +1408,7 @@ static void attach_node_and_children(struct device_node *np)
 static int __init unittest_data_add(void)
 {
 	void *unittest_data;
-	struct device_node *unittest_data_node, *np;
+	struct device_node *unittest_data_node = NULL, *np;
 	/*
 	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
 	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
@@ -1417,10 +1417,10 @@ static int __init unittest_data_add(void)
 	extern uint8_t __dtb_testcases_end[];
 	const int size = __dtb_testcases_end - __dtb_testcases_begin;
 	int rc;
+	void *ret;
 
 	if (!size) {
-		pr_warn("%s: No testcase data to attach; not running tests\n",
-			__func__);
+		pr_warn("%s: testcases is empty\n", __func__);
 		return -ENODATA;
 	}
 
@@ -1429,9 +1429,14 @@ static int __init unittest_data_add(void)
 	if (!unittest_data)
 		return -ENOMEM;
 
-	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
+	ret = of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
+	if (!ret) {
+		pr_warn("%s: unflatten testcases tree failed\n", __func__);
+		kfree(unittest_data);
+		return -ENODATA;
+	}
 	if (!unittest_data_node) {
-		pr_warn("%s: No tree to attach; not running tests\n", __func__);
+		pr_warn("%s: testcases tree is empty\n", __func__);
 		kfree(unittest_data);
 		return -ENODATA;
 	}
-- 
Frank Rowand <frank.rowand@sony.com>

