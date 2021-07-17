Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A933CC128
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGQEr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 00:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGQErX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:47:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C23C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=onMVrjqAEvJjd4tsCsT78zKN0c6rmc2F6J3NS5Ou/KE=; b=sX3Pp7nQCx9pMaGxoMT1OToTL3
        spc/s4HY0nBpmNgC7YHgiA3gKIdaybjwwmYzC73GmADJenk3PfrAhOriAzOIUQvNNBafRehPWCjhQ
        pUqMRjpQoldynD17m7WcOqosEQEIZ9IrhIANCElQLj1oRHNeagEXG2wOM0Nqw+rcSbFAa2Lob+MW5
        e03Caa69INx/+NyD5SDbVh5aCtvhahmrHXhBVadgHj5i8j7W7Zy6CPMi8pVXTXOJZeIpaV0+rCO2s
        hZPT4OTouhFa3+0RuU1p1u5OEU0fT/K+pO1a4Hsr8qSumr+s4JL+ZKSFP+Z47865W19iaR5UmmMMV
        zOjy2ipw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4cBd-005vwh-DK; Sat, 17 Jul 2021 04:44:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: add rv32 and rv64 randconfig build targets
Date:   Fri, 16 Jul 2021 21:44:24 -0700
Message-Id: <20210717044424.17478-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to do randconfig build targets for both
rv32 and rv64.

Based on a similar patch by Michael Ellerman for PowerPC.

Usage:
  make ARCH=riscv rv32_randconfig
or
  make ARCH=riscv rv64_randconfig

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org

 arch/riscv/Makefile              |   10 ++++++++++
 arch/riscv/configs/32-bit.config |    2 ++
 arch/riscv/configs/64-bit.config |    2 ++
 3 files changed, 14 insertions(+)

--- linux-next-20210715.orig/arch/riscv/Makefile
+++ linux-next-20210715/arch/riscv/Makefile
@@ -132,3 +132,13 @@ zinstall install:
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+
+PHONY += rv32_randconfig
+rv32_randconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/32-bit.config \
+		-f $(srctree)/Makefile randconfig
+
+PHONY += rv64_randconfig
+rv64_randconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
+		-f $(srctree)/Makefile randconfig
--- /dev/null
+++ linux-next-20210715/arch/riscv/configs/32-bit.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV32I=y
+CONFIG_32BIT=y
--- /dev/null
+++ linux-next-20210715/arch/riscv/configs/64-bit.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV64I=y
+CONFIG_64BIT=y
