Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7318E3B4990
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFYUBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229958AbhFYUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqSN7YKNu7jB+HrLuLUg+PFT/fO3y/oLnfYjNwzT7ZY=;
        b=XIESBdUfLyeyhSFgMv4xg5HuhLrwyik/J2UroekBZ1luSXa4W1cCkbTvC0ebbT10X9rpf9
        bnD1QrYRqP4xuqPJ42uZ+E+bzXcCqPLxI27pNwM90FtQVtRI/uzN2vPHWVCc4/MSfOmn4G
        el29UVSNXRhlT3ZEqipBhoB7/ITCIRw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-q7zRhSa_OSyc9dRaO3JywA-1; Fri, 25 Jun 2021 15:59:08 -0400
X-MC-Unique: q7zRhSa_OSyc9dRaO3JywA-1
Received: by mail-oi1-f199.google.com with SMTP id k11-20020a54440b0000b02901f3e6a011b4so6490596oiw.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqSN7YKNu7jB+HrLuLUg+PFT/fO3y/oLnfYjNwzT7ZY=;
        b=EVP1t9jSWEYHJ5Va2c69sdpAqfXvn6RBOAJ09kT8oupXAxlQbJTTdlVxD8sUtU9B+t
         97/pmX3U8wlWMqJjGZaKLbY940JXUz3XiWxFB4ETuOILlVQ4dS6CAuyy/3XFYbJ7rDai
         zIfvLGBdMBSLC7Iy3mETFZe6gT0ajE4npZdSozog1j3g8WKo6bT2EjMuMcFgHjEo11bS
         yhVJ6quJ9CzeuWQFLG/rN80xLkjgVUw5rWSl/QhgFU27yUEc2LGwPPRtQzs4+VGc9Y33
         4FfOs3GkNoKa79Jjh7Fr+WMFYBVJtP0FClmA5hThsEm9RBSKnrsMtxMSILqUj/v1cXpk
         pJ9g==
X-Gm-Message-State: AOAM533EV3sO0HFBASWUUjjTeM1OB4+k+6SwzRUpQMmGIq/Ll32vwolo
        EVFN3DYirupM58X+Eo4uFnS3TNECVqkQEVCi9rnMhI0DCtzvBK0rqNloIzA64IHZwPHo3LdKZVi
        dFS1gOqTwPgVhg6O6URXDgHIK
X-Received: by 2002:a9d:7748:: with SMTP id t8mr10592302otl.110.1624651147438;
        Fri, 25 Jun 2021 12:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu34MbJmcblH8cUFKOa/B1UaUgiD0OGN1o/K/VsRr/ozopnaksdv0CoB7hGyKwnTfZVZXWwg==
X-Received: by 2002:a9d:7748:: with SMTP id t8mr10592285otl.110.1624651147242;
        Fri, 25 Jun 2021 12:59:07 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:59:06 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 3/4] fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
Date:   Fri, 25 Jun 2021 12:58:48 -0700
Message-Id: <20210625195849.837976-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195849.837976-1-trix@redhat.com>
References: <20210625195849.837976-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Refactor fpga_manager_write* functions for reimaging, pass
the update_ops as a parameter.  Continue the passing of the update_ops
to the write wrapper functions.  Only do the reconfig ops.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 90 ++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 31c51d7e07cc8..c8a6bfa037933 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -45,10 +45,12 @@ static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
 	return 0;
 }
 
-static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+static inline int fpga_mgr_write(struct fpga_manager *mgr,
+				 const char *buf, size_t count,
+				 const struct fpga_manager_update_ops *uops)
 {
 	if (mgr->mops->reconfig.write)
-		return  mgr->mops->reconfig.write(mgr, buf, count);
+		return  uops->write(mgr, buf, count);
 	return -EOPNOTSUPP;
 }
 
@@ -57,13 +59,14 @@ static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size
  * finish and set the FPGA into operating mode.
  */
 static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
