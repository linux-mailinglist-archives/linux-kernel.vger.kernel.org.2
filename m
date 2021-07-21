Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5073D1A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhGUXPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGUXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 19:15:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DECC061575;
        Wed, 21 Jul 2021 16:55:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k4-20020a17090a5144b02901731c776526so1661589pjm.4;
        Wed, 21 Jul 2021 16:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/faA740GtIYGKlC3Y760h5zLcVyGfa1r19k8TFxbNbw=;
        b=fDeS3/eDTapS2+0+fyKmjIppOd53OEDC0CvUxpHKIRq3smQoX8hueLwAx63cdcSeud
         xw2YuTolI6Av4ZyI6iUbbOu/+9B4r88zjHJ8qhcN3fYsbPe1eLNhmkqy89xHB10KGBSh
         9DDx2zWL/BC3GEhI60tXyO/3CtvsJQtq1qK4DEZFbtlu7no+5k8HqRJO8IPxrDgrZ02J
         yV994gHTGlKzrGJi6HqMOBUsn8sQWyJ2V3bmjRPPlVj+8wKNWx0tiT5GgQGPxHgvTdom
         NtOuZSdmSL/VKjpj4qNfxFvzHXT+Xn0i4z608+I0EKt3qhIEgZW4fKfOpTSGqJSU/jyn
         laHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/faA740GtIYGKlC3Y760h5zLcVyGfa1r19k8TFxbNbw=;
        b=ARHZ7CIsZreBbhJ5TgueRRzahH+fzi3+ZQeyYpvcNH/NFnIXEP6TUVj//p1FfiQsiS
         9X9dNqH9DVBkmDXxFiwz2wrK5ojzr9f8dVCDrXcHQ9mfBvRqVAwM23zRPS5SX5EvUhTb
         fuVHhE0yLIWu4UU1d3IPSRpYEgVXVxzB1TJZ4ak5shd3ZOej7XvMQKi7ywx4nb14SYf8
         fSTVUeZrSwaKUK0WRwAiL86ySeJjPl5md16AcUP8OcjI6xwHyRkbxRw0gIogpL71ScL7
         bv5vL4yEfgcSlO+KIL9O4CqKNecuYw0wGl+c7pHvXQ48ShbhvRhsJbKwd4BRVr2ZsJsX
         L29A==
X-Gm-Message-State: AOAM5335Vljl9+nF45213I4sLyclyrpEDq7mxQtuEYrF8r8J+vwyZjFo
        IygsMWW3GjPHKRD53bL4zUQ=
X-Google-Smtp-Source: ABdhPJw+HUZwBjBvj25ITmExyQYVXedgVyz/DiX9e3WvFD6/Pn/E80dHpps6fZ1HXGoM0jaPkthGpg==
X-Received: by 2002:a63:2308:: with SMTP id j8mr34736692pgj.166.1626911754579;
        Wed, 21 Jul 2021 16:55:54 -0700 (PDT)
Received: from michael-gitpc.. ([1.132.146.172])
        by smtp.gmail.com with ESMTPSA id g5sm7784981pfj.212.2021.07.21.16.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:55:54 -0700 (PDT)
From:   Michael Broadfoot <msbroadf@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Broadfoot <msbroadf@gmail.com>
Subject: [PATCH v2] vhci_hcd:  USB port can get stuck in the disabled state
Date:   Thu, 22 Jul 2021 09:55:26 +1000
Message-Id: <20210721235526.10588-1-msbroadf@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a remote usb device is attached to the local Virtual USB
Host Controller Root Hub port, the bound device driver may send a
port reset command. For example to initialize firmware (eg. btusb does this).
This port reset command can be sent at any time, however the VHCI hcd
root hub is only expecting reset to occur before the device receives
SET_ADDRESS. The USB port should always be enabled after a reset
(because the port is virtual and there is no possibility of hardware errors)



Signed-off-by: Michael Broadfoot <msbroadf@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..d3cda1b2c15a 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -455,15 +455,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
 			vhci_hcd->re_timeout = 0;
 
-			if (vhci_hcd->vdev[rhport].ud.status ==
-			    VDEV_ST_NOTASSIGNED) {
-				usbip_dbg_vhci_rh(
-					" enable rhport %d (status %u)\n",
-					rhport,
-					vhci_hcd->vdev[rhport].ud.status);
-				vhci_hcd->port_status[rhport] |=
-					USB_PORT_STAT_ENABLE;
-			}
+			usbip_dbg_vhci_rh(" enable rhport %d (status %u)\n",
+					  rhport,
+					  vhci_hcd->vdev[rhport].ud.status);
+			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_ENABLE;
 
 			if (hcd->speed < HCD_USB3) {
 				switch (vhci_hcd->vdev[rhport].speed) {
-- 
2.30.2

