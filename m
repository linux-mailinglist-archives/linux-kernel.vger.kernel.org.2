Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72534B236
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCZWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCZWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:34:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACFC0613AA;
        Fri, 26 Mar 2021 15:34:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l3so5807841pfc.7;
        Fri, 26 Mar 2021 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCrxf8KWANSammOalLt55qLDasqp/niYHetjHjkFBW4=;
        b=u6rPQ8cWE6iXSS/N5BfOKlQINGp/6uc0gEhAvj3MoHYQMHul9zEiswrLtNYmxiR7+T
         5qFhnXRu/m9i4ELAQ5/7sjfddibZBLWJFfx/5gyOWjm9iSZjnMrEnT7edUMEi32VKRgq
         tC+b4eZ31Lfkp+++loPuaqulh6wTtfge6k9c4US3FRlT0HUIPpfQ9WrRIxk4spgC43kx
         CuWuXaXCE0bhDJHg0Eqp2RUEbsNGDB7krBg9t1zsxfTbwipVBrmlZ2rfxdjN0rkpgwYe
         uCNQlfr6FRT89Avb4iKqGyjSHINO0nwXlJOiBtKS82oldlKNojmhMgwN/LbF8YnW/BPc
         LLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCrxf8KWANSammOalLt55qLDasqp/niYHetjHjkFBW4=;
        b=KAnC/BNiHHx0aU5Tbk+2A1ybapPxveFzNO/8E+crPOgISGtAayAYdhdLONVI3upsBl
         jGvHTmJCq5wy2M+l2bN6vH+pHKE+EfW/QBudgGYwm4gognr0R64qD3PpijmFitMJs8oV
         omIGnMtIWfkYQ/Ftx3hSWSGGj1mYTl2MX4BSqdmjJ/kvGgDYRPKxvHtZv7ubp3962clo
         lCGrY5DdRpmNUaonjdFTAafSEuMb4Tja5wULqV9ec4TNo5G0jqpxPGbvMYkljIKkvfHv
         mbxt/cZGMV9VMDSZpc4WQxp/qeCpIVQy1fZpjUjju/7NaqtgRc9EjJL0ECdX3GLBZsNl
         b73Q==
X-Gm-Message-State: AOAM532xVfX9uLqsZU6yzykBJNxVS4MLMnbkVp7/MgRk5NJp20Av1RLP
        cfh10kuIsuV5daVRWE/GspJlyiaMxznSdVTx
X-Google-Smtp-Source: ABdhPJx/5aCUoYhYa0UNfaYmhUWFs40K6W2OYDecB+Bac/QPiC/wQ2a5zBfX84D+xIKZp5vgSmWnlQ==
X-Received: by 2002:a63:3752:: with SMTP id g18mr13229702pgn.388.1616798061112;
        Fri, 26 Mar 2021 15:34:21 -0700 (PDT)
Received: from localhost.localdomain ([49.207.194.205])
        by smtp.gmail.com with ESMTPSA id c193sm10136262pfc.180.2021.03.26.15.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:34:20 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] usb: misc: usbsevseg: update to use usb_control_msg_send()
Date:   Sat, 27 Mar 2021 04:02:51 +0530
Message-Id: <20210326223251.753952-4-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
References: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API ensures that a short read is 
treated as an error, data can be used off the stack, and raw usb pipes 
need not be created in the calling functions.
For this reason, instances of usb_control_msg() have been replaced with
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/usbsevseg.c | 60 ++++++++++--------------------------
 1 file changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/misc/usbsevseg.c b/drivers/usb/misc/usbsevseg.c
index 551074f5b7ad..4bc816bb09bb 100644
--- a/drivers/usb/misc/usbsevseg.c
+++ b/drivers/usb/misc/usbsevseg.c
@@ -74,15 +74,10 @@ static void update_display_powered(struct usb_sevsegdev *mydev)
 	if (mydev->shadow_power != 1)
 		return;
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(80 * 0x100) + 10, /*  (power mode) */
-			(0x00 * 0x100) + (mydev->powered ? 1 : 0),
-			NULL,
-			0,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (80 * 0x100) + 10, /*  (power mode) */
+				  (0x00 * 0x100) + (mydev->powered ? 1 : 0),
+				  NULL, 0, 2000, GFP_KERNEL);
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "power retval = %d\n", rc);
 
@@ -99,15 +94,10 @@ static void update_display_mode(struct usb_sevsegdev *mydev)
 	if(mydev->shadow_power != 1)
 		return;
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(82 * 0x100) + 10, /* (set mode) */
-			(mydev->mode_msb * 0x100) + mydev->mode_lsb,
-			NULL,
-			0,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (82 * 0x100) + 10, /* (set mode) */
+				  (mydev->mode_msb * 0x100) + mydev->mode_lsb,
+				  NULL, 0, 2000, GFP_NOIO);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "mode retval = %d\n", rc);
@@ -117,48 +107,32 @@ static void update_display_visual(struct usb_sevsegdev *mydev, gfp_t mf)
 {
 	int rc;
 	int i;
-	unsigned char *buffer;
+	unsigned char buffer[MAXLEN] = {0};
 	u8 decimals = 0;
 
 	if(mydev->shadow_power != 1)
 		return;
 
-	buffer = kzalloc(MAXLEN, mf);
-	if (!buffer)
-		return;
-
 	/* The device is right to left, where as you write left to right */
 	for (i = 0; i < mydev->textlength; i++)
 		buffer[i] = mydev->text[mydev->textlength-1-i];
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(85 * 0x100) + 10, /* (write text) */
-			(0 * 0x100) + mydev->textmode, /* mode  */
-			buffer,
-			mydev->textlength,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (85 * 0x100) + 10, /* (write text) */
+				  (0 * 0x100) + mydev->textmode, /* mode  */
+				  &buffer, mydev->textlength, 2000, mf);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "write retval = %d\n", rc);
 
-	kfree(buffer);
-
 	/* The device is right to left, where as you write left to right */
 	for (i = 0; i < sizeof(mydev->decimals); i++)
 		decimals |= mydev->decimals[i] << i;
 
-	rc = usb_control_msg(mydev->udev,
-			usb_sndctrlpipe(mydev->udev, 0),
-			0x12,
-			0x48,
-			(86 * 0x100) + 10, /* (set decimal) */
-			(0 * 0x100) + decimals, /* decimals */
-			NULL,
-			0,
-			2000);
+	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
+				  (86 * 0x100) + 10, /* (set decimal) */
+				  (0 * 0x100) + decimals, /* decimals */
+				  NULL, 0, 2000, mf);
 
 	if (rc < 0)
 		dev_dbg(&mydev->udev->dev, "decimal retval = %d\n", rc);
-- 
2.25.1

