Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B633B2049
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFWS1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhFWS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvDjxT4JNnOa6YI54+xpsPvfGpnD/xGsyt4kT9ZCqb0=;
        b=KRSkVxUIHgwHlmdRKk1Ie02xDaBR3OFL3KenJ/MUb05JagzF60JegqRjfd7K7rBvjqg2b7
        cfOeG9JmqL9PH/rkQ/rz61m9Jgw3v5GbhyY+u86Etd3hUTaKSBqWLWoFIXfmmEmrAnL4fT
        4LHv1MHdI1LB0KSUVu2iwGoPZ2Qj/n4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-ED8mRUTCM0uSJpZdW_JQ-A-1; Wed, 23 Jun 2021 14:24:43 -0400
X-MC-Unique: ED8mRUTCM0uSJpZdW_JQ-A-1
Received: by mail-oi1-f200.google.com with SMTP id l123-20020acad4810000b02901f1fb44dca7so2227003oig.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvDjxT4JNnOa6YI54+xpsPvfGpnD/xGsyt4kT9ZCqb0=;
        b=XOGPsuo4iVEfG/eFviDkSliolTd0wmO7+PJsSyEySM3PAXZFRua/AIs51CoNOUWVV7
         KfCjlccAcwxsmh/Q2NQ+DKFhWymNnXEQP/vNpB+qnhW1eE3BVWfuprdKs/QLeDQk8Yik
         X6Eiq+Hnef953BPl3B+gBgTSsnx2miHI2Oh0jQwSoH+v/HWIazja6F0FVWPOZrGRCQNJ
         2DI9RTNxV+VwLerapPkt6aqcHIRysxn6lPJ/LvIzuqu4mFYvWqApOXDS8qNaPzOEjSMs
         Kdn92r+NhLt8mW4vwaxhdQ/wEwyXvIY5/5r4LcXSaA4VyMfeFJVxlBq98GUh3mEMXuQs
         wd1w==
X-Gm-Message-State: AOAM531taD8dC86a5p1hK/8w/3A2X1YfY9ExO+tMB4EemqzZ6Yif4j5R
        BL8zNtQYTwi+1LJK4+Nc05pswvSEgk7VIruRI4A/K9mhgj5ZmRRYsGt020MYegVDfGngjx42pgH
        6bNzeOk/jM7pmADETvhPede94
X-Received: by 2002:a05:6830:1658:: with SMTP id h24mr1117198otr.149.1624472682140;
        Wed, 23 Jun 2021 11:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGxW/gR8wVzOIBVQ5Zi3UaRp0R838f9fy7n6jF4t2ZrwynunQMj2JjoRpRgrK/gAnIOAC4JA==
X-Received: by 2002:a05:6830:1658:: with SMTP id h24mr1117185otr.149.1624472681977;
        Wed, 23 Jun 2021 11:24:41 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:41 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 7/7] fpga-mgr: collect wrappers and change to inline
Date:   Wed, 23 Jun 2021 11:24:10 -0700
Message-Id: <20210623182410.3787784-9-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Anyone searching for the wrappers should find all of
them together, so  move the wrappers.

Since they are all small functions, make them inline.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 117 ++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 1a2b8d8be7674..000fa89fda99d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,65 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+/* mops wrappers */
+static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->state)
+		return  mgr->mops->state(mgr);
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->status)
+		return mgr->mops->status(mgr);
+	return 0;
+}
+
+static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
+
+static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write)
+		return  mgr->mops->write(mgr, buf, count);
+	return -EOPNOTSUPP;
+}
+
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
+	if (mgr->mops && mgr->mops->write_complete)
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
+static inline void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->fpga_remove)
+		mgr->mops->fpga_remove(mgr);
+}
+
 /**
  * fpga_image_info_alloc - Allocate an FPGA image info struct
  * @dev: owning device
@@ -69,14 +128,6 @@ void fpga_image_info_free(struct fpga_image_info *info)
 }
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
-static int fpga_mgr_write_init(struct fpga_manager *mgr,
-			       struct fpga_image_info *info,
-			       const char *buf, size_t count)
-{
-	if (mgr->mops && mgr->mops->write_init)
-		return  mgr->mops->write_init(mgr, info, buf, count);
-	return 0;
-}
 /*
  * Call the low level driver's write_init function.  This will do the
  * device-specific things to get the FPGA into the state where it is ready to
@@ -145,35 +196,6 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	return ret;
 }
 
-/*
- * After all the FPGA image has been written, do the device specific steps to
- * finish and set the FPGA into operating mode.
- */
-static int fpga_mgr_write_complete(struct fpga_manager *mgr,
-				   struct fpga_image_info *info)
-{
-	int ret = 0;
-
-	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	if (mgr->mops && mgr->mops->write_complete)
-		ret = mgr->mops->write_complete(mgr, info);
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
-static int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
-{
-	if (mgr->mops && mgr->mops->write)
-		return  mgr->mops->write(mgr, buf, count);
-	return -EOPNOTSUPP;
-}
-
 /**
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
@@ -426,14 +448,6 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
-static u64 fpga_mgr_status(struct fpga_manager *mgr)
-{
-	if (mgr->mops && mgr->mops->status)
-		return mgr->mops->status(mgr);
-
-	return 0;
-}
-
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -692,13 +706,6 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *nam
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
 
-static enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
-{
-	if (mgr->mops && mgr->mops->state)
-		return  mgr->mops->state(mgr);
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 /**
  * fpga_mgr_register - register an FPGA manager
  * @mgr: fpga manager struct
@@ -731,12 +738,6 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
-static void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
-{
-	if (mgr->mops && mgr->mops->fpga_remove)
-		mgr->mops->fpga_remove(mgr);
-}
-
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
  * @mgr: fpga manager struct
-- 
2.26.3

