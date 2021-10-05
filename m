Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA8422A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhJEOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbhJEOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:09 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB7C08E86B;
        Tue,  5 Oct 2021 07:03:27 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HNznp1jCQzQkZm;
        Tue,  5 Oct 2021 16:03:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=fqo3O/9/epAUV0GXP9kWNRcnLVhhtBguy9K48WqISWE=;
        b=JE2bmWyaOwj3lG0VWTUHder+3VLfd747BJlkilEHutPH2xk8qqsA0PqGTlmHKyy4f3CoZr
        QIn7ofaJTTeXUXrCOkhSpInsL0nmoWMgp9y633b72UDHFzQuTVFulVsA6KL5Ma0dVfit0Y
        iRcUi/aiWjmwxuF6OsIex8xaYeCd32OQtpEeCPdlQJQx7ltMbYiAo96VePZt+zGexGhDIQ
        3MBizV3uA5So4+U56LT9fLTPZaNbF9/s86ZXk9TbZs1KF9DkY+i31V+lQCqDGY07aP5D6x
        2STN4StUwji9d0lSYa+oEllvnEHtQzi56wvx7Uldcgx+PNMb0GL3MgBmQk5LHQ==
X-Mailbox-Line: From 1a69658a8abf6d22fe9121228f57d5a0e9390c34 Mon Sep 17 00:00:00 2001
Message-Id: <1a69658a8abf6d22fe9121228f57d5a0e9390c34.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:22:42 +0100
Subject: [PATCH 06/13] usb: core: config: unsplit strings which are split
 across lines
X-Rspamd-Queue-Id: 86CFC272
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning across many lines:

WARNING:SPLIT_STRING: quoted string split across lines

