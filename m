Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160C3E998B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhHKUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhHKUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:15:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BA4C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:15:21 -0700 (PDT)
Received: from dslb-094-219-033-123.094.219.pools.vodafone-ip.de ([94.219.33.123] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mDud9-0004sF-Tv; Wed, 11 Aug 2021 22:15:15 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: remove unused function parameters
Date:   Wed, 11 Aug 2021 22:14:47 +0200
Message-Id: <20210811201450.31366-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811201450.31366-1-martin@kaiser.cx>
References: <20210811201450.31366-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_usb_if1_init and chip_by_usb_id do not need a
struct usb_device_id parameter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 8f1e33d2fff7..4bf89b78a74a 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -250,8 +250,7 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 
 }
 
-static void chip_by_usb_id(struct adapter *padapter,
-			   const struct usb_device_id *pdid)
+static void chip_by_usb_id(struct adapter *padapter)
 {
 	padapter->chip_type = NULL_CHIP_TYPE;
 	hal_set_hw_type(padapter);
@@ -569,7 +568,7 @@ int rtw_resume_process(struct adapter *padapter)
  */
 
 static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
-	struct usb_interface *pusb_intf, const struct usb_device_id *pdid)
+	struct usb_interface *pusb_intf)
 {
 	struct adapter *padapter = NULL;
 	struct net_device *pnetdev = NULL;
@@ -587,7 +586,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	/* step 1-1., decide the chip_type via vid/pid */
 	padapter->interface_type = RTW_USB;
-	chip_by_usb_id(padapter, pdid);
+	chip_by_usb_id(padapter);
 
 	if (rtw_handle_dualmac(padapter, 1) != _SUCCESS)
 		goto free_adapter;
@@ -722,7 +721,7 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 	if (!dvobj)
 		goto exit;
 
-	if1 = rtw_usb_if1_init(dvobj, pusb_intf, pdid);
+	if1 = rtw_usb_if1_init(dvobj, pusb_intf);
 	if (!if1) {
 		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
 		goto free_dvobj;
-- 
2.20.1

