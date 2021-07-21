Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585333D0657
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 03:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhGUAeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 20:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhGUAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 20:34:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ADCC061574;
        Tue, 20 Jul 2021 18:15:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso3049826pjz.1;
        Tue, 20 Jul 2021 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cfxISAWJir65FIuVoWTeD4Z8lhcpGdiMTQZJgbLt4qI=;
        b=QOCauwmLCvpdD042bMLDMZEpbC+3VLF993MfVvdpeA7NhriesN/yYxzSLn+AtSU0n1
         ZzV9HbfFq33v/JtIY4fSoGw/FgNqsLNYP68Eoyi19ddnd08Gd2zO9xCqFkjM6NdmvOp1
         eniz9i6vFjMhhHNqjaKS2Mmy71xl+geVtwFP57M+nTshhxC0evAy8M5jBvOHeHwAwQny
         mc3+/Ay25Ei836yxb3EFMVmTgF1n0qI5zmzoicBxxDtAnpLHenDKYpMV6saLJZEL3WdN
         FId1IdDN5+xbjOuxtL/5hgvK7pkfuCcVfeMvi4oXRVkWeYoC0PiW+bRxW6yTPDXzgjmR
         i4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cfxISAWJir65FIuVoWTeD4Z8lhcpGdiMTQZJgbLt4qI=;
        b=sjFjV5uLA3QV4OJeck2AzLfi4tVg9n6XRtgCYRhXCCFCjcPwIvVjeOF/MDOCQc64hu
         5bSLtRxStGKwwtaBSuFEDCD63rCihBpfmYZkuQBCxhCqILjh1h/cyDa6E2X19I+91z98
         ZblGpe+iVOSR5xq4K+J+ibyQgsticu9RsCfWmA3zPXpXCyli3x+WAr+no/Eq8wo/5jC2
         xTQf1WjY+T2DZRchCog7ukmhkPnhoXeDx7AHDeV+Q+gDELqZ3xwtbXtG9lESG1lZcK7Y
         3IUD/DDyuvkUE3+qX0emRJhd7/LlAXWffMJq7HKsAn9iOB9h4mxZii6esLOXqOrADPw6
         BAdg==
X-Gm-Message-State: AOAM532whLd/sUPQCyuoa3EvSY6PBo1zfJs1MfiQVUbP85dhlrM7wgaC
        dQ8XOHAkyjdsml37Cd74W1izm0MqvUQx8w==
X-Google-Smtp-Source: ABdhPJz1VDa58wOWnJOej1A3jGGR5Jn1wWSybl0UAZ/Xr8rOWeGv8NINQ9iBdd2qM0Awq15NQJOORQ==
X-Received: by 2002:a17:902:fe11:b029:12b:9108:c068 with SMTP id g17-20020a170902fe11b029012b9108c068mr7692097plj.36.1626830108166;
        Tue, 20 Jul 2021 18:15:08 -0700 (PDT)
Received: from michael-gitpc ([1.132.149.66])
        by smtp.gmail.com with ESMTPSA id l10sm2068811pjg.11.2021.07.20.18.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:15:07 -0700 (PDT)
Date:   Wed, 21 Jul 2021 11:15:02 +1000
From:   Michael Broadfoot <msbroadf@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] A reset can be sent anytime and so the vhcd Root Hub should
 renable the port always on a virtual reset
Message-ID: <YPd1FhI/ASlQ2K9o@michael-gitpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And if the HIGH and LOW flags are not set on the port
status that means FULL speed and is not an
error (see 11.24.2.7.1 Port Status Bits)
---
 drivers/usb/usbip/vhci_hcd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..3ea76dcdc8e2 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -455,15 +455,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
 			vhci_hcd->re_timeout = 0;
 
-			if (vhci_hcd->vdev[rhport].ud.status ==
-			    VDEV_ST_NOTASSIGNED) {
 				usbip_dbg_vhci_rh(
 					" enable rhport %d (status %u)\n",
 					rhport,
 					vhci_hcd->vdev[rhport].ud.status);
 				vhci_hcd->port_status[rhport] |=
 					USB_PORT_STAT_ENABLE;
-			}
 
 			if (hcd->speed < HCD_USB3) {
 				switch (vhci_hcd->vdev[rhport].speed) {
@@ -475,8 +472,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					vhci_hcd->port_status[rhport] |=
 						USB_PORT_STAT_LOW_SPEED;
 					break;
-				default:
-					pr_err("vhci_device speed not set\n");
+				default: // FULL speed
 					break;
 				}
 			}
-- 
2.30.2

