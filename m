Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF4639B847
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFDLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:52:51 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42567 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:52:49 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5547A20007;
        Fri,  4 Jun 2021 11:50:58 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v4 1/4] riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
Date:   Fri,  4 Jun 2021 13:49:47 +0200
Message-Id: <20210604114950.1446390-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210604114950.1446390-1-alex@ghiti.fr>
References: <20210604114950.1446390-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the physical RAM base address available for all kernels, not only
XIP kernels as it will allow to simplify address conversions macros.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b58596b141fc..3d8e7e4bb45c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -493,13 +493,8 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
 
-config PHYS_RAM_BASE_FIXED
-	bool "Explicitly specified physical RAM address"
-	default n
-
 config PHYS_RAM_BASE
 	hex "Platform Physical RAM address"
-	depends on PHYS_RAM_BASE_FIXED
 	default "0x80000000"
 	help
 	  This is the physical address of RAM in the system. It has to be
@@ -512,7 +507,6 @@ config XIP_KERNEL
 	# This prevents XIP from being enabled by all{yes,mod}config, which
 	# fail to build since XIP doesn't support large kernels.
 	depends on !COMPILE_TEST
-	select PHYS_RAM_BASE_FIXED
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
2.30.2

