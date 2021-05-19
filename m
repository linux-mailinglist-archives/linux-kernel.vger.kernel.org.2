Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE43894A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhESRd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhESRdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6564611BF;
        Wed, 19 May 2021 17:32:30 +0000 (UTC)
Date:   Wed, 19 May 2021 18:32:28 +0100
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
Subject: Re: [PATCH v12 1/8] arm64: mte: Handle race when synchronising tags
Message-ID: <20210519173228.GC21619@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517123239.8025-2-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:32:32PM +0100, Steven Price wrote:
> mte_sync_tags() used test_and_set_bit() to set the PG_mte_tagged flag
> before restoring/zeroing the MTE tags. However if another thread were to
> race and attempt to sync the tags on the same page before the first
> thread had completed restoring/zeroing then it would see the flag is
> already set and continue without waiting. This would potentially expose
> the previous contents of the tags to user space, and cause any updates
> that user space makes before the restoring/zeroing has completed to
> potentially be lost.
> 
> Since this code is run from atomic contexts we can't just lock the page
> during the process. Instead implement a new (global) spinlock to protect
> the mte_sync_page_tags() function.
> 
> Fixes: 34bfeea4a9e9 ("arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE")
> Signed-off-by: Steven Price <steven.price@arm.com>

Other than the missing spinlock initialisation, the patch looks fine to
me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(though I'll probably queue it as a fix, waiting a couple of days for
comments)

-- 
Catalin
