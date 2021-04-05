Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5605C35477D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbhDEUSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbhDEUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:18:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71FBC0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:18:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i190so607959pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phmSYqCi7mknHFm/KEUrvvrrvKp87F1PLLd2ohbWer0=;
        b=Bxew4BZaVIb/CcsXTp3cHQMwuxLv24nehxixcLowRwatyS6BltOCsORKpKFH+CiA3I
         QOxQ/TLddPQ4SK07LmBHRLXCbtiCrOr0VeDLNcw+bozvTh5jBr+pjf/o1HgTPmPftuxm
         XFyXvVmvuHKiCL1i+/4e9sSA5pvER1jWuvSJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phmSYqCi7mknHFm/KEUrvvrrvKp87F1PLLd2ohbWer0=;
        b=mfMpzVPEMrEeiNoDzBmqZHztAKRxKE4fCp6Rb4WnBo2ei/7XLEGFlC8LMhJ0WONALN
         bpQJUt8jLQii8ppArelmpNYjURld3SYdXvxTzPk9zCWJMiDhyHFgFdUpADeXWmddwi4Z
         DXoML7Jz9ZcS2ETYWUJVzkBBTssSMNQWmnuKHdWkK+XcFC4eDHkanMDImLzFqIDpTXjF
         Y3nQEOTfe/J3fl7ZjLSpzWlCPCTj75Y5f92csAtZXr6k2NfIgcIUHOkD0QdFPeOYEz8H
         +h3n0LkrxBbja9qYYpXzM32+okXYVkFQFPuxVghx2rZAF7Iz3VF6kTc99YYhCQa5wN3N
         0YCQ==
X-Gm-Message-State: AOAM530rZs1L0Qwd9EhjwZHkrq2IxWbQkU8inhCbGFG0UaIC6gTMtD75
        BVNm3aEgBTARTHnTq+IH+Oykqw==
X-Google-Smtp-Source: ABdhPJx0kAom4olpEYGNk79t5SSQ9qqWEbGmGVAM/ejqc97986HkvwYxt3fDf0ZzajLsBWF/qqdR3w==
X-Received: by 2002:a63:cc:: with SMTP id 195mr24247056pga.282.1617653907297;
        Mon, 05 Apr 2021 13:18:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:455e:b8cf:5939:67da])
        by smtp.gmail.com with UTF8SMTPSA id x1sm256458pje.40.2021.04.05.13.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 13:18:26 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH v6 4/5] usb: host: xhci-plat: Create platform device for onboard hubs in probe()
Date:   Mon,  5 Apr 2021 13:18:16 -0700
Message-Id: <20210405124900.v6.4.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
In-Reply-To: <20210405201817.3977893-1-mka@chromium.org>
References: <20210405201817.3977893-1-mka@chromium.org>
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

Changes in v7:
- none

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
2.31.0.208.g409f899ff0-goog

