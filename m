Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C628A42C13F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJMNWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbhJMNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:22:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D4AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so8397341wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mgFSrV+iMN1oBi/O+8oct0dgEOn7Saj407EzA+v2vE=;
        b=zJTTw5qhEsbNqCMN5+WT0gytwlz2nL+F4I8Qz1I6H9ZUcG315aQAJCxFgYSePNr3yw
         yff8UiYuE1laYr5aeFAKlgxZhUG4CXhwaY5fS3Sfj4lPcUyCCdSF7PM8bT6ereSB8mYI
         IxwFlbcrYix/tinoc+hdtx1ZR8oNHAX3bkq+tHVLaFY6PX3TzRVGjjTbAdsXGuwx7PKu
         gTuO8boENhV9LdhmqMmBU+O9sFSO0VA+F6LKzYvKSzpe9g5ga2tXdBvkWvSZdlr7HI4+
         vohOFjDmsjF7tRY6YYM78yKI79avusJi51j3tsKjrIoVvja3TV782byte0RrIwSD+b+z
         xK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mgFSrV+iMN1oBi/O+8oct0dgEOn7Saj407EzA+v2vE=;
        b=aKSa3uPC0ScSwY6gL8EQSdvmAPjlogthkTQCaoerWdQ+QXzw5sNS/jm4GKmRRscF3E
         vF/1UWVfGieAm21O/yut9u0P2NGCo92YkBMTEnEgsQAVN/xCXFvP7nEBj+T/u+JWiGMD
         gCSaqODxvSqBueYdg/LA64ATmWnrkehmRP4mNCTz5nqw9dIpWXfgQnufbIK/0Miwwx2b
         KjKgP0HAY+eiMT0Ezvy9Y2Z6TCRLZ8FMestf7e3nu1vW1Mt5ZmzfWTFwWJpPOUHV4/Wf
         H29bIrun0TjBsoswNwXS2+9/C8dnx1ftDQWO8od4UqAtzX67iDxEsSdCvIaxKrPJbxCA
         mG9A==
X-Gm-Message-State: AOAM5302YEVgryb4fjXKAmjxo/Memh3P4nREGYYRyotJ+u++R6myAdoq
        U3SzqpHuc2HWMaqEwQEzrna+zA==
X-Google-Smtp-Source: ABdhPJxSIEKCv88UDZ+zKs9/rydrd2Oo1bC4db+6bfBGeqaDZPwFgNn6Qk+9WaJ1A0xBMsqLqTGmOg==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr13126045wmq.110.1634131227634;
        Wed, 13 Oct 2021 06:20:27 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r4sm2281367wrz.58.2021.10.13.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:20:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 1/3] nvmem: core: rework nvmem cell instance creation
Date:   Wed, 13 Oct 2021 14:19:55 +0100
Message-Id: <20211013131957.30271-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
References: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the existing design, we do not create a instance per nvmem cell consumer
but we directly refer cell from nvmem cell list that are added to provider.

However this design has some limitations when consumers want to assign name
or connection id the nvmem cell instance, ex: via "nvmem-cell-names" or
id in nvmem_cell_get(id).

Having a name associated with nvmem cell consumer instance will help
provider drivers in performing post processing of nvmem cell data if required
before data is seen by the consumers. This is pretty normal with some vendors
storing nvmem cells like mac-address in a vendor specific data layouts that
are not directly usable by the consumer drivers.

With this patch nvmem cell will be created dynamically during nvmem_cell_get
and destroyed in nvmem_cell_put, allowing consumers to associate name with
nvmem cell consumer instance.

With this patch a new struct nvmem_cell_entry replaces struct nvmem_cell
for storing nvmem cell information within the core.
This patch does not change nvmem-consumer interface based on nvmem_cell.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/core.c | 165 +++++++++++++++++++++++++++----------------
 1 file changed, 105 insertions(+), 60 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 8976da38b375..277ca5b47ade 100644
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
+static void nvmem_cell_entry_drop(struct nvmem_cell_entry *cell)
 {
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
 	mutex_lock(&nvmem_mutex);
@@ -435,13 +439,13 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 
 static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
-	struct nvmem_cell *cell, *p;
+	struct nvmem_cell_entry *cell, *p;
 
 	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
-		nvmem_cell_drop(cell);
+		nvmem_cell_entry_drop(cell);
 }
 
