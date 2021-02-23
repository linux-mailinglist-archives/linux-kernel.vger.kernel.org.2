Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3905A322FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhBWRqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhBWRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:45:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F4C06174A;
        Tue, 23 Feb 2021 09:45:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o16so1316680wmh.0;
        Tue, 23 Feb 2021 09:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1ebTmxylMMNhfzmMvoYVmlP+/kjTLY+kX8ILsVeGAE=;
        b=eLPiNIlZhCgXEwZBB2NYuErw41gBNhTCzs9hJKxI9E0LyUrUF1Posv1DOLZNtaUQpz
         LRt9OR7oy9WGSdpOqX8Bf3KTNo2sJLclB64jNUYtsQXQ5v4jjOEVTvtr45Evz1EIIB25
         BJrXf/veBVLTIMR8aNnwLhMYbBV522reDL3F4tHRHSy8+N6jWisHdpUR6dPydPiYC3Ng
         zGruznq6TiUEfGpteig+uvjEcAgKb22tF7kFiXlJPG0PKDH81Tz6nx79SrPYoUIOS9w3
         OM6thfHJEkOEyk4Z5YiK0Y41UsgtJPv8SkrNdBp+388KpxD/9jqe4x7WXQNP8aqvsNzj
         iyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ebTmxylMMNhfzmMvoYVmlP+/kjTLY+kX8ILsVeGAE=;
        b=NoeKbNuXLerdXQqqStw+35o/GHIt5EHtZckXU77jlLa1zgRA66miLbeof48jiliwl8
         0wg3ehA3aNyVu6E4dAR1YsHH1h5P1V+Jf1xVRByDNOkDN9TNdBRlx3UEi7wkBwP1/ycy
         vE+8ROSDLxiHx98ot1z5Tt9JDwPaPQR8vch0KMIizao1wdh60up9qtCvDkHhXGdglZU9
         cUIB1v7SpSJODFdmQHskjbKdjs1Bp1/4Vs7/ri/QXFbs4ygiNwBvVC7ddjKPdnSvJxPk
         +e4PXWAo4NcvgHn055sxVECnscZ4at26N0Y2FHNfJqPqaGA8xtU2ucMIHzV9QeaGJ9Xu
         qGCw==
X-Gm-Message-State: AOAM530e4ZfysagMaMwppk7CvSN5Ep73CFSZ+FNdaYN6mueEIlX8fMU3
        o2A5QBfnKT6HfTOiFWctySU=
X-Google-Smtp-Source: ABdhPJwZTjU+7SUuMXu7kZwaMwVbjaiEa9h+praKw+z60VcKxG/R2nXI6WghzXSLZnLJkyPmBMm7jA==
X-Received: by 2002:a7b:c18b:: with SMTP id y11mr18954565wmi.132.1614102299471;
        Tue, 23 Feb 2021 09:44:59 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u7sm32408428wrt.67.2021.02.23.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:44:59 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <florian@openwrt.org>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 1/3] usb: ehci: add spurious flag to disable overcurrent checking
Date:   Tue, 23 Feb 2021 18:44:53 +0100
Message-Id: <20210223174455.1378-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223174455.1378-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223174455.1378-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <florian@openwrt.org>

This patch adds an ignore_oc flag which can be set by EHCI controller
not supporting or wanting to disable overcurrent checking. The EHCI
platform data in include/linux/usb/ehci_pdriver.h is also augmented to
take advantage of this new flag.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/usb/host/ehci-hcd.c      | 2 +-
 drivers/usb/host/ehci-hub.c      | 4 ++--
 drivers/usb/host/ehci-platform.c | 2 ++
 drivers/usb/host/ehci.h          | 1 +
 include/linux/usb/ehci_pdriver.h | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1926b328b6aa..2237d22d292a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -651,7 +651,7 @@ static int ehci_run (struct usb_hcd *hcd)
 		"USB %x.%x started, EHCI %x.%02x%s\n",
 		((ehci->sbrn & 0xf0)>>4), (ehci->sbrn & 0x0f),
 		temp >> 8, temp & 0xff,
-		ignore_oc ? ", overcurrent ignored" : "");
+		(ignore_oc || ehci->spurious_oc) ? ", overcurrent ignored" : "");
 
 	ehci_writel(ehci, INTR_MASK,
 		    &ehci->regs->intr_enable); /* Turn On Interrupts */
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 9f9ab5ccea88..159cc27b1a36 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -643,7 +643,7 @@ ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 	 * always set, seem to clear PORT_OCC and PORT_CSC when writing to
 	 * PORT_POWER; that's surprising, but maybe within-spec.
 	 */
-	if (!ignore_oc)
+	if (!ignore_oc && !ehci->spurious_oc)
 		mask = PORT_CSC | PORT_PEC | PORT_OCC;
 	else
 		mask = PORT_CSC | PORT_PEC;
@@ -1013,7 +1013,7 @@ int ehci_hub_control(
 		if (temp & PORT_PEC)
 			status |= USB_PORT_STAT_C_ENABLE << 16;
 
-		if ((temp & PORT_OCC) && !ignore_oc){
+		if ((temp & PORT_OCC) && (!ignore_oc && !ehci->spurious_oc)){
 			status |= USB_PORT_STAT_C_OVERCURRENT << 16;
 
 			/*
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index a48dd3fac153..4d7b17f4f82b 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -327,6 +327,8 @@ static int ehci_platform_probe(struct platform_device *dev)
 		hcd->has_tt = 1;
 	if (pdata->reset_on_resume)
 		priv->reset_on_resume = true;
+	if (pdata->spurious_oc)
+		ehci->spurious_oc = 1;
 
 #ifndef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
 	if (ehci->big_endian_mmio) {
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index eabf22a78eae..80bb823aa9fe 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -218,6 +218,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		frame_index_bug:1; /* MosChip (AKA NetMos) */
 	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
 	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
+	unsigned		spurious_oc:1;
 
 	/* required for usb32 quirk */
 	#define OHCI_CTRL_HCFS          (3 << 6)
diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
index dd742afdc03f..89fc901e778f 100644
--- a/include/linux/usb/ehci_pdriver.h
+++ b/include/linux/usb/ehci_pdriver.h
@@ -50,6 +50,7 @@ struct usb_ehci_pdata {
 	unsigned	no_io_watchdog:1;
 	unsigned	reset_on_resume:1;
 	unsigned	dma_mask_64:1;
+	unsigned	spurious_oc:1;
 
 	/* Turn on all power and clocks */
 	int (*power_on)(struct platform_device *pdev);
-- 
2.20.1

