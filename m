Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3552B40C548
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhIOMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhIOMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:32:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE938C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:31:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k65so5308502yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RMVz/YL87qFcfNY/40TnLa7NwiZxF7oASbtjCW+e3a4=;
        b=RzAvK5whFHR8Ja0G/byfrStN/Gh4cBJyxKb4g9NBLL7rLGvqIq05Fra5Bw7l1E/eAJ
         Xh60LlMhNBXL7udExk5GF6GgX5J2hqInSzKQzdqH5gb8W51HNlx9hfWvIWAuh28KkY2e
         lyKQnlt3SP+HjroUYvDLOm4fXd/xpC47tLU9fz44Vq5UcuRAY2gqjtYGXOO7NUsme2I0
         0VYgkCnIxEoxEw8iEX2FOYBns5hFePRrx21ydMoWcVfGMpyF3xIoLhnVrcrCqmm3RJk3
         EK2gTCT/xAzLKspLaltXX/zN65UbISZUGc1YcmiFjEXs0hg3/IMmRZ7YvCzXI7gW34ng
         f22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RMVz/YL87qFcfNY/40TnLa7NwiZxF7oASbtjCW+e3a4=;
        b=40w/4L/aeGtLFqCD4iuJOR7JWnO6jo4NaWNy8B4l1/pbHpWlPBouugVH4BUS/NmsLG
         fHbh4qyWbxpeOQgbxBAtvxtamBuWmx0B6lcAbzCeD0tO4t5hdsU0Bk6gwi7Lp/j+VTWP
         IBhiQtNmdh7luuRWdcx5L9/vkbUFqvmqVFO+nl0/Ahpov6M5Y1k5vd3iwFjM2s4cNYSV
         Puon02HRB7x4uPKXEC0UT/jPdmLEfDQbxRVLGsJ+DJCC2OQRL1PMS+sV5rlyBSa7Gpj8
         WC93IQjpHiJbJL4/L3FiVNYQWlApG6lnhB7158x8sIVOrlT3RgD3vWb+L9Sp1tdS37dI
         RGbg==
X-Gm-Message-State: AOAM533j7WXVhjCjPohEjodJKuf7hVBHFx2Iq9kptduu0DF9JXREmp7y
        1Fpp3kPemnSYt+mSzHiRW6YHYbKN3T3IeECXUpq6pw==
X-Google-Smtp-Source: ABdhPJwNIgYbkZgJEF6V8XuJgeeiK0bTe4qAJyKTIoOfMo0fC9XebsLm4yFw+BBZjRC+03lEAIp430YkfJoQnMwveEE=
X-Received: by 2002:a5b:142:: with SMTP id c2mr5909857ybp.425.1631709066908;
 Wed, 15 Sep 2021 05:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-5-mkoutny@suse.com>
 <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
 <20210914092207.GA23743@blackbody.suse.cz> <CAKfTPtDw6_iMxGyCK8vrwgV-zMyHtNKBksxs3OpbpK=houzp2g@mail.gmail.com>
In-Reply-To: <CAKfTPtDw6_iMxGyCK8vrwgV-zMyHtNKBksxs3OpbpK=houzp2g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Sep 2021 14:30:56 +0200
Message-ID: <CAKfTPtC5+4gf_R0bAVHe+0Fw6dQYQ_a-f529H9s4KLpm40X9Ng@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list maintenance
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 11:45, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 14 Sept 2021 at 11:22, Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
> >
> > On Fri, Sep 10, 2021 at 04:19:27PM +0200, Vincent Guittot <vincent.guit=
tot@linaro.org> wrote:
> > > Your proposal looks interesting but I need more time to make sure tha=
t
> > > all cases are covered. We have faced several odd corner cases and
> > > sequences in the past that I need time to check that you don't put
> > > some back
> >
> > Do you have any pointers to the cases that come to your mind? I wonder
> > if those could be reproduced with a simple setup.
>
> I don't have a strict list but several warnings for leaf_list have
> been already reported on lkml in the past and the use cases were quite
> complicated and I want to go through them to make sure they are still
> covered.

The corner cases that I wanted to check, are covered by
a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle"=
)
and
fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after
unthrottling")

This patch looks ok to me.
Also, propagate_entity_cfs_rq() could also get advantage of the same
kind of change

>
> Vincent
>
> > (FTR, I used the LTP test (at b673f49ae) cfs_bandwidth01 to check this =
change.)
> >
> > Thanks,
> > Michal
