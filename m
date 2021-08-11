Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27103E969C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhHKROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhHKROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:14:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F9C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:14:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n32so1637573wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QpIwet/AC5O/k59FR7WwXyPuguJVSQeI19QTbcjpwJI=;
        b=Et52sF1oYhbifOVvT3mL2hpDxRCwoUnBVLBB38VGkvSqgT0cDSjaM1AKpAjR7xOWqm
         JL/AfidsVfujOA5thwHkuVrZZrnZUICqRvvKbylhGy0mz2vY41cQrJjB7RqKGHfYPCez
         Mgz5l0CQ/g6kmd3nJWgkheuew/6AAXLDUFq2rQhjBeR7JsfuL7JmMipXSZu9+iBsaXr5
         5x6BdWoGWhUXAINWldhs2lrwTGyITsmBzrXWoSydLDYXL/fbr+GtcKHjOP7SLPL1SPCn
         BWYAN2Ct4cix8HxFTGTEAwxddo/pjmhy5R5wd21YZ7V2kVOxh/arypfjCD7/GhLnwns9
         24NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpIwet/AC5O/k59FR7WwXyPuguJVSQeI19QTbcjpwJI=;
        b=WGzyJ6k1K2KIsSCoSYmuPrZE7aPvNJ48WiVViokIN17sxuatNAofHC/00zWbq+JG07
         sIUjNq61EKfxYPtO5d24xww7E3RNV4o6yhKsnqc99SVEtlQK4udkiHUEJI23HcUfGuh/
         c2Q4pb4wRjiX5eHdEqaliZuWx0RyNwodUdfvUxu5y36f/uZykElwOxwxqhpyFPiogz6O
         KpcAdv4vuoEZPjG007s1kqVP8dJoMe9nySXioTEM20jGOixZPwmscjHWVHxUpb7ECu8D
         SNoCXfdiU6ExvaJFGNRpgfl3jJ426o+sUvdlg79Xgq/katTVgDCZdjI/P3Y2nICvl8IV
         youQ==
X-Gm-Message-State: AOAM533o21dfamRaFH7JODwvtuJj31GWjp87WQmBBPec69riIrKBWp50
        VSrOHhfwSYMRv62iZbjtYX3HdA==
X-Google-Smtp-Source: ABdhPJy6EtFmTBxXJgAxX1gCvQaQesMvWNx3RHI9duUuqQ7akaQlEM/XDd3aHkl0q2AWBK+uG3QN+w==
X-Received: by 2002:a1c:2090:: with SMTP id g138mr9198667wmg.98.1628702054387;
        Wed, 11 Aug 2021 10:14:14 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id p2sm28010773wrr.21.2021.08.11.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:14:13 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:14:11 +0100
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
Subject: Re: [PATCH v1 12/20] x86/recstrl: Add per-rmid arch private storage
 for overflow and chunks
Message-ID: <YRQFY+/vwsfTBeTd@hazel>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-13-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729223610.29373-13-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jul 29, 2021 at 10:36:02PM +0000, James Morse wrote:
> resctrl_arch_rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a counter. Currently the function returns
> the mbm values in chunks directly from hardware. For bandwidth
> counters the resctrl filesystem provides the number of bytes
> ever seen. Internally mba_sc uses a second prev_bw_msr to calculate
> the bytes read since the last mba_sc invocation.
> 
> MPAM's scaling of counters can be changed at runtime, reducing the
> resolution but increasing the range. When this is changed the prev_msr
> values need to be converted by the architecture code.
> 
> Add storage for per-rmid private storage. The prev_msr and chunks
> values will move here to allow resctrl_arch_rmid_read() to always
> return the number of bytes read by this counter.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 29 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h | 13 ++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 8a3c13c6c19f..27c93d12ca27 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -432,6 +432,28 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> +{
> +	size_t tsize;
> +
> +	if (is_mbm_total_enabled()) {
> +		tsize = sizeof(*hw_dom->arch_mbm_total);
> +		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
> +		if (!hw_dom->arch_mbm_total)
> +			return -ENOMEM;
> +	}
> +	if (is_mbm_local_enabled()) {
> +		tsize = sizeof(*hw_dom->arch_mbm_local);
> +		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
> +		if (!hw_dom->arch_mbm_local) {
> +			kfree(hw_dom->arch_mbm_total);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -481,6 +503,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> +	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +		kfree(d);

Does this error path and subsequent ones in domain_add_cpu also need to 
undo the allocations from arch_domain_mbm_alloc?

Thanks,

Jamie
