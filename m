Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16CA406AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhIJLpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:45:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:43:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s16so3268669ybe.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VMVUgRcV4Z/grB1WjttIzCGNMGmvXlycMzssrqJ854M=;
        b=d9KWVr7tUe4VoXcmJRV18Pg+IK5FyDz7YRkf4coCovdmTVLkNgif7dfu2ulEskrNkb
         EUczm+g+4Jg7LoCrc3PUap83+rQI/OyqMahJxX+k/R/5iGgnJK/dCWPkMVXPkomu8mhk
         QW07EEYDKM66HvX4lT+wWLf8Nd1peWPEb1aWh5pDKbI2VeqVLK75fvaCP1wCe2E/x+YP
         NUJeQsC4En7x3ehuW23Bi3lZMqWFwaMBvKU5yBmnAXTPrS9BIRi6t9xnTO3Vf+06GVh2
         e4kqTEb1FkJdZEm3xu1ej0SHh4L9+hZLlBecKIkfYoFUB2dVFFKYxYgyFxotEN3baJay
         WsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VMVUgRcV4Z/grB1WjttIzCGNMGmvXlycMzssrqJ854M=;
        b=7TQPzTvl5ZBPRY8aXCThGDQdpy+aFP2HQBkYJZ2gn2TUTi9Y6GcZjdktRCudcbXMEZ
         loqFxEGqsL9Dvln6nhb0hIx3SfAik9mALvV2nR2D3tI3phLm/EMHBFRLIuuc0FvF3ecm
         t9wrxHl99/F4KXkHvgR15031UclFxNimeyvHWd2SDVFOKZ6YoQIlV27pv26V/lfKC8uY
         r596vwX+pjnWmD+rdsIkoWRGx3LDBTCf0WHrVSAvNFvEvHcUQX5ZZ6VGllTnmyf+S3pR
         QDpmGQ/DunPSOawwyNstNF28fOzLORcJNdRt0ucg6vFsOpzxlMNBMXOvwfpuEH/ARYtA
         XYVA==
X-Gm-Message-State: AOAM530M7VVYGHY06L89NAszFGgH7xNGI3frJ+SKfzEnKdAwnA44jW6B
        k1QTRsv+XPJmtCvWqrbmud+89H4793eqO2FOU1kIWg==
X-Google-Smtp-Source: ABdhPJxtkp0TqHhtFA8mT9PMhjEBn9zKodvWRH2ds28iojKiLLgaCWgWbJz7m0QavFCq2mAygVTT78y/Wr/u4+ns2fM=
X-Received: by 2002:a5b:f03:: with SMTP id x3mr9308603ybr.546.1631274230684;
 Fri, 10 Sep 2021 04:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-6-mkoutny@suse.com>
 <CAKfTPtDwOGu9kkMdXDx=+mGVGq_EmF0wgLen7hYO+VEy+j6rig@mail.gmail.com> <20210910113552.GA30004@blackbody.suse.cz>
In-Reply-To: <20210910113552.GA30004@blackbody.suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Sep 2021 13:43:39 +0200
Message-ID: <CAKfTPtC1T+S0MoaCJsdrw+XJQEkZ02uZSt2X4b66db4CnAi6sQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] sched/fair: Simplify ancestor enqueue loops
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

On Fri, 10 Sept 2021 at 13:35, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Thu, Sep 09, 2021 at 04:04:02PM +0200, Vincent Guittot <vincent.guitto=
t@linaro.org> wrote:
> > These multiple break loops have been done to make unthrottle_cfs_rq,
> > throttle_cfs_rq, enqueue_task_fair and dequeue_task_fair to follow the
> > same pattern
>
> Ah, I watched only the unthrottle_cfs_rq and enqueue_task_fair pair and
> missed the consistency with the other two.
>
> > and I don't see any good reason to break this
>
> Isn't this a good reason
> >  21 insertions(+), 36 deletions(-)
> ?

Not if it make the code less readable and I prefer the current implementati=
on

>
> (The stats are with a grain of salt, I'd need to recheck how these stats
> would hold if throttle_cfs_rq, dequeue_task_fair would be modified too +
> they look a bit better because of the loop from 1/5.)
>
> Michal
