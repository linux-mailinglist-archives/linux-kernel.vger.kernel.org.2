Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199FD3315EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhCHSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:24:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36038 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCHSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:23:55 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJKXq-0004Cs-CL
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 18:23:54 +0000
Received: by mail-wr1-f71.google.com with SMTP id s10so5196968wre.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzhmjnnDaBAM6gz8zOmUYx1vx5KSpg9Ds20f5pFImQQ=;
        b=k9o0Krw+d0EZJ0rWDRwcw7Ky3jD2/0+SSvI2ke1ykafAn6qJJksNfD+1lR/84j/HNx
         upV1noCDY9WfE9NqMaJCy1FQw7u398G2Aa2v6wGQGud4Y4f/O+ffDd+12C66yG6awbKE
         WHZwpAN2DPA2U5pnPm0eCh6kNQBjwKEw43TU99eJ0IRITOzhzuhp2ddbrSpzv+phCuik
         okowpKhtLNYGc9gaSmlWedEJhEyGGE8ka+GmfADyhbQv+L5XOsmrXudkOynNMa5wVDw0
         0uFFrHvAgAcANUAmEGs3Va8wCaJOFOtypMt03sSOQ1WtpfZ6sq+5qcLtybyMX2oFv9mv
         kVVQ==
X-Gm-Message-State: AOAM5334QZABuGkIckXAaI1VKRMPfdbAlTjceamdWgkh9FDMDbKyYxhy
        XIpKHqcIRNQppXF3pHNKyhCD2lWoO100/OcMBn5WpJ7+M3g+dLFq6sBOazLqH1jY9RQabIpynAj
        O6xS/QoaQxFhW0ROz6hA/YjCfzF2IWu2h/95aa6idvw==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr23826950wrw.95.1615227834162;
        Mon, 08 Mar 2021 10:23:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6by2i2b5cJeyKFWf+JvioS4ol4PlyvgX86myQjOefknz3S/le/EI3WF/MNfYVqwAjsZrJTg==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr23826942wrw.95.1615227834053;
        Mon, 08 Mar 2021 10:23:54 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id f22sm158207wmb.31.2021.03.08.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:23:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/3] clk: socfpga: allow compile testing of Stratix 10 / Agilex clocks
Date:   Mon,  8 Mar 2021 19:23:39 +0100
Message-Id: <20210308182339.379775-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
References: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Stratix 10 / Agilex / N5X clocks do not use anything other than OF
or COMMON_CLK so they should be compile testable on most of the
platforms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/Makefile        |  5 +----
 drivers/clk/socfpga/Kconfig | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 12e46b12e587..9b582b3fca34 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -104,10 +104,7 @@ obj-y					+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
-obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
-obj-$(CONFIG_ARCH_AGILEX)		+= socfpga/
-obj-$(CONFIG_ARCH_N5X)			+= socfpga/
-obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
+obj-y					+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
index 4922cc35f4cc..de7b3137e215 100644
--- a/drivers/clk/socfpga/Kconfig
+++ b/drivers/clk/socfpga/Kconfig
@@ -1,13 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0
+config COMMON_CLK_SOCFPGA
+	bool "Intel SoCFPGA family clock support" if COMPILE_TEST
+	depends on ARCH_AGILEX || ARCH_N5X || ARCH_SOCFPGA || ARCH_STRATIX10 || COMPILE_TEST
+	default y if ARCH_AGILEX || ARCH_N5X || ARCH_SOCFPGA || ARCH_STRATIX10
+	help
+	  Support for the clock controllers present on Intel SoCFPGA and eASIC
+          devices like Stratix 10, Agilex and N5X eASIC.
+
+if COMMON_CLK_SOCFPGA
+
 config COMMON_CLK_STRATIX10
-	bool
-	# Intel Stratix / Agilex / N5X clock controller support
+	bool "Intel Stratix / Agilex / N5X clock controller support" if COMPILE_TEST
 	default y if ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
-	depends on ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
+	depends on ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10 || COMPILE_TEST
 
 config COMMON_CLK_AGILEX
-	bool
-	# Intel Agilex / N5X clock controller support
+	bool "Intel Agilex / N5X clock controller support" if COMPILE_TEST
 	default y if ARCH_AGILEX || ARCH_N5X
-	depends on ARCH_AGILEX || ARCH_N5X
+	depends on ARCH_AGILEX || ARCH_N5X || COMPILE_TEST
 	select COMMON_CLK_STRATIX10
+
+endif # COMMON_CLK_SOCFPGA
-- 
2.25.1

