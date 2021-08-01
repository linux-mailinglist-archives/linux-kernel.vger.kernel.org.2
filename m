Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89533DCDC7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhHAUda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhHAUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:33:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A38C06175F;
        Sun,  1 Aug 2021 13:33:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so21858756pji.5;
        Sun, 01 Aug 2021 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TNHUAUUQq6pSAVAD9dbbOs6upEHGa+nDHRxnvCMA0s=;
        b=T0X4CO4M8F3dWkJj4Aoz7Pq/OBjVQ6SDo1u72RfiWIpbTz+gvREkDtbxlx5OMW/jHj
         Do5WHp5Xg+Kad7D1564OKoU8AGR1dgA1VQxhk0yvc9WwYPbh1Aw5jXGvgCKfCfF1eEu1
         LpR9gM6bpKagcPKMn3mZPc6/ewPmeTGYCcTB34LP6o5prx7U3Wb9R5m5xNKleo1H2Mbk
         G+AS+lERj9Dyg1FHmzrWfb0fRTBrY64EiEOuLPJVVOTcuDP3x/eqrYqwWrgn7bnbqjvj
         XwiCwxebnuThAX/RrZQ2fKWSGD7W1CCWgb9I7OJNwiQl7YUnOoF6nu+4bCZXss7BP6a+
         PDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TNHUAUUQq6pSAVAD9dbbOs6upEHGa+nDHRxnvCMA0s=;
        b=sjztybxXop4Fp5Wd1xhCcmmlXHxjjC+3Pb/T1KJ8PUN16Ib0V65ignEl4lq1eCEH3r
         pzmGUf+ZROBjAlLOIy3Hy9W/b+G6EKt8bVpgyFKbUYYeS1ogK802cA0piRscxjyLBme6
         Y7iF7OS4CyhUiGtYTL2JbftrbWsgXRYQDfVq+R5q4cI7y3+5j2nTMU+rpRS9GjdFcCQw
         ErkpRWrnoSoMttHqjuKlJu5pTJE9BcuSaCuxnZKMrHf6WnCgV9WBV4BfMePev03AjdF1
         nwWnDEwJgkFlthgfjw9ck75yR/ONumNDjzdBQ8X82Xw65OqLg8xexgIJ6rTlJ3GZWFJL
         E/+g==
X-Gm-Message-State: AOAM5311xaiKUEHJT3c0GmnPOifef5cbM6ZQf2fmzbjQqKG/RAoTI2VR
        vq9PbXRizi91F57YIcbsP3M=
X-Google-Smtp-Source: ABdhPJxL+qGkny0dOtPtCRtQwaXtU6a4PXUjhHTUnKGapKXJMvmxTLw1FWI8V7JWOkuxjkrzdP8UpQ==
X-Received: by 2002:a65:6553:: with SMTP id a19mr8474236pgw.8.1627849998215;
        Sun, 01 Aug 2021 13:33:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:33:17 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 5/6] USB: serial: keyspan_pda: use usb_control_msg_recv()
Date:   Mon,  2 Aug 2021 02:01:21 +0530
Message-Id: <20210801203122.3515-6-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210801203122.3515-1-himadrispandya@gmail.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wrapper function usb_control_msg_recv() that accepts stack
variables and remove dma buffers from callers of usb_control_msg().

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
Changes in v2:
 - Rebase the patch on top of recent changes
 - Drop unrelated style changes
---
 drivers/usb/serial/keyspan_pda.c | 70 ++++++++++++++------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 39b0f5f344c2..831dc5f42dea 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -77,35 +77,28 @@ static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
 {
 	struct usb_serial_port *port = priv->port;
 	struct usb_serial *serial = port->serial;
-	u8 *room;
+	u8 room;
 	int rc;
 
-	room = kmalloc(1, GFP_KERNEL);
-	if (!room)
-		return -ENOMEM;
-
-	rc = usb_control_msg(serial->dev,
-			     usb_rcvctrlpipe(serial->dev, 0),
-			     6, /* write_room */
-			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-			     | USB_DIR_IN,
-			     0, /* value: 0 means "remaining room" */
-			     0, /* index */
-			     room,
-			     1,
-			     2000);
-	if (rc != 1) {
-		if (rc >= 0)
-			rc = -EIO;
+	rc = usb_control_msg_recv(serial->dev,
+				  0,
+				  6, /* write_room */
+				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE
+				  | USB_DIR_IN,
+				  0, /* value: 0 means "remaining room" */
+				  0, /* index */
+				  &room,
+				  1,
+				  2000,
+				  GFP_KERNEL);
+	if (rc) {
 		dev_dbg(&port->dev, "roomquery failed: %d\n", rc);
-		goto out_free;
+		goto out;
 	}
 
-	dev_dbg(&port->dev, "roomquery says %d\n", *room);
-	rc = *room;
-out_free:
-	kfree(room);
-
+	dev_dbg(&port->dev, "roomquery says %d\n", room);
+	rc = room;
+out:
 	return rc;
 }
 
@@ -381,22 +374,21 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 				      unsigned char *value)
 {
 	int rc;
-	u8 *data;
-
-	data = kmalloc(1, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	rc = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			     3, /* get pins */
-			     USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_IN,
-			     0, 0, data, 1, 2000);
-	if (rc == 1)
-		*value = *data;
-	else if (rc >= 0)
-		rc = -EIO;
+	u8 data;
+
+	rc = usb_control_msg_recv(serial->dev, 0,
+				  3, /* get pins */
+				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
+				  USB_DIR_IN,
+				  0,
+				  0,
+				  &data,
+				  1,
+				  2000,
+				  GFP_KERNEL);
+	if (rc == 0)
+		*value = data;
 
-	kfree(data);
 	return rc;
 }
 
-- 
2.17.1

