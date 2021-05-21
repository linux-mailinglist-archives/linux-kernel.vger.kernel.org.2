Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4238C2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhEUJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhEUJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:22:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:20:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h16so22549405edr.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIcFS8N+HWbbjOzDHLDZa7jvtbkKy4iRjprQFgQsHfQ=;
        b=qkT7zs7wCtbe41iE0jgDpO0KbJ81Q3li0cGfVXfgZtEmtG644AvCJBKMgnI6qLd342
         vfuPyNcFasHZG7CY9EuVgmGxgby+QIglOGAZiSDxXhbev2YF2XBQc5zRkar1arKgTlvJ
         XZqdoHUGJImCNgLOlccxDO967RP4UTzWtByMYjWXYHtcatl1x3IFe2fWxF+35qhOQOzW
         y+Pp/em8NyoIjqNIdm4wWbVbRQPt5KXQuunlrKn/s/lhgIhlvBm9xdm26rCe0G1Kn15i
         biukeThTqNK7D7cGfNLn6GPw91WofP8wV1cjJyZ2N+a5Uy7Za3Cr0IQ2zI1gOQZcaYHw
         gTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIcFS8N+HWbbjOzDHLDZa7jvtbkKy4iRjprQFgQsHfQ=;
        b=bU+NckZL3FhymPB1lOB6dPh3KmDlOCd8PfN+V5yuD9PIP3uN19DwkzFAUD6+r6OGC6
         rn/GQBLbbUA6Hzb0kffiFboE2rFIe3U7qPAkWTLar4N8DFC/PsrV1knpP4XDYyS5BA2i
         lxduc+MovCK2yayN9zhHvX6e0MhkDXDe1DI33cKcwP3kaOk3HXm1HAFk9QRkJGnKqLdS
         mRqsn7aSR9G28BYIjkIiumeB80iPnhsKAFxoILZV1snJXfiP7PFXMFFxvyQzNeqvA0Qn
         lkoQt9v1smgz5BVXWpNEKHmozYt7w3/rvnpLJtSueFclTYNqzuLta0MzIn+NECQywxIj
         igGA==
X-Gm-Message-State: AOAM533jaJN6727+2xxkGLsXWtJmYHAb1NfiRw5dMhJDum0YLiEKdNL8
        0Td+Wg9KhI6jLK3doWoNkVVTS7Sx90HHR/J7w1c=
X-Google-Smtp-Source: ABdhPJw8zg9EDlc+VKcPNO+fsBccSGaQk+CaGqvvwdb8lKzBVF7IxTLg5RnSYKBL0rDc1tfgwdnlUGDsaGMDxrKwHWU=
X-Received: by 2002:a05:6402:16db:: with SMTP id r27mr9747777edx.375.1621588848485;
 Fri, 21 May 2021 02:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
 <CAHp75Vf8kQ73w0R9ieDNjDVkxM-V83QRN9mc6BjRZA8xHpPNAA@mail.gmail.com>
 <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com> <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com>
In-Reply-To: <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Fri, 21 May 2021 02:20:37 -0700
Message-ID: <CA+7tXigG7QVYOtkuFrqciHfuxE4+c0JM9z8r0e9rooTjjz5PYA@mail.gmail.com>
Subject: Re: A divide by zero bug in lib/math/rational.c (with triggering input)
To:     Yiyuan guo <yguoaz@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oskar@scara.com" <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:55 AM Yiyuan guo <yguoaz@gmail.com> wrote:
>
> Thanks for your timely response.
>
> I am not familiar with the theorem. But any input satisfying the
> condition below will
> trigger a divide by zero at the first loop iteration:
>
> (given_numerator / given_denominator > max_numerator) || (1 +
> given_numerator / given_denominator > max_denominator)

I think the error can only occur when the loop exits on the 1st
iteration, when d1 is still zero.  In this case the prior convergent,
n1/d1 = 1/0, does not really exist as this is the 1st iteration.  The
actual series of convergents generated will never have zero terms,
because we stop at zero, so there will never be zero from the prior
iteration as we would have stopped there.

I think the prior version of the code, which did not consider
semi-convergents, would have determined the 1st convergent, 314/1,
exceeded the bounds and would return the prior one, 1/0, without
generating an exception but also not a correct answer, since 1/0 isn't
really part of the series, it's just an initial value to make the math
that generates the series work (d2 = a * d1 + d0).

With semi-convergents, this can actually get the correct answer.  The
best semi-convergent term is correctly found, (max_numerator - n0) /
n1 = 255.  Using this would return 255/1, which is in this case the
best answer.

But the "is semi-convergent better than prior convergent" test does
not consider what I think is a special case of there being no prior
convergent.  In this case it should always select the semi-convergent.

I think this handles it:

                if ((n2 > max_numerator) || (d2 > max_denominator)) {
                       unsigned long t = (max_numerator - n0) / n1;
                       if (!d1 || (t = min(t, max_denominator - d0) / d1)) ||
                           2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
                               n1 = n0 + t * n1;
                               d1 = d0 + t * d1;
                       }
                       break;
               }

Above !d1 is the special case.  I don't like that, but I'm not seeing
a way to think about the problect that doesn't involve one.


> I think such a condition is rather complex and may not be enforced by
> all callers of this function.
>
> On Fri, May 21, 2021 at 3:42 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> >
> >
> > On Friday, May 21, 2021, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >>
> >>
> >>
> >> On Friday, May 21, 2021, Yiyuan guo <yguoaz@gmail.com> wrote:
> >>>
> >>> In the file lib/math/rational.c, the function
> >>> rational_best_approximation has the following
> >>> code:
> >>>
> >>> void rational_best_approximation(
> >>>     unsigned long given_numerator, unsigned long given_denominator,
> >>>     unsigned long max_numerator, unsigned long max_denominator,
> >>>     unsigned long *best_numerator, unsigned long *best_denominator) {
> >>>    ...
> >>>    if ((n2 > max_numerator) || (d2 > max_denominator)) {
> >>>             unsigned long t = min((max_numerator - n0) / n1,
> >>>                           (max_denominator - d0) / d1);
> >>>    ...
> >>> }
> >>>
> >>> d1 may be equal to zero when performing the division, leading to a
> >>> divide by zero problem.
> >>>
> >>> One input  to trigger the divide by zero bug is:
> >>> rational_best_approximation(31415, 100, (1 << 8) - 1, (1 << 5) - 1, &n, &d)
> >>
> >>
> >>
> >> Have you read a theorem about this? TL;DR; as far as I can see the input data is not suitable for this function.
> >>
> >
> >
> > I think we may add the proper check and saturate the output which in your case should be (255,1).
> >
> >>
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
> >>
> >>
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
