Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3994175C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbhIXNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:32:19 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37606
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346166AbhIXNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:32:15 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8ED4E4027C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490240;
        bh=3xD6qAEhtRsJqFfznLwkKRQHrDkBb3UaWxl2/slC6j4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nSjm3xZyhfahJPG/dd2BJOA02+LCoFxYoguBs6CybtMYbjB18D0DM1KPv5jTLqY6X
         nlIYIqRHgJy0L2EuIYJBhbSmCdrSEPWC8yJ/9FBt4CSurIYr66iqE2ky6vcDn1hlWU
         dN/Ng9JdxDbazvJTXTJcyi+IbVK0gMqN2vOx5C7QIrxadz8Zv6v+ym8xtkmTph3fQ7
         yrGW20s5ZFT/wLoikFsCKO21fuU0JaiqEaVADR1b5D/7kijNpavDfURf4af/uc2EJN
         vFX3G4DsRxx92eYfnzBOSu+LAndjijk0OZbK/ulBe/rJagxD97Cc/FzyXB863N443R
         LzrdsmSDinvSw==
Received: by mail-wr1-f72.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso8066268wrw.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xD6qAEhtRsJqFfznLwkKRQHrDkBb3UaWxl2/slC6j4=;
        b=76E0lJ/2VWpuEhrp91pxlEJZ7ky90Zx1p8eDxybTJolk+fNY+ByJEUPoptDuG6L7UO
         kUYQDdJsAVYXkvApzrrQWhCx/dpddZMj9jWaGtF1zQ6S1CrVx2/R5iLJP48mNm7Jk7qa
         bLpSEJBsZRMWQH97K4+Zz0J/CU7j6O7Ezopuu7JLp6MmOVG83LHvP6b14PrLm+1rIUQN
         8xghrDSyss84bHwMQDjlmA/7D+6OwNWHnsrAGQ48EUePpE0mLx22XdzosDdkf9wn/Lol
         jt1HTsoNJennV9U2nJBiKbUgC8/TgzQqCZjGWjYMM3g1WLygbXn1OxmbBX133WC9u517
         q0bw==
X-Gm-Message-State: AOAM532uvYyzUnvJNH1uhoyzbN+apr2I1HjoyVzCPButOV/GR/qEcz3W
        BrVMI4l47yU6fqgmubLPHaEyJuh5+7MGy8T2VRJRelVhS8J8BhVDDm9K7i9FZ+/Pe3FehF3nOod
        fRYBIiKMpeHoF5OB9nrLUg+XMYJrCUu4jjQEXA7NRQA==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr2131021wmc.105.1632490239946;
        Fri, 24 Sep 2021 06:30:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxatSONAGwx8bkyPabvpoXT2g6eOdCu2CFURKgVt6gBRUeQdbu9BS0S8yUmhBIZdqIfSdu7VA==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr2130997wmc.105.1632490239750;
        Fri, 24 Sep 2021 06:30:39 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l19sm8646742wrc.16.2021.09.24.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:30:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: exynos: describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:30:05 +0200
Message-Id: <20210924133005.111564-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/usb/dwc3/Kconfig | 7 ++++---
 drivers/usb/host/Kconfig | 6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 66b1454c4db2..c483f28b695d 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -66,12 +66,13 @@ config USB_DWC3_OMAP
 	  Say 'Y' or 'M' here if you have one such device
 
 config USB_DWC3_EXYNOS
-	tristate "Samsung Exynos Platform"
+	tristate "Samsung Exynos SoC Platform"
 	depends on (ARCH_EXYNOS || COMPILE_TEST) && OF
 	default USB_DWC3
 	help
-	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
-	  say 'Y' or 'M' if you have one such device.
+	  Recent Samsung Exynos SoCs (Exynos5250, Exynos5410, Exynos542x,
+	  Exynos5800, Exynos5433, Exynos7) ship with one DesignWare Core USB3
+	  IP inside, say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_PCI
 	tristate "PCIe-based Platforms"
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c4736d1d020c..d1d926f8f9c2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -290,7 +290,8 @@ config USB_EHCI_EXYNOS
 	tristate "EHCI support for Samsung S5P/Exynos SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
-	  Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
+	  Enable support for the Samsung S5Pv210 and Exynos SOC's on-chip EHCI
+	  controller.
 
 config USB_EHCI_MV
 	tristate "EHCI support for Marvell PXA/MMP USB controller"
@@ -563,7 +564,8 @@ config USB_OHCI_EXYNOS
 	tristate "OHCI support for Samsung S5P/Exynos SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
-	  Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
+	  Enable support for the Samsung S5Pv210 and Exynos SOC's on-chip OHCI
+	  controller.
 
 config USB_CNS3XXX_OHCI
 	bool "Cavium CNS3XXX OHCI Module (DEPRECATED)"
-- 
2.30.2

