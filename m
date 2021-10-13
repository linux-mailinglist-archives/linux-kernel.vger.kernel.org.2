Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BF42C140
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhJMNWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:22:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C8C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so8324407wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLVvQfXbLN5IE/H2dtFBLOIYoDlAfvYNMVf+EYllJ84=;
        b=uzFl50gE40hliyFS7rHAA3LRyS+gT27nKz7JF+iDTiyfT5IbnieVF5V4xM2mBnysoD
         rOii2RChMBtXi/flJRFXY39qmZjDnjRMVlYCHRQd3eAjW+/2doGbfjGXmiE4dwLKNu+P
         aMdUypIn4CQbtWZYl4FSAX6JstZgb8b+iSXCKB6pjj6cjUgrDr60OZ1J+in3gbgBLzu/
         Z3Grr2g88Uss4zPP8d6iO0WDptfqTFxkjyYF7DFA5ixNsvJTqMZodB4iiQV3NMz0T5bi
         9GVuCpLGHfYrTibaNOgNIkk22m0KFbHUayMkjVElggJHzua+b3sS4ShEDdCESSQL7Rak
         Cfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLVvQfXbLN5IE/H2dtFBLOIYoDlAfvYNMVf+EYllJ84=;
        b=wzoHWTEVtqN7o7gNLOLWg94CZTehu1SK5tQYzdEdEAqiGitKPsKiHqMjScLeVqFqnP
         eUyd8XNXuTbvQx9ATNQGDmA7Z+bZ8Bc8lug+TAkI6iVzZXNNWYmO1w0EnPmglkEu0HA8
         tG7US7hzj/ZNhszfc7Vg0t0Jw6aeVl5WL13vUP4iPFbBGvApI/Xq774FSk68i8RgcTAc
         nEznSTZGDmvE4N2XHn5pi+TEbEoGUG++yofPZbKIgSAIMEdt7eyPfPlZhzTjoawutHaO
         6b+kW/URrqxyl4P2ZPqwlPNp9RSKchC64vSA/eWOeo26sFaevqDxsJqnGXo/lK0561Ap
         boyQ==
X-Gm-Message-State: AOAM530lYtO9JePUePZbvj80XmCdSeTn7Lsj/CaRfTZbWcv5AnSznre/
        whfZ1jkEMO3FIOO22jEZ9/2fR0ooTGkIKA==
X-Google-Smtp-Source: ABdhPJwe+6u1F/AB2+KiIL3ZX9LR5vcg1wywNLvGB1kUDnu6QBhpYDY0fLHJNH80GwoaFA+WI8lqKg==
X-Received: by 2002:a05:6000:2ca:: with SMTP id o10mr27003222wry.383.1634131228552;
        Wed, 13 Oct 2021 06:20:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r4sm2281367wrz.58.2021.10.13.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:20:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/3] nvmem: core: add nvmem cell post processing callback
Date:   Wed, 13 Oct 2021 14:19:56 +0100
Message-Id: <20211013131957.30271-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
References: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NVMEM providers have certain nvmem cells encoded, which requires
post processing before actually using it.

For example mac-address is stored in either in ascii or delimited or reverse-order.

Having a post-process callback hook to provider drivers would enable them to
do this vendor specific post processing before nvmem consumers see it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/core.c           | 9 +++++++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 277ca5b47ade..e765d3d0542e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	void *priv;
 };
@@ -796,6 +797,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1441,6 +1443,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
+	if (nvmem->cell_post_process) {
+		rc = nvmem->cell_post_process(nvmem->priv, id,
+					      cell->offset, buf, cell->bytes);
+		if (rc)
+			return rc;
+	}
+
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 104505e9028f..98efb7b5660d 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -19,6 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
+/* used for vendor specific post processing of cell data */
+typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, unsigned int offset,
+					  void *buf, size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -62,6 +65,7 @@ struct nvmem_keepout {
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
+ * @cell_post_process:	Callback for vendor specific post processing of cell data
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -92,6 +96,7 @@ struct nvmem_config {
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_cell_post_process_t cell_post_process;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.21.0

