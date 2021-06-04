Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB839B126
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFDD4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:56:19 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44956 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDD4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:56:18 -0400
Received: by mail-pf1-f175.google.com with SMTP id u18so6479317pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ijm9mI6kBOXP+oPrDMGDyY4lUqBqK/+hLm4ytshoSI=;
        b=wNBJ+FLB2/mjtgOQap7hj9qwv9U6UjZ/cLGFE9sobg2lhJffSNWkMQJWZUBMxu+SOa
         bhX+FcOsLHi3KiiJky5zwxikYdgVGwipU1suOOAK6z4IxgWAVkPjGCVUC+4C6NanulAc
         rSACEnaG3xQFxqO5vkVncYJKvOBKGFUntlZjFyAHKDMAqFntitqLmKIKpJvNsI69JHL3
         dDBC8sEs8vEetDIzT/jCTqv7JL9tUXclCGaM14xjjffRAYlgnTEu8dEULw9bSEuvXSEe
         nYGGDelcTo/ezyK0w8sHTy5dWyCOYWWhWEZH0ha9uJjXrfUE1343a2hxwtvi3rCCF0Cw
         xqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ijm9mI6kBOXP+oPrDMGDyY4lUqBqK/+hLm4ytshoSI=;
        b=Q9Itvdv5HXj6iUcu2cGza7PhTuGSL+H83ycz6qCx/I9WwY0ZqVUQMWXkBfJEd9nzUS
         4roIKM9xYuyLHnM4wHJ0Si4Aob3I0+Y/35/ykqmR690yn0esVN/B+60hgjSgXxBNjUx/
         AjtSyMqu+xwJuPBLl4dLpNwmGddKFAipNTEWIxMwsFb8UPIkZ1CTcnnG0bJTrEvf8O2I
         dL4OHQrBaJWkTHJx8uxUWkoyj73BM+T7Cv/KNhV4RIBO1rKbeoGhSXAaQ3q670wkLoEz
         GLS8WrWOcaKbBJz9Bpul4eJxl8ikw9/BxBrLiJSqK+1WWreMvlLWENUTY35b0aRE5wgx
         dIXw==
X-Gm-Message-State: AOAM530njrv7fKDnYzGT2ViUtW5xKA9iSEn7EJbwKl7P+YwCL5tJTpMI
        QcsU/gg5SkunVuGBiuN+B8IQNQ==
X-Google-Smtp-Source: ABdhPJzFuScCZHrJLAasevbcPUgUk0ahyaDro5v+732wEn71LPtujZoeCD44R3GjCbJdBJGjGK4VlA==
X-Received: by 2002:a63:b243:: with SMTP id t3mr2786567pgo.253.1622778797706;
        Thu, 03 Jun 2021 20:53:17 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id f4sm3299976pjs.1.2021.06.03.20.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 20:53:16 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:23:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
Message-ID: <20210604035312.jp2gshfigsodwvcg@vireshk-i7>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org>
 <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
 <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
 <CAPDyKFofsuY_RAMGsRLtKo=JxJ11DgGqOijZEEf1HEANCvomzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFofsuY_RAMGsRLtKo=JxJ11DgGqOijZEEf1HEANCvomzg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-21, 13:17, Ulf Hansson wrote:
> On Thu, 3 Jun 2021 at 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > +static int genpd_drop_performance_state(struct device *dev)
> > > > +{
> > > > +     unsigned int prev_state = dev_gpd_data(dev)->performance_state;
> > > > +
> > > > +     if (!genpd_set_performance_state(dev, 0))
> > > > +             return prev_state;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void genpd_restore_performance_state(struct device *dev,
> > > > +                                         unsigned int state)
> > > > +{
> > > > +     if (state)
> > >
> > > I will skip this check, as we are checking it in
> > > genpd_set_performance_state() anyway ?
> >
> > I don't want us to override OPP votes made by the subsystem/driver
> > level runtime PM callbacks. For example, if the drivers manage this
> > thing themselves, that should be preserved.
> >
> > That said, by the check above I want to avoid setting the state to
> > zero internally by genpd, if the driver level ->runtime_resume()
> > callback has already restored the state.
> 
> Ehh, forget about what I said about the ->runtime_resume() callback.
> 
> I am mostly trying to avoid restoring a state that is zero, just to be
> sure nobody else on some different level outside gendp, have decided
> to set a new OPP in-between our calls to
> genpd_drop|restore_performance state.

What stops the core to call genpd_drop_performance_state() in the
first place here, if the driver was doing its own thing ? If that gets
called, then restore should be without any checks IMO. The state
should already be 0 at this point of time, I don't know why this will
get called again with state 0, but it will have no effect.

Can you give some sort of flow sequence where I can see the problem a
bit more clearly ?

-- 
viresh
