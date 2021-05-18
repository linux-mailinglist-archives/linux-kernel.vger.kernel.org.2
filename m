Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE4387E71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351171AbhERRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346560AbhERRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:35:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2FC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:34:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d64-20020a6368430000b02902104a07607cso6761563pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DXZ5TJfbcJBrlmnD1QhFY5JORCd7o8ZDmjjRDdrnQQ4=;
        b=fITe5PKZVFB3hTUkaiMHz50JHcFawCTY/nRNzHlm4ICLkX/hPhHQGjnvGFXfrAP9FT
         PnSzzhxOGBWcUCFTClTphe4IU48lVMM4UlBFsDN3PzKwWMfFUi7fwlcAjUPT/xfdNv3y
         sqgYDyBZJX5vOyk9mCL2FF0gMZi34YQ0a6X2IoZBfz62LdY0pm87i0C0s3I7kh2lQ5P/
         8F1Mt7UbdEN3uI2tQ5Hu6YzMYk+h0q//e6o1NM+lEykfGgnxXncz5ZQNaxXEh0BTJlZb
         GkdmtLjSUkQTwHlKsaSMn/yu+CXcgJEXeam7WlbRcu8N840lbh/YT0tifYtJBU3GJnMk
         Cu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DXZ5TJfbcJBrlmnD1QhFY5JORCd7o8ZDmjjRDdrnQQ4=;
        b=k/JfANCxpy432vYKGlrBze3NEHP78E+SstmGV8Sfh4a0U+DJQ/F0RzU1pgAJzcCWSx
         WZ2dUDxroRZtCinxKBxXbX1g9cZFtIFSGLu+C8i/RAtZXe0bi20dyRQWd/qdMCk55Wmm
         FfWtj4W3MLwcal/p2akkSa08/7nrGNGl2jdCfdhq3fnPzPvZWj2wp0uyj28yTpMsCtC7
         hu9siICLVVqIM+DMF+nqDktMT27wsCv2/xdvsTfBE8gRaK0f+F+pGWT7HQlFkr5Xpehh
         a3i3TNk5rnG5iAm0ZhR7PeVlFCcyv57+BdTkO2Inanx44wqZI5t7aWMPX6L2qzYrHynJ
         S7vA==
X-Gm-Message-State: AOAM530aY4NKZ6etYVVQD8LLeLPCPfpYZJtc4SGo1KcHTqdteG90ZdQ3
        GdVq7lng0f12nCV93x5+QqhsAKp7ZL32DNnQBWGFympB9DJ4hhfho4ILKVuh94dZq6MH+BjuTvo
        zuXGelvpPkhuxxmPefdjBn4dNLWe8taupYSaqnCNi1KieHH2qtU6TdBqgsL8oYEbzuJqm8HsW
X-Google-Smtp-Source: ABdhPJxH/9tG/t86LHHAa4/hAgCVq/qgoHyGjHoR5nIyyfVZPiukffsaMKMgU4PaB8wt5NJZXBdDg7nHZ4uJ
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2715:2de:868e:9db7])
 (user=bgardon job=sendgmr) by 2002:a17:90a:4487:: with SMTP id
 t7mr611698pjg.1.1621359257711; Tue, 18 May 2021 10:34:17 -0700 (PDT)
Date:   Tue, 18 May 2021 10:34:07 -0700
Message-Id: <20210518173414.450044-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v5 0/7] Lazily allocate memslot rmaps
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

v5:
	Responding to comments from Sean.
	Improved comments
	Swapped args to kvm_copy_memslots to match memcpy
	Fixed some line wrap and declaration style issues
	No longer check if memslots have rmaps before operations which
	iterate through active_mmu_pages
	Re-added the kvm_memslots_have_rmaps helper
	Fixed a couple missing unlocks for the slots_arch_lock

Ben Gardon (7):
  KVM: x86/mmu: Deduplicate rmap freeing
  KVM: x86/mmu: Factor out allocating memslot rmap
  KVM: mmu: Refactor memslot copy
  KVM: mmu: Add slots_arch_lock for memslot arch fields
  KVM: x86/mmu: Add a field to control memslot rmap allocation
  KVM: x86/mmu: Skip rmap operations if rmaps not allocated
  KVM: x86/mmu: Lazily allocate memslot rmaps

 arch/x86/include/asm/kvm_host.h |   8 ++
 arch/x86/kvm/mmu.h              |  10 +++
 arch/x86/kvm/mmu/mmu.c          | 125 ++++++++++++++++++++------------
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              | 109 +++++++++++++++++++++++-----
 include/linux/kvm_host.h        |   9 +++
 virt/kvm/kvm_main.c             |  77 ++++++++++++++++----
 8 files changed, 263 insertions(+), 85 deletions(-)

-- 
2.31.1.751.gd2f1c929bd-goog

