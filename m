Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69743DA604
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhG2OLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:11:22 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:29318 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbhG2OGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:06:53 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 16TE5VPR011777;
        Thu, 29 Jul 2021 23:05:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 16TE5VPR011777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627567532;
        bh=crqolrXBSp1NHqhBNbE370Q12hlODI+0Gc1e3Qr9tdo=;
        h=From:To:Cc:Subject:Date:From;
        b=z8HLtte7N11tkzm6+LfJ5ZzJ7ujVPYRmlCWuW4KcbIWT7Dpuh90g1FnhSTw9UDV04
         /Ukij3Qu0X9Sg/uG5ShTgwuzcRVmOdCQO8HZKmPN6HaqgR8HNAak6RZj04MdKc/yBN
         JOTI7g+ICIRvjwzuddxcyayCgZbbCV1QlLB3BcGA+G19EyfHfjD5uKTkeweCTDTgiA
         xgs6ZHwjAEl96GSYsCSDq1p1MQyZjlu77wdpGHsl7fIT+aJoS6MPKRT6H4UpEnD7Oo
         qMIoF19mEb0v8CopuBDedfkb18b8qVN4LyuTXV9B726E6tlrR0fy4Xb//d8QQjJK0K
         Id33UL0onWmpw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: move the (z)install rules to arch/arm64/Makefile
Date:   Thu, 29 Jul 2021 23:05:27 +0900
Message-Id: <20210729140527.443116-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the (z)install targets in arch/arm64/Makefile descend into
arch/arm64/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/arm64/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/Makefile      | 7 +++++--
 arch/arm64/boot/Makefile | 8 --------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7bc37d0a1b68..ded13230f901 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -165,8 +165,11 @@ Image: vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-zinstall install:
-	$(Q)$(MAKE) $(build)=$(boot) $@
+install: install-image := Image
+zinstall: install-image := Image.gz
+install zinstall:
+	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
+	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index cd3414898d10..ebe80faab883 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -35,11 +35,3 @@ $(obj)/Image.lzma: $(obj)/Image FORCE
 
 $(obj)/Image.lzo: $(obj)/Image FORCE
 	$(call if_changed,lzo)
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

