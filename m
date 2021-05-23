Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C486238D7DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 02:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhEWAGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 20:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhEWAGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 20:06:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D723C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:05:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f18so5878036ejq.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivy3nqszZrnAQTpRgs8RLYL4mi7jLAex7afb3rEY1SQ=;
        b=hl8pIV4DGQ7pBk1r9cmtUYmm1pYEbtLnN5Ac5BXtihF0NTCMncOmcVvX8IcnVnAMb8
         cPsDij7iGH0XsJlAqf+O19iN2NX7yle88E3UHZ70FdyrvDUcVDB2mXdT0KuPcu2CfOmu
         Y0VbWcSLqaNks7wtKQHIYVFw+exvz2pf7gCSvwlMCnpS5GU5fFi8eNLm2EJeso+Qk2Cm
         q/L7VPpJfTAB1U5CDvtl7h15eVRm7jx4CeKN5A1KCCP7crrzbOLiP7TTeGFhFsyxrt/q
         zBx4e7CfdfBcfWIE0ANmq1y8us3hvLeU8ljIjypvQZk54/cy9WvFBP1Td+iVUrzxLC3e
         XuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivy3nqszZrnAQTpRgs8RLYL4mi7jLAex7afb3rEY1SQ=;
        b=QF/l4JhG6mrjpoERxzjMzjpUH1hKdYp4t9KEweg2ChnnqESvnmMZ/V+59MWJYcDWeC
         +fcEe2+O/hL24FVwCOJK/QhNgefAE3FgkRrQ2qafn4CIL594KaxbTVsb9Lb3PlMMmGGN
         QD9l7/gs61ad3maO/hmVdIHcx/ICESKu/9Of3ju+wbC8vhT2v2NFAk1VvKdCfDC7jnbq
         3iFLnrjyBPS2IT+rNCESR57WYydz0uJ+KiJ02cgJJagWLy9z5B6wouVKODA6Wo6cxXuC
         5mpfbeJUJpXbWq5owHIkAb3WL0rCrupk7Ka4cD0CVBWQbe2UiyWwNtxO0C6xZ9XUyxU4
         FPuA==
X-Gm-Message-State: AOAM5323NSQAatOjQHddoCRqK3H5IbrjDA4iBbhhfi0xQeSV4M7qoFxJ
        0uWLlA/LUB7ZX1utbkTtDjQp6Yyvczlg5AGrcP0=
X-Google-Smtp-Source: ABdhPJypXJUqkb9XMD3a0SvT52jIELP9jCPcQ4BAURc32XX0X1Pzk8mJQfNEAJ4outmI9yR8+mwfIS/QY1Wbba9mZDw=
X-Received: by 2002:a17:906:5052:: with SMTP id e18mr16755490ejk.112.1621728318923;
 Sat, 22 May 2021 17:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
 <CAHp75Vf8kQ73w0R9ieDNjDVkxM-V83QRN9mc6BjRZA8xHpPNAA@mail.gmail.com>
 <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com>
 <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com>
 <CA+7tXigG7QVYOtkuFrqciHfuxE4+c0JM9z8r0e9rooTjjz5PYA@mail.gmail.com> <CAHp75VdeSkQSHjwTFObj84TyOOW2dh9LW3Ci9L7=iDFTbEvRoA@mail.gmail.com>
In-Reply-To: <CAHp75VdeSkQSHjwTFObj84TyOOW2dh9LW3Ci9L7=iDFTbEvRoA@mail.gmail.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Sat, 22 May 2021 17:05:08 -0700
Message-ID: <CA+7tXijWgDGzWPOYhzX+bWn0cjOZ9y1-gWRG+0uobQ128=8vCg@mail.gmail.com>
Subject: Re: A divide by zero bug in lib/math/rational.c (with triggering input)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Yiyuan guo <yguoaz@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oskar@scara.com" <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 2:53 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
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

I came up with some more test cases, and there is another possibility,
if the value is small. e.g.

rational_best_approximation(1,30, 1,10, ...)
rational_best_approximation(1,19, 1,10, ...)

The former should be 0/1 and the latter 1/10.  These will divide by
zero on the 2nd iteration.

But I have a patch now that works.  It gets the closest answer in all
cases, larger than max, less than min but closer to the min than to
zero, and closest to zero.

It ends up being zero additional arithmetic to do this.   All that is
needed is a few additional branches in the termination condition.
