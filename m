Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB26422AA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhJEORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhJEOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:16:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF4C061760
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:14:06 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i3-20020aa79083000000b003efb4fd360dso8141368pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SDsJgC6yRUYCiS38hXuTRfkxBXO2Typ8HW1RqnSDwgU=;
        b=WeZkwfK6oBSxs/O/acgLPndgpCiFPCqd4RXHGlMyqTy0KCNAgjQIOFHL1HHsn5GKG8
         F6L3/f5shsb/QdXjg22u39OY9tRhTOl6TgwBnJnWyzYPMdkxJrZn6r9zhXnamfzYF61U
         k1bpJJkJ0IglQ0M93cIay60PqMgDxk0abkZLyqtBpAbTOsDKOFqgFBwDimxGj1qofayn
         GHmYtuDVmc4jwjZDjmzkC22clpPR4u/mpOsOLZOvuDOG8fhiYSIXlGMZ3Z0afMpC3LXz
         xS+g83DJUtbIyoDP13E/PXSakvBhBxbAYvrJxkMYnqbiI3nl0D45aU0K5tgAfMG4UhbT
         0YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SDsJgC6yRUYCiS38hXuTRfkxBXO2Typ8HW1RqnSDwgU=;
        b=KeL4zDoD6g2uVeeD3xRHCh1dKw30860c4scr4BWKylEOSjEg99EFIanAs04ZNk9egF
         Hob2QjKSRTDs+dY5T6JBHTH0UsYp6Nj5vVkNY5mWlj9nL20yYqAe8Vzae/XZkP5pifod
         fpUKk1B7iBU+p7jlERULBTVyKrJ7zT1H5+B8kLcpzSywm0OSpfmQUUJf1cWyFSqIsGj0
         UwHUt9coM0MVRt9y5+hcMPUIzEOEniDdq/4+nPrBwdj5iD0nqOEryOkHToVfM+WbPyW8
         bCwaLn2hw4qLsRkND5FW1l8GZWSQdQD4s9z+2O4iB3fiSXR69m29blEfUabWyPbuTkXd
         Q0jA==
X-Gm-Message-State: AOAM530AtgEjKIgScQAT6fg4P3cePZl9yyHUnNUqAPa8hl8JqrPUZ4oC
        LPWRxuatE+4pFMm/Gyg0uKf0hstFavU=
X-Google-Smtp-Source: ABdhPJxp3f2LEh/Ngwm+g/yVc6YFHOxhCbCFvf0n1krzrBVPEjf41LVRHVe2KU6kpU35sedmYiHallV2ULM=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:225f:7216:6111:7f1c])
 (user=pgonda job=sendgmr) by 2002:a17:90a:7892:: with SMTP id
 x18mr4058151pjk.33.1633443246156; Tue, 05 Oct 2021 07:14:06 -0700 (PDT)
Date:   Tue,  5 Oct 2021 07:13:53 -0700
Message-Id: <20211005141357.2393627-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH 0/4 V9] Add AMD SEV and SEV-ES intra host migration support
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intra host migration provides a low-cost mechanism for userspace VMM
upgrades.  It is an alternative to traditional (i.e., remote) live
migration. Whereas remote migration handles moving a guest to a new host,
intra host migration only handles moving a guest to a new userspace VMM
within a host.  This can be used to update, rollback, change flags of the
VMM, etc. The lower cost compared to live migration comes from the fact
that the guest's memory does not need to be copied between processes. A
handle to the guest memory simply gets passed to the new VMM, this could
be done via /dev/shm with share=on or similar feature.

The guest state can be transferred from an old VMM to a new VMM as follows:
1. Export guest state from KVM to the old user-space VMM via a getter
user-space/kernel API 2. Transfer guest state from old VMM to new VMM via
IPC communication 3. Import guest state into KVM from the new user-space
VMM via a setter user-space/kernel API VMMs by exporting from KVM using
getters, sending that data to the new VMM, then setting it again in KVM.

In the common case for intra host migration, we can rely on the normal
ioctls for passing data from one VMM to the next. SEV, SEV-ES, and other
confidential compute environments make most of this information opaque, and
render KVM ioctls such as "KVM_GET_REGS" irrelevant.  As a result, we need
the ability to pass this opaque metadata from one VMM to the next. The
easiest way to do this is to leave this data in the kernel, and transfer
ownership of the metadata from one KVM VM (or vCPU) to the next. For
example, we need to move the SEV enabled ASID, VMSAs, and GHCB metadata
from one VMM to the next.  In general, we need to be able to hand off any
data that would be unsafe/impossible for the kernel to hand directly to
userspace (and cannot be reproduced using data that can be handed safely to
userspace).

V9
 * Fix sev_lock_vcpus_for_migration from unlocking the vCPU mutex it
   failed to unlock.

V8
 * Update to require that @dst is not SEV or SEV-ES enabled.
 * Address selftest feedback.

V7
 * Address selftest feedback.

V6
 * Add selftest.

V5:
 * Fix up locking scheme
 * Address marcorr@ comments.

V4:
 * Move to seanjc@'s suggestion of source VM FD based single ioctl design.

v3:
 * Fix memory leak found by dan.carpenter@

v2:
 * Added marcorr@ reviewed by tag
 * Renamed function introduced in 1/3
 * Edited with seanjc@'s review comments
 ** Cleaned up WARN usage
 ** Userspace makes random token now
 * Edited with brijesh.singh@'s review comments
 ** Checks for different LAUNCH_* states in send function

v1: https://lore.kernel.org/kvm/20210621163118.1040170-1-pgonda@google.com/

base-commit: 680c7e3be6a3

Cc: Marc Orr <marcorr@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Peter Gonda (4):
  KVM: SEV: Add support for SEV intra host migration
  KVM: SEV: Add support for SEV-ES intra host migration
  selftest: KVM: Add open sev dev helper
  selftest: KVM: Add intra host migration tests

 Documentation/virt/kvm/api.rst                |  15 ++
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/svm/sev.c                        | 187 ++++++++++++++++
 arch/x86/kvm/svm/svm.c                        |   1 +
 arch/x86/kvm/svm/svm.h                        |   2 +
 arch/x86/kvm/x86.c                            |   6 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../selftests/kvm/include/x86_64/svm_util.h   |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  24 ++-
 tools/testing/selftests/kvm/lib/x86_64/svm.c  |  13 ++
 .../selftests/kvm/x86_64/sev_vm_tests.c       | 203 ++++++++++++++++++
 13 files changed, 447 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_vm_tests.c

-- 
2.33.0.309.g3052b89438-goog

