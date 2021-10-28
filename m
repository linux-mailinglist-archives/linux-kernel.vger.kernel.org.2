Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37D43DDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhJ1JfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:35:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14871 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhJ1JfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:35:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hg0ht4hjYz90Vh;
        Thu, 28 Oct 2021 17:32:46 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 17:32:50 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 17:32:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH -next] staging: r8188eu: fix missing unlock in rtw_resume()
Date:   Thu, 28 Oct 2021 17:40:38 +0800
Message-ID: <20211028094038.2877341-1-yangyingliang@huawei.com>
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

Add the missing unlock before return from rtw_resume().

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 6b93830130e7..5a35d9fe3fc9 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -298,8 +298,10 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 		pwrpriv->bkeepfwalive = false;
 
 	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
-	if (pm_netdev_open(pnetdev, true) != 0)
+	if (pm_netdev_open(pnetdev, true) != 0) {
+		mutex_unlock(&pwrpriv->lock);
 		goto exit;
+	}
 
 	netif_device_attach(pnetdev);
 	netif_carrier_on(pnetdev);
-- 
2.25.1

