Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5D368519
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhDVQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:43:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVQnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:43:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BC011D4;
        Thu, 22 Apr 2021 09:42:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7E033F73B;
        Thu, 22 Apr 2021 09:42:30 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:42:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        He Zhe <zhe.he@windriver.com>, oleg@redhat.com,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Message-ID: <20210422164228.GD66392@C02TD0UTHF1T.local>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com>
 <20210416133431.GA2303@C02TD0UTHF1T.local>
 <20210419121932.GA30004@willie-the-truck>
 <20210421171005.GA46949@C02TD0UTHF1T.local>
 <20210422160752.GA2214@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422160752.GA2214@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 05:07:53PM +0100, Will Deacon wrote:
> On Wed, Apr 21, 2021 at 06:10:05PM +0100, Mark Rutland wrote:
> > On Mon, Apr 19, 2021 at 01:19:33PM +0100, Will Deacon wrote:
> > > On Fri, Apr 16, 2021 at 02:34:41PM +0100, Mark Rutland wrote:
> > > > I think this is a problem we created for ourselves back in commit:
> > > > 
> > > >   15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return)
> > > > 
> > > > AFAICT, the perf regs samples are the only place this matters, since for
> > > > ptrace the compat regs are implicitly truncated to compat_ulong_t, and
> > > > audit expects the non-truncated return value. Other architectures don't
> > > > truncate here, so I think we're setting ourselves up for a game of
> > > > whack-a-mole to truncate and extend wherever we need to.
> > > > 
> > > > Given that, I suspect it'd be better to do something like the below.
> > > > 
> > > > Will, thoughts?
> > > 
> > > I think perf is one example, but this is also visible to userspace via the
> > > native ptrace interface and I distinctly remember needing this for some
> > > versions of arm64 strace to work correctly when tracing compat tasks.
> > 
> > FWIW, you've convinced me on your approach (more on that below), but
> > when I went digging here this didn't seem to be exposed via ptrace --
> > for any task tracing a compat task, the GPRs are exposed via
> > compat_gpr_{get,set}(), which always truncate to compat_ulong_t, giving
> > the lower 32 bits. See task_user_regset_view() for where we get the
> > regset.
> > 
> > Am I missing something, or are you thinking of another issue you fixed
> > at the same time?
> 
> I think it may depend on whether strace pokes at the GPRs or instead issues
> a PTRACE_GET_SYSCALL_INFO request but I've forgotten the details,
> unfortunately. I do remember seeing an issue though, and it was only last
> year.

Ah; I hadn't spotted PTRACE_GET_SYSCALL_INFO, thanks for the pointer. I
see that gets at the regs via syscall_get_arguments(), which doesn't
truncate them.

That makes me wonder whether x86 and others do the right thing here...

> > > So I do think that clearing the upper bits on the return path is the right
> > > approach, but it sounds like we need some more work to handle syscall(-1)
> > > and audit (what exactly is the problem here after these patches have been
> > > applied?)
> > 
> > From digging a bit more, I think I agree, and I think these patches are
> > sufficient for audit. I have some comments I'll leave separately.
> > 
> > The remaining issues are wherever we assign a signed value to a compat
> > GPR without explicit truncation. That'll leak via perf sampling the user
> > regs, but I haven't managed to convince myself whether that causes any
> > functional change in behaviour for audit, seccomp, or syscall tracing.
> > 
> > Since we mostly use compat_ulong_t for intermediate values in compat
> > code, it does look like this is only an issue for x0 where we assign an
> > error value, e.g. the -ENOSYS case in el0_svc_common. I'll go see if I
> > can find any more.
> > 
> > With those fixed up we can remove the x0 truncation from entry.S,
> > which'd be nice too.
> 
> If we remove that then we should probably have a (debug?) check on the
> return-to-user path just to make sure.

I've hacked that up locally; I'd certainly like to run that along with
some other sanity checks (e.g. PSTATE) while fuzzing, but agree that's
probably not something to enable in any defconfig build.

I'm happy to add that later as and when I remove the bit from entry.S.

Thanks,
Mark.
