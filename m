Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F403730E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEDTgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhEDTgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:36:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F6C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:35:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so10644992wry.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUE6T8d/N4f3Mv0jX1DZW932G/DmWRKc7vhygQ2jwlM=;
        b=iY+VQNDWOqV/CG0cFNr9CjtsFJKTTbCm/lkfOwHdVMCGDyal0uZ2C50CTS43njVgTz
         OnOVf/G0AOan8QKQdzXf4eiQbi4MwhQayhKyfYUKV3vzFALPV3HQFcP5zfa0UYE58kgW
         b5RtPat4w1Sb/6LGKFS7o9zYw4SKH0OjDoU8mGUva0X3eh2KOutn3cS2aS2jSZw8gOhw
         Y8gFyh+2JkGDKYGsSoRAbegD6y1CvVaym3vVi+Z3WjBSyuvlfkO2bgQcnMac/Rue+jm0
         S3BZNYVA5+pBIOM5uoredT4nnMp3r7vMIp/VsAnvoH5JUg47Nd5/i3j6fhOQZ63Yeae4
         /7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUE6T8d/N4f3Mv0jX1DZW932G/DmWRKc7vhygQ2jwlM=;
        b=eWFX9goS88ZhINK5Y29kF8t9ZUKevP9hysjn/ZexTnZnEG9SWqpkuzWGU0NfPQdZRw
         lScOOlq0BZQPF52kwbTfDJ5VttN4Q3TosDRKmi4H3p1cSuvSLJsoxjTtIOYUO1EU3Z2o
         mQd8gsyBx3uTYQX7EwrayE2pSvfMJaYIhxerzZJRcnm9E9t6iF2CEYEdHV/p99NB5tl0
         LpsbLGVCkxRMYuFrx9hahqprwG8YkcWhiEMca67s2QtVBYn3qD4YVES3WFs6gJUhkmpQ
         CtzbWir7V4p2UcbKh1b67LP5/wxw9MmaJCgo2Qt6n3E46q9cigT888TROJs40PJWfkf6
         8mIQ==
X-Gm-Message-State: AOAM530mXVQWWaZk+i/kgYUVc2pmRL6flHlL0hqhyHdycvGX9vGFF259
        3WyJzn/PXxzfmHUtRuMc33+7og==
X-Google-Smtp-Source: ABdhPJyTc2cvByzqBL/z0VWYE9grFLrwGOUQgAq6tWjFmTXdEdBZNW+9YhAcr6eeRxF8kc5ORG5rEQ==
X-Received: by 2002:a5d:5741:: with SMTP id q1mr33553742wrw.212.1620156908233;
        Tue, 04 May 2021 12:35:08 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8sm17072136wru.70.2021.05.04.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:35:07 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, kaloz@openwrt.org, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/5] ARM: dts: add intel-ixp42x-welltech-epbx100
Date:   Tue,  4 May 2021 19:34:57 +0000
Message-Id: <20210504193457.4008384-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504193457.4008384-1-clabbe@baylibre.com>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree for intel-ixp42x-welltech-epbx100.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/intel-ixp42x-welltech-epbx100.dts     | 76 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1580313eb372..7d0c94b9108d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -242,6 +242,7 @@ dtb-$(CONFIG_ARCH_INTEGRATOR) += \
 	integratorcp.dtb
 dtb-$(CONFIG_ARCH_IXP4XX) += \
 	intel-ixp42x-linksys-nslu2.dtb \
+	intel-ixp42x-welltech-epbx100.dtb \
 	intel-ixp43x-gateworks-gw2358.dtb
 dtb-$(CONFIG_ARCH_KEYSTONE) += \
 	keystone-k2hk-evm.dtb \
diff --git a/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts b/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
new file mode 100644
index 000000000000..84158503be2a
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Corentin Labbe <clabbe@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "intel-ixp42x.dtsi"
+
+/ {
+	model = "Welltech EPBX100";
+	compatible = "welltech,epbx100", "intel,ixp42x";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory@0 {
+		/* 64 MB SDRAM */
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 root=/dev/ram0 initrd=0x00800000,9M";
+		stdout-path = "uart0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	flash@50000000 {
+		compatible = "intel,ixp4xx-flash", "cfi-flash";
+		bank-width = <2>;
+		/*
+		 * 16 MB of Flash
+		 */
+		reg = <0x50000000 0x1000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "RedBoot";
+				reg = <0x00000000 0x00080000>;
+				read-only;
+			};
+			partition@80000 {
+				label = "zImage";
+				reg = <0x00080000 0x00100000>;
+				read-only;
+			};
+			partition@180000 {
+				label = "ramdisk";
+				reg = <0x00180000 0x00300000>;
+				read-only;
+			};
+			partition@480000 {
+				label = "User";
+				reg = <0x00480000 0x00b60000>;
+				read-only;
+			};
+			partition@fe0000 {
+				label = "FIS directory";
+				reg = <0x00fe0000 0x001f000>;
+				read-only;
+			};
+			partition@fff000 {
+				label = "RedBoot config";
+				reg = <0x00fff000 0x0001000>;
+				read-only;
+			};
+		};
+	};
+};
-- 
2.26.3