+					  struct fpga_image_info *info,
+					  const struct fpga_manager_update_ops *uops)
 {
 	int ret = 0;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	if (mgr->mops->reconfig.write_complete)
-		ret = mgr->mops->reconfig.write_complete(mgr, info);
+	if (uops->write_complete)
+		ret = uops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -76,18 +79,20 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
 
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
-				      const char *buf, size_t count)
+				      const char *buf, size_t count,
+				      const struct fpga_manager_update_ops *uops)
 {
-	if (mgr->mops->reconfig.write_init)
-		return  mgr->mops->reconfig.write_init(mgr, info, buf, count);
+	if (uops->write_init)
+		return  uops->write_init(mgr, info, buf, count);
 	return 0;
 }
 
 static inline int fpga_mgr_write_sg(struct fpga_manager *mgr,
-				    struct sg_table *sgt)
+				    struct sg_table *sgt,
+				    const struct fpga_manager_update_ops *uops)
 {
-	if (mgr->mops->reconfig.write_sg)
-		return  mgr->mops->reconfig.write_sg(mgr, sgt);
+	if (uops->write_sg)
+		return  uops->write_sg(mgr, sgt);
 	return -EOPNOTSUPP;
 }
 
@@ -143,16 +148,17 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
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
@@ -165,7 +171,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
-				  struct sg_table *sgt)
+				  struct sg_table *sgt,
+				  const struct fpga_manager_update_ops *uops)
 {
 	struct sg_mapping_iter miter;
 	size_t len;
@@ -173,7 +180,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	int ret;
 
 	if (!mgr->mops->initial_header_size)
-		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
+		return fpga_mgr_write_init_buf(mgr, info, NULL, 0, uops);
 
 	/*
 	 * First try to use miter to map the first fragment to access the
@@ -183,7 +190,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	if (sg_miter_next(&miter) &&
 	    miter.length >= mgr->mops->initial_header_size) {
 		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
-					      miter.length);
+					      miter.length, uops);
 		sg_miter_stop(&miter);
 		return ret;
 	}
@@ -196,7 +203,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 
 	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
 				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+	ret = fpga_mgr_write_init_buf(mgr, info, buf, len, uops);
 
 	kfree(buf);
 
@@ -208,6 +215,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  * @mgr:	fpga manager
  * @info:	fpga image specific information
  * @sgt:	scatterlist table
+ * @uops:       which update ops to use
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
@@ -222,24 +230,25 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
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
-		ret = fpga_mgr_write_sg(mgr, sgt);
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
@@ -252,16 +261,17 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
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
 
@@ -269,14 +279,14 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
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
@@ -285,6 +295,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  * @info:	fpga image info
  * @buf:	buffer contain fpga image
  * @count:	byte count of buf
+ * @uops:       which update ops to use
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
@@ -295,7 +306,8 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 			     struct fpga_image_info *info,
-			     const char *buf, size_t count)
+			     const char *buf, size_t count,
+			     const struct fpga_manager_update_ops *uops)
 {
 	struct page **pages;
 	struct sg_table sgt;
@@ -309,8 +321,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->reconfig.write)
-		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
+	if (uops && uops->write)
+		return fpga_mgr_buf_load_mapped(mgr, info, buf, count, uops);
 
 	/*
 	 * Convert the linear kernel pointer into a sg_table of pages for use
@@ -345,7 +357,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	if (rc)
 		return rc;
 
-	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt);
+	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt, uops);
 	sg_free_table(&sgt);
 
 	return rc;
@@ -356,6 +368,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  * @mgr:	fpga manager
  * @info:	fpga image specific information
  * @image_name:	name of image file on the firmware search path
+ * @uops:       which update ops to use
  *
  * Request an FPGA image using the firmware class, then write out to the FPGA.
  * Update the state before each step to provide info on what step failed if
@@ -367,7 +380,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  */
 static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
-				  const char *image_name)
+				  const char *image_name,
+				  const struct fpga_manager_update_ops *uops)
 {
 	struct device *dev = &mgr->dev;
 	const struct firmware *fw;
@@ -384,7 +398,7 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
+	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size, uops);
 
 	release_firmware(fw);
 
@@ -403,12 +417,14 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
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

