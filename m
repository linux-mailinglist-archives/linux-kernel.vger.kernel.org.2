Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1F393C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 06:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhE1EDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 00:03:41 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:41188 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhE1EDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 00:03:32 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 14S40IVA023787;
        Fri, 28 May 2021 13:00:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 14S40IVA023787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622174418;
        bh=kXCWf9JfpTorquIMy+GqkIRC1TM6xcAKHYrkf4dDilI=;
        h=From:To:Cc:Subject:Date:From;
        b=WFEdhJhkpJP4OOdFBlvkJxZ5BNjVlcTAwzLPDyR7yQE2Yotw0zWLBsELp26lch9Qf
         D7EsmBzyiILwUFta8lN37Gd9eUdcjkX42RkrOkg5Say98VyO11z+PTIuKhFxiT6ufE
         Rssj6Bb43m1w0S9Zh39SvjRZlCtqKfNaHtvuh9kJ20vsCK8SAbTh1XeI2fG2p7Sj6A
         xHfdWmDB9cxQb/Wany72XlxxQt8qSuJ+/23Y0PFrIgM2CCT1cy2AEZlNykF4ZhgFqV
         hqf3XXBojz0gyVo9LBfSkamSBqNdADZMAVJfrFgKXeX/dhO//149IOkmoqhvHI0W6m
         XUAONZWaJkUnw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: remove unneeded abi parameter to syscallnr.sh
Date:   Fri, 28 May 2021 13:00:14 +0900
Message-Id: <20210528040014.2160181-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to pass the abi parameter to syscallnr.sh because it
parses all the lines of syscall.tbl except comments anyway.

Simplify the code. Also, remove unneeded single-quoting.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.13-rc1

 arch/arm/tools/Makefile     | 4 +---
 arch/arm/tools/syscallnr.sh | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 057639019059..3f254456a830 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -46,8 +46,7 @@ quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_sysnr  = SYSNR   $@
-      cmd_sysnr  = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@' \
-		   '$(syshdr_abi_$(basetarget))'
+      cmd_sysnr  = $(CONFIG_SHELL) $(sysnr) $< $@
 
 $(uapi)/unistd-oabi.h: abis := common,oabi
 $(uapi)/unistd-oabi.h: $(syscall) $(syshdr) FORCE
@@ -57,7 +56,6 @@ $(uapi)/unistd-eabi.h: abis := common,eabi
 $(uapi)/unistd-eabi.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-sysnr_abi_unistd-nr := common,oabi,eabi,compat
 $(kapi)/unistd-nr.h: $(syscall) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
diff --git a/arch/arm/tools/syscallnr.sh b/arch/arm/tools/syscallnr.sh
index df3ccd0ca831..9e386770b6b3 100644
--- a/arch/arm/tools/syscallnr.sh
+++ b/arch/arm/tools/syscallnr.sh
@@ -2,14 +2,13 @@
 # SPDX-License-Identifier: GPL-2.0
 in="$1"
 out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
 align=1
 
 fileguard=_ASM_ARM_`basename "$out" | sed \
     -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
     -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
 
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | tail -n1 | (
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+" "$in" | sort -n | tail -n1 | (
     echo "#ifndef ${fileguard}
 #define ${fileguard} 1
 
-- 
2.27.0

