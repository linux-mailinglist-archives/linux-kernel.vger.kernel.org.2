Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E93F41AE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhHVVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhHVVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 17:08:52 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=acsO0vRheXjx61bMjODn3+lNhDfQhnX9ZhEZMEdR7XQ=; b=Y0Vnwwtyg4qyGK7tjUC6rgWU5f
        7JoHJgn3iVJX5A8f+quINpvHuZtJlJkBeCVMSLzUN2+/942tyDapQIWHH4i0HrXItzjkPOCnWfPtO
        JUtaFosBAxUpds7I6q5Q9jiXNDdkVEfrxzmVVdA1NecA9DtLOp/t9c7wEG7PtpKk7/RAnjLGQxO5J
        KnCSLOWCu6FTwT8bAX+hv+K+asj4zdKmuZqI8dnvLuMNY9dD8rmZ7sVP4fgmFClmBa3jeJsCk5Q4p
        6WbJ4oxCmU52jDssNpfeSuaKNd2/EHLjQ8E3V7ZzBFjQnzsh0RovfVoka9niVFXq4E7GKljiBBACR
        7wRI+V9g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHuhO-00Eksm-Js; Sun, 22 Aug 2021 21:08:10 +0000
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
References: <438052.1629663003@turing-police>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2bf9925a-fad9-ad9a-c878-daa08fae7e07@infradead.org>
Date:   Sun, 22 Aug 2021 14:08:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <438052.1629663003@turing-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 1:10 PM, Valdis Klētnieks wrote:
> Commit 86afc1df661a adds a reference to a symbol that doesn't have an
> EXPORT_SYMBOL, which fails if qcom-cpufreq-hw is built as a module.
> 
> ERROR: modpost: "topology_set_thermal_pressure" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> 
> Add the missing EXPORT_SYMBOL.
> 
> Fixes: 86afc1df661a ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 921312a8d957..fbc39ca67124 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -165,6 +165,7 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
>   	for_each_cpu(cpu, cpus)
>   		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
>   }
> +EXPORT_SYMBOL(topology_set_thermal_pressure);
>   
>   static ssize_t cpu_capacity_show(struct device *dev,
>   				 struct device_attribute *attr,
> 

Hi Valdis,

This fixes one build error for me but I am still seeing another one:

ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

thanks.
-- 
~Randy

