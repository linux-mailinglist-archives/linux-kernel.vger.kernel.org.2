Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D363DA635
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhG2OWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:22:37 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:49934 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhG2OWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:22:32 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 16TEJpXJ024963;
        Thu, 29 Jul 2021 23:19:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 16TEJpXJ024963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627568392;
        bh=k0k1BpTJNthZ0PJ04lpkmlmV8tJCB6nj/7sP9kIAxfY=;
        h=From:To:Cc:Subject:Date:From;
        b=PfW4Cb3Vg5fCqLQicGRT5nE8436T44DKu88jWgt8iaBkCBdm1qf0QUuKCoGarp7Da
         +2vpT9WAgGsmgcwGv2BFpwIkyj8AMoHvlQZ7XakKmcPcxUKVY+d6F0hgJUiL0QV39+
         RbMzNx2f9CopVb+VYgDzE2uiPjkLZ4RPtbnPu5MVbIr/WnBWzd/X/UdKqDOCb03H+W
         ry9xjVTO8OXMkETYEfcyS/act1xtWs4S+sf3Lwwvb4Bh54mLcO70VMRL94HragobdQ
         sTMGwcdOxtnj5v19ee8WLokUfvyeS1gPiD6uU93+O9O2sc7V66FDj6tv2VTE9+z58n
         S35OGPYnmj5AA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Jordan Niethe <jniethe5@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/3] powerpc: remove unused zInstall target from arch/powerpc/boot/Makefile
Date:   Thu, 29 Jul 2021 23:19:35 +0900
Message-Id: <20210729141937.445051-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c913e5f95e54 ("powerpc/boot: Don't install zImage.* from make
install") added the zInstall target to arch/powerpc/boot/Makefile,
but you cannot use it since the corresponding hook is missing in
arch/powerpc/Makefile.

It has never worked since its addition. Nobody has complained about
it for 7 years, which means this code was unneeded.

With this removal, the install.sh will be passed in with 4 parameters.
Simplify the shell script.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/boot/Makefile   |  6 +-----
 arch/powerpc/boot/install.sh | 13 -------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e312ea802aa6..a702f9d1ec0d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -448,11 +448,7 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
 
-# Install the vmlinux and other built boot targets.
-zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
-
-PHONY += install zInstall
+PHONY += install
 
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
index b6a256bc96ee..658c93ca7437 100644
--- a/arch/powerpc/boot/install.sh
+++ b/arch/powerpc/boot/install.sh
@@ -15,7 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
-#   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
 #
 
 # Bail with error code if anything goes wrong
@@ -41,15 +40,3 @@ fi
 
 cat $2 > $4/$image_name
 cp $3 $4/System.map
-
-# Copy all the bootable image files
-path=$4
-shift 4
-while [ $# -ne 0 ]; do
-	image_name=`basename $1`
-	if [ -f $path/$image_name ]; then
-		mv $path/$image_name $path/$image_name.old
-	fi
-	cat $1 > $path/$image_name
-	shift
-done;
-- 
2.27.0

