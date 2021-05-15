Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CFD381B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhEOVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhEOVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 17:49:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37FC061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 14:47:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a11so1215718plh.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82QdE9J4wKm3e2XYmonXH+Z0bxnNpYp5wBpLxORTDvg=;
        b=rZtSzDOgrQOHCS12M+nhlQLrICBavWTWDJdA8pqEa7AiDEt+bjTbJStY83CIz1PGm+
         HMhnv39w0dcabWDQWav/TPr2gjF+/X11l8WAQrRULEU19/4YUHsLrpFruNQWYzh3+iLh
         g9A9y0hkD+YC+5rO2Rl0y/hLXH0gNgwEVqJvgMBq67pjMCD/ijlLpXjS9g6HnCAOpRNa
         3Rm58uc4rtDuXLoN7qtsX3zY1NbLtOA/HRIlwCfpMNxtVXEO3NGPb8+qDtuFl+5KsG0t
         0bvcsJrrUBuE4y1oJksUdgEmG7rBNWo45EnwXCg1H48w607SdFHGpj3bLA2dbLZPRlll
         270A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82QdE9J4wKm3e2XYmonXH+Z0bxnNpYp5wBpLxORTDvg=;
        b=diryBSPhZYrDI0VCBxe9HuTkx+2C2fTbcy5jFF7hcKR4d1n2qInrSRYIJsjCTLHWD8
         jDuwKo8wRlGgb6W8fNjFrHVBIC5Jmo1Mb/xBx9VxNSCOfP4kOv9Yrm9XCWkfWm6GFbZ0
         pPhb5QaNONCQuKy4LZtAqOV3gBXB5DbGoVkojKD+UE4HMpYQd8AnqKUFWSwZdLWNVg3W
         FhjxtwyI1u61CvXVpocn4ngHE4Kob4m7aPWjJVjMeUZchA3zsTb4Y4chU+V0++Gm48M3
         M4JYfSRAAlZXCgsSU5CtCR6vrLZ6MKnEh7rKyDBfLO6sw4fVgvI05E6h2zHHtBPhLpdb
         QnIQ==
X-Gm-Message-State: AOAM533dvVPcNIFI95oswRhJacSP1dNebIe0klrr0eeCBF8Qm8AFpMTD
        erNSqqTCYtXnMOTtv50nxH8=
X-Google-Smtp-Source: ABdhPJz+0wVvKsWz6Oeb55zf+JqJIvAmIkQvBCXgAFj8UACy6MBuijDIDf78pqmGQk7Ph5jBKr4+dQ==
X-Received: by 2002:a17:903:208a:b029:ef:9465:ad10 with SMTP id d10-20020a170903208ab02900ef9465ad10mr16924406plc.53.1621115278028;
        Sat, 15 May 2021 14:47:58 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id g13sm7052431pfi.18.2021.05.15.14.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 14:47:57 -0700 (PDT)
Date:   Sun, 16 May 2021 06:47:55 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        green.hu@gmail.com, guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mattst88@gmail.com, monstr@monstr.eu, mpe@ellerman.id.au,
        nickhu@andestech.com, palmer@dabbelt.com, paulus@samba.org,
        paul.walmsley@sifive.com, rth@twiddle.net,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: Re: [PATCH 25/33] locking/atomic: openrisc: move to ARCH_ATOMIC