-static void nvmem_cell_add(struct nvmem_cell *cell)
+static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
 {
 	mutex_lock(&nvmem_mutex);
 	list_add_tail(&cell->node, &cell->nvmem->cells);
@@ -449,9 +453,9 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
 }
 
-static int nvmem_cell_info_to_nvmem_cell_nodup(struct nvmem_device *nvmem,
-					const struct nvmem_cell_info *info,
-					struct nvmem_cell *cell)
+static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
+						     const struct nvmem_cell_info *info,
+						     struct nvmem_cell_entry *cell)
 {
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
@@ -475,13 +479,13 @@ static int nvmem_cell_info_to_nvmem_cell_nodup(struct nvmem_device *nvmem,
 	return 0;
 }
 
-static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
-				const struct nvmem_cell_info *info,
-				struct nvmem_cell *cell)
+static int nvmem_cell_info_to_nvmem_cell_entry(struct nvmem_device *nvmem,
+					       const struct nvmem_cell_info *info,
+					       struct nvmem_cell_entry *cell)
 {
 	int err;
 
-	err = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, cell);
+	err = nvmem_cell_info_to_nvmem_cell_entry_nodup(nvmem, info, cell);
 	if (err)
 		return err;
 
@@ -505,7 +509,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		    const struct nvmem_cell_info *info,
 		    int ncells)
 {
-	struct nvmem_cell **cells;
+	struct nvmem_cell_entry **cells;
 	int i, rval;
 
 	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
@@ -519,13 +523,13 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 			goto err;
 		}
 
-		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
+		rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, &info[i], cells[i]);
 		if (rval) {
 			kfree(cells[i]);
 			goto err;
 		}
 
-		nvmem_cell_add(cells[i]);
+		nvmem_cell_entry_add(cells[i]);
 	}
 
 	/* remove tmp array */
@@ -534,7 +538,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 	return 0;
 err:
 	while (i--)
-		nvmem_cell_drop(cells[i]);
+		nvmem_cell_entry_drop(cells[i]);
 
 	kfree(cells);
 
@@ -571,7 +575,7 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 {
 	const struct nvmem_cell_info *info;
 	struct nvmem_cell_table *table;
-	struct nvmem_cell *cell;
+	struct nvmem_cell_entry *cell;
 	int rval = 0, i;
 
 	mutex_lock(&nvmem_cell_mutex);
@@ -586,15 +590,13 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 					goto out;
 				}
 
-				rval = nvmem_cell_info_to_nvmem_cell(nvmem,
-								     info,
-								     cell);
+				rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, info, cell);
 				if (rval) {
 					kfree(cell);
 					goto out;
 				}
 
-				nvmem_cell_add(cell);
+				nvmem_cell_entry_add(cell);
 			}
 		}
 	}
@@ -604,10 +606,10 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 	return rval;
 }
 
-static struct nvmem_cell *
-nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
+static struct nvmem_cell_entry *
+nvmem_find_cell_entry_by_name(struct nvmem_device *nvmem, const char *cell_id)
 {
-	struct nvmem_cell *iter, *cell = NULL;
+	struct nvmem_cell_entry *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
 	list_for_each_entry(iter, &nvmem->cells, node) {
@@ -678,7 +680,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
 	struct device_node *parent, *child;
 	struct device *dev = &nvmem->dev;
-	struct nvmem_cell *cell;
+	struct nvmem_cell_entry *cell;
 	const __be32 *addr;
 	int len;
 
@@ -727,7 +729,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 		}
 
 		cell->np = of_node_get(child);
-		nvmem_cell_add(cell);
+		nvmem_cell_entry_add(cell);
 	}
 
 	return 0;
