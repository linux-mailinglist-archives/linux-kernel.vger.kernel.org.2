Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75994311BAB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhBFFsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBFFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 00:48:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A09C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 21:47:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 8so4633717plc.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 21:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAE/HnEoeH/I6AsDCMIiIUVtpfPBxI4oEAjjMlMZGXc=;
        b=ZfBYm49eLFIQVfzYokXITH5vfeUno9/jvuNet9pJQuW3syR/+XH3/YZk7qYsGlaarI
         Av8bjd9ybfZ2NrBbkKoH6TkHKgDOozMgh5AfXNz2vBQO/CjBCUCqnALvXpYGfT4saEch
         /9wCs2JEHatTpiiTbSS0/jeDneToQGX/UbC/riRDR9KDRuze2GzoJovxK+sDxxU3D58G
         e6dBr1bcw9JY0uhHo7cPlIcQKBZT5TBvifUlt8hsQ+C5nQX5APkE6jPwT6fKeY5Wkcw1
         Cy44UKqKF6aOMe5F/BWJyDL454r9LYEwH4Vtz9CEhfiKHMks6kN+2bQt3ndo/gu0Myi9
         yXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAE/HnEoeH/I6AsDCMIiIUVtpfPBxI4oEAjjMlMZGXc=;
        b=kndeWafMR3FWt5PO9xkAbz9IViPbJyKNUVQ9LqKMOf9Kaqo54xj0V/g0E7jgxgyWAX
         1MRyj1Bb0ZtnbJwv7NsULMkm4Ze//zKJmlvcnsOIpvHmOqXoNbrZSVJOC8SFgVX9qmju
         1bAkhcwHhQMaV+kodBsOc4ZM64wj/l8WZBIVDsVTWC7sf/kVV6QDOFTa304eckvxWWY4
         d7GGOP7BBLRSGiNvxRL3w2xBtswEcqnP1H+wg1npLoVe8JFDYn0sfW3YCVum5dUuSzqM
         VRPYB1LZB+kyapD1An9fyP0w9Xuz2CtNZe2H5yo/vxBV488Iabjc1uR/AN7ngXTBLP8a
         LTAA==
X-Gm-Message-State: AOAM532Kd+gh2+Fm+joqhXlZDueyGW1V9i01x/9d9rGIlU9wTzKKN8zT
        /t/yXkB4+HlfdEBgBzSdMveqlbMkr8xo5g==
X-Google-Smtp-Source: ABdhPJy2np2futESbWx4VSlBPWGsf9xnPAKiXfTrc46U4XfKehlJZOZJ93yJOyYV7fxA8/jLvmM9vw==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr7553358pjb.199.1612590472244;
        Fri, 05 Feb 2021 21:47:52 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id ob6sm9200211pjb.30.2021.02.05.21.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 21:47:51 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 1/2] dma-buf: dma-heap: Provide accessor to get heap name
Date:   Sat,  6 Feb 2021 05:47:47 +0000
Message-Id: <20210206054748.378300-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to access the name for the heap,
so provide an accessor to do so.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/dma-heap.c | 13 +++++++++++++
 include/linux/dma-heap.h   |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index afd22c9dbdcf..6c746ea67676 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -190,6 +190,19 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 	return heap->priv;
 }
 
+
+/**
+ * dma_heap_get_name() - get heap name
+ * @heap: DMA-Heap to retrieve private data for
+ *
+ * Returns:
+ * The char* for the heap name.
+ */
+char *dma_heap_get_name(struct dma_heap *heap)
+{
+	return heap->name;
+}
+
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 454e354d1ffb..b91778291fb1 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -50,6 +50,15 @@ struct dma_heap_export_info {
  */
 void *dma_heap_get_drvdata(struct dma_heap *heap);
 
+/**
+ * dma_heap_get_name() - get heap name
+ * @heap: DMA-Heap to retrieve private data for
+ *
+ * Returns:
+ * The char* for the heap name.
+ */
+char *dma_heap_get_name(struct dma_heap *heap);
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info:		information needed to register this heap
-- 
2.25.1

