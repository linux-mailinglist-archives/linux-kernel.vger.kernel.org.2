Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3172D3970B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhFAJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:55:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2821 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFAJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:55:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvS6Z2K3dzWnXr;
        Tue,  1 Jun 2021 17:49:10 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:53:51 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:53:51 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next] usb: isp1760: Fix meaningless check in isp1763_run()
Date:   Tue, 1 Jun 2021 18:03:11 +0800
Message-ID: <20210601100311.70200-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a meaningless check in isp1763_run. According to the
similar implement in isp1760_run, the proper check should remove
retval = 0;

Fixes: 60d789f3bfbb ("usb: isp1760: add support for isp1763")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 016a54ea76f4..27168b4a4ef2 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -1648,7 +1648,6 @@ static int isp1763_run(struct usb_hcd *hcd)
 	down_write(&ehci_cf_port_reset_rwsem);
 	retval = isp1760_hcd_set_and_wait(hcd, FLAG_CF, 250 * 1000);
 	up_write(&ehci_cf_port_reset_rwsem);
-	retval = 0;
 	if (retval)
 		return retval;
 
-- 
2.18.0.huawei.25

