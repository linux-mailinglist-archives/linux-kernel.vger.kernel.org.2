Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59093E8F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhHKL0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhHKL0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:26:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563DC60F55;
        Wed, 11 Aug 2021 11:25:40 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDmMc-004J3u-6l; Wed, 11 Aug 2021 12:25:38 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     will@kernel.org, suzuki.poulose@arm.com, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com, ardb@kernel.org,
        tabba@google.com
Subject: Re: [PATCH v4 00/21] Track shared pages at EL2 in protected mode
Date:   Wed, 11 Aug 2021 12:25:34 +0100
Message-Id: <162868104087.2706016.2089522816364249636.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
References: <20210809152448.1810400-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, catalin.marinas@arm.com, qperret@google.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, qwandor@google.com, dbrazdil@google.com, kernel-team@android.com, ardb@kernel.org, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 16:24:27 +0100, Quentin Perret wrote:
> This is v4 of the patch series previously posted here:
> 
> https://lore.kernel.org/lkml/20210729132818.4091769-1-qperret@google.com/
> 
> This series aims to improve how the nVHE hypervisor tracks ownership of
> memory pages when running in protected mode ("kvm-arm.mode=protected" on
> the kernel command line).
> 
> [...]

Applied to next, thanks!

[01/21] KVM: arm64: Add hyp_spin_is_locked() for basic locking assertions at EL2
        commit: d21292f13f1f0721d60e8122e2db46bea8cf6950
[02/21] KVM: arm64: Introduce hyp_assert_lock_held()
        commit: 8e049e0daf23aa380c264e5e15e4c64ea5497ed7
[03/21] KVM: arm64: Provide the host_stage2_try() helper macro
        commit: 1bac49d490cbc813f407a5c9806e464bf4a300c9
[05/21] KVM: arm64: Expose page-table helpers
        commit: 51add457733bbc4a442fc280d73d14bfe262e4a0
[06/21] KVM: arm64: Optimize host memory aborts
        commit: c4f0935e4d957bfcea25ad76860445660a60f3fd
[07/21] KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
        commit: 178cac08d588e7406a09351a992f57892d8d9cc9
[08/21] KVM: arm64: Don't overwrite software bits with owner id
        commit: 8a0282c68121e53ab17413283cfed408a47e1a2a
[09/21] KVM: arm64: Tolerate re-creating hyp mappings to set software bits
        commit: b53846c5f279cb5329b82f19a7d313f02cb9d21c
[10/21] KVM: arm64: Enable forcing page-level stage-2 mappings
        commit: 5651311941105ca077d3ab74dd4a92e646ecf7fb
[11/21] KVM: arm64: Allow populating software bits
        commit: 4505e9b624cefafa4b75d8a28e72f32076c33375
[12/21] KVM: arm64: Add helpers to tag shared pages in SW bits
        commit: ec250a67ea8db6209918a389554cf3aec0395b1f
[13/21] KVM: arm64: Expose host stage-2 manipulation helpers
        commit: 39257da0e04e5cdb1e4a3ca715dc3d949fe8b059
[14/21] KVM: arm64: Expose pkvm_hyp_id
        commit: 2d77e238badb022adb364332b7d6a1d627f77145
[15/21] KVM: arm64: Introduce addr_is_memory()
        commit: e009dce1292c37cf8ee7c33e0887ad3c642f980f
[16/21] KVM: arm64: Enable retrieving protections attributes of PTEs
        commit: 9024b3d0069ab4b8ef70cf55f0ee09e61f3a0747
[17/21] KVM: arm64: Mark host bss and rodata section as shared
        commit: 2c50166c62ba7f3c23c1bbdbb9324db462ddc97b
[18/21] KVM: arm64: Remove __pkvm_mark_hyp
        commit: ad0e0139a8e163245d8f44ab4f6ec3bc9b08034d
[19/21] KVM: arm64: Refactor protected nVHE stage-1 locking
        commit: f9370010e92638f66473baf342e19de940403362
[20/21] KVM: arm64: Restrict EL2 stage-1 changes in protected mode
        commit: 66c57edd3bc79e3527daaae8123f72ecd1e3fa25
[21/21] KVM: arm64: Make __pkvm_create_mappings static
        commit: 64a80fb766f9a91e26930bfc56d8e7c12425df12

Note that patch #4 has been used as the base for this series,
and is already part of the mapping level rework.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


