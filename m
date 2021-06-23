Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB83B23BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWXIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWXIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:08:18 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:05:59 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h10-20020ac87d4a0000b029024eccb9d079so4347964qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=XfVXHKeEwKS6iZ0DHXHeo0Qo09QuL9XzgavzaDfpho4=;
        b=RQkfnKz5rYet9tNbokVuMowTizNEfSKL++7S3EuKiG4Rino1iF57Fpie3kF3jGZgFD
         dZB2YhdaWBWDAJfiCaeYBAz3XEo5WxEXXFI8qhIII2jaTVd5mcTqU/cyz5V3x0YhmT0f
         LxtEesR6BZ4Dcz4DwV54H7VfhE8C3yWqZt5cvANBWXtGyGdEflRRiHQNQqNyQb1nCjSu
         MQ/wI+LtjljQQ7J/PvR0YmPoZ4Dkssz+y90omcYSip1KC33zjXehSdCkOztzMPHIM0cO
         jc9ckwBiK86k4m4aePC06Cxve7y9KQoKgp+iuSQ1pHkChNYaoveYwHvDgzm5hV1GLA3u
         OiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=XfVXHKeEwKS6iZ0DHXHeo0Qo09QuL9XzgavzaDfpho4=;
        b=YGAtDDixxP3wPp9IAwCP8DJzRUTeXabBYRiUQ2ysye6xez1mC49/Cx66O6JxTIduDd
         rP0dytwvjJ30D+a6++DXo43YTCaizck6201AyFZMlrHRK/kDTJ+qnOB2B5H+jx1x0OQR
         3LNm0qxfdMrDJRmOHsmBgSEELfg+hGF3Pf1o+zLh6iKbXnFzbnX1IuTOW3BskVYKBuId
         TB0w3zUrES/BQnjbjL0ExvKEOpq8fXpTxIGFTjiMiIl/5HVR0X2iC09G962mFeiFfK6C
         cyc+MwHC5O8lYYO2rBd8wYy8Gf9ZRMGU0F1rnQq6+uGTjFGlg8kQ1UgZC76g+KB8UsyQ
         1cWw==
X-Gm-Message-State: AOAM533z98F7jMgfYh9JtzflQJrPN3vuCaZOJPWc6aAmnF8NmFrT5WrL
        oj2JPdJBXHnHxLOrGC2q6tTecfijE3c=
X-Google-Smtp-Source: ABdhPJyEU6qwB4nJApfEcVGmi+jb9w0T4FSK3sG9yEAxPiYVbusZ4/enmtlqA2npkvLigZaOIqONJfT7bNw=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e9e:5b86:b4f2:e3c9])
 (user=seanjc job=sendgmr) by 2002:a25:e803:: with SMTP id k3mr668644ybd.268.1624489558343;
 Wed, 23 Jun 2021 16:05:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 23 Jun 2021 16:05:45 -0700
Message-Id: <20210623230552.4027702-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 0/7] KVM: x86: guest MAXPHYADDR and C-bit fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes centered around enumerating guest MAXPHYADDR and handling the
C-bit in KVM.

DISCLAIMER: I have no idea if patch 04, "Truncate reported guest
MAXPHYADDR to C-bit if SEV is" is architecturally correct.  The APM says
the following about the C-bit in the context of SEV, but I can't for the
life of me find anything in the APM that clarifies whether "effectively
reduced" is supposed to apply to _only_ SEV guests, or any guest on an
SEV enabled platform.

  Note that because guest physical addresses are always translated through
  the nested page tables, the size of the guest physical address space is
  not impacted by any physical address space reduction indicated in
  CPUID 8000_001F[EBX]. If the C-bit is a physical address bit however,
  the guest physical address space is effectively reduced by 1 bit.

In practice, I have observed that Rome CPUs treat the C-bit as reserved for
non-SEV guests (another disclaimer on this below).  Long story short, commit
ef4c9f4f6546 ("KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()")
exposed the issue by inadvertantly causing selftests to start using GPAs
with bit 47 set.

That said, regardless of whether or not the behavior is intended, it needs
to be addressed by KVM.  I think the only difference is whether this is
KVM's _only_ behavior, or whether it's gated by an erratum flag.

The second disclaimer is that I haven't tested with memory encryption
disabled in hardware.  I wrote the patch assuming/hoping that only CPUs
that report SEV=1 treat the C-bit as reserved, but I haven't actually
tested the SEV=0 case on e.g. CPUs with only SME (we might have these
platforms, but I've no idea how to access/find them), or CPUs with SME/SEV
disabled in BIOS (again, I've no idea how to do this with our BIOS).

Sean Christopherson (7):
  KVM: x86: Use guest MAXPHYADDR from CPUID.0x8000_0008 iff TDP is
    enabled
  KVM: x86: Use kernel's x86_phys_bits to handle reduced MAXPHYADDR
  KVM: x86: Truncate reported guest MAXPHYADDR to C-bit if SEV is
    supported
  KVM: x86/mmu: Do not apply HPA (memory encryption) mask to GPAs
  KVM: VMX: Refactor 32-bit PSE PT creation to avoid using MMU macro
  KVM: x86/mmu: Bury 32-bit PSE paging helpers in paging_tmpl.h
  KVM: x86/mmu: Use separate namespaces for guest PTEs and shadow PTEs

 arch/x86/kvm/cpuid.c            | 38 +++++++++++++++++---
 arch/x86/kvm/mmu.h              | 11 ++----
 arch/x86/kvm/mmu/mmu.c          | 63 ++++++++-------------------------
 arch/x86/kvm/mmu/mmu_audit.c    |  6 ++--
 arch/x86/kvm/mmu/mmu_internal.h | 14 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 52 ++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/spte.c         |  2 +-
 arch/x86/kvm/mmu/spte.h         | 34 +++++++-----------
 arch/x86/kvm/mmu/tdp_iter.c     |  6 ++--
 arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
 arch/x86/kvm/svm/svm.c          | 37 ++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c          |  2 +-
 arch/x86/kvm/x86.c              |  3 ++
 arch/x86/kvm/x86.h              |  1 +
 14 files changed, 170 insertions(+), 101 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

