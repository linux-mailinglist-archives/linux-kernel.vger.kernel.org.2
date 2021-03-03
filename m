Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07CD32C34C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhCDAHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:07:21 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36056 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhCCVmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:42:40 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BC10672C8B8;
        Thu,  4 Mar 2021 00:40:53 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id AAEF27CC8A2; Thu,  4 Mar 2021 00:40:53 +0300 (MSK)
Date:   Thu, 4 Mar 2021 00:40:53 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
Message-ID: <20210303214053.GA19445@altlinux.org>
References: <20210221002554.333076-1-slyfox@gentoo.org>
 <20210221002554.333076-2-slyfox@gentoo.org>
 <20210302233925.081075e0@sf>
 <20210303143018.GB28955@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303143018.GB28955@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 03:30:19PM +0100, Oleg Nesterov wrote:
> On 03/02, Sergei Trofimovich wrote:
> >
> > > --- a/arch/ia64/include/asm/syscall.h
> > > +++ b/arch/ia64/include/asm/syscall.h
> > > @@ -32,7 +32,7 @@ static inline void syscall_rollback(struct task_struct *task,
> > >  static inline long syscall_get_error(struct task_struct *task,
> > >  				     struct pt_regs *regs)
> > >  {
> > > -	return regs->r10 == -1 ? regs->r8:0;
> > > +	return regs->r10 == -1 ? -regs->r8:0;
> > >  }
> > >
> > >  static inline long syscall_get_return_value(struct task_struct *task,
> > > --
> > > 2.30.1
> > >
> >
> > Andrew, would it be fine to pass it through misc tree?
> > Or should it go through Oleg as it's mostly about ptrace?
> 
> We usually route ptrace fixes via mm tree.
> 
> But this fix and another patch from you "ia64: fix ia64_syscall_get_set_arguments()
> for break-based syscalls" look very much ia64 specific. I don't think it's actually
> about ptrace, and I didn't even try to review these patches because I do not
> understand this low level ia64 code.
> 
> Can it be routed via ia64 tree? Add Tony and Fenghua...

Apparently [1], ia64 architecture is now orphaned, so we don't have this
option anymore.

[1] https://git.kernel.org/torvalds/c/96ec72a3425d1515b69b7f9dc34a4a6ce5862a37


-- 
ldv
