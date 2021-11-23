Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA145A6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhKWP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbhKWP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85356C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v11so1292388wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQEeEtqyWMKpnKijDTiwXcpp3sArP6LYVWQBTfTX5pw=;
        b=DnORQJb151Y68o1Xq5C1bs+ehBs7egIy8Zf7m9EhobNyNkNltfk9nluQfV6vg+k3af
         erkLDX0T5xUVEXpH5SfY9woZiSaofhLW0KKmsf7S8dCOShjjBwlIh6h9Bg86OM/t9Ys2
         7KUoC8jlteZiEN7JG6PwBNNBv2kBubdv54mskqFP3aA+VlWWZdD6X6xfK3ziJBrOzf0t
         AeMXqPvmhpfwNLuKdrBsRd47bmijs+HtSCPQEjXA5wim33MpmaEy/KwNonOhWvaobqmC
         mNIW0gMTfppFjFp4NdzmviZQSrLvoLeRsA6LvAwHRrHmKIjCkLaG2rk4ezXrAMi6fj7M
         1COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQEeEtqyWMKpnKijDTiwXcpp3sArP6LYVWQBTfTX5pw=;
        b=IwwyCLznmhz0g8NZmrJ8/IOBIDRNXoPZll7hKQY/br8HYU2JSYNte9TgYNhzVVFpIS
         AkwFAsWP97GRbEljmv7b1LX7Z6wdrZsJICl4BJLm5mcyPPuxHXl0dWTtf1IJ0boFLeS+
         DckxuetYoec/EfaETDRWGBXlVZSKbaz+26LtzuTH9ijHYSWNUP8jrMxReiuxyonOFrok
         eEwiZvBv96X1X/88gO3uHTOZ7XQywrx3ggOXVRcFMukKsLmdeneaTYFSKyUdljXkbPH+
         isxCgyt8QyFnlcVKW7ntvrMaAXs2WrDKW2QAG55yI3i9pQjlUK/cnM5ugatJnBSmKI3+
         w67Q==
X-Gm-Message-State: AOAM532v3aTDFw0RTyYa4MSE8b3WGoXpmarUWEnJod0tXXmSUlKU8Xv9
        1cQx2aVmky8jVPCNyc2RXmB3KA==
X-Google-Smtp-Source: ABdhPJxT/I0BtNdu9fjPi/ENgWGb2FgYhYgcB+hKaYupajDlliAWaWM2yGA2SVIFcUq31yQZKtvE0Q==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr8639359wrx.156.1637683000160;
        Tue, 23 Nov 2021 07:56:40 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:39 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com, pasic@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 3/5] iommu/virtio: Sort reserved regions
Date:   Tue, 23 Nov 2021 15:53:00 +0000
Message-Id: <20211123155301.1047943-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ease identity mapping support, keep the list of reserved regions
sorted.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index ee8a7afd667b..d63ec4d11b00 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -423,7 +423,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
-	struct iommu_resv_region *region = NULL;
+	struct iommu_resv_region *region = NULL, *next;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	start = start64 = le64_to_cpu(mem->start);
@@ -454,7 +454,12 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (!region)
 		return -ENOMEM;
 
-	list_add(&region->list, &vdev->resv_regions);
+	/* Keep the list sorted */
+	list_for_each_entry(next, &vdev->resv_regions, list) {
+		if (next->start > region->start)
+			break;
+	}
+	list_add_tail(&region->list, &next->list);
 	return 0;
 }
 
-- 
2.33.1

