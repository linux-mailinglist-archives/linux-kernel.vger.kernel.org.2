Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C783D998C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhG1XiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhG1XiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:38:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD7C061765;
        Wed, 28 Jul 2021 16:38:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t3so2581482plg.9;
        Wed, 28 Jul 2021 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TM1oWFJiQ55sCFQ7wpGHeNKBl5+PgVPl+xUxtGHeuDA=;
        b=I1042sBWKb+QVDCGOEqGBiFnCM3hVK/1s4yYAMaLBBxqae36UPOw+4Jb07vYE6R2dY
         uSDKJLjYAryvvfkAFzo2/Ah9h1X/VkKULWXFySS/2ZWA8xvU+SyNMZsnArfcHvjxhnDq
         V3J+sj4WAS7Gab7twrSEfc6cYAmZExoGPldDWMygvSF/Z704yUK8HHsirr3gUkVeST+N
         KBEltaVshKEf8x/hXIAYvrXFc6senSs5HB+42Hl6jaWckU9rZDD6mlNYh0Yp1vj5p5iW
         vwweQD9S25RgBxLStHcxDvcyeQZEVqE31Z0LZbR7pqEtLQrPY6tXrIpIsuv1LSMnJso9
         ALUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TM1oWFJiQ55sCFQ7wpGHeNKBl5+PgVPl+xUxtGHeuDA=;
        b=c3XaTWxQWoiJnkj4sQrkVDTDVl5AaGiF0gSFWy0+3FeLfzNV004NhubOo+VqbVeUUf
         EmX7vxCxpwR2sES6LG34ea+idvdqCf9rbwCm7YaQFJsClAt8rw9/Uq3P/JUf9kdcKfv9
         C13FEGfbg5iclYFKbG4do9uxF8u2NoUONGJ6zjQWA/NP0meUliULKah/ORwo2uwDx6gV
         /o0ItlrGmckinOh3qjzV+TZ/Tjw8BLxwUvj0K19gbtE3s5DZoW1AH9fFncLMj5bwnaTj
         0k0qQk8uW9Ybcu4ahyRKvTe9hxK0qVjHUoINkUPmeHXB325NwmtQdtSP067YyUcyKDco
         VO1g==
X-Gm-Message-State: AOAM532LIy6E8puBQrJbzY+otE/3mXB1zJkQKG7+ZwvHYKnU+wHT7GmV
        HbAheGMO+AT+faVEA3Wg6lg=
X-Google-Smtp-Source: ABdhPJyUkypAjII61agd3+GcR+1EIgkC9yRJLVJ4SSY6U5CP784rDEdPD6XPamhPhWKFzVf/N20poQ==
X-Received: by 2002:a17:90a:ce07:: with SMTP id f7mr2139372pju.81.1627515486795;
        Wed, 28 Jul 2021 16:38:06 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id k37sm1038671pgm.84.2021.07.28.16.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:38:06 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/6] ARM: dts: Add Facebook BMC 128MB flash layout
Date:   Wed, 28 Jul 2021 16:37:50 -0700
Message-Id: <20210728233755.17963-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210728233755.17963-1-rentao.bupt@gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This is the layout used by Facebook BMC systems. It describes the fixed
flash layout of a 128MB mtd device.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/facebook-bmc-flash-layout-128.dtsi    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi

diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi b/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
new file mode 100644
index 000000000000..7f3652dea550
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot@0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta@f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 119 MB.
+	 */
+	fit@100000 {
+		reg = <0x100000 0x7700000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (8MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0@7800000 {
+		reg = <0x7800000 0x800000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0@0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.17.1

