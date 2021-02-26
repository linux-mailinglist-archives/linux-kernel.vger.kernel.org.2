Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABF13263C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBZOHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:07:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBZOEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:04:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 782A7AD57;
        Fri, 26 Feb 2021 14:03:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 07/13] arm64: Mark ARCH_MVEBU as needing broken 64bit MMIO support
Date:   Fri, 26 Feb 2021 15:02:59 +0100
Message-Id: <20210226140305.26356-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus AP806's IOMMU sits on can't handle 64bit MMIO accesses[1]. So
select 'ARCH_HAS_64BIT_MMIO_BROKEN' for the platform.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
[1] See Armada-AP806 erratum #582743
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cdfd5fed457f..04a97cf486c5 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -175,6 +175,7 @@ config ARCH_MESON
 
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
+	select ARCH_HAS_64BIT_MMIO_BROKEN
 	select ARMADA_AP806_SYSCON
 	select ARMADA_CP110_SYSCON
 	select ARMADA_37XX_CLK
-- 
2.30.1

