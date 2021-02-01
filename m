Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435D730A4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhBAKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhBAKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:06:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA222C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:05:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t25so11753470pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frVr/xCUvbYcgOOMMYBu0rOoutvXVeUOoguRH3Tfir4=;
        b=KwK6870QDpRjaQinp8V2YB7qTqptw0NUC4QQzI6GlaPFwXhH4XhywUDn/dr3sbz6Gy
         OC4dJlWbmACnp5g0iaHf7r2ef2MJMzVA4SX9JzX0tQzX3dH9LjJrJmtGptQfM2hAb75z
         UwUleW6xFmNJZ+WzH6n/lRLf7noLT5jz5vNrR3OyxLR8GSEIHs3YpR9lunUV5AVQaJ5e
         xUsgx/9Q29q66NefdOejr8sBM9dmVUXClEIPnF5lvzGZDfQAj90Vfg6rzlDhsmHnyaIj
         BgQ6zroUKfsLkQfJtGCrRgiUkguq9n6eaDLq/9bX4KdNIES/ladpVGwk5SF3htHMTj4K
         ukHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frVr/xCUvbYcgOOMMYBu0rOoutvXVeUOoguRH3Tfir4=;
        b=KUNJQ0tb97ovyGQaa2AVtxAaSwbQLrtm26n8SKxyd2GGMbAs3D3t2gUsPjJfv8XhRW
         5Hq2TueagVOeTVmN6KzKzjc9wK7NTPANIifN2SBGdqQVmSHo+SfZoIWh38PyFWlm9rKL
         IeGmoWqp/4zX0xaiwRnexWfhCsOCbknzUmSHYg6a5vQVib/H4wRtxLuw6XZ3kzE/Bie3
         V/dwyxykRPmrTXQtjMN7Axir6eIaTki9Ce9vk4JaUwo5EenJ5oH7w6Wsk0ZPaVCvDHJB
         yVRacY2btfbgG+adndTO4JQdaPk68Z6ojZdPdS00UAYxXlCJyeGjLXsqFBbK+oLiHtsl
         +pNA==
X-Gm-Message-State: AOAM532aQZSvBB6qbLbV+rF+aWwONx+OaIPc9l0mEfg0YPSTZbj2fg8P
        4ltuy3yhoRlKzjo8hOmTjfsKwQ==
X-Google-Smtp-Source: ABdhPJyxP1XDmrI0MqAUO7EnoKcwJKb1624sQpyrFq75F363UpbEny2r9jczdiB/yEeu8ohEE5Gqfw==
X-Received: by 2002:aa7:8698:0:b029:1be:aef7:449d with SMTP id d24-20020aa786980000b02901beaef7449dmr15532020pfo.60.1612173905191;
        Mon, 01 Feb 2021 02:05:05 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id c11sm15454066pfl.185.2021.02.01.02.05.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 02:05:04 -0800 (PST)
Date:   Mon, 1 Feb 2021 15:35:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Remove CPUFREQ_STICKY flag
Message-ID: <20210201100502.xluaj5rpqosqsq7b@vireshk-i7>
References: <377d2e2d328276070ae2f26c65daa1497bb3c3cf.1612166647.git.viresh.kumar@linaro.org>
 <YBfNb91psVcf3TAS@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBfNb91psVcf3TAS@light.dominikbrodowski.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 10:44, Dominik Brodowski wrote:
> IIRC, it was required on various ARM systems,[*] as CPUs were registered as
> subsys_initcall(), while cpufreq used to be initialized only later, as an

s/later/earlier ? arch happens before subsys not at least and that is
the only way we can break cpufreq here, i.e. when the driver comes up
before the CPUs are registered.

> arch_initcall(). If the ordering is opposite now on all architectures (it
> wasn't on ARM back then), we should be fine.
> 
> [*] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/arch/arm/mach-sa1100/cpu-sa1100.c?id=f59d3bbe35f6268d729f51be82af8325d62f20f5

Thanks for your reply, it made me look at that aspect in some more
detail to confirm I don't end up breaking anything. Unless I am making
a mistake in reading the code, this is the code flow that we have
right now:

start_kernel()
-> kernel_init()
   -> kernel_init_freeable()
      -> do_basic_setup()
         -> driver_init()
            -> cpu_dev_init()
               -> subsys_system_register(for-CPUs)
 
         -> do_initcalls()
            -> register-cpufreq-driver from any level

And so CPUs should always be there for a cpufreq driver.

Makes sense ?

-- 
viresh
