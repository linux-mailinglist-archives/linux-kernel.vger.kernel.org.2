Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4909B3572A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354526AbhDGRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDGRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:06:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB3C06175F;
        Wed,  7 Apr 2021 10:05:50 -0700 (PDT)
Received: from ipservice-092-217-079-185.092.217.pools.vodafone-ip.de ([92.217.79.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUBcd-0001Q6-VP; Wed, 07 Apr 2021 19:05:44 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/10] staging: rtl8188eu: remove unused macros
Date:   Wed,  7 Apr 2021 19:05:22 +0200
Message-Id: <20210407170531.29356-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_ops_linux.h contains a couple of macros to make functions usable as
urb completion callbacks. Most of them are unused and can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/usb_ops_linux.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
index 4e0e48cb5c8e..1a0b38de5027 100644
--- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
@@ -23,18 +23,10 @@
 #define USB_HIGH_SPEED_BULK_SIZE	512
 #define USB_FULL_SPEED_BULK_SIZE	64
 
-#define _usbctrl_vendorreq_async_callback(urb, regs)	\
-	_usbctrl_vendorreq_async_callback(urb)
-#define usb_bulkout_zero_complete(purb, regs)		\
-	usb_bulkout_zero_complete(purb)
-#define usb_write_mem_complete(purb, regs)		\
-	usb_write_mem_complete(purb)
 #define usb_write_port_complete(purb, regs)		\
 	usb_write_port_complete(purb)
 #define usb_read_port_complete(purb, regs)		\
 	usb_read_port_complete(purb)
-#define usb_read_interrupt_complete(purb, regs)		\
-	usb_read_interrupt_complete(purb)
 
 unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
-- 
2.20.1

