Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15A39C2B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFDVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhFDVnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:43:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69070C061795
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 14:41:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 6so8888967pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cb8MKJzTDoaj8WiPaa35LEcoEg4Drs9vV0lgWkDtDAo=;
        b=QVZ4rAfi8C5Ki+5xWVj1CwGynxccuyQcHJneYbyKvKxu1OI93FK+6Kg+/DR/7gbjDA
         zh59GaAysCTFJ51ScCtozx8PQ4ViIb7IwRYl7rOqIYkHa+2G9m5U19TpTHLBACrLUtRD
         p4630iYKmKM/m4L9LxKEKFreT43h6HKoN4zJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cb8MKJzTDoaj8WiPaa35LEcoEg4Drs9vV0lgWkDtDAo=;
        b=QGJmJ5zNrAoRJM2hWs0S8M6eTRLAu1V7w32yE6SIrIr7togv4d/hzt2QB7RzblTgIR
         wt4MdaPWyMnj7AWrrr7PzaifdoSS9JLBDryFKMt5WBVgIhaXngcc8ebmb5rr+E9XCU5w
         RaVAk7hfpOCt/WrBsvWj6vodrPIdIVsltOug29hMv2pgVcwi9o03UELed23iQaeaAdMV
         VF+8TCBWX+R5xaSGz5nrAdGrJZU4L9LbS+hlwITbDvOnXgLOn+8QUfgg5BDQc3lpMu9n
         g1KeDg8CgEkA0eG5FZDjKoD98H5eh0N9bb5K39cSS74S939l6JlhovqKnIy0+Lpok8L4
         K9gg==
X-Gm-Message-State: AOAM532KhLAGi8LgP1vV4NKLBDvmhizZR56oa87qQ2214Y3SubyBH0+J
        srnrHSo/nBC3T+yf+37b6epgHQ==
X-Google-Smtp-Source: ABdhPJxO45TRA3vR8JSzcoH+gsoFwveRpeyt/ffdpKxCxP9fKAm1XpW7U5WeidBdo3AQBixHz3EItw==
X-Received: by 2002:a65:5a47:: with SMTP id z7mr6970405pgs.400.1622842876818;
        Fri, 04 Jun 2021 14:41:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id w125sm2432309pfw.214.2021.06.04.14.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:41:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v11 4/5] usb: host: xhci-plat: Create platform device for onboard hubs in probe()
Date:   Fri,  4 Jun 2021 14:41:00 -0700
Message-Id: <20210604144027.v11.4.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210604214101.3363525-1-mka@chromium.org>
References: <20210604214101.3363525-1-mka@chromium.org>
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
index df9428f1dc5e..46818b232204 100644
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
index 2595a8f057c4..52d9b28745de 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1919,6 +1919,8 @@ struct xhci_hcd {
 	struct dentry		*debugfs_slots;
 	struct list_head	regset_list;
 
+	struct list_head	onboard_hub_devs;
+
 	void			*dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[] __aligned(sizeof(s64));
-- 
2.32.0.rc1.229.g3e70b5a671-goog

