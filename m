Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700131B919
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBOMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhBOMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:19:40 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55C1C06178C;
        Mon, 15 Feb 2021 04:18:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DFBC442510;
        Mon, 15 Feb 2021 12:18:53 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/25] arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
Date:   Mon, 15 Feb 2021 21:17:04 +0900
Message-Id: <20210215121713.57687-17-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a Kconfig option to toggle support for Apple ARM SoCs.
At this time this targets the M1 and later "Apple Silicon" Mac SoCs.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..13659523876d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -29,6 +29,14 @@ config ARCH_ALPINE
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
 
+config ARCH_APPLE
+	bool "Apple Silicon SoC family"
+	select APPLE_AIC
+	select ARM64_FIQ_SUPPORT
+	help
+	  This enables support for Apple's in-house ARM SoC family, starting
+	  with the Apple M1.
+
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
 	select TIMER_OF
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a0bcf0201261..7b37a52d0887 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_AGILEX=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
+CONFIG_ARCH_APPLE=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM4908=y
 CONFIG_ARCH_BCM_IPROC=y
-- 
2.30.0

