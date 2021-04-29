Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8436E747
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbhD2Iqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:46:32 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:25811 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhD2Iqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:46:31 -0400
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C4ECF240006;
        Thu, 29 Apr 2021 08:45:42 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Disallow to build XIP_KERNEL with SOC_SIFIVE
Date:   Thu, 29 Apr 2021 04:45:41 -0400
Message-Id: <20210429084541.28083-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISCV_ERRATA_ALTERNATIVE patches text at runtime which is not possible when
the kernel is executed from the flash in XIP mode, and as the SIFIVE
errata must be fixed somehow, disallow to build a XIP kernel that
supports SIFIVE socs.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig.erratas | 2 +-
 arch/riscv/Kconfig.socs    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index d5d03ae8d685..9537dbd67357 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -2,7 +2,7 @@ menu "CPU errata selection"
 
 config RISCV_ERRATA_ALTERNATIVE
 	bool "RISC-V alternative scheme"
-	default y
+	default y if !XIP_KERNEL
 	help
 	  This Kconfig allows the kernel to automatically patch the
 	  errata required by the execution platform at run time. The
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 00c2b205654c..9cb38bc9d7cd 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -9,6 +9,7 @@ config SOC_MICROCHIP_POLARFIRE
 
 config SOC_SIFIVE
 	bool "SiFive SoCs"
+	depends on !XIP_KERNEL
 	select SERIAL_SIFIVE if TTY
 	select SERIAL_SIFIVE_CONSOLE if TTY
 	select CLK_SIFIVE
-- 
2.20.1

