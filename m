Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0653036718D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbhDURlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:41:47 -0400
Received: from foss.arm.com ([217.140.110.172]:38818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243098AbhDURlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:41:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A92E311FB;
        Wed, 21 Apr 2021 10:41:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.3.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1FBB3F694;
        Wed, 21 Apr 2021 10:41:08 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:41:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: syscall.h: Add sign extension handling in
 syscall_get_return_value for compat
Message-ID: <20210421174105.GB52940@C02TD0UTHF1T.local>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416075533.7720-2-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416075533.7720-2-zhe.he@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:55:32PM +0800, He Zhe wrote:
> Add sign extension handling in syscall_get_return_value so that it can
> handle 32-bit compatible case and can be used by for example audit, just
> like what syscall_get_error does.

If a compat syscall can ever legitimately return a non-error value with
bit 31 set, and this sign-extends it, is that ever going to reach
userspace as a 64-bit value?

IIUC things like mmap() can return pointers above 2GiB for a compat
task, so I'm a bit uneasy that we'd handle those wrong. I can't see a
way of preventing that unless we keep the upper 32 bits for errors.

Mark.

> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  arch/arm64/include/asm/syscall.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index cfc0672013f6..cd7a22787aeb 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -44,7 +44,12 @@ static inline long syscall_get_error(struct task_struct *task,
>  static inline long syscall_get_return_value(struct task_struct *task,
>  					    struct pt_regs *regs)
>  {
> -	return regs->regs[0];
> +	long val = regs->regs[0];
> +
> +	if (is_compat_thread(task_thread_info(task)))
> +		val = sign_extend64(val, 31);
> +
> +	return val;
>  }
>  
>  static inline void syscall_set_return_value(struct task_struct *task,
> -- 
> 2.17.1
> 
