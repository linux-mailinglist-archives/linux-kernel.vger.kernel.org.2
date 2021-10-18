Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3758E430DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 04:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhJRCXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 22:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhJRCXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 22:23:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13226C06161C;
        Sun, 17 Oct 2021 19:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DIQKw3qwkDPCsXVrAmS0+BsNjJtAvTsvtObVynrX8dE=; b=Zv7pV55a57UKMjZhSUwkrg2KGh
        VBRiEcVefW0t2tUlf1qKwUHL6GUV5xRkBaktWkpwxQDyxZ0IlOEvrMQY750p505ZTKoOssDYxDawM
        0RHstdRi+dHMhY8O8SH7+HTnaXscH+N60iUHmM9qVmv325S4eF9LyTP061d0+6WXG4VgLKNhrlXXY
        cVNi/b94tY/RfqNMdZBH1GEBy5cUWXDiarvHB58cWmV24xggRj6L8nYfr5g8cs/JEXTL3nfgtA7Ex
        vIqnMv6w5R+r2aA7Th39dOsXyswzTWe7DP2WnHQw5/4AurkCnb6E/gBJwKRctmIiLOTNy18dP/an4
        JjhEJ7FQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcIDp-00AdoF-Mt; Mon, 18 Oct 2021 02:18:41 +0000
Date:   Mon, 18 Oct 2021 03:17:53 +0100
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
Message-ID: <YWzZUZILdhAGba8I@casper.infradead.org>
References: <20211018013117.256284-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018013117.256284-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:31:17AM +0800, Boqun Feng wrote:
> @@ -391,6 +387,23 @@ the stack trace of the offending worker thread. ::
>  The work item's function should be trivially visible in the stack
>  trace.
>  
> +Non-reentrance Conditions
> +=========================
> +
> +Workqueue guarantees that a work item cannot be re-entrant if the following
> +conditions hold after a work item gets queued:
> +
> +        1. The work function hasn't been changed.
> +        2. No one queues the work item to another workqueue.
> +        3. The work item hasn't been reinitiated.
> +
> +In other words, if the above conditions hold, the work item is guaranteed to be
> +executed by at most one worker system-wide at any given time.
> +
> +Note that requeuing the work item (to the same queue) in the self function
> +doesn't break these conditions, so it's safe to do. Otherwise, caution is
> +required when breaking the conditions inside a work function.
> +

I'd like to suggest that this be added to the Guidelines section
instead:

* A work item will not normally be processed on multiple CPUs at the
  same time.  It can happen if the work function is changed, the work
  item is queued to multiple queues or the work function is
  reinitialised after being queued.
