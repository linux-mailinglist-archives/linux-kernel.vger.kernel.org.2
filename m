Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C526D3A20F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhFIXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:45:50 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39476 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFIXpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:45:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id h12-20020ac8776c0000b02901f1228fdb1bso12508134qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=cf+PBcjDUxGIj9/295s6zdiSNXtJ4G7lf26HTPdRo1w=;
        b=mhkfykEavDETnLV1exgNtC8oTqdPqkz0tNNvjSdH5vzC1QNrtNBY7s5bz7cEGhE/0R
         6ejGo7I0eok6GJpWXeyfQrrX7s2VViTJswmrGlo46hXOEahmQ7JstM8n2SSUQrGfoPvh
         tM694Lwis3A/w/pc91jCupX6eX+LY3mdciUfXiYrozOQojBK1FU5pXpl0jp2RKqFU4LT
         mlHR9Omqc5n1geG4Y0+2dhlLQqjS7hmfE11GsABUTKGYTDd7o8eul/qz54VnwRQczImb
         Tzp0dylveVSaCrDxLQ4xJL7RiLnsfqCq3fwZf0IkwUFUe6ZehyoXtaF+P81f//aky7vw
         jD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=cf+PBcjDUxGIj9/295s6zdiSNXtJ4G7lf26HTPdRo1w=;
        b=H0clteVjbBR57jh1NOfTTDDgFokaYkGh/nvRUj0EfslqRgwpA1xDpQFgQILAWSPBQs
         pDmXj3OxFBNLTORedSUqqcu4lRC3z+g8NQwtBG6CVRkUH3jJGCd4sYtbu12lU1WZt9eV
         K8k9B/UtJ9x7IwDsbVPivWgcra06uIv48BKY2SaYCuCtzfhyM8jP0ZqaI2mqn7mnDgyb
         /3eigXCFdWdbRYbCtumfLrraKbzCMnIqUUV1SNW1MlhaHKXCf8RjqLjaBAym2WdduouW
         QWwqGBHSIzxvwaWK2opuEgc7TtBxmDtvXDHtSz41L/uEIr5A/8R2hEcW0bZVVImNzI6y
         LxYQ==
X-Gm-Message-State: AOAM533lLiOJXoQS1U7Soi5pCa6RFT/EZp7CzfSk6Kxtu4qOK+c43/gM
        +JokhJsdG18ihaBasYcoPmI091mdrgQ=
X-Google-Smtp-Source: ABdhPJzxktU7xI8kCHat1pp07oRXofxpQoacAe1AI2rYFxp4Kd55MFLRKm+bfhWImgiHJH0K4LEuOAoO2dQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:8daf:e5e:ae50:4f28])
 (user=seanjc job=sendgmr) by 2002:ad4:55ac:: with SMTP id f12mr2563463qvx.39.1623282162273;
 Wed, 09 Jun 2021 16:42:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 16:42:20 -0700
Message-Id: <20210609234235.1244004-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 00/15] KVM: x86/mmu: TLB fixes and related cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for two (very) theoretical TLB flushing bugs (patches 1 and 4),
and clean ups on top to (hopefully) consolidate and simplifiy the TLB
flushing logic.

The basic gist of the TLB flush and MMU sync code shuffling  is to stop
relying on the logic in __kvm_mmu_new_pgd() (but keep it for forced
flushing), and instead handle the flush+sync logic in the caller
independent from whether or not the "fast" switch occurs.

I spent a fair bit of time trying to shove the necessary logic down into
__kvm_mmu_new_pgd(), but it always ended up a complete mess because the
requirements and contextual information is always different.  The rules
for MOV CR3 are different from nVMX transitions (and those vary based on
EPT+VPID), and nSVM will be different still (once it adds proper TLB
handling).  In particular, I like that nVMX no longer has special code
for synchronizing the MMU when using shadowing paging and instead relies
on the common rules for TLB flushing.

Note, this series (indirectly) relies heavily on commit b53e84eed08b
("KVM: x86: Unload MMU on guest TLB flush if TDP disabled to force MMU
sync"), as it uses KVM_REQ_TLB_FLUSH_GUEST (was KVM_REQ_HV_TLB_FLUSH)
to do the TLB flush _and_ the MMU sync in non-PV code.

Tested all combinations for i386, EPT, NPT, and shadow paging. I think...

The EPTP switching and INVPCID single-context changes in particular lack
meaningful coverage in kvm-unit-tests+Linux.  Long term it's on my todo
list to remedy that, but realistically I doubt I'll get it done anytime
soon.

To test EPTP switching, I hacked L1 to set up a duplicate top-level EPT
table, copy the "real" table to the duplicate table on EPT violation,
populate VMFUNC.EPTP_LIST with the two EPTPs, expose  VMFUNC.EPTP_SWITCH
to L2.  I then hacked L2 to do an EPTP switch to a random (valid) EPTP
index on every task switch.

To test INVPCID single-context I modified L1 to iterate over all possible
PCIDs using INVPCID single-context in native_flush_tlb_global().  I also
verified that the guest crashed if it didn't do any INVPCID at all
(interestingly, the guest made it through boot without the flushes when
EPT was enabled, which implies the missing MMU sync on INVPCID was the
source of the crash, not a stale TLB entry).

Sean Christopherson (15):
  KVM: nVMX: Sync all PGDs on nested transition with shadow paging
  KVM: nVMX: Ensure 64-bit shift when checking VMFUNC bitmap
  KVM: nVMX: Don't clobber nested MMU's A/D status on EPTP switch
  KVM: x86: Invalidate all PGDs for the current PCID on MOV CR3 w/ flush
  KVM: x86: Uncondtionally skip MMU sync/TLB flush in MOV CR3's PGD
    switch
  KVM: nSVM: Move TLB flushing logic (or lack thereof) to dedicated
    helper
  KVM: x86: Drop skip MMU sync and TLB flush params from "new PGD"
    helpers
  KVM: nVMX: Consolidate VM-Enter/VM-Exit TLB flush and MMU sync logic
  KVM: nVMX: Free only guest_mode (L2) roots on INVVPID w/o EPT
  KVM: x86: Use KVM_REQ_TLB_FLUSH_GUEST to handle INVPCID(ALL) emulation
  KVM: nVMX: Use fast PGD switch when emulating VMFUNC[EPTP_SWITCH]
  KVM: x86: Defer MMU sync on PCID invalidation
  KVM: x86: Drop pointless @reset_roots from kvm_init_mmu()
  KVM: nVMX: WARN if subtly-impossible VMFUNC conditions occur
  KVM: nVMX: Drop redundant checks on vmcs12 in EPTP switching emulation

 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/hyperv.c           |   2 +-
 arch/x86/kvm/mmu.h              |   2 +-
 arch/x86/kvm/mmu/mmu.c          |  57 ++++++++-----
 arch/x86/kvm/svm/nested.c       |  40 ++++++---
 arch/x86/kvm/vmx/nested.c       | 139 ++++++++++++--------------------
 arch/x86/kvm/x86.c              |  75 ++++++++++-------
 7 files changed, 169 insertions(+), 152 deletions(-)

-- 
2.32.0.rc1.229.g3e70b5a671-goog

