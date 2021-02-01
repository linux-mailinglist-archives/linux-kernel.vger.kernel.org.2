Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7430AEDD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBASPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhBASOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:41 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E0CC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x9so4559268plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkMHICiY0sjvBDYwRE3nRQtY0zoUuO0WMFpN8g7r2A8=;
        b=vlqpMcOccLHMKfyFmm0VBfziORVRLmt8yzV7ICOPBJoFkdzNIO89ZyGaqR6J8hhNNO
         7ZlPjJYgqQ5Xvxzcqsep6TF2M15aBK7XgBiu3Zj5wTtj29UpvPf4Iw65f4NgrOSbiUAa
         +2z+x9Uj+mEvqFDjGraGjhnlPUpfpMLFtaMrbzhUENbXpYlloBTlZEEucKDwvBKCCDwm
         CbYprpqJVEe6Xu+tfGi9O0gln6Glwsi6U3N5VVWQGUzGLYagUh7fingrvtPAYzft+w9K
         yhki4VKGcLBRGm/WNKttqksUzJkJHhFE0FCiq2kqRiS9YRbR6vWQJGHQ0OvvLN+qHP38
         8xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkMHICiY0sjvBDYwRE3nRQtY0zoUuO0WMFpN8g7r2A8=;
        b=TJyDnBDoDnoyX6xyMo1pR9ku2ZIR7cPH3ElMx21XbLISngyWjkKrrkmneOMz1V/XrY
         Dahz0l49qQjBCJsDA8FgNYIMokM1ggAE205fZ0nuGKmMdnKbIxDmINWoQEaQnlp9Ewys
         34FXbfDNO2BjzNccSWG2Mmp5WaQ9XfTtB2FPTtGyrj75pOSfgD0OfeNx93XVSHsh4Q8P
         A4fhpQWQzncv8eHpeznnwbgQ+4xOYszU/TB3eV7vW+yJytRTrdRXzpnMtw5JOg7DJTAo
         wP6W5iDB1PH078q8lpVXNhtKXoHuZVOw/Phiu6B7pX+6uvSCjUC22+Hcf3zxe1j3ARUc
         ZxlA==
X-Gm-Message-State: AOAM532ONSf+J2Flh+lMYSrkHYVnwJ6MhSgs5KOsUTKEVFOv9ZRKwL9g
        Bq1YW3NqZMuFcfJFSzQg9dXcag==
X-Google-Smtp-Source: ABdhPJyztrTnQycZMCgCHBeSSeVduujWZcTuRldzwD/RBoN4blZFdcuzJgo7+pc9q0RlJZ9/uuBZ2Q==
X-Received: by 2002:a17:902:6b45:b029:e0:7a3:a8c with SMTP id g5-20020a1709026b45b02900e007a30a8cmr19048550plt.1.1612203239599;
        Mon, 01 Feb 2021 10:13:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:13:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/31] coresight: tpiu: Prepare for using coresight device access abstraction
Date:   Mon,  1 Feb 2021 11:13:26 -0700
Message-Id: <20210201181351.1475223-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Prepare the TPIU driver to make use of the CoreSight device access
abstraction layer. The driver touches the device even before the
coresight device is registered. Thus we could be accessing the
devices without a csdev. As we are about to use the abstraction
layer for accessing the device, pass in the access directly
to avoid having to deal with the un-initialised csdev.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-5-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 30 +++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 6ca396799883..a12b6ee0a576 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -60,49 +60,45 @@ struct tpiu_drvdata {
 	struct coresight_device	*csdev;
 };
 
-static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
+static void tpiu_enable_hw(struct csdev_access *csa)
 {
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(csa->base);
 
 	/* TODO: fill this up */
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(csa->base);
 }
 
 static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	tpiu_enable_hw(drvdata);
+	tpiu_enable_hw(&csdev->access);
 	atomic_inc(csdev->refcnt);
 	dev_dbg(&csdev->dev, "TPIU enabled\n");
 	return 0;
 }
 
-static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
+static void tpiu_disable_hw(struct csdev_access *csa)
 {
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(csa->base);
 
 	/* Clear formatter and stop on flush */
-	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
+	csdev_access_relaxed_write32(csa, FFCR_STOP_FI, TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
+	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
+	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(csa->base);
 }
 
 static int tpiu_disable(struct coresight_device *csdev)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
 	if (atomic_dec_return(csdev->refcnt))
 		return -EBUSY;
 
-	tpiu_disable_hw(drvdata);
+	tpiu_disable_hw(&csdev->access);
 
 	dev_dbg(&csdev->dev, "TPIU disabled\n");
 	return 0;
@@ -152,7 +148,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	/* Disable tpiu to support older devices */
-	tpiu_disable_hw(drvdata);
+	tpiu_disable_hw(&desc.access);
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
-- 
2.25.1

