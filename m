Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9429C3729AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEDLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhEDLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:50:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC29C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 04:49:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y9so5726364ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ojk0uBlcSQA0tRoIr6v61EVqnolFhG0EuiHG8D7GLow=;
        b=KRpkSYzoZGwaGRkN1Ey+Rwmni9zy8TzJkmZmJlhT50ctyokurFobZoDpzNdvR9utBz
         6edivwHlBmDU9f2ra+TjMK49Jno1YE67rkr1P/ynF50TEx970UsvxhLJyqN0LYcpegoX
         tY4A1zehnbDfzQ1Gev+bbHwDiBW/oxeyHCdr0MxvVKM17vGTqP0+XRYSrNWnEa7f9ydW
         Z+MNQZOEf1FWMdnue7sJo5hZVAlDIgZ2jW2TmnYpQu0M0yHFe7l8/gE3ipoBP8ZWW+Ia
         ETAbUmmqWSl8m0rWlGJnAolXBSsXK1UZUwmVAI7ySiyQZGhKpB3nuQjK0c2eVBVEp6l0
         N+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ojk0uBlcSQA0tRoIr6v61EVqnolFhG0EuiHG8D7GLow=;
        b=PgYCZvZ6fwAxB2ufjsso7hcm/usd8j/EuUieTEM4tOQPcUXN0ImPmXZGuribCSWdbc
         DeF03Law9cxOCmhrmTR+EwXATwxR3lttOiQmLqjnFKHXyhYV3tLpd4c3bL29zlGEPTeV
         Gbd5kYfCaGYwBtux1nyOrH/MC8hemZT7urWi6Rht/FHAzx/nP9gVGP8xfJ88XJhMN7RT
         Ay79nKsc3YrV4gw6QIgsNI6MZb/2FdbErwg2uuTypJ0QJglClMEHyJFd5sTQgGFQLL+I
         YY07fkBRPZ8XsLNYByfs3MHZL4JK73SSUi+MGisC8qezASGao7GIjvLXU7D/G6wTt2ky
         eBHg==
X-Gm-Message-State: AOAM531z9SqR+yQta3RrSqz06GwPg+EZSNcQnrGDMTrpxl6gYanowe1S
        nfztW5FS59lb4783w4iaIASoycygVct5DnhXRwc=
X-Google-Smtp-Source: ABdhPJzKy8vHzqdQTks+QG264+LYBuuRJGMOCERQ0ZNnynfSFFtqj6L8fAwYj4DjOWElRFvobvgwqKrkgXeerUKCAs4=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr17094355ljp.227.1620128988341;
 Tue, 04 May 2021 04:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210504090743.9688-1-Pierre.Gondois@arm.com> <d06dbab5-60cf-a558-0ded-2d224aca89fd@arm.com>
In-Reply-To: <d06dbab5-60cf-a558-0ded-2d224aca89fd@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 4 May 2021 19:49:29 +0800
Message-ID: <CAB8ipk8ozBDFP7GfRMLZVdjO8D5e+OuFKOOQg1zkEgb9g3Qdug@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sched/fair: find_energy_efficient_cpu() enhancements
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, qperret@qperret.net,
        Lukasz.Luba@arm.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent.Donnefort@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre=EF=BC=8C

The two patches look good to me.

Thanks
Xuewen Yan

On Tue, May 4, 2021 at 5:11 PM Pierre Gondois <pierre.gondois@arm.com> wrot=
e:
>
> Hi Xuewen,
>
> Please let me know if you have some comments,
> Pierre
>
> On 5/4/21 10:07 AM, Pierre Gondois wrote:
> > V2:
> >   - Split the patch in 2. [Quentin]
> >   - Add testing results to the cover-letter. [Dietmar]
> >   - Put back 'rcu_read_unlock()' to unlock the rcu
> >     earlier. [Dietmar]
> >   - Various comments. [Dietmar/Quentin]
> >
> > V3:
> >   - Layout/phrasing. [Dietmar]
> >
> > This patchset prevents underflows in find_energy_efficient_cpu().
> > This is done in the second patch:
> > sched/fair: Fix negative energy delta in find_energy_efficient_cpu()
> >
> > The first patch:
> > sched/fair: Only compute base_energy_pd if necessary
> > prevents an unnecessary call to compute_energy() if no CPU is available
> > in a performance domain (pd).
> > When looping over the pds, it also allows to gather the calls
> > to compute_energy(), reducing the chances of having utilization signals
> > being concurrently updated and having a 'negative delta'.
> >
> > The energy tests of the initial EAS enablement at:
> > https://lkml.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com
> > have been executed using LISA on a Juno-r2 (2xA57 + 4xA53).
> >
> > To recall the test:
> > "10 iterations of between 10 and 50 periodic rt-app tasks (16ms period,
> > 5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules.
> > The goal is to save energy, so lower is better."
> > "Energy is measured with the onboard energy meter. Numbers include
> > consumption of big and little CPUs."
> >
> > +----------+-----------------+-------------------------+
> > |          | Without patches | With patches            |
> > +----------+--------+--------+------------------+------+
> > | Tasks nb |  Mean  |    CI* | Mean             |  CI* |
> > +----------+--------+--------+------------------+------+
> > |       10 |   6.57 |   0.24 |   6.46 (-1.63%)  | 0.27 |
> > |       20 |  12.44 |   0.21 |  12.44 (-0.01%)  | 0.14 |
> > |       30 |  19.10 |   0.78 |  18.75 (-1.85%)  | 0.15 |
> > |       40 |  27.27 |   0.53 |  27.35 (+0.31%)  | 0.33 |
> > |       50 |  36.55 |   0.42 |  36.28 (-0.74%)  | 0.42 |
> > +----------+-----------------+-------------------------+
> > CI: confidence interval
> >
> > For each line, the intervals of values w/ w/o the patches are
> > overlapping (consider Mean +/- CI). Thus, the energy results shouldn't
> > have been impacted.
> >
> > Pierre Gondois (2):
> >    sched/fair: Only compute base_energy_pd if necessary
> >    sched/fair: Fix negative energy delta in find_energy_efficient_cpu()
> >
> >   kernel/sched/fair.c | 68 ++++++++++++++++++++++++++------------------=
-
> >   1 file changed, 39 insertions(+), 29 deletions(-)
> >
