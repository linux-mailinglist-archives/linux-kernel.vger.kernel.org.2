Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CA37ACDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhEKRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:17:24 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:16:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i8-20020a6548480000b02901fb8ebd5714so12733517pgs.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wrxaJJ4wLpCH56K58T42qTboLrClp3cmD5uAO6GdTRk=;
        b=l76qbi6P/SehrOCp1qoEGbmTbqEjj4eJr4tyEsEw5XLxrzDMoThXR04U+df2NUu/+Y
         E7aAXlcsZLelYuyCoWUXythfKFTbDP/kX9h1dxdNGe/X33qbmPybZLuNOdqwuSUOBXBL
         KeU12UlxGZRDTPCuc08B02zNsly3bT0CWAb9XTVPO83jzjHqSlJfSiGH8wkyUFtqVWIk
         pgZSRZvmJqy7V8YWbO3ipdnnq6G7OxQm5kPFpSVHOzEy77EhsKfa1PuIuad/oq0hTzYV
         XvEcCuuCtefkvI6sYc7KrrsLH1la38zf91sPNYEVUcGokifhJ9ukNA6KFqQLrmpT6OIT
         EX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wrxaJJ4wLpCH56K58T42qTboLrClp3cmD5uAO6GdTRk=;
        b=jH5wimAjuAbyharncydIOTWdUJVAKrO7eMIyCOoh+Wx21U/YB7TYLRoxvNYks5gKM2
         qovqp5lj4v9PkR65q2sxc3kLffOzN9Yc0HuNucE9DxdSnFbDUoFyqi4zXX89u0YNVhnY
         p55NIvZsa7Z3PhvKR2SpngnwhP3zwO/mfoygIGNNF8X/x3hkviLWiKjmtCof0DDc1wao
         UUMuDzlhqXhEZt/UqaQVimL8qpaO9QhCUEVQHlW6wCSrw3HvnA0sTyHD1RXtQqcI2uBW
         86YB6pJ7/klrFynG0HpvxmS+Niexg2HM521Y82MclBf39DW06cZP3JDVBanvHHsfmBF7
         l+DA==
X-Gm-Message-State: AOAM5323qVdfgEEX4NVvU/LRb7AYKY9q6/j+hbVIm7AMIoVF+p8+9+UX
        Tix4Qo1jQKpWajmgwT+1WuWAf0xiKUb4tf7+Z61saayR7/nSDBhzTVPW+hSYRikBfiZDdfzcP1+
        Esu92IuWcdf1QoAChEWtfFKHOhcJ4QTxcJ6/QSzzGpwXtKeRfquSNUduj7fM0jfpZef3dAKe5
X-Google-Smtp-Source: ABdhPJwVNckP1kFfI7u/oxNIHTRqrzbcv7RwGflHnvJz47IsbxuNA+DgWKVR71xplchbLOkK0r5aknV/aaeB
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:e050:3342:9ea6:6859])
 (user=bgardon job=sendgmr) by 2002:a62:dd90:0:b029:2bd:f232:16fa with SMTP id
 w138-20020a62dd900000b02902bdf23216famr12666445pff.54.1620753376110; Tue, 11
 May 2021 10:16:16 -0700 (PDT)
Date:   Tue, 11 May 2021 10:16:03 -0700
Message-Id: <20210511171610.170160-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v4 0/7] Lazily allocate memslot rmaps
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables KVM to save memory when using the TDP MMU by waiting
to allocate memslot rmaps until they are needed. To do this, KVM tracks
whether or not a shadow root has been allocated. In order to get away
with not allocating the rmaps, KVM must also be sure to skip operations
which iterate over the rmaps. If the TDP MMU is in use and we have not
allocated a shadow root, these operations would essentially be op-ops
anyway. Skipping the rmap operations has a secondary benefit of avoiding
acquiring the MMU lock in write mode in many cases, substantially
reducing MMU lock contention.

This series was tested on an Intel Skylake machine. With the TDP MMU off
and on, this introduced no new failures on kvm-unit-tests or KVM selftests.

Changelog:
v2:
	Incorporated feedback from Paolo and Sean
	Replaced the memslot_assignment_lock with slots_arch_lock, which
	has a larger critical section.

v3:
	Removed shadow_mmu_active as suggested by Sean
	Removed everything except adding a return value to
	kvm_mmu_init_tdp_mmu from patch 1 of v2
	Added RCU protection and better memory ordering for installing the
	memslot rmaps as suggested by Paolo
	Reordered most of the patches

v4:
	Renamed functions to allocate and free memslots based on feedback
	from David.
	Eliminated the goto in memslot_rmap_alloc, as David suggested.
	Eliminated kvm_memslots_have_rmaps and updated comments on uses of
	memslots_have_rmaps. Suggested by Paolo.
	Changed the description on patch 7 to one Paolo suggested.
	Collected Reviewed-by tags from David.
	Dropped the patch to add RCU notations to rmap accesses.

Ben Gardon (7):
  KVM: x86/mmu: Deduplicate rmap freeing
  KVM: x86/mmu: Factor out allocating memslot rmap
  KVM: mmu: Refactor memslot copy
  KVM: mmu: Add slots_arch_lock for memslot arch fields
  KVM: x86/mmu: Add a field to control memslot rmap allocation
  KVM: x86/mmu: Skip rmap operations if rmaps not allocated
  KVM: x86/mmu: Lazily allocate memslot rmaps

 arch/x86/include/asm/kvm_host.h |   8 ++
 arch/x86/kvm/mmu/mmu.c          | 153 +++++++++++++++++++++-----------
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              | 108 ++++++++++++++++++----
 include/linux/kvm_host.h        |   9 ++
 virt/kvm/kvm_main.c             |  54 ++++++++---
 7 files changed, 255 insertions(+), 87 deletions(-)

-- 
2.31.1.607.g51e8a6a459-goog

