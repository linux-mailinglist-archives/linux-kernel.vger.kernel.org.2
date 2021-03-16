Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19E33E082
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCPV3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCPV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:29:27 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:29:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b5so14074273ilq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tzU2FBGLVgsAwsa24/PHLvin+0F6bwNLVKxARgFVukY=;
        b=Iyz2Zs1s28Fl10igpCVQyq6ndVLdYNk6mPsmV3FwXdNPfiRN0FBiGQarEo4oH7RscU
         4TkyWXtlMyPudsn/OCsnQkGfYqxEQSO8Fmbhu8HHNWcoq4Z7jVkgCZrl4Z8DKjX/TGdZ
         V2kASyslsKMVlWSDu/KB9gfs0VopOGsItsU2JNPyDmN6Do8muARVKDD1Yn+Ch7kjP6WR
         jOr7y/xo9X5TO83g5wavYLgmj/cyABZeSp+04slQZSxqIQa9Sd2JBpiWJzoiNCnUkRbi
         E28S9luOXIq5FJjeVqm+X+nYFXIfWnsA/ifeNT2kHweUYGEuZsb4XbTyHer6ef1vvEjF
         io/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tzU2FBGLVgsAwsa24/PHLvin+0F6bwNLVKxARgFVukY=;
        b=LeNxfLVInIUKBE6UyMRwYk+xbhDnr/u+zVpJLoyqUeKlYW7rJ0dQzRasMD7Sdow1og
         U0sAxDKYOJgtedYKTnuf8kOLuV9ocvxT7h9G+MoUTpv9S7FfDJKt+kp1L+mVWqsaZ+Py
         SfC1pdpkIKAFfr7vvOSN/cpMSqM3ySxoUlPW0ncWa2GLY5Uz8++redsdw2JTGNwfkpQX
         GQWbn8wytiEOr3SQ/gZaohLKS5gHzCpHWUGW+VnTOT3v0AFt3tgjxE5d6y4IZVF4aSkr
         Uowoc4AuLvn1z5FSLPn71OJBZ8XkS0d8eI6kKGEXN16lRV/+h1kidrRpsWynRG8C9lqf
         ATrw==
X-Gm-Message-State: AOAM531VWZGCE+Ym/5b17qxKuZWvzELokRtym072ZeApUsnLi9+kikoi
        12Js6GfJR1/Wlz0ol0Sm0MwREg==
X-Google-Smtp-Source: ABdhPJyEKrKhe5XXeDVQv7JPQKsd1QHmrjTmuHKTJS+x8m8ZEtoBVhwNXiT5smUnWhRmJbIzzyLBqA==
X-Received: by 2002:a92:7306:: with SMTP id o6mr5508056ilc.2.1615930165923;
        Tue, 16 Mar 2021 14:29:25 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:85db:6a0d:7a4d:5606])
        by smtp.gmail.com with ESMTPSA id t14sm9971955ilq.13.2021.03.16.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:29:25 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:29:20 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 11/14] mm: multigenerational lru: page activation
Message-ID: <YFEjMCeVv9MARvp3@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-12-yuzhao@google.com>
 <20210316163437.GB3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316163437.GB3420@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:34:37PM +0000, Matthew Wilcox wrote:
> On Sat, Mar 13, 2021 at 12:57:44AM -0700, Yu Zhao wrote:
> > In the page fault path, we want to add pages to the per-zone lists
> > index by max_seq as they cannot be evicted without going through
> > the aging first. For anon pages, we rename
> > lru_cache_add_inactive_or_unevictable() to lru_cache_add_page_vma()
> > and add a new parameter, which is set to true in the page fault path,
> > to indicate whether they should be added to the per-zone lists index
> > by max_seq. For page/swap cache, since we cannot differentiate the
> > page fault path from the read ahead path at the time we call
> > lru_cache_add() in add_to_page_cache_lru() and
> > __read_swap_cache_async(), we have to add a new function
> > lru_gen_activate_page(), which is essentially activate_page(), to move
> > pages to the per-zone lists indexed by max_seq at a later time.
> > Hopefully we would find pages we want to activate in lru_pvecs.lru_add
> > and simply set PageActive() on them without having to actually move
> > them.
> > 
> > In the reclaim path, pages mapped around a referenced PTE may also
> > have been referenced due to spatial locality. We add a new function
> > lru_gen_scan_around() to scan the vicinity of such a PTE.
> > 
> > In addition, we add a new function page_is_active() to tell whether a
> > page is active. We cannot use PageActive() because it is only set on
> > active pages while they are not on multigenerational lru. It is
> > cleared while pages are on multigenerational lru, in order to spare
> > the aging the trouble of clearing it when an active generation becomes
> > inactive. Internally, page_is_active() compares the generation number
> > of a page with max_seq and max_seq-1, which are active generations and
> > protected from the eviction. Other generations, which may or may not
> > exist, are inactive.
> 
> If we go with this multi-LRU approach, it feels like PageActive and
> PageInactive should go away as tests.  We should have a LRU field in
> the page flags with some special values:
> 
>  - Not managed through LRU list
>  - Not currently on any LRU list
>  - Unevictable
>  - Active list 1
>  - Active list 2
>  - ...
>  - Active list 5
> 
> Now you don't need any extra bits in the page flags.  Or if you want to
> have 13 lists instead of 5, you can use just one extra bit.  I'm not
> quite sure whether it makes sense to have that many lists, so I need
> to try to understand that better.

Yes, and this would be a lot cleaner. PG_{lru,unevictable,active,
referenced,reclaim,workingset,young,idle} could all go away. Look how
many bits we've added just for page reclaim. Sigh...

> I'd like to echo the comments from others that it'd be nice to split apart
> the multigenerational part of this and the physical scanning part of this.
> It's possible they don't make performance sense without each other,
> but from a review point of view, they seem entirely separate things.

Thanks for noticing. I do plan to see if the page table scanning part
could be better refactored. (I cut some corners by squashing it while
rebasing to latest kernel.)
