Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD353B7C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhF3D4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 23:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhF3Dzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:55:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC78C061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 20:53:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so3081435pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UD8T97d6m5wJ+ibsAaXsXaCeGXCEKJyV5O+K6ZTbqtk=;
        b=R7GIPWVXUcCcFCZro/fdSCmKWKSZvb0/CPUuhSh6bLmBN+XLgDK4j3FaDTiEwW2Uyc
         4jlJ2KBTfrJv6u4/aSfvO+bH6Y1Bw0Oe2fA800RIkbCB9DHg7SIguJYYOdTorgfb4I9D
         ohrOYZYT/ehlwSZRzW5vwL7NJwK+XdkCOltFHuKFzwXVe0RrulCgKq8qSyIw8567KuQi
         SF3Ka/kuOYQ6idEixi3oo3CsrtcRiCAirnFwdTLSQV1J6NVDIwgeu77++PNC+5KZ8ukw
         RCccynICKc9Li5OSM0gK+/iCqXDWMWfQq4PGbmIsQHpsjyX8IWlYvLABj1BSmn6KjIMr
         KkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UD8T97d6m5wJ+ibsAaXsXaCeGXCEKJyV5O+K6ZTbqtk=;
        b=pcrxLb3rApwGpxK8EjArXXz5IbvM/V+HlgEdiySocEZdgZXqY02AfnMFuhuvLp1J1G
         b2dyV3fgm+7XbwSz14Xrp7hEAEO2fdrj2HL6BRo6HaNq7XqrmWKeP/zyYykMjJQVSLCv
         E/ZnEUgLsFhspDaxWqgM57pp/lqCgRP3Q5MYKmxPNO3M2iU8LUcUoNYiKC5UIqZKU8GM
         AfAeeD3dDRGyWlQZzXyvlNg1NYWMhfYVQtk8PuuTbjq6MYYDefqsNOHP8IdA2BbrCcxL
         2s90NmLn6cckADDZSxHi/hjMIRBHMBCVo8/tmk3pFTA2XGbXln2BzcIE7YC4GDY7yZce
         lg6w==
X-Gm-Message-State: AOAM530UHSwN9D5Vgr4wmfTxGJzpsCitA9yo6BxoYD0jt2UjSaq2gOkT
        qByDALqXgttTG3h7EUDC+25v5Q==
X-Google-Smtp-Source: ABdhPJzwaGRPZR/RwPb5361P3l44INggwSiCue7C9Mww3eNhmzaKQEkIeHOGInLB9v/6PM7o1G3asA==
X-Received: by 2002:a17:90a:fa92:: with SMTP id cu18mr2311163pjb.215.1625025192309;
        Tue, 29 Jun 2021 20:53:12 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id n33sm19872937pgm.55.2021.06.29.20.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:53:11 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:23:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v2 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210630035307.gaglmi36lqk3shwp@vireshk-i7>
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-4-thara.gopinath@linaro.org>
 <20210629023556.v3u4hdye5ojolubq@vireshk-i7>
 <5d194c91-e557-e5f5-60d6-ad2b1ca2def4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d194c91-e557-e5f5-60d6-ad2b1ca2def4@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-21, 22:25, Thara Gopinath wrote:
> I don't think cpufreq_cooling recognizes boost frequencies. The max state
> there is the max of nominal frequencies , right? If not, it might be a good
> idea to add this check there as well.

Ahh, that explains it.

-- 
viresh
