Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D833DA643
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhG2OYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:24:09 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:32654 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbhG2OYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:24:08 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 16TENgXm028070;
        Thu, 29 Jul 2021 23:23:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 16TENgXm028070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627568622;
        bh=ypjCNDDnVVPZXFfURLYoJuUHqtvv6teMatNQiXvJXeA=;
        h=From:To:Cc:Subject:Date:From;
        b=QDmU14dmlNCGy3L4PAZmA61Z+932kLekAwoRdUvfWeLj/k+Rz9y7C9RrkgObjKjOX
         3PvYVJbya3NgAlFiSGhuzqpsDiI7lSWgk2QSZLfvmSDfes8REAP8yveR2IGbdaokav
         x4S7r575Q4ykqc0Ga0uPG3tmiRijHfuGiBfw/IiK8LP17CQ0ZK1hxAIOTgOZMsG6gh
         KSmOGmyk8MTBDnZY6G2q9PPZXkRvOHvpGz/kDAkS74jqq5AWThddOJnU6rHDFuHKYL
         8nG+C8xsX9tofOkIVUh3pW9hhNIX4+LaNeDIwjBs6MmQru29N96n53QyVRXE0YD288
         navFHgBjTt8EQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: move the install rule to arch/s390/Makefile
Date:   Thu, 29 Jul 2021 23:23:38 +0900
Message-Id: <20210729142338.446002-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the install target in arch/s390/Makefile descends into
arch/s390/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/s390/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/Makefile      | 3 ++-
 arch/s390/boot/Makefile | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 1e3172877982..17dc4f1ac4fa 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -142,7 +142,8 @@ all: bzImage
 KBUILD_IMAGE	:= $(boot)/bzImage
 
 install:
-	$(Q)$(MAKE) $(build)=$(boot) $@
+	sh -x $(srctree)/$(boot)/install.sh $(KERNELRELEASE) $(KBUILD_IMAGE) \
+	      System.map "$(INSTALL_PATH)"
 
 bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 41a64b8dce25..6e4b56470b85 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -69,7 +69,3 @@ $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
 
 $(obj)/startup.a: $(OBJECTS) FORCE
 	$(call if_changed,ar)
-
-install:
-	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
-	      System.map "$(INSTALL_PATH)"
-- 
2.27.0

