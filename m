Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FAE365FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhDTSpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhDTSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:45:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48030C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5F3jGx65SnQO+RXht0oRt+BbRnMmT6jpP4qDeYt/9B8=; b=ZRlhx4xEJQQj2fEiL3lgOBdo+B
        LBlfpZIogBk7mLSC61EUMlmk+gGkIDzHBza6afU3m0q7akIGTgwkvrBSByHT4zGJ6OthYrRd3CbdI
        kiBfput0fErOsgOY7uVBSGMA7gIzyNjvpb/ENGsFBzVIi+UvijVNX1cbPHfW++UudbdydTzyARuNa
        A5p2YX0aZJqRBKghzYdAJSmWe2P9ZF3FJh5m2z88gVZbZqx68Aif7DfuTcfS/9NyYTDN0heSYVbqD
        cenRP5LqRduTNVFMivMBW4Jh+JHFbDBBU284ZryLMzyIgVe84dJzp2Ul+b5gfFZtgOvhbg67SYAUu
        gqngzRbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYvLW-00FW5Y-Ar; Tue, 20 Apr 2021 18:43:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC20130020C;
        Tue, 20 Apr 2021 20:43:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6AB201A2E19; Tue, 20 Apr 2021 20:43:36 +0200 (CEST)
Date:   Tue, 20 Apr 2021 20:43:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YH8g2EPn+2cvN3JA@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7civd59i4hquyxExQALcxOeDxk_ODpJwCRr-Rm3iMeahxQ@mail.gmail.com>
 <YH6s3P/3hQxI21eO@hirez.programming.kicks-ass.net>
 <CAM9d7chaxr4o3iY1Y+Z9W0C5rZ7gazvUA2U+Uq_L6CHaHsFqGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chaxr4o3iY1Y+Z9W0C5rZ7gazvUA2U+Uq_L6CHaHsFqGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:37:11AM +0900, Namhyung Kim wrote:
> On Tue, Apr 20, 2021 at 7:28 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > You forgot NMI.
> 
> Thanks for your explanation.  Maybe I'm missing something but
> this event is basically for counting and doesn't allow sampling.
> Do you say it's affected by other sampling events?  Note that
> it's not reading from the PMU here, what it reads is a snapshot
> of last pmu->read(event) afaik.

Even !sampling events will trigger NMI to deal with short hardware
counters rolling over. But yes, !sampling can also be updated from NMI
by other events if they're in a group etc..

Basically, always assume NMI/PMI can happen.
