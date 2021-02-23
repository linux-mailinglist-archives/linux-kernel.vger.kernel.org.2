Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17B1323496
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhBXAU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhBWXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:40:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6AC061223
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r5so28748pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GF5EQHFlmp0+qmUZul6iVpKZ4h0RkwOCQenPoUGAdoc=;
        b=JXFzabmRKJ8V0T+o9nOAxWVsuMgdr+B8uaPJVlbvmPmcxc8D6urjBQYMXSW2PwklpB
         bLKPh91Z/GF+3TG31+OpZ+cASxREnq6WnPHRCUV1ycXtwqyrWBImOtrXS5ynLbt2vBsM
         HOPj48ofMMoFkxHSPjERWm8vGjs97SXvNzKBva13fVqzcrx6emz4c9e9nOxtvyKkXbDn
         UI/EXGCm5L3V/ZnYJZvvjUVSgdUy99W4qBIzXOCwMgryXYPjgb5oUt/IiRB3+74VMUMg
         SkY0NYoGrq1zLG0Y9ooK6VlJMJD4YkNiMgngT0hXE5T8g+hR9wjGZsWWCI8fFSqOAkNe
         ansg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GF5EQHFlmp0+qmUZul6iVpKZ4h0RkwOCQenPoUGAdoc=;
        b=LaThuTurXnJIwC2uy97rd3feFi2D4lLgLjngmErNesK+SFhVLLRzsv4D5PjhMjAxDp
         Ujv9PQS09JGk7EVzhCe9lW+4kn63riGLJUvUnjYAf8oAi87anNPw1sl6hnO8llj5SrUw
         0x+w+arWgZDHNbDgmmipk7/fGYsiKrc6GiiUXx3LsWV1CRB9JSi7zIK5UJ6V0W96niAb
         Ckw49CoVXsqxNSjcpV9zD/FWgXyVMJpr+AltP9l3XFLu3CsD9HnUmlXGv1gOYufklrV7
         eUlNiaAEWbA2D1aQAAew0HV17XjXqiLSXLMTlNu/5mYuP3G/S73hg32FUYrZxKWIeUs5
         X6WA==
X-Gm-Message-State: AOAM532n49DWtqsW4/gCbhagQkgltaDCFbuTbTwhn4tEi7nhXTgpzZ85
        oEkcq1jRFwkT8+B9F6EepVVulg==
X-Google-Smtp-Source: ABdhPJz42IAXFy40S62cYn6Imjzfoc1xcaOkTJIhpRstco5Pcq5ISsfYuxsdM4Ul6ZKyAulxaa/GhA==
X-Received: by 2002:a65:6205:: with SMTP id d5mr4569749pgv.40.1614123327949;
        Tue, 23 Feb 2021 15:35:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:27 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 10/16] remoteproc: Introduce function rproc_detach()
Date:   Tue, 23 Feb 2021 16:35:09 -0700
Message-Id: <20210223233515.3468677-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function rproc_detach() to enable the remoteproc
core to release the resources associated with a remote processor
without stopping its operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
New for V6:
- Checking for rproc->state has been removed.  They have been moved to
  calling functions.
- Freeing the cache table has been moved to the next patch, i.e 11/16.
---

 drivers/remoteproc/remoteproc_core.c | 58 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  1 +
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0f680b7ff8f1..fc01b29290a6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1709,7 +1709,7 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 /*
  * __rproc_detach(): Does the opposite of __rproc_attach()
  */
-static int __maybe_unused __rproc_detach(struct rproc *rproc)
+static int __rproc_detach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1948,6 +1948,62 @@ void rproc_shutdown(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+/**
+ * rproc_detach() - Detach the remote processor from the
+ * remoteproc core
+ *
+ * @rproc: the remote processor
+ *
+ * Detach a remote processor (previously attached to with rproc_attach()).
+ *
+ * In case @rproc is still being used by an additional user(s), then
+ * this function will just decrement the power refcount and exit,
+ * without disconnecting the device.
+ *
+ * Function rproc_detach() calls __rproc_detach() in order to let a remote
+ * processor know that services provided by the application processor are
+ * no longer available.  From there it should be possible to remove the
+ * platform driver and even power cycle the application processor (if the HW
+ * supports it) without needing to switch off the remote processor.
+ */
+int rproc_detach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret) {
+		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
+		return ret;
+	}
+
+	/* if the remote proc is still needed, bail out */
+	if (!atomic_dec_and_test(&rproc->power)) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = __rproc_detach(rproc);
+	if (ret) {
+		atomic_inc(&rproc->power);
+		goto out;
+	}
+
+	/* clean up all acquired resources */
+	rproc_resource_cleanup(rproc);
+
+	/* release HW resources if needed */
+	rproc_unprepare_device(rproc);
+
+	rproc_disable_iommu(rproc);
+
+	rproc->table_ptr = NULL;
+out:
+	mutex_unlock(&rproc->lock);
+	return ret;
+}
+EXPORT_SYMBOL(rproc_detach);
+
 /**
  * rproc_get_by_phandle() - find a remote processor by phandle
  * @phandle: phandle to the rproc
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index eff55ec72e80..e1c843c19cc6 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -662,6 +662,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
 
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
+int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 void rproc_coredump_using_sections(struct rproc *rproc);
-- 
2.25.1

