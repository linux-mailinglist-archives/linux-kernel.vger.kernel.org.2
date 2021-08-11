Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC63E93C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhHKOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhHKOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:40:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D80CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:39:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso4615131wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gdt8lIjV6iD7SQvCjoFoUXFp8NNjB2qyZ0eN4tD/1G0=;
        b=DBDuQvZD0UIyI7Y7ZQl0EawBBOTfUFUj8fQBZTzqbVZI8OPdKTQ/OSyfKe3AxsN8sl
         G9ybap+FG06KwTIp3NLpkFvzI26uySZdMywdZ26OyQ9FFKYwWXfmzUUYhu4IJ577Mti2
         8XoGP4Z+mY/Ycd6eqZYYYN6kACBQQ8En9cilDT/92mUYOIZwx+bgxjCgh/ywSNP3h1R9
         Js+yPydRUXV3qCVrRTwgusvInINW6Wh/4M/dsX4FVokHfB4i7syKk5vDsWLWBnGUuW08
         EpXUCCKDTXHx7nTl3cVVt2R6U8fcQSrPr4zvyWfNSHD7JsSypvM8QbhvVvc0BXdBao8s
         yZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gdt8lIjV6iD7SQvCjoFoUXFp8NNjB2qyZ0eN4tD/1G0=;
        b=oO6nfbnU/cWO1vXuCkBl8Oh1QnXTmqlf+tXT5duVjYonoiTmbq5cEpHiUX1SkId7VW
         1fE0sZDXD97T6rGakSqf0IIQLNeGluu8s9vE9OOhZ0uumwOlnHbTOByWorblb8MNrmHt
         8xxdLIXlEdRiASYlFdeI/bfwp394wevY/Y1pI9SBfOK/H/iK2FCrr3r4u7XgN+3DtkMB
         8eEd9qmPR6nz0dExidNByPqVbMDk8yYk0EApi06Y+cuzv5WXWSVpJB7v1OBal5tFcN+z
         VvJ/KUq6ej2u4p7uZAaVeH9iKIHfnXwsZr0arIEueHR+gwlIuFzJ+nHl8vGPpNcUKjMB
         25ww==
X-Gm-Message-State: AOAM531DBMVfccH5L5tLbusOth5l2oAODqUyjjVjj6EJPhUGczr6nRqJ
        eU75aQ9dCP5vuQyco0K75zYMxA==
X-Google-Smtp-Source: ABdhPJymFwE8deJDEUQN95xYHSVUV02wjbndxGNU77LOz1RKXXiK9Tf21LKPwUIa+gJMzFfHx/e+kQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr22252909wmb.112.1628692777433;
        Wed, 11 Aug 2021 07:39:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
        by smtp.gmail.com with ESMTPSA id g12sm27079366wri.49.2021.08.11.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 07:39:37 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:39:31 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
Message-ID: <YRPhI3AOAJLpQnjT@google.com>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
 <YRPN8zjp1wqkHg6t@google.com>
 <b02cff82-d242-f783-6f29-78e734f78e26@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02cff82-d242-f783-6f29-78e734f78e26@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Aug 2021 at 15:09:13 (+0100), Lukasz Luba wrote:
> 
> 
> On 8/11/21 2:17 PM, Quentin Perret wrote:
> > On Wednesday 11 Aug 2021 at 17:28:47 (+0530), Viresh Kumar wrote:
> > > Set the newly added .register_em() callback to register with the EM
> > > after the cpufreq policy is properly initialized.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >   drivers/cpufreq/scmi-cpufreq.c | 55 ++++++++++++++++++++--------------
> > >   1 file changed, 32 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > > index 75f818d04b48..b916c9e22921 100644
> > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > @@ -22,7 +22,9 @@
> > >   struct scmi_data {
> > >   	int domain_id;
> > > +	int nr_opp;
> > >   	struct device *cpu_dev;
> > > +	cpumask_var_t opp_shared_cpus;
> > 
> > Can we use policy->related_cpus and friends directly in the callback
> 
> Unfortunately not. This tricky setup code was introduced because we may
> have a platform with per-CPU policy, so single bit set in
> policy->related_cpus, but we want EAS to be still working on set
> of CPUs. That's why we construct temporary cpumask and pass it to EM.

Aha, I see this now. Hmm, those platforms better have AMUs then,
otherwise PELT signals will be wonky ...

I was going to suggest using dev_pm_opp_get_sharing_cpus() from the
callback instead, but maybe that's overkill as we'd need to allocate a
temporary cpumask and all. So n/m this patch should be fine as is.
