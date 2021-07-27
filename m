Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31493D6B41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhG0ABZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhG0ABH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B3C06179E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:41:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so13753334plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1TdIia5oT/voXXUM8yfgtY/ld2vpGF8mnnowb7I2uA=;
        b=hfSix+mnUbMCu8A40vm+XLqCtZK4K9Jk/VjM6gz8k5i/rH2AI8ho6UTmEHdm6F204n
         mtfA1ywu5eSd4cdJlEWC/51Cja6fJJkepSUOCfvPN2gwKV09Jus+N+Jb1RAsoRbNzkIU
         wOs/PChCn705N3dK+IkUdEXPo6m7PB0UgqMNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1TdIia5oT/voXXUM8yfgtY/ld2vpGF8mnnowb7I2uA=;
        b=d3+rwiOwZdbWqGqvnHIFo347cWgGEH7Dy02EYB3XRm10Xbm2nqTN8TXTBHIyCMCC6Z
         oHAxsIQ3lOHwulIYljoqpu1wxzl+GItIgHe2pCek/eEpgXQhqOnSwoYSasaThmMfV05l
         Vmnb1KglN7KBBF0JHbrcyLaA/zt0FlIM//7N90Bl3V1VH7RMPR59C3MDGtHes22HqUu3
         GOjH6AWWNAvzK/v1VxBT1LwZGaZ3dYL8NhITnWUUWgiCIO/6jrFycsArMSqlxKuv6m1Y
         VTH7puxJ+DyuyiUFLB4S/e6fmS5MkyFSL0uuMkrPGpQQt/aI5/M7aTs3Wc3Aq0fGBenR
         cLNw==
X-Gm-Message-State: AOAM531EkIv/At7nAlec1WdVQtD19wA2xNmex0M+sQfbzMKnxbz8sW0+
        lcXqfYA2RwtrSMnXdamT27OCwQ==
X-Google-Smtp-Source: ABdhPJwrUmIYjcLSmqI7Zx8l8YF+URlYNPNpbbDnrWfUmW7G4MGkqUfOQusH4JSWBeevvQjKfXUKHg==
X-Received: by 2002:a17:90b:212:: with SMTP id fy18mr8675133pjb.52.1627346494140;
        Mon, 26 Jul 2021 17:41:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9c3d:270c:6be9:9c33])
        by smtp.gmail.com with UTF8SMTPSA id x18sm1241519pfh.48.2021.07.26.17.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:41:33 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>, devicetree@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v15 5/6] usb: host: xhci-plat: Create platform device for onboard hubs in probe()
Date:   Mon, 26 Jul 2021 17:41:17 -0700
Message-Id: <20210726174048.v15.5.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727004118.2583774-1-mka@chromium.org>
References: <20210727004118.2583774-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call onboard_hub_create/destroy_pdevs() from  _probe()/_remove()
to create/destroy platform devices for onboard USB hubs that may
be connected to the root hub of the controller. These functions
are a NOP unless CONFIG_USB_ONBOARD_HUB=y/m.

Also add a field to struct xhci_hcd to keep track of the onboard hub
platform devices that are owned by the xHCI.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- added comment for 'depends on USB_ONBOARD_HUB || !USB_ONBOARD_HUB'
  construct

Changes in v12:
- none

Changes in v11:
- use onboard_hub_create/destroy_pdevs() to support multiple onboard
  hubs that are connected to the same root hub
- moved field/list to keep track of platform devices from struct
  usb_hcd to struct xhci_hcd
- updated commit message

Changes in v10:
- none

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

 drivers/usb/host/Kconfig     | 1 +
 drivers/usb/host/xhci-plat.c | 6 ++++++
 drivers/usb/host/xhci.h      | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 518c2312ef0c..099e9615919c 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -54,6 +54,7 @@ config USB_XHCI_PCI_RENESAS
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
 	select USB_XHCI_RCAR if ARCH_RENESAS
+	depends on USB_ONBOARD_HUB || !USB_ONBOARD_HUB # if USB_ONBOARD_HUB=m, this can't be 'y'
 	help
 	  Adds an xHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9b13ce..ee98a3671619 100644
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
@@ -374,6 +375,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(&pdev->dev);
 
+	INIT_LIST_HEAD(&xhci->onboard_hub_devs);
+	onboard_hub_create_pdevs(hcd->self.root_hub, &xhci->onboard_hub_devs);
+
 	return 0;
 
 
@@ -420,6 +424,8 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	usb_put_hcd(shared_hcd);
 
+	onboard_hub_destroy_pdevs(&xhci->onboard_hub_devs);
+
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3c7d281672ae..5ba01d5ccab8 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1923,6 +1923,8 @@ struct xhci_hcd {
 	struct dentry		*debugfs_slots;
 	struct list_head	regset_list;
 
+	struct list_head	onboard_hub_devs;
+
 	void			*dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[] __aligned(sizeof(s64));
-- 
2.32.0.432.gabb21c7263-goog

