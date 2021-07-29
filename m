Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2A3DA639
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhG2OXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:23:15 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:40393 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhG2OXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:23:15 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 16TELnM4012048;
        Thu, 29 Jul 2021 23:21:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 16TELnM4012048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627568510;
        bh=gIER6M/yetFIr/zY03y/J3RNp299mi6jgg2VO7pHBG8=;
        h=From:To:Cc:Subject:Date:From;
        b=OIPGhlSxzmEIQ/XRyK6pMZbkWX9BN+XwZhARCinWDPyLS90GApKnXNjHdoq6BF/zj
         I+f6oSr0ddA3qlUD/ACerbzjWRKhW0cCWpfJ4NP98cj47TUqEUx0dxxWeY9XAOGtl8
         6KMI7wxFlY0mFJDZw0nyYHsKaLdsmrrKVOJTdTwoM1AVDOtlKx+gOerVrJ6a0XQ5Y9
         PSyntHQnVqeQIFpgClnwVAFg/JcYK2oggCSuxSjg+XSmGtiIm1ATmbkPx5VbyAzIvq
         hVbzJ0mTwVUto4KmfIjxtq/55918dttdzwc6bdeV2kL9G2HOuGSxSMqPp6i9EsIWli
         cWulz2pQqrUsA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: move the (z)install rules to arch/riscv/Makefile
Date:   Thu, 29 Jul 2021 23:21:47 +0900
Message-Id: <20210729142147.445593-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the (z)install targets in arch/riscv/Makefile descend into
arch/riscv/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/riscv/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Makefile      | 7 +++++--
 arch/riscv/boot/Makefile | 8 --------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index bc74afdbf31e..3c437fb09a07 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -126,8 +126,11 @@ $(BOOT_TARGETS): vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-zinstall install:
-	$(Q)$(MAKE) $(build)=$(boot) $@
+install: install-image = Image
+zinstall: install-image = Image.gz
+install zinstall:
+	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
+	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 6bf299f70c27..becd0621071c 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -58,11 +58,3 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
-
-install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
-	$(obj)/Image System.map "$(INSTALL_PATH)"
-
-zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
-	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
-- 
2.27.0

