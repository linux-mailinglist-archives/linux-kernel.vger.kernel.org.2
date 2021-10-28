Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E0B43E854
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJ1SdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1SdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:30:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 62so1930464iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVJUiiGg7BPcD0nHmnfGHtL2v/PQ6LcxLlzW2OXEqr4=;
        b=iTkCTrsCfSQze4Ok1K7X4JZ8B+mt+yuaT5x02z3IvB3eZoceGk+l6Rl0vLWOxtb4j6
         q/kvxEAsrqSdZ8bAg1v94Ujecv6sVMtoWvmppYlcjxPLv9NX9grNZ45nl69K9gju13kX
         HgRtSI9x8dpLg9Xd6LSOW8pq8dK9nAMtv+t2+W72UUSezXCk1u9+crz5bQhkktGLVEDH
         doz7ewhknNK89gpTavKqE5Wjqcey5ZztAt8ZEUmTSxMvPHRGcFOQdE/lnRk9Z+DPhYv/
         f0iwDoDwaeD6fYInN0G/v10TZChhfc/7nh+An+x2fCkS+LwCh+9FtpDYoGNKu3Aq9FDa
         EMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVJUiiGg7BPcD0nHmnfGHtL2v/PQ6LcxLlzW2OXEqr4=;
        b=6AcScJA7WEQmdOXBY3YmDCK81+84ekKvJPPQXG+dc5mXSX4eqDgLU5VdI0SnWkIui/
         7VB9oAvZw9p84GVBQdELhibAZP/Up9zf+zGbpOkLwNYaVNR+MdsDg9Im7SDO+eA2dvbf
         peYmo3kkmXgiZ2CxjLc/N84Z0CGfSrCU9P9kqpkj4R4J2HSKzhiDooIkERs2tIn2qqJ7
         KA4lPgCBN6D7WIbpe58Y59VByeX6yb+KbMO+MUYW9b63W1ytCisI8hDnu1xG7+p2dDNw
         U1NrcrGz2824U+RZhTwRHnxAxwETMRsL5oYzO6JkksWLRsclozNKPb483aC/92YSCg2w
         L5Lg==
X-Gm-Message-State: AOAM533YQdkSYCnJge4EIIqy5FQd61W7y2ycmWkK5OAMm7CPrgm6mtz5
        4sH0cF1AQK0fMzxeOC832sveU52r8dCr2StKY0gl1w==
X-Google-Smtp-Source: ABdhPJypdeO5lTvhivNSq33OjQQZSkIVoSXUfz+Q0JNJAhLmkHtgAbNk5UjnOsw6d1unDbTUJGxc9Hy7MvTCQ4W9YxU=
X-Received: by 2002:a6b:8bd0:: with SMTP id n199mr4269025iod.15.1635445840580;
 Thu, 28 Oct 2021 11:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com> <YTnL814pES+YWWnm@hirez.programming.kicks-ass.net>
 <CABPqkBROKmSLLCwFjiqObDpQz4iBUeO-0OaziNy05kxs3-4JHQ@mail.gmail.com> <YUG3DBtJKO8mTVHy@hirez.programming.kicks-ass.net>
In-Reply-To: <YUG3DBtJKO8mTVHy@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 28 Oct 2021 11:30:29 -0700
Message-ID: <CABPqkBRg=7udnCKvC=9OU6Pf=9V8kbqSLKhXeCKc3B1Jf=NyPA@mail.gmail.com>
Subject: Re: [PATCH v1 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 2:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 14, 2021 at 10:55:12PM -0700, Stephane Eranian wrote:
> > On Thu, Sep 9, 2021 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Sep 09, 2021 at 12:56:47AM -0700, Stephane Eranian wrote:
> > > > This patch series adds support for the AMD Fam19h 16-deep branch sampling
> > > > feature as described in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13.
> > >
> > > Yay..
> > >
> > > > BRS interacts with the NMI interrupt as well. Because enabling BRS is expensive,
> > > > it is only activated after P event occurrences, where P is the desired sampling period.
> > > > At P occurrences of the event, the counter overflows, the CPU catches the NMI interrupt,
> > > > activates BRS for 16 branches until it saturates, and then delivers the NMI to the kernel.
> > >
> > > WTF... ?!? Srsly? You're joking right?
> > >
> >
> > As I said, this is because of the cost of running BRS usually for
> > millions of branches to keep only the last 16.
> > Running branch sampling in general on any arch is  never totally free.
>
> Holding up the NMI will disrupt the sampling of the other events, which
> is, IMO unacceptible and would require this event to be exclusive on the
> whole PMU, simply because sharing it doesn't work.
>
Sorry for the long delay, I have been very busy.

You are right on this. It would hold the NMI for 16 taken branches.
Making the event exclusive creates a problem with the NMI watchdog.
We can try to hack something in to allow NMI watchdog + the sampling
event and nothing else.

> (also, other NMI sources might object)
>
On AMD, there is also IBS op, IBS Fetch both firing on NMI. but that
is less of a concern because the instruction address is captured by IBS
and the interrupted IP is not useful. So the interrupt skid is not important.

> Also, by only having LBRs post overflow you can't apply LBR based
> analysis to other events, which seems quite limiting.
>
This is a very limited functionality designed to support basic sampling
primarily to support autoFDO where there is only one sampling event.

> This really seems like a very sub-optimal solution. I mean, it's awesome
> AMD gets branch records, but this seems a very poor solution.

For now, this is what we have. It is important to get some basic form of branch
sampling on Zen3 even if it is not perfect because it enables optimizations such
as autoFDO for compilers today. We have verified that autoFDO works well with
branch sampling on Zen3.

I hope it will improve in the future.
