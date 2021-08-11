Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6E3E9623
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhHKQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:38:47 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:24474 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhHKQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:38:44 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 17BGbXJ2027140;
        Thu, 12 Aug 2021 01:37:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 17BGbXJ2027140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628699855;
        bh=gGasa+zCJtwMQ/MN8gPIKkIM9bvv+AeK9qmF6dzqjlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYNyul/jXyoDwojGW+SctVA7+3v4Uk1BIhY67c+ErhMQSX+ZiGBRpMCvd1xkiRiJN
         4NoviOGFm8KmblDkGppZhgHosX47HzIQ0ATpa+nhyYXHT32QVmeV2GGFYyGeLMcwkI
         2M9PuLp1NYaFsSQHpwrDRRMH+0ZPYSP4eKiUJ3rJMpRq+kzVARysJlNDyv5SleW7NP
         F55+A/2+61Jd9mk6EIfuXBHnD0g7aUrR2/b0dwk2qLAs5L3Y8zRoMD7G78UzSHkyPO
         fftVM6D5FktezCT3GhpgOWYxey+WtefFzMntDNYG6mr59LT+1DBis+o4ClcnJZ8wyK
         jx0PUz+6bGcmQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] xtensa: build platform directories unconditionally
Date:   Thu, 12 Aug 2021 01:37:30 +0900
Message-Id: <20210811163731.186125-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811163731.186125-1-masahiroy@kernel.org>
References: <20210811163731.186125-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of arch/xtensa/platforms/*/ have Makefile. You do not need to
check the presence of Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/Makefile | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 3c0573fe6761..093e87b889be 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -32,8 +32,6 @@ platform-$(CONFIG_XTENSA_PLATFORM_XT2000)	:= xt2000
 platform-$(CONFIG_XTENSA_PLATFORM_ISS)		:= iss
 platform-$(CONFIG_XTENSA_PLATFORM_XTFPGA)	:= xtfpga
 
-PLATFORM = $(platform-y)
-
 # temporarily until string.h is fixed
 KBUILD_CFLAGS += -ffreestanding -D__linux__
 KBUILD_CFLAGS += -pipe -mlongcalls -mtext-section-literals
@@ -55,16 +53,13 @@ KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))
 
 KBUILD_DEFCONFIG := iss_defconfig
 
-# Only build platform if it includes a Makefile
-buildplf := $(shell test -e $(srctree)/arch/xtensa/platforms/$(PLATFORM)/Makefile && echo arch/xtensa/platforms/$(PLATFORM)/)
-
 # Find libgcc.a
 
 LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 head-y		:= arch/xtensa/kernel/head.o
 core-y		+= arch/xtensa/kernel/ arch/xtensa/mm/
-core-y		+= $(buildplf)
+core-y		+= arch/xtensa/platforms/$(platform-y)/
 core-y 		+= arch/xtensa/boot/dts/
 
 libs-y		+= arch/xtensa/lib/ $(LIBGCC)
-- 
2.30.2

