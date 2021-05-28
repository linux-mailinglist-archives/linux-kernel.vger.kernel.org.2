Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB749393C17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhE1DxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:53:04 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:51084 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhE1DxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:53:02 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 14S3nfb7025846;
        Fri, 28 May 2021 12:49:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 14S3nfb7025846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622173782;
        bh=nOwm0twLETAPHRynLa6fcg+8wECFXm1xLxM6UXBaq0c=;
        h=From:To:Cc:Subject:Date:From;
        b=eC3OPtc0ytnCD/7/zZXQSeVf/To0a0yY/+wUdhPSvru5cqh75ucrtQgtiOSLwD+r8
         NCwBp+u7vzMetvgXKOgLFJK9NqYwgFqDPuc2Ig+BKgmlRrM/jITbcArosX/WLEoCEZ
         f9ftJQDNTlc+BZI+UTSW3jBgHdqNniWaB0oQKAvZ253ErzJJpPbLHXB1/cik/E4EWg
         5ykkwYnUsMnmj98plCxh2/NOPTXMW/nncZA86GcyD7YHs65TJe77a1/Eqao+JphKTb
         ic37sVg0yIN5tm9EPQ5u+ju91u5AbI2UhBoxHGA6Hz4GTCMuxw3sBofn+BQw3y6c0L
         80hKnOFePJVOw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: simplify the build rule of mach-types.h
Date:   Fri, 28 May 2021 12:49:13 +0900
Message-Id: <20210528034913.2157657-1-masahiroy@kernel.org>
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

