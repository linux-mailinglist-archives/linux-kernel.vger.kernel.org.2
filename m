Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E132030AF74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhBASeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhBASbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:31:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:30:23 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 18so12049335pgp.22
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=dv/wJr+V9NRV+lolRhI4CVLaEjJrVVBI8C3cibP+WBU=;
        b=Lj3UyKxA8lOIDGcPlpqgpnIQ+ae5rtq8GZJ3tw2mo4cgWWi5PDLt0PQL1ceiR7DkDT
         fsn7U8UN+bqxxlHbLikEDWaglidRgQkkFYiDgTHcsS82JHwwx7gJtiYdyllzS5oNcaWC
         Eg/jeZpIVEEtoFwS/sAagES8+4KsAUqFWJauvb3OSw+rWHAxuwBZDOO2pzJYGxTwRa3i
         6b9k7zhAfI8DOS7uaEO/5PWyeY3tCZ/Y8/padIigVO7e+pLSphaeaBtA4lxv18bUw0Hb
         T0XuC3AQhuA5yRyaXcr1PL8TRMjE6yZNayj7+MSPQdQWYa+Q1XTmQ8XLb4lcAkkwvub7
         l3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=dv/wJr+V9NRV+lolRhI4CVLaEjJrVVBI8C3cibP+WBU=;
        b=MId8brGbxbkK6SAZgDDIztX3DniJ1RATQNkvRgeFh/H9cuLaU+u+M49v1uQDVUGU1s
         pjOIgIWyfVO64G64Y1m/kXKPtu9pwBEBqK/paFRVQMuyht6WQ49UbO2dG9Vfx1U29ReV
         4P6xSSP6QNCPcYes/Ecz8cQBt29lkdc0r9tyWUpAwOaBz+Itlckv/b1gipFvHV3m37o6
         wywXyzD4C5as38yRFjCLchPXp5X68J0k9MrBrCCmUPdtzXp/qdZNKzsR9pnAdzRlu/1y
         asoY5X229IrtlBAkQtVr3Z5xVOBjyD9MTpZmTVgt4Co9qZAkIFGUM7cJ+0WbCw259aw8
         fWkw==
X-Gm-Message-State: AOAM533qIbWEL/9eOeApvAxkwltW6YFkr979rbjbGgz6RNm2Km6ItULJ
        jOZsCM8eOK+Q3T8YLRlvoL4Ke3zpCQ==
X-Google-Smtp-Source: ABdhPJyh03Hh5IPZa/NXKVXEfxYK+v8U+Q/6t0H4LGYsfl6XIq6w4GCzICateDGeGMpAGtpLIcmYglBU8Q==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:90a:d58a:: with SMTP id
 v10mr196883pju.9.1612204223378; Mon, 01 Feb 2021 10:30:23 -0800 (PST)
Date:   Mon,  1 Feb 2021 10:30:15 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-2-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 1/3] Adding page_offset_mask to device_dma_parameters
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
index 1779f90eeb4c..7960bf516dd7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -291,6 +291,7 @@ struct device_dma_parameters {
 	 * sg limitations.
 	 */
 	unsigned int max_segment_size;
+	unsigned int min_align_mask;
 	unsigned long segment_boundary_mask;
 };
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f39..27ec3cab8cbd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline unsigned int dma_get_min_align_mask(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->min_align_mask;
+	return 0;
+}
+
+static inline int dma_set_min_align_mask(struct device *dev,
+		unsigned int min_align_mask)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->min_align_mask = min_align_mask;
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

