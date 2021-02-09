Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBC315BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhBJBMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhBIWYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:24:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90132C0698D7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:22:10 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v206so8109404qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqilSyANb2yKNyp5C84XuLtT56SS42oSdtYgcD/KNKI=;
        b=rkk64bC3gUH20iyUq9lXg4/whibac5PNI6g9rBOp/8JLjQAVtEYBgWUgOCQhrhwtc1
         nAYoOFQubJbwTa+qzQi04ksycVdMK7LMFKIuj/KfCuI09ixolgbSeqL+kbpbbHgFCIMN
         LgoivRNKmLXSTnErsEeVwHAEirhpvARnUmcLCfE1DgMyssikk94rhdpjgupMncATxIuo
         E5f8h5UaTQrw68w6sBS1VAunb/YpnJt4rznlF++DYpFiflpSboc8me+f7BlJn5SsFzLj
         zC20W6+7uQ9DJ+W7ujnSd8tfu/irV2V6J2IjSaoLbFjMDUjbuXO1ncNnouv3F8M4H50i
         CxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqilSyANb2yKNyp5C84XuLtT56SS42oSdtYgcD/KNKI=;
        b=eA/+bpzLANarRFz0QQv4BQ/G5wpApV75XK5dGhSvcDWwSJ/yXabZtpAAfWVBkjpIjy
         aBPDxewRuMdFJPtgG/2KOvSkV8iQAVpM60IRW6u2u9Sb+7JuCJVob/wLOI5YQWOwmzTc
         Tkp5aOHNak/UIq9iLw1tOsugdvycRqVRGi+/JHMUNGhJOhQo2JMLj/g9Q9qMxCty3fIQ
         2YyEGeTnipqrk2lro7Teu4wL3vg2CjrNpba8BFUFdefXsRWtY1bIX+8OXoDqWSRxtjFq
         11E1CDJ2MftWNDNPamWMky8S3BKFf1FxeVujifKCvbzvCEjRfkVL7MYkh4Mz9ZHzdUWx
         Ajpg==
X-Gm-Message-State: AOAM532RprZGVkDVc+aCzFDspl3km0qxlTCip+ErA56J46nLkC+5okwg
        snxbzzhaMJAPuEvA3LSZR6Rbsi0VCLW3UQ==
X-Google-Smtp-Source: ABdhPJz4Zr6dJzukGC3DYAKKOMDeZ70xNoCDbVRx+hX2r3XTqUWEDeBvBquPHQaBI4BhKc9KU0ZbMw==
X-Received: by 2002:a05:620a:2239:: with SMTP id n25mr412298qkh.46.1612909329847;
        Tue, 09 Feb 2021 14:22:09 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t8sm48886qkt.125.2021.02.09.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:22:09 -0800 (PST)
Date:   Tue, 9 Feb 2021 17:22:08 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: Fix missing mem cgroup soft limit tree updates
Message-ID: <YCMLEB/2IscnaGGh@cmpxchg.org>
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
 <3b6e4e9aa8b3ee1466269baf23ed82d90a8f791c.1612902157.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6e4e9aa8b3ee1466269baf23ed82d90a8f791c.1612902157.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

On Tue, Feb 09, 2021 at 12:29:47PM -0800, Tim Chen wrote:
> @@ -6849,7 +6850,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	 * exclusive access to the page.
>  	 */
>  
> -	if (ug->memcg != page_memcg(page)) {
> +	if (ug->memcg != page_memcg(page) ||
> +	    /* uncharge batch update soft limit tree on a node basis */
> +	    (ug->dummy_page && ug->nid != page_to_nid(page))) {

The fix makes sense to me.

However, unconditionally breaking up the batch by node can
unnecessarily regress workloads in cgroups that do not have a soft
limit configured, and cgroup2 which doesn't have soft limits at
all. Consider an interleaving allocation policy for example.

Can you please further gate on memcg->soft_limit != PAGE_COUNTER_MAX,
or at least on !cgroup_subsys_on_dfl(memory_cgrp_subsys)?

Thanks
