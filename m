Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710CC3B90FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhGALMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhGALMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:12:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A414C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:10:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 65so5593645qko.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfGds6BnQUXnFsToXmVlpRl9EGFieOscnvQwxQdcuP8=;
        b=WRZs228ixfJZYLWmabOSw65BO6S9roOO0ovheIy6MDtgDgyIJRcs947IMvognXs6nf
         /0T2GTmpYT5BB/u1Uns7KRvWrEC+ASA+5vz4f1NOCe7ABpGwBhUjKT9mfuT3Ff4ymy6y
         7QWqQj34ImZYeWbn0GJoOBf3r6ZB184i/D+GYoJ9BWBcd5NGR8xtVThs/UABmkH+IneH
         ylYQSJ5oV2buAFl+iwbrdyu8TRauIf83GYFON8mWCMGUL6OSTSuEeOffAyP+k1ajYTQW
         GJTLYmDxFpSIJPLLqQKpQY8E6p90L5RenascqSdUarQ1N0ePjZuN13FmIbZS9qqi9ywL
         HtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfGds6BnQUXnFsToXmVlpRl9EGFieOscnvQwxQdcuP8=;
        b=C4rjmvqncSvVZfKpppajg1EUbhGHAIHVEbwmZuhW0orhGEZZvEEwMx4zFYAjAHTwy/
         IVSgTgK3kqxW1tqPww52NoPwnpXhoyjIYa8WPt11+2XL6zr6msDe0unaHmzGkVSdIKsg
         9KGgfMaGnW+L1m21hg+ASQjVoIxf75Wtf+BglyKnM5hrd/2V8JYI5vIwIJDjUCMaen19
         EDsG4RYlpQ42bL+Lc7gF7sj8ag/I3XlReZYDJo6qUzrWQnhE5u0Cxn0vavD3erbwXK0v
         YrcXjXHeQ/A6DE4jYORnl9H6f0vqONXTwPrAQwdH6YbgBrLVk9h4/7s6MK6heWci9EB+
         xVFw==
X-Gm-Message-State: AOAM533bKT19mePoC/q8wUgZrKTI7fb6PyqqHOD/beUDvYeTXfnWpcoK
        OjkpdpdsEhxNBF1gdbo4ff7YSit5AwkK8tQmBv5kmA==
X-Google-Smtp-Source: ABdhPJxK81/tXcxjZ99wIr+hQBWxN/HhS0cvOYye9PN4/sTZYjwU0kMpEcu7UQuFRSm3kQaCWrNJ/fCmcmbd/+uBDfY=
X-Received: by 2002:ae9:dd06:: with SMTP id r6mr42243802qkf.74.1625137804041;
 Thu, 01 Jul 2021 04:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210624111815.57937-1-odin@uged.al> <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
 <20210701103448.GL3840@techsingularity.net>
In-Reply-To: <20210701103448.GL3840@techsingularity.net>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 1 Jul 2021 13:09:33 +0200
Message-ID: <CAFpoUr1mpErE1Soa05p36wL1uTeojQ2mqNLJ1GKVnpJ+x-3itw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Odin Ugedal <odin@uged.al>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tor. 1. jul. 2021 kl. 12:34 skrev Mel Gorman <mgorman@techsingularity.net>:
>
> What was HEAD when you checked this? 1c35b07e6d39 was merged in the
> 5.14-rc1 merge window so would not be in 5.13.

From the kernel log it looks like he used commit dbe69e433722
(somewhere in Linus' tree), and that should include my patch. I don't
think the patches from Vincent in the previous thread have been posted
properly, and I think those can fix the edge case you are seeing.

This should mitigate some issues:
https://lore.kernel.org/lkml/20210622143154.GA804@vingu-book/

while
https://lore.kernel.org/lkml/20210623071935.GA29143@vingu-book/
might also help in some cases as well.

Both of those are needed to make sure that *_avg is zero whenever *_sum is zero.

> # git log v5.13..origin/master --pretty=one | grep 1c35b07e
> 1c35b07e6d3986474e5635be566e7bc79d97c64d sched/fair: Ensure _sum and _avg values stay consistent
>
> It's not tagged for stable and lacks a Fixes: tag so I don't think
> it'll be automatically picked up for 5.13-stable unless Odin sends it
> to stable@vger.kernel.org.

Ahh, so the "Fixes" tag is what makes them pick it up...  Thanks! I am
fairly new to this, but it does make sense when I think about it. I
have seen https://www.kernel.org/doc/html/v5.13/process/stable-kernel-rules.html
before, so I guess I can send it to them to get it into -stable. The
assertion is not a part of v5.13 either though, so people will not see
this warning there (but it can still cause fairness issues).

> --
> Mel Gorman
> SUSE Labs

Thanks
Odin
