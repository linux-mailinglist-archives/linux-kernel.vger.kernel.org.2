Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059FD3A90B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFPEng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:43:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4927 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhFPEnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:43:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4XVv5c1Dz6yrv;
        Wed, 16 Jun 2021 12:38:15 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 12:41:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 12:41:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
Subject: [PATCH -next 2/3] usb: host: xhci-tegra: Add missing of_node_put() in tegra_xusb_probe()
Date:   Wed, 16 Jun 2021 12:45:18 +0800
Message-ID: <20210616044519.2183826-2-yangyingliang@huawei.com>
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

This node pointer is returned by of_parse_phandle() with refcount
incremented in this function. of_node_put() on it before exitting
this function.

Fixes: 971ee247060d ("usb: xhci: tegra: Enable ELPG for runtime/system PM")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/host/xhci-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 281abf10f9fd..8d8e867876ad 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1751,6 +1751,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 put_powerdomains:
 	tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
 put_padctl:
+	of_node_put(np);
 	tegra_xusb_padctl_put(tegra->padctl);
 	return err;
 }
-- 
2.25.1

