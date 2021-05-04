Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABC372713
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhEDIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229872AbhEDIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620116460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMP1xx5RM3W39LPjwsE6CWlx07bFQEOIwnlzCme4Sl4=;
        b=ASAKeVCpqA2IHOK5TWmUTc2lmSGpMKZ9Cah3GoH9d2HdE0Nf18dpVlwTXbp9CzMB7KWWhs
        V7UmKUIdY3OEHhsGPY3p31H0xNRxZCRkn1HBxAxowl1WOb+nrVK/dmVXjbq3+5efCepPRj
        1vgb53y0Z3kJEx9/IQKwxFD84IAbuqA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-_hzC5RdpMP-VF3tosaZEIw-1; Tue, 04 May 2021 04:20:59 -0400
X-MC-Unique: _hzC5RdpMP-VF3tosaZEIw-1
Received: by mail-wm1-f70.google.com with SMTP id j128-20020a1c55860000b02901384b712094so159585wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 01:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMP1xx5RM3W39LPjwsE6CWlx07bFQEOIwnlzCme4Sl4=;
        b=ZpDKcCg3XTSKGSo441fj6ubCviTlKZX27FB6w1EZCMGfWt5VJPzPDZ8uLcvodKCo4W
         +FoHLdv/HjGct4+8rnp2Vfj3BtCYfhBKCLvDXoSMx3n0KffkY1mdu29XyKAlWBzhiuFY
         WeKsE1cJXWm9fc6O2KkCINTmsfuW6n52qgz7rmbwrd4tc0Ko9ZWV8705XdzjlGewlJbw
         pSZX8Zva1kDbDDOZYfBVp3mZftCMQcyVdjweD4wfGDYRYWLtXxm9/sRhFMP6iPj135Nj
         gFLsBumE177os0C00a/iTtDYgLLH/0lYDUyMG859w6/R8uOGH82469Zki7PD4BwL9aMa
         tl0w==
X-Gm-Message-State: AOAM53101wuEWT9NRu/YMSiSAS/pseRJKMG/VawyXMlAJs6f3OS6f2w+
        seVoAsVJXim5fqVnd81OFC/cI9vfJo/QAzI/qB2F7tIimNKjOo3FGK++5VGN0214Sl1d6DugSDq
        ldntOBl6WqUel3G3SdiSrhlzmCSyJB2jD1bsTSjCdYX/cOz/NZfRPwEpJDeeMfkOrQmlBQQ==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr2604821wma.144.1620116458276;
        Tue, 04 May 2021 01:20:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTbu5ekU7D/8mrl31/CpdYXkrj1VnJHihiA9z9xrr3YZFmIJDwfjFftMechzR6ujZAAVINxg==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr2604801wma.144.1620116457988;
        Tue, 04 May 2021 01:20:57 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id l66sm1845078wmf.20.2021.05.04.01.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 01:20:57 -0700 (PDT)
Date:   Tue, 4 May 2021 04:20:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] virtio_pci_modern: correct sparse tags for notify
Message-ID: <20210504082034.118581-2-mst@redhat.com>
References: <20210504082034.118581-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504082034.118581-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching virtio_pci_modern to use a helper for mappings we lost an
__iomem tag. Restore it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9e3bb9b79a71 ("virtio_pci_modern: introduce helper to map vq notify area")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 9 ++++-----
 include/linux/virtio_pci_modern.h      | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index ae87b3fa8858..54f297028586 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -605,8 +605,8 @@ static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
  *
  * Returns the address of the notification area
  */
-void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
-			      u16 index, resource_size_t *pa)
+void __iomem *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+				      u16 index, resource_size_t *pa)
 {
 	u16 off = vp_modern_get_queue_notify_off(mdev, index);
 
@@ -624,10 +624,9 @@ void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
 		if (pa)
 			*pa = mdev->notify_pa +
 			      off * mdev->notify_offset_multiplier;
-		return (void __force *)mdev->notify_base +
-			off * mdev->notify_offset_multiplier;
+		return mdev->notify_base + off * mdev->notify_offset_multiplier;
 	} else {
-		return (void __force *)vp_modern_map_capability(mdev,
+		return vp_modern_map_capability(mdev,
 				       mdev->notify_map_cap, 2, 2,
 				       off * mdev->notify_offset_multiplier, 2,
 				       NULL, pa);
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index cdfabbefacdf..6a95b58fd0f4 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -101,8 +101,8 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
 u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
-void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
-                              u16 index, resource_size_t *pa);
+void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+				       u16 index, resource_size_t *pa);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
 void vp_modern_remove(struct virtio_pci_modern_device *mdev);
 #endif
-- 
MST

