Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953F0422A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhJEOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhJEOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:12 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E0C08EA48;
        Tue,  5 Oct 2021 07:03:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HNzns1vgVzQkBh;
        Tue,  5 Oct 2021 16:03:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=rNhLsyCLq4qKkSJBH/0nPNy5VFhxhCPgg0+RJqtGwSk=;
        b=SQh2lnE/BURZjkTtevZt0SP9aRQbLYNMpdTZW5kejxb/2OyVOYCtOcXDKFuUaoZ+aXR2JZ
        MkdnZztGCG5okULr2x6HWwSR0rc/+454Lzrb9GpXxOw3vINlnLYP/qAk4if8XepAgKNNMN
        MA3ehDm+3JkqAICmxjVbH/7H7ttE/Q/ihm/1kirZ6L+996bIFwPPsirc21JSGUx3G8VyIY
        kuF0dpuzSn/vWxTqYqzyGgWis2+FYPnB+1fH5Cz1pjBq9QwCS/1EZeTv67rBv5I26JkQox
        x3vMLIlpuXpLh8SJalXAHqaXUfjZl2Grp2y0bn2WPzjfB9UTg9aTTh1llFF/Uw==
X-Mailbox-Line: From d36b554ae066057954eda49dbadb4e1d97323bfd Mon Sep 17 00:00:00 2001
Message-Id: <d36b554ae066057954eda49dbadb4e1d97323bfd.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:30:49 +0100
Subject: [PATCH 09/13] usb: core: config: fix inline spacign
X-Rspamd-Queue-Id: 87B6C272
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warnings:

(many locations) CHECK:SPACING: No space is necessary after a cast
core/config.c:332: CHECK:SPACING: spaces preferred around that '*' (ctx:VxV)

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 3bf04fdf850a..9717f89bcb6f 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -31,7 +31,7 @@ static int find_next_descriptor(unsigned char *buffer, int size,
 
 	/* Find the next descriptor of type dt1 or dt2 */
 	while (size > 0) {
-		h = (struct usb_descriptor_header *) buffer;
+		h = (struct usb_descriptor_header *)buffer;
 		if (h->bDescriptorType == dt1 || h->bDescriptorType == dt2)
 			break;
 		buffer += h->bLength;
@@ -57,7 +57,7 @@ static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
 	 * The SuperSpeedPlus Isoc endpoint companion descriptor immediately
 	 * follows the SuperSpeed Endpoint Companion descriptor
 	 */
-	desc = (struct usb_ssp_isoc_ep_comp_descriptor *) buffer;
+	desc = (struct usb_ssp_isoc_ep_comp_descriptor *)buffer;
 	if (desc->bDescriptorType != USB_DT_SSP_ISOC_ENDPOINT_COMP ||
 	    size < USB_DT_SSP_ISOC_EP_COMP_SIZE) {
 		dev_warn(ddev,
@@ -78,7 +78,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	/* The SuperSpeed endpoint companion descriptor is supposed to
 	 * be the first thing immediately following the endpoint descriptor.
 	 */
-	desc = (struct usb_ss_ep_comp_descriptor *) buffer;
+	desc = (struct usb_ss_ep_comp_descriptor *)buffer;
 
 	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP ||
 			size < USB_DT_SS_EP_COMP_SIZE) {
@@ -261,7 +261,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	unsigned int maxp;
 	const unsigned short *maxpacket_maxes;
 
-	d = (struct usb_endpoint_descriptor *) buffer;
+	d = (struct usb_endpoint_descriptor *)buffer;
 	buffer += d->bLength;
 	size -= d->bLength;
 
@@ -329,7 +329,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 			 * descriptors. Try to fix those and fall back to an
 			 * 8-ms default value otherwise.
 			 */
-			n = fls(d->bInterval*8);
+			n = fls(d->bInterval * 8);
 			if (n == 0)
 				n = 7;	/* 8 ms = 2^(7-1) uframes */
 			j = 16;
@@ -505,7 +505,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	int len, retval;
 	int num_ep, num_ep_orig;
 
-	d = (struct usb_interface_descriptor *) buffer;
+	d = (struct usb_interface_descriptor *)buffer;
 	buffer += d->bLength;
 	size -= d->bLength;
 
@@ -574,7 +574,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	/* Parse all the endpoint descriptors */
 	n = 0;
 	while (size > 0) {
-		if (((struct usb_descriptor_header *) buffer)->bDescriptorType
+		if (((struct usb_descriptor_header *)buffer)->bDescriptorType
 		     == USB_DT_INTERFACE)
 			break;
 		retval = usb_parse_endpoint(ddev, cfgno, config, inum, asnum,
@@ -654,7 +654,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			break;
 		}
 
-		header = (struct usb_descriptor_header *) buffer2;
+		header = (struct usb_descriptor_header *)buffer2;
 		if ((header->bLength > size2) || (header->bLength < 2)) {
 			dev_warn(ddev,
 				 "config %d has an invalid descriptor of length %d, skipping remainder of the config\n",
@@ -666,7 +666,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			struct usb_interface_descriptor *d;
 			int inum;
 
-			d = (struct usb_interface_descriptor *) header;
+			d = (struct usb_interface_descriptor *)header;
 			if (d->bLength < USB_DT_INTERFACE_SIZE) {
 				dev_warn(ddev,
 					 "config %d has an invalid interface descriptor of length %d, skipping\n",
@@ -912,7 +912,7 @@ int usb_get_configuration(struct usb_device *dev)
 			result = -EINVAL;
 			goto err;
 		}
-		length = max((int) le16_to_cpu(desc->wTotalLength),
+		length = max((int)le16_to_cpu(desc->wTotalLength),
 		    USB_DT_CONFIG_SIZE);
 
 		/* Now that we know the length, get the whole thing */
-- 
2.32.0

