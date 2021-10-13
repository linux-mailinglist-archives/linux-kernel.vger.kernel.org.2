Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0942C569
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhJMQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhJMQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:39 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:35 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id a15-20020a056000188f00b00161068d8461so2358175wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Eht9NEYnyeNXZ9GC0V0N+PJToFUkivNq3A15CtLZoHQ=;
        b=MmrT+s8muELqT2L44AG8+lk0AywU/F2urJDOsAWd0K9der7aYqNb7QeEmpJr61jjDJ
         ktPaVPfr9Um/DkE+sBzpnuPozNyp6CQ+MtznYTvTt4wDgqSdOkw9M3DVjAPywJYCv8V/
         zflAJefyFMKPyYkjOQMiINYeddoxDo7z6hdWUMN0HOvwQHdW00FFAeG+92esLUP8C1E+
         zneGPi2fokr5vos/ibfeJwBKG8GSSV9xYqTD3faz8aL7hRURTFEOjeGJufrj7gWmhW2u
         pYfTxgeNY741mtX6j+fZtTb7vRXRx4KkLWMdK5IbhZnKd9AIAIS/+TedR6F/JZd1rqzO
         v0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Eht9NEYnyeNXZ9GC0V0N+PJToFUkivNq3A15CtLZoHQ=;
        b=BS5FhMpqiLRfPNCYL6SgBAZCSW01NjRdqD9aS+OR0MwJEOwDzpyQCrlchAOx4/M+lc
         7rW6pFOEEGpEshXsHUKsjtvsKD2Wn1dYsCoRaexOlwISzLi/mlt2eH7vU+6WU8nNVIH5
         BUdgSB5hRqE9xUmTFb7vSrsw2SLzh1H/b4pwid0m2CVMQ6Z7TR/jo1p0FWZmm5R021dC
         Z4FI/TegynFVuQu9ChXk/2BRCub1IVmH+uSmSDoHLzC8Ka/1yYbsfkhBdYNDYJ15h3yb
         xOcM2/LGkTFk6hh/htaolpXT+yB3HZBG6RVDez/73V8ACxsqzdlIqmGpNKw1EWuJUvsF
         Qjbw==
X-Gm-Message-State: AOAM532mGexhVea8MyWbRyfllEwBocL1KznBuDgAJtDNiOJqYV7O/+EC
        qHWQETYisB2OafzkNK5o66l+nzKFyZnc
X-Google-Smtp-Source: ABdhPJwUVK1oAUnrbwA0NBbH6MgXKCoPORRCUhS/cSQ3NHCwSOfsKuOk9OgrZX4VXp9Bg29A4CFrD6RFznFb
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a05:600c:1c05:: with SMTP id
 j5mr141830wms.1.1634140714059; Wed, 13 Oct 2021 08:58:34 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:15 +0100
Message-Id: <20211013155831.943476-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 00/16] KVM: arm64: Implement unshare hypercall for pkvm
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series implements an unshare hypercall at EL2 in nVHE protected
mode, and makes use of it to unmmap guest-specific data-structures from
EL2 stage-1 during guest tear-down. Crucially, the implementation of the
share and unshare hypercall implements page refcounts at EL2 to avoid
accidentally unmapping data-structures that overlap a common page.

This series has two main benefits. Firstly it allows EL2 to track the
state of shared pages cleanly, as they can now transition from SHARED
back to OWNED. This will simplify permission checks once e.g. pkvm
implements a donation hcall to provide memory to protected guests, as
there should then be no reason for the host to donate a page that is
currently marked shared. And secondly, it avoids having dangling
mappings in the hypervisor's stage-1, which should be a good idea from
a security perspective as the hypervisor is obviously running with
elevated privileges. And perhaps worth noting is that this also
refactors the EL2 page-tracking checks in a more scalable way, which
should allow to implement other memory transitions (host donating memory
to a guest, a guest sharing back with the host, ...) much more easily in
the future.

The series is organized as follows:

 - patches 01-05 refactor the implementation of the existing share
   hypercall;

 - patches 06-10 introduce infrastructure to allow unmapping pages from
   EL2 stage-1;

 - patches 11-14 allow to refcount pages that are shared more than once
   with EL2;

 - patches 15-16 add the unshare hypercall, and make use of it when
   tearing down guests.

This has been lightly tested on Qemu, by spawning and powering off a
guest 50 times.

Feedback welcome :) !

Thanks,
Quentin

Quentin Perret (11):
  KVM: arm64: Avoid remapping the SVE state in the hyp stage-1
  KVM: arm64: Introduce kvm_share_hyp()
  KVM: arm64: Accept page ranges in pkvm share hypercall
  KVM: arm64: Provide {get,put}_page() stubs for early hyp allocator
  KVM: arm64: Refcount hyp stage-1 pgtable pages
  KVM: arm64: Fixup hyp stage-1 refcount
  KVM: arm64: Back hyp_vmemmap for all of memory
  KVM: arm64: Move hyp refcount helpers to header files
  KVM: arm64: Refcount shared pages at EL2
  KVM: arm64: pkvm: Introduce an unshare hypercall
  KVM: arm64: pkvm: Unshare guest structs during teardown

Will Deacon (5):
  KVM: arm64: Introduce do_share() helper for memory sharing between
    components
  KVM: arm64: Implement __pkvm_host_share_hyp() using do_share()
  KVM: arm64: Hook up ->page_count() for hypervisor stage-1 page-table
  KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2
  KVM: arm64: Move double-sharing logic into hyp-specific function

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_host.h             |   2 +
 arch/arm64/include/asm/kvm_mmu.h              |   2 +
 arch/arm64/include/asm/kvm_pgtable.h          |  21 +
 arch/arm64/kvm/arm.c                          |  17 +-
 arch/arm64/kvm/fpsimd.c                       |  25 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  18 +
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  29 +-
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |   5 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  12 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 596 ++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/mm.c                  |  31 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |  22 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  39 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  80 ++-
 arch/arm64/kvm/hyp/reserved_mem.c             |  17 +-
 arch/arm64/kvm/mmu.c                          |  48 +-
 arch/arm64/kvm/reset.c                        |  13 +-
 19 files changed, 814 insertions(+), 172 deletions(-)

-- 
2.33.0.882.g93a45727a2-goog

