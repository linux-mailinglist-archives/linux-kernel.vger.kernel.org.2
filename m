Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0D4028D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbhIGMeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:34:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343965AbhIGMeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:34:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67CFE6D;
        Tue,  7 Sep 2021 05:33:10 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31CFC3F766;
        Tue,  7 Sep 2021 05:33:04 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH v2 0/2] Add memcg accounting to Arm KVM
Date:   Tue,  7 Sep 2021 20:31:10 +0800
Message-Id: <20210907123112.10232-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by what had been done by X86 kvm and kvm common codes, it would
be better to make arm64 kvm consistent with them.

The memory allocations of VM scope should be charged into VM process.
Hence change the allocation flag from GFP_KERNEL to GFP_KERNEL_ACCOUNT.

There remain some GFP_KERNEL unchanged since they are global allocations,
instead of VM scope.

Changes:
v2: address a few comments from Marc Zyngier, including redundant
    GFP_KERNEL, incorrect memcg accounting and variable type   
v1: https://lkml.org/lkml/2021/9/2/649

Jia He (2):
  KVM: arm64: vgic: Add memcg accounting to vgic allocations
  KVM: arm64: Add memcg accounting to KVM allocations

 arch/arm64/kvm/arm.c               |  6 ++++--
 arch/arm64/kvm/mmu.c               |  2 +-
 arch/arm64/kvm/pmu-emul.c          |  2 +-
 arch/arm64/kvm/reset.c             |  2 +-
 arch/arm64/kvm/vgic/vgic-init.c    |  2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c   |  2 +-
 arch/arm64/kvm/vgic/vgic-its.c     | 14 +++++++-------
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |  2 +-
 arch/arm64/kvm/vgic/vgic-v4.c      |  2 +-
 9 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.17.1

