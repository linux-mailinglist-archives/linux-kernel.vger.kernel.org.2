Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391E738B575
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhETRvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhETRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:51:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:49:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 76so17014470qkn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wnCevUZkueOstLHW1AR+QAWLP03GYm6cWFjqEuHEYGM=;
        b=VltoijMDIEpRVRY9l4HbfrI7BGbonOBsac4oFYuRIH/2XzCHlXMheQcqxsyieGVmd3
         RYKsDZR9DrFvtQQhrPbgzeUSR3BH8PI7JXEoIJktZJBqChWZ6ejMdKAMs0sy9MzjSM7Q
         MmzXyySIqsGszhgVQwbm/jjSdMitHM4MRziZO3g0djOwcNF2BG1fbGBz+mnznJGy9cyi
         9hGp7ggKIdlgfdrurwa4IRkJo49fg5RkbN5APqaiSPm8FZ1yjK2ZsTFrlpLEOwqTpswy
         H34W0Uu8ghb6KoBH6W8EsLQKTGZ3QsT51tncEUvkrHPBbsQzU8kbswMd4Q8pCi6V1dXk
         4qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnCevUZkueOstLHW1AR+QAWLP03GYm6cWFjqEuHEYGM=;
        b=lBaCJlNlzmYYw86v4BYDKL915Z9Miv1c0RU12YVQvpOsJoyeHBMIkJ0BItoLFA2Mj4
         05SRday+eI6eziFjO4ClD24o9Bu3sDWBrVpbcWvds4z6IoEXv7D8T8INH5D9GUeF2QWT
         g6j8+vPbANdJzIKsuLClPlGk8ZqGISWUhIjciENBV5z3PsiOvHklzicAEC47oCf/7TAN
         P5ySejxw1S7Ev1AwR2b4k/bTa1RpHUplAWw2PdTlPFXhmEwy5M+eNxCsDDWj47gyw7sy
         mcHzOtyu+LV/3SqVrNeEuIDr6RkGh918mBHwVhSOCfI/7Alb4F51IOWOzLhj0+G5BkuE
         llyg==
X-Gm-Message-State: AOAM530SvWljjMH9stWpRl2R3dyJ8/twevgSeuRsgam/2yaKajnGBKxU
        RGovMDmw2fT6W4OGElKUTm2h6w==
X-Google-Smtp-Source: ABdhPJyFy0sHlDam4B2F9bdQUSXGtggaa+v1VdI6qA9a2zyjmzAcFwO3W53jqtukcNIc+T1Ho3fwLQ==
X-Received: by 2002:a05:620a:3dd:: with SMTP id r29mr6463037qkm.468.1621532979915;
        Thu, 20 May 2021 10:49:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3178])
        by smtp.gmail.com with ESMTPSA id l4sm2384579qkp.48.2021.05.20.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:49:38 -0700 (PDT)
Date:   Thu, 20 May 2021 13:49:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
Message-ID: <YKahMXCwDRlBksAU@cmpxchg.org>
References: <20210519013313.1274454-1-ying.huang@intel.com>
 <YKUlfeAiq/vv+dHl@cmpxchg.org>
 <87r1i28ahm.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <YKW/ix3Yg5HRuBaC@cmpxchg.org>
 <87im3e88ss.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im3e88ss.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 09:59:15AM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > On Thu, May 20, 2021 at 09:22:45AM +0800, Huang, Ying wrote:
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> 
> >> > On Wed, May 19, 2021 at 09:33:13AM +0800, Huang Ying wrote:
> >> >> diff --git a/mm/memory.c b/mm/memory.c
> >> >> index b83f734c4e1d..2b6847f4c03e 100644
> >> >> --- a/mm/memory.c
> >> >> +++ b/mm/memory.c
> >> >> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >> >>  				munlock_vma_page(old_page);
> >> >>  			unlock_page(old_page);
> >> >>  		}
> >> >> +		if (page_copied && PageSwapCache(old_page) &&
> >> >> +		    !page_mapped(old_page) && trylock_page(old_page)) {
> >> >> +			try_to_free_idle_swapcache(old_page);
> >> >> +			unlock_page(old_page);
> >> >
> >> > If there are no more swap or pte references, can we just attempt to
> >> > free the page right away, like we do during regular unmap?
> >> >
> >> > 		if (page_copied)
> >> > 			free_swap_cache(old_page);
> >> > 		put_page(old_page);
> >> 
> >> A previous version of the patch does roughly this.
> >> 
> >> https://lore.kernel.org/lkml/20210113024241.179113-1-ying.huang@intel.com/
> >> 
> >> But Linus has concerns with the overhead introduced in the hot COW path.
> >
> > Sorry, I had missed that thread.
> >
> > It sounds like there were the same concerns about the LRU shuffling
> > overhead in the COW page. Now we have numbers for that, but not the
> > free_swap_cache version. Would you be able to run the numbers for that
> > as well? It would be interesting to see how much the additional code
> > complexity buys us.
> 
> The number for which workload?  The workload that is used to evaluate
> this patch?

Yeah, the pmbench one from the changelog.
