Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9D3793AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhEJQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhEJQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620663829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GM0xXI2SrREJ7JlKGLgzDLd/F63JhoF+RMHium7R9Oc=;
        b=OcLR6w8wDyzCDAmnUu2ZITlHKib0aKIOMwE0TVr8w6yte5AUFXABMrhPEcELjeAD8GSCeW
        x/MZYR13Pq9rZQBMsYY1p0n+aZgJZQsaW6caHseXxPjK+s1lPqoIKyQHZrUcoixfjhi7ne
        4DvQg9rHXL/K7q3XcCvYiP67zPikHOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Drhbr88pOKqvcYvZYVzsQg-1; Mon, 10 May 2021 12:23:48 -0400
X-MC-Unique: Drhbr88pOKqvcYvZYVzsQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 140628015A8;
        Mon, 10 May 2021 16:23:47 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C75395D9CA;
        Mon, 10 May 2021 16:23:46 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 624D840E6DFB; Fri,  7 May 2021 19:09:12 -0300 (-03)
Date:   Fri, 7 May 2021 19:09:12 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "isolcpus: Affine unbound kernel threads to
 housekeeping cpus"
Message-ID: <20210507220912.GB449495@fuller.cnet>
References: <20210507165710.GA429056@fuller.cnet>
 <20210507201600.GA66223@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507201600.GA66223@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 10:16:00PM +0200, Frederic Weisbecker wrote:
> On Fri, May 07, 2021 at 01:57:10PM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > commit 9cc5b8656892a72438ee7deb introduced a new housekeeping flag,
> > HK_FLAG_KTHREAD, that when enabled sets the CPU affinity for the 
> > kthreadd process (therefore all unbounded kernel threads created
> > from that point on will use the housekeeping cpumask).
> > 
> > This is not necessary, since its possible to control placement of
> > kthreadd from userspace:
> > 
> > # taskset -c -p 0 `pgrep kthreadd`
> > pid 2's current affinity list: 1
> > pid 2's new affinity list: 0
> > 
> > Unbounded kernel threads started from that point on will inherit
> > the kthreadd cpumask.
> 
> Hmm, but look below:
> 
> > @@ -405,8 +404,7 @@ struct task_struct *__kthread_create_on_
> >  		 * The kernel thread should not inherit these properties.
> >  		 */
> >  		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> > -		set_cpus_allowed_ptr(task,
> > -				     housekeeping_cpumask(HK_FLAG_KTHREAD));
> > +		set_cpus_allowed_ptr(task, cpu_possible_mask);
> 
> That inheritance is then overriden, right?
> 
> Thanks.

Hi Frederic,

Doh, yes, ignore me.


