Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD724000F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbhICOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243643AbhICOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:05:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7298C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:04:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m28so11991865lfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sSgMe6jO7xnpGx2tRPpBBTj9lsn9JwdSXq1ZWNG03/M=;
        b=rvDoigY4cruxeRTZs+bhQzHXKT3VjFr4e/H7h+cD0NLeK/FeRpzslf5ZAmDeXOg7Mq
         AshatvKefj52y10+jKbCXd/91DGeT8RiJPL1xj5Wtfpk33fHYOLkDwgu9pRI6lug61AV
         fZ/L8xdAMXW3+klI27chBrjkdd1/vFbtbfmrqzINMqIDhe9wqUWC0Li5rAb8Rjbc2u7f
         a9Wnvaw89HHUL9bniTze4k82ZG+qOLrk+KmNTLc7UZ55I5M2l9vZRsIL2VCtmf/hJiU+
         FS8D0SDahwDWYwTKd0Co345S5WPe2mE6y8xwI7xKAGDjruPgiWsYxNwfggUSDJc7EeUd
         jd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sSgMe6jO7xnpGx2tRPpBBTj9lsn9JwdSXq1ZWNG03/M=;
        b=Ac6nmaabC2sWPqTZkW2COpGnW452BM7qxvGxHPRXLYh19lPf0Sm+bPFkywf5dyZw4R
         v7GeYBPUUPoheLolkIvVvo0E+SQlLHQbtgP3WfOIfJrUeatVmfQsy4099v/xvC9Zn7iw
         kqYLPwmLrIG/LS16GmBMj0Pk7UjEV2c+Gce82dKMDYwlFAQyDwqEGivKyCLkTz2uRpS3
         qKqtdfnGkSha5Z22kiUr0hsDceQPwN84U6ujeDzdb7vJ/zvXmpt+e6PtX3V6EosezBFz
         3nZHtfeU7lr+zDpYzOGvKWxBJqixKu67G9Dfd5MjzTmlfhg6QfmaYYAmGfJBvlWOh4JR
         uxrg==
X-Gm-Message-State: AOAM530CqzfXl6wut1hkBeWuzwoWZQtkptiIChPHFAL7sTMCB2CKaPfZ
        boELiOkifLl4VnkkkxSlpLhjif8AD1j6xedbMv1UZw==
X-Google-Smtp-Source: ABdhPJwLX1bWYt8jcuZqjDpgjcYrm0IuHl4c8OMxpt1GGMcSijXKANRPJNpt4cJRX1gNjfc9oLeX0gjQzvqQxLFdz80=
X-Received: by 2002:a19:ac42:: with SMTP id r2mr2840448lfc.167.1630677873121;
 Fri, 03 Sep 2021 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org> <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com> <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
In-Reply-To: <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Sep 2021 16:03:56 +0200
Message-ID: <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.09.2021 11:22, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> When a device is detached from its genpd, genpd loses track of the de=
vice,
> >>> including its performance state vote that may have been requested for=
 it.
> >>>
> >>> Rather than relying on the consumer driver to drop the performance st=
ate
> >>> vote for its device, let's do it internally in genpd when the device =
is
> >>> getting detached. In this way, we makes sure that the aggregation of =
the
> >>> votes in genpd becomes correct.
> >>
> >> This is a dangerous behaviour in a case where performance state
> >> represents voltage. If hardware is kept active on detachment, say it's
> >> always-on, then it may be a disaster to drop the voltage for the activ=
e
> >> hardware.
> >>
> >> It's safe to drop performance state only if you assume that there is a
> >> firmware behind kernel which has its own layer of performance manageme=
nt
> >> and it will prevent the disaster by saying 'nope, I'm not doing this'.
> >>
> >> The performance state should be persistent for a device and it should =
be
> >> controlled in a conjunction with runtime PM. If platform wants to drop
> >> performance state to zero on detachment, then this behaviour should be
> >> specific to that platform.
> >
> > I understand your concern, but at this point, genpd can't help to fix t=
his.
> >
> > Genpd has no information about the device, unless it's attached to it.
> > For now and for these always on HWs, we simply need to make sure the
> > device stays attached, in one way or the other.
>
> This indeed requires to redesign GENPD to make it more coupled with a
> device, but this is not a real problem for any of the current API users
> AFAIK. Ideally the state should be persistent to make API more universal.

Right. In fact this has been discussed in the past. In principle, the
idea was to attach to genpd at device registration, rather than at
driver probe.

Although, this is not very easy to implement - and it seems like the
churns to do, have not been really worth it. At least so far.

>
> Since for today we assume that device should be suspended at the time of
> the detachment (if the default OPP state isn't used), it may be better
> to add a noisy warning message if pstate!=3D0, keeping the state untouche=
d
> if it's not zero.

That would just be very silly in my opinion.

When the device is detached (suspended or not), it may cause it's PM
domain to be powered off - and there is really nothing we can do about
that from the genpd point of view.

As stated, the only current short term solution is to avoid detaching
the device. Anything else, would just be papering of the issue.

Kind regards
Uffe
