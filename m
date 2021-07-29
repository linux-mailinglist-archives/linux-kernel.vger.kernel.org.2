Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FBA3DA64E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhG2OZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:25:12 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:53150 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhG2OZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:25:11 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 16TEOfZU029590;
        Thu, 29 Jul 2021 23:24:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 16TEOfZU029590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627568681;
        bh=oe92qc6oXS/tMkEcshM/u14k3ZMZbnu1S1iFNTswLHA=;
        h=From:To:Cc:Subject:Date:From;
        b=N+jeyjbx7vlpISrVUhxSFNsWG1IH38BLhpZilkt0jeU3YRExaqQd3NuV4TS5Uhy7K
         sGO897Ivf7ZgLgC35/RSLdlqt3vsOJkp5vb17QTFqfrcyXhVWPZT6aKQyw1RP/7D/A
         jHmNII0Pxo0NlVwhH10mRvW4GlnYocVOXzKT3M5dV6QkBOFawNIr72vtRh7ZrfG6kM
         SZ776BYjMYDFQY2E+K32W8fAnzqWGnqRRKot19kzKAaWx0SeyfY6TdmAcRuuh9Zf+H
         +ESCwIauNHb9nOcZ2bLoYKUQNwOBvRnnNYbX0qNcOOXsFl8qRgf5Q3QuOut+Biw2Ra
         30Fmqx4F1U7hQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: move the install rule to arch/sparc/Makefile
Date:   Thu, 29 Jul 2021 23:24:40 +0900
Message-Id: <20210729142440.446322-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the install target in arch/sparc/Makefile descends into
arch/sparc/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/sparc/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/Makefile      | 3 ++-
 arch/sparc/boot/Makefile | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 4e65245bc755..24fb5a99f439 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -72,7 +72,8 @@ image zImage uImage tftpboot.img vmlinux.aout: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 install:
-	$(Q)$(MAKE) $(build)=$(boot) $@
+	sh $(srctree)/$(boot)/install.sh $(KERNELRELEASE) $(KBUILD_IMAGE) \
+		System.map "$(INSTALL_PATH)"
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 380e2b018992..849236d4eca4 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -70,7 +70,3 @@ $(obj)/image: vmlinux FORCE
 $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)
-
-install:
-	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(obj)/zImage \
-		System.map "$(INSTALL_PATH)"
-- 
2.27.0

