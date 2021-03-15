Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4033A93B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 02:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCOBFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCOBEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:04:52 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:04:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h18so7886754ils.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aAXz8eb+v2Zd51ASzlIswe8D5zMlueWA5CeLpEroo+4=;
        b=STey9XLF2Yb47zgO895takcZ0V7enD0LHmc59PdqvqqjjddLEaWdK84pqPEPNZa0Xy
         GXpsNX9mOtWCbQYXmqQMKYtsKXhB83HCuuLnCqyjBGtMSc/dtn9zeySQIH42P7fVZp5W
         kzxGlg8hpFAErlGCT2H1j2iu12GHxjlIi7xys5GuL7mTmw+lFWvw6igXXUJVEtsNCSnW
         JRS+VfX2qMaE4DAV2OI2i3+GjLFKw82R5Pi+WX8AQKzyL2yedx3iggG+VL+SX+/LY4Tl
         W+GUYpyV4LuBDKq9pZIgUO1d7sA0lMYrqWNM4nA0HYbvLGAXpqF8wTYSnWrC3m3YJqJZ
         zPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aAXz8eb+v2Zd51ASzlIswe8D5zMlueWA5CeLpEroo+4=;
        b=LEbHTnzcwrPAYCnfPvJ2F3LCvd+YXiWF+Gc8sTh0atzKI37DJALggQqBCJNzv1uRgr
         QFnDbOV73C384GSjvPo7TG4WPDvfFhBfh0pg8NNY2uxo4FvGd1Y7iDFYl7jBcgtjc2JD
         GH7abB1VUn6xym8zU5Gq8CC71bjOO/IfBJgHzotgT/bDLz63114VvvJYtyLFiNjAbCtF
         ZiAlCAFt+n/ek5KcTg3ALzVHVAFfZ/fqxC31P9STb6KfcEyLALrK7G36PqyGuUS3krD+
         ullhf1IqSlnX7jOav9ORDuZa0Enjcpe6ejRuZBcd5FfNOEFcvvellCjO6NIvPRRdEABv
         Xtog==
X-Gm-Message-State: AOAM530L74IfuURpKQXBFiLuFuQS/NMuSNX46eI/wTUieswhhKhYl0I7
        MZHZCNZotnwwwxF35fdtQ3RKJw==
X-Google-Smtp-Source: ABdhPJxaWwNE2jcuLtNghjyUlNQD+ZViU4UuvsTyIpOuocSqtE4Gk4ltQ6fXH+yJS1UX3tSHJzD8oQ==
X-Received: by 2002:a05:6e02:802:: with SMTP id u2mr9407801ilm.298.1615770291601;
        Sun, 14 Mar 2021 18:04:51 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4d84:eb70:5c32:32b8])
        by smtp.gmail.com with ESMTPSA id l14sm6981976ilc.33.2021.03.14.18.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 18:04:50 -0700 (PDT)
Date:   Sun, 14 Mar 2021 19:04:45 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
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
Subject: Re: [PATCH v1 06/14] mm, x86: support the access bit on non-leaf PMD
 entries
Message-ID: <YE6yrQC1Ps195wPw@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-7-yuzhao@google.com>
 <74C83FFE-DC78-40CD-B6BE-00614DC8F125@nvidia.com>
 <20210314225103.GQ2577561@casper.infradead.org>
 <YE6kacDMLga/kfvf@google.com>
 <3465DA3A-B735-4657-A1E0-89CF5DE0D4FF@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3465DA3A-B735-4657-A1E0-89CF5DE0D4FF@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 08:27:29PM -0400, Zi Yan wrote:
> On 14 Mar 2021, at 20:03, Yu Zhao wrote:
> 
> > On Sun, Mar 14, 2021 at 10:51:03PM +0000, Matthew Wilcox wrote:
> >> On Sun, Mar 14, 2021 at 06:12:42PM -0400, Zi Yan wrote:
> >>> On 13 Mar 2021, at 2:57, Yu Zhao wrote:
> >>>
> >>>> Some architectures support the accessed bit on non-leaf PMD entries
> >>>> (parents) in addition to leaf PTE entries (children) where pages are
> >>>> mapped, e.g., x86_64 sets the accessed bit on a parent when using it
> >>>> as part of linear-address translation [1]. Page table walkers who are
> >>>> interested in the accessed bit on children can take advantage of this:
> >>>> they do not need to search the children when the accessed bit is not
> >>>> set on a parent, given that they have previously cleared the accessed
> >>>> bit on this parent in addition to its children.
> >>>>
> >>>> [1]: Intel 64 and IA-32 Architectures Software Developer's Manual
> >>>>      Volume 3 (October 2019), section 4.8
> >>>
> >>> Just curious. Does this also apply to non-leaf PUD entries? Do you
> >>> mind sharing which sentence from the manual gives the information?
> >>
> >> The first few sentences from 4.8:
> >>
> >> : For any paging-structure entry that is used during linear-address
> >> : translation, bit 5 is the accessed flag. For paging-structure
> >> : entries that map a page (as opposed to referencing another paging
> >> : structure), bit 6 is the dirty flag. These flags are provided for
> >> : use by memory-management software to manage the transfer of pages and
> >> : paging structures into and out of physical memory.
> >>
> >> : Whenever the processor uses a paging-structure entry as part of
> >> : linear-address translation, it sets the accessed flag in that entry
> >> : (if it is not already set).
> 
> Matthew, thanks for the pointer.
> 
> >
> > As far as I know x86 is the one that supports this.
> >
> >> The way they differentiate between the A and D bits makes it clear to
> >> me that the A bit is set at each level of the tree, but the D bit is
> >> only set on leaf entries.
> >
> > And the difference makes perfect sense (to me). Kudos to Intel.
> 
> Hi Yu,
> 
> You only introduced HAVE_ARCH_PARENT_PMD_YOUNG but no HAVE_ARCH_PARENT_PUD_YOUNG.
> Is it PUD granularity too large to be useful for multigenerational LRU algorithm?

Oh, sorry. I overlooked this part of the question.

Yes, you are right. We found no measurable performance difference
between using and not using the accessed bit on non-leaf PUD entries.

For the PMD case, the difference is tiny but still measurable on small
systems, e.g., laptops with 4GB memory. It's clear (a few percent in
kswapd) on servers with tens of GBs of 4KB pages.
