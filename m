Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0F3686E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbhDVTFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:05:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67703C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:04:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so21305289ybo.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3JxsJBXAmKu7JJp72AbzAJVBgXn6zJ+KszGwGGilLKo=;
        b=XkJg3rmRjbx8Y8ZkYXzeh6z+LPHZ50Pz8RxUIMMoz9jTInIT02KOS3pe4eUZ2hw4/H
         SK6by80n5x6WOL+6YXJYod68LK5ILC9QVKzG2agzERtRYjVrQfSRFdlIgIMboryc9/2O
         7kdEKb6YHMMEyPpoWv3NR6JT1A2GKG3Tf0HJ1KVcXFo+qjPhFFdO5G6waCFUQ9r2JATT
         NHNzCsLoJGXM+z2z6Wkx1CiF1qyE5hnSvTmjG4r/gSsyIx1Xq6axYRKNzG33SxgHShwO
         hW8MF8kNwEfw9rRDJOaYeJX2VZBATxVHqyNNSvdCQvFYl4hnmC0BBkrlZCQdeAVpCZZv
         B60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3JxsJBXAmKu7JJp72AbzAJVBgXn6zJ+KszGwGGilLKo=;
        b=IVwfmaSCUymVW7VeQ/tS2CxyvIqW/ae9KS5ijdlun9E8qYNIMUQ4l7KJ6lkH1kuPJ0
         L7hs1IyPAeF6fcmQD0huknlBASAzl8hKGE/NbuWmDzzpO2ndXgU9Hh+fVT/y43/rQrFG
         MJrx7EiljjIxuDuNFN6IzFXc91VmIeNTcUNhW9XR3RR/33YKxScKssvaVsagMT8lncSD
         jvvHBjt1iyY0vEznytJ0Rh35umCa5KJx38NCyo2MrMY47/tVDKDIRChM2G4Qrb3w6K/y
         0b0/UM2yrB8IpXpPgRd1ZgydgB4D0CZoCPsAw+AeycajqKK0MwazPoSrV8H/F3xeCt9U
         8AOw==
X-Gm-Message-State: AOAM532qCS5TRsdc0vxUkJiWcIgONd+NLYIEr3/Z2hNU39khL34xo6SF
        NmAr3PrpWZmEl/XS3a+XLSRNFeg0sC6Vjblhldg=
X-Google-Smtp-Source: ABdhPJx7fas+0qxPzzKSYnDfQaHNVMa/Uc1ndJ2GEH/VXBkuUAPPYNeE/R7YyB4zXKJTGB81RP5P8PghEqv2RRuaRHg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9317:2762:871:5f48])
 (user=ndesaulniers job=sendgmr) by 2002:a25:58d5:: with SMTP id
 m204mr308072ybb.32.1619118293658; Thu, 22 Apr 2021 12:04:53 -0700 (PDT)
Date:   Thu, 22 Apr 2021 12:04:42 -0700
Message-Id: <20210422190450.3903999-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] x86/boot/compressed: enable -Wundef
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A discussion around -Wundef showed that there were still a few boolean
Kconfigs where #if was used rather than #ifdef to guard different code.
Kconfig doesn't define boolean configs, which can result in -Wundef
warnings.

arch/x86/boot/compressed/Makefile resets the CFLAGS used for this
directory, and doesn't re-enable -Wundef as the top level Makefile does.
If re-added, with RANDOMIZE_BASE and X86_NEED_RELOCS disabled, the
following warnings are visible.

arch/x86/boot/compressed/misc.h:82:5: warning: 'CONFIG_RANDOMIZE_BASE'
is not defined, evaluates to 0 [-Wundef]
    ^
arch/x86/boot/compressed/misc.c:175:5: warning: 'CONFIG_X86_NEED_RELOCS'
is not defined, evaluates to 0 [-Wundef]
    ^

Simply fix these and re-enable this warning for this directory.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/570
Link: https://lore.kernel.org/lkml/67f6cd269684c9aa8463ff4812c3b4605e6739c3.camel@perches.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/boot/compressed/Makefile | 1 +
 arch/x86/boot/compressed/misc.c   | 2 +-
 arch/x86/boot/compressed/misc.h   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..77cc373c1036 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -30,6 +30,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 
 KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
+KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 267e7f93050e..3a214cc3239f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -172,7 +172,7 @@ void __puthex(unsigned long value)
 	}
 }
 
-#if CONFIG_X86_NEED_RELOCS
+#ifdef CONFIG_X86_NEED_RELOCS
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
 {
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 901ea5ebec22..b140f988a233 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -79,7 +79,7 @@ struct mem_vector {
 	u64 size;
 };
 
-#if CONFIG_RANDOMIZE_BASE
+#ifdef CONFIG_RANDOMIZE_BASE
 /* kaslr.c */
 void choose_random_location(unsigned long input,
 			    unsigned long input_size,

base-commit: 16fc44d6387e260f4932e9248b985837324705d8
-- 
2.31.1.498.g6c1eba8ee3d-goog

