Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33D3E964E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhHKQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:45:38 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:34199 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhHKQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:45:34 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 17BGiU2m005946;
        Thu, 12 Aug 2021 01:44:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 17BGiU2m005946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628700271;
        bh=9slvC/sReWYIdBY0mz+Zmg+FwVWGz4yM8/US4HhVIhU=;
        h=From:To:Cc:Subject:Date:From;
        b=kwWlj/13voM0LPeMTS6CuNom2U8JEXY4yJLJjGd3bEba5Ckz08Jeb92XXwwl1CiZb
         D0yvkk3ZF3qFn7AaTX2hYWviBRG0ydW3wM4u2h747ReVlvtNpEBcZdGIRR5d8YBLQF
         MmOsYI2UqAn7dBjP/ocyhNXCw10mmPqvADt8iZzh5YovlXo5hcvar2r5TAIHVSdBbB
         AJ4e7q19rpqF2OK+WxWe1W4AHK8yrRr8vD+UcHO6wUgBF0Ji9Cn2k98gpVOWOvCfdY
         dQalT1L9tkXc9I2cN116onFnEmukQulIxitVH+6VO2UmYqIp5gsSnUEb1ajQK4aqfl
         53k4u8CqMdveA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: move core-y in arch/nds32/Makefile to arch/nds32/Kbuild
Date:   Thu, 12 Aug 2021 01:44:27 +0900
Message-Id: <20210811164427.187368-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nds32/Kbuild   | 3 +++
 arch/nds32/Makefile | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kbuild b/arch/nds32/Kbuild
index a4e40e534e6a..565b9bc3c9db 100644
--- a/arch/nds32/Kbuild
+++ b/arch/nds32/Kbuild
@@ -1 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y			+= kernel/ mm/
+obj-$(CONFIG_FPU)	+= math-emu/
+obj-y			+= boot/dts/
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index ccdca7142020..853a5df32f68 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -25,8 +25,6 @@ export	TEXTADDR
 
 
 # If we have a machine-specific directory, then include it in the build.
-core-y				+= arch/nds32/kernel/ arch/nds32/mm/
-core-$(CONFIG_FPU)              += arch/nds32/math-emu/
 libs-y				+= arch/nds32/lib/
 
 ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
@@ -48,7 +46,6 @@ CHECKFLAGS      += -D__NDS32_EB__
 endif
 
 boot := arch/nds32/boot
-core-y += $(boot)/dts/
 
 Image: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-- 
2.30.2

