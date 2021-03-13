Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2B339E09
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhCMMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:25:43 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:21027 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:24:58 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 12DCNhQw030190;
        Sat, 13 Mar 2021 21:23:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 12DCNhQw030190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615638225;
        bh=9qrTaAv2B4VMn64mVvVgTSppSGJt8J/HF9r0PzcF7aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oc2wi0N88ICf7XOtSNURODJ6Uv8+9N5qZeGf4itNbkaF8FXGM1vqvdSRxSkoMyIIM
         YBJhKzJbX4JhY0+FfIod0EoUKJv1Q3vnTychnkF9ZcT28xzySguGu+8ZFZJgBhH1IA
         yIqqmm1IyA9snchObecsjN3h9myhNyhR+MOgx1cP2cJku+ig71uJ+E0jrp3gL91JSA
         sZzhef3j2w8VTA8XoMDgvVwAJS11+wkuOh7Frf9Vyx88TpZc+wfNnBPC8FDyeOiz5h
         i7yATScETs4fdax+oWqJdz2D+uiJG1AMe9xL92WrznUXT4ITKkhKDZv6wbvapulJ9O
         sCCGdOwsPNB4A==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] xtensa: remove unneeded export in boot-elf/Makefile
Date:   Sat, 13 Mar 2021 21:23:42 +0900
Message-Id: <20210313122342.69995-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210313122342.69995-1-masahiroy@kernel.org>
References: <20210313122342.69995-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one uses these as environment variables.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 arch/xtensa/boot/boot-elf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
index 47b9063f2c5d..faec2002923b 100644
--- a/arch/xtensa/boot/boot-elf/Makefile
+++ b/arch/xtensa/boot/boot-elf/Makefile
@@ -6,9 +6,8 @@
 
 OBJCOPY_ARGS := -O $(if $(CONFIG_CPU_BIG_ENDIAN),elf32-xtensa-be,elf32-xtensa-le)
 
-export OBJCOPY_ARGS
-export CPPFLAGS_boot.lds += -P -C
-export KBUILD_AFLAGS += -mtext-section-literals
+CPPFLAGS_boot.lds += -P -C
+KBUILD_AFLAGS += -mtext-section-literals
 
 boot-y		:= bootstrap.o
 targets		+= $(boot-y) boot.lds
-- 
2.27.0

