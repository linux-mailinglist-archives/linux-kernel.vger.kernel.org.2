Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56233350893
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhCaUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhCaUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:55:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t140so129679pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bZ3bzKOfhPGnPGG60VssYCADe64CpCvkm0duGoaMAA=;
        b=iK6Dd1WzfTgZlYmEbgnA8JsN6ev91O3XgM9qgKS6kJCpEDzjxzvzwCL7RPAIIEpMPO
         m6g+Zrkan6Wwii54JTWoNBmrYZfJ1o2xcdda5yUzNDrzCoTAdDL5oMoveSYaiu0rppz9
         QW6uvmXPJPJYn+Oeme3ufD9LvkkfwQLu9XavI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bZ3bzKOfhPGnPGG60VssYCADe64CpCvkm0duGoaMAA=;
        b=etD8FU3g88UpqvnvVRPP5rGS5x0hXxcaQRUX/qJqV20fm8KTxZKEiiEZgA5D2SR3bz
         1snMkPCDUibJ/x/kS4vyXT5bhqdsGBqVmxqMs2FN1SQ1BRLpGoK9HbaeHCVAPRYyMwZ+
         ssYqoTU9ONztjgx2ktkOUb//iLFl3fGfHD6SClUr/SLoVvYFP0Lh3hFCw4LnAdj8sXc0
         HY23AlOvscQvUlO104Bnfn8GycIWnpuJg75WPsvNd+OWKSaN/h7HaRjmUBiTmZef0cvM
         9QEk19WKDbqnwcPp9q6IFkR0sPuANAjCLAZs8vpjwsQm3VJ1r+tfR5dGJVeU6c6Tfg0b
         bH3Q==
X-Gm-Message-State: AOAM530UcA1+RLsJl6IekieotkBtL35TU7n2tC3bHaug04kR5ie1Fd2W
        ZbN+VFGD8JsmaF6IKhxUCxb/mA==
X-Google-Smtp-Source: ABdhPJzUF8uhkl0raN0ODpiCdyJAh9H7iGlPFlGsUGF89srEBkCnpo3FL1QwTdlnzj6Suocxnxa0yg==
X-Received: by 2002:a63:af51:: with SMTP id s17mr4640944pgo.405.1617224103801;
        Wed, 31 Mar 2021 13:55:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v18sm4189804pgo.0.2021.03.31.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v9 0/6] Optionally randomize kernel stack offset each syscall
Date:   Wed, 31 Mar 2021 13:54:52 -0700
Message-Id: <20210331205458.1871746-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will (and Mark and Catalin),

Can you take this via the arm64 tree for v5.13 please? Thomas has added
his Reviewed-by, so it only leaves arm64's. :)


v9:
- comment position nit (tglx)
- Added tglx's Reviewed-by
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
 18 files changed, 207 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.25.1

