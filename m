Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDA422A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhJEOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbhJEOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:10 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62A7C08E89D;
        Tue,  5 Oct 2021 07:03:36 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HNznz0VLHzQkjm;
        Tue,  5 Oct 2021 16:03:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=ug6rDDzpKnA56k+77e0aEXwzq5oBN6KdvkwcQyZ0wkg=;
        b=OQEop257I0oKisJVYuxZnizx4T6JSIK/bdk+gxoKzoTC/1r6cp31FqKuSYoR/LX/XysGCv
        4b1xTlNZ2TtBOQWgxQFyd9SuC5Ashu2bCG5xzp/+8oVO/GZGAsh0tWlCUWP7uPMpngIEsE
        gKHrXuDf68YRVjQXFpfrsWmUX2G/ookPQleyy7iYbw9Cdzn4pFBKoQoVZ31jK+PWOO6ckO
        YfKtTVaiFdxqBYx0YGezBSFYYAf0jYb4w2Sx7dT+SxU0lCR+/5IWv4Ug+rMe1LgFjawHJV
        Kncu+iHWo5J2Ln1x4VTx30/OY8wgTcvnxgJ+NHk6VfsKogRFGIo0pALOe8pd2Q==
X-Mailbox-Line: From 835bbc4e27ca989674fb916f70b81038deaf47e5 Mon Sep 17 00:00:00 2001
Message-Id: <835bbc4e27ca989674fb916f70b81038deaf47e5.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:52:43 +0100
Subject: [PATCH 13/13] usb: core: config: fix parenthesis alignment
X-Rspamd-Queue-Id: 4981426E
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch.pl warnings at various locations:

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 87 +++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 1fe995a66182..94de1476e9d0 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -23,7 +23,7 @@ static inline const char *plural(int n)
 }
 
 static int find_next_descriptor(unsigned char *buffer, int size,
-		int dt1, int dt2, int *num_skipped)
+				int dt1, int dt2, int *num_skipped)
 {
 	struct usb_descriptor_header *h;
 	int n = 0;
@@ -48,8 +48,11 @@ static int find_next_descriptor(unsigned char *buffer, int size,
 }
 
 static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
-		int cfgno, int inum, int asnum, struct usb_host_endpoint *ep,
-		unsigned char *buffer, int size)
+						  int cfgno, int inum,
+						  int asnum,
+						  struct usb_host_endpoint *ep,
+						  unsigned char *buffer,
+						  int size)
 {
 	struct usb_ssp_isoc_ep_comp_descriptor *desc;
 
@@ -69,8 +72,9 @@ static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
 }
 
 static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
