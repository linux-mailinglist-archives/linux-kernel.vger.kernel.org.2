Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3D3384D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCLFFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhCLFFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:05:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:05:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s21so4576999pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sMxwnvuc1nA8yvslVBDOI1x9ILhMBBdT+FDUKsUbLFw=;
        b=QCAOkT4QxsUi9ibjkTr7f3jgm5CEzmHYE6L9DeAEe8Y4GWu5YMakan/Z53Y95rEHSJ
         fATQpqGYDDBWx6dx1bu2KTxmIgSs0Y/myxOzowcc+NprM1whRf+d4iGZ+IXCWDLW6SeJ
         O1mg7dCSFGeGFNRUKhsvpTdM2PmCrLqgt/nmlDi9Cl+Vn+J5YfahSh1eLJ9FjwvXXxdC
         GN11TzKtHZXFPPqUQkp6qSGUEhBJEnHkdA97MmR5Pev53Cbzm3o6P3bTu9ghpurrsOkQ
         kFdaN+qyyTTyMMrdnydhBDE32uRE+yMc8VE97FL0i+gW455vYSvfUOGhBArINjS7VPnT
         TUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMxwnvuc1nA8yvslVBDOI1x9ILhMBBdT+FDUKsUbLFw=;
        b=c4/FyWBxMqDG78yTEc5e31y9w2abzGsYUtuomNICQeWkAC9FQQ0IS3A4mhRkm2iHKk
         gIy1byXS45dlR0kfFsMjg+5iqcICjv04DqS5TmVqkdpRvEjfCilsJAAsU+qxj1QHTmp+
         FACAoaPMwVEY5WWYuyEBv/uq3csb5ilFdrVaKgu9Br9aUrBIkzbFbruva3AUhlqxc76G
         l08HqPJZU2tTZZ4duAerDHZ+qOE+9umQFZ+jFyX6rn43Omdn7+JrRkMZupRuMo9/3dEJ
         odqqfbfZLNh0+4+RUEGO0z4c4NZD8wIeOyUZKGcTmbf6B0Ii7EqvL5DPsnPv2azrQljh
         2YsQ==
X-Gm-Message-State: AOAM532PS3WymJg+ueDsxoTcXv5dnp1L71VBx/Xd06KJ+GAyx84rXbUL
        nfEbEbEpbJe1pV/6nRTTr94pxg==
X-Google-Smtp-Source: ABdhPJzrXlzlGOv2QAM2TH1Gyw5l/Ofi3ya9OtE2H7DvA6J8UYYuSv5rsvmB8DaebXp640Oj9rP4YA==
X-Received: by 2002:a17:902:59c9:b029:e6:5cdd:f709 with SMTP id d9-20020a17090259c9b02900e65cddf709mr11644131plj.20.1615525549931;
        Thu, 11 Mar 2021 21:05:49 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id s194sm3992652pfs.57.2021.03.11.21.05.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 21:05:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 10:35:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 3/4] arch_topology: Export arch_freq_scale and helpers
Message-ID: <20210312050547.mhyhz2vntple2oxu@vireshk-i7>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
 <1b5c83549720da480b1e23e542f44b1edb2e4157.1615351622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5c83549720da480b1e23e542f44b1edb2e4157.1615351622.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-21, 10:53, Viresh Kumar wrote:
> It is possible now for other parts of the kernel to provide their own
> implementation of sched_freq_tick() and they can very well be modules
> themselves (like CPPC cpufreq driver, which is going to use these in a
> later commit).
> 
> Export arch_freq_scale and topology_{set|clear}_scale_freq_source().
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/arch_topology.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index ebcd2ea3091f..995e52b9eca4 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -78,6 +78,7 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
>  
>  	update_scale_freq_invariant(true);
>  }
> +EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
>  
>  void topology_clear_scale_freq_source(enum scale_freq_source source,
>  				      const struct cpumask *cpus)
> @@ -96,6 +97,7 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
>  
>  	update_scale_freq_invariant(false);
>  }
> +EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
>  
>  void topology_scale_freq_tick(void)
>  {
> @@ -106,6 +108,7 @@ void topology_scale_freq_tick(void)
>  }
>  
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_SYMBOL_GPL(arch_freq_scale);

Did minor change here after testing bot complaint of sparse warning.

-EXPORT_SYMBOL_GPL(arch_freq_scale);
+EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);

-- 
viresh
