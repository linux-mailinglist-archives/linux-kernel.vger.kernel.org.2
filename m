Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3B3F7BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhHYRio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHYRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:38:42 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A381C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=rY73rRoR8yTyuQDcGNMsO2Zf1R0kZpSKccJmW700Kfs=; b=EiwX1npFSWNkI5tgP5Vx1LXX6J
        KpR90iLf7fw2pWlk6fMe/FHIuIYX9eFiryZD5ie6CaoUt/0tGdU2iZiWmMNGhhDmUPmOzGphSlIZT
        8sAQDHEu9YtZd6tOVkEzZcyEQB0M6fHii814/5OuJn6sPLWO+9vI+B7OsP5OWUFR4+YvJuEhPQVaj
        tTd23ikIpNufcYBdeB4TS3Peye6/Lfw67K/VepkPhLiEmLv5Gzo8GujjOx7gXk4/X1WESDcwkTvf4
        NEO6keGuS6P3oDOn2NYDvosoImF0WZgDD92LITVgGwiotib/AUbxEx24uQ3yCVLRLcNVNs97NFHue
        u9ecC2DA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIwqa-0086t7-0t; Wed, 25 Aug 2021 17:37:56 +0000
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build,
 part 2
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        SeongJae Park <sj38.park@gmail.com>,
        linux-kernel@vger.kernel.org
References: <14920.1629868638@turing-police>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8ff70e56-f3c7-09e8-0915-ebde0f44ede3@infradead.org>
Date:   Wed, 25 Aug 2021 10:37:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <14920.1629868638@turing-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 10:17 PM, Valdis Klētnieks wrote:
> Commit 86afc1df661a adds a reference to a symbol that doesn't have an
> EXPORT_PER_CPU_SYMBOL, which fails if qcom-cpufreq-hw is built as a module.
> 
> ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> 
> Thanks to Seonjae Park for pointing me in the right direction.
> 
> Fixes: 86afc1df661a ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Suggested-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 921312a8d957..7e7de763bd88 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -149,6 +149,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
>   }
>   
>   DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);
>   
>   void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>   {
> 

Hi Valdis,

I could not repro these build errors in today's linux-next.
It looks like someone has already merged an alternative patch
(and its follow-up):
   https://lore.kernel.org/lkml/a1053bd0e63ec0d985691b8a37bf7f6d5a1156aa.1629702403.git.viresh.kumar@linaro.org/

thanks.
-- 
~Randy

