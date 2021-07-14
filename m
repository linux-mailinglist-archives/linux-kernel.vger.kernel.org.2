Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69A3C9382
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhGNWE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:04:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6871C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:01:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n10so2160312plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZz3Q/ZJbGlF0mir3OjfntOY5tpSIoWny/Bp+uepGXc=;
        b=i0xDSdkSRmXXOlx60zQ/z8SIGn3i2kQFScqyHKQIZ6TWj1yFsa6ts/GJ+nJpfGNnXa
         ldpQKEuq3GLVR0g5swbC9+jHPvjskZrEdabNEmPF7khXFQHjawTVmg/RlTDJHM0+3rzo
         oQVkDT0PujyHoCqd/iqOsBf/HMUb48mksXhdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZz3Q/ZJbGlF0mir3OjfntOY5tpSIoWny/Bp+uepGXc=;
        b=t7vorxvKwoDHNnsEFbdu3oJqU0ER7BwmiWVZSaKvdv2dg9x4fDP29OPPh7bL2gTIXQ
         ulABIzW+je2N0aExtagOGsYdFYwpD3JKkj65c2WE23ySgO1spoen/eNeXfZZu3n0Yqz6
         mrprNclJHd3sB6NPBn6RcCz9hULUl4chw2VR7JkLJVHtGBaLfZF5ksIegcc5rRhGieMI
         7LFptoVgHLm/CKn8yndzjylEduckk6r8NeeY1I17YSQYupopw6+xSQc5OeLzRTOPIBou
         BbcqywdksKcf4bIXGcy5VKQzwrlzRo8PkZXsTjxp042HI2D4FXUN9rdSyjCHi7i1fbse
         BMAQ==
X-Gm-Message-State: AOAM530Fz9V+G8dnqdky+c1of1ASXSVmwF00+cHd3uW+NcQqeMb5cYzD
        gthT0LCYk5Jx1M85LC4QZJIiDw==
X-Google-Smtp-Source: ABdhPJyayP6g/Ad7a/Q/O3dIAqBlI0rEC61CDeZToDIGUuPyVKJcPdNTqjuKz1Y8fu5e7oQHNDv7Tw==
X-Received: by 2002:a17:90a:3f87:: with SMTP id m7mr5791738pjc.128.1626300092420;
        Wed, 14 Jul 2021 15:01:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 5sm4311009pgv.25.2021.07.14.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:01:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] hardening: Introduce CONFIG_ZERO_CALL_USED_REGS
Date:   Wed, 14 Jul 2021 15:01:29 -0700
Message-Id: <20210714220129.844345-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5017; h=from:subject; bh=NRSAJRf4SfXeilyQmbm87EVou7aHzXrXqis5Pti8xs4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg7164+Lyw2yeO7DZfdYiS3fm5Ky5EDg9iq+jyUN6L TXD+yMyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYO9euAAKCRCJcvTf3G3AJvk3D/ 0fsebV/Ys/JhQT2Lgipn4xkNZAmc57ZE4slJTJYwn3wzWikokMZr9MC8gC6M1lAMQ8F8HXcwE0rFfi /t6oP35HrW1PQfqTOl68Yv97F29HkBojl8MkrC0zRmVzMkbsLwwOJk4ZBF0xqesEMx802/aOJxJsl5 aycAweKJm5kY253Hq/b0UyZjrjmQcK4gNsCBjVe2VspmF8+DF+wFeCdyRDtD1Z2LImhQjd16SSvhTW sFTIRD2dfOIJ9jHwW4bsU9y+rrwb7QtRRwDTVnVg74e0IUsynsvEhBd5h7DZ85NIMaTqtNumgVqalY lnwllyU/RItdBI/vgkR/ZgbTXjfqGF3fNPkMNHdYZ9KnRF4cI26UFtQyXmjGr7Mj4Etw4RdSdZUNF+ E3DKyZe3kIe9MgJGGqOTKNKbkjh0BzlyVsNlHVHD+TqutmdZzhIYzMGSOLGnS01OI6w1g2fbsME4+O ei0lRn6EI4iAVrTWizV++C5tHl7SANNSsRvYQ49gxr4U4W9W0sZhak5Bz7218e6Wo9MBRQglzrrNfX IuMX12J9x19nv+wO9Qf5Ht/vWhfuvR+2emycd65CIf3YUgvMkDiockBq4yJ3SmFSNjYNuNuN0VWuhG P9Kn3Lb6XYIs23PJSFM/IwzqGd5xmT/Wttp34hpzqf+A+nWc7b9KtKrmpOKA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ZERO_CALL_USED_REGS is enabled, build the kernel with
"-fzero-call-used-regs=used-gpr" (in GCC 11). This option will zero any
caller-used register contents just before returning from a function,
ensuring that temporary values are not leaked beyond the function
boundary. This means that register contents are less likely to be
available for side channel attacks and information exposures.

Additionally this helps reduce the number of useful ROP gadgets in the
kernel image by about 20%:

