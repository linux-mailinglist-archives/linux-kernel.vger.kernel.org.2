Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC48393C19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhE1Dz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:55:28 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:42472 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhE1Dz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:55:27 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 14S3qBFA024800;
        Fri, 28 May 2021 12:52:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 14S3qBFA024800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622173932;
        bh=6KU0Trdq4K/2P2XIJXTR2lASBtxZgHuNXe5Ass8LYl0=;
        h=From:To:Cc:Subject:Date:From;
        b=JAJHkxp//xw4Wqbhb/9kqDKs2tLxQZ73tURX5+OKK3V53N63Bv03Ou3tEqihb1kTl
         WE4EpdMmWKXiOUvn5JP5w/xZEHXVcHAyZYKwMIvauG+jE9nHC6fzsuSRfAhc1oWngo
         zgQxvGIGngx5g2+buY/3JxtCp7FuLoIeksQNLG/B1zOb9S7+JE6JKtttIi4knbwwKA
         km1d/L0yR0sv+HZOrcFrbV0MTrj5vvZ64GucpuKqJWb6o4GwTPI+beUFDTma9SsngR
         QHbnFkXasYuqWqwgOGGYMvj0UaQqMAfcYWLMB6+z9k6sW/evR662edScTa0SpzbAPA
         J1bpONW2UPkfg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: simplify the build rule of mach-types.h
Date:   Fri, 28 May 2021 12:52:09 +0900
Message-Id: <20210528035209.2157823-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The directory of mach-types.h is created a couple of lines above:

  _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \

The 'mkdir -p' command is redundant.

scripts/Kbuild.include defines real-prereqs as a shorthand for
$(filter-out $(PHONY),$^). Let's use it to simplify the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.13-rc1

 arch/arm/tools/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 87de1f63f649..057639019059 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -33,8 +33,7 @@ _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
           $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')
 
 quiet_cmd_gen_mach = GEN     $@
-      cmd_gen_mach = mkdir -p $(dir $@) && \
-		     $(AWK) -f $(filter-out $(PHONY),$^) > $@
+      cmd_gen_mach = $(AWK) -f $(real-prereqs) > $@
 
 $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
-- 
2.27.0

