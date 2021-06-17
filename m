Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792703AB6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhFQPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhFQPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623942085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9trAQlzc2QEz4xJ8O3LYvFQuTY9I2SKkZwuq9UUOyI=;
        b=KRcomv1VUEWmgjEtZ4A5Qg21AupIf6h+seXXQrH88aQf1ZAwofVM1U2lhT2KX94+CSF41f
        47eHaVbCVqRszzX6H1aPrhWtwT4rymKUcAl2EW9DzLO2SemcmbCMVZFT/Sfu5/wqrs5m2P
        guR+YHLIxAPzQMFRESZvhL0m7FqLLK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-OFo0pHUaMhiLgJTH3OXeRQ-1; Thu, 17 Jun 2021 11:01:23 -0400
X-MC-Unique: OFo0pHUaMhiLgJTH3OXeRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 915FF81DF1B;
        Thu, 17 Jun 2021 15:01:22 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F4B360CC9;
        Thu, 17 Jun 2021 15:01:18 +0000 (UTC)
Date:   Thu, 17 Jun 2021 11:01:16 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <YMtjvF0en9NjIspl@lorien.usersys.redhat.com>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <20210616090314.GJ30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616090314.GJ30378@techsingularity.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Wed, Jun 16, 2021 at 10:03:14AM +0100 Mel Gorman wrote:
> On Tue, Jun 15, 2021 at 10:42:28PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> > > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > This is a partial forward-port of Peter Ziljstra's work first posted
> > > at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.
> > 
> > It's patches 2 and 3 together, right?
> > 
> 
> Patches 2, 3, 9 and 10. I saw limited value to preserving the feature
> flag. Some of the series has since been obsoleted. The main patch of
> interest that was dropped was patch 1 because the results were somewhat
> inconclusive but leaning towards being an overall loss.
> 
> > > His Signed-off has been removed because it is modified but will be restored
> > > if he says it's still ok.
> > 
> > I suppose the SoB will auto-magically re-appear if I apply it :-)
> > 
> 
> Yep, it would and it would indicate that you didn't object to the copying
> at least :P
> 
> > > The patch potentially matters when a socket was multiple LLCs as the
> > > maximum search depth is lower. However, some of the test results were
> > > suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> > > other results were not dramatically different to other mcahines.
> > > 
> > > Given the nature of the patch, Peter's full series is not being forward
> > > ported as each part should stand on its own. Preferably they would be
> > > merged at different times to reduce the risk of false bisections.
> > 
> > I'm tempted to give it a go.. anyone object?
> 
> Thanks, so far no serious objection :)
> 
> The latest results as I see them have been copied to
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/dashboard.html
> They will move from here if the patch is accepted to 5-assembly replacing
> 3-perf-test. This naming is part of my workflow for evaluating topic
> branches separetly and then putting them together for another round
> of testing.
> 
> NAS shows small differences but NAS would see limited impact from the
> patch. Specjbb shows small losses and some minor gains which is unfortunate
> but the workload tends to see small gains and losses all the time.
> redis is a mixed bag but has some wins. hackbench is the main benefit
> because it's wakeup intensive and tends to overload machines where deep
> searches hurt.
> 
> There are other results in there if you feel like digging around
> such as sched-core tested with no processes getting tagged with prctl
> https://beta.suse.com/private/mgorman/melt/v5.13-rc5/5-assembly/sched/sched-schedcore-v1r2/html/dashboard.html
>

Thanks for the links. It's cool to see what your results dashboard looks like.
It's really small, what are you plotting in those heat maps?

It's hard for me to publish the results that come from our testing (web based
on intranet) but we don't see any major differences with this patch.  There
are some gains here and there mostly balanced by some loses.  Overall it comes
out basically as a wash across our main performance test workload.

It'll be interesting to see if it effects a sensitive, proprietary perf test
suite from a European company with a 3 letter name :)


Cheers,
Phil

> 
> -- 
> Mel Gorman
> SUSE Labs
> 

-- 

