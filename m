Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F378B3AB356
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhFQMPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhFQMPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C580D610EA;
        Thu, 17 Jun 2021 12:13:24 +0000 (UTC)
Date:   Thu, 17 Jun 2021 13:13:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v15 0/7] MTE support for KVM guest
Message-ID: <20210617121322.GC6314@arm.com>
References: <20210614090525.4338-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614090525.4338-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:05:18AM +0100, Steven Price wrote:
> I realise there are still open questions[1] around the performance of
> this series (the 'big lock', tag_sync_lock, introduced in the first
> patch). But there should be no impact on non-MTE workloads and until we
> get real MTE-enabled hardware it's hard to know whether there is a need
> for something more sophisticated or not. Peter Collingbourne's patch[3]
> to clear the tags at page allocation time should hide more of the impact
> for non-VM cases. So the remaining concern is around VM startup which
> could be effectively serialised through the lock.
[...]
> [1]: https://lore.kernel.org/r/874ke7z3ng.wl-maz%40kernel.org

Start-up, VM resume, migration could be affected by this lock, basically
any time you fault a page into the guest. As you said, for now it should
be fine as long as the hardware doesn't support MTE or qemu doesn't
enable MTE in guests. But the problem won't go away.

We have a partial solution with an array of locks to mitigate against
this but there's still the question of whether we should actually bother
for something that's unlikely to happen in practice: MAP_SHARED memory
in guests (ignoring the stage 1 case for now).

If MAP_SHARED in guests is not a realistic use-case, we have the vma in
user_mem_abort() and if the VM_SHARED flag is set together with MTE
enabled for guests, we can reject the mapping.

We can discuss the stage 1 case separately from this series.

-- 
Catalin
