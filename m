Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341D534912C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYLrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCYLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:46:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB6C06174A;
        Thu, 25 Mar 2021 04:46:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j9so233984wrx.12;
        Thu, 25 Mar 2021 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JfeEWHZhneA8/Ay4nqg54j7jVIWGAMpwTBaGcBtQn9o=;
        b=Bte9Z3Dis7NJewkuMrY460myLVMDziLOW4fJbutiE95RI1T1SDl5C5anOdVgDFwcu2
         m6BD8VwND/mHovT8lF0HG2o33Jiq5XSJKTvoniqHnBp8UJXB6R4luR2bfGzBiQ3rAuuf
         hrWIHu4fhpHVteg5R5d9J4MabouyiuhdlZI6AEChuWzAav0BARM2VdF6Qh8lQiDjq/tJ
         MVIOVKjK0J3uduMegUq4en4ItSPYG2yuNzyTbyRFeBaoeLOeXid/vjFkDdSI2WmhJyK/
         0DZFbf9h4nxxkWw7rWAcw9a2vt6T0097eei99LNfTkoCY/FT8NOwf7dquCUnt9upXW2x
         XHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JfeEWHZhneA8/Ay4nqg54j7jVIWGAMpwTBaGcBtQn9o=;
        b=kKJ4ww3WTBAi0pEMn7tuRrPKC4pYSP9MtSTvwAr1YDD6fsf6NjCx98HuUIVFT+3/Ei
         3SfrNXLOHOoKciNvvpX0Wfzg1RtHB3wwlFsIba7JovW/iDsQS/h7bmsvNXKTCg2HHyTv
         LMZAhWkN0jE80KG/xfZL/7TBtz2ulmK1EPTMmAj8OvSnevscwL0av2bP/qqWQd11AtNe
         /8v8oobzq3kIrrgJ/BHmyuKjmZ5Aufmk8Jvcj7vR5iqOx2pyV8O2HJnM76gvHPVfhdzI
         fVQxgW8Iofx+cKO0JsA699nrUp7gwdNUJ8R65+gXJimH62unImYfvvWvk7CPbjxXpAUo
         XJ3w==
X-Gm-Message-State: AOAM533yrYB6NKYtD+sQ67Bi/hnZQpVeUjCpiLKtM+hyVHKD12eQE/MR
        H6WpN87T71zRbZlA7NVYYyxDp4tOxzDwTA==
X-Google-Smtp-Source: ABdhPJw7bbXj8WTefzgFLxnJaAnqmXTMhj+5JuvkFRB0e32tiPPsuUvpw30rXw1OxKKNSxAWq0p9Ig==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr8366351wrt.280.1616672803597;
        Thu, 25 Mar 2021 04:46:43 -0700 (PDT)
Received: from LEGION ([39.46.39.200])
        by smtp.gmail.com with ESMTPSA id h10sm7498863wrp.22.2021.03.25.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:46:43 -0700 (PDT)
Date:   Thu, 25 Mar 2021 16:46:38 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        valentina.manea.m@gmail.com, stern@rowland.harvard.edu
Cc:     musamaanjum@gmail.com
Subject: [PATCH] usbip: vhci_hcd: do proper error handling
Message-ID: <20210325114638.GA659438@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was assuming that all the parameters would be valid. But it
is possible that parameters are sent from userspace. For those cases,
appropriate error checks have been added.

Porting partial fix from: 
c318840fb2 ("USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug")
   
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3209b5ddd30c..e32c080a2825 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -393,13 +393,24 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			else
 				vhci_hcd->port_status[rhport] &= ~USB_PORT_STAT_POWER;
 			break;
-		default:
-			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
-					  wValue);
+		case USB_PORT_FEAT_ENABLE:
+		case USB_PORT_FEAT_C_ENABLE:
+		case USB_PORT_FEAT_C_SUSPEND:
+			/* Not allowed for USB-3 */
+			if (hcd->speed == HCD_USB3)
+				goto error;
+			fallthrough;
+		case USB_PORT_FEAT_C_CONNECTION:
+		case USB_PORT_FEAT_C_RESET:
 			if (wValue >= 32)
 				goto error;
 			vhci_hcd->port_status[rhport] &= ~(1 << wValue);
 			break;
+		default:
+			/* Disallow INDICATOR and C_OVER_CURRENT */
+			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
+					  wValue);
+			goto error;
 		}
 		break;
 	case GetHubDescriptor:
@@ -587,6 +598,14 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			/* 50msec reset signaling */
 			vhci_hcd->re_timeout = jiffies + msecs_to_jiffies(50);
 			fallthrough;
+		case USB_PORT_FEAT_C_CONNECTION:
+		case USB_PORT_FEAT_C_RESET:
+		case USB_PORT_FEAT_C_ENABLE:
+		case USB_PORT_FEAT_C_SUSPEND:
+			/* Not allowed for USB-3, and ignored for USB-2 */
+			if (hcd->speed == HCD_USB3)
+				goto error;
+			break;
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
-- 
2.25.1

