Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBC4075C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhIKJXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235598AbhIKJXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:23:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6056761221;
        Sat, 11 Sep 2021 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631352150;
        bh=cRNfFnfeWGtcYlgL0PiB2KFICmvm/APlEwTrrujZ2D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwTVSxsrXizDaf29KSNkLvVarSdmBDDs1X9JPPdiCw+yjKX+h2av4oPRu1n/F2fmB
         b77KfT4cmza+/EoQ+o5uxVYZff8Wr3WaU3N7o427j0MZmI8UpiWjR6FYn4ZKVICYlX
         HrZiFmwgslW4SKxAalSW90GoxGhe/YrmbCFHVxhSb3MI7F+QYbUQJJLyiWs6OiT3iO
         U1X53I/4wcF5qjm8Y4kIasLuAVS7LjtNS7m/uxohtGQa1pXW3Yygz9qOv7NPJA3DUc
         o/YH2LxMuKWeUrnMBDljTHk9+qu+VXNXDF8kSCboZCJuEcccTz5Pqf0DoYbVM5j+9n
         iSH6vrqlx8sZg==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>
Subject: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
Date:   Sat, 11 Sep 2021 17:21:39 +0800
Message-Id: <20210911092139.79607-7-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911092139.79607-1-guoren@kernel.org>
References: <20210911092139.79607-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Shaohua <liush@allwinnertech.com>

Add Allwinner kconfig option which selects SoC specific and common
drivers that is required for this SoC.

Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
interconnect issues for dma synchronization, so we set the default
value when SOC_SUNXI selected.

Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Wei Fu <wefu@redhat.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/Kconfig.socs      | 15 +++++++++++++++
 arch/riscv/configs/defconfig |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 30676ebb16eb..8721c000ef23 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -70,4 +70,19 @@ config SOC_CANAAN_K210_DTB_SOURCE
 
 endif
 
+config SOC_SUNXI
+	bool "Allwinner SoCs"
+	depends on MMU
+	select DWMAC_GENERIC
+	select ERRATA_THEAD
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_ERRATA_ALTERNATIVE
+	select SERIAL_8250
+	select SERIAL_8250_CONSOLE
+	select SERIAL_8250_DW
+	select SIFIVE_PLIC
+	select STMMAC_ETH
+	help
+	  This enables support for Allwinner SoC platforms like the D1.
+
 endmenu
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index bc68231a8fb7..a50f250fbdd8 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -15,6 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
+CONFIG_SOC_SUNXI=y
 CONFIG_SOC_VIRT=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
-- 
2.25.1

