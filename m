Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84816323489
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhBWXzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhBWXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:38:42 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC89C0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:22 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g4so244871pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhTtWZ2doNdRzGDtmgu+jcX3oUvQ8f/zyG4h5bfvKfU=;
        b=oJCAZRog6hxBAFJw2zpiSM+UvYVpBhl6yqgyqt6dOItsdVpAy+Kv4v+nUBfcqbhALd
         VMm/uz8Iy9pICeudHEluanUam5NITXMiefOGc3QRfPNVfhpnFaPzNQqTx3gpxnUaiS6G
         zvWacl8Eb4rVT70iE12VJbCZQYd5TK+ydLD2YedIWDxaidsX+FvkzYaLjpFouHXBTuoZ
         Xr6o4zkgDgTUpS9yJmNJ/YHc2kraD5PorZUunMLmdALlvGkSSZczpvfcWwiA1A1bF1RN
         VUhPRCQrQ/S4rHt/Xq/kbSelkCh9/sGshD9zH2fFle3YMvWlBg6F0vQFeA+4YLvrIiP6
         nXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhTtWZ2doNdRzGDtmgu+jcX3oUvQ8f/zyG4h5bfvKfU=;
        b=r5Pe0YTKkl/9gLLs2WJSTkweVAZb1iJx+iJWjX9bDSh/qufi0KKSCI/uWmqcyIgvnO
         7ZVVzKBpxUrnyX1ts6B8901hZvyiukWtPzEsCAFyxOMy1hNacW3dsDPrB7iNIH3yTWXO
         2kIQ5s59L+oFgYhd0UHwA0L5A4biHe8qKYE8Y2LF8BRZC3QagW9u9WOcAdcF9VA7oENB
         i8WGDk3DFW9BNWHTlZDvk3GHuGQQdqyGkRpfi40Wcy45q4GT/w4BgNfAR5ZlcW79hMiV
         6GYY+WhRQ/qqEOBu+LWWR2p/qt6vCBR8vVrg0r7/0n8cqFWMmMUdl7OkaXec8ZdV/H16
         KTWA==
X-Gm-Message-State: AOAM532pF7W16SMOqeQrIgkq2ncrLrRjv3TrSMV+6pjDXUNdDPaq89W+
        YsYClK6UIAT6um7eYATYLqSa/w==
X-Google-Smtp-Source: ABdhPJyyk1a9A4dF+jF++NTAGKcmDAEFkg+LKnFi+FHWIYuXkBFjIHVrtAUNNc+tQhYddkk/W8JbJg==
X-Received: by 2002:a62:83ca:0:b029:1ed:78d1:531a with SMTP id h193-20020a6283ca0000b02901ed78d1531amr15767699pfe.56.1614123322159;
        Tue, 23 Feb 2021 15:35:22 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:21 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 05/16] remoteproc: Add new get_loaded_rsc_table() to rproc_ops
Date:   Tue, 23 Feb 2021 16:35:04 -0700
Message-Id: <20210223233515.3468677-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new get_loaded_rsc_table() operation in order to support
scenarios where the remoteproc core has booted a remote processor
and detaches from it.  When re-attaching to the remote processor,
the core needs to know where the resource table has been placed
in memory.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
New for V6:
- Don't return an error if a resource table doesn't exist.
---

 drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h | 10 ++++++++
 include/linux/remoteproc.h               |  6 ++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8c7e9f1d50d7..0012b7bdce24 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1537,6 +1537,32 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static int rproc_set_loaded_rsc_table(struct rproc *rproc)
+{
+	struct resource_table *table_ptr;
+	struct device *dev = &rproc->dev;
+	size_t table_sz;
+	int ret;
+
+	table_ptr = rproc_get_loaded_rsc_table(rproc, &table_sz);
+	if (!table_ptr) {
+		/* Not having a resource table is acceptable */
+		return 0;
+	}
+
+	if (IS_ERR(table_ptr)) {
+		ret = PTR_ERR(table_ptr);
+		dev_err(dev, "can't load resource table: %d\n", ret);
+		return ret;
+	}
+
+	rproc->cached_table = NULL;
+	rproc->table_ptr = table_ptr;
+	rproc->table_sz = table_sz;
+
+	return 0;
+}
+
 /*
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
@@ -1556,6 +1582,12 @@ static int rproc_attach(struct rproc *rproc)
 		return ret;
 	}
 
+	ret = rproc_set_loaded_rsc_table(rproc);
+	if (ret) {
+		dev_err(dev, "can't load resource table: %d\n", ret);
+		goto disable_iommu;
+	}
+
 	/* reset max_notifyid */
 	rproc->max_notifyid = -1;
 
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index c34002888d2c..4f73aac7e60d 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -177,6 +177,16 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 	return NULL;
 }
 
+static inline
+struct resource_table *rproc_get_loaded_rsc_table(struct rproc *rproc,
+						  size_t *size)
+{
+	if (rproc->ops->get_loaded_rsc_table)
+		return rproc->ops->get_loaded_rsc_table(rproc, size);
+
+	return NULL;
+}
+
 static inline
 bool rproc_u64_fit_in_size_t(u64 val)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 6b0a0ed30a03..51538a7d120d 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -368,7 +368,9 @@ enum rsc_handling_status {
  * RSC_HANDLED if resource was handled, RSC_IGNORED if not handled and a
  * negative value on error
  * @load_rsc_table:	load resource table from firmware image
- * @find_loaded_rsc_table: find the loaded resouce table
+ * @find_loaded_rsc_table: find the loaded resource table from firmware image
+ * @get_loaded_rsc_table: get resource table installed in memory
+ *			  by external entity
  * @load:		load firmware to memory, where the remote processor
  *			expects to find it
  * @sanity_check:	sanity check the fw image
@@ -390,6 +392,8 @@ struct rproc_ops {
 			  int offset, int avail);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
+	struct resource_table *(*get_loaded_rsc_table)(
+				struct rproc *rproc, size_t *size);
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
-- 
2.25.1

