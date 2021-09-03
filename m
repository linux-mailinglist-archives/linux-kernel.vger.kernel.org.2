Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF23FFBDE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbhICIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348342AbhICIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:24:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C596C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:23:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y34so10225910lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hAqGYrLjRZ3iykSbGor+qLd4AGyjB0PsrRt/XCzshnA=;
        b=RZaRoRA3ZPlAb4WoHFUgzFl0jZaakLFCJbgMO1iW0KpQC7RBvcOtkhtq82E7RP7t++
         P8kOVNYw/SmbJv8dFhkQZfu02OD1YkBj/vKCPW0cgi1M+JfRg/B4P+Il1TPVFSLPltWY
         AhQLLV/HxRbnFtvLL4VF6cXFgAmcnIHUxCPZWozvoq5oPPKteQYr0RsoCOtygrFQS4qo
         NcRqmYtR8q71ysadIIQgHiDPwPFwVd56tDpFAxjStSMw6PKD3yagR6+16X2kQ0F2r5nK
         TDtGbzr3AnVHYlmL0OqxDDsphsznRC5HIdA8GKnpHOV/mVSgWewAd4ZF22rHzBbqicMq
         mf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hAqGYrLjRZ3iykSbGor+qLd4AGyjB0PsrRt/XCzshnA=;
        b=AB2IEvaYDk7Fu3Pa8OqRb4+uhjafYmWSkXtq66hwC892qkaGOQfJ21KOIZdSlLdhJp
         Fq3zjqydWKThUM3T57UsFDfpjZcSspo3cuvYSO6BUCVzEbRWZy4IHpaWaiQZJ5YNuaag
         sMG8Aw4S0ec48W69cvnjNtAT8FyPoQRWSJR4tITCuEo81kShTU5EKCnQCEFI/C3ZA46c
         6t+Qc/WQ6+PPQbXUmiH9Sg1bayKH7L5p7HYlnDAM525yVgB3p4ViFYuOBLzxO2Z0IEo2
         YHERwScZdxykkhUUJbLYJDdNqKpE+PLPBjWkuq1VEbKEG/0Ta8tP/KV+rTGQDpzaSNJv
         LH/Q==
X-Gm-Message-State: AOAM533NblUT8YpHTExeBjgv0mFGq/ywojRMoRKESErRfTmW+uY0ILK6
        x1/3Lce7T/7VZ82GweC3DOehl1BDX5fHJ3CQx+bD1Q==
X-Google-Smtp-Source: ABdhPJyRFy8znwwAG/S5c2HOe673r98QPD3crhekcHkJPEwDJj5xfL1g6mIr/hFt9tGetbXQOgRxN2Dzaw+vDXHHoIY=
X-Received: by 2002:a19:655e:: with SMTP id c30mr1874417lfj.142.1630657415405;
 Fri, 03 Sep 2021 01:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org> <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
In-Reply-To: <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Sep 2021 10:22:59 +0200
Message-ID: <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
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

On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 02.09.2021 13:16, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > When a device is detached from its genpd, genpd loses track of the devi=
ce,
> > including its performance state vote that may have been requested for i=
t.
> >
> > Rather than relying on the consumer driver to drop the performance stat=
e
> > vote for its device, let's do it internally in genpd when the device is
> > getting detached. In this way, we makes sure that the aggregation of th=
e
> > votes in genpd becomes correct.
>
> This is a dangerous behaviour in a case where performance state
> represents voltage. If hardware is kept active on detachment, say it's
> always-on, then it may be a disaster to drop the voltage for the active
> hardware.
>
> It's safe to drop performance state only if you assume that there is a
> firmware behind kernel which has its own layer of performance management
> and it will prevent the disaster by saying 'nope, I'm not doing this'.
>
> The performance state should be persistent for a device and it should be
> controlled in a conjunction with runtime PM. If platform wants to drop
> performance state to zero on detachment, then this behaviour should be
> specific to that platform.

I understand your concern, but at this point, genpd can't help to fix this.

Genpd has no information about the device, unless it's attached to it.
For now and for these always on HWs, we simply need to make sure the
device stays attached, in one way or the other.

Kind regards
Uffe
