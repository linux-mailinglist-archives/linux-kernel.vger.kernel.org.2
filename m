Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A24075C2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhIKJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 05:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhIKJX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 05:23:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6151E611F2;
        Sat, 11 Sep 2021 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631352135;
        bh=HpczDCI/VmO/hoLx97DUXUTuxC7jnTK5MeZdEMO4bFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtZx2lq4XG8v1qS1EWbvBLfNb6/XMkIMsAPC9iBdpu5kJ3ty01Kd9zQ90LE95YrZt
         Vp0UxnDyBGBEnhmgUGxF/HUs7jSAHUiQohJyGJ6a5ThnI/pA5oHmlVMOSArIH1UFmF
         GoKANXwnhfdMeD3dOsV+TNFodHvXoSnDTem82IJ1j18vQOxvdu5JkZnT+YrpRwivOe
         QkdVMLiZub4dbxP9XJwfZ2123nKfJhaLdk12sJsX64+ejmGX6ul+98kQRXbbEMqoSF
         hkztwP4YgeHHjvkTvts88Sedq0SrOLV3ebYqGgHPPUqLBjVLYutvDKcnQhMNMrAC7P
         zLizmKvVCNd/A==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V4 3/6] RISC-V: Support a new config option for non-coherent DMA
Date:   Sat, 11 Sep 2021 17:21:36 +0800
Message-Id: <20210911092139.79607-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911092139.79607-1-guoren@kernel.org>
References: <20210911092139.79607-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

In future, there will be more RISC-V platforms with non-coherent DMA.
Instead of selecting all the required config options in every soc, create
a new config that selects all the required configs related non-coherent
DMA.

Signed-off-by: Atish Patra <atish.patra@wdc.com>

RISC-V: Support DMA_DIRECT_REMAP for non-coherent DMA

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3ab3730bee92..d18a59ea10e5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -213,6 +213,15 @@ config PGTABLE_LEVELS
 config LOCKDEP_SUPPORT
 	def_bool y
 
+config RISCV_DMA_NONCOHERENT
+	bool
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SETUP_DMA_OPS
+	select DMA_GLOBAL_POOL
+	select DMA_DIRECT_REMAP
+
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.erratas"
 
-- 
2.25.1

