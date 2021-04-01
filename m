Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED05F35237F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhDAXYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDAXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:23:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F340C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:23:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g15so2525664pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvZ4JPpQqHS2L+8HlT+daZ1S1BgsSu5178qEy4RCC4Y=;
        b=YZ2XpfpKoroyGz71W+msLoD8z0VD52kPmSJv459/I/wuG/2XcHz3JsBZ/c6p6L2Nn8
         8H5NsdPVJ6DSqLb594nllbPXtbErOCzCubBserjfdkJSKnhsSr95MVfacSGa+37MzJRK
         bF/Hk303mqASYIyN0wawBGfZ7oFpoTYBaqvCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvZ4JPpQqHS2L+8HlT+daZ1S1BgsSu5178qEy4RCC4Y=;
        b=DHgTKw6xbdUaM6aD55jPrC++r2aLWevc71luOGfHo5LiblK5shOYQQIVZFAgznWJXE
         StF7+nu8nWIkJextfrZew1KpNk7nNO5tbrFXv9W8qgz7v/jkjqhs97TQRYJL1wvfOPnq
         /LihG6FWQ5mT+APS1nlkmTnyVC/8TvPs0q59sF8YJKYoue8oyqwwFRWgDNnrm52unzJn
         nsDWj5MQHxYXUKrSQEyqaHAfiXFw/v3BR4ZiS411PPmtytaiHpINiWqgnF+GVOt0YSoi
         OT6KsK5AHSD30Xn10zuEVCVhEzSs87/AG272QfOKEmaGMmXX+14ZbRgAnXnH5SKiIIim
         snKA==
X-Gm-Message-State: AOAM531dDMKlCEcfvMMtKoQnhV8OPAgMZOzBMOMVaghH4zFl506zc0y9
        3GeC+Y5b/Kw7bcI/ul/uAcgcAg==
X-Google-Smtp-Source: ABdhPJxPVVyaaPVouPZCxZu9UN0Ld9Gm94Y/m3EFLAj4GgnjzyBntyxwYP5GLB2Jp9HjhO9Kt5fUBQ==
X-Received: by 2002:a05:6a00:22c8:b029:222:7cf7:7f5c with SMTP id f8-20020a056a0022c8b02902227cf77f5cmr9512290pfj.8.1617319431829;
        Thu, 01 Apr 2021 16:23:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm6265013pfa.68.2021.04.01.16.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 16:23:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/6] Optionally randomize kernel stack offset each syscall
Date:   Thu,  1 Apr 2021 16:23:41 -0700
Message-Id: <20210401232347.2791257-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should be good to go now. :)

v10:
- switch from "m" to "o" constraint (will)
- switch to raw_cpu_*() (tglx)
- hooked LKDTM test up to kselftest
v9: https://lore.kernel.org/lkml/20210331205458.1871746-1-keescook@chromium.org/
v8: https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/
v7: https://lore.kernel.org/lkml/20210319212835.3928492-1-keescook@chromium.org/
v6: https://lore.kernel.org/lkml/20210315180229.1224655-1-keescook@chromium.org/
v5: https://lore.kernel.org/lkml/20210309214301.678739-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200622193146.2985288-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200406231606.37619-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200324203231.64324-1-keescook@chromium.org/
rfc: https://lore.kernel.org/kernel-hardening/20190329081358.30497-1-elena.reshetova@intel.com/

This is a continuation and refactoring of Elena's earlier effort to add
kernel stack base offset randomization. In the time since the earlier
discussions, two attacks[1][2] were made public that depended on stack
determinism, so we're no longer in the position of "this is a good idea
but we have no examples of attacks". :)

Earlier discussions also devolved into debates on entropy sources, which
is mostly a red herring, given the already low entropy available due
to stack size. Regardless, entropy can be changed/improved separately
from this series as needed.

Earlier discussions also got stuck debating how much syscall overhead
was too much, but this is also a red herring since the feature itself
needs to be selectable at boot with no cost for those that don't want it:
this is solved here with static branches.

So, here is the latest improved version, made as arch-agnostic as
possible, with usage added for x86 and arm64. It also includes some small
static branch clean ups, and addresses some surprise performance issues
due to the stack canary[3].

Thanks!

-Kees

[1] https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[2] https://repositorio-aberto.up.pt/bitstream/10216/125357/2/374717.pdf
[3] https://lore.kernel.org/lkml/202003281520.A9BFF461@keescook/

Kees Cook (6):
  jump_label: Provide CONFIG-driven build state defaults
  init_on_alloc: Optimize static branches
  stack: Optionally randomize kernel stack offset each syscall
  x86/entry: Enable random_kstack_offset support
  arm64: entry: Enable random_kstack_offset support
  lkdtm: Add REPORT_STACK for checking stack offsets

 .../admin-guide/kernel-parameters.txt         | 11 ++++
 Makefile                                      |  4 ++
 arch/Kconfig                                  | 23 ++++++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/Makefile                    |  5 ++
 arch/arm64/kernel/syscall.c                   | 16 ++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/common.c                       |  3 ++
 arch/x86/include/asm/entry-common.h           | 16 ++++++
 drivers/misc/lkdtm/bugs.c                     | 17 ++++++
 drivers/misc/lkdtm/core.c                     |  1 +
 drivers/misc/lkdtm/lkdtm.h                    |  1 +
 include/linux/jump_label.h                    | 19 +++++++
 include/linux/mm.h                            | 10 ++--
 include/linux/randomize_kstack.h              | 54 +++++++++++++++++++
 init/main.c                                   | 23 ++++++++
 mm/page_alloc.c                               |  4 +-
 mm/slab.h                                     |  6 ++-
 tools/testing/selftests/lkdtm/.gitignore      |  1 +
 tools/testing/selftests/lkdtm/Makefile        |  1 +
 .../testing/selftests/lkdtm/stack-entropy.sh  | 36 +++++++++++++
 21 files changed, 245 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h
 create mode 100755 tools/testing/selftests/lkdtm/stack-entropy.sh

-- 
2.25.1

