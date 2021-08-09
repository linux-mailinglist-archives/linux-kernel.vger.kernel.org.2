Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD63E489D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhHIPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhHIPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:12 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8ABC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:24:51 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k7-20020ad453c70000b02902f36ca6afdcso8289936qvv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sfgr1+pjxwO+6iSgebnByF44WjX6kRSHecCaxtQePZ0=;
        b=Xh2kqkwkFE567i2M7PGURzIq6o67p8a8DB6yI8XjMIyueExrM+HKhm+ixlYuCiVWS/
         EumxnwJJ+g6k52kHwJSRi+VRe6hnJ51TCPU7OQLFo+5aXOPS/h1+UCPmuSAJc1DcChA0
         hnQ+ceBk6rBjPvn0djNQajEUDYdAOJhL/4Xirk9E1Zr8Vg9l8k/pStrff+kUD0j9v8RV
         L9VTtxPPs+LjlDVNV+Ekprs4s0YgyKPI9LoUFNWX8OyDWFOuchS1Ej6/W8jQb5nRLyb3
         TdyUD9f77ySFL74U9yk+ZiE7V3wkNqY9pf9OmTyXLY4EYH2biilgza9uDl/nXIhhz8W4
         CpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sfgr1+pjxwO+6iSgebnByF44WjX6kRSHecCaxtQePZ0=;
        b=jO8oJqp1CPKXq35m+8xeFoc8Ee19ENkJOHrY7bSS9/k4CXb2M9o9i1SYYzGPnMq6Os
         vo3Cb3okHLnf5iWa/x7t4qsVN4AwVCXXK4Sl3G52qPd/kDERIEqMo6O/4RYVYrA8Cs/w
         HLBhalzT+BqdO7X6QtFhqXfIMHNrn09PzldQ5lxlldAnGmmhJFmqK1AgjHskxxjtKGim
         QlFhgNLMOMLJY0DAyLvtI/oa0KHv4fjsNqN1U7s5/Fj2ZuxOaGxV/SWdfTmlCw0YG3/+
         C4Ru2eQQIahKLlLVbcaDnYbC+XSlMgZionJGlenvlmUQ0rEBseq39Y1p/q/nJ8ul+9mg
         7G2Q==
X-Gm-Message-State: AOAM531BocDCtUwsooNCIfRidXdgayQw23n28jhxOG7m51wodU6VWEqJ
        ISjRTzkrF8NS6RZq/uoXTqymnhldWHlb
X-Google-Smtp-Source: ABdhPJzBn9yhlAu07QtSGQuwxOrZ5MMWw+8/mQ+Vs8NMKruwuhNqXHXVSdp7rqXkm+45IeSKyxkhlT+s0C/r
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:f0a:: with SMTP id
 gw10mr23729394qvb.27.1628522690786; Mon, 09 Aug 2021 08:24:50 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:27 +0100
Message-Id: <20210809152448.1810400-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 00/21] Track shared pages at EL2 in protected mode
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v4 of the patch series previously posted here:

https://lore.kernel.org/lkml/20210729132818.4091769-1-qperret@google.com/

This series aims to improve how the nVHE hypervisor tracks ownership of
memory pages when running in protected mode ("kvm-arm.mode=protected" on
the kernel command line).

The main issue with the existing ownership tracking code is that it is
completely binary: a page is either owned by an entity (e.g. the host)
or not. However, we'll need something smarter to track shared pages, as
is needed for virtio, or even just host/hypervisor communications.

This series introduces a few changes to the kvm page-table library to
allow annotating shared pages in ignored bits (a.k.a. software bits) of
leaf entries, and makes use of that infrastructure to track all pages
that are shared between the host and the hypervisor. We will obviously
want to apply the same treatment to guest stage-2 page-tables, but that
is not really possible to do until EL2 manages them directly, so I'll
keep that for another series.

The series is based on the 5.14-rc5, and has been tested on
AML-S905X-CC (Le Potato) and using various Qemu configurations.

Changes since v3
 - Fixed typos in comments / commit messages;
 - Various small cleanups and refactoring;
 - Rebased on 5.14-rc5.

Marc Zyngier (1):
  KVM: arm64: Introduce helper to retrieve a PTE and its level

Quentin Perret (19):
  KVM: arm64: Introduce hyp_assert_lock_held()
  KVM: arm64: Provide the host_stage2_try() helper macro
  KVM: arm64: Expose page-table helpers
  KVM: arm64: Optimize host memory aborts
  KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
  KVM: arm64: Don't overwrite software bits with owner id
  KVM: arm64: Tolerate re-creating hyp mappings to set software bits
  KVM: arm64: Enable forcing page-level stage-2 mappings
  KVM: arm64: Allow populating software bits
  KVM: arm64: Add helpers to tag shared pages in SW bits
  KVM: arm64: Expose host stage-2 manipulation helpers
  KVM: arm64: Expose pkvm_hyp_id
  KVM: arm64: Introduce addr_is_memory()
  KVM: arm64: Enable retrieving protections attributes of PTEs
  KVM: arm64: Mark host bss and rodata section as shared
  KVM: arm64: Remove __pkvm_mark_hyp
  KVM: arm64: Refactor protected nVHE stage-1 locking
  KVM: arm64: Restrict EL2 stage-1 changes in protected mode
  KVM: arm64: Make __pkvm_create_mappings static

Will Deacon (1):
  KVM: arm64: Add hyp_spin_is_locked() for basic locking assertions at
    EL2

 arch/arm64/include/asm/kvm_asm.h              |   5 +-
 arch/arm64/include/asm/kvm_pgtable.h          | 167 ++++++++----
 arch/arm64/kvm/Kconfig                        |   9 +
 arch/arm64/kvm/arm.c                          |  46 ----
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  33 ++-
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |   3 +-
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h    |  25 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  20 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 225 +++++++++++++---
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  22 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  82 +++++-
 arch/arm64/kvm/hyp/pgtable.c                  | 247 +++++++++---------
 arch/arm64/kvm/mmu.c                          |  28 +-
 13 files changed, 628 insertions(+), 284 deletions(-)

-- 
2.32.0.605.g8dce9f2422-goog

