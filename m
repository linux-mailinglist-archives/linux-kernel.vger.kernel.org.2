Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33A407271
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhIJUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhIJUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:23:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BCFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:22:18 -0700 (PDT)
Received: from ipservice-092-217-077-211.092.217.pools.vodafone-ip.de ([92.217.77.211] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mOn2M-0005Wm-6V; Fri, 10 Sep 2021 22:22:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] staging: r8188eu: remove the remaining usb endpoint functions
Date:   Fri, 10 Sep 2021 22:21:51 +0200
Message-Id: <20210910202151.4007-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210910202151.4007-1-martin@kaiser.cx>
References: <20210910202151.4007-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last bunch of unused RT_usb_endpoint_... functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index d22022b0cc93..b174cc69ded7 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -73,21 +73,6 @@ static struct rtw_usb_drv rtl8188e_usb_drv = {
 
 static struct rtw_usb_drv *usb_drv = &rtl8188e_usb_drv;
 
-static inline int RT_usb_endpoint_dir_out(const struct usb_endpoint_descriptor *epd)
-{
-	return (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT;
-}
-
-static inline int RT_usb_endpoint_xfer_bulk(const struct usb_endpoint_descriptor *epd)
-{
-	return (epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_BULK;
-}
-
-static inline int RT_usb_endpoint_is_bulk_out(const struct usb_endpoint_descriptor *epd)
-{
-	return RT_usb_endpoint_xfer_bulk(epd) && RT_usb_endpoint_dir_out(epd);
-}
-
 static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 {
 	u8 rst = _SUCCESS;
-- 
2.20.1

