Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF33E942E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhHKPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232792AbhHKPDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:03:13 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857E760F55;
        Wed, 11 Aug 2021 15:02:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDpkl-004MSu-GS; Wed, 11 Aug 2021 16:02:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K and 16K page size
Date:   Wed, 11 Aug 2021 16:02:44 +0100
Message-Id: <162869415426.2969316.15859233360100994637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1628680275-16578-1-git-send-email-anshuman.khandual@arm.com>
References: <1628680275-16578-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, alexandru.elisei@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 16:41:15 +0530, Anshuman Khandual wrote:
> Even though ID_AA64MMFR0.PARANGE reports 52 bit PA size support, it cannot
> be enabled as guest IPA size on 4K or 16K page size configurations. Hence
> kvm_ipa_limit must be restricted to 48 bits. This change achieves required
> IPA capping.
> 
> Before the commit c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA
> size based on host configuration"), the problem here would have been just
> latent via PHYS_MASK_SHIFT (which earlier in turn capped kvm_ipa_limit),
> which remains capped at 48 bits on 4K and 16K configs.

Applied to next, thanks!

[1/1] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K and 16K page size
      commit: 5e5df9571c319fb107d7a523cc96fcc99961ee70

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


