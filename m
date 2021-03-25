Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866F2349C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCYV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhCYV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:59:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B05C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:59:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l3so3436609pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Zsnn8pso6szUQsAjCpqSbmAJBJ6ZCI4v7Sc/zsP40o8=;
        b=E4VyPGq2dPub4V6Jjd+TH0ugNkX3Bi4zeaRU2ExF6mC8hqbrhxm3/AsypxRCwWSu5F
         1gvFHxxjSCnfqOgRjxgf4j/S/rGU5WrJTLLPMMYl3dE7w1e9kX0bnmSksoBcnNnihdzq
         U2BpBHfLqQfIGdMPxk4zxTjwEJPk2Dw0JQROE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zsnn8pso6szUQsAjCpqSbmAJBJ6ZCI4v7Sc/zsP40o8=;
        b=HjvXsV7sH6uCOfxTrXK6P3kSNWRgjfL7njJ3EIuinnkNFvqoszoDZaHtyMbkyHCUw4
         8lmSE27vmxDkfGwhoJa+Go0HybcuiGb3fYv1diApsLN3EySxUsLPBqeA3UiuRCRTVV1F
         w1qXCHfP2c2JLUkSJX2NtldyuDhu1oVPY57pjGaEbBEp0BLGtMmll0Gw1I0c2UEjDsZD
         2/JGYfM+djZj10KH0GmJAHCqqOkYuminM0yHFo5+dj/ORhQwVUVTztvuxRxOCj6SSZeq
         tR1f20TPmfW5lmjQMNs//M3SMz8OWai2zkNQ9ePHIg/VC1G9ef2Uppxov4ahM83coDVc
         bD+g==
X-Gm-Message-State: AOAM532u41Btb6t2h1rWR86qjxZoR2y9x2v3bSkpN7emJIFhgmcsF15/
        Wyur8Hprcjh2mwHwXsPTh/WZ4axsH42FIw==
X-Google-Smtp-Source: ABdhPJyA2oEKhViwkPh1P5hbZjroAu9KTgv8yWP4Bw8pQhjyp6gxRlSpoKBALiVXJbhObfL1/Cx+pA==
X-Received: by 2002:a17:902:710b:b029:e6:ef44:5c85 with SMTP id a11-20020a170902710bb02900e6ef445c85mr11806732pll.34.1616709549479;
        Thu, 25 Mar 2021 14:59:09 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-5199-f2bf-3cbb-22e6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:5199:f2bf:3cbb:22e6])
        by smtp.gmail.com with ESMTPSA id u4sm6631014pfk.131.2021.03.25.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:59:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 05/15] powerpc/uaccess: Move get_user_instr helpers in asm/inst.h
In-Reply-To: <2c6e83581b4fa434aa7cf2fa7714c41e98f57007.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu> <2c6e83581b4fa434aa7cf2fa7714c41e98f57007.1615398265.git.christophe.leroy@csgroup.eu>
Date:   Fri, 26 Mar 2021 08:59:05 +1100
Message-ID: <87a6qqki8m.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> Those helpers use get_user helpers but they don't participate
> in their implementation, so they do not belong to asm/uaccess.h
>
> Move them in asm/inst.h

Hmm, is asm/inst.h the right place for this?

asm/inst.h seems to be entirely concerned with the ppc_inst type:
converting things to and from ppc_inst, print ppc_inst as a string,
dealing with prefixed instructs, etc., etc. The only things currently
that look at memory are the probe_user_read_inst and
probe_kernel_read_inst prototypes...

Having said that, I'm not sure quite where else to put it, and none of
the other places in arch/powerpc/include that currently reference
ppc_inst seem any better...

If we do use asm/inst.h, I think maybe it makes sense to put the
code towards the end rather than at the start, as uses structs and calls
macros that are defined later on in the function.

Kind regards,
Daniel

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/inst.h    | 34 ++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/uaccess.h | 34 ------------------------------
>  2 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> index cc73c1267572..19e18af2fac9 100644
> --- a/arch/powerpc/include/asm/inst.h
> +++ b/arch/powerpc/include/asm/inst.h
> @@ -4,6 +4,40 @@
>  
>  #include <asm/ppc-opcode.h>
>  
> +#ifdef CONFIG_PPC64
> +
> +#define ___get_user_instr(gu_op, dest, ptr)				\
> +({									\
> +	long __gui_ret = 0;						\
> +	unsigned long __gui_ptr = (unsigned long)ptr;			\
> +	struct ppc_inst __gui_inst;					\
> +	unsigned int __prefix, __suffix;				\
> +	__gui_ret = gu_op(__prefix, (unsigned int __user *)__gui_ptr);	\
> +	if (__gui_ret == 0) {						\
> +		if ((__prefix >> 26) == OP_PREFIX) {			\
> +			__gui_ret = gu_op(__suffix,			\
> +				(unsigned int __user *)__gui_ptr + 1);	\
> +			__gui_inst = ppc_inst_prefix(__prefix,		\
> +						     __suffix);		\
> +		} else {						\
> +			__gui_inst = ppc_inst(__prefix);		\
> +		}							\
> +		if (__gui_ret == 0)					\
> +			(dest) = __gui_inst;				\
> +	}								\
> +	__gui_ret;							\
> +})
> +#else /* !CONFIG_PPC64 */
> +#define ___get_user_instr(gu_op, dest, ptr)				\
> +	gu_op((dest).val, (u32 __user *)(ptr))
> +#endif /* CONFIG_PPC64 */
> +
> +#define get_user_instr(x, ptr) \
> +	___get_user_instr(get_user, x, ptr)
> +
> +#define __get_user_instr(x, ptr) \
> +	___get_user_instr(__get_user, x, ptr)
> +
>  /*
>   * Instruction data type for POWER
>   */
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 01aea0df4dd0..eaa828a6a419 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -53,40 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
>  #define __put_user(x, ptr) \
>  	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
>  
> -#ifdef CONFIG_PPC64
> -
> -#define ___get_user_instr(gu_op, dest, ptr)				\
> -({									\
> -	long __gui_ret = 0;						\
> -	unsigned long __gui_ptr = (unsigned long)ptr;			\
> -	struct ppc_inst __gui_inst;					\
> -	unsigned int __prefix, __suffix;				\
> -	__gui_ret = gu_op(__prefix, (unsigned int __user *)__gui_ptr);	\
> -	if (__gui_ret == 0) {						\
> -		if ((__prefix >> 26) == OP_PREFIX) {			\
> -			__gui_ret = gu_op(__suffix,			\
> -				(unsigned int __user *)__gui_ptr + 1);	\
> -			__gui_inst = ppc_inst_prefix(__prefix,		\
> -						     __suffix);		\
> -		} else {						\
> -			__gui_inst = ppc_inst(__prefix);		\
> -		}							\
> -		if (__gui_ret == 0)					\
> -			(dest) = __gui_inst;				\
> -	}								\
> -	__gui_ret;							\
> -})
> -#else /* !CONFIG_PPC64 */
> -#define ___get_user_instr(gu_op, dest, ptr)				\
> -	gu_op((dest).val, (u32 __user *)(ptr))
> -#endif /* CONFIG_PPC64 */
> -
> -#define get_user_instr(x, ptr) \
> -	___get_user_instr(get_user, x, ptr)
> -
> -#define __get_user_instr(x, ptr) \
> -	___get_user_instr(__get_user, x, ptr)
> -
>  extern long __put_user_bad(void);
>  
>  #define __put_user_size(x, ptr, size, retval)			\
> -- 
> 2.25.0
