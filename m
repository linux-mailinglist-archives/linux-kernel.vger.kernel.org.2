Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9330E358DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhDHT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHT4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:56:30 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F8C061760;
        Thu,  8 Apr 2021 12:56:19 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUalC-0005PV-3J; Thu, 08 Apr 2021 21:56:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/12] staging: rtl8188eu: remove the last urb callback macros
Date:   Thu,  8 Apr 2021 21:55:50 +0200
Message-Id: <20210408195601.4762-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both usb_read_port_complete and usb_write_port_complete have a regs
parameter that is not used.

When this parameter is removed, the functions can be used as urb
completion callbacks directly. There's no need for the macros that
strip the second parameter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/usb_ops_linux.h | 5 -----
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c  | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
index 2f4976d251a1..0262ace52e71 100644
--- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
@@ -10,11 +10,6 @@
 #define USB_HIGH_SPEED_BULK_SIZE	512
 #define USB_FULL_SPEED_BULK_SIZE	64
 
-#define usb_write_port_complete(purb, regs)		\
-	usb_write_port_complete(purb)
-#define usb_read_port_complete(purb, regs)		\
-	usb_read_port_complete(purb)
-
 unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
 u8 usb_read8(struct adapter *adapter, u32 addr);
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index f2fa4fb3595f..28655f41a75b 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -334,7 +334,7 @@ u32 usb_read32(struct adapter *adapter, u32 addr)
 	return le32_to_cpu(data);
 }
 
-static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
+static void usb_read_port_complete(struct urb *purb)
 {
 	struct recv_buf *precvbuf = (struct recv_buf *)purb->context;
 	struct adapter *adapt = (struct adapter *)precvbuf->adapter;
@@ -519,7 +519,7 @@ int usb_write32(struct adapter *adapter, u32 addr, u32 val)
 	return usbctrl_vendorreq(adapter, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
 }
 
-static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
+static void usb_write_port_complete(struct urb *purb)
 {
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)purb->context;
 	struct adapter *padapter = pxmitbuf->padapter;
-- 
2.20.1

