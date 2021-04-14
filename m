Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4F35FD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhDNVqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDNVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:46:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED90AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:45:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c1-20020a5b0bc10000b02904e7c6399b20so125198ybr.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3tZuog4SLHhpY3z/paxkTsPCnEx+8O3qafW8rWHSl20=;
        b=oDg5/eyghmiYZFBxy2BnHB/r+LUvSsj2yKruJv+rqilNQM6dwrSQ0g7sPsJOgLSqL9
         CBzKYzO27y9kQfpbCLg/xDva9W1JFVPGrwJsi8kgTr0lsVd0uU+c9jPK2XGMBkEqfbHC
         8m1+6DdPb6kidvx+k9XsG/UrhjzlWoUgqiZh6BFVZiK3xfiNie4MFoZyhtl5xFRp//rI
         6BUlGHR63Qj9h/KOw+QrnFKJikMLAyDEDIjet0iEpP1/0rTSMPZ3rABgdZtSqu2ge5fg
         eE+T/4e4rrkzEAGPSxOhvFAPtaeFV4MKfRkvFAb3fdH+rdw3mJVCYSw+KOM5FHaLAAOU
         xQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3tZuog4SLHhpY3z/paxkTsPCnEx+8O3qafW8rWHSl20=;
        b=uBn0151SlCZ3FaU2JaD9EPYms2OKN5feMPkYzf8sGN/Ccp1Bu2/O6rMQ9Mm+VdauZe
         h8DrbNyfOmOjDp3eceDsZHHerr3HcT8jswsXAd6v9MArPRetQB4stq6tJEqe77QpHd6T
         Yv9sdf4eo4wcx6/586VeoG6MpLYGGQihVsrBGMzKpc26S4GMmrzEN2YNjOuGeL8Q+nzY
         U38rkTTuUjsQVbaavezf3HIOciZMnyKV/lA1PftkB4G9czaz9ufFYLLmNuijYK0cE78O
         IN4C0iTyseyxz62K3Q/yc0g6J6BonPb1W/2OnBy68pVjX+u9mXn2wSCjp4Q+PrHqeJpl
         OJ7g==
X-Gm-Message-State: AOAM532zoyXqhNtjp6acI1Vxwl5/F8IHb93FgKm4+N+G2OGNdQSP/1LG
        HY4ZB6mG+Dnn7gzm3KyQO/j+LIc0StwxIcAyqlI=
X-Google-Smtp-Source: ABdhPJwBULOkshK1bSSyx73ltUcgL3/lyV9Uo67fQ+9LPjaPjF0btDHX3w/AnLtnDoHA/IMhzuuUxU69aXweEyeNpQM=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:7cc9:fe9f:6e17:380e])
 (user=ndesaulniers job=sendgmr) by 2002:a25:4f06:: with SMTP id
 d6mr94731ybb.105.1618436750824; Wed, 14 Apr 2021 14:45:50 -0700 (PDT)
Date:   Wed, 14 Apr 2021 14:45:45 -0700
In-Reply-To: <YHYlQnFRMNdn/CDp@archlinux-ax161>
Message-Id: <20210414214548.700993-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <YHYlQnFRMNdn/CDp@archlinux-ax161>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2] arm64: vdso32: drop -no-integrated-as flag
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     vincenzo.frascino@arm.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang can assemble these files just fine; this is a relic from the top
level Makefile conditionally adding this. We no longer need --prefix,
--gcc-toolchain, or -Qunused-arguments flags either with this change, so
remove those too.

To test building:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
  defconfig arch/arm64/kernel/vdso32/

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Remove --prefix, --gcc-toolchain, COMPAT_GCC_TOOLCHAIN, and
  COMPAT_GCC_TOOLCHAIN_DIR as per Nathan.
* Credit Nathan with Suggested-by tag.
* Remove -Qunused-arguments.
* Update commit message.

 arch/arm64/kernel/vdso32/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 789ad420f16b..3dba0c4f8f42 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -10,15 +10,7 @@ include $(srctree)/lib/vdso/Makefile
 
 # Same as cc-*option, but using CC_COMPAT instead of CC
 ifeq ($(CONFIG_CC_IS_CLANG), y)
-COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
-COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
-
 CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-CC_COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE_COMPAT))
-CC_COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
-ifneq ($(COMPAT_GCC_TOOLCHAIN),)
-CC_COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
-endif
 
 CC_COMPAT ?= $(CC)
 CC_COMPAT += $(CC_COMPAT_CLANG_FLAGS)
-- 
2.31.1.295.g9ea45b61b8-goog

