Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F65B3148DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhBIGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhBIGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:24:14 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E62C0611C1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:23:25 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t25so11840407pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCpdetXZbkmTlNt6IWgIQo6qPUhUH6Y1glnHH1TYQ8A=;
        b=m27gPzIn4y36BwdfABPhJctzVcQ+lZFochfhUvq6yh+3RZRwkrsGVp6GPOttVPTYhe
         piJwyWKCXZarFl+5Mgad+/eyxNzq8NXJiZDrHYIevzx3qMO6Yl37ZUAmkcqRBRBt6DSZ
         YohFfsGtKU7yDyK0RzwEYOoKhUHsk0fZc4SIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCpdetXZbkmTlNt6IWgIQo6qPUhUH6Y1glnHH1TYQ8A=;
        b=jRLwqZ6lmY9IvOcXGOXvm/RGv/1hpW35mGRMxtwR3dP5L3ylVC6YWHwmQWuOO6+5Ds
         ZiDaEW0xy+yyKEJQuCtN7vPLJVFR0C47VrZSrVzayr+n6YEQVKVOVnR6PnS7rhHeC56G
         VUSSaytZfeTobIda6rTcGZWmrhM6dqjBxshmQ2/DJ2I/Y5/u/5jMvCXxDVb1btuAfgeg
         8Rigk9o/i9qfJsGSPS8HeOtthwKMWRLm24Y2N9PsNPwG2DihvXImZL9b5fctj/JZzI2T
         77TAkdg05Oxj/mDq8qO+QCubRbqwVIUYA8aZD7gueqHozkAFARjGMn1YCWm6q5HGod7D
         I+Qw==
X-Gm-Message-State: AOAM532q0MaxLuZdF/XJIm8uJQX91w4NpujObn/bFRuMdV/+/kG+ZWcJ
        5+73VqoVFBQPYRSKe/ZFTn2XIA==
X-Google-Smtp-Source: ABdhPJzbc6B180HFMEwkww4vcx+xgwf9jKl8iifukr0wO8EhuGUoiPsVkBYDMJ6LpbG7UB75Krtn/A==
X-Received: by 2002:a62:484:0:b029:1b7:878b:c170 with SMTP id 126-20020a6204840000b02901b7878bc170mr21302515pfe.28.1612851804694;
        Mon, 08 Feb 2021 22:23:24 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id c18sm11072205pfo.171.2021.02.08.22.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:23:24 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v4 14/14] of: Add plumbing for restricted DMA pool
Date:   Tue,  9 Feb 2021 14:21:31 +0800
Message-Id: <20210209062131.2300005-15-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device is not behind an IOMMU, we look up the device node and set
up the restricted DMA when the restricted-dma-pool is presented.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 25 +++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 73ddf2540f3f..b6093c9b135d 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1094,3 +1095,27 @@ bool of_dma_is_coherent(struct device_node *np)
 	return false;
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
+
+int of_dma_set_restricted_buffer(struct device *dev)
+{
+	struct device_node *node;
+	int count, i;
+
+	if (!dev->of_node)
+		return 0;
+
+	count = of_property_count_elems_of_size(dev->of_node, "memory-region",
+						sizeof(phandle));
+	for (i = 0; i < count; i++) {
+		node = of_parse_phandle(dev->of_node, "memory-region", i);
+		/* There might be multiple memory regions, but only one
+		 * restriced-dma-pool region is allowed.
+		 */
+		if (of_device_is_compatible(node, "restricted-dma-pool") &&
+		    of_device_is_available(node))
+			return of_reserved_mem_device_init_by_idx(
+				dev, dev->of_node, i);
+	}
+
+	return 0;
+}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1122daa8e273..38c631f1fafa 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -186,6 +186,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_restricted_buffer(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d9e6a324de0a..28a2dfa197ba 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -161,12 +161,17 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
+int of_dma_set_restricted_buffer(struct device *dev);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
+static inline int of_dma_get_restricted_buffer(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.30.0.478.g8a0d178c01-goog

