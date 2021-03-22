Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833FC343E29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCVKme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCVKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:42:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQV77Royvcf/qH4I7ot8EfNxqmNWD9CpDSENY6wCPko=; b=GJUFpV2mF6WwvD8GDwr0HUsxRn
        M4HG/F2jjYVmNAb/7gg07pQyqf5WLWyFVeUw7GyFHB7N/enh28sD/gUvOUGgxGbeA0qgbqdRW6FTt
        9HFmktPlPIj600f6Fn6yJK//8iwMtlTnQeBSntAfbIGsWAHQXIR05Hp8MFFcybMmE0eErBTHb3yVn
        v4Fu7n0+Rjihh9Nv5mGv2b1PJgtfoqOszEN8EGufSkrdoBvFI3dfDCAbiKTr01g0d51tQnK/D+ZKD
        y7ZImbXFvF/kj3q4L5hGM3yRjm9Px91v0AxBHpR31X9+LIIs5l71cH9eiLIdElmKVrxCiC4p/xScw
        CRINE8hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOHzg-008MNG-AG; Mon, 22 Mar 2021 10:41:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D43A03010C8;
        Mon, 22 Mar 2021 11:41:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B206C23D3F374; Mon, 22 Mar 2021 11:41:06 +0100 (CET)
Date:   Mon, 22 Mar 2021 11:41:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barret Rhoden <brho@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sched: allow resubmits to queue_balance_callback()
Message-ID: <YFh0QjnoGPmbykyE@hirez.programming.kicks-ass.net>
References: <20210318195734.3579799-1-brho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318195734.3579799-1-brho@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:57:34PM -0400, Barret Rhoden wrote:
> Prior to this commit, if you submitted the same callback_head twice, it
> would be enqueued twice, but only if it was the last callback on the
> list.  The first time it was submitted, rq->balance_callback was NULL,
> so head->next is NULL.  That defeated the check in
> queue_balance_callback().
> 
> This commit changes the callback list such that whenever an item is on
> the list, its head->next is not NULL.  The last element (first inserted)
> will point to itself.  This allows us to detect and ignore any attempt
> to reenqueue a callback_head.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>

AFAICT you're patching dead code, please check a current tree.
