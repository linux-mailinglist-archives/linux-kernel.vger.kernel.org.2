Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B943F3B85
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhHUQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhHUQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:50:42 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614FC061756
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:50:03 -0700 (PDT)
Received: from dslb-178-004-175-162.178.004.pools.vodafone-ip.de ([178.4.175.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mHUBy-0002Ch-Fg; Sat, 21 Aug 2021 18:49:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/10] staging: r8188eu: clean up the usb_writeXY functions
Date:   Sat, 21 Aug 2021 18:48:56 +0200
Message-Id: <20210821164859.4351-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
References: <20210821164859.4351-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variables, summarize declarations and assignments.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 50 ++++-----------------
 1 file changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index cb969a200681..e01f1ac19596 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -128,59 +128,25 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
 
 static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 {
-	u16 wvalue;
-	u16 len;
-	u8 data;
-	int ret;
-
-
-	wvalue = (u16)(addr & 0x0000ffff);
-	len = 1;
-	data = val;
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
+	u16 wvalue = (u16)(addr & 0x0000ffff);
 
-	return ret;
+	return usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
 }
 
 static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 {
-	u16 wvalue;
-	u16 len;
-	__le32 data;
-	int ret;
-
-
-
-	wvalue = (u16)(addr & 0x0000ffff);
-	len = 2;
-
-	data = cpu_to_le32(val & 0x0000ffff);
-
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
-
-
+	u16 wvalue = (u16)(addr & 0x0000ffff);
+	__le32 data = cpu_to_le32(val & 0x0000ffff);
 
-	return ret;
+	return usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
 }
 
 static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 {
-	u16 wvalue;
-	u16 len;
-	__le32 data;
-	int ret;
-
-
-
-	wvalue = (u16)(addr & 0x0000ffff);
-	len = 4;
-	data = cpu_to_le32(val);
-
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
-
-
+	u16 wvalue = (u16)(addr & 0x0000ffff);
+	__le32 data = cpu_to_le32(val);
 
-	return ret;
+	return usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
 }
 
 static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
-- 
2.20.1

