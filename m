Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0890B3E960A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhHKQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhHKQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:32:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6035C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:32:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u15so2379733wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nh7YSWGAbfH+z/DRUnAVPr/ND2Dkxx036sjkmpCUCPw=;
        b=ajVs44wXrjc6bXKmdk4HNXeCamNjDnEUm95vKcdKirVLh6eB90I6MU3IYAMnLbC/n7
         rJzGhLEGGJjftqtF/jYmGlzx2RZUZWba8lSu9ICXg6yJAJUC2eirld77nwjZyGrW4rUe
         OpR2lTXzdyOUVVbILW21e+oh5IxeVOT3l1Xehg6tdRsNqyCPU0TJ2FEJqPnJ55Kk9t1u
         HkFEqN9B2iFWFuMo9Q819uPekrPZCST4jk/1V/d+RYB17JwO4weT12mpuQdt2RX35Llq
         Hn36ww7xg0u10561VOWJrUHixYawKHbqADSnSEw0leO1xxy9X5QBQ2ZiAhE2Q8Am7sB/
         Wdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nh7YSWGAbfH+z/DRUnAVPr/ND2Dkxx036sjkmpCUCPw=;
        b=d84m3FcbqPesthY1toAVPDltPM4dsfOZdahbr/Ozn/xXOgffqfrj4y5qIcmDyezUNS
         DQYy5X2IA4IQ4HSmuMkZHBm8PW3u4agRqXUKkTkE+qSqYwKnC93yqN6wESgBX2KyflZP
         evg1Gb4AXLFpS2CZmrRWoTPuot20a2/5k19nOToWg00q5D4sPyFMq6bBe/DNnVZ7FL/j
         tiSP58Sgac0y2plnYygmU8cGZmbjfxbqgYf2TBrqNhW4kAGvqWtslAtJ+WBWXsPXxrk3
         nJlNas+EAh44pxOR5DC/94cimxwsyXcGXhEn8fmhde/gvNOnRXrgJTMWmpJXkKL0c2Jb
         AC2Q==
X-Gm-Message-State: AOAM532EzJPmZA2UF0D63Y6WFA2H98yUggxbw/qoFCWjHFas4C0y5Gpw
        yGUvmcCNjKoNSxxKs7qAU1+YEQ==
X-Google-Smtp-Source: ABdhPJxPm6htEoUKSwOswdsFMcX5e4v/qBecaBM72I2IMfriqvK24S3gjgK5qPIxdiMrpxVvXsJwfQ==
X-Received: by 2002:a1c:a5c1:: with SMTP id o184mr5037595wme.132.1628699525282;
        Wed, 11 Aug 2021 09:32:05 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id z137sm6558329wmc.14.2021.08.11.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 09:32:04 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:32:03 +0100
From:   Jamie Iles <jamie@nuviainc.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH v1 05/20] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Message-ID: <YRP7g5/T2kJ9BypS@hazel>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-6-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729223610.29373-6-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jul 29, 2021 at 10:35:55PM +0000, James Morse wrote:
> To support resctrl's MBA software controller, the architecture must provide
> a second configuration array to hold the mbps_val from user-space.
> 
> This complicates the interface between the architecture code.
> 
> Make the filesystem parts of resctrl create an array for the mba_sc
> values when the struct resctrl_schema is created. The software controller
> can be changed to use this, allowing the architecture code to only
> consider the values configured in hardware.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 -
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 69 ++++++++++++++++++++++++++
>  include/linux/resctrl.h                | 13 +++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e12b55f815bf..a7e2cbce29d5 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -36,7 +36,6 @@
>  #define MBM_OVERFLOW_INTERVAL		1000
>  #define MAX_MBA_BW			100u
>  #define MBA_IS_LINEAR			0x4
> -#define MBA_MAX_MBPS			U32_MAX
>  #define MAX_MBA_BW_AMD			0x800
>  #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index cf0db0b7a5d0..185f9bb992d1 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2030,6 +2030,60 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **mon_data_kn);
>  
> +static int mba_sc_domain_allocate(struct rdt_resource *res,
> +				  struct rdt_domain *d)
> +{
> +	u32 num_closid = closid_free_map_len;
> +	int cpu = cpumask_any(&d->cpu_mask);
> +	int i;
> +
> +	d->mba_sc = kcalloc_node(num_closid, sizeof(*d->mba_sc),
> +				 GFP_KERNEL, cpu_to_node(cpu));
> +	if (!d->mba_sc)
> +		return -ENOMEM;

If a CPU was hotplugged before resctrl is mounted then isn't it possible 
for this to already be allocated?  I might be misunderstanding the flows 
here though...

> +	for (i = 0; i < num_closid; i++)
> +		d->mba_sc[i].mbps_val = MBA_MAX_MBPS;
> +
> +	return 0;
> +}
> +
> +static int mba_sc_allocate(struct rdt_resource *r)
> +{
> +	struct rdt_domain *d;
> +	int ret;
> +
> +	lockdep_assert_cpus_held();
> +
> +	if (!is_mba_sc(r))
> +		return 0;
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		ret = mba_sc_domain_allocate(r, d);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mba_sc_domain_destroy(struct rdt_resource *r,
> +				  struct rdt_domain *d)
> +{
> +	kfree(d->mba_sc);
> +	d->mba_sc = NULL;
> +}
> +
> +static void mba_sc_destroy(struct rdt_resource *r)
> +{
> +	struct rdt_domain *d;
> +
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(d, &r->domains, list)
> +		mba_sc_domain_destroy(r, d);
> +}
> +
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
>  	int ret = 0;
> @@ -2117,17 +2171,27 @@ static int schemata_list_create(void)
>  
>  		if (ret)
>  			break;
> +
> +		ret = mba_sc_allocate(r);
> +		if (ret)
> +			break;
>  	}
>  
>  	return ret;
>  }
>  
> +/*
> + * During rdt_kill_sb(), the mba_sc state is reset before
> + * destroy_schemata_list() is called: unconditionally try to free the
> + * array.
> + */
>  static void schemata_list_destroy(void)
>  {
>  	struct resctrl_schema *s, *tmp;
>  
>  	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
>  		list_del(&s->list);
> +		mba_sc_destroy(s->res);
>  		kfree(s);
>  	}
>  }
> @@ -3255,6 +3319,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  		__check_limbo(d, true);
>  		cancel_delayed_work(&d->cqm_limbo);
>  	}
> +	if (static_branch_unlikely(&rdt_enable_key) && is_mba_sc(r))
> +		mba_sc_domain_destroy(r, d);
>  	bitmap_free(d->rmid_busy_llc);
>  	kfree(d->mbm_total);
>  	kfree(d->mbm_local);
> @@ -3287,6 +3353,9 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  		}
>  	}
>  
> +	if (is_mba_sc(r))
> +		mba_sc_domain_allocate(r, d);

This looks to be missing an error check.

Thanks,

Jamie
