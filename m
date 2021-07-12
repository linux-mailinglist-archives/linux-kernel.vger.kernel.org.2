Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553E33C431C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 06:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGLEiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:38:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2DC0613E5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 21:35:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so4799543pju.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 21:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmGLdBbyR/yGG+zKrhDWgh07yOAMlhLUGNP6ofQQJRo=;
        b=nwDOp4z7ovILlGRp/8705+bIVZqC8l2kngp2tnOLTu9nBV/ig/3lr1zjpTtCF2u9QH
         /6zIJSmg9nRsKRHm1ZPs3ZYhzYW0OhVRRkQrLiLx7M1JCtQ4iiCRqnOZChm2r/vvr8TC
         XdvFMut3x54aORCsfwOP+wrFhfUiVKRm2pESYD9ZP2gf/Uexj2vM2B/OlFT+D7uE4akV
         LHJf2peNV9+1aDk986Ro6uFrGwHyvl0r8GYBSfTijRja4tAodavCutWXCrg9EKNPL4hD
         7ShMJBwgKMJ+DpHNjuMWBBMbxNnRFpQpgmO+T4fsipHbFxAcfklVXqv3DLQCX1hMV/sU
         Dkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmGLdBbyR/yGG+zKrhDWgh07yOAMlhLUGNP6ofQQJRo=;
        b=LOi0W7LEXz8a0vPS5hTIen8yGezJsWEWQ0BpDVl5LfekeVzY5uI3OqlliGbT2xgpB7
         FtqpRiLBzzrwtiZldrDw/1g5W5jsqB2LSwyP2NxYjw5F6bE+0AOB7ZYvqM7752l9K4tX
         0TvXdTvH7caWTRj4JRqbvDhK7A0MWYzR265VRDjPMBlAHna1PtHOLUKfEWCpVuP7BZF2
         T2lf139AyMBqmYBGQMyO02Qy9Z1b3V9qn1+h2s4BHvWdb8LfnadpmKvvt6z8Ne5smxjm
         JnrcCfYDuTEG5Yqn+327+VJb1p+cO/le8jRM/A8ocwXeUfYUXqixBLR28Yn0HEBVD/dy
         7WEA==
X-Gm-Message-State: AOAM533fu+HVcyFud3c622Z2LwK8Z68zHiaTn0E4ecWT33J4uVzGsDo1
        MOCWAfQS1V08tSns83Hu78DyDg==
X-Google-Smtp-Source: ABdhPJyYK2HkWzveNkGLeG7+KdOGAgtFAMCx2Bq7Pc2S3zlCBItilSOYkwsW/vszIQLMAb18Fm8uvg==
X-Received: by 2002:a17:90a:e284:: with SMTP id d4mr12285357pjz.126.1626064517217;
        Sun, 11 Jul 2021 21:35:17 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id p1sm14072015pfp.137.2021.07.11.21.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 21:35:16 -0700 (PDT)
Date:   Mon, 12 Jul 2021 10:05:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210712043514.ijp6cm3zuri7u5hb@vireshk-i7>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org>
 <20210709064646.7vjgiba2o7beudly@vireshk-i7>
 <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Lukasz,

On 09-07-21, 11:37, Thara Gopinath wrote:
> On 7/9/21 2:46 AM, Viresh Kumar wrote:
> > On 08-07-21, 08:06, Thara Gopinath wrote:
> > >   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> > >   {
> > >   	struct platform_device *pdev = cpufreq_get_driver_data();
> > > @@ -370,6 +480,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> > >   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
> > >   	}
> > > +	ret = qcom_cpufreq_hw_lmh_init(policy, index);
> > 
> > You missed unregistering EM here (which is also missing from exit,
> > which you need to fix first in a separate patch).
> 
> Hi!
> 
> So how exactly do you do this? I checked other users of the api and I do not
> see any free.

Lukasz,

I don't see the cpufreq drivers ever calling dev_pm_opp_of_unregister_em(), and
even if they called, it would translate to em_dev_unregister_perf_domain(),
which has this:

	if (_is_cpu_device(dev))
		return;

I am not sure what's going on here, can you help ?

-- 
viresh
