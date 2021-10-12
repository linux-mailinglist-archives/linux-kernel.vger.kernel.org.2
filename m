Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81542B08F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhJLXsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhJLXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:48:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFFC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:46:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so1170948ybm.18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hfiy0QufwKlZXZoYyiK7jO6+5BlktvV9a4QK+YsxTx0=;
        b=P5Kv4XRzDuovgemzwzFDEbF2CapwNumuLtyGpo9nYCVcOcDOuFAm04NHV6EDPcNKoE
         kfQkzVrspYepYC/bjDdzPpXeHWd+OUcwCvxz1yWEVlGzC7u6FO8EXGPZ07b+1gSPti6L
         bcbg9qEl/VPw1CPZhDvmecfDFtpKKhYlHQrioZ1LyewqEnvWUU8agYqExzKmmGHasVdm
         vNfR3xCfSaQ6b4abY9o9hY1cDY+DMHeVGcd94ZbVzqoYEG9dMlO89lWGsnKZ3e2LE8Oq
         0yCs8X3+V5I8JK1t+GFhB2HzftTVf5g83fSzGlcYPbJZencfTlXjEmMFyCty+OCTJ7Ls
         QCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hfiy0QufwKlZXZoYyiK7jO6+5BlktvV9a4QK+YsxTx0=;
        b=MSs8GzUNwXlHlRMoC35cqMvFkRSbq/UrcSyj4XOM48Fwssv8fPju/+JaasWc7d41R2
         agHJKQNWTBgkvyLa5HE3JmSm3qujSukg3eZSW9QtZCfEBY8L25hJK2CyVX6EHKc3D5bO
         P01/Ta61gotFw057ciV6bwsf4rxgHnOPgflLL0psffk0K9rsJF9fUSi5A8oODbwyNht6
         LtxEqoQO7tXp5C47zmH54okURTqFr7OsgtGgdcg21mH6LHfMBy6UxvicHqGkrFldFg5B
         r5M385F+ZbPl/9I00RScUoVdS1K8ZSalIEsMYJha0a40HpE4MOrt/s9j6k+EPxrtBuVP
         2jYw==
X-Gm-Message-State: AOAM530gk0CV018KfEtERwEyRs+YsOajUhvuo+58EWq+TtzzIVg52RM3
        RdELo8c95cjsxdZxXm51yR+UQfzYG2R+KIYMKaY=
X-Google-Smtp-Source: ABdhPJzqJ+E+oSOLkej8TGqrH10ec7ZUj9JYPKz4YsOMxhOsBrZihoow2n6bwIjVHLjng8ovw3DFgWfRX8Hoos5I++M=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9b44:962:5897:17c0])
 (user=ndesaulniers job=sendgmr) by 2002:a25:2202:: with SMTP id
 i2mr31320160ybi.223.1634082404879; Tue, 12 Oct 2021 16:46:44 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:46:05 -0700
In-Reply-To: <20211012234606.91717-1-ndesaulniers@google.com>
Message-Id: <20211012234606.91717-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634082366; l=2372;
 s=20211004; h=from:subject; bh=hiyKEKl9KNUln0vdBegNdaMtjSqTKA9iKbxjt+QhW7o=;
 b=7aj4L6HQ17bDqsHnReZofAfQuwPdPnNcErtr1xRO8mhYy74vVRcWes0SugNBY5Cix+5yQo5urUvo
 1y5nRpMbAhoSK7FxdeCTIF3kLFjP7t8xQzU1pkdXmgLfMtYazSW1
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 2/3] arm64: vdso32: lazily invoke COMPAT_CC
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Lucas Henneman <henneman@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the following command without arm-linux-gnueabi-gcc in
one's $PATH, the following warning is observed:

$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
make[1]: arm-linux-gnueabi-gcc: No such file or directory

This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
is not set, and we end up eagerly evaluating various variables that try
to invoke CC_COMPAT.

This is a similar problem to what was observed in
commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux")

Cc: Masahiro Yamada <masahiroy@kernel.org>
Reported-by: Lucas Henneman <henneman@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/kernel/vdso32/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 89299a26638b..d24b12318f4c 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -38,12 +38,12 @@ cc32-disable-warning = $(call try-run,\
 # As a result we set our own flags here.
 
 # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
-VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
+VDSO_CPPFLAGS = -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
 VDSO_CPPFLAGS += $(LINUXINCLUDE)
 
 # Common C and assembly flags
 # From top-level Makefile
-VDSO_CAFLAGS := $(VDSO_CPPFLAGS)
+VDSO_CAFLAGS = $(VDSO_CPPFLAGS)
 ifneq ($(shell $(CC_COMPAT) --version 2>&1 | head -n 1 | grep clang),)
 VDSO_CAFLAGS += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
 endif
@@ -73,7 +73,7 @@ VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
 VDSO_CAFLAGS += $(call cc32-option,-march=armv8-a -D__LINUX_ARM_ARCH__=8,\
                                    -march=armv7-a -D__LINUX_ARM_ARCH__=7)
 
-VDSO_CFLAGS := $(VDSO_CAFLAGS)
+VDSO_CFLAGS = $(VDSO_CAFLAGS)
 VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
 # KBUILD_CFLAGS from top-level Makefile
 VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
@@ -108,7 +108,7 @@ else
 VDSO_CFLAGS += -marm
 endif
 
-VDSO_AFLAGS := $(VDSO_CAFLAGS)
+VDSO_AFLAGS = $(VDSO_CAFLAGS)
 VDSO_AFLAGS += -D__ASSEMBLY__
 
 # From arm vDSO Makefile
-- 
2.33.0.882.g93a45727a2-goog

