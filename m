Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95603422A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhJEOPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236157AbhJEOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633443151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdwRgKHT2YQyjAMlBxShEGrwGI1C4pMFWXSUBFxhHNA=;
        b=Q7IxkZVIamxOwV/Woax/mmT9diZgtidMOoHz7moeR5MsI683m9Fvy7xG/5Wmsn1kKD31uK
        Qteta8uYpUDqhjmPzDp80SkR7qSdVmCInBmwZOoQuOSm2Hj/dTfGg6XrkO1GItnF7EoeLh
        FCvPGKZfNHJvmDRBC/cCnmcEwbcP8sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-sFGoP4hRPaO-vNKgLVXCXQ-1; Tue, 05 Oct 2021 10:12:17 -0400
X-MC-Unique: sFGoP4hRPaO-vNKgLVXCXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1919100D680;
        Tue,  5 Oct 2021 14:12:15 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 011315F4EB;
        Tue,  5 Oct 2021 14:12:13 +0000 (UTC)
Date:   Tue, 5 Oct 2021 10:12:12 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mike Galbraith <efault@gmx.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVxdPGj92+FcVrgt@lorien.usersys.redhat.com>
References: <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <YUxx42W3K2Ur7W84@lorien.usersys.redhat.com>
 <YVwqphxxNSDL828Y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVwqphxxNSDL828Y@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:36:22PM +0200 Peter Zijlstra wrote:
> On Thu, Sep 23, 2021 at 08:24:03AM -0400, Phil Auld wrote:
> 
> > It's capped at 8 cpus, which is pretty easy to reach these days, so the
> > values don't get too large.  That scaling is almost a no-op these days.
> 
>   https://lkml.kernel.org/r/YVwdrh5pg0zSv2/b@hirez.programming.kicks-ass.net
> 
> Ooh, hey, we already fixed that :-)
>

Thanks Peter.

I'm always a little behind upstream (nature of the job :)

That link leads to a message Id not found. But from what I can see the
code that takes the min of online cpus and 8 is still present. 


> So the reasoning there is that if the values get too big, interactiviy
> get *really* bad, but if you go from say 1 to 4 CPUs, interactivity can
> improve due to being able to run on other CPUs.
> 
> At 8 CPUs we end up at 6ms*4=24ms, which is already pretty terrible.
> 

And actually you mention the same thing later on.  Most systems, even
desktops, have 8+ cpus these days so the scaling is mostly not doing
anything except multiplying by 4, right? So no-op was not the right
way to describe it maybe. But it's not getting bigger with larger
numbers of cpus beyond a pretty commonly reached limit.


Cheers,
Phil

-- 

