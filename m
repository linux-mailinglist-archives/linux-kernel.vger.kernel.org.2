Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26F3A8ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFOVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230520AbhFOVPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623791616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9BxiMkkA5JkSd5RMw8LSeeVOT4OFFDIz9KbyEQ6tEQ=;
        b=LWqdOr8ZdCNovpv6sdsc/+MiEic6acladXSd8Mom7HjWdfzogHON0fJDuy8Yzx4dDYWsuX
        0WlUNczfHT97Ii0zuVdnUlTkam/cZduoe6eub8uzCRkI+DbQOgGkHtHXH3d8p/LXW/Lc9+
        +25JwN8V5V5C0A6f8jN/GPZOJnMDWLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-UbjIBEhvMUuLkN36CnNXVA-1; Tue, 15 Jun 2021 17:13:35 -0400
X-MC-Unique: UbjIBEhvMUuLkN36CnNXVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C15F801B16;
        Tue, 15 Jun 2021 21:13:34 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D0D010016F4;
        Tue, 15 Jun 2021 21:13:30 +0000 (UTC)
Date:   Tue, 15 Jun 2021 17:13:28 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <YMkX+MMVV0aMjmR8@lorien.usersys.redhat.com>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615204228.GB4272@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:42:28PM +0200 Peter Zijlstra wrote:
> On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > This is a partial forward-port of Peter Ziljstra's work first posted
> > at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.
> 
> It's patches 2 and 3 together, right?
> 
> > His Signed-off has been removed because it is modified but will be restored
> > if he says it's still ok.
> 
> I suppose the SoB will auto-magically re-appear if I apply it :-)
> 
> > The patch potentially matters when a socket was multiple LLCs as the
> > maximum search depth is lower. However, some of the test results were
> > suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> > other results were not dramatically different to other mcahines.
> > 
> > Given the nature of the patch, Peter's full series is not being forward
> > ported as each part should stand on its own. Preferably they would be
> > merged at different times to reduce the risk of false bisections.
> 
> I'm tempted to give it a go.. anyone object?
> 

Fwiw, I have some perf tests running on v1.  But I don't know if the
results will be in before I'm AFK next week. I suppose we could pull
it back out if something really bad comes up.

Seems like a reasonable change to me on the surface.


Cheers,
Phil
-- 

