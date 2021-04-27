Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4772A36CE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhD0Wh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhD0WhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:37:24 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E8C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:36:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y9-20020ae9f4090000b02902e4caf24229so3495051qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tTxyuPdn4rgY+Ver4IyXpo1lEOrhYEkf7++g5p9MMkg=;
        b=Em3n9hB7Hvpo19frVT+W+lf6YpZN5+Lr/0LqsFFv0gNvnZnCBzxm85s0fMMnF+6ztv
         NKgRvI3OiEknf83jl0j/hk084leCvhzoTUmE9ZrF/gymP1jb4V1UkbftHvSRYXenOpQz
         3Xg3YuF6ncGvV2eV2iUfGUECxCAnkHYkMCrmgkfCT81klWMmMVFOzQ+LSDHr9+9E0D4L
         CYpXFr3jJ9XUcovYwMVuaNobPazmLKJ0LwIbuHRlQ7+LH4yLe5Y8lKXzpd8nbtsTr8hD
         LRqSj7wVd8no/fUL/noDSo5qeP4INm6gbF8Xr4kp0LuBnnSUr09Jbcik3UTksPFUmrB3
         2BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tTxyuPdn4rgY+Ver4IyXpo1lEOrhYEkf7++g5p9MMkg=;
        b=KR48Ld9vLtYGSioAEWIexweeug80NfDv2XrlVei4BG8EdZMfILTBPjpBiTrmPfEI9W
         s2+nP1vKzwTtQiqEmEHkjb6q7sZeS0qhufRSNogonwP5luXoLvmBHS5Tu8H6y3XbcMz0
         8lPr/aGie1F6p+mkLNT4LKYXUftj58QBjFgCh3SxHVenmrnMcAuSYiJ4XgGOV/h4M6Vl
         oVQjW/k0miLrqvzIpH1aC0AgZAE6/hDoHgGNkBqW37H9poMkhMLiP3d6XKv0zBK73tX/
         gXj9Wj8cu/nPlDzdN2om6bUrRigyg1vlgeOr+UMSFQD9UGd7EErIr3xg3QXxYqFKa8db
         hKaA==
X-Gm-Message-State: AOAM533nHwvep1SsdvdnT5zcx0Yzwa38Oy8llwlN4lgIiSozzjgB8zVj
        IFhcIhfaHpoMsq11CW+RZDkqeBRb6jd5bvoiubug/Vzo9nRLDZqkEeDt628hiM8veXjuW4nFmHG
        SvpkJJosxQG/QjtPfSZgovWXW8VbC1ZQNFcWNm+dHp0afbWMh7UkbswqWXGGQL81YKHvCa7Jj
X-Google-Smtp-Source: ABdhPJyBV1BpEZC1fi84zDfcUk6+MVZdQs5cnGvWQPszmzv2+tAOFaBcUjcAEo/m2GY/QPZ2WqzP5avG/frm
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:d0b5:c590:c6b:bd9c])
 (user=bgardon job=sendgmr) by 2002:a05:6214:246a:: with SMTP id
 im10mr25700282qvb.7.1619562998354; Tue, 27 Apr 2021 15:36:38 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:36:29 -0700
Message-Id: <20210427223635.2711774-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 0/6] Lazily allocate memslot rmaps
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
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

Ben Gardon (6):
  KVM: x86/mmu: Track if shadow MMU active
  KVM: x86/mmu: Skip rmap operations if shadow MMU inactive
  KVM: x86/mmu: Deduplicate rmap freeing in allocate_memslot_rmap
  KVM: x86/mmu: Factor out allocating memslot rmap
  KVM: x86/mmu: Protect kvm->memslots with a mutex
  KVM: x86/mmu: Lazily allocate memslot rmaps

 arch/x86/include/asm/kvm_host.h |  20 +++++
 arch/x86/kvm/mmu/mmu.c          | 153 +++++++++++++++++++++-----------
 arch/x86/kvm/mmu/mmu_internal.h |   2 +
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              | 133 +++++++++++++++++++++++----
 include/linux/kvm_host.h        |   2 +
 virt/kvm/kvm_main.c             |  48 +++++++---
 8 files changed, 283 insertions(+), 85 deletions(-)

-- 
2.31.1.498.g6c1eba8ee3d-goog

