Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11383F8131
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 05:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhHZDiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 23:38:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15217 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhHZDiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:38:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gw7n35vNFz19Vdw
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:36:39 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 11:37:13 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 26 Aug
 2021 11:37:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ben.widawsky@intel.com>
Subject: [PATCH -next] tools/testing/cxl: Fix error return code in cxl_test_init()
Date:   Thu, 26 Aug 2021 11:42:52 +0800
Message-ID: <20210826034252.3373142-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return a negative error code when platform_device_alloc() or
alloc_memdev() fail.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 tools/testing/cxl/test/cxl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 314b09d40333..92735e2e7146 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -472,8 +472,10 @@ static __init int cxl_test_init(void)
 		struct platform_device *pdev;
 
 		pdev = platform_device_alloc("cxl_host_bridge", i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_bridge;
+		}
 
 		mock_companion(adev, &pdev->dev);
 		rc = platform_device_add(pdev);
@@ -490,8 +492,10 @@ static __init int cxl_test_init(void)
 		struct platform_device *pdev;
 
 		pdev = platform_device_alloc("cxl_root_port", i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_port;
+		}
 		pdev->dev.parent = &bridge->dev;
 
 		rc = platform_device_add(pdev);
@@ -508,8 +512,10 @@ static __init int cxl_test_init(void)
 		struct platform_device *pdev;
 
 		pdev = alloc_memdev(i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_mem;
+		}
 		pdev->dev.parent = &port->dev;
 
 		rc = platform_device_add(pdev);
@@ -521,8 +527,10 @@ static __init int cxl_test_init(void)
 	}
 
 	cxl_acpi = platform_device_alloc("cxl_acpi", 0);
-	if (!cxl_acpi)
+	if (!cxl_acpi) {
+		rc = -ENOMEM;
 		goto err_mem;
+	}
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
-- 
2.25.1

