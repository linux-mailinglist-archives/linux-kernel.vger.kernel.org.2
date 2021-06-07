Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E939E4E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhFGRJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhFGRJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48E3B6101A;
        Mon,  7 Jun 2021 17:07:17 +0000 (UTC)
Date:   Mon, 7 Jun 2021 18:07:14 +0100
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
Subject: Re: [PATCH v14 2/8] arm64: Handle MTE tags zeroing in
 __alloc_zeroed_user_highpage()
Message-ID: <20210607170714.GA17957@arm.com>
References: <20210607110816.25762-1-steven.price@arm.com>
 <20210607110816.25762-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607110816.25762-3-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:08:10PM +0100, Steven Price wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Currently, on an anonymous page fault, the kernel allocates a zeroed
> page and maps it in user space. If the mapping is tagged (PROT_MTE),
> set_pte_at() additionally clears the tags under a spinlock to avoid a
> race on the page->flags. In order to optimise the lock, clear the page
> tags on allocation in __alloc_zeroed_user_highpage() if the vma flags
> have VM_MTE set.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>

I think you can drop this patch now that Peter's series has been queued
via the arm64 tree:

https://lore.kernel.org/r/20210602235230.3928842-4-pcc@google.com

-- 
Catalin
