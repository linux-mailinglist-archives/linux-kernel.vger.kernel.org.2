Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ADE3AB5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhFQO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:29:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8263 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhFQO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:29:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5PQQ1hjlz1BNTN;
        Thu, 17 Jun 2021 22:22:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 22:27:15 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 22:27:15 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <pawell@cadence.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: cdnsp: fix error return code in cdnsp_alloc_priv_device()
Date:   Thu, 17 Jun 2021 22:31:03 +0800
Message-ID: <20210617143103.2175477-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cdnsp_ring_alloc() fails, cdnsp_alloc_priv_device() need return
error code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/cdns3/cdnsp-mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index a47948a1623f..c87bf3513844 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -694,8 +694,10 @@ static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev)
 
 	/* Allocate endpoint 0 ring. */
 	pdev->eps[0].ring = cdnsp_ring_alloc(pdev, 2, TYPE_CTRL, 0, GFP_ATOMIC);
-	if (!pdev->eps[0].ring)
+	if (!pdev->eps[0].ring) {
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	/* Point to output device context in dcbaa. */
 	pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
-- 
2.25.1

