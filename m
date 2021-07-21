Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0993D0A40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhGUHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:23:01 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50065 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhGUHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:21:18 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 65F52FF812;
        Wed, 21 Jul 2021 08:01:49 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes 2/3] Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED"
Date:   Wed, 21 Jul 2021 09:59:36 +0200
Message-Id: <20210721075937.696811-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721075937.696811-1-alex@ghiti.fr>
References: <20210721075937.696811-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9b79878ced8f7ab85c57623f8b1f6882e484a316.

The removal of this config exposes CONFIG_PHYS_RAM_BASE for all kernel
types: this value being implementation-specific, this breaks the
genericity of the RISC-V kernel so revert it.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fcceb8eda07..6a02caf49cde 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -494,8 +494,13 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
 
+config PHYS_RAM_BASE_FIXED
+	bool "Explicitly specified physical RAM address"
+	default n
+
 config PHYS_RAM_BASE
 	hex "Platform Physical RAM address"
+	depends on PHYS_RAM_BASE_FIXED
 	default "0x80000000"
 	help
 	  This is the physical address of RAM in the system. It has to be
@@ -508,6 +513,7 @@ config XIP_KERNEL
 	# This prevents XIP from being enabled by all{yes,mod}config, which
 	# fail to build since XIP doesn't support large kernels.
 	depends on !COMPILE_TEST
+	select PHYS_RAM_BASE_FIXED
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
2.30.2