Message-ID: <YKBBiyKGvratENwN@antec>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-26-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510093753.40683-26-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:37:45AM +0100, Mark Rutland wrote:
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
> 
> As a step towards that, this patch migrates openrisc to ARCH_ATOMIC. The
> arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> code wraps these with optional instrumentation to provide the regular
> functions.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/openrisc/Kconfig               |  1 +
>  arch/openrisc/include/asm/atomic.h  | 42 ++++++++++++++++++++-----------------
>  arch/openrisc/include/asm/cmpxchg.h |  4 ++--
>  3 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 591acc5990dc..8c50bc9674f5 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -7,6 +7,7 @@
>  config OPENRISC
>  	def_bool y
>  	select ARCH_32BIT_OFF_T
> +	select ARCH_ATOMIC
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
> index cb86970d3859..326167e4783a 100644
> --- a/arch/openrisc/include/asm/atomic.h
> +++ b/arch/openrisc/include/asm/atomic.h
> @@ -13,7 +13,7 @@
>  
>  /* Atomically perform op with v->counter and i */
>  #define ATOMIC_OP(op)							\
> -static inline void atomic_##op(int i, atomic_t *v)			\
> +static inline void arch_atomic_##op(int i, atomic_t *v)			\
>  {									\
>  	int tmp;							\
>  									\
> @@ -30,7 +30,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
>  
>  /* Atomically perform op with v->counter and i, return the result */
>  #define ATOMIC_OP_RETURN(op)						\
> -static inline int atomic_##op##_return(int i, atomic_t *v)		\
> +static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
>  {									\
>  	int tmp;							\
>  									\
> @@ -49,7 +49,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
>  
>  /* Atomically perform op with v->counter and i, return orig v->counter */
>  #define ATOMIC_FETCH_OP(op)						\
> -static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  {									\
>  	int tmp, old;							\
>  									\
> @@ -75,6 +75,8 @@ ATOMIC_FETCH_OP(and)
>  ATOMIC_FETCH_OP(or)
>  ATOMIC_FETCH_OP(xor)
>  
> +ATOMIC_OP(add)
> +ATOMIC_OP(sub)
>  ATOMIC_OP(and)
>  ATOMIC_OP(or)
>  ATOMIC_OP(xor)
> @@ -83,16 +85,18 @@ ATOMIC_OP(xor)
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> -#define atomic_add_return	atomic_add_return
> -#define atomic_sub_return	atomic_sub_return
> -#define atomic_fetch_add	atomic_fetch_add
> -#define atomic_fetch_sub	atomic_fetch_sub
> -#define atomic_fetch_and	atomic_fetch_and
> -#define atomic_fetch_or		atomic_fetch_or
> -#define atomic_fetch_xor	atomic_fetch_xor
> -#define atomic_and	atomic_and
> -#define atomic_or	atomic_or
> -#define atomic_xor	atomic_xor
> +#define arch_atomic_add_return	arch_atomic_add_return
> +#define arch_atomic_sub_return	arch_atomic_sub_return
> +#define arch_atomic_fetch_add	arch_atomic_fetch_add
> +#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
> +#define arch_atomic_fetch_and	arch_atomic_fetch_and
> +#define arch_atomic_fetch_or	arch_atomic_fetch_or
> +#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
> +#define arch_atomic_add		arch_atomic_add
> +#define arch_atomic_sub		arch_atomic_sub
> +#define arch_atomic_and		arch_atomic_and
> +#define arch_atomic_or		arch_atomic_or
> +#define arch_atomic_xor		arch_atomic_xor
>  
>  /*
>   * Atomically add a to v->counter as long as v is not already u.
> @@ -100,7 +104,7 @@ ATOMIC_OP(xor)
>   *
>   * This is often used through atomic_inc_not_zero()
>   */
> -static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
> +static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {
>  	int old, tmp;
>  
> @@ -119,14 +123,14 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  
>  	return old;
>  }
> -#define atomic_fetch_add_unless	atomic_fetch_add_unless
> +#define arch_atomic_fetch_add_unless	arch_atomic_fetch_add_unless
>  
> -#define atomic_read(v)			READ_ONCE((v)->counter)
> -#define atomic_set(v,i)			WRITE_ONCE((v)->counter, (i))
> +#define arch_atomic_read(v)		READ_ONCE((v)->counter)
> +#define arch_atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
>  
>  #include <asm/cmpxchg.h>
>  
> -#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
> -#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
> +#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
> +#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
>  
>  #endif /* __ASM_OPENRISC_ATOMIC_H */
> diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
> index f9cd43a39d72..79fd16162ccb 100644
> --- a/arch/openrisc/include/asm/cmpxchg.h
> +++ b/arch/openrisc/include/asm/cmpxchg.h
> @@ -132,7 +132,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>  	}
>  }
>  
> -#define cmpxchg(ptr, o, n)						\
> +#define arch_cmpxchg(ptr, o, n)						\
>  	({								\
>  		(__typeof__(*(ptr))) __cmpxchg((ptr),			\
>  					       (unsigned long)(o),	\
> @@ -161,7 +161,7 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long with,
>  	}
>  }
>  
> -#define xchg(ptr, with) 						\
> +#define arch_xchg(ptr, with) 						\
>  	({								\
>  		(__typeof__(*(ptr))) __xchg((ptr),			\
>  					    (unsigned long)(with),	\

I was questioning some of this so I took your branch for a spin.  This builds
and boots and all looks good to me on OpenRISC.

The changes all look good, I was just wondering if all of the refactors were
done correctly for OpenRISC.

Acked-by: Stafford Horne <shorne@gmail.com>
