Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F201F3AE53A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 399FA60C3D;
        Mon, 21 Jun 2021 08:48:10 +0000 (UTC)
Date:   Mon, 21 Jun 2021 09:48:07 +0100
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
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v16 7/7] KVM: arm64: Document MTE capability and ioctl
Message-ID: <20210621084806.GA11552@arm.com>
References: <20210618132826.54670-1-steven.price@arm.com>
 <20210618132826.54670-8-steven.price@arm.com>
 <20210618145241.GG16116@arm.com>
 <1273c642-d2b0-b81d-2052-1f2f0deafdae@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1273c642-d2b0-b81d-2052-1f2f0deafdae@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 09:18:31AM +0100, Steven Price wrote:
> On 18/06/2021 15:52, Catalin Marinas wrote:
> > On Fri, Jun 18, 2021 at 02:28:26PM +0100, Steven Price wrote:
> >> +When this capability is enabled all memory in (non-device) memslots must not
> >> +used VM_SHARED, attempts to create a memslot with a VM_SHARED mmap will result
> >> +in an -EINVAL return.
> > 
> > "must not used" doesn't sound right. Anyway, I'd remove VM_SHARED as
> > that's a kernel internal and not something the VMM needs to be aware of.
> > Just say something like "memslots must be mapped as shareable
> > (MAP_SHARED)".
> 
> I think I meant "must not use" - and indeed memslots must *not* be
> mapped as shareable. I'll update to this wording:
> 
>   When this capability is enabled all memory in memslots must be mapped as
>   not-shareable (no MAP_SHARED), attempts to create a memslot with MAP_SHARED
>   will result in an -EINVAL return.

It looks fine. Feel free to keep my reviewed-by.

-- 
Catalin
