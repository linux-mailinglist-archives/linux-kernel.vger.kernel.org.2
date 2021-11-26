Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D245F339
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhKZR7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhKZR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:57:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864BC07E5ED
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:23 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf59-00083N-OV; Fri, 26 Nov 2021 18:32:19 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/8] staging: r8188eu: remove code to get int in pipe handle
Date:   Fri, 26 Nov 2021 18:32:01 +0100
Message-Id: <20211126173205.21352-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126173205.21352-1-martin@kaiser.cx>
References: <20211126173205.21352-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous cleanup, ffaddr2pipehdl is called only by
rtw_write_port. This function will never ask for the pipe handle
of the interrupt in pipe. We can remove the related code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 1 -
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index 3aa28b3ccb30..bc30eb4634bb 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -9,7 +9,6 @@
 #define RECV_BLK_SZ 512
 #define RECV_BLK_CNT 16
 #define RECV_BLK_TH RECV_BLK_CNT
-#define RECV_INT_IN_ADDR		0x81
 
 #define NR_PREALLOC_RECV_SKB (8)
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 5c659caa0975..d1cb33d3e6a7 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -12,9 +12,7 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 	unsigned int pipe = 0, ep_num = 0;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-	if (addr == RECV_INT_IN_ADDR) {
-		pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe[1]);
-	} else if (addr < HW_QUEUE_ENTRY) {
+	if (addr < HW_QUEUE_ENTRY) {
 		ep_num = pdvobj->Queue2Pipe[addr];
 		pipe = usb_sndbulkpipe(pusbd, ep_num);
 	}
-- 
2.20.1

