Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6485F3B1D59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFWPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:16:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310FC061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:13:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c138so6046196qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZeBBRZLdgs5z5YIW+IZOvyuL2HOJs5r51r/cXKgVrI=;
        b=YV66voH0V9MqAVOn7Keklep6VQK/r+/AlEwBzhLa/aXtZfO4MDlFTg7hphubEqbp+8
         JfW9fD173C1e0822uNyOw1UIMnx1MB0RmeKn2NSvxU9twMPAp4X1Q4koYTLOx9AMekjN
         9wMjYZELcmwL/iWnzTtlDWVmglTbUPx1lQRTQA9wypew7Hpwl/sqX3SKk4uu11CACnIs
         VschCj2ZyRo4Jp+C5NE1wI39wDPRGGVvLw03CjaVtUwNFV/U2lu9jtO0p5we6nrktiwi
         +ftiIXe1QeuQervG+nYNXMXwxPhe+RO2owMaStVg7GHfM2Yfdk9MApHpvV+XtxXcA8xC
         5bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZeBBRZLdgs5z5YIW+IZOvyuL2HOJs5r51r/cXKgVrI=;
        b=S5srXDAIrUwdB3pHQmox/gNwoO3Q0G3RuDZKgus7ZpoDdecdzWFHVdRmVZXyuQR7lo
         P7RUFYV7Suty2eHQdCqV2/17Waucs29Dpax6cB8s/qTGp537xIZtxXZlJMmL7nNSJx/T
         D0kUVVJOQ7E/aHCpCryIU/TTfo5ZijBNbQkQ+mHQ7LUoDlaE9jAyYMan9KZttz4Wicrb
         NGvS7/3hUeHkfbJEMZLElk39KFYs4UjS1szQ97Mz3Y/Fkuo6wmVFopYInXg0JCJ3pYDM
         Rfl5z5V06CqjJSwDqrMx9zBGAB832fQajMAuNOqmK2GRiWNlmQFZdEniZhEmLzyterfl
         IHMQ==
X-Gm-Message-State: AOAM530GHReri8nmefUIf40vm5LQYtYESo+DUptr7hhakaqTwZ7iKi2I
        Zcvh+M5fDQPVYxNiIINAfukXHlsyMj80hOCQwcpaOg==
X-Google-Smtp-Source: ABdhPJztGSPN1d/xRjk75/D+Fbiy6eSyD4Wtzm1wmWhJRjLyNZn3h+80Ztx7AH5f+x/Gj5yzIqqHgPAuhe1OmhCcg64=
X-Received: by 2002:a05:620a:16c2:: with SMTP id a2mr528118qkn.148.1624461227131;
 Wed, 23 Jun 2021 08:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com>
 <CAKfTPtDrHv4OOfPvwOE2DMNoucXQJ=yvvEpTVKrXghSdKEnZcA@mail.gmail.com>
 <20210622143154.GA804@vingu-book> <53968DDE-9E93-4CB4-B5E4-526230B6E154@linux.vnet.ibm.com>
 <20210623071935.GA29143@vingu-book> <CCB4222F-000A-44E8-8D61-F69893704688@linux.vnet.ibm.com>
 <6C676AB3-5D06-471A-8715-60AABEBBE392@linux.vnet.ibm.com> <20210623120835.GB29143@vingu-book>
 <CAFpoUr01xb9ZJF9mb2nmZDpUHXFH3VSbY3AU8-1owV-_7wVTPg@mail.gmail.com>
 <CAKfTPtB++3y4VnbKE_n=bgsqCfqXuF0KUsdB_cFhi9xAnMRubw@mail.gmail.com>
 <CAFpoUr3bHzrwvumw6R=2JVbKa_wmtT9cMf-mdDHxY0Png-N9Jw@mail.gmail.com> <CAKfTPtAev0VgCmK3AUyTCoVA38YmskpB98q0kTrbEPK6e=1dTA@mail.gmail.com>
In-Reply-To: <CAKfTPtAev0VgCmK3AUyTCoVA38YmskpB98q0kTrbEPK6e=1dTA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Wed, 23 Jun 2021 17:13:11 +0200
Message-ID: <CAFpoUr3Q+7Tr3y59H-BiFU7BO=dquhQpJ8M9JtmV0_3ySfp-+Q@mail.gmail.com>
Subject: Re: [powerpc][next-20210621] WARNING at kernel/sched/fair.c:3277
 during boot
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ons. 23. jun. 2021 kl. 15:56 skrev Vincent Guittot <vincent.guittot@linaro.org>:
>
>
> The pelt value of sched_entity is synced with  cfs and its contrib
> before being removed.


Hmm. Not sure what you mean by sched_entity here, since this is only
taking the "removed" load_avg
and removing it from cfs_rq, together with (removed.load_avg *
divider) from load_sum. (Although. ".removed" comes from
a sched entity)

> Then, we start to remove this load in update_cfs_rq_load_avg() before
> calling __update_load_avg_cfs_rq so contrib should not have change and
> we should be safe

For what it is worth, I am now able to reproduce it (maybe
CONFIG_HZ=300/250 is the thing) as reported by Sachin,
and my patch makes it disappear. Without my patch I see situations
where _sum is zero while _avg is eg. 1 or 2 or 14 (in that range).
This happens for both load, runnable and util.

Lets see what Sachin reports back.

Thanks
Odin
