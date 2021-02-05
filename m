Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F33311A56
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhBFDki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBFCcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932FBC0698D2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:28:10 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a16so4282517plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0CThZisk8ypQGjJO6x1LhHL7Xhm/PdgdSDv39h3UwsE=;
        b=kfZf/3+weJ8zVno0BYKgnjRpYC81thjaKMZAsYaxC+Xv4UfuDcUIKDg0soTXizlRQh
         ujNDcloW52Kjq3Kt0DK08lZIlPneGikcstO31NRpkGQTzV3HQ93UIAMFy4eLJkW/XOsN
         rPcr2gIDi/kRqCmMbER9s+G8hqfoj2TLnrepBRsGksMH2yYpj/TQH1r2yWBZTnwjH2Yh
         FU7nj8sCNYHjlNqYU4NBTdQXtCFN8wVNQ9suoS7Y6FoDd5iyVcGev1uWLaZiM/dqMaYG
         qTmBr7QvxSwrzyTpli/TD7f2KVO91TJiREN3vatXv+q5NdGdb+vGqxiroZz6PWG0wyIX
         IvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0CThZisk8ypQGjJO6x1LhHL7Xhm/PdgdSDv39h3UwsE=;
        b=iQsKqekv4U4kBE8L4O4pzrfbVYbknq9JQyB0FjuyBy3RFGoCBLXyMCHHDvsXq/MWXC
         1yk+My9I7ptQC2nte5Qnor8yPVdEBuUfMIaU9YHca5jABbCcmE0FdUPlAklI833+1elI
         OlPlZIY51E/8AYMkizK0HnSGfPWuh0XgTOTSw99Hl63xCWBAnxNBJCGH9p3MVYsA0eGS
         wb4gqImdsyFriGhueh036qTLC1oiX9o1svE3Vp/DXLCPkCFrdl6Mp4nRLejBhsvebE46
         zrCZGl/XgRpMj+N0PPWXYIgAoEuh80IYXtmgxA9m6vwE8WE7Hw584NgaSnfi3hrBpegt
         K1Qw==
X-Gm-Message-State: AOAM530UG7fzH+D/8ohpaRCeHJlKhHAdUCRwdHijNpH6T+NYIDGfacfW
        qx4d/9DpT3Qc2HEEVp+5F7IkTXirVFbAug==
X-Google-Smtp-Source: ABdhPJxSVQe+yUAaLkMTiBzc/R0XsRwjAVkpN3+DgaCr016qPC6alZV15o2OMeyY6o6pm7xih6C+Jw==
X-Received: by 2002:a17:902:b411:b029:e0:8f0:5ba with SMTP id x17-20020a170902b411b02900e008f005bamr6124016plr.19.1612564089949;
        Fri, 05 Feb 2021 14:28:09 -0800 (PST)
Received: from [2620:15c:17:3:71b0:f7a6:59ec:6ab3] ([2620:15c:17:3:71b0:f7a6:59ec:6ab3])
        by smtp.gmail.com with ESMTPSA id s21sm11115691pga.12.2021.02.05.14.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:28:09 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:28:08 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Kalla <charante@codeaurora.org>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: update the COMPACT[STALL|FAIL] events
 properly
In-Reply-To: <160ba3b5-2cd4-5ff0-1348-fb477cefd33d@codeaurora.org>
Message-ID: <1213f4c6-7557-268d-253e-23f8fea55b19@google.com>
References: <1612187338-19100-1-git-send-email-charante@codeaurora.org> <d9d1dd7b-1fe7-67b6-6ba4-fb1a6faa8fae@google.com> <160ba3b5-2cd4-5ff0-1348-fb477cefd33d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021, Charan Teja Kalla wrote:

> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 519a60d..531f244 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -4152,6 +4152,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
> >>  	memalloc_noreclaim_restore(noreclaim_flag);
> >>  	psi_memstall_leave(&pflags);
> >>  
> >> +	if (*compact_result == COMPACT_SKIPPED)
> >> +		return NULL;
> >>  	/*
> >>  	 * At least in one zone compaction wasn't deferred or skipped, so let's
> >>  	 * count a compaction stall
> > 
> > This makes sense, I wonder if it would also be useful to check that 
> > page == NULL, either in try_to_compact_pages() or here for 
> > COMPACT_SKIPPED?
> 
> In the code, when COMPACT_SKIPPED is being returned, the page will
> always be NULL. So, I'm not sure how much useful it is for the page ==
> NULL check here. Or I failed to understand your point here?
> 

Your code is short-circuiting the rest of  __alloc_pages_direct_compact() 
where the return value is dictated by whether page is NULL or non-NULL.  
We can't leak a captured page if we are testing for it being NULL or 
non-NULL, which is what the rest of __alloc_pages_direct_compact() does 
*before* your change.  So the idea was to add a check the page is actually 
NULL here since you are now relying on the return value of 
compact_zone_order() to be COMPACT_SKIPPED to infer page == NULL.

I agree that's currently true in the code, I was trying to catch any 
errors where current->capture_control.page was non-NULL but 
try_to_compact_pages() returns COMPACT_SKIPPED.  There's some complexity 
here.

So my idea was the expand this out to:

	if (*compact_result == COMPACT_SKIPPED) {
		VM_BUG_ON(page);
		return NULL;
	}
