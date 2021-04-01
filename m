Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93C351336
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhDAKR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:17:56 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:48022 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234015AbhDAKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:17:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UU61cAq_1617272236;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UU61cAq_1617272236)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Apr 2021 18:17:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] xhci: remove unused variable
Date:   Thu,  1 Apr 2021 18:17:15 +0800
Message-Id: <1617272235-62515-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/usb/host/xhci.c:1346:15: warning: variable ‘len’ set but not
used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/host/xhci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 1975016..0ead09c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1343,7 +1343,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
 
 static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 {
-	unsigned int len;
 	unsigned int buf_len;
 	enum dma_data_direction dir;
 
@@ -1359,10 +1358,9 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 				 dir);
 
 	if (usb_urb_dir_in(urb))
-		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
-					   urb->transfer_buffer,
-					   buf_len,
-					   0);
+		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
+				     urb->transfer_buffer,
+				     buf_len, 0);
 
 	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
 	kfree(urb->transfer_buffer);
-- 
1.8.3.1

