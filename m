Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEF34E82A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhC3M7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:59:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14637 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhC3M7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:59:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8qFx03Vfzmbqt;
        Tue, 30 Mar 2021 20:56:37 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:59:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>
Subject: [PATCH -next] USB: gadget: udc: fix wrong pointer passed to IS_ERR() and PTR_ERR()
Date:   Tue, 30 Mar 2021 21:01:59 +0800
Message-ID: <20210330130159.1051979-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ERR() and PTR_ERR() use wrong pointer, it should be
udc->virt_addr, fix it.

Fixes: 1b9f35adb0ff ("usb: gadget: udc: Add Synopsys UDC Platform driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/gadget/udc/snps_udc_plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 32f1d3e90c26..99805d60a7ab 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -114,8 +114,8 @@ static int udc_plat_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	udc->virt_addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(udc->regs))
-		return PTR_ERR(udc->regs);
+	if (IS_ERR(udc->virt_addr))
+		return PTR_ERR(udc->virt_addr);
 
 	/* udc csr registers base */
 	udc->csr = udc->virt_addr + UDC_CSR_ADDR;
-- 
2.25.1

