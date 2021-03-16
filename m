Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5140F33D7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCPPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:38:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:40896 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhCPPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:37:55 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12GFXL1m029361;
        Tue, 16 Mar 2021 10:33:21 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 12GFXL3d029359;
        Tue, 16 Mar 2021 10:33:21 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 16 Mar 2021 10:33:20 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH mm] kfence: fix printk format for ptrdiff_t
Message-ID: <20210316153320.GF16691@gate.crashing.org>
References: <20210303121157.3430807-1-elver@google.com> <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com> <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:32:32AM +0100, Christophe Leroy wrote:
> +segher

I cannot see through the wood of #defines here, sorry.

> Still a problem.
> 
> I don't understand, gcc bug ?

Rule #1: If you do not understand what is happening, it is not a
compiler bug.  I'm not saying that it isn't, just that it is much more
likely something else.

> The offending argument is 'const ptrdiff_t object_index'
> 
> We have:
> 
> arch/powerpc/include/uapi/asm/posix_types.h:typedef long	 
> __kernel_ptrdiff_t;

So this is a 64-bit build.

> include/linux/types.h:typedef __kernel_ptrdiff_t	ptrdiff_t;
> 
> And get:
> 
>   CC      mm/kfence/report.o
> In file included from ./include/linux/printk.h:7,
>                  from ./include/linux/kernel.h:16,
>                  from mm/kfence/report.c:10:
> mm/kfence/report.c: In function 'kfence_report_error':
> ./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument 
> of type 'ptrdiff_t', but argument 6 has type 'long int' [-Wformat=]

This is declared as
        const ptrdiff_t object_index = meta ? meta - kfence_metadata : -1;
so maybe something with that goes wrong?  What happens if you delete the
(useless) "const" here?


Segher
