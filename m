Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2637EDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387930AbhELUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386849AbhELUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:22:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C814C061353
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:20:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j19so18198734qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUIJstx/27xJVJz6QvCNOVh0gIQL6FYmLOnlZbT26JY=;
        b=gHtfhdTydYQykUTziTudHgN3fY5eRaL0TRbmCbpE/HyutC8I7eMRHymRr0f/F94N/q
         mDhKFMgyHunn8V1UvTp453K69fOaVBWqmCxPSLAyvQBRnujT00a2RCjMQqcord9iYI9Q
         DgikAWPXqoLdPCm2cv9GuFTKyablXEAcS6dUKsUy8GWTFTzqtR+lFSIXcchBFuJDQTVI
         ee8VsLYjNhW5H51afxzp73EcbEhAQcRk4mzK5s5t9C3K0XzrgmEseLbPZyS+KQLhr9bY
         BjzOCT1RSNrq+EE6oo05Z8m91yxppvW0iTyMG477mdxXC9iH8S5l7W/m/r4E2bupSKHU
         ER9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUIJstx/27xJVJz6QvCNOVh0gIQL6FYmLOnlZbT26JY=;
        b=t/OUEkhlXdB9RBa2dLt8BT35jCXzaKHrLUygSqqCa5DdhA1GFdga/VYNYcjWR1c1uP
         LZaChGducifSe9ULaxXDoY0/6inQt2UdRp3DqP2dvVAFdtsTZyZEEc5kaMsU5Zp1aoXf
         UH0fQIWrZhQewQp3U49RpKHlgPFgjXw2xMAzhmfM8IXGb8Cn3RSpC8mFRYH1eD9L4T8q
         X17qat7PFtzvJKwLXWDL/zCfrflEkfQq1BVHXCmkP9el6cTo/Ggy7NlrpvY8WFaMECw8
         WqZZNngRssFBN9N5BFn+CbpMjzBPiyoY15IJbJHRPRdjc3Pk/6ixGqU9CuY8jXD37Myq
         g5VQ==
X-Gm-Message-State: AOAM533Dm7Qb1vVpSe6pyJHkMNgfWt6P+PkIyoMCoQ/FUQ9aBqV4UA4X
        kwMQal3Yr0lxbX9Zf1tqF4CuOz6FONZof6bu3dAN0Q==
X-Google-Smtp-Source: ABdhPJxtMXLhHYJuWiY0OsXg1Vwzw0RC9z7My1doZmIhPaMmNZmmtY48fMAiP4xOY5Y5j5Fi2FbfcrWCKiwFMmKBvys=
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr34729020qtw.317.1620850814080;
 Wed, 12 May 2021 13:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.980003687@infradead.org>
 <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
 <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com> <CAEXW_YSX79vR9hdkjKcf08uZk85xhC8nOnesf8s6Cvp2kqKoFA@mail.gmail.com>
 <2b4ae2b4-62e5-96be-ddae-b261139842c1@oracle.com> <YJuadFpNsfHu6n0Y@hirez.programming.kicks-ass.net>
In-Reply-To: <YJuadFpNsfHu6n0Y@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 12 May 2021 13:20:02 -0700
Message-ID: <CABk29NsMtsMvvVLbq7fGR0EMLZ9soFKGnE-SeectjWLym6YGcg@mail.gmail.com>
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chris Hyser <chris.hyser@oracle.com>,
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

On Wed, May 12, 2021 at 2:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Right, I need a Champion that actually cares about cgroups and has
> use-cases to go argue with TJ on this. I've proposed code that I think
> has sane semantics, but I'm not in a position to argue for it, given I
> think a world without cgroups is a better world :-)))

Not sure if Tejun has any thoughts on
http://lkml.kernel.org/r/CABk29NtahuW6UERvRdK5v8My_MfPsoESDKXUjGdvaQcHOJEMvg@mail.gmail.com.

We're looking at using the prctl interface with one of our main
internal users of core scheduling. As an example, suppose we have a
management process that wants to make tasks A and B share a cookie:
- Spawn a new thread m, which then does the following, and exits.
- PR_SCHED_CORE_CREATE for just its own PID
- PR_SCHED_CORE_SHARE_TO A
- PR_SCHED_CORE_SHARE_TO B

That seems to work ok; I'll follow up if there are any pain points
that aren't easily addressed with the prctl interface.
