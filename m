Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0E3DA633
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhG2OWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:22:34 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:49926 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhG2OWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:22:32 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 16TEJpXL024963;
        Thu, 29 Jul 2021 23:19:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 16TEJpXL024963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627568394;
        bh=tVlc+Zehc0ZuNG0/0e46gBchE5kb8xTkthFuDGJLr5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEba40yzIedI5gzfvTXsJCQJkSOLZ4EuYCn889j29SxvQIqFETZHdwHDF/H0FHTUD
         +us19Q/eOhGVzYjS3GqAsHU6Bvb/BvowgdzazNvQWABBr21XWsGrxyu/wevBYn1mlf
         fIt9PFZSY++HcJIpcgDuWgXqOzEXrl/NDXvFe+W9epOHoRMYT6hDLEg9x6GYlabWcd
         wXYCpnjM7aSGbNX77ls6is3Uty2OSM8gQuI4WrGrXTR2CrLdtRQlDMC/UapNkH58fE
         thrbidXHmSx3cEnjZIYLBOk1c/m5lxqrXoHd8wLQ6BP29InxMb4stSXKaQ7zpe+1tz
         2CiWzGEDX9/og==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 3/3] powerpc: move the install rule to arch/powerpc/Makefile
Date:   Thu, 29 Jul 2021 23:19:37 +0900
Message-Id: <20210729141937.445051-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729141937.445051-1-masahiroy@kernel.org>
References: <20210729141937.445051-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the install target in arch/powerpc/Makefile descends into
arch/powerpc/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/powerpc/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/Makefile      | 3 ++-
 arch/powerpc/boot/Makefile | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6505d66f1193..9aaf1abbc641 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -407,7 +407,8 @@ endef
 
 PHONY += install
 install:
-	$(Q)$(MAKE) $(build)=$(boot) install
+	sh -x $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" vmlinux \
+	System.map "$(INSTALL_PATH)"
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0d165bd98b61..10c0fb306f15 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -444,12 +444,6 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	$(Q)rm -f $@; ln $< $@
 
-# Only install the vmlinux
-install:
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
-
-PHONY += install
-
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
-- 
2.27.0

