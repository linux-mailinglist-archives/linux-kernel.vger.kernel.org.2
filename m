Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69423456FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhKSNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:47:38 -0500
Received: from foss.arm.com ([217.140.110.172]:51786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235424AbhKSNrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:47:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602696D;
        Fri, 19 Nov 2021 05:44:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79E883F70D;
        Fri, 19 Nov 2021 05:44:34 -0800 (PST)
Date:   Fri, 19 Nov 2021 13:44:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        catalin.marinas@arm.com, kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: uaccess: fix put_user() with TTBR0 PAN
Message-ID: <20211119134432.GB25912@lakrids.cambridge.arm.com>
References: <20211118163417.21617-1-vincent.whitchurch@axis.com>
 <20211119113306.GA13292@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119113306.GA13292@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:33:06AM +0000, Will Deacon wrote:
> On Thu, Nov 18, 2021 at 05:34:17PM +0100, Vincent Whitchurch wrote:
> > The value argument to put_user() must be evaluated before the TTBR0
> > switch is done.  Otherwise, if it is a function and the function sleeps,
> > the reserved TTBR0 will be restored when the process is switched in
> > again and the process will end up in an infinite loop of faults.
> > 
> > This problem was seen with the put_user() in schedule_tail().  A similar
> > fix was done for RISC-V in commit 285a76bb2cf51b0c74c634 ("riscv:
> > evaluate put_user() arg before enabling user access").
> > 
> > Fixes: f253d827f33cb5a5990 ("arm64: uaccess: refactor __{get,put}_user")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 6e2e0b7031ab..96b26fa9d3d0 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -362,10 +362,11 @@ do {									\
> >  #define __put_user_error(x, ptr, err)					\
> >  do {									\
> >  	__typeof__(*(ptr)) __user *__p = (ptr);				\
> > +	__typeof__(*(__p)) __val = (x);					\
> >  	might_fault();							\
> >  	if (access_ok(__p, sizeof(*__p))) {				\
> >  		__p = uaccess_mask_ptr(__p);				\
> > -		__raw_put_user((x), __p, (err));			\
> > +		__raw_put_user(__val, __p, (err));			\
> >  	} else	{							\
> >  		(err) = -EFAULT;					\
> >  	}								\
> 
> 
> Oh, nice spot! I hope you didn't lose too much time debugging if you
> actually ran into this...
> 
> Although it seems a lot less likely to cause a problem, should we do
> something similar for __get_user_error() and assign to (x) outside of
> the uaccess-disabled section?

I agree we should follow up with a more general cleanup to avoid any
macro evaluation within user-access or tco critical sections. Since
that's especially subtle for the get_*() helpers (and I beleive there
may be some other latent issues in that area), I reckon we should do
that as a follow-up, and shouldn't block this patch on that being done.

I'll go audit that and see what I spot.

Thanks,
Mark.
