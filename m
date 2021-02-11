Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0030B31972C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBKXwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhBKXtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:49:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B5EC061D7F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so5354212pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxlO1VydolRynfSEzFoSB43uI6cZiPrHzyGFZeYXbiQ=;
        b=jhUZ/keN7h7x6UsBjtoZBshOgO4cbRIr+Bi88FURz5l/iyJbJGX31HPdjjR46X0vSi
         svjhP0gNQZHJ1U3ccf4xwn+ySM0K0xoO6vRtUkFJN+cEbYXUEF3P4znvXeQPA3SMmrW3
         7//YzfwBz5QykLOieoYcKjvtARdGoTYKI2C62YFsxNHCSnssGfF4cn166o6S+WuYUAn8
         g7quyV0JqppJm2YRwLvd5FL7CTqq89jyMAFmFL2o3LgRK6evxAjK+IcXDCYjpBebqkjs
         V5HxkLNQgVJAXFQKOJDwj7c/xPAx+j0StJtr+oQ45UYzWVjcIp6I8VuUOJHTHVl7+DzU
         07aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxlO1VydolRynfSEzFoSB43uI6cZiPrHzyGFZeYXbiQ=;
        b=ASwjQP9SDsp1puekx7gRISB6D3rrQpdld4sFoVx5D4mX2pOVp+62sO0J5VOVryXOgK
         QqkJ0X81tjAwwb1JAMgC5VshvKvCWX6UzcrXJfbQ+1ldJ7IYU1qIkHQhs8cdszlJQPFZ
         syiEN3LkKHX78KEioojop6J0LNOi+aBA1MQ2IpVurClGNoxhEvnycwsIQj6OZk9B6X+v
         Mzk0+2noxeJ0mYAlnHHsU+eY6+DcdPU9NxyE6agbilLGcM7FOa3Dc/t0ttfFhln002oV
         BkyHM0QTX7Pj5ZUfwrI+APQ0mfoosJ4RaJCSocNEcCnDlZAoCy5MKsSPiMSO1PdMHZnC
         smNw==
X-Gm-Message-State: AOAM533TGm9G2TFNxmxvnR02Kj+nwCbJ9HNp5Tq/mV6jb9H0HZ8lXb+L
        0FUYHn7dNZdBcJQhbfLJGuvP9tRC7rv7ow==
X-Google-Smtp-Source: ABdhPJxZMq07lMJGp5+2OX5w77enKJE/3sWiiJOqi/IHYqxvOVaNZcAzajvvIGqUv1xIFMF5Jt4NfA==
X-Received: by 2002:a17:902:bd85:b029:e3:11d0:367f with SMTP id q5-20020a170902bd85b02900e311d0367fmr495813pls.12.1613087201715;
        Thu, 11 Feb 2021 15:46:41 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:41 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 13/19] remoteproc: Properly deal with the resource table
Date:   Thu, 11 Feb 2021 16:46:21 -0700
Message-Id: <20210211234627.2669674-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it is possible to detach the remote processor, keep an untouched
copy of the resource table.  That way we can start from the same
resource table without having to worry about original values or what
elements the startup code has changed when re-attaching to the remote
processor.

Reported-by: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c       | 70 ++++++++++++++++++++++
 drivers/remoteproc/remoteproc_elf_loader.c | 24 +++++++-
 include/linux/remoteproc.h                 |  3 +
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 660dcc002ff6..9a77cb6d6470 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1527,7 +1527,9 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 clean_up_resources:
 	rproc_resource_cleanup(rproc);
 	kfree(rproc->cached_table);
+	kfree(rproc->clean_table);
 	rproc->cached_table = NULL;
+	rproc->clean_table = NULL;
 	rproc->table_ptr = NULL;
 unprepare_rproc:
 	/* release HW resources if needed */
@@ -1555,6 +1557,23 @@ static int rproc_set_loaded_rsc_table(struct rproc *rproc)
 		return ret;
 	}
 
