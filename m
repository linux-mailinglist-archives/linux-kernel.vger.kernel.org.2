Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1B3DF31D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhHCQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234108AbhHCQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628009252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mt0Bnpl0TYyUpTbTuIQ/z9RCwe83HDDTaIIA9TLwjL0=;
        b=HYz1gycY5sj/pixMsoK/tnQamsSS9ctavka/HzW5uWtbVWo/PpzQg929xw9pJ3KqtV36Ez
        NV7R1uuWj1F+Xr9aium4cyL1LJ/RIhzdXzr4Vv8GBlY1+1XCC3Itk28T1G/LulqC+PCaq6
        zGFqmYPt+8r2jVw5lwVos/7ZRxXYM0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-SjcjcMWcMCeeyC0WxReiFw-1; Tue, 03 Aug 2021 12:47:30 -0400
X-MC-Unique: SjcjcMWcMCeeyC0WxReiFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B841C1853035;
        Tue,  3 Aug 2021 16:47:27 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A4F17C58;
        Tue,  3 Aug 2021 16:47:19 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D2391417529F; Tue,  3 Aug 2021 13:44:02 -0300 (-03)
Date:   Tue, 3 Aug 2021 13:44:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 2/4] task isolation: sync vmstats on return to userspace
Message-ID: <20210803164402.GA14442@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
 <20210730202010.270885685@fuller.cnet>
 <62a66a5744b28dfea6ff2aec4e02ca0978914819.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a66a5744b28dfea6ff2aec4e02ca0978914819.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 05:13:03PM +0200, nsaenzju@redhat.com wrote:
> On Fri, 2021-07-30 at 17:18 -0300, Marcelo Tosatti wrote:
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
> > 
> > To fix this, use the task isolation prctl interface to quiesce 
> > deferred actions when returning to userspace.
> 
> Even though this is mostly targeted at nohz_full users, I believe I haven't
> seen anything in this series that forces the feature to be run on nohz_full
> CPUs (this is a good thing IMO). 

I don't think there is such a dependency either.

> So, I'd suggest to reword the patch
> description so it doesn't imply nohz_full is necessary to use this.

Its describing a fact from nohz_full where it can't guarantee entering
userspace with vmstat turned off (which is a reply to Christopher's
earlier comment that "this should just work with nohz_full and
logic to shutdown the vmstat delayed work timer").

Will add a comment to make it explicit that the series does not depend
on nohz_full.

Thanks.

