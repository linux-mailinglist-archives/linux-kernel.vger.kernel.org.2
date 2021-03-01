Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF732A02F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575470AbhCBD4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhCAWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:43:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07895C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:42:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s16so10826866plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=eE+wCAbXzOx+xliJRDgITRoOiejbPuH1lpWx1d+n1NY=;
        b=brUBn8I+68ODAQC8lx6Is9c63sYftvC5y0bh9EXjpzfI3qhxHMDodUgbLgV2F15MIC
         KWhMvu/Mif83OOkvSfYZWC19yQvB5chwZFW+rovHLkCCZOWXjo52se4GtMPgr+dDSRdu
         kXyThvEaji1xdUSQv00yfGQphIc8cIr/0SFZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eE+wCAbXzOx+xliJRDgITRoOiejbPuH1lpWx1d+n1NY=;
        b=HinGqYXXnJ24ckcDOilR5QmP0bC18/EmIg0703NWU2KpzmXNA+q3WofYK6Bc6O+UYK
         h/1y5qCUZ3PDNLG4Kw6ZJQqJ95I0Xb+HSLIgAx8IXftgmHVVEgMFR2La6/Fq3pfIAUHW
         H1NVb2MR2HJg0yQbfmCVK+9dUM+o+3QVFp+WuBz54fY22EdMiniO1i1uOxFOJzqFd8+4
         S/GSKQfAgUGCPK+zW8SUYSGGZwMn2bYMsLD450mvb6QDGmAzrQdCWj2PqPcvoRh2q7og
         J5aEU0lcCne/SxmqZKjKmZ0v3ISnsrh2PsZeMeJu5ZBdlpygoAsSJfVRAyGZYFsRuHbH
         7C9w==
X-Gm-Message-State: AOAM532CSon1b+wsD10ozKFpYJ0E6hsNyAEr9YaegBH3S629I3yOi+dX
        RkxvinvwFrHgxlr1UpqVY9auhg==
X-Google-Smtp-Source: ABdhPJz8LFXwIKs1W4H053Y5SQ5igvDhUTQUrlfpgjg2cnBDqR7E6oznRP9QHBuryEtXHgxnPGMa+Q==
X-Received: by 2002:a17:902:7404:b029:e4:503b:f83d with SMTP id g4-20020a1709027404b02900e4503bf83dmr763396pll.35.1614638567557;
        Mon, 01 Mar 2021 14:42:47 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b18e-89be-e1b2-4959.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b18e:89be:e1b2:4959])
        by smtp.gmail.com with ESMTPSA id o65sm17286437pfg.44.2021.03.01.14.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 14:42:47 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/15] powerpc/uaccess: Remove __get/put_user_inatomic()
