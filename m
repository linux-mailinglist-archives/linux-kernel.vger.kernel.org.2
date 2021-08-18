Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0713EFFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhHRI6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhHRI6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:58:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BA761075;
        Wed, 18 Aug 2021 08:57:41 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mGHOF-005hti-Px; Wed, 18 Aug 2021 09:57:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2 0/5] KVM: arm64: General cleanups
Date:   Wed, 18 Aug 2021 09:57:37 +0100
Message-Id: <162927703840.2372.14610953148314715293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
References: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 10:39:49 +0530, Anshuman Khandual wrote:
> This series contains mostly unrelated general cleanups. This series applies
> on v5.14-rc5 and has been boot tested with different page sized guests.
> 
> Changes in V2:
> 
> - Dropped the first patch regarding PAGE_[SHIFT|SIZE] per Marc
> - Added remaining ID_AA64MMFR0_PARANGE_ macros and ARM64_MIN_PARANGE_BITS per Marc
> - Dropped memory and cycle reference from commit message in [PATCH 3/5]
> - Changed return value as u32 in kvm_target_cpu() per Will
> 
> [...]

Applied to next, thanks!

[1/5] arm64/mm: Add remaining ID_AA64MMFR0_PARANGE_ macros
      commit: 504c6295b998effa682089747a96d7bb5933d4db
[2/5] KVM: arm64: Use ARM64_MIN_PARANGE_BITS as the minimum supported IPA
      commit: 9788c14060f3c179c376b2a87af1a430d4d84973
[3/5] KVM: arm64: Drop init_common_resources()
      commit: bf249d9e362f1011a839d57e771b4b1a7eed9656
[4/5] KVM: arm64: Drop check_kvm_target_cpu() based percpu probe
      commit: 6b7982fefc1fdcaa31b712f5fbc2e993cc99ad23
[5/5] KVM: arm64: Drop unused REQUIRES_VIRT
      commit: 9329752bc8659e3934e2b13434b2fddb0df0bb13

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


