Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B501838B608
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhETSbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbhETSbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/bPnMh8D9HEJogKStb+MSo8WLoMkx+68yj+/mcrE5vw=;
        b=FBng8sGD6zeTCB8INLUepn5UuA2px6CK8RBAtEefppMMeMuNT0F3Nb+VPgzjWAmN5b6lyI
        78DoA5dAxR+tugu3t+cMVe/cWqpcp8np12OQqOdhVmD5XSBmK8ARlFhtBH4brQA1pqblnC
        yypIppoKugnOSODYNVJSqQ7KqhpzdJc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-4eotWF3nNhuI1wpweE7hBg-1; Thu, 20 May 2021 14:30:27 -0400
X-MC-Unique: 4eotWF3nNhuI1wpweE7hBg-1
Received: by mail-qt1-f200.google.com with SMTP id 1-20020aed31010000b029019d1c685840so13017331qtg.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bPnMh8D9HEJogKStb+MSo8WLoMkx+68yj+/mcrE5vw=;
        b=NGm1e5k1GNklAUsmRqwDX9VqDbftFeV/DQ+v0G5xgpF7N5bPxRRXkTNQLfbwW03fiv
         pGdiDembsOP8YyE9uBUn1L1TW6t+e1yto7t3pKMwBx83EXPJRgn4uwk3mm1Rq4BgdpMf
         FYv/CyyBWwbZ6+gOWB0MrP/Tc0f2JLR0eve49a1HCKmUsaLEIUVHDmlEsdsmZtPnr1qG
         UV7kB6lKvMPiV29TNQ3NiB+EgNsADWBuq7dDSobniDcwHKP8I4A9ddDe00bC0lqAT8sq
         Vl4sl+XMbKaDsxttG0cIXX1s6uUdkVHwlV6PnEE2DCdEb+6Ucyb/m6q9o4AZh3hiL+aJ
         IFzw==
X-Gm-Message-State: AOAM533AI+0pWTWHFB6NnmIfCrl9YwxXs3+1yopIJxqiQORzMVQkXlJ6
        ll9KtaMBwBda4795y86MihbovQV0EsUAxvPgE+AyknjuopBW6bU66G97M0blXUpdytMc9BfkP/k
        LZLHtCEjy+KbCzUWA1ww1arTx
X-Received: by 2002:ad4:420b:: with SMTP id k11mr7416627qvp.18.1621535426950;
        Thu, 20 May 2021 11:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfidu4zN2uet8HOwwObbCGcgkQBZyXWsGSIncju4TJAnj0jTlP5hQB9h0cdJsfDlnQx5Otkw==
X-Received: by 2002:ad4:420b:: with SMTP id k11mr7416605qvp.18.1621535426777;
        Thu, 20 May 2021 11:30:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u26sm2512296qtf.24.2021.05.20.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:30:26 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 3/5] fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
