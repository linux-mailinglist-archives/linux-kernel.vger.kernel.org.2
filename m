Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A066A3827E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhEQJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbhEQJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4EFC061761
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q2so4474519pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWj877rAOrsZYk/58hMDg838A54wH0O9Rz7I1WQ+XlI=;
        b=tbpwHs/YPzFSMIpuO/dIVZrkP2CkLy8pAXBbgocVUys2hOUT0iZLdhc4EYmmk8bTyY
         yt6KadCd85UJlZr3Sx8D9v5AJXODYRmG2ncvAndEDM/0rnEDw1loT5Bw0HQEozOtg0Zv
         dAUeMLb9ZjDVhfbPot24KKe1IwP4SrSOXMZI5IYK42srknrN2Udu5qsdseWRnwYdrNe7
         QmrkkSqa03vqQWd2e8TjP28Y/v7K9cJ9JAJp8Vvy/Sqw3bLLJ+XykTKSgecqOtXSWRWu
         dyh0Gl03GGMIwD+63O4ok+vS9lB9ezi7dVRvyoChBpgerx2BdW0fEB6QB651o1XINI56
         2Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWj877rAOrsZYk/58hMDg838A54wH0O9Rz7I1WQ+XlI=;
        b=m1MG1bo1XfcJT2nQ3ZQ2P56lTuSWXaiRPLqBH8dmFiOznNFY5UjE+IFM8Kbl65OMlT
         6S5zeo9jiOtROMtkJfVcIP/cHI+pBSdLEB4zh5jXEVm6IuGyTFUJ1TK/wZygLQC/It20
         +iV/229XaqpdFC+mMSDv87mXO5MbT1RIA5n99JcfUB5Qi6Z8Ihladne2tjOAXr+ZCSwN
         QkhvRk3qLWvkNFjPhmFvYdPj7EHYk11QE4rJbPQmiRF84/JyJL12oEh8VBYGQ8ST0xkM
         Awws1nrEmd9jCKxKFky/WNhbG6aXbrPGE/H5FYPMfvSKRmJpZCnzIXnof0pYGLnXOJbM
         hLfA==
X-Gm-Message-State: AOAM532hNEkTVcT+sZZqlzIN6zxF6fXqoqNR5s8aqUv5XDX/RlpYtYIk
        lASGyYImmgcb4PBchJ3EOve4
X-Google-Smtp-Source: ABdhPJySGk8vPzj0Rm8EX1Z6t/75hBLp/uJPfLtkGdjb6qw/wjnkGvf5I1kGRoXNxf3S50AxrVbBxQ==
X-Received: by 2002:a63:1d1f:: with SMTP id d31mr7417505pgd.199.1621242574360;
        Mon, 17 May 2021 02:09:34 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id q24sm10115555pjp.6.2021.05.17.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:33 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/17] virtio_pmem: Remove unused used length
Date:   Mon, 17 May 2021 17:08:28 +0800
Message-Id: <20210517090836.533-10-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used. Let's drop it and
pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..f57d7663b505 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -15,10 +15,9 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 	struct virtio_pmem *vpmem = vq->vdev->priv;
 	struct virtio_pmem_request *req_data, *req_buf;
 	unsigned long flags;
-	unsigned int len;
 
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
-	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
+	while ((req_data = virtqueue_get_buf(vq, NULL)) != NULL) {
 		req_data->done = true;
 		wake_up(&req_data->host_acked);
 
-- 
2.11.0

