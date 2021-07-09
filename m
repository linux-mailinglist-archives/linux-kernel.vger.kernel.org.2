Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED793C2832
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhGIRWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:22:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ECAC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:19:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 9so10048202qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yxl1tNZKigS9UWf0mN4e6AUNlXVlUTPEpM5TqXUIMgk=;
        b=kDsooJNdH3FEa+zHQR3hu/hgw+kW6aVc0ON6I26HN+SU3QY28v8znxLReE16YciWMP
         l1cwKI5HS9lM+bYJ1oxNTNCyFydjZagKI6mAw1pID/okSOu94JlgPtwQ7sz365NbGLRS
         8OQPkUBD44FclYpIpG803fy2v8Pang3bqpxGI+JCybsndKmggVYabXil0d/LumTbdomU
         ba4ko8RN7XP18mt/3wri+aRuSe0WyI8gvQXDoHuOLdSScO9RI2b08lb2DoaqV1AZTNp4
         dF3lq0sph7Bn+BFzNx0ODu7Q2r7lj4HOu+Kv+j0NUe1cnH1iW5recG6j2qq6ajBM5O1a
         ysYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Yxl1tNZKigS9UWf0mN4e6AUNlXVlUTPEpM5TqXUIMgk=;
        b=DwW3CpxAPgf+hb6wdZGupBkD9sCHJQEXUuXUQT+ch12dabMY6cWIKa1qxXNI8RbVTn
         4TzEgkgLHNGPTVm/JULQj91RmZPFpFYCO30Xs4fIjgl0KicYLAto/DOtrk3pYBUeZdhD
         3nzSNJdSXDqme+MRb/zEqzdcXKHiSDUJGjJq/FNVK9x0V29avtPmonBFKFadHXGlqE11
         hbpLdkMHv4BOI007STofWmSTkBl43nB6t5XnEFIt01BsHm7vSXT70PZ6yu/Nk0N5QHJ9
         CZcWcJvgmU7dq3lhBslifw7ckxuQdJipixsntusMtgfm7mrIrs+pS6NHuFkoU//v8mXz
         e73A==
X-Gm-Message-State: AOAM531aiUYopeakQjPOq5HXcQzuQLxeA/bj1PJmbWfnF9oPQPsk3dPA
        hBrC5TFnpufx7hlWXGc4i11eqg==
X-Google-Smtp-Source: ABdhPJxtQXWH09PhE9SlfduyO5Hqj0r25X8OZVAG6bRQGPYPqCUK2IU+JkujC3ywxnTFKMwOZPF3ag==
X-Received: by 2002:a37:91c7:: with SMTP id t190mr38684613qkd.282.1625851164931;
        Fri, 09 Jul 2021 10:19:24 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id y20sm2722661qkm.5.2021.07.09.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:19:24 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     James.Bottomley@hansenpartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1.1] drivers: parisc: Update sba_iommu driver with proper printks
Date:   Fri, 09 Jul 2021 13:19:23 -0400
Message-ID: <4375849.LvFx2qVVIh@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <4359868.LvFx2qVVIh@iron-maiden>
References: <4359868.LvFx2qVVIh@iron-maiden>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code from the old SBA IOMMU manager is outdated when it comes to printks. 
Fix applying proper indentation and using pr_debug() instead of printk on 
debugging blocks. Also add a KERN_<LEVEL> where it is missing.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
Changelog: Replace dev_dbg() for pr_debug()
---
From 2b7df19bca628a1c7dd5bbb92dda1b3c26cd9757 Mon Sep 17 00:00:00 2001
From: Carlos Bilbao <bilbao@vt.edu>
Date: Fri, 9 Jul 2021 13:18:53 -0400
Subject: [PATCH] sba_iommu

---
 drivers/parisc/sba_iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index dce4cdf786cd..381866cfa5b2 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/printk.h>
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/iommu-helper.h>
@@ -65,26 +66,26 @@
 #undef DEBUG_DMB_TRAP
 
 #ifdef DEBUG_SBA_INIT
-#define DBG_INIT(x...)	printk(x)
+#define DBG_INIT(x...)	pr_debug(x)
 #else
 #define DBG_INIT(x...)
 #endif
 
 #ifdef DEBUG_SBA_RUN
-#define DBG_RUN(x...)	printk(x)
+#define DBG_RUN(x...)	pr_debug(x)
 #else
 #define DBG_RUN(x...)
 #endif
 
 #ifdef DEBUG_SBA_RUN_SG
-#define DBG_RUN_SG(x...)	printk(x)
+#define DBG_RUN_SG(x...)	pr_debug(x)
 #else
 #define DBG_RUN_SG(x...)
 #endif
 
 
 #ifdef DEBUG_SBA_RESOURCE
-#define DBG_RES(x...)	printk(x)
+#define DBG_RES(x...)	pr_debug(x)
 #else
 #define DBG_RES(x...)
 #endif
@@ -1276,7 +1277,7 @@ sba_ioc_init_pluto(struct parisc_device *sba, struct ioc *ioc, int ioc_num)
 	iova_space_size = ~(READ_REG(ioc->ioc_hpa + IOC_IMASK) & 0xFFFFFFFFUL) + 1;
 
 	if ((ioc->ibase < 0xfed00000UL) && ((ioc->ibase + iova_space_size) > 0xfee00000UL)) {
-		printk("WARNING: IOV space overlaps local config and interrupt message, truncating\n");
+		printk(KERN_WARNING "WARNING: IOV space overlaps local config and interrupt message, truncating\n");
 		iova_space_size /= 2;
 	}
 
@@ -1550,7 +1551,7 @@ static void sba_hw_init(struct sba_device *sba_dev)
 
 
 #if 0
-printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
+	dev_dbg("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
 	PAGE0->mem_boot.spa, PAGE0->mem_boot.pad, PAGE0->mem_boot.cl_class);
 
 	/*
-- 
2.25.1



