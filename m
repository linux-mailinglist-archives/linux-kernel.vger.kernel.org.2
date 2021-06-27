Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6233B534D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhF0NBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhF0NBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:01:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F3EC061574;
        Sun, 27 Jun 2021 05:58:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so10996537pjb.0;
        Sun, 27 Jun 2021 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TD9RKCumN6SQ/jONnfjhNDCjuF5eLGJYOMSfmMwJUAk=;
        b=VjlQciPnvD/DEQPn+L56j0VaEYuL8Wb0G7kmTb5oXASHGuLLYAbenrjlced3r/A/8G
         xrSaMUpczAtNqlbt2mN552JzULQWlr6ogDZkdGp0X2HyneguQIkADtiq8D9DlabnbRaF
         rQUJWi8O9K0ULSMf/UAbsxodF9nzDx/lDqA5o/jL4NcKNIQBkhhNIyEUCVmt8hxBDkLI
         KaIXMkqQ2jKvBeaZ/xV7F6BlZb6t6xO73CPaDsrGXcli7dE/YU3PB58e+I7FJMXOaHyH
         RZPgp3Pu+wtI4WLLuRV7u9ZLumK4JSWHqP+rleqNF7WO1ZQNq+ZsfM9ytWx4NED73+i7
         0WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TD9RKCumN6SQ/jONnfjhNDCjuF5eLGJYOMSfmMwJUAk=;
        b=nKgY5s8j0KOTiY2aUOU9+1o6jEyI66ioHbL+KY8xXHKcqcas/EWVj8bAMvv5mm0xlU
         /wv4K9g6h8W/loDWG8RGNy0nvTJeqD4Aa61rfPyKBm/McyS+Z4t+LgN7u7mG9YnkBdZ1
         b+if5c3F6xgNzGKk9uqJtozx9JS4VBaOfA50FxOebMxqNW3s1trMej62gFT/raB41IHA
         7KFcdxL7W+3fVb0JLIFFZdlupGq8MOFW4WWS0Ftgo2npyvYPI5X614t1P8gGa2LdRTIE
         7i6dMYXF2alPQB3i2Cb0MLvJfO1Dvy1+8kdfBq9An7jZTeVnOKcpaofFqUgdwP0ig3Yy
         Bp0g==
X-Gm-Message-State: AOAM531URte8lWzktP3LlsN2z+cLHSK89pHD7bTU9Fap9oJUV2C3pQob
        AtULTZQazgvV5CsN8Tk1j/4=
X-Google-Smtp-Source: ABdhPJyKhXugoSpKWQRMdqTUxbag6ZBX1DE195PxlhiC4vlMomzhbGX+c2KBjmcMY1Lc0JG5JS8i+Q==
X-Received: by 2002:a17:902:ab8e:b029:125:e6a0:fea2 with SMTP id f14-20020a170902ab8eb0290125e6a0fea2mr11520502plr.41.1624798717324;
        Sun, 27 Jun 2021 05:58:37 -0700 (PDT)
Received: from localhost.localdomain ([113.76.110.29])
        by smtp.googlemail.com with ESMTPSA id c5sm11270260pfi.81.2021.06.27.05.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:58:37 -0700 (PDT)
From:   Kelly Devilliv <kelly.devilliv@gmail.com>
To:     gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org,
        chunfeng.yun@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Devilliv <kelly.devilliv@gmail.com>
Subject: [PATCH 2/3] usb: host: fotg210: fix the endpoint's transactional opportunities calculation
Date:   Sun, 27 Jun 2021 20:57:46 +0800
Message-Id: <20210627125747.127646-3-kelly.devilliv@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210627125747.127646-1-kelly.devilliv@gmail.com>
References: <20210627125747.127646-1-kelly.devilliv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that usb_endpoint_maxp() only returns the lowest
11 bits from wMaxPacketSize, we should make use of the
usb_endpoint_* helpers instead and remove the unnecessary
max_packet()/hb_mult() macro.

Signed-off-by: Kelly Devilliv <kelly.devilliv@gmail.com>
---
 drivers/usb/host/fotg210-hcd.c | 36 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index bb50a7a7318a..c38a6c2a8d95 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -2511,11 +2511,6 @@ static unsigned qh_completions(struct fotg210_hcd *fotg210,
 	return count;
 }
 
-/* high bandwidth multiplier, as encoded in highspeed endpoint descriptors */
-#define hb_mult(wMaxPacketSize) (1 + (((wMaxPacketSize) >> 11) & 0x03))
-/* ... and packet size, for any kind of endpoint descriptor */
-#define max_packet(wMaxPacketSize) ((wMaxPacketSize) & 0x07ff)
-
 /* reverse of qh_urb_transaction:  free a list of TDs.
  * used for cleanup after errors, before HC sees an URB's TDs.
  */
