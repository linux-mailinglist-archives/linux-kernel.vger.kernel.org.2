Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD53EC7C2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhHOG4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235312AbhHOG4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629010582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ysB8E3Gr1LrzW/DtzYKw9dH3L2Llbii5/d8yEzyqiHw=;
        b=AxS0WrZMl8mC3/woKWW5u9U5yq/5JL4zHw7q7v6g7iWTmo64ojKo/FYAvl5E3NDYdc4Gfk
        a0NvpMbTrtQX3Oqyj6uujp9l4vnP3zYHgv0eVIX3s6SF4YwewRn01epWQzo4eJ+NZT1PIE
        9f+lqv5LKNYiNF7296c7TA7slqXyhRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-3_IbAhhgODemS7a1lAwphg-1; Sun, 15 Aug 2021 02:56:18 -0400
X-MC-Unique: 3_IbAhhgODemS7a1lAwphg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0776D1853028;
        Sun, 15 Aug 2021 06:56:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D9B2AAB5;
        Sun, 15 Aug 2021 06:56:17 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 5.14-rc6
Date:   Sun, 15 Aug 2021 02:56:17 -0400
Message-Id: <20210815065617.3754533-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit d5aaad6f83420efb8357ac8e11c868708b22d0a9:

  KVM: x86/mmu: Fix per-cpu counter corruption on 32-bit builds (2021-08-05 03:33:56 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 6e949ddb0a6337817330c897e29ca4177c646f02:

  Merge branch 'kvm-tdpmmu-fixes' into kvm-master (2021-08-13 03:33:13 -0400)

----------------------------------------------------------------
ARM:

- Plug race between enabling MTE and creating vcpus

- Fix off-by-one bug when checking whether an address range is RAM

x86:

- Fixes for the new MMU, especially a memory leak on hosts with <39
  physical address bits

- Remove bogus EFER.NX checks on 32-bit non-PAE hosts

- WAITPKG fix

----------------------------------------------------------------
David Brazdil (1):
      KVM: arm64: Fix off-by-one in range_is_memory

Junaid Shahid (1):
      kvm: vmx: Sync all matching EPTPs when injecting nested EPT fault

Paolo Bonzini (4):
      KVM: x86: remove dead initialization
      Merge branch 'kvm-vmx-secctl' into kvm-master
      Merge tag 'kvmarm-fixes-5.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge branch 'kvm-tdpmmu-fixes' into kvm-master

Sean Christopherson (6):
      KVM: VMX: Use current VMCS to query WAITPKG support for MSR emulation
      KVM: x86: Allow guest to set EFER.NX=1 on non-PAE 32-bit kernels
      KVM: nVMX: Use vmx_need_pf_intercept() when deciding if L0 wants a #PF
      KVM: x86/mmu: Don't leak non-leaf SPTEs when zapping all SPTEs
      KVM: x86/mmu: Don't step down in the TDP iterator when zapping all SPTEs
      KVM: x86/mmu: Protect marking SPs unsync when using TDP MMU with spinlock

Steven Price (1):
      KVM: arm64: Fix race when enabling KVM_ARM_CAP_MTE

 Documentation/virt/kvm/locking.rst    |  8 ++---
 arch/arm64/kvm/arm.c                  | 12 +++++---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  2 +-
 arch/x86/include/asm/kvm_host.h       |  7 +++++
 arch/x86/kvm/cpuid.c                  | 28 +-----------------
 arch/x86/kvm/hyperv.c                 |  2 +-
 arch/x86/kvm/mmu/mmu.c                | 28 ++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c            | 35 +++++++++++++++-------
 arch/x86/kvm/vmx/nested.c             | 56 +++++++++++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.h                |  2 +-
 10 files changed, 118 insertions(+), 62 deletions(-)

