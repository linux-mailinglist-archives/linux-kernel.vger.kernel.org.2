Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385A63ED3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhHPMdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhHPMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:33:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ACGN0Sis+sEgxBHlyEOjkA7hulSWZlh9kNBPQYj7W9Y=; b=maXa0e0PIztz0KhbIoRvGK18a1
        9D1xwwKIi1DNOSd03ch/JGU1Zf0r8V/WKlyO++8Uc1cK1T0wIwChxoq0bq7foptzM110PBg9siWTV
        GCKGYZL6axig1YqggI/57YCFzKNWHq5iqwm8dEX3xQDUmtjwx7BGWLHWRaHPw0Vbv4kI7m1fGupoc
        gQjNgPNCpNPi/7UZqIqKTqGG7mtGDkzKhH1merBdLUgnkCORtvih8XROEdjxYghv8ZjNsUi/M0G3T
        GdifhbDbMs3MCD56FQGTmN7S8MocUpVxmMX4u6Q83rVyif9rrbt8iMV30sJwLF/JwFkSTHTOvi1MX
        Ms+twG2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFblo-001LKW-L1; Mon, 16 Aug 2021 12:31:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C76E3004B2;
        Mon, 16 Aug 2021 14:31:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 211E72028D932; Mon, 16 Aug 2021 14:31:09 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:31:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
Message-ID: <YRpajXKCPiPEHFAV@hirez.programming.kicks-ass.net>
References: <20210730020019.1487127-1-joshdon@google.com>
 <20210730020019.1487127-3-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730020019.1487127-3-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 07:00:19PM -0700, Josh Don wrote:
> 1) Ignore min_granularity for determining the sched_slide of a
> SCHED_IDLE entity when it is competing with a non SCHED_IDLE entity.
> This reduces the latency of getting a non SCHED_IDLE entity back on cpu,
> at the expense of increased context switch frequency of SCHED_IDLE
> entities.

> 2) Don't give sleeper credit to SCHED_IDLE entities when they wake onto
> a cfs_rq with non SCHED_IDLE entities. As a result, newly woken
> SCHED_IDLE entities will take longer to preempt non SCHED_IDLE entities.

ISTR we had a rule about one change per patch :-)
