Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC330FEBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhBDUqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:46:45 -0500
Received: from marcansoft.com ([212.63.210.85]:33408 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhBDUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:42:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F27E54285A;
        Thu,  4 Feb 2021 20:40:45 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 12/18] arm64: setup: Use nGnRnE IO mappings for fixmap on Apple platforms
Date:   Fri,  5 Feb 2021 05:39:45 +0900
Message-Id: <20210204203951.52105-13-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a hack. I do not expect this to be merged as-is.

The problem: on Apple ARM platforms, SoC MMIO needs to use nGnRnE
mappings: writes using nGnRE are blackholed. This seems to be by design,
and there doesn't seem to be any fabric configuration or other bit we
can flip to make the problem go away.

Particularly tricky is that this affects earlycon, which uses fixmap,
which all gets initialized before any of the usual cpufeatures /
alternatives stuff. So we need to take care of fixmap very early.

Options I can think of:

(1) Unconditionally use nGnRnE on all platforms for fixmap IO. Maybe
    this is actually fine? I suspect it might break some PCI-based
    earlycons?

(2) Deal with this special case in the earlycon code, since that seems
    to be the only user that matters on these platforms. Since the
    IO mapping is done in earlycon.c, this will require some cooperation
    with samsung_tty.c so earlycon knows when it needs to do this. Note
    that doing it with DT properties will break cmdline-only earlycon
    config (which otherwise works fine on this driver).

(3) This patch, but do something saner, like use a specific DT flag to
    trigger this mode instead of a platform match.

Any other ideas?

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/include/asm/fixmap.h | 10 +++++++++-
 arch/arm64/kernel/setup.c       | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 4335800201c9..999351ce84df 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -94,7 +94,15 @@ enum fixed_addresses {
 #define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
-#define FIXMAP_PAGE_IO     __pgprot(PROT_DEVICE_nGnRE)
+/*
+ * We use nGnRE by default, but some platforms require nGnRnE for MMIO.
+ */
+extern bool arm64_use_ne_io;
+
+#define FIXMAP_PAGE_IO_DEFAULT	__pgprot(PROT_DEVICE_nGnRE)
+#define FIXMAP_PAGE_IO_STRICT	__pgprot(PROT_DEVICE_nGnRnE)
+#define FIXMAP_PAGE_IO		(arm64_use_ne_io ? FIXMAP_PAGE_IO_STRICT \
+						 : FIXMAP_PAGE_IO_DEFAULT)
 
 void __init early_fixmap_init(void);
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c18aacde8bb0..cd2dc3bdbae4 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -56,6 +56,8 @@ static struct resource *standard_resources;
 
 phys_addr_t __fdt_pointer __initdata;
 
+bool arm64_use_ne_io;
+
 /*
  * Standard memory resources
  */
@@ -197,6 +199,16 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 
 	pr_info("Machine model: %s\n", name);
 	dump_stack_set_arch_desc("%s (DT)", name);
+
+#ifdef CONFIG_ARCH_APPLE
+	/*
+	 * Apple SoCs need to use nGnRnE mappings for MMIO, and this needs
+	 * to be detected before earlycon is initialized.
+	 */
+	if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
+				     "AAPL,arm-platform"))
+		arm64_use_ne_io = true;
+#endif
 }
 
 static void __init request_standard_resources(void)
-- 
2.30.0

