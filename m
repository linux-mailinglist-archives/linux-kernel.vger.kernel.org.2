Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1424A3B99C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 01:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhGAX5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 19:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhGAX5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:57:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C61BC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 16:55:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so5462818qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ow2DpQC2coKFnJ/SMWPFob1l5XzvaNidZbZlwjsfO1U=;
        b=cJVSLikFzKcW0A2xFJTabDbHUA2LeY8gz9d1IeC/qVFQN5R5ewr+zxPU3+AfEMVENL
         K0Mu29B95m3k12XoxyOqmJPUWX7XWiA1wS9kB+3+mOgMpdKx5SjltBGoiK6d46OUI321
         gttmDJFGZu9+NMad9V5Ai3FUBsVETDtkh1qXGWlJ46XLd6gbP/SGOx+8tLulzBgtYY+5
         7r5LdXgt4qKREZsyacmrj9NTifR4KRR+AEPxr/fTvai5aZU7jOWaB1bjz0IVsdd9/GPs
         j8Soe9B5dstQt9xUsJzUmMrLhNl1uHRWvfBHjUNqQfgpVVP9mYs/vwaTLbB5iNPhGNLU
         zSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ow2DpQC2coKFnJ/SMWPFob1l5XzvaNidZbZlwjsfO1U=;
        b=XkWxr37XsZoqtwVXaOZFN3Vx20usZ3MUXEp+j5nsXSUu2yUtc8CBWwgsMwknzNM52g
         EDjdFMHud7mmvOx4JOWvR9rpls3vRh2Rs/ZoBXy3vNNzS98eQR+WDmll0Cx22TnZ2ovM
         Le5PnlpIwFMyPB97wDfvddd6zW9RYI7fCUCnaXsIwvTDtIMP+qPuY7mwoGM2mSQBWimi
         bMgdN/WqF9bSHlwV2ZSLjV9VTPKihoT7FF39f1OEsyP+rtiR1TspWoAiSB5prAi4cpY4
         bnSRf/idisUjO1iMA3nlNLbHw+CYHMqWjPyEtDRk4LxKYiBP7paOApShSwxSQEVtq0gC
         lWrg==
X-Gm-Message-State: AOAM532mCjF7dSgke913t4n6hP1qh0363pEzrie5iHypIuw0/imXcvHF
        8UzZ9oMh5MqEww85wwPjUE2dpZBtd/NIb3DUiw4=
X-Google-Smtp-Source: ABdhPJxlOczNl134CJhArUI2DZNMqGi1FuYNGVwNL/HFfQHYPMGfW3r2ZHRfMfUt4l8ShCakf0Fc7HJg8TmQfC8ywFA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:4946:97e8:cb24:9825])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:c345:: with SMTP id
 j5mr2543715qvi.26.1625183709770; Thu, 01 Jul 2021 16:55:09 -0700 (PDT)
Date:   Thu,  1 Jul 2021 16:55:05 -0700
Message-Id: <20210701235505.1792711-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get constant feedback that the command line invocation of make is too
long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
target triple, or is an absolute path outside of $PATH, but it's mostly
redundant for a given ARCH.

If CROSS_COMPILE is not set, simply set --target=aarch64-linux for
CLANG_FLAGS, KBUILD_CFLAGS, and KBUILD_AFLAGS.

Previously, we'd cross compile via:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linxu-gnu make LLVM=1 LLVM_IAS=1
Now:
$ ARCH=arm64 make LLVM=1 LLVM_IAS=1

We can drop gnu from the triple, but dropping linux from the triple
produces different .config files for the above invocations for the
defconfig target.

Link: https://github.com/ClangBuiltLinux/linux/issues/1399
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7bc37d0a1b68..016873fddcc3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -34,6 +34,17 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
+ifneq ($(LLVM),)
+ifneq ($(LLVM_IAS),)
+ifeq ($(CROSS_COMPILE),)
+CLANG_TARGET	:=--target=aarch64-linux
+CLANG_FLAGS	+= $(CLANG_TARGET)
+KBUILD_CFLAGS	+= $(CLANG_TARGET)
+KBUILD_AFLAGS	+= $(CLANG_TARGET)
+endif
+endif
+endif
+
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
-- 
2.32.0.93.g670b81a890-goog

