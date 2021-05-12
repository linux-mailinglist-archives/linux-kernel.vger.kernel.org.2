Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0437EEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442822AbhELWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbhELVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 17:09:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A6C061349
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 14:07:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v6so31350649ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shL/E+KJ1M2BQNtlFBza8kT4lpBTPBroje+SVgryMFI=;
        b=cw6PPkPxEB2GxrjH3whmIm/kZm1KSdeW20fLdGWuhiPJy4IDAMpBwFWSYvkex+vdLG
         D5FLjc6BqWPV13qRBrGNkK3Dv6f7S4SqhR+gs2YTW8rdtwB49DIa9UAIRUB6uRtn+mLj
         YP8hH/nsl9Oa/1b5It9LQGVTqSTrQjaSplChI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shL/E+KJ1M2BQNtlFBza8kT4lpBTPBroje+SVgryMFI=;
        b=Sd0Z8CUwcWMBPQdH3MJB/erERGNtFYNLBuojpmkZ43+myan3K0S2SyySebY4qmgEcK
         K7cpknxtq4Muq7DrlW9cBySZaIWkX8OgOKONLNQAkbWnmN5UHrv32b2hbScoTkA9/x2G
         JpFL+5MlQzyDyWGTl57ev/qP6sPLxRgF6KZ4piRwvXfKjuIpbnYu0Xk8bv3a9epIdZyc
         3iOiQ+2yXnDP2sAyyALiCVnDoxPMg2QWYph9NsEKLlW9ctCC4R+e4Y/pn81VXWgp2Eeh
         nSbDWfxWcCMlEC/XzqpKDHuRXPopqwDA+QfMDO+4zL3XSn7alG4etJNhlr1FV39y0Ykn
         O+nQ==
X-Gm-Message-State: AOAM533NlvyMyLZCTGbvb/8cWh4mhHJbwO76T0tXwHpBGHfCGFvZCRfr
        m5iPr4VrTmA9wzfHfzV33dmUj+PxLVC0BUkcHqOBXQ==
X-Google-Smtp-Source: ABdhPJyQ/4PvHBFG67qffVJAbrvgaRPYOwJG4BmqMfjMxAePbl7tcAwMEqWWQRvv9yV83xG6oIy5GGKVjdBrt++Gssg=
X-Received: by 2002:a2e:2243:: with SMTP id i64mr4713143lji.94.1620853662542;
 Wed, 12 May 2021 14:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.980003687@infradead.org>
 <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
 <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com> <CAEXW_YSX79vR9hdkjKcf08uZk85xhC8nOnesf8s6Cvp2kqKoFA@mail.gmail.com>
 <2b4ae2b4-62e5-96be-ddae-b261139842c1@oracle.com> <YJuadFpNsfHu6n0Y@hirez.programming.kicks-ass.net>
 <CABk29NsMtsMvvVLbq7fGR0EMLZ9soFKGnE-SeectjWLym6YGcg@mail.gmail.com>
In-Reply-To: <CABk29NsMtsMvvVLbq7fGR0EMLZ9soFKGnE-SeectjWLym6YGcg@mail.gmail.com>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Wed, 12 May 2021 14:07:31 -0700
Message-ID: <CAOY2Woy-R0WeWN-2ZCwpE2S7Qox41C_PPxmkqN5QHJr7ANhRTQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 1:58 PM Josh Don <joshdon@google.com> wrote:
>
> On Wed, May 12, 2021 at 2:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Right, I need a Champion that actually cares about cgroups and has
> > use-cases to go argue with TJ on this. I've proposed code that I think
> > has sane semantics, but I'm not in a position to argue for it, given I
> > think a world without cgroups is a better world :-)))
>
> Not sure if Tejun has any thoughts on
> http://lkml.kernel.org/r/CABk29NtahuW6UERvRdK5v8My_MfPsoESDKXUjGdvaQcHOJEMvg@mail.gmail.com.
>
> We're looking at using the prctl interface with one of our main
> internal users of core scheduling. As an example, suppose we have a
> management process that wants to make tasks A and B share a cookie:
> - Spawn a new thread m, which then does the following, and exits.
> - PR_SCHED_CORE_CREATE for just its own PID
> - PR_SCHED_CORE_SHARE_TO A
> - PR_SCHED_CORE_SHARE_TO B
>
> That seems to work ok; I'll follow up if there are any pain points
> that aren't easily addressed with the prctl interface.

This is exactly what I'm doing to tag all the processes for qemu. I have as
shell script that creates a cookie for $BASHPID and then SHARE_TO all
the process and it works just great. :)

don
