Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA33A8FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFPDv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:51:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10083 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhFPDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:51:21 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4WLz21QRzZfSk;
        Wed, 16 Jun 2021 11:46:19 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.62) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 11:49:14 +0800
From:   Yu Jiahua <yujiahua1@huawei.com>
To:     <alcooperx@gmail.com>, <gregkh@linuxfoundation.org>,
        <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Yu Jiahua <yujiahua1@huawei.com>
Subject: [PATCH -next] drivers: usb: add missing MODULE_DEVICE_TABLE definition in brcmstb-usb-pinmap.c
Date:   Tue, 15 Jun 2021 19:50:03 -0800
Message-ID: <20210616035003.38149-1-yujiahua1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.62]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Signed-off-by: Yu Jiahua <yujiahua1@huawei.com>
---
 drivers/usb/misc/brcmstb-usb-pinmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/brcmstb-usb-pinmap.c b/drivers/usb/misc/brcmstb-usb-pinmap.c
index b3cfe8666ea7..cbc958355359 100644
--- a/drivers/usb/misc/brcmstb-usb-pinmap.c
+++ b/drivers/usb/misc/brcmstb-usb-pinmap.c
@@ -331,6 +331,7 @@ static const struct of_device_id brcmstb_usb_pinmap_of_match[] = {
 	{ .compatible = "brcm,usb-pinmap" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, brcmstb_usb_pinmap_of_match);
 
 static struct platform_driver brcmstb_usb_pinmap_driver = {
 	.driver = {
-- 
2.17.1

