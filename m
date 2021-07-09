Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF93C2528
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhGINpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232033AbhGINpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625838179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wz+VSo4V9K18GbntS6U5gCGz01NIx30Fco4WkjLLzY=;
        b=LrDnq9Rnwv37vAXA60aPIuC8LerBHZ0xwLf4V6XLmvG1Ag766/9bshvePmlh7cTxHBn6xe
        x5K7QlJnwVliH847oQJxiL3jlgmTNPlWZV+Fr2tgUE5Mv1hdtyViCBlZUfPWq9moDcPqym
        +ptZFVHhRgNxdQLCR95lxbaMV2cyQ7A=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-3-sgtyPzOkOvbSlslch4eQ-1; Fri, 09 Jul 2021 09:42:55 -0400
X-MC-Unique: 3-sgtyPzOkOvbSlslch4eQ-1
Received: by mail-oo1-f72.google.com with SMTP id k19-20020a4ae2930000b029025d87cea48fso115040oot.19
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wz+VSo4V9K18GbntS6U5gCGz01NIx30Fco4WkjLLzY=;
        b=XUXEm4CslU3Dwc6nmnbOQcjy+uQvUqkWoT8H9SMN3DGvBHwre6QynX6tUq9MRZGAAC
         3GLQYO61d+yiIWEL1F5y6zACbGziTG3zU2DTytR99/SzgxyzpFt0wJXLYy3F0gtCigQf
         mUjqFrziT9KQB4KV8o4WWkJdxfAuKECLKZLZ+q/1K/Y9WCxQe63dzwHUUfaa2YsgBQFY
         96/6wvj8EC2l8kQfQ+vRD/7S1wpJW8hmINKX/B+bG6Tn4MwNpkpq4lFghli5hvZqCymy
         z2ql8RGB+F4e/rrHcpYHMqEybjxGAHf/ktSp0AOwWYObYrEUuz/q6NDFO+b/LTUOPXWQ
         Y0CQ==
X-Gm-Message-State: AOAM532K7VhF4j8mSh/k7QCxaMp51MStMNvvGEIKhLhzQoB0bnnquvKr
        s5t4Q4RhvImQSqECnZbdTBxWDBsNWEGZYJW8PdrbWU6NKgChJQEe/qx8sn6aNcmUHYAxQcKRnlR
        4iaTgewqSHsHLnc77OkE1HcMB
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr28542669ota.343.1625838175132;
        Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyct9gWfuz8J4WdA0JiUc5G3he1tUaqh++CoaPW1Hq4K8Vh7x7DTNLAC9435HjMvp1BII3xog==
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr28542648ota.343.1625838174975;
        Fri, 09 Jul 2021 06:42:54 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j23sm1215948oie.9.2021.07.09.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:54 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 3/4] fpga: dfl: implement the compat_id_show region op
Date:   Fri,  9 Jul 2021 06:42:28 -0700
Message-Id: <20210709134229.2510349-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210709134229.2510349-1-trix@redhat.com>
References: <20210709134229.2510349-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Make sure dfl will work as previously when compat_id is removed
from struct fpga_manager.  Store and pass the compat_id values
internal to dfl.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c    | 16 +++++++++++++---
 drivers/fpga/dfl-fme-region.c | 14 ++++++++++++++
 drivers/fpga/dfl.h            | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..cd0b9157ea6e5 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -22,6 +22,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/fpga/fpga-mgr.h>
 
+#include "dfl.h"
 #include "dfl-fme-pr.h"
 
 /* FME Partial Reconfiguration Sub Feature Register Set */
@@ -70,6 +71,7 @@
 struct fme_mgr_priv {
 	void __iomem *ioaddr;
 	u64 pr_error;
+	struct dfl_compat_id compat_id;
 };
 
 static u64 pr_error_to_mgr_status(u64 err)
@@ -272,13 +274,21 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.status = fme_mgr_status,
 };
 
-static void fme_mgr_get_compat_id(void __iomem *fme_pr,
-				  struct fpga_compat_id *id)
+static void _fme_mgr_get_compat_id(void __iomem *fme_pr,
+				   struct dfl_compat_id *id)
 {
 	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
 	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
 }
 
+void fme_mgr_get_compat_id(struct fpga_manager *mgr,
+			   struct dfl_compat_id *id)
+{
+	struct fme_mgr_priv *priv = mgr->priv;
+	*id = priv->compat_id;
+}
+EXPORT_SYMBOL_GPL(fme_mgr_get_compat_id);
+
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
@@ -306,7 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	if (!compat_id)
 		return -ENOMEM;
 
-	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
+	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
 
 	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
 				   &fme_mgr_ops, priv);
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index ca7277d3d30a9..d21eacbf2469f 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -17,6 +17,7 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
 
+#include "dfl.h"
 #include "dfl-fme-pr.h"
 
 static int fme_region_get_bridges(struct fpga_region *region)
@@ -27,8 +28,21 @@ static int fme_region_get_bridges(struct fpga_region *region)
 	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
 }
 
+static ssize_t fme_region_compat_id_show(struct fpga_region *region, char *buf)
+{
+	struct fpga_manager *mgr = region->mgr;
+	struct dfl_compat_id compat_id;
+
+	fme_mgr_get_compat_id(mgr, &compat_id);
+
+	return sysfs_emit(buf, "%016llx%016llx\n",
+			  (unsigned long long)compat_id.id_h,
+			  (unsigned long long)compat_id.id_l);
+}
+
 static const struct fpga_region_ops fme_fpga_region_ops = {
 	.get_bridges = fme_region_get_bridges,
+	.compat_id_show = fme_region_compat_id_show,
 };
 
 static int fme_region_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2b82c96ba56c7..a83fd11b390fc 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -169,6 +169,20 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
+/**
+ * struct dfl_compat_id - id for compatibility check
+ *
+ * @id_h: high 64bit of the compat_id
+ * @id_l: low 64bit of the compat_id
+ */
+struct dfl_compat_id {
+	u64 id_h;
+	u64 id_l;
+};
+
+void fme_mgr_get_compat_id(struct fpga_manager *mgr,
+			   struct dfl_compat_id *id);
+
 /**
  * struct dfl_fpga_port_ops - port ops
  *
-- 
2.26.3

