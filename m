Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEAF38AF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhETNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239964AbhETNDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:03:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 686BB61184;
        Thu, 20 May 2021 13:02:27 +0000 (UTC)
Date:   Thu, 20 May 2021 14:02:25 +0100
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
Subject: Re: [PATCH v12 3/8] arm64: mte: Sync tags for pages where PTE is
 untagged
Message-ID: <20210520130224.GE12251@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-4-steven.price@arm.com>
 <20210519180610.GE21619@arm.com>
 <3bac3a47-9f96-c7bf-e401-fdef60dcc9d8@arm.com>
 <20210520122550.GD12251@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520122550.GD12251@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:25:50PM +0100, Catalin Marinas wrote:
> On Thu, May 20, 2021 at 12:55:21PM +0100, Steven Price wrote:
> > The problem I hit is one of include dependencies:
> > 
> > is_swap_pte() is defined (as a static inline) in
> > include/linux/swapops.h. However the definition depends on
> > pte_none()/pte_present() which are defined in pgtable.h - so there's a
> > circular dependency.
> > 
> > Open coding is_swap_pte() in set_pte_at() works, but it's a bit ugly.
> > Any ideas on how to improve on the below?
> > 
> > 	if (system_supports_mte() && pte_present(pte) &&
> > 	    pte_access_permitted(pte, false) && !pte_special(pte)) {
> > 		pte_t old_pte = READ_ONCE(*ptep);
> > 		/*
> > 		 * We only need to synchronise if the new PTE has tags enabled
> > 		 * or if swapping in (in which case another mapping may have
> > 		 * set tags in the past even if this PTE isn't tagged).
> > 		 * (!pte_none() && !pte_present()) is an open coded version of
> > 		 * is_swap_pte()
> > 		 */
> > 		if (pte_tagged(pte) || (!pte_none(pte) && !pte_present(pte)))
> > 			mte_sync_tags(old_pte, pte);
> > 	}
> 
> That's why I avoided testing my suggestion ;). I think we should just
> add !pte_none() in there with a comment that it may be a swap pte and
> use the is_swap_pte() again on the mte_sync_tags() path. We already have
> the pte_present() check.

Correction - pte_present() checks the new pte only, we need another for
the old pte. So it looks like we'll open-code is_swap_pte().

-- 
Catalin
