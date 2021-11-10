Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0444C862
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhKJTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhKJTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:08:05 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAB0C04C316
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 10:59:32 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e136so8938346ybc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+s8t/SmW0yke2hgKEqX+e1UnUfykD15/MTB1JLZE/ho=;
        b=oscsvsddiqqJL//la+u+Lyh9iAU7ue3n7AG8q8Qj3x6t1lY4s4vENZZ29s9jbilvxw
         h5FcehR3DX5MuQQQNOUR0U2/5szJutrxinnTvuUC2yI62tEjbP/LPf56SY4IcvCUVe/d
         oGElWFhP3mNCRvtc9FerlkGxB9qvzIKDzxkcJB+F7ApSfOpRoKvI8G2NAxKDSv8/jvFT
         kaKzH0cKk7k2z3EiNFoxBaHF/0OsSAL8lzLJtA3Yv3Lcd3X9ZeP7C9FD50w1yriqTofD
         tHkzo5vS5PoFX93sKa8eULVo4yfaDk4kqoaK6WBDAFetpMd7qPTeTUwAaqjD5wy5c3ti
         WQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+s8t/SmW0yke2hgKEqX+e1UnUfykD15/MTB1JLZE/ho=;
        b=Fkcuc9FPV1+GNX5+Mp0WLqwo1sTh7zZ2JLw3wNkw2uKS37+c/TCWt7ccx9wKFIQqd5
         4qsRV+I2H2vi0mvPgnO7B4YFe0To0UWDZ2JWWc/Y/nCOL8hR4mODgOTUib7F6Gh5bIpR
         IBsLqrBCD58ngOR4xrTHoMkhESlDal87y07rPHqyPkhi4ZXn9+KogDLQUBiWynJAkbmV
         lEUP0f3as+eq1WbFSGC1Nvu4BXU3QFuE1NAhh+eauyzSpWSLbAFc+DoGqUSKkIim4NLc
         dh9H+0U8Q3GJrTq9td2JRAWCexvDVzRDieaZE411C61M3eaNSOmi6Oqvck8cvsUwu1Cz
         lzxQ==
X-Gm-Message-State: AOAM532RJsNMwTcK007pYDGi/zl4UY54hD9gR6RcOJXqTn7gaUwpMEfl
        98lm6CfF6f7RR6UYrUVxRzX2fQyViXxS9Q8ldb3VsA==
X-Google-Smtp-Source: ABdhPJxmnvEP+w6/OoB17Stbvzd5qJFt23KE33dhCc4/1lyPSChKTW0OnCZlzYrielo7hRnBxwCIGqHW9CqruRixtq0=
X-Received: by 2002:a25:6185:: with SMTP id v127mr1682355ybb.100.1636570771120;
 Wed, 10 Nov 2021 10:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20211018203428.2025792-1-joshdon@google.com> <YYpYP919xlC0NX7/@hirez.programming.kicks-ass.net>
 <CABk29NucnFxyPQ==n8-v=_hti2THkybrEkxruqJ_v8rvW4yacg@mail.gmail.com>
 <YYuFHZCxtJe+BpWM@hirez.programming.kicks-ass.net> <YYuJ3yE0gottvExw@hirez.programming.kicks-ass.net>
In-Reply-To: <YYuJ3yE0gottvExw@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 10 Nov 2021 10:59:19 -0800
Message-ID: <CABk29Ns9+F_-+=ZQPvH0WTbop5CC=ZB4=kg-yz4jSfvDBP93_Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: forced idle accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > Ok, I already changed the patch to include the above, lemme also edit
> > sched_core_tick().
>
>
> Something like so then?
>
[snip]

Thanks Peter! Looks good to me.

One thing to note though: now that we don't have the
schedstat_enabled() check in __sched_core_account_forceidle(), I'd
recommend either adding a "REQUIRES: schedstat enabled" comment to be
explicit, or switching to schedstat_add().
