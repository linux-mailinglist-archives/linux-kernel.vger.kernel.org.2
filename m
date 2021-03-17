Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93D33EE62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCQKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:36:27 -0400
Received: from casper.infradead.org ([90.155.50.34]:58204 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCQKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqM0OeH3XK2AQ8p0EiIuIfrvcMtMCFpMG1W+KKDnCuI=; b=uuivg6uTfSqcLq6lFmMC3FIedh
        r6oQekaOzYlHwsdKdxamQKDR04oeRTbAwIniea3tlgFl0+TSb1lPFnGFvDk07y6aJe9+8HvOVL7Af
        kctWAQA06ByF8pWwSTto9CZKFu5zz/htDILKndTQZ6YUKLyPzqSLqpBrmnl0JCExo7ObLRTtooFpb
        BCY4CYm3OCf7ybjtddRglLX6IBr038WPPne3a4asMt1rwX8la//lzUMzbKAVPxWDDw9Vn+bypC6U3
        dj4ttV0MN0p4JkyK0Ovq04YsjZHWU6fmljjYpkWs5nlSgY+Cymhj+jIM0tWTznmOdO5iDoyxkCPG1
        FWM/EPGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMTWZ-001Nmk-AI; Wed, 17 Mar 2021 10:35:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64BD6301324;
        Wed, 17 Mar 2021 11:35:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AC732C3C234A; Wed, 17 Mar 2021 11:35:34 +0100 (CET)
Date:   Wed, 17 Mar 2021 11:35:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mike Galbraith <efault@gmx.de>, Wang Qing <wangqing@vivo.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: swait: use wake_up_process() instead of
 wake_up_state()
Message-ID: <YFHbdojO5TtztzEn@hirez.programming.kicks-ass.net>
References: <1615893602-22260-1-git-send-email-wangqing@vivo.com>
 <4cb1a9ae15c414435020630cf6362163ddda1550.camel@gmx.de>
 <20210317094618.GA1724119@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317094618.GA1724119@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:46:18AM +0100, Ingo Molnar wrote:
> 
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Tue, 2021-03-16 at 19:20 +0800, Wang Qing wrote:
> > > Why not just use wake_up_process().
> > 
> > IMO this is not an improvement.  There are other places where explicit
> > TASK_NORMAL is used as well, and they're all perfectly clear as is.
> 
> Arguably those could all be converted to wake_up_process() as well. 
> It's a very small kernel code size optimization. There's about 3 such 
> places, could be converted in a single patch.

It's still pointless churn IMO.
