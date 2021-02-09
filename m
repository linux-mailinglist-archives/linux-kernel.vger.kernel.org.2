Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134DB314A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBIIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:40:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:52966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhBIIkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:40:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612859975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/TCQMsEKZeWKYWA7PitmpFz+lfBIV2PUxzKNcHqcSA=;
        b=KZ7MzYv+TlxppKhZLwDSyysF5uPVvVC7N2pC83pC/uTDWki/80BBoVFPdQBTjNmrVy8CT0
        y8vV0l+DqBOHYgEUOBarOoaQMVE+UkrpmLSVuQZjJ6K0hiBYKCywhHW5qvRjmBxqZ5HCFr
        plK6sLPUIvTOai6G3U2VGlUe2lbO9so=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94141AD3E;
        Tue,  9 Feb 2021 08:39:35 +0000 (UTC)
Date:   Tue, 9 Feb 2021 09:39:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2] printk: fix deadlock when kernel panic
Message-ID: <YCJKRnBXjTNWRBZ7@alley>
References: <20210206054124.6743-1-songmuchun@bytedance.com>
 <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain>
 <CAMZfGtVBVSuH=HGNs7KFOtixSviy_stoZsiG4au0RUkUnH-0rQ@mail.gmail.com>
 <YCE4tIrz/u/RkDc/@jagdpanzerIV.localdomain>
 <CAMZfGtX-bHXoF_4rU+WzDNp+LmZj3CHWmurEvjCZBCyM2uiDMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX-bHXoF_4rU+WzDNp+LmZj3CHWmurEvjCZBCyM2uiDMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-08 23:40:07, Muchun Song wrote:
> On Mon, Feb 8, 2021 at 9:12 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > On (21/02/08 16:49), Muchun Song wrote:
> > > On Mon, Feb 8, 2021 at 2:38 PM Sergey Senozhatsky
> > > <sergey.senozhatsky@gmail.com> wrote:
> > > >
> > > > On (21/02/06 13:41), Muchun Song wrote:
> > > > > We found a deadlock bug on our server when the kernel panic. It can be
> > > > > described in the following diagram.
> > > > >
> > > > > CPU0:                                         CPU1:
> > > > > panic                                         rcu_dump_cpu_stacks
> > > > >   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
> > > > >     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
> > > > >                                                     __printk_safe_flush
> > > > >                                                       raw_spin_lock_irqsave(&read_lock)
> > > > >     // send NMI to other processors
> > > > >     apic_send_IPI_allbutself(NMI_VECTOR)
> > > > >                                                         // NMI interrupt, dead loop
> > > > >                                                         crash_nmi_callback
> > > >
> > > > At what point does this decrement num_online_cpus()? Any chance that
> > > > panic CPU can apic_send_IPI_allbutself() and printk_safe_flush_on_panic()
> > > > before num_online_cpus() becomes 1?
> > >
> > > I took a closer look at the code. IIUC, It seems that there is no point
> > > which decreases num_online_cpus.
> >
> > So then this never re-inits the safe_read_lock?

Yes, but it will also not cause the deadlock.
printk_safe_flush_on_panic() will return without flushing
the buffers.

> Right. If we encounter this case, we do not flush printk
> buffer. So, it seems my previous patch is the right fix.
> Right?
> 
> https://lore.kernel.org/patchwork/patch/1373563/

No, there is a risk of deadlock caused by logbuf_lock, see
https://lore.kernel.org/lkml/YB0nggSa7a95UCIK@alley/

> >                if (num_online_cpus() > 1)
> >                        return;
> >
> >                debug_locks_off();
> >                raw_spin_lock_init(&safe_read_lock);
> >
> >         -ss

I prefer this approach. It is straightforward because it handles
read_lock the same way as logbuf_lock.

IMHO, it is not worth inventing any more complexity. Both logbuf_lock
and read_lock are obsoleted by the lockless ringbuffer. And we need
something simple to get backported to the already released kernels.

Best Regards,
Petr
