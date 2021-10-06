Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960A442405D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhJFOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbhJFOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:49:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23190C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:47:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so9726435wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8IUDU+nIe/dXy1u0ZJ1cBerzNCEinzHUXJ6bgO80wA=;
        b=gd/RWZmlcUTdmsUIG+fRst4KGkl1ODnODUihWetlT7aAi+xeCKUFFPGzYz99eqy//8
         ou8qy3BDKoOcPRS8vQeNsCK7mLdfZE72tIl9JzItyI4FmkmAh5KNW7lMVP++OxXQxFHR
         pmaxI5C4HJfNOJ2haPxcZxMHLL4FIKu75xYXt0n+5p1arQI+yk7kxArPrd06FL5ARFPX
         2L7hpbUIJh4JlPfkCng9lKbIk5jLNGmPqrZHpBEYG4+Kko2VnZhjVTU+TOCjGybpZuue
         MBNIdAzA5oNeAbWkIE3CyfPR/Cm4czn6c6vc4G/8daBpxDjWqEmMVMyh/HC1cdHR67/K
         BJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8IUDU+nIe/dXy1u0ZJ1cBerzNCEinzHUXJ6bgO80wA=;
        b=XjiShizY/E5Fh4wOjk8bRzhxeDfeHNWTz7kj84lGwf5n1l5Ssu47Bt7ptk+GDBbk1d
         ni0yrLolvPIJOEoEnmFBMchl7O3yMyUuHyMIRapfEBUV3wjlEcw36F7ntHEBtoYmPUYk
         uIpwF6fMLO2g3jsM44S/B3y/UMZj8eJ6ND93X9ZeX7ZHstH3EMksJ+voBHxcTnUbNJZu
         Dl2Azshg9nVjHzJ09l7mKqHrOds0DFxHq1p56z3MrmYeZFlpfW1t9nvodHWEZapAZLRc
         n/FiEs7SNMEWptQYXyTNHfRNBq0zw50hmbKpANUOqbEaBVqsmeLQhp0WojgyF+AuKYyl
         S+kA==
X-Gm-Message-State: AOAM5313yalaVJO+psbC70whgfGWh5ekCUHHXanTyEMFlBeRo0757CbD
        Hflux7rymYyf6PdnB2vH/XJs3CRvK0W1uQ==
X-Google-Smtp-Source: ABdhPJyOxSJOKd4hN5hu2RqDkw8QYOnxcq3Hja9CfJKoB3hPwgIp1ho//7F3kTAu+510/E4fEyQIew==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr10396214wmq.166.1633531660698;
        Wed, 06 Oct 2021 07:47:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z18sm14589340wro.25.2021.10.06.07.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:47:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiangqing.zhang@nxp.com,
        linux-imx@nxp.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] nvmem: core: rework nvmem cell instance creation
Date:   Wed,  6 Oct 2021 15:47:27 +0100
Message-Id: <20211006144729.15268-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
References: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the existing design, instance of nvmem cell is directly by referencing
the list of nvmem cell entries that are added to provider.

However this design has some limitations when consumers want to assign name
or connection id the nvmem cell instance, ex: from "nvmem-cell-names" or
id in nvmem_cell_get().
Having a name associated with nvmem cell instance will also help provider
drivers in performing post processing of nvmem cell data if required
before its seen by the consumers.

