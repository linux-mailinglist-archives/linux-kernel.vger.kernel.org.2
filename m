Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F21334999
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhCJVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhCJVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF6C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j6so9114333plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeMR2UtisGi6ZgniJxY2/huWWVqD2xtcqc6NMb4K8/0=;
        b=EBsvFLZQ6NnKS4jNzcTvZGULi3PGsqemoQp4ljvj8URM3uXP2TsOBwZPGWo71Jy6KS
         zfGni3MATLFQwbV5ozGEQ6cXWjA1bw09Sgit2MW0zikQrB//1Tt+KqGNwKlNtzrD4Lqe
         4cx6cFQeUcindtmbc5WIn6pzzByBEKzLQalh+RPsnS0X89eya1hoBzG9hpk7UvHkPlbC
         38iZqeu7I/IZEdF8DvtRsKdG7xS5LyffumFqp+aB3kg9dYnhm3CN6Fbr9TGOqOXHuA7F
         lXTEOMs+LvGJt4YZ4UYcD4ZX5CXHSCcnjGlhN69S9WQiCgV2UrcOR5+dRUPzo+b24BvI
         MRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeMR2UtisGi6ZgniJxY2/huWWVqD2xtcqc6NMb4K8/0=;
        b=VTTLEyXaauWZw5HG+TDQ6MgNwuK5Hkok3RqolfSaE/KMz9z7HpgOkx7q8JGBElBr7r
         rmFAZMcC1ZVPVFYEH8nBFL7Deuppo3EhyCXtTGitdVxz7dQp8xy98415XH9Ce/0IsTZO
         rON6N6TOIA0btmEGwG5bq0rw4aQIm+cAtD9KT30XSdYvjau4rr/GEhktsj0/jTt2i85o
         eSak6zrmHs2QZVA8fJOk7Sv8Au5i37qsANClkUoAx0IUDKhChlXiGaxHzavlKbOhnwWH
         EUoExvF3B8pGuLoLs6g0oTP1salMrqCzoziXgFJSlzKYVEEL5PeYBEALwCKofyomROID
         u64g==
X-Gm-Message-State: AOAM530kbGcrybKOEPUp10re7t5hVjmqG20F5LC3qO4eP+tT1HiEBj3B
        wXPHSW1JI2LIeqYebYlrbVkaSQ==
X-Google-Smtp-Source: ABdhPJzq/rmanro2vntRy8ql8AqTUxkiU4CGYqHtOeENyBNAEbD34Tm2CqKNwh4+K3Qb1c1I4E9CaA==
X-Received: by 2002:a17:90b:1202:: with SMTP id gl2mr5386326pjb.121.1615410641867;
        Wed, 10 Mar 2021 13:10:41 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:41 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 10/17] remoteproc: Introduce function rproc_detach()
Date:   Wed, 10 Mar 2021 14:10:18 -0700
Message-Id: <20210310211025.1084636-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function rproc_detach() to enable the remoteproc
core to release the resources associated with a remote processor
without stopping its operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 58 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  1 +
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f2a005eadfd5..5eaa47c3ba92 100644
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

