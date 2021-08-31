Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B023FC464
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhHaIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:38:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14440 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbhHaIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:38:04 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GzL6x5NG3zbfyZ;
        Tue, 31 Aug 2021 16:33:13 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 16:37:08 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 31 Aug
 2021 16:37:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <hminas@synopsys.com>
Subject: [PATCH -next] usb: dwc2: check return value after calling platform_get_resource()
Date:   Tue, 31 Aug 2021 16:42:36 +0800
Message-ID: <20210831084236.1359677-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will cause null-ptr-deref if platform_get_resource() returns NULL,
we need check the return value.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/dwc2/hcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2a7828971d05..a215ec9e172e 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5191,6 +5191,10 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 	hcd->has_tt = 1;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		retval = -EINVAL;
+		goto error1;
+	}
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
-- 
2.25.1

