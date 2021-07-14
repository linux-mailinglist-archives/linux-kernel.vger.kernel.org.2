Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FAE3C8845
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhGNQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhGNQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:04:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B64C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:01:58 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x9-20020a6541490000b0290222fe6234d6so1960702pgp.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=36Omnbyd7/DKRdeKJAY3Yo0H0DXYFeJOYXFkJ9nO0PY=;
        b=bNaY5m0BNjTkrIa24jfGv5ZBzhSpdWHZnjwdQTOmK870VyWvISk6WpG8iprS31EDue
         upk28mQj2kaUubx9qY1I99MzOu3WaOt/gI/R5H7hZLdi2US8QxWdZ8TUTpwhbfjBveUf
         UVIK4lQnLDwNr/nIomjIsz1rHpiaOJO/mzmaRj6UOiQ2mUp2+2JhBiBLg/8S0BalAwHA
         X8/fMziV6hVBXzPZAGfgTVVFURjfbkvCq1TAw/zbS1v5avNdG5K5Fuw21JTbElKa7k8P
         md2dEuWugUvnK0i8I4S4UnG8VsUyVqOQxrAYFW2CuBaJWxjOJ6IYcYMh6gj9eWvtYw9I
         iBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=36Omnbyd7/DKRdeKJAY3Yo0H0DXYFeJOYXFkJ9nO0PY=;
        b=QGRwb48HnEgUM0wEY6GDsRwdoYc1BFNvHTWAoCMW+oxUix4Btgcftjzj0+WoFO/FxA
         UJvwKWF9AG0MCjIs4wTBG1HaDV8LAUF8jHu+IoCISx1IR1VLFssDl5y5csOoiOQvIedH
         204ABegWAOwUVRkhOmDb4vPD4EaYMbmg1sxQ/ZKuvnabK0qcNJB2wxWw9rgDeQF3umjP
         6pnQfA5IGk0VvLlKAM7NU91FPGI178IVX3A3wfr8bUNYpn03CC1fMb8531mOfmdWs59t
         +6Gb6dfvH9q/iofYfqEVSjgpypFk1He7Lnd3yvJIXVYaFC09MMY+k7mJivcWz89wPNqn
         9LbQ==
X-Gm-Message-State: AOAM5335Ld70Y0ffD+cp/xdtz01OGxoE7kiVREovWHiOOGLw322kCcFe
        3TuGd4PuN6jADHgxbFAHmMjrGwxdW2E=
X-Google-Smtp-Source: ABdhPJzYnFQVarUz/3jyy/DooiZ6xEAeyOR7C/uDYGDXITH8IplGRb69qQwH/GJRN4uO8N2lU9jDLSFB4oI=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:32d8:66d1:672:9aeb])
 (user=pgonda job=sendgmr) by 2002:a17:902:d4c9:b029:12b:46f3:2db2 with SMTP
 id o9-20020a170902d4c9b029012b46f32db2mr2240730plg.5.1626278517567; Wed, 14
 Jul 2021 09:01:57 -0700 (PDT)
Date:   Wed, 14 Jul 2021 09:01:40 -0700
Message-Id: <20210714160143.2116583-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 0/3 V2] Add AMD SEV and SEV-ES intra host migration support
From:   Peter Gonda <pgonda@google.com>
To:     pgonda@google.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intra host migration provides a low-cost mechanism for userspace VMM upgrades.
It is an alternative to traditional (i.e., remote) live migration. Whereas
remote migration handles move a guest to a new host, intra host migration only
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

In the common case for intra host migration, we can rely on the normal ioctls
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

During the intra host send operation the SEV required metadata, the guest's
ASID is loaded into a kvm wide hashmap keyed by a value given by
userspace. This allows the userspace VMM to pass the key to the target
VMM. Then on intra host receive the target VMM can be loaded with the
metadata from the hashmap.

v2:
 * Added marcorr@ reviewed by tag
 * Renamed function introduced in 1/3
 * Edited with seanjc@'s review comments
 ** Cleaned up WARN usage
 ** Userspace makes random token now
 * Edited with brijesh.singh@'s review comments
 ** Checks for different LAUNCH_* states in send function

v1: https://lore.kernel.org/kvm/20210621163118.1040170-1-pgonda@google.com/

Peter Gonda (3):
  KVM, SEV: Refactor out function for unregistering encrypted regions
  KVM, SEV: Add support for SEV intra host migration
  KVM, SEV: Add support for SEV-ES intra host migration

 .../virt/kvm/amd-memory-encryption.rst        |  43 ++
 arch/x86/kvm/svm/sev.c                        | 396 +++++++++++++++++-
 arch/x86/kvm/svm/svm.h                        |   1 +
 include/uapi/linux/kvm.h                      |  12 +
 4 files changed, 433 insertions(+), 19 deletions(-)

base-commit: 7caa04b36f20

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
2.32.0.93.g670b81a890-goog