@@ -2601,7 +2596,7 @@ static struct list_head *qh_urb_transaction(struct fotg210_hcd *fotg210,
 		token |= (1 /* "in" */ << 8);
 	/* else it's already initted to "out" pid (0 << 8) */
 
-	maxpacket = max_packet(usb_maxpacket(urb->dev, urb->pipe, !is_input));
+	maxpacket = usb_maxpacket(urb->dev, urb->pipe, !is_input);
 
 	/*
 	 * buffer gets wrapped in one or more qtds;
@@ -2715,9 +2710,11 @@ static struct fotg210_qh *qh_make(struct fotg210_hcd *fotg210, struct urb *urb,
 		gfp_t flags)
 {
 	struct fotg210_qh *qh = fotg210_qh_alloc(fotg210, flags);
+	struct usb_host_endpoint *ep;
 	u32 info1 = 0, info2 = 0;
 	int is_input, type;
 	int maxp = 0;
+	int mult;
 	struct usb_tt *tt = urb->dev->tt;
 	struct fotg210_qh_hw *hw;
 
@@ -2732,14 +2729,15 @@ static struct fotg210_qh *qh_make(struct fotg210_hcd *fotg210, struct urb *urb,
 
 	is_input = usb_pipein(urb->pipe);
 	type = usb_pipetype(urb->pipe);
-	maxp = usb_maxpacket(urb->dev, urb->pipe, !is_input);
+	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
+	maxp = usb_endpoint_maxp(&ep->desc);
+	mult = usb_endpoint_maxp_mult(&ep->desc);
 
 	/* 1024 byte maxpacket is a hardware ceiling.  High bandwidth
 	 * acts like up to 3KB, but is built from smaller packets.
 	 */
-	if (max_packet(maxp) > 1024) {
-		fotg210_dbg(fotg210, "bogus qh maxpacket %d\n",
-				max_packet(maxp));
+	if (maxp > 1024) {
+		fotg210_dbg(fotg210, "bogus qh maxpacket %d\n", maxp);
 		goto done;
 	}
 
@@ -2753,8 +2751,7 @@ static struct fotg210_qh *qh_make(struct fotg210_hcd *fotg210, struct urb *urb,
 	 */
 	if (type == PIPE_INTERRUPT) {
 		qh->usecs = NS_TO_US(usb_calc_bus_time(USB_SPEED_HIGH,
-				is_input, 0,
-				hb_mult(maxp) * max_packet(maxp)));
+				is_input, 0, mult * maxp));
 		qh->start = NO_FRAME;
 
 		if (urb->dev->speed == USB_SPEED_HIGH) {
@@ -2791,7 +2788,7 @@ static struct fotg210_qh *qh_make(struct fotg210_hcd *fotg210, struct urb *urb,
 			think_time = tt ? tt->think_time : 0;
 			qh->tt_usecs = NS_TO_US(think_time +
 					usb_calc_bus_time(urb->dev->speed,
-					is_input, 0, max_packet(maxp)));
+					is_input, 0, maxp));
 			qh->period = urb->interval;
 			if (qh->period > fotg210->periodic_size) {
 				qh->period = fotg210->periodic_size;
@@ -2854,11 +2851,11 @@ static struct fotg210_qh *qh_make(struct fotg210_hcd *fotg210, struct urb *urb,
 			 * to help them do so.  So now people expect to use
 			 * such nonconformant devices with Linux too; sigh.
 			 */
-			info1 |= max_packet(maxp) << 16;
+			info1 |= maxp << 16;
 			info2 |= (FOTG210_TUNE_MULT_HS << 30);
 		} else {		/* PIPE_INTERRUPT */
-			info1 |= max_packet(maxp) << 16;
-			info2 |= hb_mult(maxp) << 30;
+			info1 |= maxp << 16;
+			info2 |= mult << 30;
 		}
 		break;
 	default:
@@ -3928,6 +3925,7 @@ static void iso_stream_init(struct fotg210_hcd *fotg210,
 	int is_input;
 	long bandwidth;
 	unsigned multi;
+	struct usb_host_endpoint *ep;
 
 	/*
 	 * this might be a "high bandwidth" highspeed endpoint,
@@ -3935,14 +3933,14 @@ static void iso_stream_init(struct fotg210_hcd *fotg210,
 	 */
 	epnum = usb_pipeendpoint(pipe);
 	is_input = usb_pipein(pipe) ? USB_DIR_IN : 0;
-	maxp = usb_maxpacket(dev, pipe, !is_input);
+	ep = usb_pipe_endpoint(dev, pipe);
+	maxp = usb_endpoint_maxp(&ep->desc);
 	if (is_input)
 		buf1 = (1 << 11);
 	else
 		buf1 = 0;
 
-	maxp = max_packet(maxp);
-	multi = hb_mult(maxp);
+	multi = usb_endpoint_maxp_mult(&ep->desc);
 	buf1 |= maxp;
 	maxp *= multi;
 
-- 
2.25.1

