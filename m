Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD3415226
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhIVU5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238006AbhIVU5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB41261353;
        Wed, 22 Sep 2021 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632344138;
        bh=M7iLfrDWnvEHZ35K9OsYIwOfFvN+NiWTqgmxlmOCDLY=;
        h=From:To:Cc:Subject:Date:From;
        b=JoazlHT/9BFamaVgzKt87cguKza0c1DpbyMR5xYlqaSOs+SWdPDq//TJUOnqg8U3l
         uR0mXKOrrn61NkOm2qMfwpGQ1698WlmeM2Zt9xzl5wyNFa47OQUgVQTWFtzTdV8zt5
         FE6fWGRRGNDpRCKUVRDPe1vRuA0KidDMfp5NEgUmgOxhA73vDtDl9bFo+t8wy2Rrzo
         YM+d2jFBt+yV1n8e9eaMjGXMBC+1xwjyiiptVXGYRO/6bV6B59C/mkT4djBKMj3Oib
         HeB7SLC/yIXx2jFkp6bJ6NyLznb6lFl2WTHVOQe57lZEpCohrROhS5Ow0ZM8mqNY0w
         cX7dZPPDpeq5Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
Date:   Wed, 22 Sep 2021 13:55:25 -0700
Message-Id: <20210922205525.570068-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.514.g99c99ed825
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the asan-stack parameter is only passed along if
CFLAGS_KASAN_SHADOW is not empty, which requires KASAN_SHADOW_OFFSET to
be defined in Kconfig so that the value can be checked. In RISC-V's
case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which means that
asan-stack does not get disabled with clang even when CONFIG_KASAN_STACK
is disabled, resulting in large stack warnings with allmodconfig:

drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:117:12:
error: stack frame size (14400) exceeds limit (2048) in function
'lb035q02_connect' [-Werror,-Wframe-larger-than]
static int lb035q02_connect(struct omap_dss_device *dssdev)
           ^
1 error generated.

Ensure that the value of CONFIG_KASAN_STACK is always passed along to
the compiler so that these warnings do not happen when
CONFIG_KASAN_STACK is disabled.

Link: https://github.com/ClangBuiltLinux/linux/issues/1453
References: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Makefile.kasan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 801c415bac59..b9e94c5e7097 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -33,10 +33,11 @@ else
 	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
 	 $(call cc-param,asan-globals=1) \
 	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
-	 $(call cc-param,asan-stack=$(stack_enable)) \
 	 $(call cc-param,asan-instrument-allocas=1)
 endif
 
+CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
+
 endif # CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_SW_TAGS

base-commit: 4057525736b159bd456732d11270af2cc49ec21f
-- 
2.33.0.514.g99c99ed825