This fix will make it easier to grep these strings in the source code.

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 224 +++++++++++++++++++-------------------
 1 file changed, 110 insertions(+), 114 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index c7451081b08b..51c590da7651 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -62,8 +62,8 @@ static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
 	desc = (struct usb_ssp_isoc_ep_comp_descriptor *) buffer;
 	if (desc->bDescriptorType != USB_DT_SSP_ISOC_ENDPOINT_COMP ||
 	    size < USB_DT_SSP_ISOC_EP_COMP_SIZE) {
-		dev_warn(ddev, "Invalid SuperSpeedPlus isoc endpoint companion "
-			 "for config %d interface %d altsetting %d ep %d.\n",
+		dev_warn(ddev,
+			 "Invalid SuperSpeedPlus isoc endpoint companion for config %d interface %d altsetting %d ep %d.\n",
 			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		return;
 	}
@@ -84,10 +84,9 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 
 	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP ||
 			size < USB_DT_SS_EP_COMP_SIZE) {
-		dev_warn(ddev, "No SuperSpeed endpoint companion for config %d "
-				" interface %d altsetting %d ep %d: "
-				"using minimum values\n",
-				cfgno, inum, asnum, ep->desc.bEndpointAddress);
+		dev_warn(ddev,
+			 "No SuperSpeed endpoint companion for config %d interface %d altsetting %d ep %d: using minimum values\n",
+			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 
 		/* Fill in some default values.
 		 * Leave bmAttributes as zero, which will mean no streams for
@@ -110,44 +109,41 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 
 	/* Check the various values */
 	if (usb_endpoint_xfer_control(&ep->desc) && desc->bMaxBurst != 0) {
-		dev_warn(ddev, "Control endpoint with bMaxBurst = %d in "
-				"config %d interface %d altsetting %d ep %d: "
-				"setting to zero\n", desc->bMaxBurst,
-				cfgno, inum, asnum, ep->desc.bEndpointAddress);
+		dev_warn(ddev,
+			 "Control endpoint with bMaxBurst = %d in config %d interface %d altsetting %d ep %d: setting to zero\n",
+			 desc->bMaxBurst, cfgno, inum, asnum,
+			 ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bMaxBurst = 0;
 	} else if (desc->bMaxBurst > 15) {
-		dev_warn(ddev, "Endpoint with bMaxBurst = %d in "
-				"config %d interface %d altsetting %d ep %d: "
-				"setting to 15\n", desc->bMaxBurst,
-				cfgno, inum, asnum, ep->desc.bEndpointAddress);
+		dev_warn(ddev,
+			 "Endpoint with bMaxBurst = %d in config %d interface %d altsetting %d ep %d: setting to 15\n",
+			 desc->bMaxBurst,
+			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bMaxBurst = 15;
 	}
 
 	if ((usb_endpoint_xfer_control(&ep->desc) ||
 			usb_endpoint_xfer_int(&ep->desc)) &&
 				desc->bmAttributes != 0) {
-		dev_warn(ddev, "%s endpoint with bmAttributes = %d in "
-				"config %d interface %d altsetting %d ep %d: "
-				"setting to zero\n",
-				usb_endpoint_xfer_control(&ep->desc) ? "Control" : "Bulk",
-				desc->bmAttributes,
-				cfgno, inum, asnum, ep->desc.bEndpointAddress);
+		dev_warn(ddev,
+			 "%s endpoint with bmAttributes = %d in config %d interface %d altsetting %d ep %d: setting to zero\n",
+			 usb_endpoint_xfer_control(&ep->desc) ? "Control" : "Bulk",
+			 desc->bmAttributes,
+			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bmAttributes = 0;
 	} else if (usb_endpoint_xfer_bulk(&ep->desc) &&
 			desc->bmAttributes > 16) {
-		dev_warn(ddev, "Bulk endpoint with more than 65536 streams in "
-				"config %d interface %d altsetting %d ep %d: "
-				"setting to max\n",
-				cfgno, inum, asnum, ep->desc.bEndpointAddress);
+		dev_warn(ddev,
+			 "Bulk endpoint with more than 65536 streams in config %d interface %d altsetting %d ep %d: setting to max\n",
+			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bmAttributes = 16;
 	} else if (usb_endpoint_xfer_isoc(&ep->desc) &&
 		   !USB_SS_SSP_ISOC_COMP(desc->bmAttributes) &&
 		   USB_SS_MULT(desc->bmAttributes) > 3) {
-		dev_warn(ddev, "Isoc endpoint has Mult of %d in "
-				"config %d interface %d altsetting %d ep %d: "
-				"setting to 3\n",
-				USB_SS_MULT(desc->bmAttributes),
-				cfgno, inum, asnum, ep->desc.bEndpointAddress);
+		dev_warn(ddev,
+			 "Isoc endpoint has Mult of %d in config %d interface %d altsetting %d ep %d: setting to 3\n",
+			 USB_SS_MULT(desc->bmAttributes),
+			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bmAttributes = 2;
 	}
 
@@ -161,13 +157,12 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	else
 		max_tx = 999999;
 	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx) {
-		dev_warn(ddev, "%s endpoint with wBytesPerInterval of %d in "
-				"config %d interface %d altsetting %d ep %d: "
-				"setting to %d\n",
-				usb_endpoint_xfer_isoc(&ep->desc) ? "Isoc" : "Int",
-				le16_to_cpu(desc->wBytesPerInterval),
-				cfgno, inum, asnum, ep->desc.bEndpointAddress,
-				max_tx);
+		dev_warn(ddev,
+			 "%s endpoint with wBytesPerInterval of %d in config %d interface %d altsetting %d ep %d: setting to %d\n",
+			 usb_endpoint_xfer_isoc(&ep->desc) ? "Isoc" : "Int",
+			 le16_to_cpu(desc->wBytesPerInterval),
+			 cfgno, inum, asnum, ep->desc.bEndpointAddress,
+			 max_tx);
 		ep->ss_ep_comp.wBytesPerInterval = cpu_to_le16(max_tx);
 	}
 	/* Parse a possible SuperSpeedPlus isoc ep companion descriptor */
@@ -274,17 +269,17 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	else if (d->bLength >= USB_DT_ENDPOINT_SIZE)
 		n = USB_DT_ENDPOINT_SIZE;
 	else {
-		dev_warn(ddev, "config %d interface %d altsetting %d has an "
-		    "invalid endpoint descriptor of length %d, skipping\n",
-		    cfgno, inum, asnum, d->bLength);
+		dev_warn(ddev,
+			 "config %d interface %d altsetting %d has an invalid endpoint descriptor of length %d, skipping\n",
+			 cfgno, inum, asnum, d->bLength);
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
 	i = d->bEndpointAddress & ~USB_ENDPOINT_DIR_MASK;
 	if (i >= 16 || i == 0) {
-		dev_warn(ddev, "config %d interface %d altsetting %d has an "
-		    "invalid endpoint with address 0x%X, skipping\n",
-		    cfgno, inum, asnum, d->bEndpointAddress);
+		dev_warn(ddev,
+			 "config %d interface %d altsetting %d has an invalid endpoint with address 0x%X, skipping\n",
+			 cfgno, inum, asnum, d->bEndpointAddress);
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
@@ -379,10 +374,9 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		}
 	}
 	if (d->bInterval < i || d->bInterval > j) {
-		dev_warn(ddev, "config %d interface %d altsetting %d "
-		    "endpoint 0x%X has an invalid bInterval %d, "
-		    "changing to %d\n",
-		    cfgno, inum, asnum,
+		dev_warn(ddev,
+			 "config %d interface %d altsetting %d endpoint 0x%X has an invalid bInterval %d, changing to %d\n",
+			 cfgno, inum, asnum,
 		    d->bEndpointAddress, d->bInterval, n);
 		endpoint->desc.bInterval = n;
 	}
@@ -392,9 +386,9 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 * them usable, we will try treating them as Interrupt endpoints.
 	 */
 	if (udev->speed == USB_SPEED_LOW && usb_endpoint_xfer_bulk(d)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d "
-		    "endpoint 0x%X is Bulk; changing to Interrupt\n",
-		    cfgno, inum, asnum, d->bEndpointAddress);
+		dev_warn(ddev,
+			 "config %d interface %d altsetting %d endpoint 0x%X is Bulk; changing to Interrupt\n",
+			 cfgno, inum, asnum, d->bEndpointAddress);
 		endpoint->desc.bmAttributes = USB_ENDPOINT_XFER_INT;
 		endpoint->desc.bInterval = 1;
 		if (usb_endpoint_maxp(&endpoint->desc) > 8)
@@ -453,10 +447,10 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 */
 	if (udev->speed == USB_SPEED_HIGH && usb_endpoint_xfer_bulk(d)) {
 		if (maxp != 512)
-			dev_warn(ddev, "config %d interface %d altsetting %d "
-				"bulk endpoint 0x%X has invalid maxpacket %d\n",
-				cfgno, inum, asnum, d->bEndpointAddress,
-				maxp);
+			dev_warn(ddev,
+				 "config %d interface %d altsetting %d bulk endpoint 0x%X has invalid maxpacket %d\n",
+				 cfgno, inum, asnum, d->bEndpointAddress,
+				 maxp);
 	}
 
 	/* Parse a possible SuperSpeed endpoint companion descriptor */
@@ -535,9 +529,9 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	      i < intfc->num_altsetting;
 	     (++i, ++alt)) {
 		if (alt->desc.bAlternateSetting == asnum) {
-			dev_warn(ddev, "Duplicate descriptor for config %d "
-			    "interface %d altsetting %d, skipping\n",
-			    cfgno, inum, asnum);
+			dev_warn(ddev,
+				 "Duplicate descriptor for config %d interface %d altsetting %d, skipping\n",
+				 cfgno, inum, asnum);
 			goto skip_to_next_interface_descriptor;
 		}
 	}
@@ -562,9 +556,9 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	num_ep = num_ep_orig = alt->desc.bNumEndpoints;
 	alt->desc.bNumEndpoints = 0;		/* Use as a counter */
 	if (num_ep > USB_MAXENDPOINTS) {
-		dev_warn(ddev, "too many endpoints for config %d interface %d "
-		    "altsetting %d: %d, using maximum allowed: %d\n",
-		    cfgno, inum, asnum, num_ep, USB_MAXENDPOINTS);
+		dev_warn(ddev,
+			 "too many endpoints for config %d interface %d altsetting %d: %d, using maximum allowed: %d\n",
+			 cfgno, inum, asnum, num_ep, USB_MAXENDPOINTS);
 		num_ep = USB_MAXENDPOINTS;
 	}
 
@@ -593,10 +587,9 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	}
 
 	if (n != num_ep_orig)
-		dev_warn(ddev, "config %d interface %d altsetting %d has %d "
-		    "endpoint descriptor%s, different from the interface "
-		    "descriptor's value: %d\n",
-		    cfgno, inum, asnum, n, plural(n), num_ep_orig);
+		dev_warn(ddev,
+			 "config %d interface %d altsetting %d has %d endpoint descriptor%s, different from the interface descriptor's value: %d\n",
+			 cfgno, inum, asnum, n, plural(n), num_ep_orig);
 	return buffer - buffer0;
 
 skip_to_next_interface_descriptor:
@@ -628,9 +621,9 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
 	    config->desc.bLength < USB_DT_CONFIG_SIZE ||
 	    config->desc.bLength > size) {
-		dev_err(ddev, "invalid descriptor for config index %d: "
-		    "type = 0x%X, length = %d\n", cfgidx,
-		    config->desc.bDescriptorType, config->desc.bLength);
+		dev_err(ddev, "invalid descriptor for config index %d: type = 0x%X, length = %d\n",
+			cfgidx, config->desc.bDescriptorType,
+			config->desc.bLength);
 		return -EINVAL;
 	}
 	cfgno = config->desc.bConfigurationValue;
@@ -639,9 +632,9 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	size -= config->desc.bLength;
 
 	if (nintf > USB_MAXINTERFACES) {
-		dev_warn(ddev, "config %d has too many interfaces: %d, "
-		    "using maximum allowed: %d\n",
-		    cfgno, nintf, USB_MAXINTERFACES);
+		dev_warn(ddev,
+			 "config %d has too many interfaces: %d, using maximum allowed: %d\n",
+			 cfgno, nintf, USB_MAXINTERFACES);
 		nintf = USB_MAXINTERFACES;
 	}
 
@@ -654,17 +647,17 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	     (buffer2 += header->bLength, size2 -= header->bLength)) {
 
 		if (size2 < sizeof(struct usb_descriptor_header)) {
-			dev_warn(ddev, "config %d descriptor has %d excess "
-			    "byte%s, ignoring\n",
-			    cfgno, size2, plural(size2));
+			dev_warn(ddev,
+				 "config %d descriptor has %d excess byte%s, ignoring\n",
+				 cfgno, size2, plural(size2));
 			break;
 		}
 
 		header = (struct usb_descriptor_header *) buffer2;
 		if ((header->bLength > size2) || (header->bLength < 2)) {
-			dev_warn(ddev, "config %d has an invalid descriptor "
-			    "of length %d, skipping remainder of the config\n",
-			    cfgno, header->bLength);
+			dev_warn(ddev,
+				 "config %d has an invalid descriptor of length %d, skipping remainder of the config\n",
+				 cfgno, header->bLength);
 			break;
 		}
 
@@ -674,9 +667,9 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			d = (struct usb_interface_descriptor *) header;
 			if (d->bLength < USB_DT_INTERFACE_SIZE) {
-				dev_warn(ddev, "config %d has an invalid "
-				    "interface descriptor of length %d, "
-				    "skipping\n", cfgno, d->bLength);
+				dev_warn(ddev,
+					 "config %d has an invalid interface descriptor of length %d, skipping\n",
+					 cfgno, d->bLength);
 				continue;
 			}
 
@@ -684,17 +677,16 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			if ((dev->quirks & USB_QUIRK_HONOR_BNUMINTERFACES) &&
 			    n >= nintf_orig) {
-				dev_warn(ddev, "config %d has more interface "
-				    "descriptors, than it declares in "
-				    "bNumInterfaces, ignoring interface "
-				    "number: %d\n", cfgno, inum);
+				dev_warn(ddev,
+					 "config %d has more interface descriptors, than it declares in bNumInterfaces, ignoring interface number: %d\n",
+					 cfgno, inum);
 				continue;
 			}
 
 			if (inum >= nintf_orig)
-				dev_warn(ddev, "config %d has an invalid "
-				    "interface number: %d but max is %d\n",
-				    cfgno, inum, nintf_orig - 1);
+				dev_warn(ddev,
+					 "config %d has an invalid interface number: %d but max is %d\n",
+					 cfgno, inum, nintf_orig - 1);
 
 			/* Have we already encountered this interface?
 			 * Count its altsettings
@@ -725,10 +717,9 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			}
 
 			if (iad_num == USB_MAXIADS) {
-				dev_warn(ddev, "found more Interface "
-					       "Association Descriptors "
-					       "than allocated for in "
-					       "configuration %d\n", cfgno);
+				dev_warn(ddev,
+					 "found more Interface Association Descriptors than allocated for in configuration %d\n",
+					cfgno);
 			} else {
 				config->intf_assoc[iad_num] = d;
 				iad_num++;
@@ -736,18 +727,18 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 		} else if (header->bDescriptorType == USB_DT_DEVICE ||
 			    header->bDescriptorType == USB_DT_CONFIG)
-			dev_warn(ddev, "config %d contains an unexpected "
-			    "descriptor of type 0x%X, skipping\n",
-			    cfgno, header->bDescriptorType);
+			dev_warn(ddev,
+				 "config %d contains an unexpected descriptor of type 0x%X, skipping\n",
+				 cfgno, header->bDescriptorType);
 
 	}	/* for ((buffer2 = buffer, size2 = size); ...) */
 	size = buffer2 - buffer;
 	config->desc.wTotalLength = cpu_to_le16(buffer2 - buffer0);
 
 	if (n != nintf)
-		dev_warn(ddev, "config %d has %d interface%s, different from "
-		    "the descriptor's value: %d\n",
-		    cfgno, n, plural(n), nintf_orig);
+		dev_warn(ddev,
+			 "config %d has %d interface%s, different from the descriptor's value: %d\n",
+			 cfgno, n, plural(n), nintf_orig);
 	else if (n == 0)
 		dev_warn(ddev, "config %d has no interfaces?\n", cfgno);
 	config->desc.bNumInterfaces = nintf = n;
@@ -759,18 +750,18 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 				break;
 		}
 		if (j >= nintf)
-			dev_warn(ddev, "config %d has no interface number "
-			    "%d\n", cfgno, i);
+			dev_warn(ddev,
+				 "config %d has no interface number %d\n",
+				 cfgno, i);
 	}
 
 	/* Allocate the usb_interface_caches and altsetting arrays */
 	for (i = 0; i < nintf; ++i) {
 		j = nalts[i];
 		if (j > USB_MAXALTSETTING) {
-			dev_warn(ddev, "too many alternate settings for "
-			    "config %d interface %d: %d, "
-			    "using maximum allowed: %d\n",
-			    cfgno, inums[i], j, USB_MAXALTSETTING);
+			dev_warn(ddev,
+				 "too many alternate settings for config %d interface %d: %d, using maximum allowed: %d\n",
+				 cfgno, inums[i], j, USB_MAXALTSETTING);
 			nalts[i] = j = USB_MAXALTSETTING;
 		}
 
@@ -816,8 +807,9 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 					break;
 			}
 			if (n >= intfc->num_altsetting)
-				dev_warn(ddev, "config %d interface %d has no "
-				    "altsetting %d\n", cfgno, inums[i], j);
+				dev_warn(ddev,
+					 "config %d interface %d has no altsetting %d\n",
+					 cfgno, inums[i], j);
 		}
 	}
 
@@ -873,8 +865,9 @@ int usb_get_configuration(struct usb_device *dev)
 	int result;
 
 	if (ncfg > USB_MAXCONFIG) {
-		dev_warn(ddev, "too many configurations: %d, "
-		    "using maximum allowed: %d\n", ncfg, USB_MAXCONFIG);
+		dev_warn(ddev,
+			 "too many configurations: %d, using maximum allowed: %d\n",
+			 ncfg, USB_MAXCONFIG);
 		dev->descriptor.bNumConfigurations = ncfg = USB_MAXCONFIG;
 	}
 
@@ -904,17 +897,18 @@ int usb_get_configuration(struct usb_device *dev)
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
 		    desc, USB_DT_CONFIG_SIZE);
 		if (result < 0) {
-			dev_err(ddev, "unable to read config index %d "
-			    "descriptor/%s: %d\n", cfgno, "start", result);
+			dev_err(ddev,
+				"unable to read config index %d descriptor/%s: %d\n",
+				cfgno, "start", result);
 			if (result != -EPIPE)
 				goto err;
 			dev_err(ddev, "chopping to %d config(s)\n", cfgno);
 			dev->descriptor.bNumConfigurations = cfgno;
 			break;
 		} else if (result < 4) {
-			dev_err(ddev, "config index %d descriptor too short "
-			    "(expected %i, got %i)\n", cfgno,
-			    USB_DT_CONFIG_SIZE, result);
+			dev_err(ddev,
+				"config index %d descriptor too short (expected %i, got %i)\n",
+				cfgno, USB_DT_CONFIG_SIZE, result);
 			result = -EINVAL;
 			goto err;
 		}
@@ -934,14 +928,16 @@ int usb_get_configuration(struct usb_device *dev)
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
 		    bigbuffer, length);
 		if (result < 0) {
-			dev_err(ddev, "unable to read config index %d "
-			    "descriptor/%s\n", cfgno, "all");
+			dev_err(ddev,
+				"unable to read config index %d descriptor/%s\n",
+				cfgno, "all");
 			kfree(bigbuffer);
 			goto err;
 		}
 		if (result < length) {
-			dev_warn(ddev, "config index %d descriptor too short "
-			    "(expected %i, got %i)\n", cfgno, length, result);
+			dev_warn(ddev,
+				 "config index %d descriptor too short (expected %i, got %i)\n",
+				 cfgno, length, result);
 			length = result;
 		}
 
-- 
2.32.0

