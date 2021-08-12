Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443CB3EAA58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhHLSjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhHLSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:39:21 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E208C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:38:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r14-20020a0c8d0e0000b02902e82df307f0so3426532qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vF0sL0fF9hkrbzST732Pf1ePejYOAKjxRopYSg2L7GI=;
        b=ftmg5/kzgPCbtDKLvOXGUxAwgCyGmQz0FjyxE5ReqXet/Q3aA1zLsnxWPlB9wBt+pN
         K36M/laOaTJCahnaYG+LNZAf7hopKfo/T+Woj0Lqtbqu8pUOV08Rgb1uTcba1TJr0CsM
         pIaP6y6TJZPdNQC4tqbrFxivJPv7+MSF1WXFvYLcnk9PYVB16yaHqxW2lm2zhBpIOK1h
         50U6BCKLsA18+Vj6lm9LmvdlfTSSlVnaBtXrWZqcWMnMAKMPMD32u7dtfSsqBLeKG8i0
         jZ1p4P4C5/fUOMLRZN8BUZUng1f5AJdXFoKWvPMWGX9zD4QQPl1J08H98tOdXaO+4cWa
         +tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vF0sL0fF9hkrbzST732Pf1ePejYOAKjxRopYSg2L7GI=;
        b=dGm5sRRnUAw8fytVnNmenFwHp6XDUZ1IpSqgorSbcQJ4qT//kMAnF8KPfp8dnmTJW8
         R/h43itbkMKVePQ2iLRpMOAxvAmkd5Uv+xwi0SFQn5bUmyFwWPFmS8rThcZKDx+GgMv+
         603ucK0QgwFDgQeRIzpTT38pQewEhGlc8mZ4jF+K4SorkedmqP1Iz+Yd2CWdmYuuk/s9
         YAAqDDm4oBzajlUo28kpVQUGalK4+8e+IOw1TZlTic6KMctNniP4EaWfCr5IZq1kGInK
         BKhLRCbtopTcmOXaJ/ljdKo9y537N3PWsoffzUvIWdQ+WlxaFgH0DDq8jVzako0D6OFZ
         c2LA==
X-Gm-Message-State: AOAM530BiG82ZcZKfg+6gMagg8kj1b8nBAtv4Gy8fFhiTEqVOp9K4QA+
        RI7JqXHzkVx+yGe3ruyCGghM4xfSBjk28H+b/m0=
X-Google-Smtp-Source: ABdhPJwEMgPpcsPo8OyjMcTQ93JyDKLoZMXUBpm95iKTMbDwHElvwnHRCWgHnUP9ul8VWThpXNeyoIM91UlK6m0wk90=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2e44:5ff0:453:5647])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:c441:: with SMTP id
 t1mr5209159qvi.25.1628793535171; Thu, 12 Aug 2021 11:38:55 -0700 (PDT)
Date:   Thu, 12 Aug 2021 11:38:48 -0700
Message-Id: <20210812183848.1519994-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2] x86/build: remove stale cc-option checks
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc-option, __cc-option, cc-option-yn, and cc-disable-warning all invoke
the compiler during build time, and can slow down the build when these
checks become stale for our supported compilers, whose minimally
supported versions increases over time. See
Documentation/process/changes.rst for the current supported minimal
versions (GCC 4.9+, clang 10.0.1+). Compiler version support for these
flags may be verified on godbolt.org.

The following flags are supported by all supported versions of GCC and
Clang. Remove their cc-option, __cc-option, and cc-option-yn tests.
* -Wno-address-of-packed-member
* -mno-avx
* -m32
* -mno-80387
* -march=k8
* -march=nocona
* -march=core2
* -march=atom
* -mtune=generic
* -mfentry

-mpreferred-stack-boundary= is specific to GCC, while
-mstack-alignment= is specific to Clang. Rather than test for this three
times via cc-option and __cc-option, rely on CONFIG_CC_IS_* from
Kconfig.

GCC did not support values less than 4 for -mpreferred-stack-boundary=
until GCC 7+. Change the cc-option test to check for a value of 2,
rather than 4.

Link: https://github.com/ClangBuiltLinux/linux/issues/1436
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Change -mpreferred-stack-boundary= cc-option test to check 2 rather
  than 4, noting that in the commit message.
* Rebase on tip/master.
* Carry forward Nathan's RB tag.

 arch/x86/Makefile | 53 +++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 307fd0000a83..0d33ba013683 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,10 +14,13 @@ endif
 
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+ifdef CONFIG_CC_IS_GCC
+ifneq ($(call cc-option, -mpreferred-stack-boundary=2),)
       cc_stack_align4 := -mpreferred-stack-boundary=2
       cc_stack_align8 := -mpreferred-stack-boundary=3
