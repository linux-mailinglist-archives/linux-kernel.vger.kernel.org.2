Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC963DA625
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbhG2OOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:14:53 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:20774 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbhG2OOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:14:49 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 16TEDnBu018370;
        Thu, 29 Jul 2021 23:13:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 16TEDnBu018370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627568029;
        bh=bbySyuuah6N6af0tiTiJxusQPyKJl35SSLwlzPEv9sQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RYtHqber/Tj7qdOZP8g+/eGio9fHshWYHPnE9GJ0ZcSg5PhGe44irMHcwMj6NXzMQ
         cozlbOLOxzxO2mRxJrbwlt4IJLPCvjDhhDMCp5jW+/yVbgV9zBjRp/mFkbiFcGP1p0
         JqzIdoxGAWV3oPzGSTlGtaSURcfTle93fK1dJO2lVDOtQdNYxqvF75a1L3adZqkQJ7
         2paIPR26rltrwgzbMuGwrlEhwBxYGUitfB+fq7HAM7VY4yco/mJet5nnY7mt1wbwmQ
         cydOGcr/o/Pbi3FA0Ww/6wNAgDgDP5bkbdVuWF17XcfC1hVLMi+FeWCgP88kohWaXj
         yJAxiAuKb0o5Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: remove unused install target from arch/parisc/boot/Makefile
Date:   Thu, 29 Jul 2021 23:13:47 +0900
Message-Id: <20210729141347.444364-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The install.sh script is invoked from arch/parisc/Makefile.

The install target in arch/parisc/boot/Makefile is never used.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/boot/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
index 61f44142cfe1..b873ee4720ca 100644
--- a/arch/parisc/boot/Makefile
+++ b/arch/parisc/boot/Makefile
@@ -15,7 +15,3 @@ $(obj)/bzImage: $(obj)/compressed/vmlinux FORCE
 
 $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
-
-install: $(CONFIGURE) $(obj)/bzImage
-	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
-	      System.map "$(INSTALL_PATH)"
-- 
2.27.0

