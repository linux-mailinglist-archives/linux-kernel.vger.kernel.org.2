Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439DD3068BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhA1Akn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhA1AjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:39:24 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:43 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y16so2379352pfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=4W4Mz7FARh9nT3HFppHTQnTZcP4AiXiO2tmblYeh7WE=;
        b=Eb4iPku8cZ0Vn7Ei3aQgJpwqmbI/1Jr3DYPfQ13tzINxjrf9Ulm40ki5zV8pC9Yap9
         Yyx8MrkyRbwP9IyEhZZDYoXDExVmMYlIO4/QGrvet29VCDBr8Fo5W0XG1xpkCGb9O04K
         xPmVNDYGnaIhJadfgRiSdMkQKEL5jhQvVV+lnkcKlMlTnrSZc32FxCZ/3//vMJGZNUOj
         mRLa6hTfO8o/ei9CRZnNDxeT6NAfg8gLjKprLbSIk6CeI+rj6RW0JrVknZEcq2liQnb4
         F90qbiiR8ek5wnxSA8hUomCWoPKIyyueIiGtYwSWRTLU00HKIXkQSrTuuOtjJnqopyl3
         fZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=4W4Mz7FARh9nT3HFppHTQnTZcP4AiXiO2tmblYeh7WE=;
        b=c7lT7QBvWX5fBrX6lFkINURNFEvLEhML5lJfcQpXnmKuiHw/e/YY/Iu42iTO2bO/bA
         BfZ9jY9k1UdRckxglpKrU8jCVegQSgGCZ4xNZPRz22QGOcYhV2uSlt1o3FPqawaqAYdB
         otOlhHMeUmQQwanBz2hK+q1rmQrnl3gnNx7fOLFHrHMWBpAXXKPMSWz6HKna98pKt3Sx
         Apd3CF3wDwzwD5QE7B4gMXkDnkjo+5hgG/041Y4weF02+YXvnUC+rOyF6NRisSOctfq2
         lNHqxpL4Kg0LQIVdIxbmm1mWpXeEUUpq+lA+6z0GKOz1am45iLdK8o4/13VYwWG8/iVW
         bnxA==
X-Gm-Message-State: AOAM532O/MxKAkQLu7bnPiryGpQwNwraSxSFS35Rhax/lirDd/3boDIN
        RTOmGh1VDEvk15bUpzTm9wDod6a6gw==
X-Google-Smtp-Source: ABdhPJxLTPQsZ3ALIjHtj1aD58QbrBkOE/Y0s5GW7Sn3xRBoflafftwJdJ89PE1InRUmNhSb23g5V+c0sg==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a05:6a00:851:b029:1b3:fbb3:faed with SMTP id
 q17-20020a056a000851b02901b3fbb3faedmr13331958pfk.18.1611794323323; Wed, 27
 Jan 2021 16:38:43 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:38:27 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-2-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
From:   Jianxiong Gao <jxgao@google.com>
To:     jxgao@google.com, erdemaktas@google.com, marcorr@google.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices rely on the address offset in a page to function
correctly (NVMe driver as an example). These devices may use
a different page size than the Linux kernel. The address offset
has to be preserved upon mapping, and in order to do so, we
need to record the page_offset_mask first.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1779f90eeb4c..f44e0659fc66 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -292,6 +292,7 @@ struct device_dma_parameters {
 	 */
 	unsigned int max_segment_size;
 	unsigned long segment_boundary_mask;
+	unsigned int page_offset_mask;
 };
 
 /**
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f39..5529a31fefba 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline unsigned int dma_get_page_offset_mask(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->page_offset_mask;
+	return 0;
+}
+
+static inline int dma_set_page_offset_mask(struct device *dev,
+		unsigned int page_offset_mask)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->page_offset_mask = page_offset_mask;
+		return 0;
+	}
+	return -EIO;
+}
+
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
-- 
2.27.0

