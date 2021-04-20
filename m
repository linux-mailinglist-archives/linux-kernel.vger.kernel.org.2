Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035D536571D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhDTLG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:06:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37849 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhDTLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:06:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYoD0-0003FG-EF; Tue, 20 Apr 2021 11:06:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: net2272: remove redundant initialization of status
Date:   Tue, 20 Apr 2021 12:06:22 +0100
Message-Id: <20210420110622.377339-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable status is being initialized with a value that is
never read and it is being updated later with a new value.  The
initialization is redundant and can be removed and move the
declaration of status to the scope where it is used.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/net2272.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 23a735641c3d..89f479b78d80 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -539,7 +539,6 @@ net2272_read_fifo(struct net2272_ep *ep, struct net2272_request *req)
 	int count;
 	int tmp;
 	int cleanup = 0;
-	int status = -1;
 
 	dev_vdbg(ep->dev->dev, "read_fifo %s actual %d len %d\n",
 		ep->ep.name, req->req.actual, req->req.length);
@@ -591,6 +590,8 @@ net2272_read_fifo(struct net2272_ep *ep, struct net2272_request *req)
 			}
 
 			if (!list_empty(&ep->queue)) {
+				int status;
+
 				req = list_entry(ep->queue.next,
 					struct net2272_request, queue);
 				status = net2272_kick_dma(ep, req);
-- 
2.30.2

