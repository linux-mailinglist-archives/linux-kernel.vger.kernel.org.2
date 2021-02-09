Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6273148D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBIG3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBIGYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:24:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0028C061223
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:23:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m2so5090800pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zQVHgfobPuQEWulcSd+ytGSNGCX6uxs4mC7Gt2kf+c=;
        b=ert+XkxphAdsHWZRYOV0Cfn/2U+Hq+bg6asziCHHt/7u8Vvc0xyaeiuaRHcJi9Q1Vz
         h0k512lAFo9/rmCIttSQjdSndXS7KAKpm476xzbqDMAPDG5a7mdNYtdhfGaun9yWGWmH
         a9iyECq63v2VApjt+BbXpHPW6ZsiyzSxuIc1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zQVHgfobPuQEWulcSd+ytGSNGCX6uxs4mC7Gt2kf+c=;
        b=qMXiwrfffLHjJmxc/IEOhWPSysyYhYp2xly6GgMNNcXnJ8aET5HP+cZhn9k72uOGp5
         8os6TvwL9nXx4pPZSPnkco5JXyBTTlgoHdKvTuvE/ZrDq1yY1c6w2mhAXmy7aZYugYuA
         TAAi19KWH8GmPvH4QqU27cjjE/3xH3d4x4A3Ob8AMZHe5FmowWEN7+n2cGpM5vAlyOu6
         wdhBUIt2/+AQnRGdehnJBjVSbTiYQfYp8LFDN6T6J4SekQ1PRZoKfa93LjYDoRM4f/ER
         rCizqieVPYCH6cEvzR+fm3R1vRZ4v5ukWponY9pONzGUJAaeMjtb7pY/V+Ur6i/LNLcq
         tvPQ==
X-Gm-Message-State: AOAM533dROxH5Krh7pT9Bhq3T0T/7JUXFb0LvSiUvKdtnlsJhf/1Pdzy
        i6PbBwekw5NKLXDileeLT0AdXQ==
X-Google-Smtp-Source: ABdhPJzmV9YXPB6hCsXZ7URzXPDB7/qCe304q7KRCHJSQjtn7qxPBetED2jKI5U7yWvekiJpr6hFzw==
X-Received: by 2002:a62:4e10:0:b029:1c9:9015:dc5b with SMTP id c16-20020a624e100000b02901c99015dc5bmr21533363pfb.30.1612851783406;
        Mon, 08 Feb 2021 22:23:03 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id gx22sm1155253pjb.49.2021.02.08.22.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:23:02 -0800 (PST)
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
Subject: [PATCH v4 11/14] swiotlb: Add is_dev_swiotlb_force()
Date:   Tue,  9 Feb 2021 14:21:28 +0800
Message-Id: <20210209062131.2300005-12-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add is_dev_swiotlb_force() which returns true if the device has
restricted DMA pool (e.g. dev->dev_swiotlb is set).

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 9 +++++++++
 kernel/dma/swiotlb.c    | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 76f86c684524..b9f2a250c8da 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -73,11 +73,16 @@ extern enum swiotlb_force swiotlb_force;
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 bool is_swiotlb_force(struct device *dev);
+bool is_dev_swiotlb_force(struct device *dev);
 #else
 static inline bool is_swiotlb_force(struct device *dev)
 {
 	return unlikely(swiotlb_force == SWIOTLB_FORCE);
 }
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
 
 bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr);
@@ -93,6 +98,10 @@ static inline bool is_swiotlb_force(struct device *dev)
 {
 	return false;
 }
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f64cbe6e84cc..fd9c1bd183ac 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -841,6 +841,11 @@ bool is_swiotlb_force(struct device *dev)
 	return unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dev_swiotlb;
 }
 
+bool is_dev_swiotlb_force(struct device *dev)
+{
+	return dev->dev_swiotlb;
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.30.0.478.g8a0d178c01-goog

