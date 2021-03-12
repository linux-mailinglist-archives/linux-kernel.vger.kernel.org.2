Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B439333933B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhCLQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhCLQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7DC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso8718102pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmIttTOsgDNM++s8zt1RjF9fKLTZIPRgfTRmynUwSgM=;
        b=bCHKr0/GSeFFSxm8Q4Nwz8kF8pe3oKPrzq/jVKb2PSnmVfo+sAl1PzrKRkSdZ8LMT0
         GF+I7XJa+Ui+EG+02L631CsvB+VbdRTXD1Uoxg5OMvP2oDDElK7xUZi7v43MjutF7rhz
         4TLz3TPulv8R10hGSYB4nDswd1dLCCl9+8d5TQyA6nE7N4Lm+9hL/N2AJI7w8618goxY
         5SrjZqWdA+PG0KdaZ3bM6uukXKrEewTRQMkrGFM5Ql7eBdas5UGg/gdcwFhN+ONnsHS/
         AXtilX1TdXRzHwsgaxg9kyaIAjz8kE22D9jLbk4iP1knKvwMZvjYP6g7UFp4Jb0ra+to
         GRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmIttTOsgDNM++s8zt1RjF9fKLTZIPRgfTRmynUwSgM=;
        b=ahwyaoc1G/EcNbxdjRxoH7B+OxQq6opgmr7sIc3oDXue0bTSfbRVf70orPmxdTuMqH
         La1nurZS1yRsPDtC5FyrAZ8Fp6H8lgbZ91K9XrZFd4TkbE5j3aBTBaGxxzYrC4en4XTl
         khhMTJNhJMjqM9Fq6cnl4IU4bf+Epb9dNUr60j+oGjgYRyHsY7ygjiG8eyaH02L0gfoY
         22F16dtVyQB9ELf76WuxMxO+54Q3kDRtTU4cZhjWptDHisBc40TTrB1LioBCsAjjZSvy
         xuXePVlkyoyW6s5oaDiNd3wDk23qVA9whti8rTJlOy+S8SKX5pSzh0sMM5c5efTQxsvs
         b4dQ==
X-Gm-Message-State: AOAM530NK4TN2vuvojz7e9N2XntLBffv84cjFDZnIiamMILg4iNNx1+u
        4fM1fDk2vaRapS85qQOWUu50ZQ==
X-Google-Smtp-Source: ABdhPJxXJe5hKTDd4WF93xA2jimdLPApISq00YSPw79YUIexUQRALtvGUMqeh8UWjTrWHXuHQImaJg==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr14916331pjb.217.1615566299668;
        Fri, 12 Mar 2021 08:24:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:24:59 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 04/17] remoteproc: Properly represent the attached state
Date:   Fri, 12 Mar 2021 09:24:40 -0700
Message-Id: <20210312162453.1234145-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need to know when a remote processor has been attached
to rather than booted by the remoteproc core.  In order to avoid
manipulating two variables, i.e rproc::autonomous and
rproc::state, get rid of the former and simply use the newly
introduced RPROC_ATTACHED state.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c  | 20 +-------------------
 drivers/remoteproc/remoteproc_sysfs.c |  5 +----
 include/linux/remoteproc.h            |  2 --
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7b66e1e96e4a..8c7e9f1d50d7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1444,7 +1444,7 @@ static int __rproc_attach(struct rproc *rproc)
 		goto stop_rproc;
 	}
 
-	rproc->state = RPROC_RUNNING;
+	rproc->state = RPROC_ATTACHED;
 
 	dev_info(dev, "remote processor %s is now attached\n", rproc->name);
 
@@ -1659,14 +1659,6 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 
 	rproc->state = RPROC_OFFLINE;
 
-	/*
-	 * The remote processor has been stopped and is now offline, which means
-	 * that the next time it is brought back online the remoteproc core will
-	 * be responsible to load its firmware.  As such it is no longer
-	 * autonomous.
-	 */
-	rproc->autonomous = false;
-
 	dev_info(dev, "stopped remote processor %s\n", rproc->name);
 
 	return 0;
@@ -2077,16 +2069,6 @@ int rproc_add(struct rproc *rproc)
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Remind ourselves the remote processor has been attached to rather
-	 * than booted by the remoteproc core.  This is important because the
-	 * RPROC_DETACHED state will be lost as soon as the remote processor
-	 * has been attached to.  Used in firmware_show() and reset in
-	 * rproc_stop().
-	 */
-	if (rproc->state == RPROC_DETACHED)
-		rproc->autonomous = true;
-
 	/* if rproc is marked always-on, request it to boot */
 	if (rproc->auto_boot) {
 		ret = rproc_trigger_auto_boot(rproc);
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 4b4aab0d4c4b..f9694def9b54 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -138,11 +138,8 @@ static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
 	 * If the remote processor has been started by an external
 	 * entity we have no idea of what image it is running.  As such
 	 * simply display a generic string rather then rproc->firmware.
-	 *
-	 * Here we rely on the autonomous flag because a remote processor
-	 * may have been attached to and currently in a running state.
 	 */
-	if (rproc->autonomous)
+	if (rproc->state == RPROC_ATTACHED)
 		firmware = "unknown";
 
 	return sprintf(buf, "%s\n", firmware);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b0a57ff73849..6b0a0ed30a03 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -512,7 +512,6 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
- * @autonomous: true if an external entity has booted the remote processor
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  * @char_dev: character device of the rproc
@@ -549,7 +548,6 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
-	bool autonomous;
 	struct list_head dump_segments;
 	int nb_vdev;
 	u8 elf_class;
-- 
2.25.1

