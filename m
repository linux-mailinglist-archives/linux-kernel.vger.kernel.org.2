Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7B4171CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbhIXM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbhIXM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ee50so35457174edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KznSAVNlR9qjlrh9l/5EnKDDm3BBqFQ33glNNhxBtQY=;
        b=eVV7+Jw2bviUZZ19vS/JCzc1ynDpaCO4DXaqe2V8cyM92d9L/tI7ujMkR4o8nuMt3Z
         VtcxSVayKx1di0rCgMsVlzkTk1YW/d0kXNogmvDFpNO6D3lf7kxJbDqFk25HcNboKFIi
         5BhOwFs1xlbKUQePxbr/DGnr8ruYIgafP+ozmMH1u1erTjISOMCTUdv0h4oBW0F9n01O
         XGzFGTH7VDojMyjEjJ4jKmFyQBB3tnoYV8NMmBRj2xbpbV/j4GI3/ls4szmXnxGBoFkt
         mSpIs0Hj3TLn80AgVgLW6J4khe/7UT8C7/jYromR1ZJKBn0tTVvaXYiDGqCr1xLMUoOO
         8GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KznSAVNlR9qjlrh9l/5EnKDDm3BBqFQ33glNNhxBtQY=;
        b=KabTTwPfQid49kAgtTTy2CGPXLdVKdv9C1jlzgBlQ/Xh1taKE+AxC2LsAS7vElQ5kJ
         qZ+7SErwsPqTIGEyelmH1C2wFJ1c52HwjKV8kIhUy8eKeDQ7VFjDgbzKN2Ojn0G/pSUF
         7Kzlvk5C1jDp0QSUs6CGOYz1B+mM6b89ATu/trAVAad1KW/N4j4KhEdMs5MYtrzvQMEH
         pcuPtEjRW3RO1FSm6ESKWhRSJFPc7B5uIH4UrrS/q6nyXFRelG2cYYscTWNF65BK7IwI
         0ePkT3ZJgHHN7gjRd4eDTWiSOpxp9n8omDPc8040RzaFwoqH/UNFjuzUwB8V3Mwj6XM2
         9HDQ==
X-Gm-Message-State: AOAM530KioPAItxeEHgOhxdJRvrdYWW+tlOQmVoqYi6cXpZG6Cwjvagi
        xuEnLQOt/LdIVTzak0b5maw=
X-Google-Smtp-Source: ABdhPJz05fsodAjnUA5ZL/qYrh9UCyRdnNLWDqXklpHk1o4RMDV1IC6FI0s+S4bijVgcrf8yiS/qZQ==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr4644883eds.166.1632486451617;
        Fri, 24 Sep 2021 05:27:31 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 04/16] staging: r8188eu: reorder comments in usbctrl_vendorreq()
Date:   Fri, 24 Sep 2021 14:26:53 +0200
Message-Id: <20210924122705.3781-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder comments in usbctrl_vendorreq() to follow Linux coding style.
Delete two of them because they are "obvious".

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 61a016e3608f..35d268c5cd7f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -35,9 +35,9 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
 	if (requesttype == REALTEK_USB_VENQT_READ)
-		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
+		pipe = usb_rcvctrlpipe(udev, 0);
 	else
-		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
+		pipe = usb_sndctrlpipe(udev, 0);
 
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
 		if (requesttype == REALTEK_USB_VENQT_READ)
@@ -49,11 +49,13 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
 					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
-		if (status == len) {   /*  Success this control transfer. */
+		if (status == len) {
+			/*  success */
 			rtw_reset_continual_urb_error(dvobjpriv);
 			if (requesttype == REALTEK_USB_VENQT_READ)
 				memcpy(data, io_buf,  len);
-		} else { /*  error cases */
+		} else {
+			/* error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
 				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
 				len, status, *(u32 *)data, vendorreq_times);
@@ -65,7 +67,8 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 					struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
 					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
 				}
-			} else { /*  status != len && status >= 0 */
+			} else {
+				/* status != len && status >= 0 */
 				if (status > 0) {
 					if (requesttype == REALTEK_USB_VENQT_READ) {
 						/*  For Control read transfer, we have to copy the read data from io_buf to data. */
-- 
2.33.0

