Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A161239D36E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFGD3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:29:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5F0C061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 20:27:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e20so825689pgg.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvJrJ0XY7euO+eidhzQthv58D56gVbJFmIhLbAAQKkE=;
        b=k68m4h5gZBiwW1crjzom3dhfE6vfJhoWEYUvqjpn1j8YEc4V8/D9mnOTEHkYDbOZ6r
         BZka4ZTnUSWbB7zwgpcKTwYrs+sWPupGSOON0cFKaQJmSkByvTz9FSvVpr4/rFPkpWJn
         6apUkGHeQlovEGxKtlNbFDza8VbIJ6kCJmWlWocM1dzrLqf5yB/ub/Eg7qekci8o8cRQ
         0EUC2vCPLJF5g7x36dm1NWaWee7zgmDgtMMbJg1Drug2Zax5bJoOxIQiyRNG1+awkU8B
         9YLrXJ+AD3P6Z+bDAney5fy4HO6ylv0BzGSqiM7MlYKN1Hwzjjzrn5AwxASfNICdUzOi
         6iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvJrJ0XY7euO+eidhzQthv58D56gVbJFmIhLbAAQKkE=;
        b=eltES4+jm1PuQRnXioDF9Q7vAL7T3rO2ROXLPd3Lf/zH9Vf7h2tVp7mChFhjvjbW75
         vEuEBiD+QKZ0wvH5D+MZqbCig65Fy5AV+/BK86p3CcM5VAbomHNqx3OFMmNSYwkcRW8K
         AFoTK2nMhBj8sVhxCGjzATvYyAH6w50vyqvgOgmUXwweZeq8J8ioRbiuxpcLeijHbsTK
         ddygkl9g35n8U117Dd90FBU2bCHkLQij/kthRFJqRicC9Tc9z7+VbKfnFMHHpaemIuCM
         o++gB43xO2NHNRothgyoFwHW8k5BfKkfyi45VhEP+vFKj8A2pn2uU1QxEdOlPjie84FR
         JcSw==
X-Gm-Message-State: AOAM530PqbGyMPYbCqQ0yI/aJ98HgXGACL8efUYVTyMevcbcF+ik2sLx
        kkLHh0mOmiOhLrBJcYCwDWWNug==
X-Google-Smtp-Source: ABdhPJxojceEpIFdRg0YIgRTnQd4QZh7XXvWqZEyy79dUZAXAhQ7OjZqNLy8LEY8XCmgkggWa2TQyA==
X-Received: by 2002:a63:5446:: with SMTP id e6mr9816706pgm.73.1623036448487;
        Sun, 06 Jun 2021 20:27:28 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id w59sm10425127pjj.13.2021.06.06.20.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 20:27:28 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:57:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hailong Liu <liuhailongg6@163.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] cpufreq: sh: Remove unused linux/sched.h headers
Message-ID: <20210607032726.rolhnshkctluepw2@vireshk-i7>
References: <20210606115828.27020-1-liuhailongg6@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606115828.27020-1-liuhailongg6@163.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-21, 19:58, Hailong Liu wrote:
> From: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Since commit '205dcc1ecbc5(cpufreq/sh: Replace racy task affinity logic)'
> the header <linux/sched.h> is useless in sh-cpufreq.c, so remove it.
> 
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> ---
>  drivers/cpufreq/sh-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 0ac265d47ef0..1a251e635ebd 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -23,7 +23,6 @@
>  #include <linux/cpumask.h>
>  #include <linux/cpu.h>
>  #include <linux/smp.h>
> -#include <linux/sched.h>	/* set_cpus_allowed() */
>  #include <linux/clk.h>
>  #include <linux/percpu.h>
>  #include <linux/sh_clk.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