$ ROPgadget.py --nosys --nojop --binary vmlinux.stock | tail -n1
Unique gadgets found: 337245

$ ROPgadget.py --nosys --nojop --binary vmlinux.zero-call-regs | tail -n1
Unique gadgets found: 267175

and more notably removes simple "write-what-where" gadgets:

$ ROPgadget.py --ropchain --binary vmlinux.stock | sed -n '/Step 1/,/Step 2/p'
- Step 1 -- Write-what-where gadgets

        [+] Gadget found: 0xffffffff8102d76c mov qword ptr [rsi], rdx ; ret
        [+] Gadget found: 0xffffffff81000cf5 pop rsi ; ret
        [+] Gadget found: 0xffffffff8104d7c8 pop rdx ; ret
        [-] Can't find the 'xor rdx, rdx' gadget. Try with another 'mov [reg], reg'

        [+] Gadget found: 0xffffffff814c2b4c mov qword ptr [rsi], rdi ; ret
        [+] Gadget found: 0xffffffff81000cf5 pop rsi ; ret
        [+] Gadget found: 0xffffffff81001e51 pop rdi ; ret
        [-] Can't find the 'xor rdi, rdi' gadget. Try with another 'mov [reg], reg'

        [+] Gadget found: 0xffffffff81540d61 mov qword ptr [rsi], rdi ; pop rbx ; pop rbp ; ret
        [+] Gadget found: 0xffffffff81000cf5 pop rsi ; ret
        [+] Gadget found: 0xffffffff81001e51 pop rdi ; ret
        [-] Can't find the 'xor rdi, rdi' gadget. Try with another 'mov [reg], reg'

        [+] Gadget found: 0xffffffff8105341e mov qword ptr [rsi], rax ; ret
        [+] Gadget found: 0xffffffff81000cf5 pop rsi ; ret
        [+] Gadget found: 0xffffffff81029a11 pop rax ; ret
        [+] Gadget found: 0xffffffff811f1c3b xor rax, rax ; ret

- Step 2 -- Init syscall number gadgets

$ ROPgadget.py --ropchain --binary vmlinux.zero* | sed -n '/Step 1/,/Step 2/p'
- Step 1 -- Write-what-where gadgets

        [-] Can't find the 'mov qword ptr [r64], r64' gadget

For an x86_64 parallel build tests, this has a less than 1% performance
impact, and grows the image size less than 1%:

$ size vmlinux.stock vmlinux.zero-call-regs
   text    data     bss     dec     hex filename
22437676   8559152 14127340 45124168 2b08a48 vmlinux.stock
22453184   8563248 14110956 45127388 2b096dc vmlinux.zero-call-regs

Impact for other architectures may vary. For example, arm64 sees a 5.5%
image size growth, mainly due to needing to always clear x16 and x17:
https://lore.kernel.org/lkml/20210510134503.GA88495@C02TD0UTHF1T.local/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: adjust image size language to reflect arm64 differences (mark)
v1: https://lore.kernel.org/lkml/20210505191804.4015873-1-keescook@chromium.org/
---
 Makefile                   |  5 +++++
 security/Kconfig.hardening | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Makefile b/Makefile
index c3f9bd191b89..bed9c68d93d3 100644
--- a/Makefile
+++ b/Makefile
@@ -841,6 +841,11 @@ endif
 # for the randomize_kstack_offset feature. Disable it for all compilers.
 KBUILD_CFLAGS	+= $(call cc-option, -fno-stack-clash-protection)
 
+# Clear used registers at func exit (to reduce data lifetime and ROP gadgets).
+ifdef CONFIG_ZERO_CALL_USED_REGS
+KBUILD_CFLAGS	+= -fzero-call-used-regs=used-gpr
+endif
+
 DEBUG_CFLAGS	:=
 
 # Workaround for GCC versions < 5.0
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index a56c36470cb1..023aea5e117c 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -217,6 +217,25 @@ config INIT_ON_FREE_DEFAULT_ON
 	  touching "cold" memory areas. Most cases see 3-5% impact. Some
 	  synthetic workloads have measured as high as 8%.
 
+config CC_HAS_ZERO_CALL_USED_REGS
+	def_bool $(cc-option,-fzero-call-used-regs=used-gpr)
+
+config ZERO_CALL_USED_REGS
+	bool "Enable register zeroing on function exit"
+	depends on CC_HAS_ZERO_CALL_USED_REGS
+	help
+	  At the end of functions, always zero any caller-used register
+	  contents. This helps ensure that temporary values are not
+	  leaked beyond the function boundary. This means that register
+	  contents are less likely to be available for side channels
+	  and information exposures. Additionally, this helps reduce the
+	  number of useful ROP gadgets by about 20% (and removes compiler
+	  generated "write-what-where" gadgets) in the resulting kernel
+	  image. This has a less than 1% performance impact on most
+	  workloads. Image size growth depends on architecture, and should
+	  be evaluated for suitability. For example, x86_64 grows by less
+	  than 1%, and arm64 grows by about 5%.
+
 endmenu
 
 endmenu
-- 
2.30.2

