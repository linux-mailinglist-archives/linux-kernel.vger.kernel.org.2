Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37D3720C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhECTqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhECTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:45:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2255C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:44:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h11so5078440pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9SQ7k96X0LZxd9chKqf25mgiUdmMwQrmDeOSJipN9g=;
        b=Cd4RGTeYMPERymb9cg+7xjK6COf7qBmXEpyKC+NWyFLDDrZOQxtJ95gh2b+3kdYjU6
         rCcawbLcPI+Qhxlg87lEiC1NXcMgZeXx+hCzf9Cu7vzPQk+JqFaivArGUIhJodz9P01u
         hAWTb957ZhlMKlCFMV+KymkbnXcJ4gxyK6FJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9SQ7k96X0LZxd9chKqf25mgiUdmMwQrmDeOSJipN9g=;
        b=WGQhVNx54EV9AQzlmQw/fC0bsb5QKgIH7JgUaFcFD0semrC7v1hirCs15KJasslW7E
         e55C3ctV7WHO7p71jE64EXSL7X/snGPYJVOXiyY38R6DSaO/RhzjsxpeWRb/+2TEBJWE
         kGG64h4sRE4QwuY5MZjRcUDDaAfDjhUODPre5jXoMceEtvOh9xe0z1ydebgwuYWTdB6O
         1camw5ncVbNCfKZNRPN7P2hnSUNUMxFxJqrnNuqo0FR7vlQuXWjJD6U1LzoBwYFCEkmd
         MvTy/I4hnjGsab3U8pkuSjXTBrbqB4Ys///E8Ismz4Nh/e362WaX41wqWx0vGdLLEoqV
         y7cg==
X-Gm-Message-State: AOAM530xQ4wp75YmCVc/gYUBO9DjeNe3WX65JgBxIP5cOXbvL1MbrO0P
        t8k1kSeOciLlQapTICfMGoAedw==
X-Google-Smtp-Source: ABdhPJzszT/PlNKe1jrnCfrkvz6XxI6c8I2RBRLM1bccNOzwoZP1+kX3eldQCxj1EABXz9jyPKyG6A==
X-Received: by 2002:a17:90b:505:: with SMTP id r5mr23060904pjz.121.1620071092395;
        Mon, 03 May 2021 12:44:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8584:3fd:2adf:a655])
        by smtp.gmail.com with UTF8SMTPSA id a13sm438705pgm.43.2021.05.03.12.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:44:52 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Al Cooper <alcooperx@gmail.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v9 4/5] usb: host: xhci-plat: Create platform device for onboard hubs in probe()
Date:   Mon,  3 May 2021 12:44:38 -0700
Message-Id: <20210503124408.v9.4.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210503194439.3289065-1-mka@chromium.org>
References: <20210503194439.3289065-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check during probe() if a hub supported by the onboard_usb_hub
driver is connected to the controller. If such a hub is found
create the corresponding platform device. This requires the
device tree to have a node for the hub with its vendor and
product id (which is not common for USB devices). Further the
platform device is only created when CONFIG_USB_ONBOARD_HUB=y/m.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v9:
- added dependency on USB_ONBOARD_HUB (or !!USB_ONBOARD_HUB) to
  USB_XHCI_PLATFORM

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- patch added to the series

 drivers/usb/host/Kconfig     |  1 +
 drivers/usb/host/xhci-plat.c | 16 ++++++++++++++++
 include/linux/usb/hcd.h      |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b94f2a070c05..da50496787fe 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -54,6 +54,7 @@ config USB_XHCI_PCI_RENESAS
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
 	select USB_XHCI_RCAR if ARCH_RENESAS
+	depends on USB_ONBOARD_HUB || !USB_ONBOARD_HUB
 	help
 	  Adds an xHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9b13ce..9c0fb7e8df1f 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/usb/onboard_hub.h>
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -195,6 +196,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	int			ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
+	struct device_node	*np;
 
 
 	if (usb_disabled())
@@ -374,6 +376,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(&pdev->dev);
 
+	np = usb_of_get_device_node(hcd->self.root_hub, hcd->self.busnum);
+	if (np && of_is_onboard_usb_hub(np)) {
+		struct platform_device *pdev;
+
+		pdev = of_platform_device_create(np, NULL, NULL);
+		if (pdev)
+			hcd->onboard_hub_dev = &pdev->dev;
+		else
+			xhci_warn(xhci, "failed to create onboard hub platform device\n");
+	}
+
 	return 0;
 
 
@@ -420,6 +433,9 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	usb_put_hcd(shared_hcd);
 
+	if (hcd->onboard_hub_dev)
+		of_platform_device_destroy(hcd->onboard_hub_dev, NULL);
+
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 96281cd50ff6..d02a508e19b0 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -225,6 +225,8 @@ struct usb_hcd {
 	 * (ohci 32, uhci 1024, ehci 256/512/1024).
 	 */
 
+	struct device *onboard_hub_dev;
+
 	/* The HC driver's private data is stored at the end of
 	 * this structure.
 	 */
-- 
2.31.1.527.g47e6f16901-goog