-		int inum, int asnum, struct usb_host_endpoint *ep,
-		unsigned char *buffer, int size)
+					    int inum, int asnum,
+					    struct usb_host_endpoint *ep,
+					    unsigned char *buffer, int size)
 {
 	struct usb_ss_ep_comp_descriptor *desc;
 	int max_tx;
@@ -81,7 +85,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	desc = (struct usb_ss_ep_comp_descriptor *)buffer;
 
 	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP ||
-			size < USB_DT_SS_EP_COMP_SIZE) {
+	    size < USB_DT_SS_EP_COMP_SIZE) {
 		dev_warn(ddev,
 			 "No SuperSpeed endpoint companion for config %d interface %d altsetting %d ep %d: using minimum values\n",
 			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -96,7 +100,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 		ep->ss_ep_comp.bLength = USB_DT_SS_EP_COMP_SIZE;
 		ep->ss_ep_comp.bDescriptorType = USB_DT_SS_ENDPOINT_COMP;
 		if (usb_endpoint_xfer_isoc(&ep->desc) ||
-				usb_endpoint_xfer_int(&ep->desc))
+		    usb_endpoint_xfer_int(&ep->desc))
 			ep->ss_ep_comp.wBytesPerInterval =
 					ep->desc.wMaxPacketSize;
 		return;
@@ -121,8 +125,8 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	}
 
 	if ((usb_endpoint_xfer_control(&ep->desc) ||
-			usb_endpoint_xfer_int(&ep->desc)) &&
-				desc->bmAttributes != 0) {
+	     usb_endpoint_xfer_int(&ep->desc)) &&
+	    desc->bmAttributes != 0) {
 		dev_warn(ddev,
 			 "%s endpoint with bmAttributes = %d in config %d interface %d altsetting %d ep %d: setting to zero\n",
 			 usb_endpoint_xfer_control(&ep->desc) ? "Control" : "Bulk",
@@ -167,7 +171,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	if (usb_endpoint_xfer_isoc(&ep->desc) &&
 	    USB_SS_SSP_ISOC_COMP(desc->bmAttributes))
 		usb_parse_ssp_isoc_endpoint_companion(ddev, cfgno, inum, asnum,
-							ep, buffer, size);
+						      ep, buffer, size);
 }
 
 static const unsigned short low_speed_maxpacket_maxes[4] = {
@@ -201,7 +205,7 @@ static const unsigned short super_speed_maxpacket_maxes[4] = {
 };
 
 static bool endpoint_is_duplicate(struct usb_endpoint_descriptor *e1,
-		struct usb_endpoint_descriptor *e2)
+				  struct usb_endpoint_descriptor *e2)
 {
 	if (e1->bEndpointAddress == e2->bEndpointAddress)
 		return true;
@@ -219,7 +223,8 @@ static bool endpoint_is_duplicate(struct usb_endpoint_descriptor *e1,
  * altsetting currently being parsed.
  */
 static bool config_endpoint_is_duplicate(struct usb_host_config *config,
-		int inum, int asnum, struct usb_endpoint_descriptor *d)
+					 int inum, int asnum,
+					 struct usb_endpoint_descriptor *d)
 {
 	struct usb_endpoint_descriptor *epd;
 	struct usb_interface_cache *intfc;
@@ -233,7 +238,7 @@ static bool config_endpoint_is_duplicate(struct usb_host_config *config,
 			alt = &intfc->altsetting[j];
 
 			if (alt->desc.bInterfaceNumber == inum &&
-					alt->desc.bAlternateSetting != asnum)
+			    alt->desc.bAlternateSetting != asnum)
 				continue;
 
 			for (k = 0; k < alt->desc.bNumEndpoints; ++k) {
@@ -249,9 +254,9 @@ static bool config_endpoint_is_duplicate(struct usb_host_config *config,
 }
 
 static int usb_parse_endpoint(struct device *ddev, int cfgno,
-		struct usb_host_config *config, int inum, int asnum,
-		struct usb_host_interface *ifp, int num_ep,
-		unsigned char *buffer, int size)
+			      struct usb_host_config *config, int inum,
+			      int asnum, struct usb_host_interface *ifp,
+			      int num_ep, unsigned char *buffer, int size)
 {
 	struct usb_device *udev = to_usb_device(ddev);
 	unsigned char *buffer0 = buffer;
@@ -291,7 +296,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
 		dev_warn(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
-				cfgno, inum, asnum, d->bEndpointAddress);
+			 cfgno, inum, asnum, d->bEndpointAddress);
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
@@ -299,8 +304,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	if (udev->quirks & USB_QUIRK_ENDPOINT_IGNORE) {
 		if (usb_endpoint_is_ignored(udev, ifp, d)) {
 			dev_warn(ddev, "config %d interface %d altsetting %d has an ignored endpoint with address 0x%X, skipping\n",
-					cfgno, inum, asnum,
-					d->bEndpointAddress);
+				 cfgno, inum, asnum, d->bEndpointAddress);
 			goto skip_to_next_endpoint_or_interface_descriptor;
 		}
 	}
@@ -407,7 +411,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	maxp = usb_endpoint_maxp(&endpoint->desc);
 	if (maxp == 0 && !(usb_endpoint_xfer_isoc(d) && asnum == 0)) {
 		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
-		    cfgno, inum, asnum, d->bEndpointAddress);
+			 cfgno, inum, asnum, d->bEndpointAddress);
 	}
 
 	/* Find the highest legal maxpacket size for this endpoint */
@@ -438,7 +442,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	if (maxp > j) {
 		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid maxpacket %d, setting to %d\n",
-		    cfgno, inum, asnum, d->bEndpointAddress, maxp, j);
+			 cfgno, inum, asnum, d->bEndpointAddress, maxp, j);
 		maxp = j;
 		endpoint->desc.wMaxPacketSize = cpu_to_le16(i | maxp);
 	}
@@ -459,24 +463,24 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	/* Parse a possible SuperSpeed endpoint companion descriptor */
 	if (udev->speed >= USB_SPEED_SUPER)
 		usb_parse_ss_endpoint_companion(ddev, cfgno,
-				inum, asnum, endpoint, buffer, size);
+						inum, asnum, endpoint, buffer, size);
 
 	/* Skip over any Class Specific or Vendor Specific descriptors;
 	 * find the next endpoint or interface descriptor
 	 */
 	endpoint->extra = buffer;
 	i = find_next_descriptor(buffer, size, USB_DT_ENDPOINT,
-			USB_DT_INTERFACE, &n);
+				 USB_DT_INTERFACE, &n);
 	endpoint->extralen = i;
 	retval = buffer - buffer0 + i;
 	if (n > 0)
 		dev_dbg(ddev, "skipped %d descriptor%s after %s\n",
-		    n, plural(n), "endpoint");
+			n, plural(n), "endpoint");
 	return retval;
 
 skip_to_next_endpoint_or_interface_descriptor:
 	i = find_next_descriptor(buffer, size, USB_DT_ENDPOINT,
-	    USB_DT_INTERFACE, NULL);
+				 USB_DT_INTERFACE, NULL);
 	return buffer - buffer0 + i;
 }
 
