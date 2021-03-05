Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2B32F41B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCETjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCETjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:39:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887BC061761
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:39:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id l7so2894482pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfOOFCL5r8iHO/1j7UcG3TomzokVFUS4JgqthyKt1sM=;
        b=BPXEmEa3zqi8kL8PefolV0beqB93cLI8VYOwiiklwdkGHEzPW6Za6EzB52WcGOLxH0
         HdkPYUY2fsMiy5KR1L8BfRrLmNScDnU/f+IlyosiP4ObRTLYDroON9ZDjA48YGww+zne
         Zn60HTcRpMcFQ6p8x/Iml9UWCybFJ9H/eGHOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfOOFCL5r8iHO/1j7UcG3TomzokVFUS4JgqthyKt1sM=;
        b=PkuHKp8K/mqkyt2wHr3ZeFcj2x9LrtnRrzUNULb7vY3yMR9klFqnqHbT2Wx0qEz6Fr
         IfFAixh77yuY2wWAK/6/jsg3I6fxrBS4vk5QHAhSOthFd75loXRKVOkIEpEIvW3JskjS
         oR9ff10sCnBkcqlKG/C9SIA5h55z8X4hMiNcuHFgl1gAcqNUztHwT23UEfDkcAV24+kW
         XclJJbE76prvKN9IAps9uaZOTaN7jCPX9JmjJdXoPBoCxUF5od6RK87Pu1s1TYNsxv9E
         C+XLZTrE/uE+ErUFTZoLqbmHTUPYNpIeYReaSjJb9hUO5bPjPJZEo/13JwGjb/lqclEI
         ICMA==
X-Gm-Message-State: AOAM5311bLs1Y/PuHhEA35fz8+wAF4D/JPZYRM1qzH7ZKkzXegmdWbXX
        xMeQZ3WDgWg8pC95AbeSkqHljg==
X-Google-Smtp-Source: ABdhPJyoea1Pf3EFQWzUSEi8x9f9lo9NqyFxIivys520joj8yl+3mZteFM76/xjubenJrzcq+DZeyw==
X-Received: by 2002:aa7:8e51:0:b029:1ed:2928:18ff with SMTP id d17-20020aa78e510000b02901ed292818ffmr10196325pfr.76.1614973148701;
        Fri, 05 Mar 2021 11:39:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:2878:25d1:94cb:a547])
        by smtp.gmail.com with UTF8SMTPSA id a24sm3501721pff.18.2021.03.05.11.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:39:08 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH v6 4/5] usb: host: xhci-plat: Create platform device for onboard hubs in probe()
Date:   Fri,  5 Mar 2021 11:38:52 -0800
Message-Id: <20210305113832.v6.4.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210305193853.2040456-1-mka@chromium.org>
References: <20210305193853.2040456-1-mka@chromium.org>
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

Changes in v6:
- none

Changes in v5:
- patch added to the series

 drivers/usb/host/xhci-plat.c | 16 ++++++++++++++++
 include/linux/usb/hcd.h      |  2 ++
 2 files changed, 18 insertions(+)

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
2.30.1.766.gb4fecdf3b7-goog

