Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7F3D8E86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhG1NHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:07:13 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:58671 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhG1NHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:07:11 -0400
X-QQ-mid: bizesmtp40t1627477586t4r18s2j
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 28 Jul 2021 21:06:24 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 5gms5Di3ODhwcUaoG5y/inyFUTUQBomNyL29HOE+eLy3B7jVXWO0qnWknMCqS
        4EUzJ1s5k48LQGmjdCtJtRVrtVGrdVJMGodSu1RhfXpRANy7M2HNEbQ4jBbTUQbxrSHYKWZ
        Ef7BSVcL+XJ6DYqoo6ve8NxCaOqG3DOZpuPSe4iQ4wnhcjXox0xP4k9W1rdx1VBwaabWW25
        BIyQLdhcPLtq7f6hOq87jovC/3zZNYy7xYEthpLUOUvvvVuqK5GF2U9j9cvfK0/lc11hZhM
        4gv0by9DALqMd2QWqoOGZpDBL/YgWtJLrc62mJUbtkkIjFip2R0iyRCQs=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] KVM: arm64: fix comment typo
Date:   Wed, 28 Jul 2021 21:06:23 +0800
Message-Id: <20210728130623.12017-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word 'the' from two comments.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v2.c b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
index a016f07adc28..5f9014ae595b 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
@@ -282,7 +282,7 @@ static unsigned long vgic_mmio_read_vcpuif(struct kvm_vcpu *vcpu,
 	case GIC_CPU_PRIMASK:
 		/*
 		 * Our KVM_DEV_TYPE_ARM_VGIC_V2 device ABI exports the
-		 * the PMR field as GICH_VMCR.VMPriMask rather than
+		 * PMR field as GICH_VMCR.VMPriMask rather than
 		 * GICC_PMR.Priority, so we expose the upper five bits of
 		 * priority mask to userspace using the lower bits in the
 		 * unsigned long.
@@ -329,7 +329,7 @@ static void vgic_mmio_write_vcpuif(struct kvm_vcpu *vcpu,
 	case GIC_CPU_PRIMASK:
 		/*
 		 * Our KVM_DEV_TYPE_ARM_VGIC_V2 device ABI exports the
-		 * the PMR field as GICH_VMCR.VMPriMask rather than
+		 * PMR field as GICH_VMCR.VMPriMask rather than
 		 * GICC_PMR.Priority, so we expose the upper five bits of
 		 * priority mask to userspace using the lower bits in the
 		 * unsigned long.
-- 
2.32.0

