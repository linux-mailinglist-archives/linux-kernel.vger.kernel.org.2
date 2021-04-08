Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED5358DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhDHT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:01 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCCDC061760;
        Thu,  8 Apr 2021 12:56:50 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUali-0005PV-8I; Thu, 08 Apr 2021 21:56:46 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/12] staging: rtl8188eu: make ffaddr2pipehdl static
Date:   Thu,  8 Apr 2021 21:55:52 +0200
Message-Id: <20210408195601.4762-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195601.4762-1-martin@kaiser.cx>
References: <20210408195601.4762-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used only inside usb_ops_linux.c.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/usb_ops_linux.h | 2 --
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
index bd9c7716c440..19c6e76d747e 100644
--- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
@@ -10,8 +10,6 @@
 #define USB_HIGH_SPEED_BULK_SIZE	512
 #define USB_FULL_SPEED_BULK_SIZE	64
 
-unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
-
 u8 usb_read8(struct adapter *adapter, u32 addr);
 u16 usb_read16(struct adapter *adapter, u32 addr);
 u32 usb_read32(struct adapter *adapter, u32 addr);
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 28655f41a75b..56ba0b8a4c87 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -195,7 +195,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 	return _SUCCESS;
 }
 
-unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
+static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 {
 	unsigned int pipe = 0, ep_num = 0;
 	struct usb_device *pusbd = pdvobj->pusbdev;
-- 
2.20.1

