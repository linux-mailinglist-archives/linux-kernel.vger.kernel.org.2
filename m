Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80FD323784
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 07:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhBXGsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 01:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhBXGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 01:48:10 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC8C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:47:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k22so612558pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+PKX1tqPNykmedfrh7em0CF5LOPt6T508fmuoJN2TMc=;
        b=CzUNH0mcsK2VYUb6BlIDTpdruzzV9hgZ7pzA3qwzBw9VL/+cDMcKHb0so0C+WULTDX
         z7mF1MrfVG8yEaqFUe6Zc6s/SVjdQMXoZkxFKZ/F0hZX8ME2jylYxx2UwHlhXkyvdlzU
         GPWsX8RzPqO/R3dOD0+NnEXa4lKOuUY9KHB8ADOhFdeJtNSxHRFq05Ek3Q2jhmHUICzr
         O27elcMSCW6Zhu0FVHfD2mah1v+U7JRuaH9raMMIK0Kbow4xk91qD+XkGqS+brli1hZ3
         vIC2tfCfTeee3RKm7ocmz++EP5HHdzYepNVcdxtnYskiZDILRRLZzxX1NHWjv4Xz65uu
         TvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+PKX1tqPNykmedfrh7em0CF5LOPt6T508fmuoJN2TMc=;
        b=VMZfcdJ3QQOtqhJnmIpkxKHIQ5ooZup/4b0O+R9Fg4IzMG23zoFN7EVs5ybzzIvWL7
         mtqy8vcrw72zpSTmHBURPeZDhmU554wPZBgqPm3mE7GCG/WULoalx89iQELaAhr2IBf3
         fZ48zLWKScx2T1J4U6CC/2vPA4pJo9+ZA973YUaBZkyJAuAzaoiSELB5bozd9I1NUsJR
         SIlKYhnnc0jPD/OCcA9Mcon0+5ThVcKQ/BlYj4n7MrCynazPisWYfuSy8247RQJIEv/S
         2HgGXZcUX0Jq5arVBmDKVsfzyCDQjCqbL0Yf7WNtLH6yYAW5Rj/zufQFTSU8sIy2R1p6
         PB8w==
X-Gm-Message-State: AOAM532HOhIeJIY5G/jW+KRJZJ3peApZC8EDSgpT3XNn58u78H3wv2pz
        fiUVYIhpqD5/4eHryx94hq/K6g==
X-Google-Smtp-Source: ABdhPJz6Dk3s1Gw6sa1nNnIeOrqnDYKbwsJL4/3Swc6qtxdROyA91KUJSwX1PNgDgkShE/q2MSpVYA==
X-Received: by 2002:a17:902:c702:b029:e3:cb6b:5e59 with SMTP id p2-20020a170902c702b02900e3cb6b5e59mr23521579plp.71.1614149249889;
        Tue, 23 Feb 2021 22:47:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y202sm1455478pfb.153.2021.02.23.22.47.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 22:47:29 -0800 (PST)
Date:   Wed, 24 Feb 2021 12:17:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH v2] cpufreq: schedutil: Call sugov_update_next_freq()
 before check to fast_switch_enabled
Message-ID: <20210224064727.w3w4b66jnsmcxdff@vireshk-i7>
References: <20210224063927.1298-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224063927.1298-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-21, 14:39, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Note that sugov_update_next_freq() may return false, that means the
> caller sugov_fast_switch() will do nothing except fast switch check.
> 
> Similarly, sugov_deferred_update() also has unnecessary operations
> of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.
> 
> So, let's call sugov_update_next_freq() before the fast switch check
> to avoid unnecessary behaviors above. Accordingly, update interface
> definition to sugov_deferred_update() and remove sugov_fast_switch()
> since we will call cpufreq_driver_fast_switch() directly instead.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
> v2: remove sugov_fast_switch() and call cpufreq_driver_fast_switch()
>     directly instead, also update minor log message.
> 
>  kernel/sched/cpufreq_schedutil.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