@@ -1142,9 +1144,33 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
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
+	return cell;
+}
+
 static struct nvmem_cell *
 nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 {
+	struct nvmem_cell_entry *cell_entry;
 	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
 	struct nvmem_cell_lookup *lookup;
 	struct nvmem_device *nvmem;
@@ -1169,11 +1195,15 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 				break;
 			}
 
-			cell = nvmem_find_cell_by_name(nvmem,
-						       lookup->cell_name);
-			if (!cell) {
+			cell_entry = nvmem_find_cell_entry_by_name(nvmem,
+								   lookup->cell_name);
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
@@ -1184,10 +1214,10 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 }
 
 #if IS_ENABLED(CONFIG_OF)
-static struct nvmem_cell *
-nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
+static struct nvmem_cell_entry *
+nvmem_find_cell_entry_by_node(struct nvmem_device *nvmem, struct device_node *np)
 {
-	struct nvmem_cell *iter, *cell = NULL;
+	struct nvmem_cell_entry *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
 	list_for_each_entry(iter, &nvmem->cells, node) {
@@ -1217,6 +1247,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 {
 	struct device_node *cell_np, *nvmem_np;
 	struct nvmem_device *nvmem;
+	struct nvmem_cell_entry *cell_entry;
 	struct nvmem_cell *cell;
 	int index = 0;
 
@@ -1237,12 +1268,16 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
 
-	cell = nvmem_find_cell_by_node(nvmem, cell_np);
-	if (!cell) {
+	cell_entry = nvmem_find_cell_entry_by_node(nvmem, cell_np);
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
@@ -1348,13 +1383,17 @@ EXPORT_SYMBOL(devm_nvmem_cell_put);
  */
 void nvmem_cell_put(struct nvmem_cell *cell)
 {
-	struct nvmem_device *nvmem = cell->nvmem;
+	struct nvmem_device *nvmem = cell->entry->nvmem;
+
+	if (cell->id)
+		kfree_const(cell->id);
 
+	kfree(cell);
 	__nvmem_device_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
+static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
 	int i, extra, bit_offset = cell->bit_offset;
@@ -1388,8 +1427,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
-		      struct nvmem_cell *cell,
-		      void *buf, size_t *len)
+		      struct nvmem_cell_entry *cell,
+		      void *buf, size_t *len, const char *id)
 {
 	int rc;
 
@@ -1420,18 +1459,18 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
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
@@ -1441,7 +1480,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read);
 
-static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
+static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell_entry *cell,
 					     u8 *_buf, int len)
 {
 	struct nvmem_device *nvmem = cell->nvmem;
@@ -1494,16 +1533,7 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
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
+static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, size_t len)
 {
 	struct nvmem_device *nvmem = cell->nvmem;
 	int rc;
@@ -1529,6 +1559,21 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
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
+	return __nvmem_cell_entry_write(cell->entry, buf, len);
+}
+
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
 static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
@@ -1631,7 +1676,7 @@ static const void *nvmem_cell_read_variable_common(struct device *dev,
 	if (IS_ERR(cell))
 		return cell;
 
-	nbits = cell->nbits;
+	nbits = cell->entry->nbits;
 	buf = nvmem_cell_read(cell, len);
 	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
@@ -1727,18 +1772,18 @@ EXPORT_SYMBOL_GPL(nvmem_cell_read_variable_le_u64);
 ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 			   struct nvmem_cell_info *info, void *buf)
 {
-	struct nvmem_cell cell;
+	struct nvmem_cell_entry cell;
 	int rc;
 	ssize_t len;
 
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, &cell);
+	rc = nvmem_cell_info_to_nvmem_cell_entry_nodup(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len);
+	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL);
 	if (rc)
 		return rc;
 
@@ -1758,17 +1803,17 @@ EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf)
 {
-	struct nvmem_cell cell;
+	struct nvmem_cell_entry cell;
 	int rc;
 
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, &cell);
+	rc = nvmem_cell_info_to_nvmem_cell_entry_nodup(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
-	return nvmem_cell_write(&cell, buf, cell.bytes);
+	return __nvmem_cell_entry_write(&cell, buf, cell.bytes);
 }
 EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
 
-- 
2.21.0

