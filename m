Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800DC3349A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhCJVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhCJVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C222C061763
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so8212566pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdHxs7JLHKePLMQLEfdUiVSo/tj85hv+zhe9KF+ZdIk=;
        b=qGi/D7QC5NtGmud6by8caRgcVHDoPCtR1WR3JW6Wk2O1JsLn8ZBz8UFNhPJSbvEuQr
         jzV4pdvy1IYWZLz7iVN3HwpNfLcY5aPd1Gj8cgy/vSUVb+MUSII1F0M0pGUGj6sB162O
         SH4aBT6GsWDeveC6iJv1DDuWocqvhoX8tWHdSQn+Oq91YMaqqBtOABTMWrkIi3NaTuIK
         MPifJ3ENBnxiO+aduNrmRuokrpKV8HBLwW3UD13AJvqZDY4jDhcopoIrxBsWCiEbRRgB
         Te8/+k1CxUXBYkDuHtecNWKgQX0v3so/hocDzbnm0ZpMQVWwupZVtHIm+04AX6ZcA5yE
         ijkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdHxs7JLHKePLMQLEfdUiVSo/tj85hv+zhe9KF+ZdIk=;
        b=kU9m2bY0wvroY4PIkSTjXct5BwpvYqb34BjCKZU/uEmjFUCGuxdxRsP52XD5XAii9r
         aeUjeXHYFT1eHnNV6y/rlrrO54/u5fo/s6ga5/IHVvYNR1o3vt67JR7sSQ+k/IczDvYY
         2H19E0MZBvp/mWD1U6KxLBzKYYAG4zyfrSbwu7qyJEsZUfD8c2h1XTaN3f5+WAllSjfW
         ZEIay19yjLZztmJxkP2Fc3vXCEj3H61I0cq+ZCo4A56yHymALhGAXShjtXPP1iycBZZY
         AYYbv2BHyWUQ9QyvwQ5KVGHpfvpxYpigbNFr/XlrZhSiLQNJvuX7PvhSjuNuhmzmAvmT
         ks9Q==
X-Gm-Message-State: AOAM533J3F3mirOqxJZPlulTIfsl9CDSQv5b913PATkA9jiNdfgtIORh
        UDMMCVPHpC9KorcuDJZl5RegJw==
X-Google-Smtp-Source: ABdhPJzgGxtP8iRK0o+bNkZzJwlNJpoCTWLZB2oCuCclCQxtb/AUHjJi2ZV24broslDNR7SvDA50Cg==
X-Received: by 2002:a17:902:10a:b029:e2:e8f7:2988 with SMTP id 10-20020a170902010ab02900e2e8f72988mr4683891plb.4.1615410634845;
        Wed, 10 Mar 2021 13:10:34 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:34 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 05/17] remoteproc: Add new get_loaded_rsc_table() to rproc_ops
Date:   Wed, 10 Mar 2021 14:10:13 -0700
Message-Id: <20210310211025.1084636-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
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
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h | 10 ++++++++
 include/linux/remoteproc.h               |  6 ++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8c7e9f1d50d7..bf6f6d15b1c3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1537,6 +1537,32 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static int rproc_set_rsc_table(struct rproc *rproc)
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
 
+	ret = rproc_set_rsc_table(rproc);
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

