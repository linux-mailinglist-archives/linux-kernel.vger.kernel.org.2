Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249E8393C37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 06:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhE1EJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 00:09:10 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:63744 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhE1EJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 00:09:07 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 14S46iQb003056;
        Fri, 28 May 2021 13:06:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 14S46iQb003056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622174804;
        bh=V/oUgF2ENKBddx4LXQrdoBl1Leu3AL/edONfdvZdcYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gw88V32l5uUsm2CN2pqeIU54p4T6IMKQrenVpN0mC0F8aF0rNyhe+GmiPsxhCIX1i
         WhWTKEP9jftey4Ko4GrjGzCx+tkYpW2Or8X3OrEJx/tlEySLDmq68FzIIz/Ao00xko
         sCR05QTlPhYSLH5qMjKXAFgn0Jgy5ueuKloZkopHy2uLYhoOgUSutG9M9IrpL7Vxdb
         +HiZCH2sHbZXtvktxz96JD+esVNALlJvGtXu+37Cl1UNN0dz2kFiUevdKnIEQ+vvNy
         skwfI1L4RLgYSRQPNQnlvXd4jHvUHsBBscv3zYaMLPsgs5UyATqToqr1FN0kTShntl
         umnt+FQKiYMCQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] parisc: syscalls: use pattern rules to generate syscall headers
Date:   Fri, 28 May 2021 13:06:37 +0900
Message-Id: <20210528040638.2162050-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pattern rules to unify similar build rules between 32-bit and 64-bit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/kernel/syscalls/Makefile | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index 0f2ea5bcb0d7..d63f18dd058d 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
@@ -10,25 +10,15 @@ syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis $(abis) $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis common,$* $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
 
-$(uapi)/unistd_32.h: abis := common,32
-$(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd_%.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(uapi)/unistd_64.h: abis := common,64
-$(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
-	$(call if_changed,syshdr)
-
-$(kapi)/syscall_table_32.h: abis := common,32
-$(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,systbl)
-
-$(kapi)/syscall_table_64.h: abis := common,64
-$(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h unistd_64.h
-- 
2.27.0

