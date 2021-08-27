Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634053F936E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 06:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhH0EN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 00:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhH0ENy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 00:13:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1AC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 21:13:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so3683569pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2crkDDVovoRCpVLHwusC/Etpp4MlaRIcgmloNRwz3ZA=;
        b=bnW+rlLr9u57Q4BBgt2wYSvPUvC9w71Jmv9CwQQxjc91Wp4Z+Ag0ASFr3DC7N5TxHh
         JZTAMGm16qdadxA0leOZSlXWk8wDxRIdLblaYjr4NvJzP/L8hgagsQK/UzrA/dfres2u
         aRD5fBDT4YS71ZAcVYuh2KOGut5wSM5YxX/hj2nDlycdU9UA18VByDNWH5YT7SN/32fr
         S0Rcx8hbRDXKlQgtXtX8Fv4H2Q0vazoT8aHnABGUEQ6LSVeR5pks138suIfTfl4i3ps9
         ou67TuGMp2/Ruk9J16WaGYbJNzBAnc2yvOLeyrJhJYnG1hDVseHIttw661aja2oqKAQT
         Eaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2crkDDVovoRCpVLHwusC/Etpp4MlaRIcgmloNRwz3ZA=;
        b=PwSaOkvsLoUZJ6zLN5LNU8+uH0LJC3ojXLxy3f+flJr64uSNxE8v77rQoGcjRBVKp/
         QqoBMGbic6D74exmq8tsPkPLuDt1arKX0oqBUERH5ThBDiZ2JNRIP0dcg9wgZd7Zh4y9
         S8o+qyqx6xZJub/zvJm39wn4NCI0rcJq6O83267rLNEd+gK7VLjVbg/dnV33B4qpRDE1
         Tn8LNCiLLIJGvjf3XB7OfBU53q8zLkwyjn1m59AUUzfEawm6+VCV8RKTrcVLTvO90HJG
         W1RK8LKV/hiVYGSOi+3T6J4rnDrW5h+m1anb1JBNHZ1IXKE8I3qz3pc5lUIKdAaZI1Jx
         7t3w==
X-Gm-Message-State: AOAM533E8jgrNc9V8zae6yhj2h2tSxeu4cfm5HPPhxhTRJDGXVZ3Rluj
        DNRPWmkf2ofT/eulrC+LSrpDOg==
X-Google-Smtp-Source: ABdhPJwxaRyy57tJuvxS009YryGtF88eBYjzRhV5X9ukzyaCKAtLMwVIZ6JW1GGf/e3dlFh4bngtKQ==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr8239511pjg.101.1630037585353;
        Thu, 26 Aug 2021 21:13:05 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id i14sm4459212pfd.112.2021.08.26.21.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 21:13:04 -0700 (PDT)
Date:   Fri, 27 Aug 2021 09:43:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state()
 callback
Message-ID: <20210827041303.5rz6xcyc2bo75tbr@vireshk-i7>
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-6-digetx@gmail.com>
 <20210827030557.aymjkky7athjxpow@vireshk-i7>
 <9c2287ca-4c51-d782-a0a5-4b1227c2e9db@gmail.com>
 <7aca6da3-89a7-a4a6-c720-8be4a105a696@gmail.com>
 <20210827040239.roal5jpndamzotle@vireshk-i7>
 <4a945d40-b30a-8a30-bdf8-4e17ad26cea7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a945d40-b30a-8a30-bdf8-4e17ad26cea7@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-21, 07:08, Dmitry Osipenko wrote:
> 27.08.2021 07:02, Viresh Kumar пишет:
> > On 27-08-21, 06:47, Dmitry Osipenko wrote:
> >> Actually, it doesn't work.
> >>
> >> The devm_tegra_core_dev_init_opp_table() needs to set clk to support older device-tree and now OPP table already has clk being set.
> >>
> >> WARNING: CPU: 2 PID: 92 at drivers/opp/core.c:2146 dev_pm_opp_set_clkname+0x97/0xb8
> >> Modules linked in:
> >> CPU: 2 PID: 92 Comm: kworker/u8:1 Tainted: G        W         5.14.0-rc7-next-20210826-00181-g6389463cbb0a #9318
> >> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> >> Workqueue: events_unbound deferred_probe_work_func
> >> [<c010cc91>] (unwind_backtrace) from [<c0108d35>] (show_stack+0x11/0x14)
> >> [<c0108d35>] (show_stack) from [<c0a6c1bd>] (dump_stack_lvl+0x2b/0x34)
> >> [<c0a6c1bd>] (dump_stack_lvl) from [<c011fc47>] (__warn+0xbb/0x100)
> >> [<c011fc47>] (__warn) from [<c0a696e3>] (warn_slowpath_fmt+0x4b/0x80)
> >> [<c0a696e3>] (warn_slowpath_fmt) from [<c07407b3>] (dev_pm_opp_set_clkname+0x97/0xb8)
> >> [<c07407b3>] (dev_pm_opp_set_clkname) from [<c07407e3>] (devm_pm_opp_set_clkname+0xf/0x64)
> >> [<c07407e3>] (devm_pm_opp_set_clkname) from [<c050735b>] (devm_tegra_core_dev_init_opp_table+0x23/0x144)
> > 
> > Why are you calling this anymore ?
> 
> Older device-trees don't have OPPs, meanwhile drivers will use
> dev_pm_opp_set_rate() and it requires OPP table to be set up using
> devm_pm_opp_set_clkname().
> 
> The devm_tegra_core_dev_init_opp_table() is a common helper that sets up
> OPP table for Tegra drivers and it sets the clk.

Ahh, I see. that's okay then. Just add a comment over it to specify the same.
Doing devm_pm_opp_set_clkname(dev, NULL) is special and looks suspicious
otherwise.

-- 
viresh
