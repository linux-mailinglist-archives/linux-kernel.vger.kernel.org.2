Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41D381882
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhEOLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 07:51:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2666 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhEOLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 07:51:00 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fj3Wb10FvzNyXh;
        Sat, 15 May 2021 19:46:19 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 15 May 2021 19:49:45 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 15
 May 2021 19:49:44 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2] usb: xhci: Check the return value from sg_pcopy_from_buffer
Date:   Sat, 15 May 2021 19:57:15 +0800
Message-ID: <20210515115715.314138-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/usb/host/xhci.c:1349:15: warning: variable ‘len’ set but not
used [-Wunused-but-set-variable ]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/usb/host/xhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ca9385d22f68..08290698b939 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1361,11 +1361,15 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 				 urb->transfer_buffer_length,
 				 dir);
 
-	if (usb_urb_dir_in(urb))
+	if (usb_urb_dir_in(urb)) {
 		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
 					   urb->transfer_buffer,
 					   buf_len,
 					   0);
+		if (len != buf_len)
+			xhci_warn(hcd_to_xhci(hcd), "WARN Wrong transfer buffer read length: %u != %u\n",
+				  len, buf_len);
+	}
 
 	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
 	kfree(urb->transfer_buffer);
-- 
2.25.4

