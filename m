Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C08393C35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 06:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhE1EIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 00:08:55 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:26274 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE1EIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 00:08:53 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 14S45hRN005132;
        Fri, 28 May 2021 13:05:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 14S45hRN005132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622174744;
        bh=v31y/lDLpAtuD0UANsxsxaUWRfMQ+aSQCWe2tci8zWc=;
        h=From:To:Cc:Subject:Date:From;
        b=bJNYOZrR5Wy5mXeXelnWzzI7JbjtEp+f8qvfmMkh2JDKn3u0IlCxMRq4AwSe6q/s0
         xQICL2inyqPgnI5OmZ7H3nDUgJ5LvgIm28wBZastgPEDSaJe92q+yRct//6H8B23WH
         WwJapuhcWrcadLHGcMoNahRmpUeusWf0jxz48UnlXuHNckEvuGLx2hVS8vQlRmKA5T
         hJsivzsLIGPZteSSRBa0Mf9MXoLeJpgJVu8+zeuEzGI8O0JTkPA1cyI6RsNXYbL8mf
         4l7LGtlbX5hHLpkBuIYP+iyB0zrqJPAlIVGBwzOBfK5TiVXaPegmwj057fizb6uRvh
         3g2wlBHu1ja4w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: syscalls: use pattern rules to generate syscall headers
Date:   Fri, 28 May 2021 13:05:42 +0900
Message-Id: <20210528040542.2161208-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pattern rules to unify similar build rules between OABI and EABI.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.13-rc1

 arch/arm/tools/Makefile | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 3f254456a830..4a5c50f67ced 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -39,30 +39,20 @@ $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) \
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis common,$* \
 		   --offset __NR_SYSCALL_BASE $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
 
 quiet_cmd_sysnr  = SYSNR   $@
       cmd_sysnr  = $(CONFIG_SHELL) $(sysnr) $< $@
 
-$(uapi)/unistd-oabi.h: abis := common,oabi
-$(uapi)/unistd-oabi.h: $(syscall) $(syshdr) FORCE
-	$(call if_changed,syshdr)
-
-$(uapi)/unistd-eabi.h: abis := common,eabi
-$(uapi)/unistd-eabi.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd-%.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 $(kapi)/unistd-nr.h: $(syscall) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-$(gen)/calls-oabi.S: abis := common,oabi
-$(gen)/calls-oabi.S: $(syscall) $(systbl) FORCE
-	$(call if_changed,systbl)
-
-$(gen)/calls-eabi.S: abis := common,eabi
-$(gen)/calls-eabi.S: $(syscall) $(systbl) FORCE
+$(gen)/calls-%.S: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
-- 
2.27.0

