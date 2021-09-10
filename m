Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCF4073FB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhIJXmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhIJXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E552C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:40:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o202-20020a25d7d3000000b005a704560db0so2773897ybg.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DKjlgcg+r0e4xO0bskFN1KIlMorQwSRD5KKU/bKadhI=;
        b=rNlh8q+W4UPNA/Z0p9mrTRUDKYG3KATgZib4VXtq55X9glfMG8NNdKRgWaTMphU3i4
         dKYE3QHp4tUQmZPlG8LlYCYVeeU73EkKI1YhpDweHtpn/h12J4Sd0bKvD9Kgt6niOKTM
         tJolRawwapExOpVKVLUdwfcRhsAn3zdy9/5fDeW4wLypoTr7+NLioaQdFsAuwIH/DO50
         hoenrJ8wpPpUsqavUuKVLOeHUNGIAj2+2HKj3j/7/TAjNhoMc1YOnJeLGTox58m02eC0
         zv6tF6a4qq0Ylfu3om8yS6a5j+jiWP4R4zN4Jwuukst+FwB5Br0Umo4LsnaqhN/edylV
         BHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DKjlgcg+r0e4xO0bskFN1KIlMorQwSRD5KKU/bKadhI=;
        b=X3ejpzBtf2/tUI4bNwPTZngLAnfVKBbpplk9HVc4+RObvHgVwK/1H3B6LbwPDSb9im
         M9ldCY4azu8VBVyBfXcw46x5/94Qw81BAWOKupXbvqaAby3ux4p+DdFfoEw/fbkPz5wo
         61FtsjUpJI75XPs6eV1WZ0oy+xSrD7xQOzqFY17gj5EhMm+n2amzKfaTeN4YPLW8tHiR
         RNQzvt23+ZKr/eir8qtPS2gq4MWfwEnOFP7sS+5Whk5TLSGyw8NbF8icKyGj30zyL/3a
         md69sEzu4Z+0tTr3ItXWda6SAmDlF2eGNcVzFmQ1t5Ca+BGR8611HwdeRsJq5k9/Dh71
         wJGw==
X-Gm-Message-State: AOAM532Kwz8Z6BEDMRYQFf2O5aRj0dvWuJ2CPNDuMlnrPHsd6js/UHuZ
        pO318tMg93yWyvCHusWi6Pq6NKcu3cy8NsaVaqg=
X-Google-Smtp-Source: ABdhPJx63/C3W7nDk7W0PmjdB/FChWCRRGKunarJ54yPmW9B3BuldlkijPE/JXpR+DsdzTSEXpbQ//wq+vzFqXWcPsE=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a25:a522:: with SMTP id
 h31mr368063ybi.355.1631317253607; Fri, 10 Sep 2021 16:40:53 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:38 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 01/10] Documentation: raise minimum supported version of GCC
 to 5.1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit fad7cd3310db ("nbd: add the check to prevent overflow in
__nbd_ioctl()")

raised an issue from the fallback helpers added in

commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")

Specifically, the helpers for checking whether the results of a
multiplication overflowed (__unsigned_mul_overflow,
__signed_add_overflow) use the division operator when
!COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
operands on 32b hosts.

Also, because the macro is type agnostic, it is very difficult to write
a similarly type generic macro that dispatches to one of:
* div64_s64
* div64_u64
* div_s64
* div_u64

Raising the minimum supported versions allows us to remove all of the
fallback helpers for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW, instead
dispatching the compiler builtins.

arm64 has already raised the minimum supported GCC version to 5.1, do
this for all targets now. See the link below for the previous
discussion.

Link: https://lore.kernel.org/all/20210909182525.372ee687@canb.auug.org.au/
Link: https://lore.kernel.org/lkml/CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com/
Link: https://github.com/ClangBuiltLinux/linux/issues/1438
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/process/changes.rst | 2 +-
 scripts/min-tool-version.sh       | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index d3a8557b66a1..e35ab74a0f80 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -29,7 +29,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
-GNU C                  4.9              gcc --version
+GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  10.0.1           clang --version
 GNU make               3.81             make --version
 binutils               2.23             ld -v
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 319f92104f56..4edc708baa63 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -17,13 +17,7 @@ binutils)
 	echo 2.23.0
 	;;
 gcc)
-	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
-	# https://lore.kernel.org/r/20210107111841.GN1551@shell.armlinux.org.uk
-	if [ "$SRCARCH" = arm64 ]; then
-		echo 5.1.0
-	else
-		echo 4.9.0
-	fi
+	echo 5.1.0
 	;;
 icc)
 	# temporary
-- 
2.33.0.309.g3052b89438-goog

