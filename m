Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711C53B387A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhFXVU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232691AbhFXVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624569477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dvny/Z8JO1gF6YOzXRWiGKmJY7imlNZkUp/yYJtEF1w=;
        b=BAxadA1F2y3ExErYQJ1QD5DPg17hQB/qmkOl52gtkLGaZAKkyiRb0ihnPbvnYJiAaWeFv9
        c4vojHAF9p21UgVzppM7CxnZARDzs/psZcQE9j+lIh9KGlaUdbbJ2gvlMfj+dohtH49czr
        kH5JZ+FQri1Lcu6LHyCBZ/Mxv/EGfQs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-OelbLd8fN1qhST9mVbr0MA-1; Thu, 24 Jun 2021 17:17:56 -0400
X-MC-Unique: OelbLd8fN1qhST9mVbr0MA-1
Received: by mail-ot1-f70.google.com with SMTP id v29-20020a056830091db029045efea1ec9bso4268498ott.21
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 14:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvny/Z8JO1gF6YOzXRWiGKmJY7imlNZkUp/yYJtEF1w=;
        b=S8hRa9c5kVZi4gr/dlt+NSyytn7Na9yA1vjFYvSwp4BTnAOkPgXelygHjeAEkYE+hR
         b4indAex7CDcBgbpPwD5Q0J0Scvl/mH+26U3bOIbyoIrVNjCissApvU7NdQ0zVhxaiZS
         k83bTGpmoKTjQ1iRm5eSry6eAJx5LFd1H8Ou52132bruZ3UT2F+wQYh2tjNlQKAHJn+B
         SEe5S/Ht7U2U8Wz7258cVOghvhjWAwLb1UThuZNBQbGaj1/t6E1mzhEYD2Wt6yYuUduC
         lqxL5GhFxKBQn1/PtHHG+qnrHfkx8bkh/zj6TG65fS7Zlkla3BajED+609RL8/XtuJFU
         qC4Q==
X-Gm-Message-State: AOAM533XgLNsAL/jsxqKdaN7kfcpckcC4YfGLbtZy5+nq91XLzl4CBp/
        K5BSQHjPPkSaptfIcWCmI/o+m+dZe1cy4DI6K/KAIOX/d46WcA8n58hK/bq1OPvIYBFzIRcIG8O
        ccrWGI/LT+/DzpIWD+hK3fqYM
X-Received: by 2002:a05:6830:1598:: with SMTP id i24mr6482134otr.52.1624569475275;
        Thu, 24 Jun 2021 14:17:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIAj1zRYvZi/2zh/ImgA6QnOGx0FLivp52DXK6MEzD+rDyJnMSz3qaflcHdOfoIDyNuEYFJA==
X-Received: by 2002:a05:6830:1598:: with SMTP id i24mr6482115otr.52.1624569475077;
        Thu, 24 Jun 2021 14:17:55 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm915513otj.33.2021.06.24.14.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:17:54 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 3/5] fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
Date:   Thu, 24 Jun 2021 14:17:25 -0700
Message-Id: <20210624211727.501019-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210624211727.501019-1-trix@redhat.com>
References: <20210624211727.501019-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Refactor fpga_manager_write* functions for reimaging, pass
the update_ops as a parameter.  Continue the passing of the update_ops
to the write wrapper functions.  Only do the reconfig ops.

Add a wrapper for write_sg, so the update ops are handled consistently.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 94 ++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9d17779cac7e3..a785b7dc5dba0 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -42,17 +42,29 @@ static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
 
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
-				      const char *buf, size_t count)
+				      const char *buf, size_t count,
+				      const struct fpga_manager_update_ops *uops)
 {
-	if (mgr->mops && mgr->mops->reconfig.write_init)
-		return  mgr->mops->reconfig.write_init(mgr, info, buf, count);
+	if (uops && uops->write_init)
+		return  uops->write_init(mgr, info, buf, count);
 	return 0;
 }
 
-static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+static inline int fpga_mgr_write(struct fpga_manager *mgr,
+				 const char *buf, size_t count,
+				 const struct fpga_manager_update_ops *uops)
 {
-	if (mgr->mops && mgr->mops->reconfig.write)
-		return  mgr->mops->reconfig.write(mgr, buf, count);
+	if (uops && uops->write)
+		return  uops->write(mgr, buf, count);
+	return -EOPNOTSUPP;
+}
+
+static inline int fpga_mgr_write_sg(struct fpga_manager *mgr,
+				    struct sg_table *sgt,
+				    const struct fpga_manager_update_ops *uops)
+{
+	if (uops && uops->write_sg)
+		return  uops->write_sg(mgr, sgt);
 	return -EOPNOTSUPP;
 }
 
@@ -61,13 +73,14 @@ static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size
  * finish and set the FPGA into operating mode.
  */
 static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
