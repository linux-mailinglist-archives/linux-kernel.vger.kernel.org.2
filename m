Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20B43358F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhJSMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhJSMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:21 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A9C061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:08 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id z26-20020a05600c221a00b0030da55bc454so2489397wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fy4DNJg+LJGIWoeCxYMWIL1CKlINKgnhRdgDVyd1Xho=;
        b=Nr4MJ1aI7q7w3UdTcVj6uCTcnUI7GEUmwq2F1i25CsIrzLEbTiVmLCgtKGbFFMtnzj
         A0IEcU+/iuEOzhIOixBDn/V6QiT02j8f644HbyG4nVN8ml3f/EdohG6B0Dxq5D0IpiLB
         q8LciAgHkLAV2t3dEYif+bOwdQrTAo0WQ0FPesXnFw1naWLXxBXnVxty6DMhm498g5lv
         4lIDI0hW+WNGf3nm+DqiXlCC7heRmA/GZGmIlGDurd93+jhzyplTOVv/oiHJZz5ZzJso
         vpDCREebQW3sMC78QseUu6Z6tLs7JutRKfuaPJ69qU40glehGG/wmTOkqSjBra3jh4+l
         PgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fy4DNJg+LJGIWoeCxYMWIL1CKlINKgnhRdgDVyd1Xho=;
        b=7ujJcxQyikEpw9oqCQqnqg4qg+bH6XuhNb4EI74DDI3gIvgY+OLr/wlkY+TB9lrm9F
         GjoVpob0tJ5sROqNR4/mtcIVaVgr2rkCbx6UQTQxd5CikVLyTbuvPlkzeb2cptfvtoQQ
         02RLki2VQwfdROfWlFK6Zl+RTT3hYbbYUGhXD8YJfuEFEkmtCusEy76O/TguFWmFC4CB
         tfJdRRuBK6xOMfq5lo6JRM357oJ3y0j3PlEtQyFQL1rXjQlYtD4bkhnN906eP8BGbVLw
         4S+UCeLgUucjnU7JaEdP+97rk7KnyXptBM3MI6EMP6I03H0vUq0klYOOh/pE4Q/rjx80
         irhA==
X-Gm-Message-State: AOAM531LfEu+od5O2hihLiMFDnERvu3mY+j4744SZuyrCLs6U2HBHHds
        kmG1vR+CyjtsHJ2oI9su3WHgdDV1WZGR
X-Google-Smtp-Source: ABdhPJyrcmjf8nedcASO5PXz/po0MxrFVu8ZXOjfZXlzQFBuQrME6M29/wyaWdnny2GWZzG1UFy/1PGuR63M
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a05:600c:3b88:: with SMTP id
 n8mr5585459wms.93.1634645586407; Tue, 19 Oct 2021 05:13:06 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:49 +0100
Message-Id: <20211019121304.2732332-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 00/15] KVM: arm64: pkvm: Implement unshare hypercall
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 of the series previously posted here:

  https://lore.kernel.org/kvmarm/20211013155831.943476-1-qperret@google.com/

This series implements an unshare hypercall at EL2 in nVHE protected
mode, and makes use of it to unmmap guest-specific data-structures from
EL2 stage-1 during guest tear-down. Crucially, the implementation of the
share and unshare routines use page refcounts in the host kernel to
avoid accidentally unmapping data-structures that overlap a common page.

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

Changes since v2:

 - moved the refcounting of pages shared more than once to the host in
   order to simplify and optimize the hyp code;

 - synchronized lifetime of the vcpu and its parent task struct using
   get_task_struct() / put_task_struct();

 - rebased on kvmarm/next

 - rebased on Marc's v2 refactoring of the first vcpu run:
   https://lore.kernel.org/kvmarm/20211018211158.3050779-1-maz@kernel.org

 - small improvements/refactoring throughout;

This has been lightly tested on Qemu, by spawning and powering off a
guest 50 times. You can find a branch with everything applied here:

  https://android-kvm.googlesource.com/linux qperret/hyp-unshare-v2

Thanks!
Quentin


Quentin Perret (7):
  KVM: arm64: Check if running in VHE from kvm_host_owns_hyp_mappings()
  KVM: arm64: Provide {get,put}_page() stubs for early hyp allocator
  KVM: arm64: Refcount hyp stage-1 pgtable pages
  KVM: arm64: Fixup hyp stage-1 refcount
  KVM: arm64: Introduce kvm_share_hyp()
  KVM: arm64: pkvm: Refcount the pages shared with EL2
  KVM: arm64: pkvm: Unshare guest structs during teardown

Will Deacon (8):
  KVM: arm64: Hook up ->page_count() for hypervisor stage-1 page-table
  KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2
  KVM: arm64: Extend pkvm_page_state enumeration to handle absent pages
  KVM: arm64: Introduce wrappers for host and hyp spin lock accessors
  KVM: arm64: Implement do_share() helper for sharing memory
  KVM: arm64: Implement __pkvm_host_share_hyp() using do_share()
  KVM: arm64: Implement do_unshare() helper for unsharing memory
  KVM: arm64: Expose unshare hypercall to the host

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_host.h             |   2 +
 arch/arm64/include/asm/kvm_mmu.h              |   2 +
 arch/arm64/include/asm/kvm_pgtable.h          |  21 +
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/arm64/kvm/fpsimd.c                       |  33 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   6 +
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |   5 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   8 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 500 +++++++++++++++---
 arch/arm64/kvm/hyp/nvhe/setup.c               |  32 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  80 ++-
 arch/arm64/kvm/mmu.c                          | 132 ++++-
 arch/arm64/kvm/reset.c                        |  10 +-
 14 files changed, 733 insertions(+), 105 deletions(-)

-- 
2.33.0.1079.g6e70778dc9-goog

