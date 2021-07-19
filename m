Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FEB3CD2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhGSKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbhGSKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:02 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:36 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id x6-20020a7bc2060000b0290218ad9a8d4aso3813417wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6r6SQ5Sfe1ngDPnI/RzrWml59LLxArWehQBwowrYG0g=;
        b=TT8gWUbNyJACYMfSgAbkMfXL/hIgt2K4TeYX1798Z+RVovD7a9k8A+Ys5fdzbqZULc
         4B4P7CHpNEvod4gaq/gLeRGehtUvM3mqYd9uMnL6DvHv5ac9mTltH59uNuqNUJ6+FHMX
         6K7zECMso0T+Ls2KaIQrVCU5PlKH3Im0K9x845PYuGR0Nlijm9kVeTa9AlAEx7TlHy++
         FyexRWmDWWzgBlUDElyQiNQ2vKbRBh1YBi4tObrK7iEB5+Mq/UlRniB4sw1uIdHbZRAw
         uZ575TJO1dEKtWRybLGfWQSPoqEwTr4VkbdKWgYrBmrVd1j9JN+rBwgxonbrMZJ4fnJM
         80Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6r6SQ5Sfe1ngDPnI/RzrWml59LLxArWehQBwowrYG0g=;
        b=H+PgK2J7oxAHzimKqInnuyEdrrF/K67cpDGQQFA33UnwffF5ZA3c2ove0ULQsMVtu9
         64DLx9/aShjfYXtn6P1Z88zvSIZ+Skgk6BVy6CDdo6rJr4zHIyA36rf9RvGZaQ6Grheq
         XdfQee56/We2fNLjKTjwL4kjKz+e/ItiokMaUzRKB3hXluz7EKOfMmAEqST290Wtjlw8
         vQzdqmGLm4MDDWq7F2thHGuiLwUIU5SK3qJ/Kpcl9wfj3tk1D2qwdn7QRJflIqiUu6vh
         r9o8fgkmR7bPHNwpNUBv8/m8FUfqJiqs94kGs0TNaAyKzdbhk8tfjJYOxS6X54M3PmGz
         P1JQ==
X-Gm-Message-State: AOAM532T4ckv2vgpKtzmkKI+Pc7zCgLhyHWTqSu/VS1gIoL6l+PE4EKq
        +MH49WdCQg2BFKUCVjH3AbMPavk7dGD9
X-Google-Smtp-Source: ABdhPJyapMlzacXUANT8CGyWjaSfGRj8ZkKY3ZV1NxaiDQ/d+WmxKezlFsiAVAsdL+q2omGDMLjGV6nnVEbo
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a5d:6846:: with SMTP id
 o6mr29073942wrw.326.1626691660737; Mon, 19 Jul 2021 03:47:40 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:21 +0100
Message-Id: <20210719104735.3681732-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 00/14] Track shared pages at EL2 in protected mode
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series aims to improve how the nVHE hypervisor tracks ownership of memory
pages when running in protected mode ("kvm-arm.mode=protected" on the kernel
command line).

The main issue with the existing ownership tracking code is that it is
completely binary: a page is either owned by an entity (e.g. the host) or not.
However, we'll need something smarter to track shared pages, as is needed for
virtio, or even just host/hypervisor communications.

This series introduces a few changes to the kvm page-table library to allow
annotating shared pages in ignored bits (a.k.a. software bits) of leaf entries,
and makes use of that infrastructure to track all pages that are shared between
the host and the hypervisor. We will obviously want to apply the same treatment
to guest stage-2 page-tables, but that is not really possible to do until EL2
manages them directly, so I'll keep that for another series.

The series is split as follows:

 - patches 01-04 are essentially cleanups and optimizations of existing code
   paths that might be relevant on their own, but also prepare the ground for
   the rest of the series;

 - patches 05-08 introduce support in the page-table library for annotating
   shared pages with software bits;

 - patches 09-14 make use of the previously introduced infrastructure to
   annotate all pages shared between the host and the hypervisor;

The series is based on the latest kvmarm/fixes branch, and has been tested
on AML-S905X-CC (Le Potato) and using various Qemu configurations.

Thanks!
Quentin

Quentin Perret (14):
  KVM: arm64: Provide the host_stage2_try() helper macro
  KVM: arm64: Optimize kvm_pgtable_stage2_find_range()
  KVM: arm64: Continue stage-2 map when re-creating mappings
  KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
  KVM: arm64: Don't overwrite ignored bits with owner id
  KVM: arm64: Tolerate re-creating hyp mappings to set ignored bits
  KVM: arm64: Enable forcing page-level stage-2 mappings
  KVM: arm64: Add support for tagging shared pages in page-table
  KVM: arm64: Mark host bss and rodata section as shared
  KVM: arm64: Enable retrieving protections attributes of PTEs
  KVM: arm64: Expose kvm_pte_valid() helper
  KVM: arm64: Refactor pkvm_pgtable locking
  KVM: arm64: Restrict hyp stage-1 manipulation in protected mode
  KVM: arm64: Prevent late calls to __pkvm_create_private_mapping()

 arch/arm64/include/asm/kvm_asm.h              |   2 +-
 arch/arm64/include/asm/kvm_pgtable.h          | 109 ++++++---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   2 +
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |   3 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  17 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 156 +++++++++++--
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  20 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  52 ++++-
 arch/arm64/kvm/hyp/pgtable.c                  | 219 +++++++++++++-----
 arch/arm64/kvm/mmu.c                          |  14 +-
 10 files changed, 454 insertions(+), 140 deletions(-)

-- 
2.32.0.402.g57bb445576-goog

