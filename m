Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086736DFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhD1TjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbhD1Ti4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:38:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A45C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:38:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y5-20020a2586050000b02904ee36d3b170so6457611ybk.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6lY0wVxKSFoGmS9bVqfbfPkbINkSpYIK0/Bfq4EeuDU=;
        b=UHp/r+M7gHphcpiU1e7jr9u5gX7d0CIPQhlJzPJs034WaUGDGPnQ5PWWpQjxogK9jR
         gRV2eCkUHTvUiuwFj08bK1QVFGzZKdIm/cxyZeoimqYttKlPB2BbBvam4admXBTXw7Cb
         N8/u+1A+HNsv8z7rqATlxasT/vEyQqwmg0wKHPT0GOaXCpjifjz7BPfscAqXv0tPFgkY
         DdXDtrSOsQgTbIzh9Nb9bn53/ZG8gorrB0YoK08kKJBz/uGhw/BOD1AhCuRHyDa4R8jt
         kiNi7SB6DEdr6n/oVZ7YoxoMni0C7Zl9c5/nmXuzpoWJ7mlUeetO7QM5xKNMYbgB8f+D
         rZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6lY0wVxKSFoGmS9bVqfbfPkbINkSpYIK0/Bfq4EeuDU=;
        b=JHzSR3Po8ZaJB8OaHJ8PoRxIxSjtWRDvIHGSR+mXI3/cTnY3sQy8Ovvx/GxdcePwKi
         eeU1muAKkKYckwOglxVzfxtmZmEnb/ruEN35GpPOB0veQSHugvlhc0gV1Icf+Xw118x5
         8Ib4a3ohc852xkoAZ4nGGHs2Io5dzN/OYk5lR/0qjV7+v9pDp08qR0lamugAe9TNzFVn
         xiJ6fmVfcHlxDJ3rYV6+EF+GrxSHxKZ6gf7kvNjL9sUa6q/o43re/2RM2hSgpOxJNtsg
         y/9fu+StBy6HTVOtmwWW2NFT77Im3SFCQ9y7vwBJCxakxY1xJNhElKxDB+20e2FTUnrf
         BH1g==
X-Gm-Message-State: AOAM533eMq9bWXbmamfmOYtYPceQJy36J9fsbI6RcNH93f0j/3jKFqQB
        zfzGtvtYtmZrpOgbX1PglRpjGdzqhoFOvQ==
X-Google-Smtp-Source: ABdhPJwBsfmNpvwW8rlmlnImBF6/Yn0bEE8RY/muQwjlhKwnzdbXRK8OsoZ5gVqEj7Y4ZZ66XeKQEI7IUq38XA==
X-Received: from ricarkol2.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a25:99c1:: with SMTP id
 q1mr40283071ybo.517.1619638681487; Wed, 28 Apr 2021 12:38:01 -0700 (PDT)
Date:   Wed, 28 Apr 2021 12:37:50 -0700
Message-Id: <20210428193756.2110517-1-ricarkol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 0/6] KVM: x86: Use kernel x86 cpuid utilities in KVM selftests
From:   Ricardo Koller <ricarkol@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has a set of utilities and definitions to deal with x86 cpu
features.  The x86 KVM selftests don't use them, and instead have
evolved to use differing and ad-hoc methods for checking features. The
advantage of the kernel feature definitions is that they use a format
that embeds the info needed to extract them from cpuid (function, index,
and register to use).

Patches 1 and 2 add a script for checking that kernel headers don't
drift from their original copies. Patches 3 and 4 massage the related
cpuid header files in the kernel side, then copy them into tools/ so
they can be included by selftests.  The last 2 patches replace the tests
checking for cpu features to use the definitions and utilities
introduced from the kernel.

Tested the arch/x86 patches by building these combinations:
  ARCH=i386 allmodconfig
  ARCH=i386 allyesconfig
  ARCH=x86_64 allyesconfig
  ARCH=x86_64 allmodconfig
  ARCH=um alldefconfig
  ARCH=i386 alldefconfig
and the selftest changes on both x86 and arm64.

Thanks,
Ricardo

v2:
- Add script to check for kernel headers drift in tools
- Sync header that is currently failing the check
- Move header copies under tools/testing/selftests/kvm/include/x86
  instead of tools/arch/x86/include
v1: https://lore.kernel.org/kvm/20210422005626.564163-1-ricarkol@google.com

Ricardo Koller (6):
  KVM: selftests: Add kernel headers sync check
  tools headers x86: Update bitsperlong.h in tools
  x86/cpu: Expose CPUID regs, leaf and index definitions to tools
  tools headers x86: Copy cpuid helpers from the kernel
  KVM: selftests: Introduce utilities for checking x86 features
  KVM: selftests: Use kernel x86 cpuid features format

 arch/x86/events/intel/pt.c                    |   1 +
 arch/x86/include/asm/cpufeature.h             |  23 +-
 arch/x86/include/asm/processor.h              |  11 -
 arch/x86/kernel/cpu/scattered.c               |   2 +-
 arch/x86/kernel/cpuid.c                       |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   3 +
 tools/include/uapi/asm-generic/bitsperlong.h  |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 tools/testing/selftests/kvm/check-headers.sh  |  64 +++++
 .../kvm/include/x86_64/asm/cpufeature.h       | 257 ++++++++++++++++++
 .../selftests/kvm/include/x86_64/cpuid.h      |  61 +++++
 .../selftests/kvm/include/x86_64/processor.h  |  16 --
 .../kvm/include/x86_64/reverse_cpuid.h        | 185 +++++++++++++
 .../selftests/kvm/include/x86_64/svm_util.h   |  11 +-
 tools/testing/selftests/kvm/lib/x86_64/svm.c  |   6 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   5 +-
 tools/testing/selftests/kvm/steal_time.c      |   5 +-
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  23 +-
 .../selftests/kvm/x86_64/set_sregs_test.c     |  25 +-
 .../selftests/kvm/x86_64/vmx_pmu_msrs_test.c  |   8 +-
 .../kvm/x86_64/vmx_set_nested_state_test.c    |   5 +-
 .../selftests/kvm/x86_64/xss_msr_test.c       |  10 +-
 22 files changed, 630 insertions(+), 96 deletions(-)
 create mode 100755 tools/testing/selftests/kvm/check-headers.sh
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/asm/cpufeature.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/cpuid.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/reverse_cpuid.h

-- 
2.31.1.498.g6c1eba8ee3d-goog

