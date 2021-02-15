Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CF31B913
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhBOMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhBOMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:19:10 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB4BC061756;
        Mon, 15 Feb 2021 04:18:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 323FA424AC;
        Mon, 15 Feb 2021 12:18:23 +0000 (UTC)
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
Subject: [PATCH v2 10/25] asm-generic/io.h:  Add a non-posted variant of ioremap()
Date:   Mon, 15 Feb 2021 21:16:58 +0900
Message-Id: <20210215121713.57687-11-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 currently defaults to posted MMIO (nGnRnE), but some devices
require the use of non-posted MMIO (nGnRE). Introduce a new ioremap()
variant to handle this case. ioremap_np() is aliased to ioremap() by
default on arches that do not implement this variant.

This adds the IORESOURCE_MEM_NONPOSTED flag, which maps to this
variant and marks a given resource as requiring non-posted mappings.
This is implemented in the resource system because it is a SoC-level
requirement, so existing drivers do not need special-case code to pick
this ioremap variant.

Then this is implemented in devres by introducing devm_ioremap_np(),
and making devm_ioremap_resource() automatically select this variant
when the resource has the IORESOURCE_MEM_NONPOSTED flag set.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 include/asm-generic/io.h |  8 +++++++-
 include/linux/io.h       |  2 ++
 include/linux/ioport.h   |  1 +
 lib/devres.c             | 22 ++++++++++++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index c6af40ce03be..43e4bb8d633c 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -942,7 +942,9 @@ static inline void *phys_to_virt(unsigned long address)
  *
  * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
  * for specific drivers if the architecture choses to implement them.  If they
- * are not implemented we fall back to plain ioremap.
+ * are not implemented we fall back to plain ioremap. Conversely, ioremap_np()
+ * can provide stricter non-posted write semantics if the architecture
+ * implements them.
  */
 #ifndef CONFIG_MMU
 #ifndef ioremap
@@ -980,6 +982,10 @@ static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 #define ioremap_wt ioremap
 #endif
 
+#ifndef ioremap_np
+#define ioremap_np ioremap
+#endif
+
 /*
  * ioremap_uc is special in that we do require an explicit architecture
  * implementation.  In general you do not want to use this function in a
diff --git a/include/linux/io.h b/include/linux/io.h
index 8394c56babc2..d718354ed3e1 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -68,6 +68,8 @@ void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
+void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index fe48b7840665..5929a67570ae 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -108,6 +108,7 @@ struct resource {
 #define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
+#define IORESOURCE_MEM_NONPOSTED	(1<<7)
 
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
diff --git a/lib/devres.c b/lib/devres.c
index 2a4ff5d64288..4679dbb1bf5f 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -10,6 +10,7 @@ enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
 	DEVM_IOREMAP_UC,
 	DEVM_IOREMAP_WC,
+	DEVM_IOREMAP_NP,
 };
 
 void devm_ioremap_release(struct device *dev, void *res)
@@ -42,6 +43,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
 	case DEVM_IOREMAP_WC:
 		addr = ioremap_wc(offset, size);
 		break;
+	case DEVM_IOREMAP_NP:
+		addr = ioremap_np(offset, size);
+		break;
 	}
 
 	if (addr) {
@@ -98,6 +102,21 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(devm_ioremap_wc);
 
+/**
+ * devm_ioremap_np - Managed ioremap_np()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed ioremap_np().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
+			      resource_size_t size)
+{
+	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NP);
+}
+EXPORT_SYMBOL(devm_ioremap_np);
+
 /**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
@@ -128,6 +147,9 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 		return IOMEM_ERR_PTR(-EINVAL);
 	}
 
+	if (type == DEVM_IOREMAP && res->flags & IORESOURCE_MEM_NONPOSTED)
+		type = DEVM_IOREMAP_NP;
+
 	size = resource_size(res);
 
 	if (res->name)
-- 
2.30.0