@@ -495,8 +499,9 @@ void usb_release_interface_cache(struct kref *ref)
 }
 
 static int usb_parse_interface(struct device *ddev, int cfgno,
-		struct usb_host_config *config, unsigned char *buffer, int size,
-		s[], u8 nalts[])
+			       struct usb_host_config *config,
+			       unsigned char *buffer, int size, s[],
+			       u8 nalts[])
 {
 	unsigned char *buffer0 = buffer;
 	struct usb_interface_descriptor	*d;
@@ -547,11 +552,11 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	 */
 	alt->extra = buffer;
 	i = find_next_descriptor(buffer, size, USB_DT_ENDPOINT,
-	    USB_DT_INTERFACE, &n);
+				 USB_DT_INTERFACE, &n);
 	alt->extralen = i;
 	if (n > 0)
 		dev_dbg(ddev, "skipped %d descriptor%s after %s\n",
-		    n, plural(n), "interface");
+			n, plural(n), "interface");
 	buffer += i;
 	size -= i;
 
@@ -581,7 +586,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 		     == USB_DT_INTERFACE)
 			break;
 		retval = usb_parse_endpoint(ddev, cfgno, config, inum, asnum,
-				alt, num_ep, buffer, size);
+					    alt, num_ep, buffer, size);
 		if (retval < 0)
 			return retval;
 		++n;
@@ -598,12 +603,13 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 
 skip_to_next_interface_descriptor:
 	i = find_next_descriptor(buffer, size, USB_DT_INTERFACE,
-	    USB_DT_INTERFACE, NULL);
+				 USB_DT_INTERFACE, NULL);
 	return buffer - buffer0 + i;
 }
 
 static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
-		struct usb_host_config *config, unsigned char *buffer, int size)
+				   struct usb_host_config *config,
+				   unsigned char *buffer, int size)
 {
 	struct device *ddev = &dev->dev;
 	unsigned char *buffer0 = buffer;
@@ -785,18 +791,18 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	 */
 	config->extra = buffer;
 	i = find_next_descriptor(buffer, size, USB_DT_INTERFACE,
-	    USB_DT_INTERFACE, &n);
+				 USB_DT_INTERFACE, &n);
 	config->extralen = i;
 	if (n > 0)
 		dev_dbg(ddev, "skipped %d descriptor%s after %s\n",
-		    n, plural(n), "configuration");
+			n, plural(n), "configuration");
 	buffer += i;
 	size -= i;
 
 	/* Parse all the interface/altsetting descriptors */
 	while (size > 0) {
 		retval = usb_parse_interface(ddev, cfgno, config,
-		    buffer, size, inums, nalts);
+					     buffer, size, inums, nalts);
 		if (retval < 0)
 			return retval;
 
@@ -847,7 +853,7 @@ void usb_destroy_configuration(struct usb_device *dev)
 		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
 			if (cf->intf_cache[i])
 				kref_put(&cf->intf_cache[i]->ref,
-					  usb_release_interface_cache);
+					 usb_release_interface_cache);
 		}
 	}
 	kfree(dev->config);
@@ -901,7 +907,7 @@ int usb_get_configuration(struct usb_device *dev)
 		 * the whole configuration is
 		 */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+					    desc, USB_DT_CONFIG_SIZE);
 		if (result < 0) {
 			dev_err(ddev,
 				"unable to read config index %d descriptor/%s: %d\n",
@@ -919,7 +925,7 @@ int usb_get_configuration(struct usb_device *dev)
 			goto err;
 		}
 		length = max((int)le16_to_cpu(desc->wTotalLength),
-		    USB_DT_CONFIG_SIZE);
+			     USB_DT_CONFIG_SIZE);
 
 		/* Now that we know the length, get the whole thing */
 		bigbuffer = kmalloc(length, GFP_KERNEL);
@@ -932,7 +938,7 @@ int usb_get_configuration(struct usb_device *dev)
 			msleep(200);
 
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    bigbuffer, length);
+					    bigbuffer, length);
 		if (result < 0) {
 			dev_err(ddev,
 				"unable to read config index %d descriptor/%s\n",
@@ -950,7 +956,8 @@ int usb_get_configuration(struct usb_device *dev)
 		dev->rawdescriptors[cfgno] = bigbuffer;
 
 		result = usb_parse_configuration(dev, cfgno,
-		    &dev->config[cfgno], bigbuffer, length);
+						 &dev->config[cfgno],
+						 bigbuffer, length);
 		if (result < 0) {
 			++cfgno;
 			goto err;
-- 
2.32.0

