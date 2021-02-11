Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77294319734
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhBKXx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBKXue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:50:34 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD38C0698CF
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:47:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o63so5062605pgo.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LiQ+DrqaiKdtyOZ0qd9/kmr3OB05MnkkmAeFHXfjc4=;
        b=SSYN+WgnLbG2ER/GI4pl0JRTRnaR3bgiGuZH/zBXNJZUmCGM0XYF8bs9ogCJw+gBVx
         zbB61u8+Cx51rvtIkimeNIFskk843o6zkUeplK2mfz34bO/1ixUfEHUwXl45K8bXMRqZ
         PiI34g01DanreaBh1mVooQr1Lpny4gggo0Ecs3FnrYgdmSL/ItczbJy6TG1e8Vgvxw0T
         rrjx1CYGbvcHO7WdTREskkiCOB8ou3LOZSK2NggZV+LFMfPrQt8GBf31ZTih+xC3h0aZ
         JCBRUV5kUczsw4Ca0W+M8C5KkNx8ZljR2rhjpbx4WQgVNq21v//Hc4GIhAYMAmYfXSEq
         65tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LiQ+DrqaiKdtyOZ0qd9/kmr3OB05MnkkmAeFHXfjc4=;
        b=HRFEBDfoCqanSwNhZlXTSel+TJTTag+FE2CgmWpty7LJmWETtTKdYWLJXP9zFRsDT9
         josDtxOStm5fczUinbU4J6xnMA9zgBWaNfvqYMU9W7lZL2zyB3eGRqwtTFkZ4NzD3yTG
         x3tF5mMjaiiaJWlfUWaj8WA71ur4Oi7Pa3jfAT2+qP4DMRrewb/Rc/XCCVUPusRz124v
         3MtYYG+i0DMswix4KubZggWe4j0HDknevfrkR2GGNzsu3ol9HUS51icQWnVcIGUwhcRs
         rFaas2UbflbG9p3DbSY/vKM+p/1PAR5p48yya3ZVJBonMGf0iTz75nnugaLMePk5vKw1
         LxhQ==
X-Gm-Message-State: AOAM530vANGOqzt3TnYdeYC71O4wqoLYGv17dDL2XpIHLhKAa/W0Is3m
        90PfxevmoGXTiq6bq9Igh9adQw==
X-Google-Smtp-Source: ABdhPJyjXlkWrcQ879uD8sZoWfnGcEA3Ql2AIHLSgPaLjGbXkhdSqoEbHCfLuVeDZSr12jD6n74l4Q==
X-Received: by 2002:a63:343:: with SMTP id 64mr556316pgd.232.1613087207742;
        Thu, 11 Feb 2021 15:46:47 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:46 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 18/19] remoteproc: Properly deal with detach request
Date:   Thu, 11 Feb 2021 16:46:26 -0700
Message-Id: <20210211234627.2669674-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached to or booted by the remoteproc core.  For
that to happen a rproc::ops::detach() operation need to be
available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 6 ++++++
 drivers/remoteproc/remoteproc_sysfs.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 61541bc7d26c..f7645f289563 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -43,6 +43,12 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (!strncmp(cmd, "detach", len)) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 7d281cfe3e03..5a239df5877e 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -207,6 +207,12 @@ static ssize_t state_store(struct device *dev,
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (sysfs_streq(buf, "detach")) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

