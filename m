Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299E3AF125
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhFURBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhFURAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1CC0219B9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:31:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 4-20020a6315440000b029022154a87a57so12052184pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iiwJASZT/KKR/5QiXti53ciACJxa4B5DHzG+xVUiEiI=;
        b=Ks/jlvia4+TwiFRGP23POzXrYebGUUn59ja4qfTmP7rwd0FvICRsgWSL50bvz7P5+r
         nbbsMlQwiKKN2/49ZluOdwF46nsc+hFm/wGsuL03SSMo3IiB5njZHjcECFk73ag5Ajag
         cj7Ss3ReZsHz/DT9/VFAsOrREenAweo1txxK3MzFQLtukQCUiCOQC6ThhI13qw64wpKE
         KA6sv2E5hWoeP01KdX4GaCAqwsjbIj8fhiycs0oFsU/41RXbWhvIye7flXg6i+WQBZeB
         MjDTDHjAW9P3WWtzOS2NJAoGjGrQv0AxIa3QGQre7AjVPXAoan5n8dNsG2JFEBDv/son
         WttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iiwJASZT/KKR/5QiXti53ciACJxa4B5DHzG+xVUiEiI=;
        b=JFhlQqoJVQvHzAKKaycdCcQgW/pf0q2R0xBvcjqXP27/eNZIkZIjejQYZAivxpbdRZ
         tApeBN98w5yAsLwppgOGHiOZpeitkTHdN05lks/WMfxuVGiRcPIJe8uH+gMiBovFqbQE
         BGsqgc0bdK4lmHPeeHtvXiTp8viYvqxPGlhpuFDbAFqXBAvmQhyNO3anfygvHE4L9Cw4
         6rxjn+gBniZFur/zCOoH83ipR+YmXL05ck3H8VjjihQnqN/fljBf3YlLJfSVCVo3NSKh
         VVhcgRfgRClXV2dWr14xMR8fM3zVg/qH/DsM/SBxzA75Kgm3BWCOYBhwOpa6ohh6REfI
         4fkQ==
X-Gm-Message-State: AOAM533MLXaPxdyQ30LKnsvsrzMjKksSBMUIty1c611Mt/607zYreKhi
        njp6Cc/gEMIXbmb4DNioc5YxJonrN0s=
X-Google-Smtp-Source: ABdhPJyc/w1KS0cnwZyAxyeq2yMFYkTqwRQ/gJdvjC/7V3+OkMAOkNaJQZ3VwQGtyT6geVh4pNeVyVGH9rM=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:2742:338c:f077:6d85])
 (user=pgonda job=sendgmr) by 2002:a17:90b:94c:: with SMTP id
 dw12mr8783727pjb.18.1624293089161; Mon, 21 Jun 2021 09:31:29 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:31:15 -0700
Message-Id: <20210621163118.1040170-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 0/3] Add AMD SEV and SEV-ES local migration support
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
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

Local migration provides a low-cost mechanism for userspace VMM upgrades.
It is an alternative to traditional (i.e., remote) live migration. Whereas
remote migration handles move a guest to a new host, local migration only
handles moving a guest to a new userspace VMM within a host.  This can be
used to update, rollback, change flags of the VMM, etc. The lower cost
compared to live migration comes from the fact that the guest's memory does
not need to be copied between processes. A handle to the guest memory
simply gets passed to the new VMM, this could be done via using /dev/shm
with share=on or similar feature.

The guest state can be transferred from an old VMM to a new VMM as follows:
1. Export guest state from KVM to the old user-space VMM via a getter
user-space/kernel API 2. Transfer guest state from old VMM to new VMM via
IPC communication 3. Import guest state into KVM from the new user-space
VMM via a setter user-space/kernel API VMMs by exporting from KVM using
getters, sending that data to the new VMM, then setting it again in KVM.

In the common case for local migration, we can rely on the normal ioctls
for passing data from one VMM to the next. SEV, SEV-ES, and other
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

During the local send operation the SEV required metadata, the guest's
ASID is loaded into a kvm wide hashmap keyed by a value given by
userspace. This allows the userspace VMM to pass the key to the target
VMM. Then on local receive the target VMM can be loaded with the
metadata from the hashmap.

Peter Gonda (3):
  KVM, SEV: Refactor out function for unregistering encrypted regions
  KVM, SEV: Add support for SEV local migration
  KVM, SEV: Add support for SEV-ES local migration

 .../virt/kvm/amd-memory-encryption.rst        |  43 ++
 arch/x86/kvm/svm/sev.c                        | 434 +++++++++++++++++-
 arch/x86/kvm/svm/svm.h                        |   1 +
 include/uapi/linux/kvm.h                      |  12 +
 4 files changed, 471 insertions(+), 19 deletions(-)

base-commit: f1b832550832

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

-- 
2.32.0.288.g62a8d224e6-goog

