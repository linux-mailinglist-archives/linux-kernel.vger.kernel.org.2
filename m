Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D2F3F3B87
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhHUQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhHUQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:50:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F42C061764
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:50:06 -0700 (PDT)
Received: from dslb-178-004-175-162.178.004.pools.vodafone-ip.de ([178.4.175.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mHUC1-0002Ch-N1; Sat, 21 Aug 2021 18:50:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: r8188eu: set pipe only once
Date:   Sat, 21 Aug 2021 18:48:59 +0200
Message-Id: <20210821164859.4351-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
References: <20210821164859.4351-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the pipe for reading or writing in usbctrl_vendorreq only once.
There's no need to set it again for every retry.

This patch is an adaptation of commit 889ed8b5e374 ("staging: rtl8188eu:
set pipe only once") for the new r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 5408383ccec3..5a55ee38d7b8 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -40,15 +40,16 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 		goto release_mutex;
 	}
 
-	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		memset(pIo_buf, 0, len);
+	if (requesttype == REALTEK_USB_VENQT_READ)
+		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
+	else
+		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
 
-		if (requesttype == REALTEK_USB_VENQT_READ) {
-			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
-		} else {
-			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
+	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
+		if (requesttype == REALTEK_USB_VENQT_READ)
+			memset(pIo_buf, 0, len);
+		else
 			memcpy(pIo_buf, pdata, len);
-		}
 
 		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
 					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-- 
2.20.1

