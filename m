Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF9431749
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJRL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhJRL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:29:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89007C06161C;
        Mon, 18 Oct 2021 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JFX8kP55RWXj6waFPYbQrLo3fe/X9uJgOWvgqmD7buQ=; b=vS/Pn2Hh90j1GtpMzv/CX9pnbg
        y3LE4C+pJ2F5QZUxboSQrYbKadYzRPXcvT61T90Ww8XswMkbKOji3AuBXBsJd46SLoF2YYEaV0eJV
        8Wx00/C8hTewQonHBeN+mXa/G38OLjscGkk03Y+DdDJ7/8vhxN830vhWbG4MEZpAX+eVuhVEFd336
        rDaA8JXtoutvh6JhIH99x/8AlU2aHu8n0ugBflNeKs6J6E1pAT9BjkQzWNgYlDAHkLi46FSg2Vh3J
        MXxytKk8j3wuabZKEnjSEHIuvGAdfzLICDYLWSGEDlvLKhcc36Jl6PCbdlxcUZRa3BOSU+C7GyCDy
        vQa80eXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcQn0-00AuWN-5j; Mon, 18 Oct 2021 11:26:55 +0000
Date:   Mon, 18 Oct 2021 12:26:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] workqueue: doc: Call out the non-reentrance conditions
Message-ID: <YW1Z9rFpGl/j70HT@casper.infradead.org>
References: <20211018013117.256284-1-boqun.feng@gmail.com>
 <YWzZUZILdhAGba8I@casper.infradead.org>
 <YWznsr6qnCpErKJi@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWznsr6qnCpErKJi@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:19:14AM +0800, Boqun Feng wrote:
> On Mon, Oct 18, 2021 at 03:17:53AM +0100, Matthew Wilcox wrote:
> > On Mon, Oct 18, 2021 at 09:31:17AM +0800, Boqun Feng wrote:
> > > @@ -391,6 +387,23 @@ the stack trace of the offending worker thread. ::
> > >  The work item's function should be trivially visible in the stack
> > >  trace.
> > >  
> > > +Non-reentrance Conditions
> > > +=========================
> > > +
> > > +Workqueue guarantees that a work item cannot be re-entrant if the following
> > > +conditions hold after a work item gets queued:
> > > +
> > > +        1. The work function hasn't been changed.
> > > +        2. No one queues the work item to another workqueue.
> > > +        3. The work item hasn't been reinitiated.
> > > +
> > > +In other words, if the above conditions hold, the work item is guaranteed to be
> > > +executed by at most one worker system-wide at any given time.
> > > +
> > > +Note that requeuing the work item (to the same queue) in the self function
> > > +doesn't break these conditions, so it's safe to do. Otherwise, caution is
> > > +required when breaking the conditions inside a work function.
> > > +
> > 
> > I'd like to suggest that this be added to the Guidelines section
> 
> Good idea, Guidelines section is a better place to put these, since it's
> for users.
> 
> > instead:
> > 
> > * A work item will not normally be processed on multiple CPUs at the
> 
> Precisely speaking, it should be "by mutliple workers" instead of "on
> multiple CPUs", because two workers of tw unbound workqueue may process
> the same work item on the same CPU, and that's problematic since
> processing work is preemptible.
> 
> >   same time.  It can happen if the work function is changed, the work
> >   item is queued to multiple queues or the work function is
> >   reinitialised after being queued.
> 
> I end up with something like below, I still want to keep the keyword
> "reentrant" for searching, because sometimes one may forget this
> particular aspect after reading the whole doc for a while, the keyword
> can help locate the lines faster (Ok, the fact is that "one" was me
> ;-)).
> 
> * A work item will not normally be processed by multiple workers at the
>   same time, i.e. it's non-reentrant.  However it can happen if the work
>   function is changed, the work item is queued to multiple queues or the
>   work item is reinitialised after being queued.
> 
> Thoughts? Thank for the suggestion!

Looks good to me!
