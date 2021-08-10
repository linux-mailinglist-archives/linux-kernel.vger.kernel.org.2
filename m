Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F53E57FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbhHJKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbhHJKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:07:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B3C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:06:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso3571759pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86LjhHwH2Y01JTFkrW4LltEIu0xfncQuIXbpof7c38U=;
        b=EPTZS1zs4hk/XgPzFZqbffWZQVnvrLyR3ikBz/nldBEri4wKTNPG02YCMYf3qAitT6
         q+Z4cbOAc+zBcMmq3+5mHoTiue9Oo7xe7e/GL5CVZ04ytybTU4xlb2s2j6jHQjQk62bx
         QF28hlimfhwV5gfNzfpwvrbzhJIZwfbT2HB+x2ZZtC/clMpcdRJQkXr0qth60U2HVJ7e
         667FyQcw0RUlRQ3txtiM1oraHW0alOh+QhDLENmbpQfvclDNkfEEpUTvYhT2R6HaMF8L
         buUhy+OmMCSHsLxF3cVcRztrvwwPRv6uD8LFb+ZoxIzUw9b+Fua3foOHksXpoLVrHKuZ
         VDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86LjhHwH2Y01JTFkrW4LltEIu0xfncQuIXbpof7c38U=;
        b=jOsTRpQf/0qK1GpwB61FIr69kizAWfgyR1kgzQUkXxdJelaDt9jGveGnl51nMz28bv
         oKYRrvijt0HGJazyOwVMsL0ZKCRPKBiKDqV2UrCw8rTsq9tYko/Wxi41GG09Z3mttgNu
         TfNTvRP1+SCdee0Vcjnm1vy9xkA7aipPDW8RaZL5K40KTqoiiVemGrW0Yl1d0FtgfDLZ
         FTt6lubdG9vjW7PTs+GJJc+WnFFX7vRQNNEqNdEigBlLynlmTaKXGkjSWgFc0mgJ0qri
         30L9g7SUulR+K2z16MbdprPlZLvz6sQOwfDJA8aEOChkvpG1kaAH8l0iixMXrhUuS+gG
         6W1A==
X-Gm-Message-State: AOAM532mhtyGf6ahMBB9n1YTUsYtTloKO59pmVChxYym8TScShqZkyfF
        Nq3LShz45YZC/NLu6IHP469JyA==
X-Google-Smtp-Source: ABdhPJya2Sgo4k+tUz0e5kI+ZjaNDAiFasmQ7SRwJDsYaa4PKlQ/HHyqa0QnogcR6+emA0GopdeupQ==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr10803526plw.83.1628590015127;
        Tue, 10 Aug 2021 03:06:55 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t13sm20302715pjg.25.2021.08.10.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:06:54 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:36:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy
 model
Message-ID: <20210810100652.h473q6hgtc5czfyk@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
 <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-08-21, 11:05, Lukasz Luba wrote:
> I can see that this driver calls explicitly the
> of_cpufreq_cooling_register()
> It does this in the cpufreq_driver->ready() callback
> implementation: ve_spc_cpufreq_ready()
> 
> With that in mind, the new code in the patch 1/8, which
> registers the EM, should be called even earlier, above:
> ---------------------8<---------------------------------
> /* Callback for handling stuff after policy is ready */
> 	if (cpufreq_driver->ready)
> 		cpufreq_driver->ready(policy);
> ------------------->8----------------------------------

Thanks. I will look at this sequencing issue again.

> This also triggered a question:
> If this new flag can be set in the cpufreq driver which hasn't set
> CPUFREQ_IS_COOLING_DEV
> ?

Why not ?

> I can only see one driver (this one in the patch) which has such
> configuration.

-- 
viresh
