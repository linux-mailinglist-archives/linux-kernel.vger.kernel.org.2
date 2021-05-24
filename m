Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D031F38F474
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhEXUhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhEXUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:36:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:35:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k132so15576601iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ww8N1sbYoNLLPF0Q7K3MF9R24b40kcWA6bCKx339gE=;
        b=h8zRmpBOVJZ4vh4QrEiZn+HMtrg4YiZv2jtRNHQtnGrdoSZmPGFJ9KOZsPcLvb+T93
         RlYuyNpewrE78vORKbWncqeq+ELUGVvkSa21nBNRsVDNQ1XvTp0a9b+ti2F7lzs/WKN5
         QCwLkUmQxn+XL47NmbzzNCzg28rCVsYOjQcAzf/NjEXdXSZXT3sCjLps4WRhic77d7DI
         63bg/he0oOhkM2TSUvR/PW2B54PXHJPUjY19AHypEcYEMglzmo7qmMgM4wu5yujHX0bv
         xTA/sWHppulhHg+pg72/BJ7lNYYGgqb9e/+Z0otK6DAgyKkGHUGsKPw5iIsSyki1iJM+
         qJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ww8N1sbYoNLLPF0Q7K3MF9R24b40kcWA6bCKx339gE=;
        b=bj4edUFwrBWdNHS8+2Fs2OGo7eX9ipdITBMxkvYXdLgU9Jj+gNfKI1sOoTmC6TLh5t
         l6mufkmJWAug6wJ4n891ENbz8s+s3ozqzEE1zyVbss9OYVnVonAOkHLfNaNy2JJcWlKG
         v3aN6idSUy8ihkAikU2dNkd1EL/+esdSF0f3lPHeailSGImJuQLCOAkG2k4hEVJkO+hw
         Z7buiPEMoc09dMzkuAs1RE9bHeoEXpOMnBvlgqQki8Lnu+C5hrbO2RI0PAFzWK0hYnHu
         wZahU935NWu2Ebw6t7BZichubuljHkv2820WN5phfG6f226LwvUcDRBWSvK2R6huwf/r
         lt5w==
X-Gm-Message-State: AOAM5301G7zcyWvevTbJX2PRIktGhBuNV8tT2l8MHePRaYkJc7PRgetR
        34AgBqZ7NWTYqKVgRDPf58XIXOdAZgTFO8vUCBDKXQ==
X-Google-Smtp-Source: ABdhPJzBRFXwFbatY6sSH2k09Ww4UANrtMtN1SbMbSJL0pV85nO7Rn77PU7ER3OURymSmD3q4O0L1ckxOHSYoVcEuEo=
X-Received: by 2002:a02:aa85:: with SMTP id u5mr27745346jai.75.1621888527554;
 Mon, 24 May 2021 13:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com>
In-Reply-To: <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 24 May 2021 13:35:16 -0700
Message-ID: <CAGS_qxpR3TPRV8YYqr0szk6LAuSrS+xQ45pH-iuBb6zdJy09vw@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 1:18 PM Trent Piepho <tpiepho@gmail.com> wrote:
>
> On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
> >
> > This misses the test cases (*). Please, develop them with Daniel.
> >
> > *) We usually don't accept changes in the generic libraries without test cases.
> >
> > Fixes tag?
>
> Is there a bug report on a tracker?  I just got the email from Yigua.

You'd want to add:
Fixes: 323dd2c3ed06 ("lib/math/rational.c: fix possible incorrect
result from rational fractions helper")


Steps taken:

$ git log --oneline lib/math/rational.c
b296a6d53339 kernel.h: split out min()/max() et al. helpers  <- irrelevant
d89775fc929c lib/: replace HTTP links with HTTPS ones  <- just comments changes
323dd2c3ed06 lib/math/rational.c: fix possible incorrect result from
rational fractions helper
2c64e9cb0b6b lib: Move mathematic helpers to separate folder

At 2c64e9cb0b6b lib: Move mathematic helpers to separate folder
[13:31:06] [FAILED] rational_bug_test
[13:31:06]     # rational_bug_test: EXPECTATION FAILED at
lib/math/rational_kunit.c:12
[13:31:06]     Expected n == 255, but
[13:31:06]         n == 1
[13:31:06]     # rational_bug_test: EXPECTATION FAILED at
lib/math/rational_kunit.c:13
[13:31:06]     Expected d == 1, but
[13:31:06]         d == 0
[13:31:06]     not ok 1 - rational_bug_test

At 323dd2c3ed06  lib/math/rational.c: fix possible incorrect result
from rational fractions helper
[13:32:50] ======== [CRASHED] rational ========
[13:32:50] [CRASHED]
[13:32:50] Kernel panic - not syncing: Kernel mode signal 8
[13:32:50] CPU: 0 PID: 15 Comm: kunit_try_catch Not tainted
5.13.0-rc1-15148-ge3e4bc7272a1-dirty #34
[13:32:50] Received SIGSEGV in SIGSEGV handler, aborting stack trace!
[13:32:50]
[13:32:50] ============================================================

So this crash was introduced by 323dd2c3ed06.
Anyone who has 323dd2c3ed06 will want to cherrypick this fix.

>
> > > +                     /* This tests if the semi-convergent is closer than the previous
> > > +                      * convergent.  If d1 is zero there is no previous convergent as this
> > > +                      * is the 1st iteration, so always choose the semi-convergent.
> > >                        */
> > > -                     if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> > > +                     if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> > >                               n1 = n0 + t * n1;
> > >                               d1 = d0 + t * d1;
> > >                       }
> >
> > I think that refactoring may lead us to check first iteration before even going
> > into the loop. But it's another story and we may do it later (the algo uses
>
> I started that, but it had no advantages and some disadvantages.
>
> Basically, there are three cases: too large, too small & closest to
> zero, too small & closest to non-zero.  This code can handle those
> three cases by adding three branches, if(d1), if(n1), and if(!d1).
> The truth values we need already exist at this point the algorithm.
>
> If it's at the start, then there still needs to be the three branches
> for each case.  But the values to test must be calculated too.
>
> What's more, it's possible that the value is exactly representable in
> the allowed range.  That's actual appears to be the most common use
> case, reducing a fraction to lowest terms (*).  By putting the tests
> in the "terminate because of limits" case, they don't need to happen
> when "terminate because exact value find" is the result. If the check
> was first, then it would always happen, even if it wouldn't have been
> necessary.
>
> And the time it took to find this bug shows us that out of bounds
> inputs are not a common case, so putting that on the hot path by
> checking it first at the expense of the reducing to lowest terms path
> doesn't make sense.
>
> (*)  One could write a reduce to lowest terms function with an easier
> interface.  It could be a trivial one expression wrapper around
> rational_best_approximation().  It could also be a simpler function,
> but I think it would still perform the exact same sequence of
> divisions and moduli, so it wouldn't really make any difference.