+					  struct fpga_image_info *info,
+					  const struct fpga_manager_update_ops *uops)
 {
 	int ret = 0;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	if (mgr->mops && mgr->mops->reconfig.write_complete)
-		ret = mgr->mops->reconfig.write_complete(mgr, info);
+	if (uops && uops->write_complete)
+		ret = uops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -136,16 +149,17 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
-				   const char *buf, size_t count)
+				   const char *buf, size_t count,
+				   const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0, uops);
 	else
 		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		    mgr, info, buf, min(mgr->mops->initial_header_size, count), uops);
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
@@ -158,7 +172,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
-				  struct sg_table *sgt)
+				  struct sg_table *sgt,
+				  const struct fpga_manager_update_ops *uops)
 {
 	struct sg_mapping_iter miter;
 	size_t len;
@@ -166,7 +181,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	int ret;
 
 	if (!mgr->mops->initial_header_size)
-		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
+		return fpga_mgr_write_init_buf(mgr, info, NULL, 0, uops);
 
 	/*
 	 * First try to use miter to map the first fragment to access the
@@ -176,7 +191,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	if (sg_miter_next(&miter) &&
 	    miter.length >= mgr->mops->initial_header_size) {
 		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
-					      miter.length);
+					      miter.length, uops);
 		sg_miter_stop(&miter);
 		return ret;
 	}
@@ -189,7 +204,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 
 	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
 				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+	ret = fpga_mgr_write_init_buf(mgr, info, buf, len, uops);
 
 	kfree(buf);
 
@@ -201,6 +216,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  * @mgr:	fpga manager
  * @info:	fpga image specific information
  * @sgt:	scatterlist table
+ * @uops:       which update ops to use
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
@@ -215,24 +231,25 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 				struct fpga_image_info *info,
-				struct sg_table *sgt)
+				struct sg_table *sgt,
+				const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
+	ret = fpga_mgr_write_init_sg(mgr, info, sgt, uops);
 	if (ret)
 		return ret;
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	if (mgr->mops->reconfig.write_sg) {
-		ret = mgr->mops->reconfig.write_sg(mgr, sgt);
+	if (uops->write_sg) {
+		ret = fpga_mgr_write_sg(mgr, sgt, uops);
 	} else {
 		struct sg_mapping_iter miter;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
+			ret = fpga_mgr_write(mgr, miter.addr, miter.length, uops);
 			if (ret)
 				break;
 		}
@@ -245,16 +262,17 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 				    struct fpga_image_info *info,
-				    const char *buf, size_t count)
+				    const char *buf, size_t count,
+				    const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
+	ret = fpga_mgr_write_init_buf(mgr, info, buf, count, uops);
 	if (ret)
 		return ret;
 
@@ -262,14 +280,14 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = fpga_mgr_write(mgr, buf, count);
+	ret = fpga_mgr_write(mgr, buf, count, uops);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 /**
@@ -278,6 +296,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  * @info:	fpga image info
  * @buf:	buffer contain fpga image
  * @count:	byte count of buf
+ * @uops:       which update ops to use
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
@@ -288,7 +307,8 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 			     struct fpga_image_info *info,
-			     const char *buf, size_t count)
+			     const char *buf, size_t count,
+			     const struct fpga_manager_update_ops *uops)
 {
 	struct page **pages;
 	struct sg_table sgt;
@@ -302,8 +322,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->reconfig.write)
-		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
+	if (uops && uops->write)
+		return fpga_mgr_buf_load_mapped(mgr, info, buf, count, uops);
 
 	/*
 	 * Convert the linear kernel pointer into a sg_table of pages for use
@@ -338,7 +358,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	if (rc)
 		return rc;
 
-	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt);
+	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt, uops);
 	sg_free_table(&sgt);
 
 	return rc;
@@ -349,6 +369,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  * @mgr:	fpga manager
  * @info:	fpga image specific information
  * @image_name:	name of image file on the firmware search path
+ * @uops:       which update ops to use
  *
  * Request an FPGA image using the firmware class, then write out to the FPGA.
  * Update the state before each step to provide info on what step failed if
@@ -360,7 +381,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  */
 static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
-				  const char *image_name)
+				  const char *image_name,
+				  const struct fpga_manager_update_ops *uops)
 {
 	struct device *dev = &mgr->dev;
 	const struct firmware *fw;
@@ -377,7 +399,7 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
+	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size, uops);
 
 	release_firmware(fw);
 
@@ -396,12 +418,14 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
  */
 int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
+	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
+
 	if (info->sgt)
-		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
+		return fpga_mgr_buf_load_sg(mgr, info, info->sgt, uops);
 	if (info->buf && info->count)
-		return fpga_mgr_buf_load(mgr, info, info->buf, info->count);
+		return fpga_mgr_buf_load(mgr, info, info->buf, info->count, uops);
 	if (info->firmware_name)
-		return fpga_mgr_firmware_load(mgr, info, info->firmware_name);
+		return fpga_mgr_firmware_load(mgr, info, info->firmware_name, uops);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_load);
-- 
2.26.3

