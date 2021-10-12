Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35FB42B090
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhJLXs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbhJLXsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:48:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00AC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:46:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso1247341yba.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3talEs2itJqGmarZ00bRlZ+EZGYrtuuD53DfIvzQNtg=;
        b=qzdeDSvgzhMcWtYkdUSFa0ZuPywUNS8d6Iq0opEXqOeXrVaoiG5JxPJ0TJQiRZh0LG
         WrVHXzHG2RJrNxv+YjLx4cto+c5SmzGQ2/z0zUULMIT7Ylb7pXOl297B1+MWZ4URm6S3
         K90m3PbtV9kWTxRgSNz3PeKremWzBOf0Cox3VCPKFO56xhD3za4t6+XsqAI+rP2pGL1W
         cTfACzuqg94r2cGOPU8l0OIdCsWVRzb7nWFXAEYC/pjCatjBxM87j3vg47R/3uW0gnuW
         mMjxF9pyyNF+/pFKR62WKfH+q/OPZAGXiRJrN508Uimg4ecnjxAB+2n+VMbix2baq+nU
         YzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3talEs2itJqGmarZ00bRlZ+EZGYrtuuD53DfIvzQNtg=;
        b=hxsGtNfyitsexM0dUGPiIdtH2I/dHT+zCYG5GY7ItzICTdHTFcOr9QpOGYUyEgoVlv
         fnNkxJ8y88IrsQdTbjHnsUgphfdXUbMRQSG8e5IvBmpTBEjKctTZC7YgeDb2EilVIpqP
         aXnEKGWjiIJ6J40seJprr+RKseIx7IfeWcIwvtw5BqSwDkp9KcXymfeJLdA3VzTjDf3k
         eDl9+MdE4xKSDR1n8ehHtaRxFgWr56zwUHYHJRoPpKW9OSM4fb3hquMtJ2s9JCeGV9yh
         /X6rv/dX9nff67DcZmFzejdMS481PIUHqVwT4lo+L7CXlZIFjTuPLjC6PAsCJ24mHqnG
         nUCQ==
X-Gm-Message-State: AOAM530IK0Ccpngw3asz46ZOlX1laAT4JkPXPCK8uOPfPD6rjfSH8XdX
        poLqs0JF4zZY4zXwPK+iet0LV44n5IziUNqCIvI=
X-Google-Smtp-Source: ABdhPJzIFutXhB9fFNe6qJTxVeF1qwVsjQr5R4imjUV0XUci065GZ+CKOL8HJ4Lt4zkEXo2DTCrWFbyf95vjjodTJI0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9b44:962:5897:17c0])
 (user=ndesaulniers job=sendgmr) by 2002:a25:81c5:: with SMTP id
 n5mr31228924ybm.276.1634082411872; Tue, 12 Oct 2021 16:46:51 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:46:06 -0700
In-Reply-To: <20211012234606.91717-1-ndesaulniers@google.com>
Message-Id: <20211012234606.91717-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634082366; l=2773;
 s=20211004; h=from:subject; bh=KivxBEiz8kY/YG1A752ABLoGXTndClfSbCaLd5U6VRE=;
 b=o6J8KwlbYffgoHGg/p2CFoh1PIdXMYZrdEsa/Db69BI0eYl2197Z05hXHSNfvgmMqr/qea2Oqv2M
 U0DjCIgcDQNjSaSxOvufMKH6LrB5PlivtBlBsJEAz4gLGwPgsM2T
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 3/3] arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to
commit 231ad7f409f1 ("Makefile: infer --target from ARCH for CC=clang")
There really is no point in setting --target based on
$CROSS_COMPILE_COMPAT for clang when the integrated assembler is being
used.

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

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/Kconfig                |  3 ++-
 arch/arm64/kernel/vdso32/Makefile | 17 +++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..7b28dad2fb80 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1264,7 +1264,8 @@ config KUSER_HELPERS
 
 config COMPAT_VDSO
 	bool "Enable vDSO for 32-bit applications"
-	depends on !CPU_BIG_ENDIAN && "$(CROSS_COMPILE_COMPAT)" != ""
+	depends on !CPU_BIG_ENDIAN
+	depends on CC_IS_CLANG && LD_IS_LLD || "$(CROSS_COMPILE_COMPAT)" != ""
 	select GENERIC_COMPAT_VDSO
 	default y
 	help
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index d24b12318f4c..376261d3791f 100644
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
 
@@ -44,10 +41,6 @@ VDSO_CPPFLAGS += $(LINUXINCLUDE)
 # Common C and assembly flags
 # From top-level Makefile
 VDSO_CAFLAGS = $(VDSO_CPPFLAGS)
-ifneq ($(shell $(CC_COMPAT) --version 2>&1 | head -n 1 | grep clang),)
-VDSO_CAFLAGS += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-endif
-
 VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
 ifdef CONFIG_DEBUG_INFO
 VDSO_CAFLAGS += -g
-- 
2.33.0.882.g93a45727a2-goog

