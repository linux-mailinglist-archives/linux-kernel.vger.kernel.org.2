Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25CD3E9625
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhHKQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:38:50 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:24492 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhHKQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:38:45 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 17BGbXJ3027140;
        Thu, 12 Aug 2021 01:37:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 17BGbXJ3027140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628699856;
        bh=et8Mka1E5ArHHTvBvnzBqyfNfwl3w1PM0NF96xE8gUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWk03G+7WtsJm8vNtT8WmvprVk1lLxy9biOk4Ytm6Ogfg6sK4+TOXHKAmoslEtHOS
         aJT6d+lhbCxjaCqiH9QJoEiE+gWX6vm/WgIkG5gwLyOa0FwEhUz+UN2WF3QxcZWok4
         NXoEG3DY84jTl6Q7e1dIE/jhmqjJKascZfds/w7+qnRjTg+EJccg0MBC5sLPoZdwh2
         36862yFATu0F0UHZZXV112RbbijcDV4+rThzzlKDBmThid7W4fWjzTWQ1kNB/77nzo
         pDgfkqat9p1imM05ICI3ykfPwhkox0XEMxt9+nKW08ip1Qj+TQdYd+NXHuKnsI3JyL
         FbcnGsEi5uDuw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] xtensa: move core-y in arch/xtensa/Makefile to arch/xtensa/Kbuild
Date:   Thu, 12 Aug 2021 01:37:31 +0900
Message-Id: <20210811163731.186125-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811163731.186125-1-masahiroy@kernel.org>
References: <20210811163731.186125-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/Kbuild             | 1 +
 arch/xtensa/Makefile           | 3 ---
 arch/xtensa/platforms/Makefile | 4 ++++
 3 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 arch/xtensa/platforms/Makefile

diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
index a4e40e534e6a..fd12f61745ba 100644
--- a/arch/xtensa/Kbuild
+++ b/arch/xtensa/Kbuild
@@ -1 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y += kernel/ mm/ platforms/ boot/dts/
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 093e87b889be..96714ef7c89e 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -58,9 +58,6 @@ KBUILD_DEFCONFIG := iss_defconfig
 LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 head-y		:= arch/xtensa/kernel/head.o
-core-y		+= arch/xtensa/kernel/ arch/xtensa/mm/
-core-y		+= arch/xtensa/platforms/$(platform-y)/
-core-y 		+= arch/xtensa/boot/dts/
 
 libs-y		+= arch/xtensa/lib/ $(LIBGCC)
 
diff --git a/arch/xtensa/platforms/Makefile b/arch/xtensa/platforms/Makefile
new file mode 100644
index 000000000000..e2e7e0726979
--- /dev/null
+++ b/arch/xtensa/platforms/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_XTENSA_PLATFORM_XT2000)	+= xt2000/
+obj-$(CONFIG_XTENSA_PLATFORM_ISS)	+= iss/
+obj-$(CONFIG_XTENSA_PLATFORM_XTFPGA)	+= xtfpga/
-- 
2.30.2

