Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB2E3E9622
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhHKQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:38:46 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:24443 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhHKQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:38:44 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 17BGbXJ1027140;
        Thu, 12 Aug 2021 01:37:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 17BGbXJ1027140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628699854;
        bh=cL21VypGpS+uiM+qAaCaWq4XrgxStOxB/CW1z83affg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnkfZYO+bGTtLD25MgGMSqCvz1gFyM+If48sDWHraZ/5SVVukIfqvtz6cJDI6y/a0
         v44Fs/jKsAwlHUYuaShvMbEQyR0SIlDymqqNcrX6Z8ECkfZKBxpLhXlq1PqkE6YVPD
         c+zzLqAjsuU48VPzbKG/gm/WAd8EMGkX1WE/qz4okLyWZ2ZtWWnqKgTBOoU0iuAx3b
         PoOpvHu7oPwMPCmA8cfR+t07AUiuLT4OYKQDs2n3kuBFUSs+y5wM6Vze7invy6Ax6H
         EdRl4yGi/kzMQyfoljQP9ruKGAMmnb0Oi2nguTPfsqndTkczMtD6PJoyv6tHT2riId
         Y8L4FV7b2S+gg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] xtensa: do not build variants directory
Date:   Thu, 12 Aug 2021 01:37:29 +0900
Message-Id: <20210811163731.186125-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811163731.186125-1-masahiroy@kernel.org>
References: <20210811163731.186125-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of arch/xtensa/variants/*/ has Makefile, so 'buildvar' is always
empty.

Perhaps, downstream variant code might be dropped in, but given the
fact that none of upstream variants builds anything in their variant
directory, I doubt this is needed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 6fab7fc87579..3c0573fe6761 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -55,9 +55,7 @@ KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))
 
 KBUILD_DEFCONFIG := iss_defconfig
 
-# Only build variant and/or platform if it includes a Makefile
-
-buildvar := $(shell test -e $(srctree)/arch/xtensa/variants/$(VARIANT)/Makefile && echo arch/xtensa/variants/$(VARIANT)/)
+# Only build platform if it includes a Makefile
 buildplf := $(shell test -e $(srctree)/arch/xtensa/platforms/$(PLATFORM)/Makefile && echo arch/xtensa/platforms/$(PLATFORM)/)
 
 # Find libgcc.a
@@ -66,7 +64,7 @@ LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 head-y		:= arch/xtensa/kernel/head.o
 core-y		+= arch/xtensa/kernel/ arch/xtensa/mm/
-core-y		+= $(buildvar) $(buildplf)
+core-y		+= $(buildplf)
 core-y 		+= arch/xtensa/boot/dts/
 
 libs-y		+= arch/xtensa/lib/ $(LIBGCC)
-- 
2.30.2

