Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA83A90BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhFPEoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:44:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7450 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFPEn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:43:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4XWf4nBwzZhgl;
        Wed, 16 Jun 2021 12:38:54 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 12:41:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 12:41:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
Subject: [PATCH -next 3/3] usb: host: xhci-tegra: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 16 Jun 2021 12:45:19 +0800
Message-ID: <20210616044519.2183826-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616044519.2183826-1-yangyingliang@huawei.com>
References: <20210616044519.2183826-1-yangyingliang@huawei.com>
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

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/host/xhci-tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 8d8e867876ad..575fa89a783f 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1422,8 +1422,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tegra->regs = devm_ioremap_resource(&pdev->dev, regs);
+	tegra->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
 
-- 
2.25.1

