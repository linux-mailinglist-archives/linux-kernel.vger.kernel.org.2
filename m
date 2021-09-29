Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A941C2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbhI2K3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:29:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47298 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S245324AbhI2K3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:29:47 -0400
X-UUID: 3dbee720d7764752a914b0dd2ad095d0-20210929
X-UUID: 3dbee720d7764752a914b0dd2ad095d0-20210929
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 625473628; Wed, 29 Sep 2021 18:28:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Sep 2021 18:28:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Sep 2021 18:28:03 +0800
Message-ID: <1c8464602db6ded259859e7d5866381017d953f3.camel@mediatek.com>
Subject: Re: [PATCH] scs: Release kasan vmalloc poison in scs_free process
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Sami Tolvanen <samitolvanen@google.com>
CC:     <yee.lee@mediatek.com>, LKML <linux-kernel@vger.kernel.org>,
        <nicholas.Tang@mediatek.com>, <chinwen.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <kuan-ying.lee@mediatek.com>
Date:   Wed, 29 Sep 2021 18:28:03 +0800
In-Reply-To: <CABCJKucWe-C7i1+k42uV4TgeD8Q7NBoMrXxdyV85oPE9Tibdrg@mail.gmail.com>
References: <20210923095316.13867-1-yee.lee@mediatek.com>
         <5f7a9ed1dabba25596c38a8e7c32ee5750b80459.camel@mediatek.com>
         <CABCJKucWe-C7i1+k42uV4TgeD8Q7NBoMrXxdyV85oPE9Tibdrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-24 at 07:35 -0700, Sami Tolvanen wrote:
> On Thu, Sep 23, 2021 at 4:19 AM Kuan-Ying Lee
> <Kuan-Ying.Lee@mediatek.com> wrote:
> > 
> > On Thu, 2021-09-23 at 17:53 +0800, yee.lee@mediatek.com wrote:
> > > From: Yee Lee <yee.lee@mediatek.com>
> > > 
> > > Since scs allocation has been moved to vmalloc region, the
> > > shadow stack is protected by kasan_posion_vmalloc.
> > > However, the vfree_atomic operation needs to access
> > > its context for scs_free process and causes kasan error
> > > as the dump info below.
> > > 
> > > This patch Adds kasan_unpoison_vmalloc() before vfree_atomic,
> > > which aligns to the prior flow as using kmem_cache.
> > > The vmalloc region will go back posioned in the following
> > > vumap() operations.
> > > 
> > >  ================================================================
> > > ==
> > >  BUG: KASAN: vmalloc-out-of-bounds in llist_add_batch+0x60/0xd4
> > >  Write of size 8 at addr ffff8000100b9000 by task kthreadd/2
> > > 
> > >  CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.15.0-rc2-11681-(skip)
> > >  Hardware name: linux,dummy-virt (DT)
> > >  Call trace:
> > >   dump_backtrace+0x0/0x43c
> > >   show_stack+0x1c/0x2c
> > >   dump_stack_lvl+0x68/0x84
> > >   print_address_description+0x80/0x394
> > >   kasan_report+0x180/0x1dc
> > >   __asan_report_store8_noabort+0x48/0x58
> > >   llist_add_batch+0x60/0xd4
> > >   vfree_atomic+0x60/0xe0
> > >   scs_free+0x1dc/0x1fc
> > >   scs_release+0xa4/0xd4
> > >   free_task+0x30/0xe4
> > >   __put_task_struct+0x1ec/0x2e0
> > >   delayed_put_task_struct+0x5c/0xa0
> > >   rcu_do_batch+0x62c/0x8a0
> > >   rcu_core+0x60c/0xc14
> > >   rcu_core_si+0x14/0x24
> > >   __do_softirq+0x19c/0x68c
> > >   irq_exit+0x118/0x2dc
> > >   handle_domain_irq+0xcc/0x134
> > >   gic_handle_irq+0x7c/0x1bc
> > >   call_on_irq_stack+0x40/0x70
> > >   do_interrupt_handler+0x78/0x9c
> > >   el1_interrupt+0x34/0x60
> > >   el1h_64_irq_handler+0x1c/0x2c
> > >   el1h_64_irq+0x78/0x7c
> > >   _raw_spin_unlock_irqrestore+0x40/0xcc
> > >   sched_fork+0x4f0/0xb00
> > >   copy_process+0xacc/0x3648
> > >   kernel_clone+0x168/0x534
> > >   kernel_thread+0x13c/0x1b0
> > >   kthreadd+0x2bc/0x400
> > >   ret_from_fork+0x10/0x20
> > > 
> > >  Memory state around the buggy address:
> > >   ffff8000100b8f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > > f8
> > >   ffff8000100b8f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > > f8
> > >  >ffff8000100b9000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > > f8
> > >                     ^
> > >   ffff8000100b9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > > f8
> > >   ffff8000100b9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > > f8
> > >  ================================================================
> > > ==
> > > 
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > CC: Will Deacon <will@kernel.org>
> > > CC: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > > ---
> > >  kernel/scs.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/scs.c b/kernel/scs.c
> > > index e2a71fc82fa0..25c0d8e416e6 100644
> > > --- a/kernel/scs.c
> > > +++ b/kernel/scs.c
> > > @@ -68,6 +68,7 @@ void scs_free(void *s)
> > > 
> > >       __scs_account(s, -1);
> > > 
> > > +     kasan_unpoison_vmalloc(s, SCS_SIZE);
> > >       /*
> > >        * We cannot sleep as this can be called in interrupt
> > > context,
> > >        * so use this_cpu_cmpxchg to update the cache, and
> > > vfree_atomic
> > 
> > I'm not sure if we need to add kasan_unpoison_vmalloc() and
> > kasan_poison_vmalloc() in this file.
> > 
> > As far as I know, vmalloc() and vfree() will do these two
> > functions.
> 
> The idea here is to poison the shadow stack after it's set up to
> catch
> unintentional accesses. Outside of compiler instrumentation, nothing
> should read or write from this buffer while the task is running.

Got it.
Thanks.

Reviewed-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

> 
> Sami

