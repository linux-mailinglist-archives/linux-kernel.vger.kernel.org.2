Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50340C258
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhIOJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhIOJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:06:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3vXsfhUkZtLTJ1AGHjbILwCR+5k9Ci1kXPWx7zfwTjg=; b=nQvuHpA6LaYvrqkVaaqv3NDZf7
        13PkJAbXyxu9gQ2mYLqpYR9HWaC0bwrPzoJkSyMnoWYl8JBrwY9ZZOakN3gG/7gQzjd8i32cZjkJl
        EGpke0C2S8R20akp+ycQGfIPjCmI+Pgix9nqyJrR0hBb4Be/FRaDLolbkbd97n/HfGdrVpKfD4Hbn
        +peNJ2EnvFa38CGWqr/Q+PtUxgSPGaycs4Yt5vAoSafSV57fUIsfkYu895IQlkEFZB/+JOO58WtvN
        pcCQFQ6mSpxwKLpBpQn1lRs018UnadyWV3fVOrBjf+ioLII+FClW8q2Qn8alJujKMEZepD3rFGb9u
        Mu5fHXGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQQpx-00FX47-Km; Wed, 15 Sep 2021 09:04:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B00BE3002B0;
        Wed, 15 Sep 2021 11:04:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 963AC2DD28600; Wed, 15 Sep 2021 11:04:12 +0200 (CEST)
Date:   Wed, 15 Sep 2021 11:04:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling
 support
Message-ID: <YUG3DBtJKO8mTVHy@hirez.programming.kicks-ass.net>
References: <20210909075700.4025355-1-eranian@google.com>
 <YTnL814pES+YWWnm@hirez.programming.kicks-ass.net>
 <CABPqkBROKmSLLCwFjiqObDpQz4iBUeO-0OaziNy05kxs3-4JHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBROKmSLLCwFjiqObDpQz4iBUeO-0OaziNy05kxs3-4JHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:55:12PM -0700, Stephane Eranian wrote:
> On Thu, Sep 9, 2021 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 09, 2021 at 12:56:47AM -0700, Stephane Eranian wrote:
> > > This patch series adds support for the AMD Fam19h 16-deep branch sampling
> > > feature as described in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13.
> >
> > Yay..
> >
> > > BRS interacts with the NMI interrupt as well. Because enabling BRS is expensive,
> > > it is only activated after P event occurrences, where P is the desired sampling period.
> > > At P occurrences of the event, the counter overflows, the CPU catches the NMI interrupt,
> > > activates BRS for 16 branches until it saturates, and then delivers the NMI to the kernel.
> >
> > WTF... ?!? Srsly? You're joking right?
> >
> 
> As I said, this is because of the cost of running BRS usually for
> millions of branches to keep only the last 16.
> Running branch sampling in general on any arch is  never totally free.

Holding up the NMI will disrupt the sampling of the other events, which
is, IMO unacceptible and would require this event to be exclusive on the
whole PMU, simply because sharing it doesn't work.

(also, other NMI sources might object)

Also, by only having LBRs post overflow you can't apply LBR based
analysis to other events, which seems quite limiting.

This really seems like a very sub-optimal solution. I mean, it's awesome
AMD gets branch records, but this seems a very poor solution.
