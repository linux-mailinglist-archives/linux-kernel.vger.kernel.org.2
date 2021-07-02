Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3243BA025
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhGBMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231912AbhGBMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625227212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Et5iZ97LTU9tQ2pMs7pR/S5TGxgSyJzTr+8AlXGoLA=;
        b=RedEYwEHJLwBuhNA0qOsxODgNHokuRbmFGg+Yyje0Rxo+XQZbFjvX6fsC7Q0X2u/milN5e
        x/iK8bo13PzGWPLVyJER7H6wGTGJ0wVR9Pz7Tpa3KcXa8EVZHrrCJ7NdPUdQXKBgXsTlM4
        CR1Eg/TSNtKpOq+0/eqOiU20IDXbUv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-3Kq-VP_BPZaAjLq-cirY6w-1; Fri, 02 Jul 2021 08:00:10 -0400
X-MC-Unique: 3Kq-VP_BPZaAjLq-cirY6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A341E9126D;
        Fri,  2 Jul 2021 12:00:09 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9531A620DE;
        Fri,  2 Jul 2021 12:00:03 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8F29C4179B8D; Fri,  2 Jul 2021 08:59:59 -0300 (-03)
Date:   Fri, 2 Jul 2021 08:59:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210702115959.GA239377@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Forgot to reply to this question...

On Fri, Jul 02, 2021 at 10:00:11AM +0200, Christoph Lameter wrote:
> On Thu, 1 Jul 2021, Marcelo Tosatti wrote:
> 
> > The logic to disable vmstat worker thread, when entering
> > nohz full, does not cover all scenarios. For example, it is possible
> > for the following to happen:
> >
> > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > 2) app runs mlock, which increases counters for mlock'ed pages.
> > 3) start -RT loop
> >
> > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > the mlock, vmstat shepherd can restart vmstat worker thread on
> > the CPU in question.
> 
> Can we enter nohz_full after the app runs mlock?

Hum, i don't think its a good idea to use that route, because
entering or exiting nohz_full depends on a number of variable
outside of one's control (and additional variables might be
added in the future).

So preparing the system to function
while entering nohz_full at any location seems the sane thing to do.

And that would be at return to userspace (since, if mlocked, after 
that point there will be no more changes to propagate to vmstat
counters).

Or am i missing something else you can think of ?


