Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2633DA5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhG2OK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:10:58 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:20651 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhG2OHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:07:49 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 16TE77x7030502;
        Thu, 29 Jul 2021 23:07:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 16TE77x7030502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627567628;
        bh=OkmM0pXDX7v2EhLXhxLu/LZ8oreIh62vNVpYZPlZlb0=;
        h=From:To:Cc:Subject:Date:From;
        b=LvG/zWy7K+8KpgQvwZOKvSf+IAn/+5SgGChyU10gxmnDnwK0GTtwJwTtHCDcycMAy
         VGiH3WqIAV3N1PIswFixnBph97hXUjUj7juVB6E9iYe3E6sjbjiFwAf3VkamJFhtJ1
         lFRn/hSbuI+7Cv4RGEA2EjFGB14wSRxtElajldZxqdgj+RiQYdPRWKHufBYqEqjMuY
         QEDzHc8UuW9gFZHojwBGBeC7IitTM/3PC9at9lJOFe4T6HyeMGRdRC/kphvSOzs4MS
         rJfFBMpS9pa6iCbaoS6FHB2LuEPGmXdnGl593HwZUJO7OxWq0OORxlBCZefyc/nL/F
         gKq2/9o3vjJIw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] nios2: move the install rule to arch/nios2/Makefile
Date:   Thu, 29 Jul 2021 23:07:06 +0900
Message-Id: <20210729140706.443527-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the install target in arch/nios2/Makefile descends into
arch/nios2/boot/Makefile to invoke the shell script, but it is no
good reason to do so.

arch/nios2/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nios2/Makefile      | 3 ++-
 arch/nios2/boot/Makefile | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index 52c03e60b114..72e8ff065cf7 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -60,7 +60,8 @@ $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
 
 install:
-	$(Q)$(MAKE) $(build)=$(nios2-boot) BOOTIMAGE=$(KBUILD_IMAGE) install
+	sh $(srctree)/$(nios2-boot)/install.sh $(KERNELRELEASE) \
+	$(KBUILD_IMAGE) System.map "$(INSTALL_PATH)"
 
 define archhelp
   echo  '* vmImage         - Kernel-only image for U-Boot ($(KBUILD_IMAGE))'
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 37dfc7e584bc..8c3ad76602f3 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -30,6 +30,3 @@ $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
 
 $(obj)/compressed/vmlinux: $(obj)/vmlinux.gz FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
-
-install:
-	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
-- 
2.27.0

