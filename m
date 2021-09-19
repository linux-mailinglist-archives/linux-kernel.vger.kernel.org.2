Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1F410DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhISXz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhISXzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9250C061767
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id co2so7408582edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1u2QxRsXlb8Ov00Ioim3Lo0VQOs1cvPeFGcYojVplM=;
        b=ZbZ+QGdAcXq1MuMGfGNsePMrKVjrlKVOQIVPQ3IRhjSsr55jfO04lwGI5SJ7dUG5Zb
         wujpXI8t4jkLqFj9f1nze6/+HPXtVk4nXh5EqIgpghUHjWT1wvO9Vmo4xvJpRoc2mqtV
         n6/vmhBOhoiT79TrIFdrr7kfDV4ve3fY06zBTNBKnN/rnWsumOtvtzlDwqiIZhO6ItnS
         x5aD4Lxh2uX3tAmsmf+WgDfPqyRF7Xx9izAPmvikriz1+uvpYvLl6f0DncCcoFyEGzes
         juOQuqnq2cqwQTOf3KvX5872LJeCPaFpEquLQCeJxDHv3b0kG2Ns6j9l4KhWnMh1DuIP
         F5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1u2QxRsXlb8Ov00Ioim3Lo0VQOs1cvPeFGcYojVplM=;
        b=0i8mNgOwud+Q3YysWZFlHs+4CjB2tjOMa/bfnjKaTWCb9OBrZgPLfwEmpphFby9Pvh
         kA3mPdEUXgjA5uf/CO9kEvHi5d/uyb2DVE2+ma0YcUmitOwQH6sTAwhQttgvYDVh++nS
         JsXdE5mFQVH0GTc6OLjavKq5Ndy3hgGSaJDGSHhFn982eQX/oJoqnVwE8evrH6uPSc5k
         hXivgieTtc6P9jwMItK5xXx7faWYSJFIM8UuwWPOsz/yWTa6DWvQEsQSdVJgJqR7/A3q
         1jOBs55vA3chQQmYkQgNu7CI0G+ofAfgFD2YHtKrRb5hBXDFKsxi1dbzNmJEjtLo+uU/
         k/UQ==
X-Gm-Message-State: AOAM530sVJ3DoyU8p2Z1Rfufc62Xp8ClKH8e1SHaWxg9rCJniRwVf5dS
        +Sfz68ztkbr4jcLOuMNSu1M=
X-Google-Smtp-Source: ABdhPJzoSHcOl0a39KeCxWz90Of1zzB22EhwiCDT4IA1Ez7QSkG9DeNiI2AfTfaENPtY+6a0szbl+A==
X-Received: by 2002:aa7:c74c:: with SMTP id c12mr26102851eds.87.1632095647445;
        Sun, 19 Sep 2021 16:54:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 04/19] staging: r8188eu: reorder comments in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:41 +0200
Message-Id: <20210919235356.4151-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder comments in usbctrl_vendorreq() to follow the Linux style.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index d92bdcc3716d..9138b730490f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -35,9 +35,11 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
 	if (requesttype == REALTEK_USB_VENQT_READ)
-		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
+		/* read in */
+		pipe = usb_rcvctrlpipe(udev, 0);
 	else
-		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
+		/* write out */
+		pipe = usb_sndctrlpipe(udev, 0);
 
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
 		if (requesttype == REALTEK_USB_VENQT_READ)
@@ -49,11 +51,13 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
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
@@ -65,7 +69,8 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
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

