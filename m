Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1A3BDBDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGFRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhGFRFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625590948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Tmzxqim5oswr4PGT5cE9HzINeuSPYd3PZxn3xtFSJ4=;
        b=JB/gM0aFSAYR5jwbOFSrucE+rBvCihNlfT9S2soz0CvwjHKRrBTD6dBB3Wuq5aoFhwrL76
        rZKLhOAVEXnyGOVSylD99yQ3on28tGdgc0hBeUzobr7oekMLmOm7pN3M9WUE8KgmC/CbdB
        KbhzEWf82QzJa3JgyUWl6FgEVbtXAXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-G-MdiZS8NYOJAmUImvxhWA-1; Tue, 06 Jul 2021 13:02:24 -0400
X-MC-Unique: G-MdiZS8NYOJAmUImvxhWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D1A350755;
        Tue,  6 Jul 2021 17:02:23 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70CA65D9D5;
        Tue,  6 Jul 2021 17:02:19 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 231B9416F5D2; Tue,  6 Jul 2021 13:53:46 -0300 (-03)
Date:   Tue, 6 Jul 2021 13:53:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210706165346.GA73435@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <20210702123032.GA72061@lothringen>
 <20210702152816.GA4122@fuller.cnet>
 <20210706130925.GC107277@lothringen>
 <20210706140550.GA64308@fuller.cnet>
 <20210706140920.GA68399@fuller.cnet>
 <YOSBnMNNeVseeGZK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOSBnMNNeVseeGZK@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 06:15:24PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 06, 2021 at 11:09:20AM -0300, Marcelo Tosatti wrote:
> > Peter, was that the only problem you saw with isolcpus interface?
> 
> It needs to die, it's a piece of crap. Use cpusets already.

OK, can do that. So how about, in addition to this patch (which again,
is needed for current systems, so we will have to keep extending it
for the current kernels which patches are backported to, as done with
managed_irqs... note most of the code that is integrated will be reused,
just a different path that enables it).

So what was discussed before was the following:

https://lkml.org/lkml/2020/9/9/1120

Do you have any other comments 
(on the "new file per isolation feature" structure) ?

Would probably want to split the flags per-CPU as well.


