Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8F392E20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhE0MjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbhE0MjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:39:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68CEC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:37:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a5so7021527lfm.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJtMUFIym4MCDsWc5krrIjsPhEBu67mDqVvWhXVdI7Q=;
        b=BaSCvx5P5J1/saPMpI2Hpv6tsMqa5H6pRd0iDGSEctw6X2Hvkt6JrbGoa3kwwTs7eX
         +fCKFH2JTP39JFuhDKAPYXJWiKZRu3YG5LKH0aoZ8krUMsp8iPhCwsrq1ulhUaNMqdaC
         isgXd2dPzQxJAhQGHyBqnGkgPTxqG3cslM6ByeSqP1hCrwdSSHo5242HJKTBr9QZfzWE
         n51fBmRVwURVenXx4Qmix59IlOSV14CWACBj4KesIk7qqxjv9EwzBRrzqCRSbu5PhtgD
         ocqgLwfsR9YlgMH5G9cbiyrkEyEKzU2cycb06RhI/BlXg7oMCjI3N49stuGLMzG+1ODU
         cVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJtMUFIym4MCDsWc5krrIjsPhEBu67mDqVvWhXVdI7Q=;
        b=iedY91xe4ceO/qqGFmWzkDqIdJuBR15zA988dsejmhzOweBTveI2uAUtzXXnBkjEq3
         uNEagQK4oDkHntX+o9qsoFailYryQSDZA3uppFUkQ/vwyFcMhcqC/Z5jJ1WvpNpzODi/
         1Lx+ztmY1OtVujdyc6FtpWfyXiyywBA4+6gwLQxmELWvP3fPCQ0k0yw0g8tF+So3ZPJi
         rLQxtqpKSc9ZKdQvGlt0vvJig5V/9SmmGqOh7454bZRoxXt5q9RXDfyFARIGXL0i5j+f
         kiHtyTW4hNy6m66Gvrlh8mUqYaMCovfUVSRwwGTqjCXVKD8kY8O4yHdesy38vMHKoIhf
         XmTg==
X-Gm-Message-State: AOAM530b9SI1mMbDVyGyQdB0cjx1cR/aqEaNpuig9fdvlsK/apuFf49P
        yLHzLWXY//wzuSYYceJ+TfAYhx9yWQD1WHA2mk3AGg==
X-Google-Smtp-Source: ABdhPJw1CZTF2VZBOlDqbR2wk/nxPBT1sQTg8SPezTCILIi6JptloJO4DeLYp/OLq67Tvrlq2fE4ziX1k+3iR25bWdo=
X-Received: by 2002:a19:e017:: with SMTP id x23mr2214851lfg.254.1622119047977;
 Thu, 27 May 2021 05:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
 <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
 <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com> <CAFpoUr0PTYs+CSiWt3WOXnxq=wN3uEyC=h+_3kDc9wLoqaRC_Q@mail.gmail.com>
In-Reply-To: <CAFpoUr0PTYs+CSiWt3WOXnxq=wN3uEyC=h+_3kDc9wLoqaRC_Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 14:37:16 +0200
Message-ID: <CAKfTPtA5NxDpG194zAF9CjchJ5hm-7fOBOPGJZG4+z4-+32qGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 13:04, Odin Ugedal <odin@uged.al> wrote:
>
> > 1st : ensure that cfs_rq->load_sum is not null if cfs_rq-> load_isn't too
> > 2nd : call update_tg_load_avg() during child update so we will be sure
> > to update tg_load_avg_contrib before removing the cfs from the list
>
> Ahh, yeah, with "1st" that would work. Yeah, that was my initial
> implementation of the change, but I thought that it was better to keep
> the logic away from the "hot path". We can verify this in
> update_tg_cfs_load(), and then force update_tg_load_avg() inside

For 1st problem, the way we were updating load_avg and load_sum, we
were losing the sync between both value

> __update_blocked_fair() when avg.load_avg is 0. (Given that this is
> the only place where we can end up in this situation. I can update
> this patch to do that instead.

In fact, the update was already there but not always called (see the
patchset i just sent)


>
> Another solution is to update avg.load_avg
> inside__update_blocked_fair() when load_sum is 0, and then propagate
> that with update_tg_load_avg(). This removes the logic from the hot
> path all together.
>
> Not sure what the preferred way is. I have not found any other places
> where this situation _should_ occur, but who knows..
>
> Odin
