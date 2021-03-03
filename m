Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F632B722
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357445AbhCCKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhCBX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:56:11 -0500
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4DC061797;
        Tue,  2 Mar 2021 15:42:26 -0800 (PST)
Date:   Tue, 2 Mar 2021 23:39:25 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
Message-ID: <20210302233925.081075e0@sf>
In-Reply-To: <20210221002554.333076-2-slyfox@gentoo.org>
References: <20210221002554.333076-1-slyfox@gentoo.org>
        <20210221002554.333076-2-slyfox@gentoo.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Feb 2021 00:25:54 +0000
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> In https://bugs.gentoo.org/769614 Dmitry noticed that
> `ptrace(PTRACE_GET_SYSCALL_INFO)` does not return error sign properly.
> 
> The bug is in mismatch between get/set errors:
> 
> static inline long syscall_get_error(struct task_struct *task,
>                                      struct pt_regs *regs)
> {
>         return regs->r10 == -1 ? regs->r8:0;
> }
> 
> static inline long syscall_get_return_value(struct task_struct *task,
>                                             struct pt_regs *regs)
> {
>         return regs->r8;
> }
> 
> static inline void syscall_set_return_value(struct task_struct *task,
>                                             struct pt_regs *regs,
>                                             int error, long val)
> {
>         if (error) {
>                 /* error < 0, but ia64 uses > 0 return value */
>                 regs->r8 = -error;
>                 regs->r10 = -1;
>         } else {
>                 regs->r8 = val;
>                 regs->r10 = 0;
>         }
> }
> 
> Tested on v5.10 on rx3600 machine (ia64 9040 CPU).
> 
> CC: linux-ia64@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Bug: https://bugs.gentoo.org/769614
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  arch/ia64/include/asm/syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
> index 6c6f16e409a8..0d23c0049301 100644
> --- a/arch/ia64/include/asm/syscall.h
> +++ b/arch/ia64/include/asm/syscall.h
> @@ -32,7 +32,7 @@ static inline void syscall_rollback(struct task_struct *task,
>  static inline long syscall_get_error(struct task_struct *task,
>  				     struct pt_regs *regs)
>  {
> -	return regs->r10 == -1 ? regs->r8:0;
> +	return regs->r10 == -1 ? -regs->r8:0;
>  }
>  
>  static inline long syscall_get_return_value(struct task_struct *task,
> -- 
> 2.30.1
> 

Andrew, would it be fine to pass it through misc tree?
Or should it go through Oleg as it's mostly about ptrace?

-- 

  Sergei
