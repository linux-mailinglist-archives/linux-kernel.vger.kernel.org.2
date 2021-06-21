Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7753AF9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhFUXzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhFUXzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:55:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A629EC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:53:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q192so8349331pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+55avrqH7PSLbd+BXUibv+6BHo9MYXZgAoz7DvAWSE=;
        b=Z9UiwsXVLViVRcDZDkhKhAP5wp6N2/7oCZHEi8zfIYlgyiaYzZTxOpttLl37nUeURD
         Np+KH8LyE0EQDTmqWBDDL1ser31YUdxduJp96bhjRqVJ9VwthhX8CurLb3IVXStzlfaa
         oeYNByH3L4dSED0VHepIX7XYepmWioWdaXHj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+55avrqH7PSLbd+BXUibv+6BHo9MYXZgAoz7DvAWSE=;
        b=msFvtX5te9nrzoefUUo6uiPFgjPZgVIB79Nw49bvO8XCnX5TzIwGyGkORyIdCAZS2u
         qfD6Y9IWJQHe0CnZi9IG2usogtjMp0vG0UPMNDvqJZAUUH1EPTYdRa35ZeIpnomzfYt+
         MkqiCLQgs7A6/Jb3ivL3Kg7rlVCyKKXx2j2kCtYh6TpRo9n5PgTcuholc5Uud0OYpxlq
         xfrnQdARBLL1T3KlMt3UMEUlF4Ski+0yHMK246n8/NmrFXXz1BKg1klIaY2lpx6DB/G2
         wScC28EZR/7AtrPzOTJyQlcCoz3ow0f7XfSSDXrVXaGm9SF3lEyDaOyt1bIHyNnQ1n3Y
         h72A==
X-Gm-Message-State: AOAM532z5gBsTiB9dR3/5SEDtnsbsDjgQMKVdELK26OXnqtjt3hgV2QI
        wOxYUwmUcB+FlhZ5AABjkwESOQ==
X-Google-Smtp-Source: ABdhPJy3/8zfBLBO8WRO6RAvlGTjYRKGlwjguf8az5cO3Oli5Gn9NpQXkk50ljDLX9KWheRiSWaDJQ==
X-Received: by 2002:a63:4653:: with SMTP id v19mr953623pgk.240.1624319597222;
        Mon, 21 Jun 2021 16:53:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu: Combine device strictness requests with the global default
Date:   Mon, 21 Jun 2021 16:52:46 -0700
Message-Id: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("drivers: base: Add bits to struct device to control
iommu strictness") we add the ability for devices to tell us about
their IOMMU strictness requirements. Let's now take that into account
in the IOMMU layer.

A few notes here:
* Presumably this is always how iommu_get_dma_strict() was intended to
  behave. Had this not been the intention then it never would have
  taken a domain as a parameter.
* The iommu_set_dma_strict() feels awfully non-symmetric now. That
  function sets the _default_ strictness globally in the system
  whereas iommu_get_dma_strict() returns the value for a given domain
  (falling back to the default). Presumably, at least, the fact that
  iommu_set_dma_strict() doesn't take a domain makes this obvious.

The function iommu_get_dma_strict() should now make it super obvious
where strictness comes from and who overides who. Though the function
changed a bunch to make the logic clearer, the only two new rules
should be:
* Devices can force strictness for themselves, overriding the cmdline
  "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
* Devices can request non-strictness for themselves, assuming there
  was no cmdline "iommu.strict=1" or a call to
  iommu_set_dma_strict(true).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++++++++++----------
 include/linux/iommu.h |  2 ++
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..0c84a4c06110 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -28,8 +28,19 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
+enum iommu_strictness {
+	IOMMU_DEFAULT_STRICTNESS = -1,
+	IOMMU_NOT_STRICT = 0,
+	IOMMU_STRICT = 1,
+};
+static inline enum iommu_strictness bool_to_strictness(bool strictness)
+{
+	return (enum iommu_strictness)strictness;
+}
+
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = true;
+static enum iommu_strictness cmdline_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
+static enum iommu_strictness driver_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
@@ -69,7 +80,6 @@ static const char * const iommu_group_resv_type_string[] = {
 };
 
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
-#define IOMMU_CMD_LINE_STRICT		BIT(1)
 
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
@@ -336,25 +346,38 @@ early_param("iommu.passthrough", iommu_set_def_domain_type);
 
 static int __init iommu_dma_setup(char *str)
 {
-	int ret = kstrtobool(str, &iommu_dma_strict);
+	bool strict;
+	int ret = kstrtobool(str, &strict);
 
 	if (!ret)
-		iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
+		cmdline_dma_strict = bool_to_strictness(strict);
 	return ret;
 }
 early_param("iommu.strict", iommu_dma_setup);
 
 void iommu_set_dma_strict(bool strict)
 {
-	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
-		iommu_dma_strict = strict;
+	/* A driver can request strictness but not the other way around */
+	if (driver_dma_strict != IOMMU_STRICT)
+		driver_dma_strict = bool_to_strictness(strict);
 }
 
 bool iommu_get_dma_strict(struct iommu_domain *domain)
 {
-	/* only allow lazy flushing for DMA domains */
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		return iommu_dma_strict;
+	/* Non-DMA domains or anyone forcing it to strict makes it strict */
+	if (domain->type != IOMMU_DOMAIN_DMA ||
+	    cmdline_dma_strict == IOMMU_STRICT ||
+	    driver_dma_strict == IOMMU_STRICT ||
+	    domain->force_strict)
+		return true;
+
+	/* Anyone requesting non-strict (if no forces) makes it non-strict */
+	if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
+	    driver_dma_strict == IOMMU_NOT_STRICT ||
+	    domain->request_non_strict)
+		return false;
+
+	/* Nobody said anything, so it's strict by default */
 	return true;
 }
 EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
@@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
 
 static int iommu_group_alloc_default_domain(struct bus_type *bus,
 					    struct iommu_group *group,
-					    unsigned int type)
+					    unsigned int type,
+					    struct device *dev)
 {
 	struct iommu_domain *dom;
 
@@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 	if (!dom)
 		return -ENOMEM;
 
+	/* Save the strictness requests from the device */
+	if (dev && type == IOMMU_DOMAIN_DMA) {
+		dom->request_non_strict = dev->request_non_strict_iommu;
+		dom->force_strict = dev->force_strict_iommu;
+	}
+
 	group->default_domain = dom;
 	if (!group->domain)
 		group->domain = dom;
@@ -1550,7 +1580,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	return iommu_group_alloc_default_domain(dev->bus, group, type, dev);
 }
 
 /**
@@ -1721,7 +1751,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 	if (!gtype.type)
 		gtype.type = iommu_def_domain_type;
 
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
+	iommu_group_alloc_default_domain(bus, group, gtype.type, NULL);
 
 }
 
@@ -3130,7 +3160,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	}
 
 	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
+	ret = iommu_group_alloc_default_domain(dev->bus, group, type, dev);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..0bddef77f415 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -81,6 +81,8 @@ struct iommu_domain_geometry {
 
 struct iommu_domain {
 	unsigned type;
+	bool force_strict:1;
+	bool request_non_strict:1;
 	const struct iommu_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
-- 
2.32.0.288.g62a8d224e6-goog