+	/*
+	 * If it is possible to detach the remote processor, keep an untouched
+	 * copy of the resource table.  That way we can start fresh again when
+	 * the remote processor is re-attached, that is:
+	 *
+	 *	DETACHED -> ATTACHED -> DETACHED -> ATTACHED
+	 *
+	 * A clean copy of the table is also taken in rproc_elf_load_rsc_table()
+	 * for cases where the remote processor is booted by the remoteproc
+	 * core and later detached from.
+	 */
+	if (rproc->ops->detach) {
+		rproc->clean_table = kmemdup(table_ptr, table_sz, GFP_KERNEL);
+		if (!rproc->clean_table)
+			return -ENOMEM;
+	}
+
 	/*
 	 * The resource table is already loaded in device memory, no need
 	 * to work with a cached table.
@@ -1566,6 +1585,40 @@ static int rproc_set_loaded_rsc_table(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_reset_loaded_rsc_table(struct rproc *rproc)
+{
+	/*
+	 * In order to detach() from a remote processor a clean resource table
+	 * _must_ have been allocated at boot time, either from rproc_fw_boot()
+	 * or from rproc_attach().  If one isn't present something went really
+	 * wrong and we must complain.
+	 */
+	if (WARN_ON(!rproc->clean_table))
+		return -EINVAL;
+
+	/*
+	 * Install the clean resource table where the firmware, i.e
+	 * rproc_get_loaded_rsc_table(), expects it.
+	 */
+	memcpy(rproc->table_ptr, rproc->clean_table, rproc->table_sz);
+
+	/*
+	 * If the remote processors was started by the core then a cached_table
+	 * is present and we must follow the same cleanup sequence as we would
+	 * for a shutdown().  As it is in rproc_stop(), use the cached resource
+	 * table for the rest of the detach process since ->table_ptr will
+	 * become invalid as soon as carveouts are released in
+	 * rproc_resource_cleanup().
+	 *
+	 * If the remote processor was started by an external entity the
+	 * cached_table is NULL and the rest of the cleanup code in
+	 * rproc_free_vring() can deal with that.
+	 */
+	rproc->table_ptr = rproc->cached_table;
+
+	return 0;
+}
+
 /*
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
@@ -1947,7 +2000,10 @@ void rproc_shutdown(struct rproc *rproc)
 
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
+	/* Free the clean resource table */
+	kfree(rproc->clean_table);
 	rproc->cached_table = NULL;
+	rproc->clean_table = NULL;
 	rproc->table_ptr = NULL;
 out:
 	mutex_unlock(&rproc->lock);
@@ -2000,6 +2056,16 @@ int rproc_detach(struct rproc *rproc)
 		goto out;
 	}
 
+	/*
+	 * Install a clean resource table for re-attach while
+	 * rproc->table_ptr is still valid.
+	 */
+	ret = rproc_reset_loaded_rsc_table(rproc);
+	if (ret) {
+		atomic_inc(&rproc->power);
+		goto out;
+	}
+
 	/* clean up all acquired resources */
 	rproc_resource_cleanup(rproc);
 
@@ -2008,10 +2074,14 @@ int rproc_detach(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	/* Free the copy of the resource table */
+	kfree(rproc->cached_table);
 	/* Follow the same sequence as in rproc_shutdown() */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
+	rproc->clean_table = NULL;
 	rproc->table_ptr = NULL;
+
 out:
 	mutex_unlock(&rproc->lock);
 	return ret;
diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index df68d87752e4..aa09782c932d 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -17,10 +17,11 @@
 
 #define pr_fmt(fmt)    "%s: " fmt, __func__
 
-#include <linux/module.h>
+#include <linux/elf.h>
 #include <linux/firmware.h>
+#include <linux/module.h>
 #include <linux/remoteproc.h>
-#include <linux/elf.h>
+#include <linux/slab.h>
 
 #include "remoteproc_internal.h"
 #include "remoteproc_elf_helpers.h"
@@ -338,6 +339,25 @@ int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw)
 	if (!rproc->cached_table)
 		return -ENOMEM;
 
+	/*
+	 * If it is possible to detach the remote processor, keep an untouched
+	 * copy of the resource table.  That way we can start fresh again when
+	 * the remote processor is re-attached, that is:
+	 *
+	 *	OFFLINE -> RUNNING -> DETACHED -> ATTACHED
+	 *
+	 * A clean copy of the table is also taken in
+	 * rproc_set_loaded_rsc_table() for cases where the remote processor is
+	 * booted by an external entity and later detached from.
+	 */
+	if (rproc->ops->detach) {
+		rproc->clean_table = kmemdup(table, tablesz, GFP_KERNEL);
+		if (!rproc->clean_table) {
+			kfree(rproc->cached_table);
+			return -ENOMEM;
+		}
+	}
+
 	rproc->table_ptr = rproc->cached_table;
 	rproc->table_sz = tablesz;
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e1c843c19cc6..e5f52a12a650 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -514,6 +514,8 @@ struct rproc_dump_segment {
  * @recovery_disabled: flag that state if recovery was disabled
  * @max_notifyid: largest allocated notify id.
  * @table_ptr: pointer to the resource table in effect
+ * @clean_table: copy of the resource table without modifications.  Used
+ *		 when a remote processor is attached or detached from the core
  * @cached_table: copy of the resource table
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
@@ -550,6 +552,7 @@ struct rproc {
 	bool recovery_disabled;
 	int max_notifyid;
 	struct resource_table *table_ptr;
+	struct resource_table *clean_table;
 	struct resource_table *cached_table;
 	size_t table_sz;
 	bool has_iommu;
-- 
2.25.1

