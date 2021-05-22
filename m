Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D7C38D731
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhEVTQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 15:16:12 -0400
Received: from skyrme.org ([37.221.197.251]:54398 "EHLO skyrme.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231465AbhEVTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 15:16:07 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2021 15:16:07 EDT
Received: (qmail 25056 invoked by uid 0); 22 May 2021 19:07:59 -0000
Received: from unknown (HELO basil.scara.com) (schirmer@unknown)
  by unknown with ESMTPA; 22 May 2021 19:07:59 -0000
Received: (qmail 28964 invoked by uid 500); 22 May 2021 19:07:59 -0000
Date:   Sat, 22 May 2021 19:07:59 +0000
From:   Oskar Schirmer <oskar@scara.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan guo <yguoaz@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: A divide by zero bug in lib/math/rational.c (with triggering
 input)
Message-ID: <20210522190759.GA9755@basil.scara.com>
References: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
 <CAHp75Vf8kQ73w0R9ieDNjDVkxM-V83QRN9mc6BjRZA8xHpPNAA@mail.gmail.com>
 <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com>
 <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com>
 <CA+7tXigG7QVYOtkuFrqciHfuxE4+c0JM9z8r0e9rooTjjz5PYA@mail.gmail.com>
 <CAHp75VdeSkQSHjwTFObj84TyOOW2dh9LW3Ci9L7=iDFTbEvRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdeSkQSHjwTFObj84TyOOW2dh9LW3Ci9L7=iDFTbEvRoA@mail.gmail.com>
Organisation: www.embedded-group.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:53:27 +0300, Andy Shevchenko wrote:
> +Cc: Daniel (here is a real case for test cases!)
> 
> On Fri, May 21, 2021 at 12:20 PM Trent Piepho <tpiepho@gmail.com> wrote:
> > On Fri, May 21, 2021 at 12:55 AM Yiyuan guo <yguoaz@gmail.com> wrote:
> > >
> > > Thanks for your timely response.
> > >
> > > I am not familiar with the theorem. But any input satisfying the
> > > condition below will
> > > trigger a divide by zero at the first loop iteration:
> > >
> > > (given_numerator / given_denominator > max_numerator) || (1 +
> > > given_numerator / given_denominator > max_denominator)
> >
> > I think the error can only occur when the loop exits on the 1st
> > iteration, when d1 is still zero.  In this case the prior convergent,
> > n1/d1 = 1/0, does not really exist as this is the 1st iteration.  The
> > actual series of convergents generated will never have zero terms,
> > because we stop at zero, so there will never be zero from the prior
> > iteration as we would have stopped there.
> 
> This is my conclusion as well, but you beat me to it.
> And below is exactly my understanding of what's going on.
> 
> > I think the prior version of the code, which did not consider
> > semi-convergents, would have determined the 1st convergent, 314/1,
> > exceeded the bounds and would return the prior one, 1/0, without
> > generating an exception but also not a correct answer, since 1/0 isn't
> > really part of the series, it's just an initial value to make the math
> > that generates the series work (d2 = a * d1 + d0).
> >
> > With semi-convergents, this can actually get the correct answer.  The
> > best semi-convergent term is correctly found, (max_numerator - n0) /
> > n1 = 255.  Using this would return 255/1, which is in this case the
> > best answer.
> >
> > But the "is semi-convergent better than prior convergent" test does
> > not consider what I think is a special case of there being no prior
> > convergent.  In this case it should always select the semi-convergent.
> >
> > I think this handles it:
> >
> >                 if ((n2 > max_numerator) || (d2 > max_denominator)) {
> >                        unsigned long t = (max_numerator - n0) / n1;
> >                        if (!d1 || (t = min(t, max_denominator - d0) / d1)) ||
> >                            2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> >                                n1 = n0 + t * n1;
> >                                d1 = d0 + t * d1;
> >                        }
> >                        break;
> >                }

Sorry, it does not. E.g. with the given fraction of 31/1000
and the registers restricted to 8 and 5 bits respectively, the
proposed fixed function would still divide by zero, because
n1 == 0. If it was for the division by d1, the test for !d1
will cut the expression for the conditional short, as intended,
but as the branch then uses t, the evaluation for t = ... / d1
will still be performed.

Moreover, for a fraction of 33/1000, both the original and
the latest version would produce 1/30, which is off by some
1.01%, but the proposed fixed version would result in 1/31,
which is worse: 2.24% off.

We are not talking about a science math library, but only
about a helper function for kernel use, and as results with
somewhat less than perfect approximation only occur in cases,
where hardware limitations do not allow the precise result,
I think the original function was not so bad. And the code it
produced was much shorter than the latest version, although
this might not be an argument in times, where a simple OS
kernel is beyond the 40MB.

Admitted, the original version had the flaw of offering bogus
fractions for input beyond the saturation limits, and this
case sure should be handled. And the function is called "best",
so Trents approach to look for better results is sure valid.

Nonetheless, I'ld favour going back to the original Euclidian,
and maybe add a test for the saturation cases to avoid the
caller running into trouble, even though given the use case
the caller will probably run into trouble with this fixed,
when the registers simply cannot hold a good approximation.
So maybe the function should return a boolean to indicate.

best regards,
  Oskar



> > Above !d1 is the special case.  I don't like that, but I'm not seeing
> > a way to think about the problect that doesn't involve one.
> 
> Let me think about it.
> 
> > > I think such a condition is rather complex and may not be enforced by
> > > all callers of this function.
> > >
> > > On Fri, May 21, 2021 at 3:42 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Friday, May 21, 2021, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > >> On Friday, May 21, 2021, Yiyuan guo <yguoaz@gmail.com> wrote:
> > > >>>
> > > >>> In the file lib/math/rational.c, the function
> > > >>> rational_best_approximation has the following
> > > >>> code:
> > > >>>
> > > >>> void rational_best_approximation(
> > > >>>     unsigned long given_numerator, unsigned long given_denominator,
> > > >>>     unsigned long max_numerator, unsigned long max_denominator,
> > > >>>     unsigned long *best_numerator, unsigned long *best_denominator) {
> > > >>>    ...
> > > >>>    if ((n2 > max_numerator) || (d2 > max_denominator)) {
> > > >>>             unsigned long t = min((max_numerator - n0) / n1,
> > > >>>                           (max_denominator - d0) / d1);
> > > >>>    ...
> > > >>> }
> > > >>>
> > > >>> d1 may be equal to zero when performing the division, leading to a
> > > >>> divide by zero problem.
> > > >>>
> > > >>> One input  to trigger the divide by zero bug is:
> > > >>> rational_best_approximation(31415, 100, (1 << 8) - 1, (1 << 5) - 1, &n, &d)
> > > >>
> > > >> Have you read a theorem about this? TL;DR; as far as I can see the input data is not suitable for this function.
> > > >
> > > > I think we may add the proper check and saturate the output which in your case should be (255,1).
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
