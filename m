Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130153466A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhCWRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:48:02 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:42620 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhCWRrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:47:45 -0400
Date:   Tue, 23 Mar 2021 17:47:24 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: mca: allocate early mca with GFP_ATOMIC
Message-ID: <20210323174724.78b61c02@sf>
In-Reply-To: <f351183c-7d70-359f-eed7-4d1722cf41c5@physik.fu-berlin.de>
References: <20210315085045.204414-1-slyfox@gentoo.org>
        <f351183c-7d70-359f-eed7-4d1722cf41c5@physik.fu-berlin.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 16:15:06 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Andrew!
> 
> On 3/15/21 9:50 AM, Sergei Trofimovich wrote:
> > The sleep warning happens at early boot right at
> > secondary CPU activation bootup:
> > 
> >     smp: Bringing up secondary CPUs ...
> >     BUG: sleeping function called from invalid context at mm/page_alloc.c:4942
> >     in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> >     CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.12.0-rc2-00007-g79e228d0b611-dirty #99
> > 
> >     Call Trace:
> >      [<a000000100014d10>] show_stack+0x90/0xc0
> >      [<a000000101111d90>] dump_stack+0x150/0x1c0
> >      [<a0000001000cbec0>] ___might_sleep+0x1c0/0x2a0
> >      [<a0000001000cc040>] __might_sleep+0xa0/0x160
> >      [<a000000100399960>] __alloc_pages_nodemask+0x1a0/0x600
> >      [<a0000001003b71b0>] alloc_page_interleave+0x30/0x1c0
> >      [<a0000001003b9b60>] alloc_pages_current+0x2c0/0x340
> >      [<a00000010038c270>] __get_free_pages+0x30/0xa0
> >      [<a000000100044730>] ia64_mca_cpu_init+0x2d0/0x3a0
> >      [<a000000100023430>] cpu_init+0x8b0/0x1440
> >      [<a000000100054680>] start_secondary+0x60/0x700
> >      [<a00000010111e1d0>] start_ap+0x750/0x780
> >     Fixed BSP b0 value from CPU 1
> > 
> > As I understand interrupts are not enabled yet and system has a lot
> > of memory. There is little chance to sleep and switch to GFP_ATOMIC
> > should be a no-op.
> > 
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: linux-ia64@vger.kernel.org
> > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> > ---
> >  arch/ia64/kernel/mca.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
> > index d4cae2fc69ca..adf6521525f4 100644
> > --- a/arch/ia64/kernel/mca.c
> > +++ b/arch/ia64/kernel/mca.c
> > @@ -1824,7 +1824,7 @@ ia64_mca_cpu_init(void *cpu_data)
> >  			data = mca_bootmem();
> >  			first_time = 0;
> >  		} else
> > -			data = (void *)__get_free_pages(GFP_KERNEL,
> > +			data = (void *)__get_free_pages(GFP_ATOMIC,
> >  							get_order(sz));
> >  		if (!data)
> >  			panic("Could not allocate MCA memory for cpu %d\n",
> >   
> 
> Has this one been picked up for your tree already?

Should be there: https://www.ozlabs.org/~akpm/mmotm/series

> #NEXT_PATCHES_START mainline-later (next week, approximately)
> ia64-mca-allocate-early-mca-with-gfp_atomic.patch


-- 

  Sergei
