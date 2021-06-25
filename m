Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1BB3B4964
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFYTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhFYTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3Hx4g23iCqTdbLSgslXxph/KRyl4q03Nb7dWJc/obU=;
        b=ELRfB259XO20XuC63mwMwq3iRqDfkCtSS/jm9hrQbOa/57s0Y6aoFlpOgRQGbOGtKZ17w4
        82z2onROG3yzlnDd+rx0WGp77xdOqDi9rwnSy0w/Lu+VNGiVM6KGKhBMqvOo+71gYZu2Hm
        +rzTKXcth5i55jrbl4iVndQJFG91m04=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-7JyynSLFNemQ6tYBNGJuNA-1; Fri, 25 Jun 2021 15:52:10 -0400
X-MC-Unique: 7JyynSLFNemQ6tYBNGJuNA-1
Received: by mail-oi1-f200.google.com with SMTP id r3-20020aca44030000b02902241b7398a8so6511036oia.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3Hx4g23iCqTdbLSgslXxph/KRyl4q03Nb7dWJc/obU=;
        b=FEO/xvvoum7KgG2XIfIE/j8pSGItOu54cUTWYkPXS6LxMkTR3LPN6jgJHGHdLE/ZvW
         wP4qb0GOxLgGC/YvJqLpjndcKjEoPxpfQGeGDaCpIV7C866MVKHFXSy7ur1y7Lrl2AeM
         Dt0vjpfZQ+CGMvzW7FnJvhNMnpNQzcTW1V1k6jZv83Xf2jAwuqXUcMTdaHbn1qPLYZX/
         L0E9R/W9EMZ1PbFuCIyi1G+uxFnosmBSEZgpIokVtJubhrpBsYN4kF+OLlKq5h3Q9dT3
         xfyxfQa8wrczt4P0W6pWcdPYmoIcFrhpXdxp3CgHt0IE03i7oWBSVCJFq7CZBQpB60Ak
         B/iw==
X-Gm-Message-State: AOAM531mGPbQMHruRp/DBCxzYSYf8BhKrC4C/btRTHcSxJK1D098aYTG
        ouTQLJo0eMWmDCNJtWHX62GxvpHIcOmXrOsq0TQF+x/zZ/WjLPu2Y9beYy5S6hdrXXonSXxW+hR
        3W4iLxlwQKjS/2d6wNRhml0wH
X-Received: by 2002:aca:360b:: with SMTP id d11mr9778917oia.108.1624650728369;
        Fri, 25 Jun 2021 12:52:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRkUHu9PZy3otLlcnM8UdeRlQ9ClzhhP/XcfbGlosU7eNjGFuxzVDIFpY6HanOFEkjF94u2A==
X-Received: by 2002:aca:360b:: with SMTP id d11mr9778907oia.108.1624650728233;
        Fri, 25 Jun 2021 12:52:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:07 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 2/7] fpga-mgr: make write_complete() op optional
Date:   Fri, 25 Jun 2021 12:51:43 -0700
Message-Id: <20210625195148.837230-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
write_complete function if there is nothing.  Move
the op check to the existing wrapper.
Default to success.
Remove noop function.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c    | 45 +++++++++++++++++++-------------------
 drivers/fpga/zynqmp-fpga.c |  7 ------
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c047de8a059b7..05a69ab3ecb9e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,28 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+/*
+ * After all the FPGA image has been written, do the device specific steps to
+ * finish and set the FPGA into operating mode.
+ */
+static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	int ret = 0;
+
+	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
+	if (mgr->mops->write_complete)
+		ret = mgr->mops->write_complete(mgr, info);
+	if (ret) {
+		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
+		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return ret;
+	}
+	mgr->state = FPGA_MGR_STATE_OPERATING;
+
+	return 0;
+}
+
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
 				      const char *buf, size_t count)
@@ -146,27 +168,6 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	return ret;
 }
 
-/*
- * After all the FPGA image has been written, do the device specific steps to
- * finish and set the FPGA into operating mode.
- */
-static int fpga_mgr_write_complete(struct fpga_manager *mgr,
-				   struct fpga_image_info *info)
-{
-	int ret;
-
-	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->write_complete(mgr, info);
-	if (ret) {
-		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
-		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
-		return ret;
-	}
-	mgr->state = FPGA_MGR_STATE_OPERATING;
-
-	return 0;
-}
-
 /**
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
@@ -577,7 +578,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
+	if (!mops || !mops->state ||
 	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797ff..9efbd70aa6864 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -66,12 +66,6 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	return ret;
 }
 
-static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
-{
-	return 0;
-}
-
 static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 {
 	u32 status = 0;
@@ -87,7 +81,6 @@ static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
-	.write_complete = zynqmp_fpga_ops_write_complete,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
-- 
2.26.3

