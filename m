Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25D364AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhDSTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234946AbhDSTkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618861200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1st1jqhHcK/7H4Up3pplf3W/o3Gcni0SMPqKRXa5GK8=;
        b=Pls0TZCkgMTqvh/19z4Piu+Y/and38wrBANucB3P+SpxDRSBKh1/3/KF5tuHBmginRg14w
        ESi8+zrZ1EWOlg11XHvZbxPtIq2SYzDl3M9qHkcbRSSV73Ym7euRGhq3LVcEhUmmRyDBgt
        rVj2Rpk27VtRB1tDapmB/Ad6M4zshgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-Ltjg0D73OUyjFgd4c5Va1w-1; Mon, 19 Apr 2021 15:39:57 -0400
X-MC-Unique: Ltjg0D73OUyjFgd4c5Va1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71D083DD40;
        Mon, 19 Apr 2021 19:39:55 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B104D610F4;
        Mon, 19 Apr 2021 19:39:25 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8B6D4416D899; Mon, 19 Apr 2021 15:56:19 -0300 (-03)
Date:   Mon, 19 Apr 2021 15:56:19 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Xu <peterx@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v5] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210419185619.GA57245@fuller.cnet>
References: <20210409165146.GA40118@fuller.cnet>
 <87lf9q4lue.ffs@nanos.tec.linutronix.de>
 <20210413170431.GA16190@fuller.cnet>
 <20210415153935.GA69750@fuller.cnet>
 <87im4nv0fh.ffs@nanos.tec.linutronix.de>
 <20210415204017.GA111847@fuller.cnet>
 <20210416160023.GA6187@fuller.cnet>
 <20210416171321.GU4440@xz-x1>
 <87pmysswtj.ffs@nanos.tec.linutronix.de>
 <87mttwsvlv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mttwsvlv.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 06:51:08PM +0200, Thomas Gleixner wrote:
> On Sat, Apr 17 2021 at 18:24, Thomas Gleixner wrote:
> > On Fri, Apr 16 2021 at 13:13, Peter Xu wrote:
> >> On Fri, Apr 16, 2021 at 01:00:23PM -0300, Marcelo Tosatti wrote:
> >>>  
> >>> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
> >>> +			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
> >>> +			 (1U << HRTIMER_BASE_TAI) |		\
> >>> +			 (1U << HRTIMER_BASE_TAI_SOFT))
> >>> +
> >>> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> >>> +{
> >>> +	if (cpu_base->softirq_activated)
> >>> +		return true;
> >>
> >> A pure question on whether this check is needed...
> >>
> >> Here even if softirq_activated==1 (as softirq is going to happen), as long as
> >> (cpu_base->active_bases & CLOCK_SET_BASES)==0, shouldn't it already mean that
> >> "yes indeed clock was set, but no need to kick this cpu as no relevant timer"?
> >> As that question seems to be orthogonal to whether a softirq is going to
> >> trigger on that cpu.
> >
> > That's correct and it's not any different from firing the IPI because in
> > both cases the update happens with the base lock of the CPU in question
> > held. And if there are no active timers in any of the affected bases,
> > then there is no need to reevaluate the next expiry because the offset
> > update does not affect any armed timers. It just makes sure that the
> > next enqueu of a timer on such a base will see the the correct offset.
> >
> > I'll just zap it.
> 
> But the whole thing is still wrong in two aspects:
> 
>     1) BOOTTIME can be one of the affected clocks when sleep time
>        (suspended time) is injected because that uses the same mechanism.
> 
>        Sorry for missing that earlier when I asked to remove it, but
>        that's trivial to fix by adding the BOOTTIME base back.
> 
>     2) What's worse is that on resume this might break because that
>        mechanism is also used to enforce the reprogramming of the clock
>        event devices and there we cannot be selective on clock bases.
> 
>        I need to dig deeper into that because suspend/resume has changed
>        a lot over time, so this might be just a historical leftover. But
>        without proper analysis we might end up with subtle and hard to
>        debug wreckage.
> 
> Thanks,
> 
>         tglx

Thomas,

There is no gain in avoiding the IPIs for the suspend/resume case 
(since suspending is a large interruption anyway). To avoid 
the potential complexity (and associated bugs), one option would 
be to NOT skip IPIs for the resume case.

Sending -v6 with that (and other suggestions/fixes).

