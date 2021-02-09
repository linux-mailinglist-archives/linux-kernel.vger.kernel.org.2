Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE023159B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhBIWvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhBITtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:49:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04732C061A2A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:48:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx20so2307317pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afF2pHGG502t/84V5YNHmCiVWiQMRNdlEkUy2NZuKx8=;
        b=yRaJ+PJ+E44+mqB5LJcQUiR6volXPqvWk7B54rrcPwNuggp7DXthL43qFxwiJaIthR
         HStcVglg8xIqrW9BKyqY4zPS+KQ0Ooh89+0ENhwQP/mK/2f/dJkzbd0fjdZhCmnkeTXo
         zrtDpP/gAUVndHlTx7IIiuhwXwmlOFXBS7Bp/wO0+I2Qwc/ntb7r3kP5blH+FynCJPxW
         v/M0ClZzR6U0x6nA2IolnjcozeqdJh+39gOMTpMFIaVj+ga+r7/IJCccxiPETvn5thso
         CvDoN0CfebHTczcBATJwgu0i8jhadc+FJUgjcdcpw6+/P9dFdvZFH4xBDmtKhcs++J9/
         i/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afF2pHGG502t/84V5YNHmCiVWiQMRNdlEkUy2NZuKx8=;
        b=qrMRonTcO1fg133+N8R2OYIBI6lNc7xAuD4eECiYFOqjUzGJi+rOa4jvRsZUXtbTvj
         AzLs4TmFqOigvqkMsDfM+OkHvph6nIPOTq8RIHpzIcVyRUffVj+iaEGkert6vTbby70w
         p1z1nY5Oq4dKCQW940X1kF9gBh3z24yVqwl+q4AOrNIJnBVn3gwdxdwHOd6E1vA5J+BV
         w68Szfvk8BGgtyA7tv+pcSf7nuLp15DBB3n0FqWjayd7i1T05ZBn7c18ql0NbDAoPs+t
         +i/wcRcJNgyQ+cIiBUmzUB6PT3xCaBIVVC7bu+Kh7bZjKxNuzK2xGaauOXHVdXEps1Jm
         WvoA==
X-Gm-Message-State: AOAM532KEnM3g5pP/CooHydZo1cvIe///uC3AVCevIVme+SckvdLBTB1
        IoY+mpIbv6rElcB63oOXwp56WCNX0/tpDQ==
X-Google-Smtp-Source: ABdhPJykD/cVLPq3p06Nm/JMKvPVGXYlG9cVWzIEFPq4tJeqUZX+9Dn/vzf27apxe3n4hL48CaR0Sw==
X-Received: by 2002:a17:90a:4588:: with SMTP id v8mr5562008pjg.58.1612900105090;
        Tue, 09 Feb 2021 11:48:25 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j17sm22365836pfh.183.2021.02.09.11.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:48:24 -0800 (PST)
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
Subject: [PATCH v2 1/2] dma-buf: dma-heap: Provide accessor to get heap name
Date:   Tue,  9 Feb 2021 19:48:17 +0000
Message-Id: <20210209194818.2459062-1-john.stultz@linaro.org>
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
v2:
* Make sure to use "const char *" as Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/dma-buf/dma-heap.c | 12 ++++++++++++
 include/linux/dma-heap.h   |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index afd22c9dbdcf..70e410c64c1c 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -190,6 +190,18 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 	return heap->priv;
 }
 
+/**
+ * dma_heap_get_name() - get heap name
+ * @heap: DMA-Heap to retrieve private data for
+ *
+ * Returns:
+ * The char* for the heap name.
+ */
+const char *dma_heap_get_name(struct dma_heap *heap)
+{
+	return heap->name;
+}
+
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 454e354d1ffb..83b8cfb2d760 100644
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
+const char *dma_heap_get_name(struct dma_heap *heap);
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info:		information needed to register this heap
-- 
2.25.1

