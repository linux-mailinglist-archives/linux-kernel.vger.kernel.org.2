Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75EC390723
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhEYRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhEYRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:11:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E65C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:10:27 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d25so20588853ioe.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGhKWueGkFJNScUYpjr13ZZiSFueS7vnLwxNVEzc8Ko=;
        b=hkctTkTSIaIn3pj5Qv1EvhhT1cPhiWJ/4s/DAb/h7t1MNt34Br9HFkPXbI/iPNOj0j
         29LBBMzPkXlYZpEVnbW+m+zEDvOYM2WALs/AruQs43ZKH4qN+3mxwlKBj94+SNbHMvL+
         9iyHzhDrhWrXIFeIvo6dCGgnH8viB+qTBNcVv9kMD1OUm7vpXe7xp3yiXbI9Ey+R5UUg
         yHfJnsthT31Fj3/NxmzCOcYuDTEYb71X0Kmlt1MAXRwNeULPsHzsy9JEHtfI+5q7dLk3
         qBzMOSVVr1Lm9paQD/ZPNvhxYqHF+ZjqX7L0uqgimE8r5emiw6wlahVC2ypU9sgf2FJZ
         Rh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGhKWueGkFJNScUYpjr13ZZiSFueS7vnLwxNVEzc8Ko=;
        b=dfJFCwg9vd87hFt29MgiKszalC8YVict/Ro3HSp14XrhlYihUN2LGyxLRhl5RIbMoB
         xCuF+phF1ZGBXDTK2gzEYYDsHGqy+N/lvQ+M6EGeZFkvjp8dwuWVRNl0BHEUMmHQggBC
         VPrAfEuFjRSdFCRkKDcMImHi8TAoUnhwHWTqT+HWx+nBXO6aT8BSZWLHZnW73fSXDOmD
         1ZufupF7ODrE3pnyY6gOd7HEwEyam+G1uo6NM1EM9aUeazmQVrWFCM+NNA6jzZjEk3u+
         Sl1spyJqGMKXRPK8o6GL1w93mdtuCllt88EVMy/n2zMjAHuKYktA5F9E+WfJgVpIvTE8
         khMA==
X-Gm-Message-State: AOAM533YzqgT1ArY817gRVAXXpUzioUKMAtkqrto/u+x5EUp0QZeAYBF
        z3FHNIGU8pqB2Xw6+bLrv/HVe3s6AnEcyISmLXf5DA==
X-Google-Smtp-Source: ABdhPJzeIpevk5xDCGlpe9Kc3jgJo3ztAndGvM+LiMnVZofBGoUW7Dsu1oFs1CwiblmZsfKzt3wAu3ooZ1TFmIdOfPc=
X-Received: by 2002:a02:aa85:: with SMTP id u5mr33795253jai.75.1621962626279;
 Tue, 25 May 2021 10:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CA+7tXiiogw+bWCj2=QiRBc+sp01dUh1j_mfLJC19CB6Wch0nuQ@mail.gmail.com> <YKy9PHIbuhsomsTq@smile.fi.intel.com>
In-Reply-To: <YKy9PHIbuhsomsTq@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 25 May 2021 10:10:15 -0700
Message-ID: <CAGS_qxqfu1Sdu6m0Sf8uVpbbpUkB5_xO3E6xbeyg-7Z67a+mQg@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 2:02 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 24, 2021 at 01:17:48PM -0700, Trent Piepho wrote:
> > On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
> > >
> > > This misses the test cases (*). Please, develop them with Daniel.
> > >
> > > *) We usually don't accept changes in the generic libraries without test cases.
> > >
> > > Fixes tag?
> >
> > Is there a bug report on a tracker?  I just got the email from Yigua.
>
> Fixes tag refers to the existing commit that brought the bug.
> Also you may need to add Reported-by tag since Yigua reported it.
>
> ...
>
> > > I think that refactoring may lead us to check first iteration before even going
> > > into the loop. But it's another story and we may do it later (the algo uses
> >
> > I started that, but it had no advantages and some disadvantages.
> >
> > Basically, there are three cases: too large, too small & closest to
> > zero, too small & closest to non-zero.  This code can handle those
> > three cases by adding three branches, if(d1), if(n1), and if(!d1).
> > The truth values we need already exist at this point the algorithm.
> >
> > If it's at the start, then there still needs to be the three branches
> > for each case.  But the values to test must be calculated too.
> >
> > What's more, it's possible that the value is exactly representable in
> > the allowed range.  That's actual appears to be the most common use
> > case, reducing a fraction to lowest terms (*).  By putting the tests
> > in the "terminate because of limits" case, they don't need to happen
> > when "terminate because exact value find" is the result. If the check
> > was first, then it would always happen, even if it wouldn't have been
> > necessary.
> >
> > And the time it took to find this bug shows us that out of bounds
> > inputs are not a common case, so putting that on the hot path by
> > checking it first at the expense of the reducing to lowest terms path
> > doesn't make sense.
>
> Thanks for detailed explanation of your view to the current state of the code.
> As you noticed I am not insisting on refactoring or so, I was rather wondering
> if it can be done in the future. Still we might need some performance tests.
>
> Daniel, does KUnit have a capability to test performance?
> Like running test case 1M times or so and calc average (median?) time of
> execution.

No, it does not.
It also currently lacks an option/flag for running a test multiple times.
So one would have to manually modify the test code itself to handle
that right now.

(One non-option is to call `kunit.py execute` in a loop, which will
avoid build + config overhead, but it still adds more than we'd find
acceptable here).

I don't think this was considered before bc it's unclear what the
performance characteristics of UML would be like compared to a more
"normal" arch. Brendan's current patchset to add QEMU support into
kunit.py makes this a bit better, but still running on a physical
machine is still probably safest.

>
> > (*)  One could write a reduce to lowest terms function with an easier
> > interface.  It could be a trivial one expression wrapper around
> > rational_best_approximation().  It could also be a simpler function,
> > but I think it would still perform the exact same sequence of
> > divisions and moduli, so it wouldn't really make any difference.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
