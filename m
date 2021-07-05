Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E421B3BB69F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGEFJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:09:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BDC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:06:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l2so2687237edt.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwU7NZpILHwuxQvC6Lvk3Ma8hMrwAx5T42zVR2BrMUY=;
        b=O1ZR29mGahR/sf/UFQ1YZTuwuV7i5RhWT6ICqVBRF/cdBIcZZDI9F5LwYQHpVUdC5+
         z2d/ctbQMR/5OQX/98SnR10Vugg6mILhf4qtfG9eI1VL5wlGfr2yqgofPz/slACFT8M0
         B1v22KLCPYWnnsr1JIKn5KTdtqJCfafNAVdWECEsvFH8x2TEig7/nMdROkJR6LrqD3Ij
         Upy7/lmNp7emLzmo5Fi2XyBS7dRf2WLlIj4H0egXE7jdtHW2CNVJCFtfOnazEg6Bfc/E
         Y8EmiNAwxUumPbdTaCMqTe4s938ORY62ltNTT/4WTlG+d/jvjDZ50fwS72deX2xf8CKD
         xm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwU7NZpILHwuxQvC6Lvk3Ma8hMrwAx5T42zVR2BrMUY=;
        b=EeokxNnfY5ZyVTuTTmwcQ3P2XEZ2It4Oki5kZe7IQrIUuOLgLK52U8aZEh3GEDBAwn
         o7Im3clnxMXs45vRMLM8hzrPzUsXGtV8+TpAu47lGnhuZ72QoNu9pLE1SyPjhokWW7Wx
         RWVJ8Nf5hJlPti+s8GrqetrMYKBDpGJHGZNS0skyLhfYTfoEWCy9U8vD55r1aoAZVeaz
         70PnJI0qp3jy5bu1ewwYKCbJfjbSrFD33v3CczlUwDHfMlPfzcc0H81SCMpYUbCy7T/S
         VexM6+vIdV1RqTtdCUzj2ZyG684NTobfVYZ1ijdw7VNq0VOKCJREMhmvI0exkBOuNl9x
         qVgg==
X-Gm-Message-State: AOAM532PL/VYLNucBaISkJVkl/l/38fjc8Xw9EPEKOHMU+ps/12YjRPe
        8FNnDBBmn86sKM1xb/cmJLWJnACScwlUNJHtZ4lblg==
X-Google-Smtp-Source: ABdhPJxOe4uyRLXZP5DBGnuKo8jdCnnZ0LHyd7dOyBNxY/Rs3f6ueLDCA+FZnjpV2pJibiCF9kEN/HOSbWk3CbaxdmA=
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr13937264edz.44.1625461594122;
 Sun, 04 Jul 2021 22:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210703005416.2668319-1-bjorn.andersson@linaro.org>
 <20210703005416.2668319-2-bjorn.andersson@linaro.org> <cacd1a1f-01c8-b913-23e5-538a772cd118@codeaurora.org>
In-Reply-To: <cacd1a1f-01c8-b913-23e5-538a772cd118@codeaurora.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon, 5 Jul 2021 00:06:23 -0500
Message-ID: <CAOCOHw4sufqC3=ixNud8Oz7vO0_ZcO8u5mqNQTKLZX4LGe9aow@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: rpmhpd: Use corner in power_off
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 11:27 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
>
> On 7/3/2021 6:24 AM, Bjorn Andersson wrote:
> > rpmhpd_aggregate_corner() takes a corner as parameter, but in
> > rpmhpd_power_off() the code requests the level of the first corner
> > instead.
> >
> > In all (known) current cases the first corner has level 0, so this
> > change should be a nop, but in case that there's a power domain with a
> > non-zero lowest level this makes sure that rpmhpd_power_off() actually
> > requests the lowest level - which is the closest to "power off" we can
> > get.
> >
> > While touching the code, also skip the unnecessary zero-initialization
> > of "ret".
> >
> > Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   drivers/soc/qcom/rpmhpd.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> > index 2daa17ba54a3..fa209b479ab3 100644
> > --- a/drivers/soc/qcom/rpmhpd.c
> > +++ b/drivers/soc/qcom/rpmhpd.c
> > @@ -403,12 +403,11 @@ static int rpmhpd_power_on(struct generic_pm_domain *domain)
> >   static int rpmhpd_power_off(struct generic_pm_domain *domain)
> >   {
> >       struct rpmhpd *pd = domain_to_rpmhpd(domain);
> > -     int ret = 0;
> > +     int ret;
> >
> >       mutex_lock(&rpmhpd_lock);
> >
> > -     ret = rpmhpd_aggregate_corner(pd, pd->level[0]);
> > -
> > +     ret = rpmhpd_aggregate_corner(pd, 0);
>
> This won't work for cases where pd->level[0] != 0, rpmh would just ignore this and keep the
> resource at whatever corner it was previously at.
> (unless command DB tells you a 0 is 'valid' for a resource, sending a 0 is a nop)
> The right thing to do is to send in whatever command DB tells you is the lowest level that's valid,
> which is pd->level[0].
>

I'm afraid this doesn't make sense to me.

In rpmh_power_on() if cmd-db tells us that we have [0, 64, ...] and we
request 64 we rpmhpd_aggregate_corner(pd, 1); but in power off, if
cmd-db would provide [64, ...] we would end up sending
rpmhpd_aggregate_corner(pd, 64);
So in power_on we request the corner (i.e. index in the array provided
in cmd-db) and in power-off the same function takes the level?

Can you please help me understand what the actual number we're
supposed to send to the RPMh is? Is it numbers in the range [0-15] or
is it numbers such as {0, 64, 128, ...}?

Afaict it's the prior (i.e. [0-15]), as this is what we currently do
in both power_on and set_performance_state, and it happens to be what
we send in power_off as long as the first level from cmd-db is 0.

Regards,
Bjorn

>
> >       if (!ret)
> >               pd->enabled = false;
> >
> >
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
