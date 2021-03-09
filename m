Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03113332232
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCIJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:39:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:48242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhCIJjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:39:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C85F4AB8C;
        Tue,  9 Mar 2021 09:39:13 +0000 (UTC)
Date:   Tue, 9 Mar 2021 10:39:12 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     npiggin@gmail.com, Davidlohr Bueso <dbueso@suse.de>,
        peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulus@samba.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/3] powerpc/qspinlock: Use generic smp_cond_load_relaxed
Message-ID: <20210309093912.GW6564@kitsune.suse.cz>
References: <20210309015950.27688-1-dave@stgolabs.net>
 <20210309015950.27688-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309015950.27688-4-dave@stgolabs.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:59:50PM -0800, Davidlohr Bueso wrote:
> 49a7d46a06c3 (powerpc: Implement smp_cond_load_relaxed()) added
> busy-waiting pausing with a preferred SMT priority pattern, lowering
> the priority (reducing decode cycles) during the whole loop slowpath.
> 
> However, data shows that while this pattern works well with simple
                                              ^^^^^^^^^^^^^^^^^^^^^^
> spinlocks, queued spinlocks benefit more being kept in medium priority,
> with a cpu_relax() instead, being a low+medium combo on powerpc.
...
> 
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index aecfde829d5d..7ae29cfb06c0 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -80,22 +80,6 @@ do {									\
>  	___p1;								\
>  })
>  
> -#ifdef CONFIG_PPC64
Maybe it should be kept for the simple spinlock case then?

Thanks

Michal
> -#define smp_cond_load_relaxed(ptr, cond_expr) ({		\
> -	typeof(ptr) __PTR = (ptr);				\
> -	__unqual_scalar_typeof(*ptr) VAL;			\
> -	VAL = READ_ONCE(*__PTR);				\
> -	if (unlikely(!(cond_expr))) {				\
> -		spin_begin();					\
> -		do {						\
> -			VAL = READ_ONCE(*__PTR);		\
> -		} while (!(cond_expr));				\
> -		spin_end();					\
> -	}							\
> -	(typeof(*ptr))VAL;					\
> -})
> -#endif
> -
>  #ifdef CONFIG_PPC_BOOK3S_64
>  #define NOSPEC_BARRIER_SLOT   nop
>  #elif defined(CONFIG_PPC_FSL_BOOK3E)
> -- 
> 2.26.2
> 
