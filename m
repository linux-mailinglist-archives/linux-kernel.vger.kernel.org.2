Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85AE3BF230
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGGWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhGGWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:45:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7AC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:43:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t11-20020a056902124bb029055a821867baso21055500ybu.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oQNGvy//YsByQbA2jNjuQSDvdEyrDDI3RHX9PIliM8M=;
        b=Afcdzv2tyx8L2xlhLRBKLqSDEg82F0PL17xPoY7Bh8Bm9YxYAp7Ztde4Mptwb3zdrx
         ijG1XcdOIogp8odOH9P+snlnYUWLLQ+9giDSSi1tMWJkXyYT4mcEkIFyurJmabQWk+O/
         BqLGt0KWhuR2CO3PbuOXNAgGpu+vtJONkSpawv7KcquUalHbNMbGU4uNykaIcKbJO4j8
         v/txcOPTf6XP7VNG2sYN19+wrQU2ebrsPn8MsXZOxi+K4ZB3p2ICYbPmE+VGEVXslesb
         BGxjUEjMoTcO30JKpNt+iBu6ZGvi96vNtpDX2QvrrIysLZRc+WRWkdY5FWyYKbwCDXUJ
         za7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oQNGvy//YsByQbA2jNjuQSDvdEyrDDI3RHX9PIliM8M=;
        b=YHasqgbSf/ePJT4FdajpK2c8QkGVv8KwgtfTmj7aOR2mz6EfXilLUa+CeclrmS3adj
         W8HCUHKBnP4UexjxPY+QW/Wn8UR1HQaIMsAmV/HqRm/ke2j/vxsUrr87+KS3gc9GsGIH
         nYjloA0kHNpybhpTpKfgAwotkh8cap3G0zpaw9HiOKnfkD1OQh7lTkZ/GZSGgqmTVVWJ
         j2a7TBoR3n2zlHmehyEnLcyerzTpp7F484PVLnOJxd88mAIFj2dKGoJT6NkEF1QycyNn
         WiZdDb1ZAjVZOgRmJLKD9eE+esIB7KyIIlC7BVtU13fBEvcjITRWDsL/E4CMqFOMLXp6
         HoyQ==
X-Gm-Message-State: AOAM532xpjkO+mTsQfhwBdWPe5C/mOidV5f90NrhzJ37QarWZbZ0vUPT
        dcSIZG96Hf5lVLtAbrm+FK8fvjVQRaRKuwkDjSI=
X-Google-Smtp-Source: ABdhPJxtgNcTGrkpVWraln9pSlgwMQdfn7B62i4Nu04ljHLEv2kCroW3BSmWTF1AVvyWeeE2N2TN2PKPO4ogI0/XX3U=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:d417:6e24:4a54:1792])
 (user=ndesaulniers job=sendgmr) by 2002:a25:8082:: with SMTP id
 n2mr34615840ybk.79.1625697796357; Wed, 07 Jul 2021 15:43:16 -0700 (PDT)
Date:   Wed,  7 Jul 2021 15:43:09 -0700
In-Reply-To: <20210707224310.1403944-1-ndesaulniers@google.com>
Message-Id: <20210707224310.1403944-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210707224310.1403944-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 1/2] Makefile: move initial clang flag handling into scripts/Makefile.clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some of the changes we'd like to make to CROSS_COMPILE, the initial
block of clang flag handling which controls things like the target triple,
whether or not to use the integrated assembler and how to find GAS,
and erroring on unknown warnings is becoming unwieldy. Move it into its
own file under scripts/.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes RFC -> v1:
* Rename new file as per Nathan.

 MAINTAINERS            |  1 +
 Makefile               | 15 +--------------
 scripts/Makefile.clang | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 14 deletions(-)
 create mode 100644 scripts/Makefile.clang

diff --git a/MAINTAINERS b/MAINTAINERS
index 81e1edeceae4..9c1205c258c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4433,6 +4433,7 @@ B:	https://github.com/ClangBuiltLinux/linux/issues
 C:	irc://chat.freenode.net/clangbuiltlinux
 F:	Documentation/kbuild/llvm.rst
 F:	include/linux/compiler-clang.h
+F:	scripts/Makefile.clang
 F:	scripts/clang-tools/
 K:	\b(?i:clang|llvm)\b
 
diff --git a/Makefile b/Makefile
index cbab0dc53065..010e3a4e770b 100644
--- a/Makefile
+++ b/Makefile
@@ -586,20 +586,7 @@ endif
 CC_VERSION_TEXT = $(subst $(pound),,$(shell $(CC) --version 2>/dev/null | head -n 1))
 
 ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
-ifneq ($(CROSS_COMPILE),)
-CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
-ifeq ($(LLVM_IAS),1)
-CLANG_FLAGS	+= -integrated-as
-else
-CLANG_FLAGS	+= -no-integrated-as
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
-CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
-endif
-CLANG_FLAGS	+= -Werror=unknown-warning-option
-KBUILD_CFLAGS	+= $(CLANG_FLAGS)
-KBUILD_AFLAGS	+= $(CLANG_FLAGS)
-export CLANG_FLAGS
+include $(srctree)/scripts/Makefile.clang
 endif
 
 # Include this also for config targets because some architectures need
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
new file mode 100644
index 000000000000..297932e973d4
--- /dev/null
+++ b/scripts/Makefile.clang
@@ -0,0 +1,14 @@
+ifneq ($(CROSS_COMPILE),)
+CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+ifeq ($(LLVM_IAS),1)
+CLANG_FLAGS	+= -integrated-as
+else
+CLANG_FLAGS	+= -no-integrated-as
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
+endif
+CLANG_FLAGS	+= -Werror=unknown-warning-option
+KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+export CLANG_FLAGS
-- 
2.32.0.93.g670b81a890-goog

