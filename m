Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC738C42E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhEUJ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbhEUJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:55:09 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F7C061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:53:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so11093117pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SBPs6mShzezlAEKsBtxITwEilEWSuPi+uM6YOTTKA0=;
        b=MZr7JvOQFyam98C+J1xL7XGvMTEVpYt+9iUJO+AM6hYm3DSm4p04UGBjIlVnREsYGL
         UyO5WUQv+tKfePEB0+w+gQpFuAaVm+zW6TdDiWRbstgx6StOsiPUj7jcFXSRJx6GxD/b
         TsWRXVLU/vWDKYmA0dsvqyLiEE8qZYEvkIanbqzOMjJz3N2I437+34U0E7qjjBp0ytHo
         tfY7fiUYAKA9eO4BXIvcbgICiqrPN2unRSbY17Q6nnVjhT7xVIUQ97dTjbo21Z75KSQj
         ne0EIZSa/Z+1bg+d/Cf+gUoyNnTY2QKHJPdHRjN5MLzDwHhNqOxB/kX0XTYVyymoc+Wv
         Lmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SBPs6mShzezlAEKsBtxITwEilEWSuPi+uM6YOTTKA0=;
        b=d14XIt2tZ5guwXJ/VQ0nCKMi6fDV6KE1gnulmFAJe/kP5gEQ6aVSV0Pe1g7vpWMYsr
         huq0PsHPlReHcyI5srQN92bXwooFnKUAJ6rhHjEUejaEdHZmNORX7VY3VeZ5FTALgEry
         8Fp62UvljchcHLslbYEmR5JWuiZXktYGH/7B1HnZFGc1nbOeZ+ZAS54RBbXCkz92OabJ
         74QtkY0V0lj99cpvi8yrmmo8R5EXQZnP0eD97uyV+OV/Ic/Y38KgkvuNQ3EUAuSZbRok
         H0YUmsVdSZ63vEz0u+CXamGbMm+fezP3JTAGfUYwYeoUdy8/iqn50ZDfpIslesa8zEMw
         bZIQ==
X-Gm-Message-State: AOAM530ZdYYwIGb2mkxoCjP6jnnnLJ9IS9CGJTvonIzSF1hn4JWT17u+
        nqCIK8zHOjMXWo1cGCSsK2tEMsPhEeu5k5v80XU=
X-Google-Smtp-Source: ABdhPJwY2j/KmGOYFcZjPDr0B995sBdpKi+ZIKLx2htYq8WHfFGwAWULquX6VZ+4+aFxymi9g7RkdyyWqgromFK2dlI=
X-Received: by 2002:a63:4145:: with SMTP id o66mr9106201pga.4.1621590823809;
 Fri, 21 May 2021 02:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
 <CAHp75Vf8kQ73w0R9ieDNjDVkxM-V83QRN9mc6BjRZA8xHpPNAA@mail.gmail.com>
 <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com>
 <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com> <CA+7tXigG7QVYOtkuFrqciHfuxE4+c0JM9z8r0e9rooTjjz5PYA@mail.gmail.com>
In-Reply-To: <CA+7tXigG7QVYOtkuFrqciHfuxE4+c0JM9z8r0e9rooTjjz5PYA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 May 2021 12:53:27 +0300
Message-ID: <CAHp75VdeSkQSHjwTFObj84TyOOW2dh9LW3Ci9L7=iDFTbEvRoA@mail.gmail.com>
Subject: Re: A divide by zero bug in lib/math/rational.c (with triggering input)
To:     Trent Piepho <tpiepho@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Yiyuan guo <yguoaz@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oskar@scara.com" <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Daniel (here is a real case for test cases!)

On Fri, May 21, 2021 at 12:20 PM Trent Piepho <tpiepho@gmail.com> wrote:
> On Fri, May 21, 2021 at 12:55 AM Yiyuan guo <yguoaz@gmail.com> wrote:
> >
> > Thanks for your timely response.
> >
> > I am not familiar with the theorem. But any input satisfying the
> > condition below will
> > trigger a divide by zero at the first loop iteration:
> >
> > (given_numerator / given_denominator > max_numerator) || (1 +
> > given_numerator / given_denominator > max_denominator)
>
> I think the error can only occur when the loop exits on the 1st
> iteration, when d1 is still zero.  In this case the prior convergent,
> n1/d1 = 1/0, does not really exist as this is the 1st iteration.  The
> actual series of convergents generated will never have zero terms,
> because we stop at zero, so there will never be zero from the prior
> iteration as we would have stopped there.

This is my conclusion as well, but you beat me to it.
And below is exactly my understanding of what's going on.

> I think the prior version of the code, which did not consider
> semi-convergents, would have determined the 1st convergent, 314/1,
> exceeded the bounds and would return the prior one, 1/0, without
> generating an exception but also not a correct answer, since 1/0 isn't
> really part of the series, it's just an initial value to make the math
> that generates the series work (d2 = a * d1 + d0).
>
> With semi-convergents, this can actually get the correct answer.  The
> best semi-convergent term is correctly found, (max_numerator - n0) /
> n1 = 255.  Using this would return 255/1, which is in this case the
> best answer.
>
> But the "is semi-convergent better than prior convergent" test does
> not consider what I think is a special case of there being no prior
> convergent.  In this case it should always select the semi-convergent.
>
> I think this handles it:
>
>                 if ((n2 > max_numerator) || (d2 > max_denominator)) {
>                        unsigned long t = (max_numerator - n0) / n1;
>                        if (!d1 || (t = min(t, max_denominator - d0) / d1)) ||
>                            2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
>                                n1 = n0 + t * n1;
>                                d1 = d0 + t * d1;
>                        }
>                        break;
>                }
>
> Above !d1 is the special case.  I don't like that, but I'm not seeing
> a way to think about the problect that doesn't involve one.

Let me think about it.

> > I think such a condition is rather complex and may not be enforced by
> > all callers of this function.
> >
> > On Fri, May 21, 2021 at 3:42 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Friday, May 21, 2021, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >> On Friday, May 21, 2021, Yiyuan guo <yguoaz@gmail.com> wrote:
> > >>>
> > >>> In the file lib/math/rational.c, the function
> > >>> rational_best_approximation has the following
> > >>> code:
> > >>>
> > >>> void rational_best_approximation(
> > >>>     unsigned long given_numerator, unsigned long given_denominator,
> > >>>     unsigned long max_numerator, unsigned long max_denominator,
> > >>>     unsigned long *best_numerator, unsigned long *best_denominator) {
> > >>>    ...
> > >>>    if ((n2 > max_numerator) || (d2 > max_denominator)) {
> > >>>             unsigned long t = min((max_numerator - n0) / n1,
> > >>>                           (max_denominator - d0) / d1);
> > >>>    ...
> > >>> }
> > >>>
> > >>> d1 may be equal to zero when performing the division, leading to a
> > >>> divide by zero problem.
> > >>>
> > >>> One input  to trigger the divide by zero bug is:
> > >>> rational_best_approximation(31415, 100, (1 << 8) - 1, (1 << 5) - 1, &n, &d)
> > >>
> > >> Have you read a theorem about this? TL;DR; as far as I can see the input data is not suitable for this function.
> > >
> > > I think we may add the proper check and saturate the output which in your case should be (255,1).



-- 
With Best Regards,
Andy Shevchenko
