Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898723BE69E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGGKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGKxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:53:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37443C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:50:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r16so2109633ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqinmbsgubdY1rzngMj67q1SA/uOa/OYEUMRA9Sn7zM=;
        b=zZAvq1+uOQ6bNKl+wJAG++GGLSuAKMOx6EKxjUj89CNG1IU9b0hdHuii4FZLAkGRbI
         B4zLefFoYRgzpIB/tPlw7lOn/0qM7UwkWLgCDPny1Ze+MavjjQZRggk/CXrRatNxsFJ/
         A2bU/QqengHTt0gMO5FRku5XiliA+rIlA+SfzKCgLrW44zOvE+bkXBHcugTITBwe/qqF
         DKmbu/S4B18FuzNybygbphmD8UuJq/JoztU5dZK1T1F8aZr0Fmgw/5WV8FYahKcoxKMu
         MjLUeHeuKJHIutx+2CCUoVU3QVH3D4jhxv7kAXu7h9E7KnmbDBFQK3kP6mkYDDxGt7XH
         U4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqinmbsgubdY1rzngMj67q1SA/uOa/OYEUMRA9Sn7zM=;
        b=ubhvNLnmWUBF5jkYA/yqRr7B2//46BFxnDGOqcejLuzcgNi63s6CMhBOVpTiT+iFfR
         oxUNSvzyxfJthyZiZhmqT4fq9Oiin7ycyU0tOhTFPZbAd0p4xzSRipBOrBrAVC1KFu5X
         J02d41Oclg8XTr1TzcmyOTabViGkygVMj09WmPwDB1StKsk+4vjiwD8osJKQzSdyB2RY
         FaDxJqmpqmHkhD9U5jfxws3UFz/F0tTZ7MK6UIAJFH9pgrQSvjeGQB7Rud6vv155/1kP
         DQgUDxW5EWFoN1RKiYrTkwVzJwiiF1UPfDq61zaX2EScRxMJMWBBl+u5TOZP31rb8mpn
         hjDw==
X-Gm-Message-State: AOAM5315tZZ6jv0sui3u7viYOq74C408t4s1WfK6Xg9z7BcLiLDIY6+y
        Q75lzJt0hQAz43+Z/A4TGgldfCTmDzMyHJFD5X+owg==
X-Google-Smtp-Source: ABdhPJxVRUeGnfZJPEnXHmMhgLj82FF2HHUpDNW3RN06EBLqkeabaYDKOo+eGmrC8O6BFp0Sr+DXBI98Y/oTYH2DDUU=
X-Received: by 2002:a05:651c:1422:: with SMTP id u34mr5040776lje.221.1625655026585;
 Wed, 07 Jul 2021 03:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com> <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com> <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com> <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
 <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com> <CAKfTPtAN6-ytxa2Qj3=z27e8ZBoqGrWAZce9CojL3wbZSotUsQ@mail.gmail.com>
 <58cb7ad3-ffff-8940-4c8e-2c46dcc86d54@arm.com>
In-Reply-To: <58cb7ad3-ffff-8940-4c8e-2c46dcc86d54@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 12:50:15 +0200
Message-ID: <CAKfTPtCy-dbo0xnW8iKaQy94_iV=JYbMU-X4qanzL6RXcL7xEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 at 12:41, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 11:32 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 12:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 7/7/21 11:11 AM, Vincent Guittot wrote:
> >>> On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>
> >> [snip]
> >>
> >>>> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts
> >>>
> >>> Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
> >>> I'm not even sure that the power model can even reach an accuracy of
> >>> 1mW
> >>>
> >>
> >> True, the EM is registering platform with 1mW precision, but 1uW
> >
> > Do you mean 1uW or 0.1uW ?
>
> In this patch set I've proposed 0.1uW, but I'm open to drop one
> order of magnitude. The 1uW still be good.

I don't want to underestimate the capabilities of the power model but
I don't see which benefit you will get with 0.1uW precision
With a 1uW precision the long type currently used for the returned
value is fine for 32bits machine AFAICT
