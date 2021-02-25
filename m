Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783193249A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhBYEBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBYEBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:01:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:00:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 7so3491984pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=dN8giP+M0NZZ+raI+j4A4emKMTlzkN2uZrsTunLcU0I=;
        b=fqC8CZrY8+VBe0e3Gwp0CBsqbj5xSA8bNa4Dw/i5bzrj4FJly5VitVPwLElv8R/DlY
         zKFhZorcNW6xlpdcASbYLh9Nw2Nb1o9X7+eBoToC1G6wNGAOYMPYOfFLhh+VF+uIBPnB
         Jq0BzSbcZS18cCCN5AJFGv6+lT/vWefjrqQFcdcjFzBgYJgdLUooWLGVRKfo5zKteBE0
         ovXJbfWqN2e5YK+w/xPtPo+sDekBc2PMbZra6MQI04xlx35ReY6tFIdOD3HZEu8rSxh1
         Vf5JUiA5tA81X9a2B9SAPmqbUdtqpYZTb8PZ44rV10WF30d2HgJ/8vdSlnFo13f6PPmk
         /61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=dN8giP+M0NZZ+raI+j4A4emKMTlzkN2uZrsTunLcU0I=;
        b=jYZuMcpOeravlLiIZCphaZpAZXAdWHbHsMA7vLT3wHRvVCOSoRhXJlnAJBRKk7g0cg
         SPPTlUqISa2PGa2g02tcYa+wkwM3TdScbYDs1sitOrszM+BFYUXVZ0Xl7ScZoMcSZC/X
         IKSBFVCcMBvKwcMFoldkRH917fGWPeij5ZqCQlH1ScscWEaGhTLtpWLNduOWY9Oac5Nn
         2FUbepnmR9VSOmomBPU1WLKussEQkt9Ea0zNJTD6bT40gl2FDe53IONzYWJy7RUWRFLg
         fgX0d7Nxx/Zc3qVSRUeWugReII35KxBpL8OLSxMEH63Q3ucLUD10sHHxFglret8b6dpp
         YY4Q==
X-Gm-Message-State: AOAM532UhvD3RCI7z2SQm6HPCxyQiDycOEqyG0towvs2gILF474zrGB2
        Co/TP+mHQbXJEO3XV+Vq/PPY+B0i
X-Google-Smtp-Source: ABdhPJwO25b81OIT452rnlYGvJY3vb1/eAwhTizrIOk5Oy0dzPvSqtqeOv/SNWXW2s4mPZSUaiuran2j
Sender: "lzye via sendgmr" <lzye@lzye2.c.googlers.com>
X-Received: from lzye2.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:6713])
 (user=lzye job=sendgmr) by 2002:a62:5bc4:0:b029:1e7:5b23:1d59 with SMTP id
 p187-20020a625bc40000b02901e75b231d59mr1381138pfb.0.1614225636530; Wed, 24
 Feb 2021 20:00:36 -0800 (PST)
Date:   Thu, 25 Feb 2021 04:00:32 +0000
Message-Id: <20210225040032.684590-1-lzye@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] Input: Add "Share" button to Microsoft Xbox One controller.
From:   Chris Ye <lzye@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chris Ye <linzhao.ye@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        kernel-team@android.com, Chris Ye <lzye@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "Share" button input capability and input event mapping for
Microsoft Xbox One controller.
Fixed Microsoft Xbox One controller share button not working under USB
connection.

Signed-off-by: Chris Ye <lzye@google.com>
---
 drivers/input/joystick/xpad.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9f0d07dcbf06..08c3e93ccb2f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -368,6 +368,14 @@ static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
 	-1
 };
 
+static const signed short xpad_xboxone_btn[] = {
+	/* buttons for xbox one controller */
+	BTN_TL, BTN_TR,		/* Button LB/RB */
+	BTN_MODE,		/* The big X button */
+	KEY_RECORD,		/* The share button */
+	-1
+};
+
 static const signed short xpad_abs[] = {
 	ABS_X, ABS_Y,		/* left stick */
 	ABS_RX, ABS_RY,		/* right stick */
@@ -862,6 +870,7 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	/* menu/view buttons */
 	input_report_key(dev, BTN_START,  data[4] & 0x04);
 	input_report_key(dev, BTN_SELECT, data[4] & 0x08);
+	input_report_key(dev, KEY_RECORD, data[22] & 0x01);
 
 	/* buttons A,B,X,Y */
 	input_report_key(dev, BTN_A,	data[4] & 0x10);
@@ -1668,10 +1677,13 @@ static int xpad_init_input(struct usb_xpad *xpad)
 		input_set_capability(input_dev, EV_KEY, xpad_common_btn[i]);
 
 	/* set up model-specific ones */
-	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W ||
-	    xpad->xtype == XTYPE_XBOXONE) {
+	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W) {
 		for (i = 0; xpad360_btn[i] >= 0; i++)
 			input_set_capability(input_dev, EV_KEY, xpad360_btn[i]);
+	}  else if (xpad->xtype == XTYPE_XBOXONE) {
+		for (i = 0; xpad_xboxone_btn[i] >= 0; i++)
+			input_set_capability(input_dev, EV_KEY,
+						xpad_xboxone_btn[i]);
 	} else {
 		for (i = 0; xpad_btn[i] >= 0; i++)
 			input_set_capability(input_dev, EV_KEY, xpad_btn[i]);
-- 
2.30.0.617.g56c4b15f3c-goog

