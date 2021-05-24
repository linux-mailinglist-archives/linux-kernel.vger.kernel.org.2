Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69A38F423
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhEXUTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhEXUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:19:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6639C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb17so25670913ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmP6wjbqPsmvs47UKJRkIpz4LlPuHsGaeQ7MCKGfEHg=;
        b=WPyv7ncbwjJgU+ICGa9mWJAAsHbJZAPg30ohv+b7MVnFf2F0zSDHVWhrwp2p9qrPux
         ZRq/59gh24wQnwgQ218BIt96wnUOWflzspa9dc5+lLWzMQwIovaYW3s9X/ht/oh5skws
         JrSTp/rIaDuGzrFUtjBrGDkCCt2DnWeRmjsnPqBDE2Hin541C7JxbUu7hY32zTgNoFAk
         n9fQText286X2W/IjvTqzRbO/o80jvj9uyG5I4jVQClZ7a8h/S+i7+rFnNh90mHZdBjK
         7Hsu7Mv147hmyWt5A5XMYICDHn+OirUIhcl3EDt+bdn+cOkrhX3/H8jxpcLPdFhjJyp5
         Ilww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmP6wjbqPsmvs47UKJRkIpz4LlPuHsGaeQ7MCKGfEHg=;
        b=WtA+JEsBE4m1/q3IF1GdAb2ImnQvW3BoZHFYRYmpM7ffwqaTLAN9ZtOY+1Tc1RP2Qm
         U7vd7hsB4Dg5Yys8mzktujMV9cNCWIGVdQb6nxiXbsst4eFz6ISBWFoUbKFU+YzftMZx
         m8TdzH2K0ZsVrWj470EECYntGVm7FdRtaSGBCXGHG3uofG53F8tIUtZFrbq+hytd5tkX
         TpPwSPMIama1hndyOm/kf1BHaz+Zlm4LwEzRnnwvR0VZ/HBwBkqpzosLDDhf20HZtlSY
         Q1A+cTy/34DqbSicD1GVbrCMh42+rtpB0cp7wEXN0ffKV/3nS0qeLvTPevkdIO9k5Cdz
         OxMA==
X-Gm-Message-State: AOAM532290CirL42qdjnxH12znzlMoWbHxhoL+v9RPS1NNxmxEOQrkns
        E+BXU+I5oec6p+SdMQ65kHiOv0WHPNGFO6uumhc=
X-Google-Smtp-Source: ABdhPJznzCfamnsKigKLIOgNqUAWP0KSM393Ix9BkfTVN03v8A4ktO8wn+S6PYCZz6EGo03ET3kWpvXPm6Ks2NhZg2Y=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr24776841ejh.341.1621887479290;
 Mon, 24 May 2021 13:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
In-Reply-To: <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Mon, 24 May 2021 13:17:48 -0700
Message-ID: <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Daniel Latypov <dlatypov@google.com>, linux-kernel@vger.kernel.org,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
>
> This misses the test cases (*). Please, develop them with Daniel.
>
> *) We usually don't accept changes in the generic libraries without test cases.
>
> Fixes tag?

Is there a bug report on a tracker?  I just got the email from Yigua.

> > +                     /* This tests if the semi-convergent is closer than the previous
> > +                      * convergent.  If d1 is zero there is no previous convergent as this
> > +                      * is the 1st iteration, so always choose the semi-convergent.
> >                        */
> > -                     if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> > +                     if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> >                               n1 = n0 + t * n1;
> >                               d1 = d0 + t * d1;
> >                       }
>
> I think that refactoring may lead us to check first iteration before even going
> into the loop. But it's another story and we may do it later (the algo uses

I started that, but it had no advantages and some disadvantages.

Basically, there are three cases: too large, too small & closest to
zero, too small & closest to non-zero.  This code can handle those
three cases by adding three branches, if(d1), if(n1), and if(!d1).
The truth values we need already exist at this point the algorithm.

If it's at the start, then there still needs to be the three branches
for each case.  But the values to test must be calculated too.

What's more, it's possible that the value is exactly representable in
the allowed range.  That's actual appears to be the most common use
case, reducing a fraction to lowest terms (*).  By putting the tests
in the "terminate because of limits" case, they don't need to happen
when "terminate because exact value find" is the result. If the check
was first, then it would always happen, even if it wouldn't have been
necessary.

And the time it took to find this bug shows us that out of bounds
inputs are not a common case, so putting that on the hot path by
checking it first at the expense of the reducing to lowest terms path
doesn't make sense.

(*)  One could write a reduce to lowest terms function with an easier
interface.  It could be a trivial one expression wrapper around
rational_best_approximation().  It could also be a simpler function,
but I think it would still perform the exact same sequence of
divisions and moduli, so it wouldn't really make any difference.
