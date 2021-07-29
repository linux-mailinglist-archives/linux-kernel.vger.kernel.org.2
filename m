Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6128B3DA417
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhG2N22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbhG2N21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:27 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D8BC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:23 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r14-20020a0c8d0e0000b02902e82df307f0so3932708qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uCsDvrfcUF+1HjCy/5u0lXgukkeSpeNSQPNFAPtE5Og=;
        b=TwUGuSD9qt0RaCZOS9MqYshAwbluPWeQnV47t4m6fl1LT4Bu8aMFJPgR4wel2mQ/0d
         VMq3hAK+GBdhK0pDqqszgH6EjWtt0g+gsttm5me4V/4bLlmdJtY8xDdSkXQhD2+kh7En
         APBRNllYpK/w+G4htTFazfyOkcJT2CNzdRflI8pGflgUvStmidwaEZJ1ISLDNIz8XHkE
         I8TAGDAGu8wQRDYBI3LsbMZm8DvGc5Yhi05TnDxDgHirqn7QwkGG9pUJKe1iAk3KJ5ST
         nrE4ll47uKL1HWghtXbFmGP9rQo/7u9BGNvZD5e4hpV4BN1enHUmTMlPD1rE19y/oH2I
         Rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uCsDvrfcUF+1HjCy/5u0lXgukkeSpeNSQPNFAPtE5Og=;
        b=SxpD7hxGtpT2VQgV9LrsTJVL4aBD6nTLQ7lUW6BU2dKxgCRNwMm16/0VgtuXqoL9A7
         zyci1iuZainzsTxSNSAbuYytd/bAv8172yr/6rZ50njiFqFPJfy4Hvf8xVuzUo/NfeZp
         RHE6atRQ4+nYxwHyI3kzgZ9nZuqe9VZqeAXcJyaRzPv5oT6vKNKgrS4BNnojmNcwSRjq
         X0b/SugOy5QXEsIuLDVNKc/c3FfwtbcToFctDYdvgAOS6fRtxE/Ux8yN1DhV8cj5wAhV
         MkvmWNh8FumyLgrjowCszLG+pXJd1NQX0niS49Z3XqDLiChAjwWvg4z8sEf/CRSSa2Qx
         /Ggw==
X-Gm-Message-State: AOAM531B9AQuPvglgor0BQPmv6LmfyI/2SmwrOouikL0C6eyZBSfbADx
        BPmDtO+BhFU0C+7N6Meg22SxLIXNWiKV
X-Google-Smtp-Source: ABdhPJwFLu6UzIEWRzj8e8yAxcsgzIxAgdeYD1x+wnn2xqD3UBVZS+HjIyhzCZDdD20gs2aUkHHEOqy6y/hY
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:27e7:: with SMTP id
 jt7mr5278007qvb.28.1627565302295; Thu, 29 Jul 2021 06:28:22 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:27:57 +0100
Message-Id: <20210729132818.4091769-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 00/21] Track shared pages at EL2 in protected mode
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

This is v3 of the patch series previously posted here:

https://lore.kernel.org/kvmarm/20210726092905.2198501-1-qperret@google.com/

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

The series is based on the kvmarm/fixes branch, and has been tested on
AML-S905X-CC (Le Potato) and using various Qemu configurations.

Changes since v2:
 - Renamed and refactored the find_range() path for host memory aborts;
 - Added hyp_assert_lock_held() using Will's hyp_spin_is_locked()
   helper, and sprinkled a few of them throughout the series;
 - Changed how host stage-2 mappings are adjusted after __pkvm_init() by
   walking the hyp stage-1 instead of relying on the host calling
   __pkvm_mark_hyp.

Changes since v1:
 - Changed the 'share' hypercall to accept a single page at a time;
 - Dropped the patch allowing to continue stage-2 map when hitting the
   EAGAIN case;
 - Dropped some of the custom pgtable walkers and used Marc's get_leaf()
   patch instead;
 - Changed pgtable API to manipulate SW bits directly rather than
   specifying shared pages;
 - Added comments and documentations all over;
 - Cleanups and small refactoring.

Thanks,
Quentin

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
 arch/arm64/include/asm/kvm_pgtable.h          | 166 ++++++++----
 arch/arm64/kvm/Kconfig                        |   9 +
 arch/arm64/kvm/arm.c                          |  46 ----
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  33 ++-
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |   3 +-
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h    |  25 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  20 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 221 ++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  22 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  82 +++++-
 arch/arm64/kvm/hyp/pgtable.c                  | 247 +++++++++---------
 arch/arm64/kvm/mmu.c                          |  28 +-
 13 files changed, 625 insertions(+), 282 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

