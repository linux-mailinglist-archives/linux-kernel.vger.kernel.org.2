Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8973375A46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhEFSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhEFSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:43:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCBC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 11:42:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o5-20020ac872c50000b02901c32e7e3c21so4162640qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sOvqNeuGyU/ZMmaxdOA2l2pA74nfx+pU9gEcCSqkRJU=;
        b=uoosXHvihKGjquSMLz/CYZMZ4tR+g+wYMy+PQ0C6KeO5KYBM56Yk/c//Vb8khLCpLa
         YCHBvNfyl8fH5jv4BySXf883bxjZ+cUiwAKJ1zfGhX8PIIuFYLGMwj52jIzhvNJwbrdG
         ctX1VXEfR5WjkdhcV0c1eKg/C6Y6xKdg5LtFepfs9Lx49Y5kn3+C6LKUY85fNB9EBNUI
         tZejepMkiSxcVdz5z3kRvFkJ0MgkNm40VBAr7pwUVoWYY16zBkswnXhIKMmIsWItYJkX
         YakB7IEn+bKpzh6aLKFM1KSAejHXtfO3bkROa587oG0OexgaEENARbJzHsBf91VwKuP8
         sppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sOvqNeuGyU/ZMmaxdOA2l2pA74nfx+pU9gEcCSqkRJU=;
        b=dauoxQCUKZm87wsBWfSpdxHakTHNt4gDRaKP0pwrO0NdTuRrjZne90QaGJnJ93D+jc
         wwbxnYb7C6tKttETRDxAhNcC1V6/acvlL2sVv+yt0GDXDALyTXY7ECPtCzNnNK9VN/lX
         69GkqZHXGoAphnH26/ztiMnnCnsMPppYp+gOMP2gwxnjSephkkceimQ/TjuLOQi4xOPG
         8Mr6mj6vQmY4bhZ3E1Y2IHKcuLM0F+apRtFhctYGdd5wTIr6TrJVldg+wabyuFyj2aXe
         h7fGvG0nUHsgj2ig6ZSTpRRX30qfAN+kmWX+JxMgfWWePrQKAIU/O0E6lElS5oMF8P3N
         y34g==
X-Gm-Message-State: AOAM532OE7xV5UKp4iuivuAtnJpsWleerf1hJKEIhB6cv1q7lBiscxUQ
        fvEJfwk2C2KbLfiW0zp5Gce9JMZGUoLn9pKaLoPP++AlfHm2ICsIDS/Ogl2/4NraTriTxO43pDw
        DIlU7Xa0emy4BPd/+RL1UK0mDTv9mZA7Yu0XWykzCnfOBzm1QgTTELT87nPoSjv0ORaF9gXeO
X-Google-Smtp-Source: ABdhPJwtioxMRraHZDM3/mQxHN62IsmMxoyEHNLt1azp+GP7XBXuMx1lN08IjxpvyrsToOHNvTb9HUS7kNjB
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9258:9474:54ca:4500])
 (user=bgardon job=sendgmr) by 2002:a05:6214:258d:: with SMTP id
 fq13mr6103004qvb.50.1620326565176; Thu, 06 May 2021 11:42:45 -0700 (PDT)
Date:   Thu,  6 May 2021 11:42:33 -0700
Message-Id: <20210506184241.618958-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 0/8] Lazily allocate memslot rmaps
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

Ben Gardon (8):
  KVM: x86/mmu: Deduplicate rmap freeing
  KVM: x86/mmu: Factor out allocating memslot rmap
  KVM: mmu: Refactor memslot copy
  KVM: mmu: Add slots_arch_lock for memslot arch fields
  KVM: x86/mmu: Add a field to control memslot rmap allocation
  KVM: x86/mmu: Skip rmap operations if rmaps not allocated
  KVM: x86/mmu: Protect rmaps independently with SRCU
  KVM: x86/mmu: Lazily allocate memslot rmaps

 arch/x86/include/asm/kvm_host.h |   9 ++
 arch/x86/kvm/mmu/mmu.c          | 195 ++++++++++++++++++++------------
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              | 107 ++++++++++++++----
 include/linux/kvm_host.h        |   9 ++
 virt/kvm/kvm_main.c             |  54 +++++++--
 7 files changed, 275 insertions(+), 109 deletions(-)

-- 
2.31.1.607.g51e8a6a459-goog

