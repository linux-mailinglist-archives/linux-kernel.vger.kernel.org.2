Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2080422A20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhJEOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbhJEOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:09 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A26C08E86A;
        Tue,  5 Oct 2021 07:03:27 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HNznn5CW0zQkSX;
        Tue,  5 Oct 2021 16:03:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=OzhPqsCgRjc99rDYjM4KQ72SeZ8m/fONRusVoznTr3E=;
        b=mLw3rSpnxqDegAEeopmzRydAaz745dZIBimiFiMYECI6RnBaavL+//VR7j+V8xNo+nPEhs
        kOHvKyArjQteeomczbBM/o+vWYHwgH5QUoTXmvXsvrHTa5KnzJw42MYVXkOjn/rM+gsymr
        /UUn+jw5YdmHfuaQ+1yw1J9MrXnqSzl1CFs4eFjKJnPD4BBsNQfejq2yBeVdw6OwJBjGOr
        wYJREiFPXyteDdi4LQxywLVMnQqNlzjMB20cPRo827wghDDO+yfHT/wtRjA7tgIS6uFUCg
        g5TN4O+6RUaMProe8tyJD7nFxyFv85NY8advb23a0ali7AjGEOBNYEnjY4xz2w==
X-Mailbox-Line: From da05f4a46e5183a0aa067673159fb70ae6621403 Mon Sep 17 00:00:00 2001
Message-Id: <da05f4a46e5183a0aa067673159fb70ae6621403.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 13:31:37 +0100
Subject: [PATCH 02/13] usb: core: config: fix block comment styles
X-Rspamd-Queue-Id: 020CC268
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning at lines 45, 467, 547, 646, 696,
782, 897:

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 52b0edee5b55..52aab1462787 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -42,7 +42,8 @@ static int find_next_descriptor(unsigned char *buffer, int size,
 	}
 
 	/* Store the number of descriptors skipped and return the
-	 * number of bytes skipped */
+	 * number of bytes skipped
+	 */
 	if (num_skipped)
 		*num_skipped = n;
 	return buffer - buffer0;
@@ -464,7 +465,8 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 				inum, asnum, endpoint, buffer, size);
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
-	 * find the next endpoint or interface descriptor */
+	 * find the next endpoint or interface descriptor
+	 */
 	endpoint->extra = buffer;
 	i = find_next_descriptor(buffer, size, USB_DT_ENDPOINT,
 			USB_DT_INTERFACE, &n);
@@ -544,7 +546,8 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	memcpy(&alt->desc, d, USB_DT_INTERFACE_SIZE);
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
-	 * find the first endpoint or interface descriptor */
+	 * find the first endpoint or interface descriptor
+	 */
 	alt->extra = buffer;
 	i = find_next_descriptor(buffer, size, USB_DT_ENDPOINT,
 	    USB_DT_INTERFACE, &n);
@@ -643,7 +646,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	}
 
 	/* Go through the descriptors, checking their length and counting the
-	 * number of altsettings for each interface */
+	 * number of altsettings for each interface
+	 */
 	n = 0;
 	for ((buffer2 = buffer, size2 = size);
 	      size2 > 0;
@@ -693,7 +697,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 				    cfgno, inum, nintf_orig - 1);
 
 			/* Have we already encountered this interface?
-			 * Count its altsettings */
+			 * Count its altsettings
+			 */
 			for (i = 0; i < n; ++i) {
 				if (inums[i] == inum)
 					break;
@@ -779,7 +784,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	/* FIXME: parse the BOS descriptor */
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
-	 * find the first interface descriptor */
+	 * find the first interface descriptor
+	 */
 	config->extra = buffer;
 	i = find_next_descriptor(buffer, size, USB_DT_INTERFACE,
 	    USB_DT_INTERFACE, &n);
@@ -894,7 +900,8 @@ int usb_get_configuration(struct usb_device *dev)
 
 	for (cfgno = 0; cfgno < ncfg; cfgno++) {
 		/* We grab just the first descriptor so we know how long
-		 * the whole configuration is */
+		 * the whole configuration is
+		 */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
 		    desc, USB_DT_CONFIG_SIZE);
 		if (result < 0) {
-- 
2.32.0

