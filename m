Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB032BA8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351675AbhCCLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:36:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245506AbhCCDIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:08:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8B71FB;
        Tue,  2 Mar 2021 18:42:38 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A34EE3F73B;
        Tue,  2 Mar 2021 18:42:34 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Date:   Wed,  3 Mar 2021 10:42:25 +0800
Message-Id: <20210303024225.2591-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the start addr is not aligned with the granule size of that level.
loop step size should be adjusted to boundary instead of simple
kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
the chance to be walked through.
E.g. Assume the unmap range [data->addr, data->end] is
[0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
should be adjusted to 0xff00c00000 instead of 0xff00cb2000.

Without this fix, userspace "segment fault" error can be easily
triggered by running simple gVisor runsc cases on an Ampere Altra
server:
    docker run --runtime=runsc -it --rm  ubuntu /bin/bash

In container:
    for i in `seq 1 100`;do ls;done

Reported-by: Howard Zhang <Howard.Zhang@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bdf8e55ed308..4d99d07c610c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -225,6 +225,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 		goto out;
 
 	if (!table) {
+		data->addr = ALIGN_DOWN(data->addr, kvm_granule_size(level));
 		data->addr += kvm_granule_size(level);
 		goto out;
 	}
-- 
2.17.1

