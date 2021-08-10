Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D133E5C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbhHJNrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhHJNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:47:50 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8AC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:47:28 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:5c69:2226:1f00:1a90])
        by laurent.telenet-ops.be with bizsmtp
        id fpnL2500a1ffYXh01pnMiA; Tue, 10 Aug 2021 15:47:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDS6C-001cUJ-NC; Tue, 10 Aug 2021 15:47:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDS6C-001Q7Z-7i; Tue, 10 Aug 2021 15:47:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: APPLE_DART should depend on ARCH_APPLE
Date:   Tue, 10 Aug 2021 15:47:19 +0200
Message-Id: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple DART (Device Address Resolution Table) IOMMU is only present
on Apple ARM SoCs like the M1.  Hence add a dependency on ARCH_APPLE, to
prevent asking the user about this driver when configuring a kernel
without support for the Apple Silicon SoC family.

Fixes: 05ce9d20d699b093 ("iommu/dart: Add DART iommu driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dfe81da483e9e073..e908b8222e4ed679 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -292,7 +292,7 @@ config SPAPR_TCE_IOMMU
 
 config APPLE_DART
 	tristate "Apple DART IOMMU Support"
-	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	default ARCH_APPLE
-- 
2.25.1

