Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE78C3B074A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhFVOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhFVOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:24:13 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66A1611BF;
        Tue, 22 Jun 2021 14:21:57 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lvhHn-0097g1-MJ; Tue, 22 Jun 2021 15:21:55 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v17 0/6] MTE support for KVM guest
Date:   Tue, 22 Jun 2021 15:21:51 +0100
Message-Id: <162437105102.29544.14666831489362675099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621111716.37157-1-steven.price@arm.com>
References: <20210621111716.37157-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, will@kernel.org, steven.price@arm.com, linux-kernel@vger.kernel.org, Dave.Martin@arm.com, peter.maydell@linaro.org, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, quintela@redhat.com, dgilbert@redhat.com, drjones@redhat.com, qemu-devel@nongnu.org, tglx@linutronix.de, james.morse@arm.com, richard.henderson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 12:17:10 +0100, Steven Price wrote:
> This series adds support for using the Arm Memory Tagging Extensions
> (MTE) in a KVM guest.
> 
> Changes since v16[1]:
> 
>  - Dropped the first patch ("Handle race when synchronising tags") as
>    it's not KVM specific and by restricting MAP_SHARED in KVM there is
>    no longer a dependency.
> 
> [...]

Applied to next, thanks!

[1/6] arm64: mte: Sync tags for pages where PTE is untagged
      commit: 69e3b846d8a753f9f279f29531ca56b0f7563ad0
[2/6] KVM: arm64: Introduce MTE VM feature
      commit: ea7fc1bb1cd1b92b42b1d9273ce7e231d3dc9321
[3/6] KVM: arm64: Save/restore MTE registers
      commit: e1f358b5046479d2897f23b1d5b092687c6e7a67
[4/6] KVM: arm64: Expose KVM_ARM_CAP_MTE
      commit: 673638f434ee4a00319e254ade338c57618d6f7e
[5/6] KVM: arm64: ioctl to fetch/store tags in a guest
      commit: f0376edb1ddcab19a473b4bf1fbd5b6bbed3705b
[6/6] KVM: arm64: Document MTE capability and ioctl
      commit: 04c02c201d7e8149ae336ead69fb64e4e6f94bc9

I performed a number of changes in user_mem_abort(), so please
have a look at the result. It is also pretty late in the merge
cycle, so if anything looks amiss, I'll just drop it.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