Date:   Thu, 20 May 2021 11:30:22 -0700
Message-Id: <20210520183022.2022394-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Refactor fpga_manager_write* functions for reimaging, pass
the update_ops as a parameter.  Only do the reconfig ops.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index e3fc1b0bd7181..4263c9e94949d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -77,16 +77,17 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
+				   const struct fpga_manager_update_ops *uops,
 				   const char *buf, size_t count)
 {
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->reconfig.write_init(mgr, info, NULL, 0);
+		ret = uops->write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->reconfig.write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		ret = uops->write_init(
+			mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
@@ -99,6 +100,7 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
+				  const struct fpga_manager_update_ops *uops,
 				  struct sg_table *sgt)
 {
 	struct sg_mapping_iter miter;
@@ -107,7 +109,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	int ret;
 
 	if (!mgr->mops->initial_header_size)
-		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
+		return fpga_mgr_write_init_buf(mgr, info, uops, NULL, 0);
 
 	/*
 	 * First try to use miter to map the first fragment to access the
@@ -116,7 +118,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 	if (sg_miter_next(&miter) &&
 	    miter.length >= mgr->mops->initial_header_size) {
-		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
+		ret = fpga_mgr_write_init_buf(mgr, info, uops, miter.addr,
 					      miter.length);
 		sg_miter_stop(&miter);
 		return ret;
@@ -130,7 +132,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 
 	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
 				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+	ret = fpga_mgr_write_init_buf(mgr, info, uops, buf, len);
 
 	kfree(buf);
 
@@ -142,12 +144,13 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  * finish and set the FPGA into operating mode.
  */
 static int fpga_mgr_write_complete(struct fpga_manager *mgr,
-				   struct fpga_image_info *info)
+				   struct fpga_image_info *info,
+				   const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->reconfig.write_complete(mgr, info);
+	ret = uops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -162,6 +165,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
  * @info:	fpga image specific information
+ * @uops:       which update ops to use
  * @sgt:	scatterlist table
  *
  * Step the low level fpga manager through the device-specific steps of getting
@@ -177,24 +181,25 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 				struct fpga_image_info *info,
+				const struct fpga_manager_update_ops *uops,
 				struct sg_table *sgt)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
+	ret = fpga_mgr_write_init_sg(mgr, info, uops, sgt);
 	if (ret)
 		return ret;
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	if (mgr->mops->reconfig.write_sg) {
-		ret = mgr->mops->reconfig.write_sg(mgr, sgt);
+	if (uops->write_sg) {
+		ret = uops->write_sg(mgr, sgt);
 	} else {
 		struct sg_mapping_iter miter;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->reconfig.write(mgr, miter.addr, miter.length);
+			ret = uops->write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -207,16 +212,17 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 				    struct fpga_image_info *info,
+				    const struct fpga_manager_update_ops *uops,
 				    const char *buf, size_t count)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
+	ret = fpga_mgr_write_init_buf(mgr, info, uops, buf, count);
 	if (ret)
 		return ret;
 
@@ -224,20 +230,21 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->reconfig.write(mgr, buf, count);
+	ret = uops->write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 /**
  * fpga_mgr_buf_load - load fpga from image in buffer
  * @mgr:	fpga manager
  * @info:	fpga image info
+ * @uops:       which update ops to use
  * @buf:	buffer contain fpga image
  * @count:	byte count of buf
  *
@@ -250,6 +257,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 			     struct fpga_image_info *info,
+			     const struct fpga_manager_update_ops *uops,
 			     const char *buf, size_t count)
 {
 	struct page **pages;
@@ -264,8 +272,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->reconfig.write)
-		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
+	if (uops->write)
+		return fpga_mgr_buf_load_mapped(mgr, info, uops, buf, count);
 
 	/*
 	 * Convert the linear kernel pointer into a sg_table of pages for use
@@ -300,7 +308,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	if (rc)
 		return rc;
 
-	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt);
+	rc = fpga_mgr_buf_load_sg(mgr, info, uops, &sgt);
 	sg_free_table(&sgt);
 
 	return rc;
@@ -322,6 +330,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  */
 static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
+				  const struct fpga_manager_update_ops *uops,
 				  const char *image_name)
 {
 	struct device *dev = &mgr->dev;
@@ -339,7 +348,7 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
+	ret = fpga_mgr_buf_load(mgr, info, uops, fw->data, fw->size);
 
 	release_firmware(fw);
 
@@ -358,12 +367,14 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
  */
 int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
+	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
+
 	if (info->sgt)
-		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
+		return fpga_mgr_buf_load_sg(mgr, info, uops, info->sgt);
 	if (info->buf && info->count)
-		return fpga_mgr_buf_load(mgr, info, info->buf, info->count);
+		return fpga_mgr_buf_load(mgr, info, uops, info->buf, info->count);
 	if (info->firmware_name)
-		return fpga_mgr_firmware_load(mgr, info, info->firmware_name);
+		return fpga_mgr_firmware_load(mgr, info, uops, info->firmware_name);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_load);
-- 
2.26.3

