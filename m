Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20B3CC733
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhGRByT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 21:54:19 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46973 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbhGRByP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 21:54:15 -0400
Received: by mail-pl1-f179.google.com with SMTP id c15so7618286pls.13;
        Sat, 17 Jul 2021 18:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NG6pheoCZKg5UXChiGjOLrLU9fLUpsB1CjGA68gDk8k=;
        b=tJDge/o+yeqJDcdkBEI9FsGha/sE8vIVAhoX4RJpYryq4sbAeSAPqe5HMjaCj6BhBt
         TC3Cm+tRz4t6EMZ+cdyF6IiSnGx2jkwkTndxN0gldkvYZHrNGDmNfJs2/t4tLeMOGcmh
         bBwvqzB0CL3Y4UutLNjOU7reYzgF/3gw8VHnOBDd3RMu60Zd7NUwqLU4rS4x5qp69jOH
         FsuAKo5w3aWksy0nDCUivgNs8RS3ivZFvjusmej+yiS9HBH7zqcLYH36PHLIiW1QVtJ3
         GtqSPLXbNvCZ7DGJQS8UiRoLCHRJDJ4mK7FN1EuvzQJcLNTC7I/3qRi8Zj1U0Qj9382f
         x8iA==
X-Gm-Message-State: AOAM532I6Y/OfBuOp9mc3F+Ap8/JvNLwtUKQbMlGPrFXL+2KJGy21v7/
        GFlpdnLoZqVWtR2xkNC2EFlE+0uPpsc=
X-Google-Smtp-Source: ABdhPJzto7UloYy2y1932tH4/csp9BczYENPIJQN0qn19MDDh3Lc0exmtcvMH1cFQ/pVNaGwxEQ/QA==
X-Received: by 2002:a17:903:234f:b029:12b:7bad:75cb with SMTP id c15-20020a170903234fb029012b7bad75cbmr3028593plh.67.1626573076666;
        Sat, 17 Jul 2021 18:51:16 -0700 (PDT)
Received: from localhost ([24.4.24.239])
        by smtp.gmail.com with ESMTPSA id q3sm14726441pfj.89.2021.07.17.18.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 18:51:16 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, moritzf@google.com,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        Moritz Fischer <mdf@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/2] usb: renesas-xhci: Remove renesas_xhci_pci_exit()
Date:   Sat, 17 Jul 2021 18:51:11 -0700
Message-Id: <20210718015111.389719-3-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210718015111.389719-1-mdf@kernel.org>
References: <20210718015111.389719-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty function renesas_xhci_pci_exit() that does not
actually do anything.

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/usb/host/xhci-pci-renesas.c | 5 -----
 drivers/usb/host/xhci-pci.c         | 2 --
 drivers/usb/host/xhci-pci.h         | 3 ---
 3 files changed, 10 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 327f6a6d5672..1ebacc42a552 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -620,9 +620,4 @@ int renesas_xhci_check_request_fw(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(renesas_xhci_check_request_fw);
 
-void renesas_xhci_pci_exit(struct pci_dev *dev)
-{
-}
-EXPORT_SYMBOL_GPL(renesas_xhci_pci_exit);
-
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 18c2bbddf080..4456ba338b74 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -449,8 +449,6 @@ static void xhci_pci_remove(struct pci_dev *dev)
 	struct xhci_hcd *xhci;
 
 	xhci = hcd_to_xhci(pci_get_drvdata(dev));
-	if (xhci->quirks & XHCI_RENESAS_FW_QUIRK)
-		renesas_xhci_pci_exit(dev);
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
index acd7cf0a1706..cb9a8f331a44 100644
--- a/drivers/usb/host/xhci-pci.h
+++ b/drivers/usb/host/xhci-pci.h
@@ -7,7 +7,6 @@
 #if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
 int renesas_xhci_check_request_fw(struct pci_dev *dev,
 				  const struct pci_device_id *id);
-void renesas_xhci_pci_exit(struct pci_dev *dev);
 
 #else
 static int renesas_xhci_check_request_fw(struct pci_dev *dev,
@@ -16,8 +15,6 @@ static int renesas_xhci_check_request_fw(struct pci_dev *dev,
 	return 0;
 }
 
-static void renesas_xhci_pci_exit(struct pci_dev *dev) { };
-
 #endif
 
 struct xhci_driver_data {
-- 
2.32.0

