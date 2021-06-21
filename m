Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72E53AF927
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhFUXVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhFUXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:21:12 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0BEC061760
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:18:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w1-20020ac87a610000b02902433332a0easo17033739qtt.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rjB5gl/OyQ1mYdw8idF1qN2FUIQyyWYhNBNVDiw+uvU=;
        b=Fx/5r3tL8gCFAJtd4rl2DAmVtq/Hcag/FqOXfbZTiumpQvK7IpCiwSoO4s2r3Pg4kG
         DjgqzwZbw38zdRoLWEIFqajlU0HyzgooEI43aq0nXoB3xcXQkKM3CW4mob90gDiP9WK2
         hHrDsQKAVpOhYF9U5V1S3QpzKlSx5rhNkESwPwwewApEl53L6IrVLx7uL19uIuHFuiOo
         6lolqnl8of8SHB6qJI16xb6wkcrAAnCL9U5ewHgz0C+f0vibak7dCVxmIJY/mPLRKbjo
         OXIV6b2Ew6sgl0PP+wDqL797jk1u3lvn2QWTbcBZRMFj+LYkj51nlwS6pHOjBj5NB8Kb
         CkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rjB5gl/OyQ1mYdw8idF1qN2FUIQyyWYhNBNVDiw+uvU=;
        b=PvCbrXdlzqJyK6sMPhFN/9dJ0SwL0yyCYW6k5a0e20YMPi5S+GxqJNSSUYp5i5bs9w
         Axmr02NvbS1yTe2/oIk0YX31ZZ3p7fhUKyfKEiCvtLIkmn5g6X+qifk3uJk8Vyy1IO5q
         1I1EiSe7+5CUfRBqF9edMUs0PDc572K0SrguwwrFrssQhwUCqdyGK8p0ndIwUGwWrEXr
         aLdS7iYhEyRg67S/9feiSUGsU3GRx71r9pM78H8aw5jZNCzUURgsm3e/HhIqZctkUxEl
         lDlXBRMELoAAhs7bTA8m2R8X7YqDSwyuNxSaJp2ncu0/OT12q7FJFEhAK/AIJvsx0BjF
         O7mg==
X-Gm-Message-State: AOAM531SbXdTZ0gHbGWtangYK9OnIywRjoOGw2L8qtkhNvnr7D62llNe
        TsUoYryq9bbnt6biGJNAhsBL7xwklmzqimHCVS8=
X-Google-Smtp-Source: ABdhPJyXTOipiZC/T1Rh2LGkpucm8jFtJ6//dT3xhNEPf1PixdbviPLfrtW8WqYG2ren4BZlrLSA6JcmNbcRdaRhqhk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:dfd:ebf9:4ec7:1783])
 (user=ndesaulniers job=sendgmr) by 2002:a25:aea4:: with SMTP id
 b36mr794382ybj.428.1624317536807; Mon, 21 Jun 2021 16:18:56 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:18:21 -0700
In-Reply-To: <20210621231822.2848305-1-ndesaulniers@google.com>
Message-Id: <20210621231822.2848305-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210621231822.2848305-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 2/3] compiler_attributes.h: cleanups for GCC 4.9+
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Martin Liska <mliska@suse.cz>, Marco Elver <elver@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Fangrui Song <maskray@google.com>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        johannes.berg@intel.com, linux-toolchains@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since
commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
we no longer support building the kernel with GCC 4.8; drop the
preprocess checks for __GNUC_MINOR__ version. It's implied that if
__GNUC_MAJOR__ is 4, then the only supported version of __GNUC_MINOR__
left is 9.

Cc: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler_attributes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 225511b17223..84b1c970acb3 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -27,7 +27,7 @@
  */
 #ifndef __has_attribute
 # define __has_attribute(x) __GCC4_has_attribute_##x
-# define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
+# define __GCC4_has_attribute___assume_aligned__      1
 # define __GCC4_has_attribute___copy__                0
 # define __GCC4_has_attribute___designated_init__     0
 # define __GCC4_has_attribute___externally_visible__  1
@@ -35,8 +35,8 @@
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___no_profile_instrument_function__ 0
 # define __GCC4_has_attribute___nonstring__           0
-# define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
-# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
+# define __GCC4_has_attribute___no_sanitize_address__ 1
+# define __GCC4_has_attribute___no_sanitize_undefined__ 1
 # define __GCC4_has_attribute___fallthrough__         0
 #endif
 
-- 
2.32.0.288.g62a8d224e6-goog

