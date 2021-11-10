Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9835344C00E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKJLXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:23:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5803DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CKdGRMTGsWn9HCBQ5Oi6SxJ1ad0n9MyScVi4CuS0mWM=; b=qxVhBfi88ggtGutV0mk23qAID+
        DqTtqFaZuebEIRAbDCmFVl2EDZn7kj7b83mbuV3XY+7417TPHZNnhHO7vmj26qpz3uFBeKKn/WRx2
        j2isy8Cd+1jyuOELDU0W00EG2u+7KjZZr/TGjNqZqG5lqXhg3SUmNTSPiGej1Oqawr5jwbRsZ8zhE
        Lt91QO8lAr/lE0UcgWMYZv9u2TiR1azxNRgcetmUql5yBH3qefh3JGRRr1tjgFZC+C7WMzsL0OiSp
        GSb7pySq+6oaDqIBnfFfHF8+LDnPA3mrHsd/AdszMJomO0hW+UZmBkFRH3jhz4iHYk4O3v8Q1ERAE
        6yq/xbIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkleB-001ohi-VO; Wed, 10 Nov 2021 11:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC4963000A3;
        Wed, 10 Nov 2021 12:20:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E7E8214EB9C2; Wed, 10 Nov 2021 12:20:05 +0100 (CET)
Date:   Wed, 10 Nov 2021 12:20:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <YYuq5d7MYL2wxlOd@hirez.programming.kicks-ass.net>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <YYuj/rT+EO3K0LsK@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuj/rT+EO3K0LsK@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:50:38AM +0100, Petr Mladek wrote:
> On Tue 2021-11-09 12:06:48, Sultan Alsawaf wrote:
> > Hi,
> > 
> > I encountered a printk deadlock on 5.13 which appears to still affect the latest
> > kernel. The deadlock occurs due to printk being used while having the current
> > CPU's runqueue locked, and the underlying framebuffer console attempting to lock
> > the same runqueue when printk tries to flush the log buffer.
> > 
> > I'm not sure what the *correct* solution is here (don't use printk while having
> > a runqueue locked? don't use schedule_work() from the fbcon path? tell printk
> > to use one of its lock-less backends?), so I've cc'd all the relevant folks.
> 
> At the moment, printk_deferred() could be used here. It defers the
> console handling via irq_work().

I think I've rejected that patch at least twice now :-) John's printk
stuff will really land real soon now, right.