In-Reply-To: <8732e0c78400c99ec418323ab6b0853b91752be4.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu> <8732e0c78400c99ec418323ab6b0853b91752be4.1614275314.git.christophe.leroy@csgroup.eu>
Date:   Tue, 02 Mar 2021 09:42:44 +1100
Message-ID: <87czwio5qz.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Since commit 662bbcb2747c ("mm, sched: Allow uaccess in atomic with
> pagefault_disable()"), __get/put_user() can be used in atomic parts
> of the code, therefore the __get/put_user_inatomic() introduced
> by commit e68c825bb016 ("[POWERPC] Add inatomic versions of __get_user
> and __put_user") have become useless.

I spent some time chasing these macro definitions.

Let me see if I understand you.

__get_user(x, ptr) becomes __get_user_nocheck(..., true)
__get_user_inatomic() become __get_user_nosleep()

The difference between how __get_user_nosleep() and
__get_user_nocheck(..., true) operate is that __get_user_nocheck calls
might_fault() and __get_user_nosleep() does not.

If I understand the commit you reference and mm/memory.c, you're saying
that we can indeed call might_fault() when page faults are disabled,
because __might_fault() checks if page faults are disabled and does not
fire a warning if it is called with page faults disabled.

Therefore, it is safe to remove our _inatomic version that does not call
might_fault and just to call might_fault unconditionally.

Is that right?

I haven't checked changes you made to the various .c files in fine
detail but they appear to be entirely mechanical.

> powerpc is the only one having such functions. There is a real
> intention not to have to provide such _inatomic() helpers, see the
> comment in might_fault() in mm/memory.c introduced by
> commit 3ee1afa308f2 ("x86: some lock annotations for user
> copy paths, v2"):
>
> 	/*
> 	 * it would be nicer only to annotate paths which are not under
> 	 * pagefault_disable, however that requires a larger audit and
> 	 * providing helpers like get_user_atomic.
> 	 */
>

I'm not fully sure I understand what you're saying in this part of the
commit message.

Kind regards,
Daniel

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/uaccess.h            | 37 -------------------
>  arch/powerpc/kernel/align.c                   | 32 ++++++++--------
>  .../kernel/hw_breakpoint_constraints.c        |  2 +-
>  arch/powerpc/kernel/traps.c                   |  2 +-
>  4 files changed, 18 insertions(+), 55 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index a08c482b1315..01aea0df4dd0 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -53,11 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
>  #define __put_user(x, ptr) \
>  	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
>  
> -#define __get_user_inatomic(x, ptr) \
> -	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
> -#define __put_user_inatomic(x, ptr) \
> -	__put_user_nosleep((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
> -
>  #ifdef CONFIG_PPC64
>  
>  #define ___get_user_instr(gu_op, dest, ptr)				\
> @@ -92,9 +87,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
>  #define __get_user_instr(x, ptr) \
>  	___get_user_instr(__get_user, x, ptr)
>  
> -#define __get_user_instr_inatomic(x, ptr) \
> -	___get_user_instr(__get_user_inatomic, x, ptr)
> -
>  extern long __put_user_bad(void);
>  
>  #define __put_user_size(x, ptr, size, retval)			\
> @@ -141,20 +133,6 @@ __pu_failed:							\
>  	__pu_err;							\
>  })
>  
> -#define __put_user_nosleep(x, ptr, size)			\
> -({								\
> -	long __pu_err;						\
> -	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
> -	__typeof__(*(ptr)) __pu_val = (x);			\
> -	__typeof__(size) __pu_size = (size);			\
> -								\
> -	__chk_user_ptr(__pu_addr);				\
> -	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
> -								\
> -	__pu_err;						\
> -})
> -
> -
>  /*
>   * We don't tell gcc that we are accessing memory, but this is OK
>   * because we do not write to any memory gcc knows about, so there
> @@ -320,21 +298,6 @@ do {								\
>  	__gu_err;							\
>  })
>  
> -#define __get_user_nosleep(x, ptr, size)			\
> -({								\
> -	long __gu_err;						\
> -	__long_type(*(ptr)) __gu_val;				\
> -	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
> -	__typeof__(size) __gu_size = (size);			\
> -								\
> -	__chk_user_ptr(__gu_addr);				\
> -	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err); \
> -	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
> -								\
> -	__gu_err;						\
> -})
> -
> -
>  /* more complex routines */
>  
>  extern unsigned long __copy_tofrom_user(void __user *to,
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index c7797eb958c7..83b199026a1e 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -174,18 +174,18 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
>  
>  		switch (nb) {
>  		case 8:
> -			ret |= __get_user_inatomic(temp.v[0], p++);
> -			ret |= __get_user_inatomic(temp.v[1], p++);
> -			ret |= __get_user_inatomic(temp.v[2], p++);
> -			ret |= __get_user_inatomic(temp.v[3], p++);
> +			ret |= __get_user(temp.v[0], p++);
> +			ret |= __get_user(temp.v[1], p++);
> +			ret |= __get_user(temp.v[2], p++);
> +			ret |= __get_user(temp.v[3], p++);
>  			fallthrough;
>  		case 4:
> -			ret |= __get_user_inatomic(temp.v[4], p++);
> -			ret |= __get_user_inatomic(temp.v[5], p++);
> +			ret |= __get_user(temp.v[4], p++);
> +			ret |= __get_user(temp.v[5], p++);
>  			fallthrough;
>  		case 2:
> -			ret |= __get_user_inatomic(temp.v[6], p++);
> -			ret |= __get_user_inatomic(temp.v[7], p++);
> +			ret |= __get_user(temp.v[6], p++);
> +			ret |= __get_user(temp.v[7], p++);
>  			if (unlikely(ret))
>  				return -EFAULT;
>  		}
> @@ -259,18 +259,18 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
>  		p = addr;
>  		switch (nb) {
>  		case 8:
> -			ret |= __put_user_inatomic(data.v[0], p++);
> -			ret |= __put_user_inatomic(data.v[1], p++);
> -			ret |= __put_user_inatomic(data.v[2], p++);
> -			ret |= __put_user_inatomic(data.v[3], p++);
> +			ret |= __put_user(data.v[0], p++);
> +			ret |= __put_user(data.v[1], p++);
> +			ret |= __put_user(data.v[2], p++);
> +			ret |= __put_user(data.v[3], p++);
>  			fallthrough;
>  		case 4:
> -			ret |= __put_user_inatomic(data.v[4], p++);
> -			ret |= __put_user_inatomic(data.v[5], p++);
> +			ret |= __put_user(data.v[4], p++);
> +			ret |= __put_user(data.v[5], p++);
>  			fallthrough;
>  		case 2:
> -			ret |= __put_user_inatomic(data.v[6], p++);
> -			ret |= __put_user_inatomic(data.v[7], p++);
> +			ret |= __put_user(data.v[6], p++);
> +			ret |= __put_user(data.v[7], p++);
>  		}
>  		if (unlikely(ret))
>  			return -EFAULT;
> diff --git a/arch/powerpc/kernel/hw_breakpoint_constraints.c b/arch/powerpc/kernel/hw_breakpoint_constraints.c
> index 867ee4aa026a..675d1f66ab72 100644
> --- a/arch/powerpc/kernel/hw_breakpoint_constraints.c
> +++ b/arch/powerpc/kernel/hw_breakpoint_constraints.c
> @@ -141,7 +141,7 @@ void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
>  {
>  	struct instruction_op op;
>  
> -	if (__get_user_instr_inatomic(*instr, (void __user *)regs->nip))
> +	if (__get_user_instr(*instr, (void __user *)regs->nip))
>  		return;
>  
>  	analyse_instr(&op, regs, *instr);
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1583fd1c6010..1fa36bd08efe 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -864,7 +864,7 @@ static void p9_hmi_special_emu(struct pt_regs *regs)
>  	unsigned long ea, msr, msr_mask;
>  	bool swap;
>  
> -	if (__get_user_inatomic(instr, (unsigned int __user *)regs->nip))
> +	if (__get_user(instr, (unsigned int __user *)regs->nip))
>  		return;
>  
>  	/*
> -- 
> 2.25.0
