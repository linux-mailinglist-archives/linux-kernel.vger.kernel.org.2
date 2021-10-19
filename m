Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B4434178
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJSWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhJSWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:39:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F71C061768
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:37:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so27304830ybb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ieJkUq9AzcpIj4LQBtK/SuYHkz864IVu4L+C9FeReNk=;
        b=ERko7aMyEefMKRlvV+YD2HoE6JCeR02DxC3cDmrCS0O1UiBj+RN2tSODvIWcna78Cw
         EJR33ISjdTzmwBPptFpZbGhcPvP4wQ/wlvy/jh/F5JfsfiG7Nwaoy7dsONTwHvPP7YJo
         wqdihZee+7b7qp3N9lLeJUXPikSzPfCkK3O3jppmlVpy+p4/D5m9KVmWBTdOjIttqqBb
         XNcKhpveeawTx3cJCTsN50vbXBF+S91p2IOyqhdMBcjThvW8iAGo6nckvEmibPnHUbzb
         tMG1bFm6Th+iIzS+zYG23S7K9UTJDw4wBFJ8/VIMGzm8Y4T/9FiaFppZ3vbDfkAsU2cG
         cE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ieJkUq9AzcpIj4LQBtK/SuYHkz864IVu4L+C9FeReNk=;
        b=iH8HXn81NNGkieLYCoLRQ8GI5O+8OxqViNbtReMVKzQ+Xo8jQik5xi6+f9Tz7VqhHE
         NViJGrbOePy7BKsvKNcuoqun8PUHbyoEgYghWiN1S0leL7ssqYrCLVK45VQhu7kVBTw2
         mV7IyOrQVLuEvqUSK342PPzXMf+XO1duYIol+LoVcrlZuMJ7gUZ3VGXIdl6B4PU8k1DL
         nIYUo2XO/79lxslAiDrc6PVJB0bI/1R4xRc64yQtkuNQeBrFcMKcFzq53Uek4Bqk8M7v
         uNcu8sn8/z1NzTBoQoFwlX2w21SgonpN5lYS1FsfoS/4evWx7OGFmK7vYAgcNDS6mzMM
         P0GA==
X-Gm-Message-State: AOAM532jM6TheAPlA/MecGEWqSoxsxcqJvDoxPCB5lhGs8IzTGWvHao2
        DH7RtKH/4Lr49hgsKbEqEOPezorgsKsnJ97nUeY=
X-Google-Smtp-Source: ABdhPJw8tBLJuOZSF61b7iRwYY/fKQtMy2X99637/nO9cOgSqDLJbdat9U2v0D48/Z7up8cj+LueXImtfbNoMWSaySs=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:de0:247b:5157:7c15])
 (user=ndesaulniers job=sendgmr) by 2002:a25:1a46:: with SMTP id
 a67mr42666171yba.21.1634683021220; Tue, 19 Oct 2021 15:37:01 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:36:46 -0700
In-Reply-To: <20211019223646.1146945-1-ndesaulniers@google.com>
Message-Id: <20211019223646.1146945-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20211019223646.1146945-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634683006; l=3156;
 s=20211004; h=from:subject; bh=bnFBQ6SFPtVAkwcilKxCNvOoVbtexwjszCO7lK1gTak=;
 b=WK0kuoDuvYBKOWtOBxZiPPiBoN9HIqJyfM6EDsHV+1PUewJNi21HNTTWWfH7V5NZcKxfR4UBSAPi
 L3H7+RH4BlB/mChnNglFhRxhTz73LV4hNQDAa3YHRyCtVpW1JNKe
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 4/4] arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to
commit 231ad7f409f1 ("Makefile: infer --target from ARCH for CC=clang")
There really is no point in setting --target based on
$CROSS_COMPILE_COMPAT for clang when the integrated assembler is being
used, since
commit ef94340583ee ("arm64: vdso32: drop -no-integrated-as flag").

Allows COMPAT_VDSO to be selected without setting $CROSS_COMPILE_COMPAT
when using clang and lld together.

Before:
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 defconfig
$ grep CONFIG_COMPAT_VDSO .config
CONFIG_COMPAT_VDSO=y
$ ARCH=arm64 make -j72 LLVM=1 defconfig
$ grep CONFIG_COMPAT_VDSO .config
$

After:
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 defconfig
$ grep CONFIG_COMPAT_VDSO .config
CONFIG_COMPAT_VDSO=y
$ ARCH=arm64 make -j72 LLVM=1 defconfig
$ grep CONFIG_COMPAT_VDSO .config
CONFIG_COMPAT_VDSO=y

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Cite ef94340583ee as per Nathan.
* Add parens to Kconfig expression as per Nathan.
* Pick up Nathan's RB, TB, and SB tags.

 arch/arm64/Kconfig                |  3 ++-
 arch/arm64/kernel/vdso32/Makefile | 17 +++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..f0f2c95aa4c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1264,7 +1264,8 @@ config KUSER_HELPERS
 
 config COMPAT_VDSO
 	bool "Enable vDSO for 32-bit applications"
-	depends on !CPU_BIG_ENDIAN && "$(CROSS_COMPILE_COMPAT)" != ""
+	depends on !CPU_BIG_ENDIAN
+	depends on (CC_IS_CLANG && LD_IS_LLD) || "$(CROSS_COMPILE_COMPAT)" != ""
 	select GENERIC_COMPAT_VDSO
 	default y
 	help
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index e478cebb9891..c8fec493a450 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -10,18 +10,15 @@ include $(srctree)/lib/vdso/Makefile
 
 # Same as cc-*option, but using CC_COMPAT instead of CC
 ifeq ($(CONFIG_CC_IS_CLANG), y)
-CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-
 CC_COMPAT ?= $(CC)
-CC_COMPAT += $(CC_COMPAT_CLANG_FLAGS)
-
-ifneq ($(LLVM),)
-LD_COMPAT ?= $(LD)
+CC_COMPAT += --target=arm-linux-gnueabi
 else
-LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)ld
+CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
 endif
+
+ifeq ($(CONFIG_LD_IS_LLD), y)
+LD_COMPAT ?= $(LD)
 else
-CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
 LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)ld
 endif
 
@@ -45,10 +42,6 @@ VDSO_CPPFLAGS += $(LINUXINCLUDE)
 # Common C and assembly flags
 # From top-level Makefile
 VDSO_CAFLAGS := $(VDSO_CPPFLAGS)
-ifneq ($(shell $(CC_COMPAT) --version 2>&1 | head -n 1 | grep clang),)
-VDSO_CAFLAGS += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-endif
-
 VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
 ifdef CONFIG_DEBUG_INFO
 VDSO_CAFLAGS += -g
-- 
2.33.0.1079.g6e70778dc9-goog

