Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC0422A39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhJEOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbhJEOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:09 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB21C08E876;
        Tue,  5 Oct 2021 07:03:32 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HNznt6q56zQkBY;
        Tue,  5 Oct 2021 16:03:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=4yU91kg1vQx6jyFicaSxV6cIZEe01aqr2KGabcn8IAs=;
        b=RMBEXpmwUGL2U5lOIXSm4tNcQ9vEsnZ2rcNquWgZGCV5BlqaPHzBp+lBH0rSe22Eoq5zqd
        c9Mm4CKX3O5eAbTYG43PMGw9T1JWOhp8k3kfz4z/FwQp4bbAjQcus+LUPCSywYlCd/DgmF
        DhJjAauKBocmht3m40Gz9qo1fkyZ9wyqTOBCDkijKlZCA3Ti9H+2Wxf1ABFU9T9OE72AJX
        +w7YEdQZScxam4m1/6enYGem6rnc7abIgm5nJqlXzFIF+kchqXAszxkyK+C0A8hDkox/A7
        5UlA2a2atm/S1FRLHsOq1wfpS9thFGQBRa0ukyv//nkHVCTOhiYX/rXW2usTdA==
X-Mailbox-Line: From af1fb8e9de157431a5a912f7a03f6ff70d4263cd Mon Sep 17 00:00:00 2001
Message-Id: <af1fb8e9de157431a5a912f7a03f6ff70d4263cd.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:43:08 +0100
Subject: [PATCH 12/13] usb: core: config: remove multiple assignments
X-Rspamd-Queue-Id: 36DF8188F
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warning at multiple locations:

CHECK:MULTIPLE_ASSIGNMENTS: multiple assignments should be avoided

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index ab3395ec4260..1fe995a66182 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -342,7 +342,8 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 			 */
 			if (udev->quirks & USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL) {
 				n = clamp(fls(d->bInterval) + 3, i, j);
-				i = j = n;
+				j = n;
+				i = j;
 			}
 			/*
 			 * This quirk fixes bIntervals reported in
@@ -350,7 +351,8 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 			 */
 			if (udev->quirks & USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL) {
 				n = clamp(fls(d->bInterval), i, j);
-				i = j = n;
+				j = n;
+				i = j;
 			}
 			break;
 		default:		/* USB_SPEED_FULL or _LOW */
@@ -554,7 +556,8 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	size -= i;
 
 	/* Allocate space for the right(?) number of endpoints */
-	num_ep = num_ep_orig = alt->desc.bNumEndpoints;
+	num_ep_orig = alt->desc.bNumEndpoints;
+	num_ep = num_ep_orig;
 	alt->desc.bNumEndpoints = 0;		/* Use as a counter */
 	if (num_ep > USB_MAXENDPOINTS) {
 		dev_warn(ddev,
@@ -616,7 +619,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	unsigned int iad_num = 0;
 
 	memcpy(&config->desc, buffer, USB_DT_CONFIG_SIZE);
-	nintf = nintf_orig = config->desc.bNumInterfaces;
+	nintf_orig = config->desc.bNumInterfaces;
+	nintf = nintf_orig;
 	config->desc.bNumInterfaces = 0;	// Adjusted later
 
 	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
@@ -741,7 +745,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			 cfgno, n, plural(n), nintf_orig);
 	else if (n == 0)
 		dev_warn(ddev, "config %d has no interfaces?\n", cfgno);
-	config->desc.bNumInterfaces = nintf = n;
+	nintf = n;
+	config->desc.bNumInterfaces = nintf;
 
 	/* Check for missing interface numbers */
 	for (i = 0; i < nintf; ++i) {
@@ -762,7 +767,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			dev_warn(ddev,
 				 "too many alternate settings for config %d interface %d: %d, using maximum allowed: %d\n",
 				 cfgno, inums[i], j, USB_MAXALTSETTING);
-			nalts[i] = j = USB_MAXALTSETTING;
+			j = USB_MAXALTSETTING;
+			nalts[i] = j;
 		}
 
 		intfc = kzalloc(struct_size(intfc, altsetting, j), GFP_KERNEL);
@@ -867,7 +873,8 @@ int usb_get_configuration(struct usb_device *dev)
 		dev_warn(ddev,
 			 "too many configurations: %d, using maximum allowed: %d\n",
 			 ncfg, USB_MAXCONFIG);
-		dev->descriptor.bNumConfigurations = ncfg = USB_MAXCONFIG;
+		ncfg = USB_MAXCONFIG;
+		dev->descriptor.bNumConfigurations = ncfg;
 	}
 
 	if (ncfg < 1) {
-- 
2.32.0

