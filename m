Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5562D41CC40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbhI2TD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbhI2TD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:03:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:01:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z5so7678155ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1HrOgnHYMt6/j5z86XsX78v2f2V6qyrrlkiNPoh4Xo=;
        b=AEjByFqc2whHkx+eeZQZlR569mQhX0vVW1jO4vxy70+jtSZlVyJceQ/hEduBi/xI7h
         dbka8h8jShnd0qhwSkURayRW3kCpn3AG4BAcGX/9YXHAX9sAHXZFMWkxHyh6ESYRUfZl
         ZBTz2lYLIeGnRzkniDPMwuUsEf+O1kndfSQGt7XXn2t1AtW7PxAAtWSWD6uG50k4NcmC
         H8019WXqwqKqANZA01uLbZwGZJ20+dsz3wBtq02DOVXFnFzBTUPBuWfhRApsOwpCs3DE
         QtJwORB/4H5r7AjQmBBOx7bkkzrEabge5tIX0Z7X25KeruKmz3zSNnzI/DMnEhBT6aqH
         28BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1HrOgnHYMt6/j5z86XsX78v2f2V6qyrrlkiNPoh4Xo=;
        b=7vVm+zrKA1N2S+koggceaKQULikMZPFfcZtGe5wnFHZ65h6JVXTY4Ky1+0zW2Cm/G9
         w8PqbRZO1INHzOi8jRikbUmKFKt415vAFfU2TRwC9HbUwO25k3FZ30eEAq/zkFkWVRXb
         d/GzHQt/fCBzDqC7Q3ZLMHKUlV3crKmOrO8fyuEtOoqDYmqC1uhseIK2f0ETPcR8fCkz
         j7nxaw2nVryi/s0iKdm/swLxfpodcUtc2YWvZrwnKDoWP/tTTK+hPEc5/nC4oJQIfd8m
         BZIUVlf5DHik2MRHfG08AdtASh3OllAy9CBTOe8j0Yy4keop3u7G1Qf1vljgxA+9g4qJ
         kBvw==
X-Gm-Message-State: AOAM533qYCmq6ZdWT/pL4lLWI3P3SwSPZ+pgJGujMxc06W8HYpsHGm+A
        mkIJJtHV7U3qLESsegeLwPMafQLeq2FCFcvK0wrSeg==
X-Google-Smtp-Source: ABdhPJyMfbkO1GE+TnZ1h+PquDmNgg9khTPescylLKR/RobKDu3KEe7quLxrZEP/ej0z7H5y6152FSe2CunSpCPDKGQ=
X-Received: by 2002:a5b:783:: with SMTP id b3mr1768829ybq.328.1632942103708;
 Wed, 29 Sep 2021 12:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210929005103.698172-1-saravanak@google.com> <CAJZ5v0juFEy-7HPAVyL6qibzhF48tH_qgzh9Kjj32iEY2j0Q9Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0juFEy-7HPAVyL6qibzhF48tH_qgzh9Kjj32iEY2j0Q9Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 29 Sep 2021 12:01:07 -0700
Message-ID: <CAGETcx--z9VSyEuxE6nc7SWA+z-y9L7CQhTj2ZMdSRZdYqkCgw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Reject pointless SYNC_STATE_ONLY device links
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 5:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 2:51 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > SYNC_STATE_ONLY device links intentionally allow cycles because cyclic
> > sync_state() dependencies are valid and necessary.
> >
> > However a SYNC_STATE_ONLY device link where the consumer and the supplier
> > are the same device is pointless because the device link would be deleted
> > as soon as the device probes (because it's also the consumer) and won't
> > affect when the sync_state() callback is called. It's a waste of CPU cycles
> > and memory to create this device link. So reject any attempts to create
> > such a device link.
> >
> > Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 15986cc2fe5e..eed27933ac4d 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -716,7 +716,7 @@ struct device_link *device_link_add(struct device *consumer,
> >          * SYNC_STATE_ONLY link, we don't check for reverse dependencies
> >          * because it only affects sync_state() callbacks.
> >          */
> > -       if (!device_pm_initialized(supplier)
> > +       if (!device_pm_initialized(supplier) || consumer == supplier
>
> Why do we need to get all the way down to here in order to return NULL
> in the consumer == supplier case?

This is where it used to be checked before the "Fixes commit" so I
added it back here. But sure, I can move it up there.

-Saravana

>
> IMO this should be checked at the beginning along with !consumer and !supplier.
>
> >             || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
> >                   device_is_dependent(consumer, supplier))) {
> >                 link = NULL;
> > --
> > 2.33.0.685.g46640cef36-goog
> >
