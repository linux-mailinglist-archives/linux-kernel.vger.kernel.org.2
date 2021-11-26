Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0845F337
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhKZR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhKZR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:57:50 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E17C07E5E7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:22 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf58-00083N-Cd; Fri, 26 Nov 2021 18:32:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/8] staging: r8188eu: get the rcv bulk pipe handle directly
Date:   Fri, 26 Nov 2021 18:32:00 +0100
Message-Id: <20211126173205.21352-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126173205.21352-1-martin@kaiser.cx>
References: <20211126173205.21352-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in calling ffaddr2pipehdl from rtw_read_port if the
endpoint address is constant. We can call usb_rcvbulkpipe ourselves
to get the pipe handle.

We can now remove RECV_BULK_IN_ADDR.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c     | 2 +-
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 1 -
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  | 4 +---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6af55cd6c061..d66a4b394610 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -507,7 +507,7 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	purb = precvbuf->purb;
 
 	/* translate DMA FIFO addr to pipehandle */
-	pipe = ffaddr2pipehdl(pdvobj, RECV_BULK_IN_ADDR);
+	pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe[0]);
 
 	usb_fill_bulk_urb(purb, pusbd, pipe,
 			  precvbuf->pbuf,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index 2ab395ef579b..3aa28b3ccb30 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -9,7 +9,6 @@
 #define RECV_BLK_SZ 512
 #define RECV_BLK_CNT 16
 #define RECV_BLK_TH RECV_BLK_CNT
-#define RECV_BULK_IN_ADDR		0x80
 #define RECV_INT_IN_ADDR		0x81
 
 #define NR_PREALLOC_RECV_SKB (8)
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index ef2ea68ae873..5c659caa0975 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -12,9 +12,7 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 	unsigned int pipe = 0, ep_num = 0;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-	if (addr == RECV_BULK_IN_ADDR) {
-		pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe[0]);
-	} else if (addr == RECV_INT_IN_ADDR) {
+	if (addr == RECV_INT_IN_ADDR) {
 		pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe[1]);
 	} else if (addr < HW_QUEUE_ENTRY) {
 		ep_num = pdvobj->Queue2Pipe[addr];
-- 
2.20.1

