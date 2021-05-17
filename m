Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3038286C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhEQJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhEQJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 69so2813123plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/2QVLOgD3QaECJTrTbM5k9jGDLwf7tpQ1pOJ5OD/EE=;
        b=J8WKLVJPuIGApBZ19Vy0+KOxNbJePFdwLgt/apjbNlexgh0rnIQ96o/Z8EszBAhXfy
         KVZY3iDlpRDmE5u+fkb54PrTs0f+/FW1hUNORDD6hoNygUnCA0Lio0wXdaeQKBnoYM5u
         +tZNH+R4NC/hSNJnXqr1UUMpAy3EH2rJZbP5ps/GvXxRCnA4GIK54q8BFR/M6L5id9DO
         NcfB8hXGgfXGdZkYobI+Moi+co07EFq1sWPXgs6mEw87BvzoBZQRPiHFerKS6bT4X4qn
         S+E3MJqal+G2UrtOHTbRuKiH1E2rmTqWYOXgG/x5rsGll6ft8lw+2AWLhQde981GEwLe
         bkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/2QVLOgD3QaECJTrTbM5k9jGDLwf7tpQ1pOJ5OD/EE=;
        b=o1Hnvtt/Z1oMN9zq/1yi9rkOE4QV5yFMuyGt1h/yMXEP+A3PUiqR1bB08me39CeV7d
         Tw9TkuhsBvEbdXmGnARpaVWjgvGsq10kTwKAVCRjWyNRtRr8oktWpor4IdqCOelDVdnm
         K88aysLAwQlFdj/iCIlUHFVvBd+wsPU3Lt379+VewVSdpy5oCczDZNHncd22Pu4uhCGa
         ilg8DB1fWW4uAsH2Q9m4bQSGARAl0d6tzPUYv/DHAf5jtxpDqLuRvdKbI8H4HOafXwwp
         K6uRFfM6nSYuhX5O/g7/frBPw+jsy6aMEl6bxKDC3h1VY8n4FZUUrdu9boOZCHhlzl0R
         eggQ==
X-Gm-Message-State: AOAM533c+BWcyPXaTcB+fkyJeYJCk2slPjQGjW4amCIzyQEgoPaTcTp0
        tpMySLK5vs2/S7f/btiN/dvq
X-Google-Smtp-Source: ABdhPJzxvdEKnkmaiK6byC1OQ5/ZkFXnOmEQvAxi/hz9alutu/dNmJgGl8lPmUsRDJeicWH7glRB3A==
X-Received: by 2002:a17:90a:a10e:: with SMTP id s14mr25512814pjp.61.1621244118022;
        Mon, 17 May 2021 02:35:18 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id c6sm9374376pfo.192.2021.05.17.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:17 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/15] virtio-iommu: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:19 +0800
Message-Id: <20210517093428.670-7-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case on probe.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/iommu/virtio-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 2bfdd5734844..0d4840c5841a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1053,7 +1053,9 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
 
-	virtio_device_ready(vdev);
+	ret = virtio_device_ready(vdev);
+	if (ret)
+		goto err_free_vqs;
 
 	/* Populate the event queue with buffers */
 	ret = viommu_fill_evtq(viommu);
-- 
2.11.0

