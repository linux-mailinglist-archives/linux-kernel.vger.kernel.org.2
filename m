Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BC73D6820
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGZTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhGZTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627331217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fw3k8510EioNmTpAQUibHcKLICTVfvZZc4r6uW301CE=;
        b=fWt5DfH/yRGoMtZuFI9uoWaxVylzJxvJL6CVdg3w97pAnBS+8fD7e3bHh2/28igghdA2aC
        w44SOkJXxBODFNNVdkEzweorU0Ig1Tq1w0tBeE7LuNIPffnBntAS+5fi50CmDNrA+nNxhm
        arhYDKRsMmSCemsPBGsKozADxHCFkRw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-3dVXJ2FMP2aOYpwS6zmkTQ-1; Mon, 26 Jul 2021 16:26:56 -0400
X-MC-Unique: 3dVXJ2FMP2aOYpwS6zmkTQ-1
Received: by mail-qv1-f69.google.com with SMTP id o32-20020a0c85a30000b0290328f91ede2bso5632484qva.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fw3k8510EioNmTpAQUibHcKLICTVfvZZc4r6uW301CE=;
        b=PAM/HDMgH6LGX+G/h9v+JwbHPos0x4Aeqet5WoApez3fRCLUxhRqMv9zqW1HFcGL8i
         KH+JSmFGxalj0OLzIWm3uDcjg9qF5A5wSTk3+jSDUjPuXEyr2OhulV6bQ40DsEE62PnP
         vj2TSzI80xoQEpOamaw6LnCpPOURe7liTKlc02o+zjqstVJJg7QW+aAzlDLnb8jBUEhF
         Mjo27JEkpEK/zlu49WSYIEz3WrP2iI3M0vQ+htNU9Nll4kW4LETJ5wGA+XHLGVn4rpIk
         rj6Io1EwDyKjJctz0P4DgC096NwzJIwp/QKJIKTEkOXTY8Ihg0/aPbARI21zBl0C8ZTc
         Mf6Q==
X-Gm-Message-State: AOAM532aKZrbQJxGlNw5qgbe9ijHbqUsObb9qiNZ/KDAaspczaL/O5aV
        uAyEQQ37oTttNdNXCqrpyO1lr1DguIW+eqN6wyeLzoiZVCvP9f0eKz8CEFRSeU8mxEU8mVqVswb
        xsHJWmn9OgbmC5xjmiFUUnVx1
X-Received: by 2002:a0c:ee43:: with SMTP id m3mr19728125qvs.34.1627331215242;
        Mon, 26 Jul 2021 13:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD3CJp5qfja+2uXTxqqxkY9fBFfISZ81Yi9O/f57IsbQrtZnAkoV3cR+A8YpkuW82y6D990Q==
X-Received: by 2002:a0c:ee43:: with SMTP id m3mr19728118qvs.34.1627331215053;
        Mon, 26 Jul 2021 13:26:55 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g11sm444951qtk.91.2021.07.26.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:26:54 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: region: handle compat_id as an uuid
Date:   Mon, 26 Jul 2021 13:26:50 -0700
Message-Id: <20210726202650.4074614-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An fpga region's compat_id is exported by the sysfs
as a 128 bit hex string formed by concatenating two
64 bit values together.

The only user of compat_id is dfl.  Its user library
opae converts this value into a uuid.

ex/
$ cat /sys/class/fpga_region/region1/compat_id
f3c9941350814aadbced07eb84a6d0bb

Is reported as
$ fpgainfo bmc
...
Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb

Storing a uuid as 2 64 bit values is vendor specific.
And concatenating them together is vendor specific.

It is better to store and print out as a vendor neutral uuid.

Change fpga_compat_id from a struct to a union.
Keep the old 64 bit values for dfl.
Sysfs output is now
f3c99413-5081-4aad-bced-07eb84a6d0bb

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../ABI/testing/sysfs-class-fpga-region        |  4 ++--
 drivers/fpga/dfl-fme-mgr.c                     |  8 ++++----
 drivers/fpga/fpga-region.c                     |  4 +---
 include/linux/fpga/fpga-mgr.h                  | 18 ++++++++++++------
 include/linux/fpga/fpga-region.h               |  2 +-
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
index bc7ec644acc9a..241359fb74a55 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-region
+++ b/Documentation/ABI/testing/sysfs-class-fpga-region
@@ -5,5 +5,5 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	FPGA region id for compatibility check, e.g. compatibility
 		of the FPGA reconfiguration hardware and image. This value
 		is defined or calculated by the layer that is creating the
-		FPGA region. This interface returns the compat_id value or
-		just error code -ENOENT in case compat_id is not used.
+		FPGA region. This interface returns a uuid value or just
+		error code -ENOENT in case compat_id is not used.
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..012b72712684c 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -273,16 +273,16 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 };
 
 static void fme_mgr_get_compat_id(void __iomem *fme_pr,
-				  struct fpga_compat_id *id)
+				  union fpga_compat_id *id)
 {
-	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
-	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
+	id->id_l = cpu_to_be64(readq(fme_pr + FME_PR_INTFC_ID_L));
+	id->id_h = cpu_to_be64(readq(fme_pr + FME_PR_INTFC_ID_H));
 }
 
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct fpga_compat_id *compat_id;
+	union fpga_compat_id *compat_id;
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index a4838715221ff..f1083b5894635 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -166,9 +166,7 @@ static ssize_t compat_id_show(struct device *dev,
 	if (!region->compat_id)
 		return -ENOENT;
 
-	return sprintf(buf, "%016llx%016llx\n",
-		       (unsigned long long)region->compat_id->id_h,
-		       (unsigned long long)region->compat_id->id_l);
+	return sprintf(buf, "%pU\n", &region->compat_id->uuid);
 }
 
 static DEVICE_ATTR_RO(compat_id);
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index ec2cd8bfceb00..b12f9994932e1 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -10,6 +10,7 @@
 
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/uuid.h>
 
 struct fpga_manager;
 struct sg_table;
@@ -144,14 +145,19 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
 
 /**
- * struct fpga_compat_id - id for compatibility check
- *
+ * union fpga_compat_id - id for compatibility check
+ * Can be accessed as either:
+ * @uuid: the base uuid_t type
+ * or
  * @id_h: high 64bit of the compat_id
  * @id_l: low 64bit of the compat_id
  */
-struct fpga_compat_id {
-	u64 id_h;
-	u64 id_l;
+union fpga_compat_id {
+	uuid_t uuid;
+	struct {
+		u64 id_h;
+		u64 id_l;
+	};
 };
 
 /**
@@ -169,7 +175,7 @@ struct fpga_manager {
 	struct device dev;
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
-	struct fpga_compat_id *compat_id;
+	union fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
 };
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 27cb706275dba..7cc2ee543efb4 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -24,7 +24,7 @@ struct fpga_region {
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
-	struct fpga_compat_id *compat_id;
+	union fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
-- 
2.26.3

