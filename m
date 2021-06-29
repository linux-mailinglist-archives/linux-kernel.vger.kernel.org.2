Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF313B7993
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhF2U5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhF2U5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:57:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27EEC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:55:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11so340986pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uR+oNqdNXCd0ydbXpC+e50tzxUKWaMRxr1XrQBOJgzg=;
        b=GKxg0E3ctyeYI1S26Htk9zOKzWMNEXaO/C1s8QInVi1mTh1JLWupC3zw0qnydqRnKY
         ALXKaMRbGL6MwyTrlDhlZjLZeZMapFKT2DURQxuA/tzvFAASHiLBiqxgn53diIS5mD5y
         o/V8ouSeowxnmWWsW1HFziZEQRfzWaU2rsvCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uR+oNqdNXCd0ydbXpC+e50tzxUKWaMRxr1XrQBOJgzg=;
        b=hKUlzDTmAn+uOMjr/ucGjrfesJusbWkyJm3Z+KqGuI8lgPRk6YS1/gIeBP3OVeqN43
         z91GQj0piSk6ykrOorCxbrMGUUA3/8ftNTvjgBOJ3WConsJpgvVMd4gBxw4LwkpBnHda
         mADg8ronjinU6HSUn+Eyh1c8l/IzsyMZLiWOGLX94yTDIZwitRyds00DzaiUUIeoZTEn
         lyLsu+kekAo4pg/ggFNU6i9Bx0prh+CbtZz1R6xTac7cLkHPQR3hI5+b7hXSbwpNFpmD
         lvy5U8Wh8VAqYg5FJ3AfnPuQvoW8VrDDs72NufdOF/GH7Z6ckkbQFVUwsbtuaPX1MDK3
         bakg==
X-Gm-Message-State: AOAM532rHAsycDAaDSWOW0mRciClkGFxAz4nj/C+n2buYT0WJWlzMF2R
        +Ze/9RomoE8CP0IgEIVibNoYYg==
X-Google-Smtp-Source: ABdhPJyXWCZwKyoZkos/DWtazxF2itd/3fJQSR85HluD3Vh7SKZivXmUbSk+09WCkDgeW4sXJ/ECzA==
X-Received: by 2002:a17:902:ea12:b029:128:977b:fa78 with SMTP id s18-20020a170902ea12b0290128977bfa78mr23327400plg.15.1625000122180;
        Tue, 29 Jun 2021 13:55:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r10sm9964324pff.7.2021.06.29.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:55:21 -0700 (PDT)
Date:   Tue, 29 Jun 2021 13:55:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] Clang feature updates for v5.14-rc1 (take 2)
Message-ID: <202106291354.CE55889CF4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these Clang feature updates for v5.14-rc1 (take 2). This is
everything except the big PGO portion from the original pull request
and includes an additional CFI fix that had gotten lost.

Thanks!

-Kees

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.14-rc1

for you to fetch changes up to fca41af18e10318e4de090db47d9fa7169e1bf2f:

  qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute (2021-06-29 13:25:20 -0700)

----------------------------------------------------------------
Clang feature updates for v5.14-rc1

- Add CC_HAS_NO_PROFILE_FN_ATTR in preparation for PGO support in
  the face of the noinstr attribute, paving the way for PGO and fixing
  GCOV. (Nick Desaulniers)

- x86_64 LTO coverage is expanded to 32-bit x86. (Nathan Chancellor)

- Small fixes to CFI. (Mark Rutland, Nathan Chancellor)

----------------------------------------------------------------
Mark Rutland (1):
      CFI: Move function_nocfi() into compiler.h

Nathan Chancellor (3):
      MAINTAINERS: Add Clang CFI section
      x86, lto: Enable Clang LTO for 32-bit as well
      qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute

Nick Desaulniers (3):
      compiler_attributes.h: define __no_profile, add to noinstr
      compiler_attributes.h: cleanups for GCC 4.9+
      Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR

 MAINTAINERS                         | 12 ++++++++++++
 arch/Kconfig                        |  7 +++++++
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/compiler.h   | 16 ++++++++++++++++
 arch/arm64/include/asm/memory.h     | 16 ----------------
 arch/s390/Kconfig                   |  1 +
 arch/x86/Kconfig                    |  5 +++--
 drivers/firmware/qemu_fw_cfg.c      |  8 +++-----
 include/linux/compiler.h            | 10 ++++++++++
 include/linux/compiler_attributes.h | 19 ++++++++++++++++---
 include/linux/compiler_types.h      |  2 +-
 include/linux/mm.h                  | 10 ----------
 init/Kconfig                        |  3 +++
 kernel/gcov/Kconfig                 |  1 +
 14 files changed, 74 insertions(+), 37 deletions(-)

-- 
Kees Cook
