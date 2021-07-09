Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216303C2529
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhGINpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231880AbhGINpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625838180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlPPUF0Gcbw6/yHTlRqjYQVdox+0fqPhBKj6QGPVVk8=;
        b=OcSMGlgjUbPa4vWWHNuymXlVMi1LmD6xbrzlNI+0aa9mQE9Jl4fc2O4v/sc4YCjqPOdTzA
        hYlpCjuuCiu4VPp8KRtvL17r8IMmiWb+0s8tHIWQf+zwXYZohxMnBI1CZmdNQbtOJwxTKf
        9u7RFcSQ8hXI5rak3ZOMZfkwDpKY2FM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-jKPfTyryNQW2M9cSQv7vRA-1; Fri, 09 Jul 2021 09:42:58 -0400
X-MC-Unique: jKPfTyryNQW2M9cSQv7vRA-1
Received: by mail-oi1-f199.google.com with SMTP id f84-20020aca38570000b02901f424a672b7so6636137oia.18
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlPPUF0Gcbw6/yHTlRqjYQVdox+0fqPhBKj6QGPVVk8=;
        b=mFDUkOChv2h1GgevXTxkDQnvKnaCGsK/pNHKxnxGVa+3IgK+jydiE5xyESUufJ2jYF
         8igvAd2MoxfiBjWc7aoVWyiw4k1LwZXcd2KciEBEtaFYE6waCcsr7cekt7BDcE/ZN3pf
         NJ2ojJIS8DAD/XbT5EB0R3kG2DgacvZ/XfzE3N5dQ1YHAJMxmX3YPh0w1g1kdHsZNZqX
         Y3eBQquAEQ4nEaHKv01BOFrrcLCqbGfhDuoUr+GSGfvE3Lrqw3A37OhBDcbGZQI7H0hE
         ohJe9lRhysgdEgy2VteZqJFRb3sCSuneySa5aJBZ1kOTEmz2MWjGXQ/qoKzzHaBVXfvQ
         T2xw==
X-Gm-Message-State: AOAM531DNZCQBjWsKjgVNBbZnrk9j2/3p75391EjjUcoXUfDUGcshujG
        hwciFuQxyDA8fCIhK+ExylLGEEmbuR52lGlT5j47cVNXEVdtojUyoOiP9JPc3T99kpbcYDLa3x2
        aRc+zeVQwvZgBGmhob5CsYJkH
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr25514346ott.201.1625838178194;
        Fri, 09 Jul 2021 06:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZB10we+gSjX2AbpriYStSZIsyFAqiV/1xYA1P7bwk1YCEK7j4xSxMnm+CRKGwJ5ih2KGX9Q==
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr25514334ott.201.1625838178022;
        Fri, 09 Jul 2021 06:42:58 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j23sm1215948oie.9.2021.07.09.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:57 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and fpga_region
Date:   Fri,  9 Jul 2021 06:42:29 -0700
Message-Id: <20210709134229.2510349-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210709134229.2510349-1-trix@redhat.com>
References: <20210709134229.2510349-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

compat_id is implementation specific.  So the data should be
stored at the implemeation layer, not the infrastructure layer.
Remove the compat_id elements and supporting code.

Printing out the compat_id is done with the fpga_region
compat_id_show() op.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c       |  7 -------
 drivers/fpga/dfl-fme-region.c    |  1 -
 drivers/fpga/fpga-region.c       |  7 +------
 include/linux/fpga/fpga-mgr.h    | 13 -------------
 include/linux/fpga/fpga-region.h |  2 --
 5 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index cd0b9157ea6e5..8c5423eeffe75 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -292,7 +292,6 @@ EXPORT_SYMBOL_GPL(fme_mgr_get_compat_id);
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct fpga_compat_id *compat_id;
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
@@ -312,10 +311,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->ioaddr);
 	}
 
-	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
-	if (!compat_id)
-		return -ENOMEM;
-
 	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
 
 	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
@@ -323,8 +318,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	mgr->compat_id = compat_id;
-
 	return devm_fpga_mgr_register(dev, mgr);
 }
 
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index d21eacbf2469f..be1d57ee37666 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -64,7 +64,6 @@ static int fme_region_probe(struct platform_device *pdev)
 	}
 
 	region->priv = pdata;
-	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
 	ret = fpga_region_register(region);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 864dd4f290e3b..b08d3914716f0 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -172,12 +172,7 @@ static ssize_t compat_id_show(struct device *dev,
 	if (region->rops && region->rops->compat_id_show)
 		return region->rops->compat_id_show(region, buf);
 
-	if (!region->compat_id)
-		return -ENOENT;
-
-	return sprintf(buf, "%016llx%016llx\n",
-		       (unsigned long long)region->compat_id->id_h,
-		       (unsigned long long)region->compat_id->id_l);
+	return -ENOENT;
 }
 
 static DEVICE_ATTR_RO(compat_id);
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index ec2cd8bfceb00..ebdea215a8643 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -143,24 +143,12 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
 
-/**
- * struct fpga_compat_id - id for compatibility check
- *
- * @id_h: high 64bit of the compat_id
- * @id_l: low 64bit of the compat_id
- */
-struct fpga_compat_id {
-	u64 id_h;
-	u64 id_l;
-};
-
 /**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
  * @dev: fpga manager device
  * @ref_mutex: only allows one reference to fpga manager
  * @state: state of fpga manager
- * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
  */
@@ -169,7 +157,6 @@ struct fpga_manager {
 	struct device dev;
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
-	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
 };
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 236d3819f1c13..afc79784b2823 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -30,7 +30,6 @@ struct fpga_region_ops {
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
  * @info: FPGA image info
- * @compat_id: FPGA region id for compatibility check.
  * @priv: private data
  * @rops: optional pointer to struct for fpga region ops
  */
@@ -40,7 +39,6 @@ struct fpga_region {
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
-	struct fpga_compat_id *compat_id;
 	void *priv;
 	const struct fpga_region_ops *rops;
 };
-- 
2.26.3