-else ifneq ($(call cc-option, -mstack-alignment=16),)
+endif
+endif
+ifdef CONFIG_CC_IS_CLANG
       cc_stack_align4 := -mstack-alignment=4
       cc_stack_align8 := -mstack-alignment=8
 endif
@@ -31,8 +34,8 @@ REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
 
 REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
+REALMODE_CFLAGS += -Wno-address-of-packed-member
+REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
 export REALMODE_CFLAGS
 
@@ -48,8 +51,7 @@ export BITS
 #
 #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
 #
-KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
+KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
 # Intel CET isn't enabled in the kernel
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
@@ -59,9 +61,8 @@ ifeq ($(CONFIG_X86_32),y)
         UTS_MACHINE := i386
         CHECKFLAGS += -D__i386__
 
-        biarch := $(call cc-option,-m32)
-        KBUILD_AFLAGS += $(biarch)
-        KBUILD_CFLAGS += $(biarch)
+        KBUILD_AFLAGS += -m32
+        KBUILD_CFLAGS += -m32
 
         KBUILD_CFLAGS += -msoft-float -mregparm=3 -freg-struct-return
 
@@ -72,7 +73,7 @@ ifeq ($(CONFIG_X86_32),y)
         # Align the stack to the register width instead of using the default
         # alignment of 16 bytes. This reduces stack usage and the number of
         # alignment instructions.
-        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
+        KBUILD_CFLAGS += $(cc_stack_align4)
 
         # CPU-specific tuning. Anything which can be shared with UML should go here.
         include arch/x86/Makefile_32.cpu
@@ -93,7 +94,6 @@ else
         UTS_MACHINE := x86_64
         CHECKFLAGS += -D__x86_64__
 
-        biarch := -m64
         KBUILD_AFLAGS += -m64
         KBUILD_CFLAGS += -m64
 
@@ -104,7 +104,7 @@ else
         KBUILD_CFLAGS += $(call cc-option,-falign-loops=1)
 
         # Don't autogenerate traditional x87 instructions
-        KBUILD_CFLAGS += $(call cc-option,-mno-80387)
+        KBUILD_CFLAGS += -mno-80387
         KBUILD_CFLAGS += $(call cc-option,-mno-fp-ret-in-387)
 
         # By default gcc and clang use a stack alignment of 16 bytes for x86.
@@ -114,20 +114,17 @@ else
         # default alignment which keep the stack *mis*aligned.
         # Furthermore an alignment to the register width reduces stack usage
         # and the number of alignment instructions.
-        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align8))
+        KBUILD_CFLAGS += $(cc_stack_align8)
 
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
         # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
-        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
-        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
-
-        cflags-$(CONFIG_MCORE2) += \
-                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
-	cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
-		$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
-        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
+        cflags-$(CONFIG_MK8)		+= -march=k8
+        cflags-$(CONFIG_MPSC)		+= -march=nocona
+        cflags-$(CONFIG_MCORE2)		+= -march=core2
+        cflags-$(CONFIG_MATOM)		+= -march=atom
+        cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
@@ -158,18 +155,6 @@ export CONFIG_X86_X32_ABI
 ifdef CONFIG_FUNCTION_GRAPH_TRACER
   ifndef CONFIG_HAVE_FENTRY
 	ACCUMULATE_OUTGOING_ARGS := 1
-  else
-    ifeq ($(call cc-option-yn, -mfentry), n)
-	ACCUMULATE_OUTGOING_ARGS := 1
-
-	# GCC ignores '-maccumulate-outgoing-args' when used with '-Os'.
-	# If '-Os' is enabled, disable it and print a warning.
-        ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-          undefine CONFIG_CC_OPTIMIZE_FOR_SIZE
-          $(warning Disabling CONFIG_CC_OPTIMIZE_FOR_SIZE.  Your compiler does not have -mfentry so you cannot optimize for size with CONFIG_FUNCTION_GRAPH_TRACER.)
-        endif
-
-    endif
   endif
 endif
 
@@ -193,7 +178,7 @@ ifdef CONFIG_RETPOLINE
   # only been fixed starting from gcc stable version 8.4.0 and
   # onwards, but not for older ones. See gcc bug #86952.
   ifndef CONFIG_CC_IS_CLANG
-    KBUILD_CFLAGS += $(call cc-option,-fno-jump-tables)
+    KBUILD_CFLAGS += -fno-jump-tables
   endif
 endif
 

base-commit: c5ee8ababa9be56241c949d5c3b9e29a1d0300d6
-- 
2.33.0.rc1.237.g0d66db33f3-goog

