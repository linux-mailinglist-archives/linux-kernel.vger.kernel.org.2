Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1003686DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhDVS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:58:20 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41380 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVS6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:58:20 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3CB5672C8B5;
        Thu, 22 Apr 2021 21:57:43 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 2EEC27CC69B; Thu, 22 Apr 2021 21:57:43 +0300 (MSK)
Date:   Thu, 22 Apr 2021 21:57:43 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        He Zhe <zhe.he@windriver.com>, oleg@redhat.com,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Message-ID: <20210422185743.GC12226@altlinux.org>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com>
 <20210416133431.GA2303@C02TD0UTHF1T.local>
 <20210419121932.GA30004@willie-the-truck>
 <20210421171005.GA46949@C02TD0UTHF1T.local>
 <20210422160752.GA2214@willie-the-truck>
 <20210422164228.GD66392@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422164228.GD66392@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 05:42:28PM +0100, Mark Rutland wrote:
> On Thu, Apr 22, 2021 at 05:07:53PM +0100, Will Deacon wrote:
> > On Wed, Apr 21, 2021 at 06:10:05PM +0100, Mark Rutland wrote:
> > > On Mon, Apr 19, 2021 at 01:19:33PM +0100, Will Deacon wrote:
> > > > On Fri, Apr 16, 2021 at 02:34:41PM +0100, Mark Rutland wrote:
> > > > > I think this is a problem we created for ourselves back in commit:
> > > > > 
> > > > >   15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return)
> > > > > 
> > > > > AFAICT, the perf regs samples are the only place this matters, since for
> > > > > ptrace the compat regs are implicitly truncated to compat_ulong_t, and
> > > > > audit expects the non-truncated return value. Other architectures don't
> > > > > truncate here, so I think we're setting ourselves up for a game of
> > > > > whack-a-mole to truncate and extend wherever we need to.
> > > > > 
> > > > > Given that, I suspect it'd be better to do something like the below.
> > > > > 
> > > > > Will, thoughts?
> > > > 
> > > > I think perf is one example, but this is also visible to userspace via the
> > > > native ptrace interface and I distinctly remember needing this for some
> > > > versions of arm64 strace to work correctly when tracing compat tasks.
> > > 
> > > FWIW, you've convinced me on your approach (more on that below), but
> > > when I went digging here this didn't seem to be exposed via ptrace --
> > > for any task tracing a compat task, the GPRs are exposed via
> > > compat_gpr_{get,set}(), which always truncate to compat_ulong_t, giving
> > > the lower 32 bits. See task_user_regset_view() for where we get the
> > > regset.
> > > 
> > > Am I missing something, or are you thinking of another issue you fixed
> > > at the same time?
> > 
> > I think it may depend on whether strace pokes at the GPRs or instead issues
> > a PTRACE_GET_SYSCALL_INFO request but I've forgotten the details,
> > unfortunately. I do remember seeing an issue though, and it was only last
> > year.
> 
> Ah; I hadn't spotted PTRACE_GET_SYSCALL_INFO, thanks for the pointer. I
> see that gets at the regs via syscall_get_arguments(), which doesn't
> truncate them.
> 
> That makes me wonder whether x86 and others do the right thing here...

Yes, some architectures had to be fixed, but they mostly do the right
thing nowadays.

Feel free to use tools/testing/selftests/ptrace/get_syscall_info.c for
testing, or indeed use strace test suite.


-- 
ldv
