Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D830364184
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhDSMUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239064AbhDSMUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC4566135F;
        Mon, 19 Apr 2021 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618834779;
        bh=vID4nWjxHrnKngR2T3VE7SWDRX/nxRGLtI0Y09J0vYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRrboZUaTSD01xxGFANUrz7+k1Kp0UPdLHtH2Y5s5qZL3iLLLWr0JoGZiQ8YOhAGQ
         DFNLIj5xm61RzSliRlk6EaWuIEccp4yePh5lvRLAxNuHI2T92pTspozEu1517b96iv
         nQCbCSn8gAN1rZZ+o64WceHXXtQ4KYsPXkFXsB/APDw02kpjFOYKCnl0rielIQ2RRZ
         sSwsnrFNFOhNhzxhm41L3A5uGzRcHWXJFT1fkVJyO+0iy6e9dJEQoHyDxhnk12eXtn
         MhSEiTcJAxxO1DBmfyXWsOfB2tV++LY1sRDUTruYckKV/T+PvBXOzIRsawj+ud2ui7
         F3iOaaPdx4kvA==
Date:   Mon, 19 Apr 2021 13:19:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        He Zhe <zhe.he@windriver.com>, oleg@redhat.com,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Message-ID: <20210419121932.GA30004@willie-the-truck>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com>
 <20210416133431.GA2303@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416133431.GA2303@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 02:34:41PM +0100, Mark Rutland wrote:
> On Fri, Apr 16, 2021 at 01:33:22PM +0100, Catalin Marinas wrote:
> > On Fri, Apr 16, 2021 at 03:55:31PM +0800, He Zhe wrote:
> > > The general version of is_syscall_success does not handle 32-bit
> > > compatible case, which would cause 32-bit negative return code to be
> > > recoganized as a positive number later and seen as a "success".
> > > 
> > > Since is_compat_thread is defined in compat.h, implementing
> > > is_syscall_success in ptrace.h would introduce build failure due to
> > > recursive inclusion of some basic headers like mutex.h. We put the
> > > implementation to ptrace.c
> > > 
> > > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > > ---
> > >  arch/arm64/include/asm/ptrace.h |  3 +++
> > >  arch/arm64/kernel/ptrace.c      | 10 ++++++++++
> > >  2 files changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > > index e58bca832dff..3c415e9e5d85 100644
> > > --- a/arch/arm64/include/asm/ptrace.h
> > > +++ b/arch/arm64/include/asm/ptrace.h
> > > @@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> > >  	regs->regs[0] = rc;
> > >  }
> > >  
> > > +extern inline int is_syscall_success(struct pt_regs *regs);
> > > +#define is_syscall_success(regs) is_syscall_success(regs)
> > > +
> > >  /**
> > >   * regs_get_kernel_argument() - get Nth function argument in kernel
> > >   * @regs:	pt_regs of that context
> > > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > > index 170f42fd6101..3266201f8c60 100644
> > > --- a/arch/arm64/kernel/ptrace.c
> > > +++ b/arch/arm64/kernel/ptrace.c
> > > @@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
> > >  	else
> > >  		return valid_native_regs(regs);
> > >  }
> > > +
> > > +inline int is_syscall_success(struct pt_regs *regs)
> > > +{
> > > +	unsigned long val = regs->regs[0];
> > > +
> > > +	if (is_compat_thread(task_thread_info(current)))
> > > +		val = sign_extend64(val, 31);
> > > +
> > > +	return !IS_ERR_VALUE(val);
> > > +}
> > 
> > It's better to use compat_user_mode(regs) here instead of
> > is_compat_thread(). It saves us from worrying whether regs are for the
> > current context.
> > 
> > I think we should change regs_return_value() instead. This function
> > seems to be called from several other places and it has the same
> > potential problems if called on compat pt_regs.
> 
> I think this is a problem we created for ourselves back in commit:
> 
>   15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return)
> 
> AFAICT, the perf regs samples are the only place this matters, since for
> ptrace the compat regs are implicitly truncated to compat_ulong_t, and
> audit expects the non-truncated return value. Other architectures don't
> truncate here, so I think we're setting ourselves up for a game of
> whack-a-mole to truncate and extend wherever we need to.
> 
> Given that, I suspect it'd be better to do something like the below.
> 
> Will, thoughts?

I think perf is one example, but this is also visible to userspace via the
native ptrace interface and I distinctly remember needing this for some
versions of arm64 strace to work correctly when tracing compat tasks.

So I do think that clearing the upper bits on the return path is the right
approach, but it sounds like we need some more work to handle syscall(-1)
and audit (what exactly is the problem here after these patches have been
applied?)

Will
