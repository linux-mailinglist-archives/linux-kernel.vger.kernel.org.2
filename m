Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD36434177
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJSWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJSWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:39:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20A2C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:36:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x15-20020a056902102f00b005ba71cd7dbfso27161768ybt.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VaDhNNXFhhUWTkgSjDPcE9jIHDvc0J7EwPhGj9hqbDg=;
        b=U4r59HjWNUbmVDmiOoXYYqpVZHqKp4+rLZ02pdOyHxb2EHjipt3QcanrHfMBoa3rT5
         46DcFKiJRxQZrRbEhBFYXiTFuko4pQ5C5tx7WmOh3ox8ce6rI9/4yFHS+m/HOWpKlIrw
         7Z9onRNpOALMCnrVgSQ2ak3GUAPD/Rab/YKMyZJp8Fs+FnjqNiJ0TzTZcGl3K7WUvHUK
         vt8BxxNp4U19TJKZLBQgLCVUJHQAAn8GY5FXIlcasCpw6bD30t9rhDA5EDyoCjKH/eGL
         Cc/kBpiOTrJCT8bKggekiJ28PoyiEuvGfzlC3I/YJVcxIRRBp9whVGiMU2mocdYsgib0
         h6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VaDhNNXFhhUWTkgSjDPcE9jIHDvc0J7EwPhGj9hqbDg=;
        b=bJeCuJW/x1a2B1OuQP/BvxV2p84/Qk4VpE8jGQjW624M1qxH9PyjWx/Yq6+fGhhNCt
         zZqh3duIjwTEUxgU3FbZ6GdZ8NxFbYhQyE/qfcp1lH99H7T73++hiDGzkF9rGYcYF5wc
         0Ap9xHQ3aue6D7yqbgQTjC825cHDrtdWe2enjWRmUDDLZagwGVZTLYK7z6H8GJ2KoLn3
         IX4fCAeyWJCwzzWEH9CGnPGYGvEzrlXab02T0TktXgTNBWhz/u5zA929ELnXgX3wSP3s
         M2zlN22dMofmtbIHr9U76xlVwjRkdFEGjavGebGOTLmK9fEKGrDUkvrwYugv0nnudABz
         MLpw==
X-Gm-Message-State: AOAM532y/G9+f9Wkf2i/3E2uzj5PAC4M59GtKt7wo+pOuTQkGFVAoazN
        ZxSKtCJ+N+eYJ92UGQJ5u9eEUmJlrOsPCc8JUyc=
X-Google-Smtp-Source: ABdhPJyQWgh+9TAh7Tj9W4TPJjcbAfo42Zp7ylgyKKOUAS7vlg0nA6CmHikYeHsN7iDfd3+1B8gmJF9NLBykmaqmjNI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:de0:247b:5157:7c15])
 (user=ndesaulniers job=sendgmr) by 2002:a25:b887:: with SMTP id
 w7mr6602581ybj.52.1634683014157; Tue, 19 Oct 2021 15:36:54 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:36:43 -0700
In-Reply-To: <20211019223646.1146945-1-ndesaulniers@google.com>
Message-Id: <20211019223646.1146945-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20211019223646.1146945-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634683006; l=2834;
 s=20211004; h=from:subject; bh=31zZKmnHrPsMeReQcK7MwmH2ZeeaRVf9+ZMpH9/QAhA=;
 b=g12/8wiwE9txkit7fKe98XPB6Jo5bZ5mba6BV0kO9dbn65pXWfDpCYkXcn2/HlAcmBW//4ogjGTH
 n0jVXAvFAXMo22BQYw6Wtm/FKDQlrvXziKgG73UymQWiS1njdv50
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 1/4] arm64: vdso32: drop the test for dmb ishld
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Biesinger <cbiesinger@google.com>,
        Simon Marchi <simon.marchi@polymtl.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binutils added support for this instruction in commit
e797f7e0b2bedc9328d4a9a0ebc63ca7a2dbbebc which shipped in 2.24 (just
missing the 2.33 release) but was cherry-picked into 2.23 in commit
27a50d6755bae906bc73b4ec1a8b448467f0bea1. Thanks to Christian and Simon
for helping me with the patch archaeology.

According to Documentation/process/changes.rst, the minimum supported
version of binutils is 2.23. Since all supported versions of GAS support
this instruction, drop the assembler invocation, preprocessor
flags/guards, and the cross assembler macro that's now unused.

This also avoids a recursive self reference in a follow up cleanup
patch.

Cc: Christian Biesinger <cbiesinger@google.com>
Cc: Simon Marchi <simon.marchi@polymtl.ca>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Fix typos (2.33 -> 2.23, 2.34 -> 2.24) as per Christian.

 arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
 arch/arm64/kernel/vdso32/Makefile            | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
index 3fd8fd6d8fc2..fb60a88b5ed4 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -20,7 +20,7 @@
 
 #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
 
-#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
+#if __LINUX_ARM_ARCH__ >= 8
 #define aarch32_smp_mb()	dmb(ish)
 #define aarch32_smp_rmb()	dmb(ishld)
 #define aarch32_smp_wmb()	dmb(ishst)
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 3dba0c4f8f42..89299a26638b 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -29,8 +29,6 @@ cc32-option = $(call try-run,\
         $(CC_COMPAT) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
 cc32-disable-warning = $(call try-run,\
 	$(CC_COMPAT) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
-cc32-as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC_COMPAT) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
 
 # We cannot use the global flags to compile the vDSO files, the main reason
 # being that the 32-bit compiler may be older than the main (64-bit) compiler
@@ -113,12 +111,6 @@ endif
 VDSO_AFLAGS := $(VDSO_CAFLAGS)
 VDSO_AFLAGS += -D__ASSEMBLY__
 
-# Check for binutils support for dmb ishld
-dmbinstr := $(call cc32-as-instr,dmb ishld,-DCONFIG_AS_DMB_ISHLD=1)
-
-VDSO_CFLAGS += $(dmbinstr)
-VDSO_AFLAGS += $(dmbinstr)
-
 # From arm vDSO Makefile
 VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
 VDSO_LDFLAGS += -z max-page-size=4096 -z common-page-size=4096
-- 
2.33.0.1079.g6e70778dc9-goog

