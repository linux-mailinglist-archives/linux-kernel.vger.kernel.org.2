Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70D63DA618
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhG2OMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:12:16 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:63176 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbhG2OCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:24 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 16TE0RBq024554;
        Thu, 29 Jul 2021 23:00:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 16TE0RBq024554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627567229;
        bh=sqZM91siVcPP9ChqztPPE72d4zrmws7fdj3MQF/Yl8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjhRPXlPHLA9cLE2aGhkLKasvpHh6hQ7voS/OPY5FOgmTGCg7P2i/DLw6prqSy/H0
         bq1qYugDWRwQFq5Zk2Q90eobqOsHlFy/A8JL/Udt/d118/PB/OY3OFirsO8o2UmzbR
         yTOI0pcIPdZ8qh85dmg9rd0AczGGGhSAuJznwRbHsI8loxB1s/W7vMj/pmwQRl6gUg
         PTQSf0w9Db+hql/RMwlJhdHl0To0cJGb18DBdUWaF1DetVe3MlknB+0zqg+ItQddJl
         HjvZ7+2eIkDGaepbpcNr/bg7A065FqyL6iWqNIa3AfpCxTbU2JsWP3n4wHbu94H0eA
         eyjyxhZYDM1HA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/build: move the install rule to arch/x86/Makefile
Date:   Thu, 29 Jul 2021 23:00:23 +0900
Message-Id: <20210729140023.442101-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729140023.442101-1-masahiroy@kernel.org>
References: <20210729140023.442101-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the install target in arch/x86/Makefile descends into
arch/x86/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/x86/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Makefile      | 3 ++-
 arch/x86/boot/Makefile | 7 +------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4f784d9ac925..2c36cdc2593a 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -277,7 +277,8 @@ $(BOOT_TARGETS): vmlinux
 
 PHONY += install
 install:
-	$(Q)$(MAKE) $(build)=$(boot) $@
+	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
+		$(KBUILD_IMAGE) System.map "$(INSTALL_PATH)"
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index dfbc26a8e924..b5aecb524a8a 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -133,7 +133,7 @@ quiet_cmd_genimage = GENIMAGE $3
 cmd_genimage = $(BASH) $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
 		$(obj)/mtools.conf '$(FDARGS)' $(FDINITRD)
 
-PHONY += bzdisk fdimage fdimage144 fdimage288 hdimage isoimage install
+PHONY += bzdisk fdimage fdimage144 fdimage288 hdimage isoimage
 
 # This requires write access to /dev/fd0
 # All images require syslinux to be installed; hdimage also requires
@@ -156,8 +156,3 @@ hdimage: $(imgdeps)
 isoimage: $(imgdeps)
 	$(call cmd,genimage,isoimage,$(obj)/image.iso)
 	@$(kecho) 'Kernel: $(obj)/image.iso is ready'
-
-install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh \
-		$(KERNELRELEASE) $(obj)/bzImage \
-		System.map "$(INSTALL_PATH)"
-- 
2.27.0

