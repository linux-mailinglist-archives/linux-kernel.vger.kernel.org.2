Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3731B914
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBOMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:22:32 -0500
Received: from marcansoft.com ([212.63.210.85]:42762 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhBOMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:19:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 095E2424B1;
        Mon, 15 Feb 2021 12:18:28 +0000 (UTC)
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
Subject: [PATCH v2 11/25] arm64: Implement ioremap_np() to map MMIO as nGnRnE
Date:   Mon, 15 Feb 2021 21:16:59 +0900
Message-Id: <20210215121713.57687-12-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used on Apple ARM platforms, which require most MMIO
(except PCI devices) to be mapped as nGnRnE.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 5ea8656a2030..953b8703af60 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -169,6 +169,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 
 #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
+#define ioremap_np(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
 
 /*
  * PCI configuration space mapping function.
-- 
2.30.0

