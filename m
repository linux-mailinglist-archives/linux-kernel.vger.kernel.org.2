Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F1407B6D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 05:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhILDq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 23:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhILDq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 23:46:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6337C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8WjU6g8LyQFS2vag9kHMbs4XWQe5eyGfJBzL3JNFYYE=; b=0d2AutHRpw+684dykEBk+aueDi
        Z0fA2iwP/0HP+I8+qt4R/Xl7ArtNLyQWF3tqlneLJsrqoJQnagF9MB6HURvwlv4sQKqtP03Zc5WNC
        vHVGfr1Mzk9IDzcG5aLozbpGSXJqz7/2X0QHgIPXyrwsQdwr7Ka+eae9kIqYb+RtXecJgQWBiRmqE
        6d8cvdL5Y3I++US5jT413WbXBpb/2hdzePyiy1xuB5lzssbg3LQ28cYRH4Q05G8MzR8kSKAeJvi4X
        A/R1M+gONPnYMkSaoCgzscb1OLpnJoZZE+99fyJqmSeTX62++ybVn8QArZT0fa2okFnF8t43dNw7G
        EAAOoPKg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPGR1-00Fmmw-NJ; Sun, 12 Sep 2021 03:45:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] riscv: add rv32 and rv64 randconfig build targets
Date:   Sat, 11 Sep 2021 20:45:38 -0700
Message-Id: <20210912034538.19404-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
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

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
v2: add missing S-o-b

 arch/riscv/Makefile              |   10 ++++++++++
 arch/riscv/configs/32-bit.config |    2 ++
 arch/riscv/configs/64-bit.config |    2 ++
 3 files changed, 14 insertions(+)

--- linux-next-20210910.orig/arch/riscv/Makefile
+++ linux-next-20210910/arch/riscv/Makefile
@@ -141,3 +141,13 @@ install zinstall:
 
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
+++ linux-next-20210910/arch/riscv/configs/32-bit.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV32I=y
+CONFIG_32BIT=y
--- /dev/null
+++ linux-next-20210910/arch/riscv/configs/64-bit.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV64I=y
+CONFIG_64BIT=y
