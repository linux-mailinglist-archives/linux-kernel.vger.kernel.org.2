Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E583A8A66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhFOUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:45:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A51C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a904s9c4hVdONd2ZZ/pZ6JoSVL0uZx+id5frjGcZJtw=; b=UZ8KQonxSeKlYXD6/d1z3jy4nd
        uJDGzta3JHAtrZnsZi7EjJLIGmmEnAV52s79VMYp1EaCLkXPgg5xYagJ/4CrwdtEIEFnvr9auNznW
        TIwS/kapMt2r5Xjaekw/digYAkXhhWpX0d3rbYQJQNInM2lVgF0hBGU3uSMO4kqdepsNgAocvSXl+
        ubU+cSlIeZkspPDGOkKTA7MyCRDbVzSWFrX1OH+xbs23xZPctQPZKfpLsBxe9sPnT+NVGS13xdggm
        sbLMyS+4RJqyS1Jr1/JgdOU9xk4tOHPMPHdQIsEJYmv8eeCDBow17fEETUPRhWCvAELkNa3OECSAw
        bK8zNDbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltFtG-007Ea0-1a; Tue, 15 Jun 2021 20:42:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 917A79863C9; Tue, 15 Jun 2021 22:42:28 +0200 (CEST)
Date:   Tue, 15 Jun 2021 22:42:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <20210615204228.GB4272@worktop.programming.kicks-ass.net>
References: <20210615111611.GH30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615111611.GH30378@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> This is a partial forward-port of Peter Ziljstra's work first posted
> at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.

It's patches 2 and 3 together, right?

> His Signed-off has been removed because it is modified but will be restored
> if he says it's still ok.

I suppose the SoB will auto-magically re-appear if I apply it :-)

> The patch potentially matters when a socket was multiple LLCs as the
> maximum search depth is lower. However, some of the test results were
> suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> other results were not dramatically different to other mcahines.
> 
> Given the nature of the patch, Peter's full series is not being forward
> ported as each part should stand on its own. Preferably they would be
> merged at different times to reduce the risk of false bisections.

I'm tempted to give it a go.. anyone object?
