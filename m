Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818063EBCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhHMTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhHMTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:53:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38044C061292
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:52:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bo18so16972515pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9Rmu3khB0kAKTqvY5KWNzvfUL1dPXP+fLP9201xmak=;
        b=av8ZrIBvUM9hRpZVFwbUKZwLn2rXRoaHSb4/HOsVGKL7qYduvlwoxVy31eMFlY2nci
         lG7Q8S9SSkYUFT4SnL56w4Dm69qWmAD0UAJ9ge/PeiX2Ie9l8KQA305+tM9dz2l3HTGO
         whRsW1NtjHNHSDHSt2CxTPksVISyHaWynR1GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9Rmu3khB0kAKTqvY5KWNzvfUL1dPXP+fLP9201xmak=;
        b=Vf5c+VAJ3lBNmlvAW3Pd0pv+hJbmu80914B1rIXEYVbdxMUXg7wTBqjX6zE/0RkEG5
         23Ocd/M/8t0Wc0UdKTy86kkKLt3kc1na1goPIJ1oHf2/Y+oQSZ+RoGrJ1E9Mkhryokfi
         mLOUwUKKK0dJ9To7jwAlNWvx0miPpzBzPDzBhDm5K9UTgEAni5NNz7tmrB+IcsX8Rk8n
         t+GRY/dToakjgAFE4nOA/TGbfeZuoOMjKLkW264U8yioQhNhMlUedk4ATdkVZfGqBfWB
         Xf4rqbhkLeVlee0Z/q7x5KZ1UYtfFMwEofVZCBoWg9LTUJXsV91iUE1iZij8NH6v0Xyi
         nHfg==
X-Gm-Message-State: AOAM533GC3wN60GYhQlBI9Aw107NTv3xRm2FIeS7N+Lm8LIjzbfHpgR4
        whT3TguQYnQool09z3ISZTKNnw==
X-Google-Smtp-Source: ABdhPJzMsWHluNheUBxKxn/mMpe02w5C5YzOslH3Qs1NIX7pgA6rpbeKz4VALiqEC017+IZBEQEDGg==
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr3242709pjb.234.1628884371370;
        Fri, 13 Aug 2021 12:52:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:450d:9788:a70e:42d6])
        by smtp.gmail.com with UTF8SMTPSA id x189sm3625510pfx.99.2021.08.13.12.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:52:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v16 6/7] usb: host: xhci-plat: Create platform device for onboard hubs in probe()
Date:   Fri, 13 Aug 2021 12:52:27 -0700
Message-Id: <20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813195228.2003500-1-mka@chromium.org>
References: <20210813195228.2003500-1-mka@chromium.org>
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

Changes in v16:
- none

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
2.33.0.rc1.237.g0d66db33f3-goog

