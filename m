Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1306C4540FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhKQGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhKQGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:42:37 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B634DC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:39:39 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m6so4277300oim.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=uaBnlFHJNu65iA6uEhxPYlb/03NsUwHMSkh0xmYjPh4=;
        b=asm29ox26MwSTUQG2YFYhV+q2GmCwLFcMHPBgvAwwXk8B1Hw2DiIPNjwdVj8frXPUS
         tw8aWGkod53MhdMhE85xkgkkYR3/JUhP5JoNPpCgyyXhZqIIhbD9iWSz/DcOxFm367Ja
         8ndWn2h2VZ41tqUwP1spyvhOU9i6s9ulWiDiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=uaBnlFHJNu65iA6uEhxPYlb/03NsUwHMSkh0xmYjPh4=;
        b=b2ukvKyQvIXr4EvoIRKwo0l/aRHfudIoRG3gDt9GojYWyUWcZ6IzOftuuuHjcv+G/D
         KgqLkSD2nsky6zpQ4wQ8/n3JTcyFeN/IowpMrFJ4k7EIEZg9aF1lHD4t1yExIFta9i2y
         //sew8gZ5HecZL0z96PZOmTY1/AcPBPbXz3yqbMRrvmyoj78wgTV5QQqfNFZSZi1YYQx
         M0P7lTtS8lOKMlXJ0NqfDARA6IXQ97pYrXm84kkeMYarTP488f02C4sc5O9UqtDG4HvW
         hpqhaG8Tp/8yWlfzlFcOB7orOXRpDbLzW3spwvcNE9RaFuVrt303dIXjS5D+Tn1AiImn
         alqw==
X-Gm-Message-State: AOAM533I4imo3Ms0ro8IyDamzlSCzXiwCb5MtsmiaPEt5liC3nurwHIU
        Lzv4Na6iPdRTvPMwmmtC5kmgfs8jjDOSHnyvBgIitQ==
X-Google-Smtp-Source: ABdhPJyBHQWaotdsn7Iy2GutsTjMnAVJWzUw5o7uB8itcXEeqVjdmLxnB/uP+e7Kaz12lP4ZnNA9eyDHEqWpLU9BZW8=
X-Received: by 2002:aca:2319:: with SMTP id e25mr58625412oie.164.1637131178953;
 Tue, 16 Nov 2021 22:39:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:39:38 -0800
MIME-Version: 1.0
In-Reply-To: <000101d7db7c$d2ef1330$78cd3990$@codeaurora.org>
References: <1635860673-12146-1-git-send-email-pillair@codeaurora.org>
 <1635860673-12146-4-git-send-email-pillair@codeaurora.org>
 <CAE-0n53PSDzj9owjeaB1bGQ5=255=Q_djEvcQGtZzRxMRMhe1g@mail.gmail.com> <000101d7db7c$d2ef1330$78cd3990$@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:39:38 -0800
Message-ID: <CAE-0n502Wi+oLnzbjZ4TVe1y98=rL2ML9E5FSKaBfcEmWP+W9A@mail.gmail.com>
Subject: RE: [PATCH v8 3/3] remoteproc: qcom: q6v5_wpss: Add support for
 sc7280 WPSS
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibis@codeaurora.org, mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-11-16 22:31:51)
>
>
> > -----Original Message-----
> > From: Stephen Boyd <swboyd@chromium.org>
> > Sent: Wednesday, November 17, 2021 4:25 AM
> > To: Rakesh Pillai <pillair@codeaurora.org>; agross@kernel.org;
> > bjorn.andersson@linaro.org; mathieu.poirier@linaro.org; ohad@wizery.com;
> > p.zabel@pengutronix.de; robh+dt@kernel.org
> > Cc: linux-arm-msm@vger.kernel.org; linux-remoteproc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > sibis@codeaurora.org; mpubbise@codeaurora.org; kuabhs@chromium.org
> > Subject: Re: [PATCH v8 3/3] remoteproc: qcom: q6v5_wpss: Add support for
> > sc7280 WPSS
> >
> > Quoting Rakesh Pillai (2021-11-02 06:44:33)
> > > @@ -457,7 +608,13 @@ static int adsp_probe(struct platform_device
> > *pdev)
> > >         if (ret)
> > >                 goto free_rproc;
> > >
> > > -       pm_runtime_enable(adsp->dev);
> > > +       ret = qcom_rproc_pds_attach(adsp->dev, adsp->proxy_pds,
> > > +                                   desc->proxy_pd_names);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "Failed to attach proxy power domains\n");
> > > +               goto free_rproc;
> > > +       }
> > > +       adsp->proxy_pd_count = ret;
> >
> > Can we check this against the define so that we don't have more than the
> > fixed number of power domains and try to access elements beyond the
> > length of the array?
>
> The number of entries populated in the "proxy_pds" array depends on the "desc->proxy_pd_names", which is statically
> initialized for each remoteproc. Hence there will not be any out of bound access for this array.
>

Sure nothing is wrong today but it's a potential problem in the future
if someone adds more elements to proxy_pd_names than proxy_pds can hold.
Please prevent that from happening by writing stricter code.
