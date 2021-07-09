Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9FC3C2836
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGIRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:23:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB52C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:20:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 9so10051023qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQdxfw/9c+/+gNmT+Te/u1pLJuYCp7pHwQO0FEVae+s=;
        b=lc+RSkREEO1Tcr1TNfj4YsYs7ZsWeTJIWqAfw6loonCnuNuS9bHLlZDpbXcdrPPNCr
         y2gq9+9jbhuyAKZ1skn9RSY9vZmkGEYt8ttBqQDqH2YUWUZ/RZ7wmRL11UHJ4N7PqvRN
         ULN3pLRI7Imkb1N2fNokzSCcF8W0i/cH5Uo44+jo0zq1i1GgdCHJVgCaCPLNO+fChtvX
         wd8tUEEj8Q/XhvVyKc6Qx+jA4PnD8sFVO7wSOK1d3MEIcdD+QTXZkktYVnfENApN470D
         XU2/+7f/zdRqGETJa+OZPGoTLdlfevbATsh5rUnLbtOL4fHj+XCpwbqd2EbxVwh0zt5I
         AL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tQdxfw/9c+/+gNmT+Te/u1pLJuYCp7pHwQO0FEVae+s=;
        b=Lmj2JOc2kAfpy0wBsG3vYHCAQRBwJQbvs7Ow4nQtSndFikD3n40YNvp4SEJU25rgHe
         vLs+kTuS9wsQwlqConfIcuJld7TDyyON7jIcYN7Jmf0aT5zmAicY0PPreC3p26TG1iI0
         Tik5T2exMq3xfTqZLOAbh0ySbDkRWIZ3LyBtDQ9htN6nf9yYE3WwqujJg0c0pTQWVy/1
         PQI/uOHLnl1c8dzWD3vsJsER+9BKIvmcFeX31AfmHQurtj5yExcTuy5hXKxEh6MfMNHK
         uB9zLHZFAHGwfcRfqp+GNoPdZLkcLtm+nM2E1wyRDoEjP6h/rDq0SNXpdVobsxgnkS3c
         Sm0Q==
X-Gm-Message-State: AOAM533ur8qtKsob+W1xqnxWpTijz7y0XnJ+vwsmLcMYKJQrdh/EIzgQ
        tq2ylsmQNjO/TxMfbrTzc7rJvg==
X-Google-Smtp-Source: ABdhPJyCYVDG4weAlapQyqWoUDGxBtKVnCjF7eRtucCgocj11IoflK9SfhOKteUKNcOYoWFD8Bryuw==
X-Received: by 2002:a37:73c7:: with SMTP id o190mr39279854qkc.314.1625851217697;
        Fri, 09 Jul 2021 10:20:17 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id w2sm2673316qkf.88.2021.07.09.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:20:17 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     James.Bottomley@hansenpartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1.1] drivers: parisc: Update sba_iommu driver with proper printks
Date:   Fri, 09 Jul 2021 13:20:16 -0400
Message-ID: <4683831.GXAFRqVoOG@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <4375849.LvFx2qVVIh@iron-maiden>
References: <4359868.LvFx2qVVIh@iron-maiden> <4375849.LvFx2qVVIh@iron-maiden>
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
-#define DBG_INIT(x...) printk(x)
+#define DBG_INIT(x...) pr_debug(x)
 #else
 #define DBG_INIT(x...)
 #endif
 
 #ifdef DEBUG_SBA_RUN
-#define DBG_RUN(x...)  printk(x)
+#define DBG_RUN(x...)  pr_debug(x)
 #else
 #define DBG_RUN(x...)
 #endif
 
 #ifdef DEBUG_SBA_RUN_SG
-#define DBG_RUN_SG(x...)       printk(x)
+#define DBG_RUN_SG(x...)       pr_debug(x)
 #else
 #define DBG_RUN_SG(x...)
 #endif
 
 
 #ifdef DEBUG_SBA_RESOURCE
-#define DBG_RES(x...)  printk(x)
+#define DBG_RES(x...)  pr_debug(x)
 #else
 #define DBG_RES(x...)
 #endif
@@ -1276,7 +1277,7 @@ sba_ioc_init_pluto(struct parisc_device *sba, struct ioc *ioc, int ioc_num)
        iova_space_size = ~(READ_REG(ioc->ioc_hpa + IOC_IMASK) & 0xFFFFFFFFUL) + 1;
 
        if ((ioc->ibase < 0xfed00000UL) && ((ioc->ibase + iova_space_size) > 0xfee00000UL)) {
-               printk("WARNING: IOV space overlaps local config and interrupt message, truncating\n");
+               printk(KERN_WARNING "WARNING: IOV space overlaps local config and interrupt message, truncating\n");
                iova_space_size /= 2;
        }
 
@@ -1550,7 +1551,7 @@ static void sba_hw_init(struct sba_device *sba_dev)
 
 
 #if 0
-printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
+       dev_dbg("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
        PAGE0->mem_boot.spa, PAGE0->mem_boot.pad, PAGE0->mem_boot.cl_class);
 
        /*
-- 
2.25.1


