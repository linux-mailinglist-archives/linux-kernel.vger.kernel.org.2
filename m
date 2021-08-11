Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91DE3E9598
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhHKQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHKQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:11:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB8C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:10:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 203-20020a1c00d40000b02902e6a4e244e4so2365121wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wny9vyhe7x9w1XyyXnqMYIBIFak+X9iPgGD7ibd1xHI=;
        b=hQlBIBS5XXJxLYFxtmr0+EFj0Kdl8fP8sLheKRFbhlyJithKgMxkS9x3/wlgDODdAI
         9H56yqCc8SK0zAs7mVIjwLi44P+o/lLwgcHLgzumzrnf1MhlzPzt4ygOSpurrO15f6Xc
         JY2pP7LPY/xP3oOoJiOhdhMQ47tVn83fn4ELN6m9FVJVYfKATOS6sRYF4ZtwgRZ9qvEp
         uZ2QBXZn7EGLIPFp3i1jn1ZGSAv5Q1Zq+HlxWzmREJ0mrV36DxlZeYbbInd+g/bUXCYp
         z7yI5TrQl92Jdc4adoaMH5v/RuU/9sCdMqlFKoBOV5jD4UN5TO9vPfiP3FahuJgr1QOy
         iUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wny9vyhe7x9w1XyyXnqMYIBIFak+X9iPgGD7ibd1xHI=;
        b=hRefLDDrUCMpmV9w6hNG6cptCVaXqKy4ULazS/8q9AjKp27+oCAOjZXjHmq9yiyKfB
         5L6pPEnXEQs06RHkZrFbtBqRnL++AzvGoLzaEdMlvG7AOLb287QO/1jHfNpV3pRUXS5F
         CYJrizM6bPiSnZ9tl+pLcafSl3MSbkmMY/g+dmjxPCnsilbmEKmBOACEprLAtn5K50sA
         80HGwPIkscPHSw5JsbuMM5c93yT6CA6ZQ1hT9sP+74F3H/ZJUOKXY5xk7jQ/K7UpIbaV
         oXy8UhdZE92afnv5hJDRGyMJU81miMp1eU+csAXjhESSEb4KLB3C2NtcjvoJ7P/McRHk
         HX7A==
X-Gm-Message-State: AOAM533NmyoLIiLolwV3OsKXfL8hLdCQx1YlMeV7vw5vJYVFKLMlISjS
        MG78RT9YBosa9/LInjZ0S91Lfw==
X-Google-Smtp-Source: ABdhPJwFeaWpYSE9fkqhaYbNSfzVIcxe8QkzAWnHjWXhW/Y/jzBPtZs14+zxp7qdSjWrrQAxxA1mFA==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr9495111wml.42.1628698241505;
        Wed, 11 Aug 2021 09:10:41 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id x9sm6734498wmj.41.2021.08.11.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 09:10:40 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:10:39 +0100
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
Subject: Re: [PATCH v1 04/20] x86/resctrl: Add domain offline callback for
 resctrl work
Message-ID: <YRP2fzaEsqt1C4SW@hazel>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-5-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729223610.29373-5-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jul 29, 2021 at 10:35:54PM +0000, James Morse wrote:
> Because domains are exposed to user-space via resctrl, the filesystem
> must update its state when cpu hotplug callbacks are triggered.
> 
> Some of this work is common to any architecture that would support
> resctrl, but the work is tied up with the architecture code to
> free the memory.
> 
> Move the monitor subdir removal and the cancelling of the mbm/limbo
> works into a new resctrl_offline_domain() call.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 24 +---------------
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 --
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 +++++++++++++++++++++++---
>  include/linux/resctrl.h                |  1 +
>  4 files changed, 37 insertions(+), 29 deletions(-)
...
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e1af1d81b924..cf0db0b7a5d0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
...
> @@ -3229,6 +3227,39 @@ static int __init rdtgroup_setup_root(void)
>  	return ret;
>  }
>  
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex); // the arch code took this for us
> +
> +	if (!r->mon_capable)
> +		return;
> +
> +	/*
> +	 * If resctrl is mounted, remove all the
> +	 * per domain monitor data directories.
> +	 */
> +	if (static_branch_unlikely(&rdt_mon_enable_key))
> +		rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +
> +	if (r->mon_capable && is_mbm_enabled())
> +		cancel_delayed_work(&d->mbm_over);

There's a redundant r->mon_capable check here.

> +	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
> +		/*
> +		 * When a package is going down, forcefully
> +		 * decrement rmid->ebusy. There is no way to know
> +		 * that the L3 was flushed and hence may lead to
> +		 * incorrect counts in rare scenarios, but leaving
> +		 * the RMID as busy creates RMID leaks if the
> +		 * package never comes back.
> +		 */
> +		__check_limbo(d, true);
> +		cancel_delayed_work(&d->cqm_limbo);
> +	}
> +	bitmap_free(d->rmid_busy_llc);
> +	kfree(d->mbm_total);
> +	kfree(d->mbm_local);
> +}

Thanks,

Jamie
