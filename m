Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893ED368552
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhDVQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:56:26 -0400
Received: from foss.arm.com ([217.140.110.172]:53868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238156AbhDVQ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:56:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076B311D4;
        Thu, 22 Apr 2021 09:55:49 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A843F694;
        Thu, 22 Apr 2021 09:55:47 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:55:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: syscall.h: Add sign extension handling in
 syscall_get_return_value for compat
Message-ID: <20210422165545.GE66392@C02TD0UTHF1T.local>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416075533.7720-2-zhe.he@windriver.com>
 <20210421174105.GB52940@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421174105.GB52940@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:41:05PM +0100, Mark Rutland wrote:
> On Fri, Apr 16, 2021 at 03:55:32PM +0800, He Zhe wrote:
> > Add sign extension handling in syscall_get_return_value so that it can
> > handle 32-bit compatible case and can be used by for example audit, just
> > like what syscall_get_error does.
> 
> If a compat syscall can ever legitimately return a non-error value with
> bit 31 set, and this sign-extends it, is that ever going to reach
> userspace as a 64-bit value?
> 
> IIUC things like mmap() can return pointers above 2GiB for a compat
> task, so I'm a bit uneasy that we'd handle those wrong. I can't see a
> way of preventing that unless we keep the upper 32 bits for errors.

Looking at this with fresh eyes, I think we can more closely mirror
syscall_get_error(), and do something like:

static inline long syscall_get_return_value(struct task_struct *task,
					    struct pt_regs *regs)
{
	long val = regs->regs[0];
	long error = val;

	if (is_compat_thread(task_thread_info(task)))
		error = sign_extend64(error, 31);
	
	return IS_ERR_VALUE(error) ? error : val;
}

Thanks,
Mark.

> 
> Mark.
> 
> > 
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > ---
> >  arch/arm64/include/asm/syscall.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> > index cfc0672013f6..cd7a22787aeb 100644
> > --- a/arch/arm64/include/asm/syscall.h
> > +++ b/arch/arm64/include/asm/syscall.h
> > @@ -44,7 +44,12 @@ static inline long syscall_get_error(struct task_struct *task,
> >  static inline long syscall_get_return_value(struct task_struct *task,
> >  					    struct pt_regs *regs)
> >  {
> > -	return regs->regs[0];
> > +	long val = regs->regs[0];
> > +
> > +	if (is_compat_thread(task_thread_info(task)))
> > +		val = sign_extend64(val, 31);
> > +
> > +	return val;
> >  }
> >  
> >  static inline void syscall_set_return_value(struct task_struct *task,
> > -- 
> > 2.17.1
> > 
