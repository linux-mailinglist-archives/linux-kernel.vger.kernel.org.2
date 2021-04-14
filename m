Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4E35FCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhDNVDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhDNVDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:03:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62857C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:02:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso13170683pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UNiXmh33gM3qS0FOiDfXRI3gMFMKu7/rvgZO8KzNOiY=;
        b=u0fnXTpVsEGoPFPkAh/6LfZAlBoxyym0Rocaxk498N+SwZO8Xqr08r04o/3l9YTIDo
         7Au3zL4IVXAB9lLFQowD/3rOM3XXNnls5l5Klql07LDxyGs7w0obH3Mtlmzg1+C7CVpb
         pqqn38DnhiIcpsBEEams4qrdh+SWeAqKvCW2B731ShKGovLsS4gWVS83dNehow8U1B0v
         A1mhVbjSDX8PTrz10Bxu2pxVM5J7HytFdAOOelBEwgF14mG96ieXlxxB0y5y09Jw1x/y
         t0PEyuVoSGvgFh3l9DEMCPrLdiDaKOmFhlFqsYTng7QVk8txDN+eBpuuy44hRhYog1Ql
         4ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UNiXmh33gM3qS0FOiDfXRI3gMFMKu7/rvgZO8KzNOiY=;
        b=E22tor2I7cPthL5v5MrHhx40XXI8u76EkpntUj48t2/9NcoXrzPLTW4Nb1VD3Eg9QL
         NceqPUzIjOHCt8aM0AJBQwZMgz8SSVus35Wywk9pIut2cnaSpEMrjYSgHrFdRYhSFgyQ
         7oTO++teH8U+LBkDOAW9B+EV6pj6EtD/UKOQ7XMZoecM0fgXI83XgIwpo91k5vKScG7e
         PJLT91pkI6Ot4EjbZ5ZHbNqPOcFqOTJMGAIscMyj66lW8eY+BHDrGjdP3QidzJ//G/bD
         iZ1ephY2BC6XMTDIpwOmo7MRVKKwUgcynENpSsyGILqQjhqKUn1SzlEVO+VRPNsuj9wE
         vdTw==
X-Gm-Message-State: AOAM531Uh4mlbjm4O/ITJq812DetZsHbBuZMt5URiHfY7WXt3pODxU9s
        qQ1to3lA5bIIozpw+bQPUwI=
X-Google-Smtp-Source: ABdhPJyXSDeamwRRE3yl4KyzbzFQqsCd3zzVg9u6w2eCOFpVC1eGMY23VQF30b979LhymEFZBKok/w==
X-Received: by 2002:a17:903:308b:b029:eb:5fd0:87ea with SMTP id u11-20020a170903308bb02900eb5fd087eamr144494plc.47.1618434172885;
        Wed, 14 Apr 2021 14:02:52 -0700 (PDT)
Received: from localhost (g191.124-44-145.ppp.wakwak.ne.jp. [124.44.145.191])
        by smtp.gmail.com with ESMTPSA id b21sm255987pji.39.2021.04.14.14.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:02:52 -0700 (PDT)
Date:   Thu, 15 Apr 2021 06:02:49 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <20210414210249.GK3288043@lianli.shorne-pla.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <YHbj987Ks0JOKw/X@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbj987Ks0JOKw/X@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:45:43PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 14, 2021 at 12:16:38PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 14, 2021 at 11:05:24AM +0200, Peter Zijlstra wrote:
> > 
> > > That made me look at the qspinlock code, and queued_spin_*lock() uses
> > > atomic_try_cmpxchg_acquire(), which means any arch that uses qspinlock
> > > and has RCpc atomics will give us massive pain.
> > > 
> > > Current archs using qspinlock are: x86, arm64, power, sparc64, mips and
> > > openrisc (WTF?!).
> > > 
> > > Of those, x86 and sparc are TSO archs with SC atomics, arm64 has RCsc
> > > atomics, power has RCtso atomics (and is the arch we all hate for having
> > > RCtso locks).
> > > 
> > > Now MIPS has all sorts of ill specified barriers, but last time looked
> > > at it it didn't actually use any of that and stuck to using smp_mb(), so
> > > it will have RCsc atomics.
> > > 
> > > /me goes look at wth openrisc is..  doesn't even appear to have
> > > asm/barrier.h :-/ Looking at wikipedia it also doesn't appear to
> > > actually have hardware ...
> > 
> > FWIW this is broken, anything SMP *MUST* define mb(), at the very least.
> 
> As near as I can tell this should do. The arch spec only lists this one
> instruction and the text makes it sound like a completion barrier.

Yes, I will submit this patch.

The l.msync instruction completes all load/store operations.
The l.lwa/l.swa pair (used for xchg/cmpxchg) also implies l.msync.

> ---
>  arch/openrisc/include/asm/barrier.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
> new file mode 100644
> index 000000000000..7538294721be
> --- /dev/null
> +++ b/arch/openrisc/include/asm/barrier.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_BARRIER_H
> +#define __ASM_BARRIER_H
> +
> +#define mb() asm volatile ("l.msync" ::: "memory")
> +
> +#include <asm-generic/barrier.h>
> +
> +#endif /* __ASM_BARRIER_H */
