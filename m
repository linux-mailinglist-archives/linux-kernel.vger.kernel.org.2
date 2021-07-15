Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE64F3C95E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhGOC3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGOC3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:29:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 19:26:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8-20020a05600c1d08b02902333d79327aso1988062wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HBtiHGC6J9IUoaLI1gRsR3CF7DXPQ2QzWezq4+ip74c=;
        b=iQjG1WXDkx3YYz1TSCmCXt3BYtYtwAdJd9iRkhizRFgbUN8bLrBnEvG2LSKiGbCcpt
         YvuF3PrCu+cKk5T3glOS3qaGCgAjsMKYYNnonTJdk+86F6cIW6DdaOr0aUlCnxcpq4uh
         Veb6HQUd1dG0nuB5v5hF9eSSW7CMRXtRw2opRqOxbxxpAbmB7WSNKg+IRIJZ7fPecf9H
         4ZPmFntGU8TwEltoT1F4wFjqUzMYySnYVyVC0C/9zCC47AeanOYImvrBL1dXfkh6Qcho
         c0PFDm93AlE4ZUV5voXfAzcTJouUBQxyF4jrUFN8TMghQfarbhiJgvSM0jFGD64BAcHw
         piLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HBtiHGC6J9IUoaLI1gRsR3CF7DXPQ2QzWezq4+ip74c=;
        b=B8KK+/cX8aSPg6TkVKW+I64npvrQ+QwbisQSHAvpiEGdMq8rjQValNCXayTpkgvgPM
         l5m9HfxSHWtrH3NSGRmLl1SBdHpMECIXnz5EviuhtZVWecpbaYID/kHCGu/EZJOjvjmy
         jpsxURWAER5Qen+BTSYO5UzgDmpKrmQZPzwEfrGjjK4shygrVJqrzCiUqkGnIzqYIzL0
         sb40twMt9ByqtC2A2vRePbKPRd/5AbiXeSOjbRhT8QrZd68Etm81F+oPBFswMtpZbuSu
         lh8xwaFXE7cLH9rut50GBajV9MBGKx0lxycalV208R/v8l0r+F4nsvh9WNUAJk+HrjTm
         KS8Q==
X-Gm-Message-State: AOAM530UGx1oAsC3TDh1oyNsAzhkjjHWplRbEAjSshyO0ob9Cia43++5
        xfhsNlw0aF60YZHqN1+WWjY=
X-Google-Smtp-Source: ABdhPJxn1T4bn///Gv7e2Du24vrLgCHupAii9EVBix7NmosZYFR3Aaq+zcWXoEP6nVaVxvVwcurfZQ==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr7388818wmh.120.1626316015945;
        Wed, 14 Jul 2021 19:26:55 -0700 (PDT)
Received: from pc ([196.235.28.219])
        by smtp.gmail.com with ESMTPSA id o22sm3539019wmc.18.2021.07.14.19.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:26:55 -0700 (PDT)
Date:   Thu, 15 Jul 2021 03:26:52 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] comedi: usbdux: free allocated memory/urbs on failure
Message-ID: <20210715022652.GA2054080@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free allocated memory/urbs on failure in order to prevent memory leaks.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/comedi/drivers/usbdux.c | 42 ++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/comedi/drivers/usbdux.c b/drivers/comedi/drivers/usbdux.c
index 0350f303d557..fe388a9a588a 100644
--- a/drivers/comedi/drivers/usbdux.c
+++ b/drivers/comedi/drivers/usbdux.c
@@ -1456,7 +1456,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
 		/* one frame: 1ms */
 		urb = usb_alloc_urb(1, GFP_KERNEL);
 		if (!urb)
-			return -ENOMEM;
+			goto free_ai_urbs1;
 		devpriv->ai_urbs[i] = urb;
 
 		urb->dev = usb;
@@ -1465,7 +1465,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
 		urb->transfer_flags = URB_ISO_ASAP;
 		urb->transfer_buffer = kzalloc(SIZEINBUF, GFP_KERNEL);
 		if (!urb->transfer_buffer)
-			return -ENOMEM;
+			goto free_ai_urbs2;
 
 		urb->complete = usbduxsub_ai_isoc_irq;
 		urb->number_of_packets = 1;
@@ -1478,7 +1478,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
 		/* one frame: 1ms */
 		urb = usb_alloc_urb(1, GFP_KERNEL);
 		if (!urb)
-			return -ENOMEM;
+			goto free_ao_urbs1;
 		devpriv->ao_urbs[i] = urb;
 
 		urb->dev = usb;
@@ -1487,7 +1487,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
 		urb->transfer_flags = URB_ISO_ASAP;
 		urb->transfer_buffer = kzalloc(SIZEOUTBUF, GFP_KERNEL);
 		if (!urb->transfer_buffer)
-			return -ENOMEM;
+			goto free_ao_urbs2;
 
 		urb->complete = usbduxsub_ao_isoc_irq;
 		urb->number_of_packets = 1;
@@ -1504,17 +1504,47 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
 	if (devpriv->pwm_buf_sz) {
 		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb)
-			return -ENOMEM;
+			goto free_ao_urbs0;
 		devpriv->pwm_urb = urb;
 
 		/* max bulk ep size in high speed */
 		urb->transfer_buffer = kzalloc(devpriv->pwm_buf_sz,
 					       GFP_KERNEL);
 		if (!urb->transfer_buffer)
-			return -ENOMEM;
+			goto free_urb;
 	}
 
 	return 0;
+
+free_urb:
+	usb_free_urb(urb);
+
+free_ao_urbs0:
+	i = devpriv->n_ao_urbs;
+
+free_ao_urbs1:
+	i--;
+
+free_ao_urbs2:
+	while (i >= 0) {
+		kfree(devpriv->ao_urbs[i]->transfer_buffer);
+		usb_free_urb(devpriv->ao_urbs[i]);
+		i--;
+	}
+	i = devpriv->n_ai_urbs;
+
+free_ai_urbs1:
+	i--;
+
+free_ai_urbs2:
+	while (i >= 0) {
+		kfree(devpriv->ai_urbs[i]->transfer_buffer);
+		usb_free_urb(devpriv->ai_urbs[i]);
+		i--;
+	}
+
+	return -ENOMEM;
+
 }
 
 static void usbdux_free_usb_buffers(struct comedi_device *dev)
-- 
2.25.1

