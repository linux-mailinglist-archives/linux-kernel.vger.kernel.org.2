Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3D3B9108
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhGALUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhGALUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:20:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F06C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:17:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w19so11175697lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFPUItBMnncK7FHehif+IBkI2DHCqlFHO1vIqrwRGSQ=;
        b=FITtGH2VIoJiv/K+yqkEckOSGh/No1WWyQpXykyRPUj1S+pSaUEF2C+6+QYY7P2eIE
         wGdCdF8X8FQJuJcCowuwFfZXL04QA+yma6Rl2FT0DRQOR9zptMOh0WqcFk6trlW/+to/
         1ZXRUbprfCqOROVNozmzQy/J2r6F+vhkLcoF1ED7YD4PP0aSkjdLf5aFitSifL3iL28U
         x9XAfRkRW7CUDP0quCg7D8iKGJ3xu10fxQ9pX2oLsgZ3omjFFS90EIh5yCRpD2qgzzLj
         +Ka+y5D5Q3dsBZfeiHudfwmMc5yt9MdzBG6FtERizzsr1/Hze46EqBHTyftNQfEB8KbU
         Baow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFPUItBMnncK7FHehif+IBkI2DHCqlFHO1vIqrwRGSQ=;
        b=GrmTv5afh7Suv2sACifEf6wWTAMsuH76HW+aZ01GGDb0/DK0bg+rVBzox0+19TnbUq
         rGcH6XwcFvugNpcW7aYNvzfGNgcXpYD53o/Z4bZMXsjQQfEkL9zcln++PzCoe/+owzme
         7IPg2iPpA/hZlIFPC7gO8iMRG0soTIIoMe52MGcBfJH28+j29fAhRmF9X08SNTlm/OaH
         rQeZ94psyg4oKy+L9F+V8lwE/aUBEQ0mRy0QMjB7y3sr+Te7SgyBpBd0Q5D7pzaqwb7H
         Z9LgZjCweiXBC3ANkLE8zgkgIG17RBnK1PjQeurIT9/fBO8b2Jo6jhoLJ2ILxed3bsrR
         ycZQ==
X-Gm-Message-State: AOAM532DKzr/ai1ZbEhRzHDUuNVJWQDa35WYsTxtv3cwwI94P0yMWOUC
        KN/w8KZFqXkPAtTQcZCJQr7o3T6RAOY75M2kDusflw==
X-Google-Smtp-Source: ABdhPJz3ump/F+CEEAsd9xLbeE61Fc9Tnzv2NquCKJbQy8E4kSgiVZaCY012Ps1/KNkYHQ+O21fOXEEnOjF8oea/nmk=
X-Received: by 2002:a05:6512:242:: with SMTP id b2mr31880953lfo.277.1625138264081;
 Thu, 01 Jul 2021 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210624111815.57937-1-odin@uged.al> <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
 <20210701103448.GL3840@techsingularity.net> <CAFpoUr1mpErE1Soa05p36wL1uTeojQ2mqNLJ1GKVnpJ+x-3itw@mail.gmail.com>
In-Reply-To: <CAFpoUr1mpErE1Soa05p36wL1uTeojQ2mqNLJ1GKVnpJ+x-3itw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 1 Jul 2021 13:17:32 +0200
Message-ID: <CAKfTPtBG0r3mOON_i5cDtFP7pSG3pzue+TNAAQe-8a+FUwB3Lg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
To:     Odin Ugedal <odin@uged.al>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 13:10, Odin Ugedal <odin@uged.al> wrote:
>
> tor. 1. jul. 2021 kl. 12:34 skrev Mel Gorman <mgorman@techsingularity.net>:
> >
> > What was HEAD when you checked this? 1c35b07e6d39 was merged in the
> > 5.14-rc1 merge window so would not be in 5.13.
>
> From the kernel log it looks like he used commit dbe69e433722
> (somewhere in Linus' tree), and that should include my patch. I don't
> think the patches from Vincent in the previous thread have been posted
> properly, and I think those can fix the edge case you are seeing.
>
> This should mitigate some issues:
> https://lore.kernel.org/lkml/20210622143154.GA804@vingu-book/

Yeah this one should help . I will send a proper patch if it fixes your issue

>
> while
> https://lore.kernel.org/lkml/20210623071935.GA29143@vingu-book/
> might also help in some cases as well.
>
> Both of those are needed to make sure that *_avg is zero whenever *_sum is zero.
>
> > # git log v5.13..origin/master --pretty=one | grep 1c35b07e
> > 1c35b07e6d3986474e5635be566e7bc79d97c64d sched/fair: Ensure _sum and _avg values stay consistent
> >
> > It's not tagged for stable and lacks a Fixes: tag so I don't think
> > it'll be automatically picked up for 5.13-stable unless Odin sends it
> > to stable@vger.kernel.org.
>
> Ahh, so the "Fixes" tag is what makes them pick it up...  Thanks! I am
> fairly new to this, but it does make sense when I think about it. I
> have seen https://www.kernel.org/doc/html/v5.13/process/stable-kernel-rules.html
> before, so I guess I can send it to them to get it into -stable. The
> assertion is not a part of v5.13 either though, so people will not see
> this warning there (but it can still cause fairness issues).
>
> > --
> > Mel Gorman
> > SUSE Labs
>
> Thanks
> Odin