With this patch nvmem cell will be created dynamically during nvmem_cell_get
and destroyed in nvmem_cell_put, allowing consumers to associate name with
nvmem cell instance.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 140 ++++++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 47 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3d87fadaa160..9da4e8f42d86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -45,8 +45,7 @@ struct nvmem_device {
 #define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
 
 #define FLAG_COMPAT		BIT(0)
-
-struct nvmem_cell {
+struct nvmem_cell_entry {
 	const char		*name;
 	int			offset;
 	int			bytes;
@@ -57,6 +56,11 @@ struct nvmem_cell {
 	struct list_head	node;
 };
 
+struct nvmem_cell {
+	struct nvmem_cell_entry *entry;
+	const char		*id;
+};
+
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
@@ -422,7 +426,7 @@ static struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
-static void nvmem_cell_drop(struct nvmem_cell *cell)
+static void nvmem_cell_drop(struct nvmem_cell_entry *cell)
 {
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
 	mutex_lock(&nvmem_mutex);
@@ -435,13 +439,13 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 
 static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
-	struct nvmem_cell *cell, *p;
+	struct nvmem_cell_entry *cell, *p;
 
 	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
 		nvmem_cell_drop(cell);
 }
 
-static void nvmem_cell_add(struct nvmem_cell *cell)
+static void nvmem_cell_add(struct nvmem_cell_entry *cell)
 {
 	mutex_lock(&nvmem_mutex);
 	list_add_tail(&cell->node, &cell->nvmem->cells);
@@ -451,7 +455,7 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 
 static int nvmem_cell_info_to_nvmem_cell_nodup(struct nvmem_device *nvmem,
 					const struct nvmem_cell_info *info,
-					struct nvmem_cell *cell)
+					struct nvmem_cell_entry *cell)
 {
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
@@ -477,7 +481,7 @@ static int nvmem_cell_info_to_nvmem_cell_nodup(struct nvmem_device *nvmem,
 
 static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 				const struct nvmem_cell_info *info,
-				struct nvmem_cell *cell)
+				struct nvmem_cell_entry *cell)
 {
 	int err;
 
@@ -505,7 +509,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		    const struct nvmem_cell_info *info,
 		    int ncells)
 {
-	struct nvmem_cell **cells;
+	struct nvmem_cell_entry **cells;
 	int i, rval;
 
 	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
@@ -571,7 +575,7 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 {
 	const struct nvmem_cell_info *info;
 	struct nvmem_cell_table *table;
-	struct nvmem_cell *cell;
+	struct nvmem_cell_entry *cell;
 	int rval = 0, i;
 
 	mutex_lock(&nvmem_cell_mutex);
@@ -604,10 +608,10 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 	return rval;
 }
 
-static struct nvmem_cell *
+static struct nvmem_cell_entry *
 nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
 {
-	struct nvmem_cell *iter, *cell = NULL;
+	struct nvmem_cell_entry *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
 	list_for_each_entry(iter, &nvmem->cells, node) {
@@ -678,7 +682,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
 	struct device_node *parent, *child;
 	struct device *dev = &nvmem->dev;
-	struct nvmem_cell *cell;
+	struct nvmem_cell_entry *cell;
 	const __be32 *addr;
 	int len;
 
@@ -1142,9 +1146,34 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
+static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry, const char *id)
+{
+	struct nvmem_cell *cell;
+	const char *name = NULL;
+
+	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return ERR_PTR(-ENOMEM);
+
+	if (id) {
+		name = kstrdup_const(id, GFP_KERNEL);
+		if (!name) {
+			kfree(cell);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	cell->id = name;
+	cell->entry = entry;
+
+
+	return cell;
+}
+
 static struct nvmem_cell *
 nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 {
+	struct nvmem_cell_entry *cell_entry = NULL;
 	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
 	struct nvmem_cell_lookup *lookup;
 	struct nvmem_device *nvmem;
@@ -1169,11 +1198,15 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 				break;
 			}
 
-			cell = nvmem_find_cell_by_name(nvmem,
+			cell_entry = nvmem_find_cell_by_name(nvmem,
 						       lookup->cell_name);
-			if (!cell) {
+			if (!cell_entry) {
 				__nvmem_device_put(nvmem);
 				cell = ERR_PTR(-ENOENT);
+			} else {
+				cell = nvmem_create_cell(cell_entry, con_id);
+				if (IS_ERR(cell))
+					__nvmem_device_put(nvmem);
 			}
 			break;
 		}
@@ -1184,10 +1217,10 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 }
 
 #if IS_ENABLED(CONFIG_OF)
-static struct nvmem_cell *
+static struct nvmem_cell_entry *
 nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
 {
-	struct nvmem_cell *iter, *cell = NULL;
+	struct nvmem_cell_entry *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
 	list_for_each_entry(iter, &nvmem->cells, node) {
@@ -1217,6 +1250,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 {
 	struct device_node *cell_np, *nvmem_np;
 	struct nvmem_device *nvmem;
+	struct nvmem_cell_entry *cell_entry;
 	struct nvmem_cell *cell;
 	int index = 0;
 
@@ -1237,12 +1271,16 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
 
-	cell = nvmem_find_cell_by_node(nvmem, cell_np);
-	if (!cell) {
+	cell_entry = nvmem_find_cell_by_node(nvmem, cell_np);
+	if (!cell_entry) {
 		__nvmem_device_put(nvmem);
 		return ERR_PTR(-ENOENT);
 	}
 
+	cell = nvmem_create_cell(cell_entry, id);
+	if (IS_ERR(cell))
+		__nvmem_device_put(nvmem);
+
 	return cell;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
@@ -1348,13 +1386,15 @@ EXPORT_SYMBOL(devm_nvmem_cell_put);
  */
 void nvmem_cell_put(struct nvmem_cell *cell)
 {
-	struct nvmem_device *nvmem = cell->nvmem;
+	struct nvmem_device *nvmem = cell->entry->nvmem;
 
+	kfree_const(cell->id);
+	kfree(cell);
 	__nvmem_device_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
+static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
 	int i, extra, bit_offset = cell->bit_offset;
@@ -1387,8 +1427,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
-		      struct nvmem_cell *cell,
-		      void *buf, size_t *len)
+		      struct nvmem_cell_entry *cell,
+		      void *buf, size_t *len, const char *id)
 {
 	int rc;
 
@@ -1419,18 +1459,18 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
  */
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
-	struct nvmem_device *nvmem = cell->nvmem;
+	struct nvmem_device *nvmem = cell->entry->nvmem;
 	u8 *buf;
 	int rc;
 
 	if (!nvmem)
 		return ERR_PTR(-EINVAL);
 
-	buf = kzalloc(cell->bytes, GFP_KERNEL);
+	buf = kzalloc(cell->entry->bytes, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	rc = __nvmem_cell_read(nvmem, cell, buf, len);
+	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id);
 	if (rc) {
 		kfree(buf);
 		return ERR_PTR(rc);
@@ -1440,7 +1480,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read);
 
-static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
+static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell_entry *cell,
 					     u8 *_buf, int len)
 {
 	struct nvmem_device *nvmem = cell->nvmem;
@@ -1493,34 +1533,25 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 	return ERR_PTR(rc);
 }
 
-/**
- * nvmem_cell_write() - Write to a given nvmem cell
- *
- * @cell: nvmem cell to be written.
- * @buf: Buffer to be written.
- * @len: length of buffer to be written to nvmem cell.
- *
- * Return: length of bytes written or negative on failure.
- */
-int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
+static int __nvmem_cell_write(struct nvmem_cell_entry *entry, void *buf, size_t len)
 {
-	struct nvmem_device *nvmem = cell->nvmem;
+	struct nvmem_device *nvmem = entry->nvmem;
 	int rc;
 
 	if (!nvmem || nvmem->read_only ||
-	    (cell->bit_offset == 0 && len != cell->bytes))
+	    (entry->bit_offset == 0 && len != entry->bytes))
 		return -EINVAL;
 
-	if (cell->bit_offset || cell->nbits) {
-		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
+	if (entry->bit_offset || entry->nbits) {
+		buf = nvmem_cell_prepare_write_buffer(entry, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
 	}
 
-	rc = nvmem_reg_write(nvmem, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_write(nvmem, entry->offset, buf, entry->bytes);
 
 	/* free the tmp buffer */
-	if (cell->bit_offset || cell->nbits)
+	if (entry->bit_offset || entry->nbits)
 		kfree(buf);
 
 	if (rc)
@@ -1528,6 +1559,21 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
 	return len;
 }
+
+/**
+ * nvmem_cell_write() - Write to a given nvmem cell
+ *
+ * @cell: nvmem cell to be written.
+ * @buf: Buffer to be written.
+ * @len: length of buffer to be written to nvmem cell.
+ *
+ * Return: length of bytes written or negative on failure.
+ */
+int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
+{
+	return __nvmem_cell_write(cell->entry, buf, len);
+}
+
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
 static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
@@ -1630,7 +1676,7 @@ static const void *nvmem_cell_read_variable_common(struct device *dev,
 	if (IS_ERR(cell))
 		return cell;
 
-	nbits = cell->nbits;
+	nbits = cell->entry->nbits;
 	buf = nvmem_cell_read(cell, len);
 	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
@@ -1726,7 +1772,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_read_variable_le_u64);
 ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 			   struct nvmem_cell_info *info, void *buf)
 {
-	struct nvmem_cell cell;
+	struct nvmem_cell_entry cell;
 	int rc;
 	ssize_t len;
 
@@ -1737,7 +1783,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	if (rc)
 		return rc;
 
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len);
+	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL);
 	if (rc)
 		return rc;
 
@@ -1757,7 +1803,7 @@ EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf)
 {
-	struct nvmem_cell cell;
+	struct nvmem_cell_entry cell;
 	int rc;
 
 	if (!nvmem)
@@ -1767,7 +1813,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 	if (rc)
 		return rc;
 
-	return nvmem_cell_write(&cell, buf, cell.bytes);
+	return __nvmem_cell_write(&cell, buf, cell.bytes);
 }
 EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
 
-- 
2.21.0

