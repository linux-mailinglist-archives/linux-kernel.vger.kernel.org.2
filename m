Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742F538F188
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhEXQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233535AbhEXQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/bPnMh8D9HEJogKStb+MSo8WLoMkx+68yj+/mcrE5vw=;
        b=Ncj89Y63eIy4J9mxBhNJGsGNbOxgL6qalHoDKKy3dDumWoigqstMelxRFDdMvI2mK57F09
        N1Dv4KgwFbQ7ByKDC/NM2FckKdd6dv1sCVPq/OkW/tTyTxdYS3713haJOC1Thwv/WRhxB5
        ZoEs5kKZTq1qVqkHx3G+u0i+mifIqeI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-RtFrhiapNdq77dkNsIzhpA-1; Mon, 24 May 2021 12:28:10 -0400
X-MC-Unique: RtFrhiapNdq77dkNsIzhpA-1
Received: by mail-ot1-f70.google.com with SMTP id h8-20020a9d6a480000b02902edb9406104so20103742otn.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bPnMh8D9HEJogKStb+MSo8WLoMkx+68yj+/mcrE5vw=;
        b=kp/fFvJJD88luI1wG55YtnDnY3QazWI28cKMppq4xJdhObO5suFFeY+OA75O/8q+Gp
         f87QhCCfLmFyX2YFvHQsx7WuzzfrS/ytTlq3fWzp/ZfRTY+qicLBGI5+pd3+iZ3OC6d9
         85gRNi1IFvQSdzG9CvJHEjKUzTe1n42NWiDMoeRIOAbgOwselYwqNlFsZGT2+NlqEn66
         IwbYqiW6kZ9zKzJfuc+0sQckrw4HGT7VzO7xlr5D+sqJVbC7QmhUKOT8RtZK3quRkRHT
         8Rrk7vUYjUPXK9C2j6z81HOuJECjhcQwaSPoDwEwkb0bv3V1T/E0wf/aUr5wfLIBT8Rl
         LcqA==
X-Gm-Message-State: AOAM532dTZoIXyL8tFjSuyaXZjM+ERqw+G9EYIV5ZgFKcid/61lEYQku
        pQY7Un5QFnbjmPQ5zIhnq7swVDfHkGVdubnjQnFsQ4G4tl7QBWnBAlEKRDuRcd8vf6ktAH4sY55
        95N9t1MiLeZCesjAyR8KOuoti
X-Received: by 2002:a54:4d8b:: with SMTP id y11mr11248016oix.26.1621873689669;
        Mon, 24 May 2021 09:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX3ed3rDvLKYSHOItIJT1bkLEuVLcaI5L5DaEegq62jGmP0UCGxQZdtyfVbl2T8BsTbjltpQ==
X-Received: by 2002:a54:4d8b:: with SMTP id y11mr11248002oix.26.1621873689445;
        Mon, 24 May 2021 09:28:09 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 73sm2676487oty.40.2021.05.24.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:28:08 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 3/6] fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
Date:   Mon, 24 May 2021 09:28:05 -0700
Message-Id: <20210524162805.2221361-1-trix@redhat.com>
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

