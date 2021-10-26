Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BA843B348
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhJZNmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:42:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14866 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJZNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:42:03 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HdtGW3JsZz90Th;
        Tue, 26 Oct 2021 21:39:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 26 Oct 2021 21:39:30 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 21:39:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <jasowang@redhat.com>, <mst@redhat.com>
Subject: [PATCH -next] virtio-pci: fix error return code in vp_legacy_probe()
Date:   Tue, 26 Oct 2021 21:47:25 +0800
Message-ID: <20211026134725.345020-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error code if pci_iomap() fails in vp_legacy_probe()

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: c3ca8a3eeb54 ("virtio-pci: introduce legacy device module")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/virtio/virtio_pci_legacy_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
index 9b97680dd02b..4ca3ef38d3bf 100644
--- a/drivers/virtio/virtio_pci_legacy_dev.c
+++ b/drivers/virtio/virtio_pci_legacy_dev.c
@@ -45,8 +45,10 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
 		return rc;
 
 	ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
-	if (!ldev->ioaddr)
+	if (!ldev->ioaddr) {
+		rc = -ENOMEM;
 		goto err_iomap;
+	}
 
 	ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
 
-- 
2.25.1

