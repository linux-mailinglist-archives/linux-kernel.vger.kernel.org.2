Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DEE3AE132
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 02:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFUAnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 20:43:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5407 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFUAnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 20:43:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G7Vwz65Svz72CY;
        Mon, 21 Jun 2021 08:37:39 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 08:40:53 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 08:40:52 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Alexandru Vasile <lexnv@amazon.com>,
        "Alexandru Ciobotaru" <alcioa@amazon.com>
Subject: [PATCH v2] nitro_enclaves: Set Bus Master for the NE PCI device
Date:   Mon, 21 Jun 2021 08:40:46 +0800
Message-ID: <20210621004046.1419-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Bus Master for the NE PCI device, according to the PCI spec
for submitting memory or I/O requests:

 Master Enable – Controls the ability of a PCI Express
  Endpoint to issue Memory and I/O Read/Write Requests, and
  the ability of a Root or Switch Port to forward Memory and
  I/O Read/Write Requests in the Upstream direction

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andra Paraschiv <andraprs@amazon.com>
Cc: Alexandru Vasile <lexnv@amazon.com>
Cc: Alexandru Ciobotaru <alcioa@amazon.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
Changes since v1:
  - update the commit message. [Andra]
---
 drivers/virt/nitro_enclaves/ne_pci_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index b9c1de4..143207e 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -480,6 +480,8 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free_ne_pci_dev;
 	}
 
+	pci_set_master(pdev);
+
 	rc = pci_request_regions_exclusive(pdev, "nitro_enclaves");
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Error in pci request regions [rc=%d]\n", rc);
-- 
1.8.3.1

