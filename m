Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09723257EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBYUso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhBYUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:48:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B9EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:47:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v62so7552492ybb.15
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=om9uFHT7e8jzZ23sZL9XQVqb3sS0Fv61rG18CUdoIp0=;
        b=QeFBPAKjT+YjPCo9JcaoxsSX9JFFup0lEG3jQCx5yJI1ixHMZCsadFJ/NNf5RDZz5A
         3mKCO7izGPoz+pC/V9koHNS9jPbCJQCsp3R4idXXfZ4KBQPQRvUHDcH22Z8e7RqxsdD0
         TQI/pp0NvGSnCCLn9mWzdHlNVLkF3HHETi//tjnTvJFK6j0JabIsycg/LWUS6cyx37Ap
         yobJgLs0cG95IiS0twVjcdhZJpNiPfr6m1Sab4is3JSIELkxd+OEM5HWo4KGhIgqqTPR
         2XI0oPfzWzBpDA3wozCD3CX6w16Rq2h+B1cu6BkOCBxWG6J2ix1io6JLiNjdPwQsd8VM
         4aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=om9uFHT7e8jzZ23sZL9XQVqb3sS0Fv61rG18CUdoIp0=;
        b=U0i4CpL1xv81MZzQLsr44ebLPiQWqx7C23LrLGbx0YjpSPNL5lQGAEPIkmJECH/AGj
         6byVE+PZ6HVyi11OXa3J4V9BQpzA/anIJVNfJD96grq8jbP5nXKuWXLZ71JSVodMkMTL
         FE13iFcuLxEv5RB1Z2ZF+MfIFJCLWW5oSaxU/xGQGpT+bGnqBh62BX6CYoWDmuZ6Jk3P
         2nyeU/ikgRhfhM4+IO4OSFODfRpiQqvGCHrJ2aDfm2DbDvfdFgYwDH1UF+bTGitaqanU
         3LiQRmDBRp/DEa9XMtiB8zuD86DYBuyA8ArEBOXPWVcW7jBHULY0apSODcwtJNLoSA4r
         o19g==
X-Gm-Message-State: AOAM532rXgdls2LwoH9hB49PGGM0MCTb7QEI9hGPRlIPCqj75RAbiQvu
        LSVDWQ29fr0hd4gUan33EpGgLAtUOgg=
X-Google-Smtp-Source: ABdhPJzl2CHRSfum3VVu3pLelkQeo1yBDsqs7I/L+wQrUIIse1Xh/RGmrEbBFSjoFD2ZghbqTRgUPLXJKpA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:1184:: with SMTP id 126mr6443848ybr.430.1614286077055;
 Thu, 25 Feb 2021 12:47:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:25 -0800
Message-Id: <20210225204749.1512652-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 00/24] KVM: x86/mmu: Introduce MMU_PRESENT and fix bugs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the simple idea of tagging shadow-present SPTEs with
a single bit, instead of looking for non-zero SPTEs that aren't MMIO and
aren't REMOVED.  Doing so reduces KVM's code footprint by 2k bytes on
x86-64, and presumably adds a tiny performance boost in related paths.

But, actually adding MMU_PRESENT without breaking one flow or another is
a bit of a debacle.  The main issue is that EPT doesn't have many low
available bits, and PAE doesn't have any high available bits.  And, the
existing MMU_WRITABLE and HOST_WRITABLE flags aren't optional, i.e. are
needed for all flavors of paging.  The solution I settled on is to let
make the *_WRITABLE bit configurable so that EPT can use high available
bits.

Of course, I forgot the above PAE restriction multiple times, and
journeyed down several dead ends.  The most notable failed idea was
using the AD_* masks in bits 52 and 53 to denote shadow-present SPTEs.
That would have been quite clever as it would provide the same benefits
without burning another available bit.

Along the many failed attempts, I collected a variety of bug fixes and
cleanups, mostly things found by inspection after doing a deep dive to
figure out what I broke.

Sean Christopherson (24):
  KVM: x86/mmu: Set SPTE_AD_WRPROT_ONLY_MASK if and only if PML is
    enabled
  KVM: x86/mmu: Check for shadow-present SPTE before querying A/D status
  KVM: x86/mmu: Bail from fast_page_fault() if SPTE is not
    shadow-present
  KVM: x86/mmu: Disable MMIO caching if MMIO value collides with L1TF
  KVM: x86/mmu: Retry page faults that hit an invalid memslot
  KVM: x86/mmu: Don't install bogus MMIO SPTEs if MMIO caching is
    disabled
  KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()
  KVM: x86/mmu: Drop redundant trace_kvm_mmu_set_spte() in the TDP MMU
  KVM: x86/mmu: Rename 'mask' to 'spte' in MMIO SPTE helpers
  KVM: x86/mmu: Stop using software available bits to denote MMIO SPTEs
  KVM: x86/mmu: Add module param to disable MMIO caching (for testing)
  KVM: x86/mmu: Rename and document A/D scheme for TDP SPTEs
  KVM: x86/mmu: Use MMIO SPTE bits 53 and 52 for the MMIO generation
  KVM: x86/mmu: Document dependency bewteen TDP A/D type and saved bits
  KVM: x86/mmu: Move initial kvm_mmu_set_mask_ptes() call into MMU
    proper
  KVM: x86/mmu: Co-locate code for setting various SPTE masks
  KVM: x86/mmu: Move logic for setting SPTE masks for EPT into the MMU
    proper
  KVM: x86/mmu: Make Host-writable and MMU-writable bit locations
    dynamic
  KVM: x86/mmu: Use high bits for host/mmu writable masks for EPT SPTEs
  KVM: x86/mmu: Use a dedicated bit to track shadow/MMU-present SPTEs
  KVM: x86/mmu: Tweak auditing WARN for A/D bits to !PRESENT (was MMIO)
  KVM: x86/mmu: Use is_removed_spte() instead of open coded equivalents
  KVM: x86/mmu: Use low available bits for removed SPTEs
  KVM: x86/mmu: Dump reserved bits if they're detected on non-MMIO SPTE

 Documentation/virt/kvm/locking.rst |  49 +++++----
 arch/x86/include/asm/kvm_host.h    |   3 -
 arch/x86/kvm/mmu.h                 |  15 +--
 arch/x86/kvm/mmu/mmu.c             |  87 +++++++---------
 arch/x86/kvm/mmu/mmu_internal.h    |  16 +--
 arch/x86/kvm/mmu/paging_tmpl.h     |   2 +-
 arch/x86/kvm/mmu/spte.c            | 157 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/spte.h            | 135 +++++++++++++++++--------
 arch/x86/kvm/mmu/tdp_mmu.c         |  22 ++--
 arch/x86/kvm/svm/svm.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  24 +----
 arch/x86/kvm/x86.c                 |   3 -
 12 files changed, 290 insertions(+), 225 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

