Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007E036F1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbhD2VTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhD2VTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:19:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DFC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:18:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x186-20020a25e0c30000b02904f0d007a955so5969678ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5NDzCDKCGCk6XFMagA6CzP44uT46tOEAvw4LLjGAeOA=;
        b=rsK1XDnr5jWG+rKZO/5mZTxX0XfQb3/H8ivcRXIm8gWzPRbayNlE2dbGbIR2G21tnP
         CjdzicccsKnXkgCxrKknP2hlgTb2OvTbwkjMYfsSoG41gsJ6+v4Ot2toYnKn6Tu48ua8
         YwBI7l6OYQKS4jyWdgj7zcEY1jk2KSRxCUfOAgQy4rmguySN0O28l7NAS8qKBcGukhpy
         EtuKxQnFHjmTeMhFTjMMS2enzygdfISkubtywX1Kwnm+iL/fLlYd25Ylo69pqwXLbfi3
         yHJLPy9wsIxUHVlV1GqJUe4sJA8EuEsU3wgJy4AlznwRc1IjXxZrPO2GuumB9IhoMUnr
         XR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5NDzCDKCGCk6XFMagA6CzP44uT46tOEAvw4LLjGAeOA=;
        b=SGbu6+pT4Z2kJ10nC5mD0HLTuHYY/QXgZIKkx62Ge0H02vy9dz32YGUWE2ANh4O9ef
         Pzi/qfn+eDFne1SzuNRuIeMWw0c17SOOci7jp2dMhq2FRHvlBbgFG1xe8yN9RL2qPOdC
         IXyl8VlHP8M7zhqfskSs96TzUvFiIee5Qq5VFJ1UX+e5N25YWN2GYyHA3Y2ICUXzh2zB
         XUygcq/EcoKST2ddlwINxWO5UC8AVZ+CM0C6I1gL5J/gh26zb6yCFLwP8NwbOsssatxR
         sO+UKS5vBHLfet+CtRPwXInvO50zhCHK7eGErlj3dbTB8xAmDhwoVnyTTfK8R74ZB7v3
         Y08w==
X-Gm-Message-State: AOAM530hDwmHXUF3s059oad7crGoakynzAIY1GSL4+NhesyOro3E/Bra
        1TiwBegIsDLxE2XepICcE5+Dgki4/joSEseFVDI9VoNUj27/OmeJVQ3kU3dt5GKjX/WhFeom/kk
        Ah1gF0TPOdq8mAouIqR4Nyx8lxk71xpdSJ7Vnfsz4B3QnYxCun6JX3uwvO324hVH2G8yzHWgo
X-Google-Smtp-Source: ABdhPJzMnmNUqhweoATHShUFOm2WiU0N4e30hQvigpqsUZJG3TEf8qs9lU0gYxxmgEWAVvG1Ltgqrz6ePbmj
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:1a18:9719:a02:56fb])
 (user=bgardon job=sendgmr) by 2002:a5b:611:: with SMTP id d17mr2257989ybq.421.1619731126562;
 Thu, 29 Apr 2021 14:18:46 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:18:26 -0700
Message-Id: <20210429211833.3361994-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 0/7] Lazily allocate memslot rmaps
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

Changelog:
v2:
	Incorporated feedback from Paolo and Sean
	Replaced the memslot_assignment_lock with slots_arch_lock, which
	has a larger critical section.

Ben Gardon (7):
  KVM: x86/mmu: Track if shadow MMU active
  KVM: x86/mmu: Skip rmap operations if shadow MMU inactive
  KVM: x86/mmu: Deduplicate rmap freeing
  KVM: x86/mmu: Factor out allocating memslot rmap
  KVM: mmu: Refactor memslot copy
  KVM: mmu: Add slots_arch_lock for memslot arch fields
  KVM: x86/mmu: Lazily allocate memslot rmaps

 arch/x86/include/asm/kvm_host.h |  13 +++
 arch/x86/kvm/mmu/mmu.c          | 153 +++++++++++++++++++++-----------
 arch/x86/kvm/mmu/mmu_internal.h |   2 +
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              | 110 +++++++++++++++++++----
 include/linux/kvm_host.h        |   9 ++
 virt/kvm/kvm_main.c             |  54 ++++++++---
 8 files changed, 264 insertions(+), 87 deletions(-)

-- 
2.31.1.527.g47e6f16901-goog

