Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0215340C2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhIOJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:21:15 -0400
Received: from foss.arm.com ([217.140.110.172]:53848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhIOJVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:21:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2FF6D;
        Wed, 15 Sep 2021 02:19:51 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBFF43F5A1;
        Wed, 15 Sep 2021 02:19:49 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:19:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     ashimida <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Abbott <labbott@kernel.org>
Subject: Re: [PATCH] [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
Message-ID: <20210915091943.GA47689@C02TD0UTHF1T.local>
References: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
 <20210914101709.GA29127@C02TD0UTHF1T.local>
 <f02816a4-5b8e-d1c6-88a2-1db282a7479e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02816a4-5b8e-d1c6-88a2-1db282a7479e@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 09:57:14AM +0800, ashimida wrote:
> Hi King, Rutland:
> 
> Thanks for the reply and let me understand the reason here.
> 
> Then may I first submit a patch to modify the attributes of
> __stack_chk_guard of the arm/aarch64 platform?

This patch looks fine as-is (hence the Acked-by). Doing the same for
arch/arm makes sense, but that should be a separate patch.

I was suggesting that in future we should probably do the same in more
places, not that you need to do so now.

Thanks,
Mark.

> 
> On 9/14/21 6:17 PM, Mark Rutland wrote:
> > On Tue, Sep 14, 2021 at 05:44:02PM +0800, Dan Li wrote:
> > > __stack_chk_guard is setup once while init stage and never changed
> > > after that.
> > > 
> > > Although the modification of this variable at runtime will usually
> > > cause the kernel to crash (so dose the attacker), it should be marked
> > > as _ro_after_init, and it should not affect performance if it is
> > > placed in the ro_after_init section.
> > > 
> > > This should also be the case on the ARM platform, or am I missing
> > > something?
> > > 
> > > Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> > 
> > FWIW, this makes sense to me:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Looking at the history, this was added to arm64 in commit:
> > 
> >    c0c264ae5112d1cd ("arm64: Add CONFIG_CC_STACKPROTECTOR")
> > 
> > ... whereas __ro_after_init was introduced around 2 years later in
> > commit:
> > 
> >    c74ba8b3480da6dd ("arch: Introduce post-init read-only memory")
> > 
> > ... so we weren't deliberately avoiding __ro_after_init, and there are
> > probably a significant number of other variables we could apply it to.
> > 
> > Mark.
> > 
> > > ---
> > >   arch/arm64/kernel/process.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index c8989b9..c858b85 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -60,7 +60,7 @@
> > >   #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
> > >   #include <linux/stackprotector.h>
> > > -unsigned long __stack_chk_guard __read_mostly;
> > > +unsigned long __stack_chk_guard __ro_after_init;
> > >   EXPORT_SYMBOL(__stack_chk_guard);
> > >   #endif
> > > -- 
> > > 2.7.4
> > > 
