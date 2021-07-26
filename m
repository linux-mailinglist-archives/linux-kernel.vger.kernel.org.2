Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF80F3D5681
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGZIsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhGZIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:44 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88911C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:12 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id o90-20020a5093e30000b02903bb95130460so1048879eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DCvP66qXTBgcdbjyYQwVaIHGbmeDnGwgmndjPCUFZv0=;
        b=LszyL0ac2kAjWuiZPWogQnvnhJe8WWxuAssQ2tOcCSO63Y+EpNy9srxlU7ETxbVzrL
         jsonb/tmICqfScnrKqzEL/v8OaT5iihwGykqbQrXqhuDK/KoyT05kQEkJ4gfuxm8uT7j
         /wrabJ7Jxqvl6MMAKROuFiCwv0wFJ9occQnnfhptzoDPo+r+B3Y5kM3YnLjY0QwHyqus
         o0xsGG19XNfNfD/0CnhjCwgUkyr+o9ob7e79XzMQazCTd9XpcKWiFBxx+h40mnAvon9b
         I+bghqZiBtUczZE4qs3TIgu+PJWesXlNkAl4m+wsv+rpDdItgjfW8vt2g4EwKpuOEHXU
         G3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DCvP66qXTBgcdbjyYQwVaIHGbmeDnGwgmndjPCUFZv0=;
        b=OrJ1zQkjOksD6qTYhN80R4TO+ldEDK1jn5Yiyby0YqluH7RKRX420l+ZMuP8gSTKZg
         WrvtBwC3QabVH53v07VdstlTzwPDd5FVB7tSnQTPTjvmoF8Sp2scO9TyVEw/7ShLbJKF
         UTrdn/FMrz9LXPzORHLD+BADV5xlNlqUgTzNy0M3aL4vaWyjjdmwe3b2WfLuIdiQ5Df+
         W8kMoj3wphBnLZy8B5ghh7RptgzD0VcjKTASD1zkmYInTK4bPBe6V3+SyMWqTUz8YLRT
         33+oMz0m44JBKDIVXuB9JsRjLeZ5ZjGxZ3jHm6WCBmQfnMAg5PO6uwo2ZW9F5H2UlygI
         v2bw==
X-Gm-Message-State: AOAM5337sjnIS7eszU20vBiwJG+5QY2Xb3+SHFNe6G5o4a9RJddA8MAt
        paxgoXFAsBUIydCdRspT6gQoIsVt5g3I
X-Google-Smtp-Source: ABdhPJzYf6PYxoyOLxQsDMRWgbQljCu/i20aLfGHMDpPArbaJdKVDGYqVf1Kcrk75PpRPPEhGP1AhJYC5bQR
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a17:906:b89a:: with SMTP id
 hb26mr16162211ejb.492.1627291750860; Mon, 26 Jul 2021 02:29:10 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:49 +0100
Message-Id: <20210726092905.2198501-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 00/16] Track shared pages at EL2 in protected mode
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

This is v2 of the patch series first posted here:

https://lore.kernel.org/kvmarm/20210719104735.3681732-1-qperret@google.com/

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

The series is based on the latest kvmarm/fixes branch, and has been
tested on AML-S905X-CC (Le Potato) and using various Qemu configurations.

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

Quentin Perret (15):
  KVM: arm64: Provide the host_stage2_try() helper macro
  KVM: arm64: Expose page-table helpers
  KVM: arm64: Optimize host memory aborts
  KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
  KVM: arm64: Don't overwrite software bits with owner id
  KVM: arm64: Tolerate re-creating hyp mappings to set software bits
  KVM: arm64: Enable forcing page-level stage-2 mappings
  KVM: arm64: Allow populating software bits
  KVM: arm64: Add helpers to tag shared pages in SW bits
  KVM: arm64: Introduce and export host_stage2_idmap_locked()
  KVM: arm64: Mark host bss and rodata section as shared
  KVM: arm64: Enable retrieving protections attributes of PTEs
  KVM: arm64: Refactor protected nVHE stage-1 locking
  KVM: arm64: Restrict EL2 stage-1 changes in protected mode
  KVM: arm64: Make __pkvm_create_mappings static

 arch/arm64/include/asm/kvm_asm.h              |   2 +-
 arch/arm64/include/asm/kvm_pgtable.h          | 153 ++++++++----
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  29 +++
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |   3 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  11 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 188 ++++++++++++--
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  21 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  52 +++-
 arch/arm64/kvm/hyp/pgtable.c                  | 234 ++++++++++--------
 arch/arm64/kvm/mmu.c                          |  28 ++-
 10 files changed, 525 insertions(+), 196 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

