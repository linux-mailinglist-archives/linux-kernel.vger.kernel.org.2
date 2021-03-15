Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37C33A8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCOAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCOAD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:03:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:03:59 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id w11so5863926iol.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5awGwLT+/wrAkwuHT0oLGATitjYm81mdUztjiIyC4eE=;
        b=bRm7HpJ8zjWzV5z0RlBsJuTUxs6SUoyO2/6YAQtw4QA9PlRmT5eDBKBHc0kUXYwWvQ
         /USrISGagPhndaoM4af5HNB3rd6yinl5BBvgojwzzektuQkAAHHTykd5C6TKZTbFHH3k
         2A0YD7qBc/EhDZow3l0PojzycVgvH/bucbqF6UErDQagXz2TOxywDbbbXwiu3Is39co8
         OSXGoSDE51sYDqlXLok0Z5kvN10NpZ+KpR/xCxpW4AttmCQhRLQ39iFq5m5YsGixzzCH
         rrZZiMNLQEf+TmfaI9sDlbx9ePA01U1UXBS9RTVyOKrKdZJfxw3KtDf9TyREGgBhhZAZ
         d+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5awGwLT+/wrAkwuHT0oLGATitjYm81mdUztjiIyC4eE=;
        b=NVwO/Kmzltb9YHr8ETSEq9LSogywoM4pzHXCozgwvJ1TMHeFCQT1yCKySdA2cTi59+
         nobA3Yi8XOw9nhOOCHyaSRAYgbOpJwF0qkHVIahy3vPh98lViPt6n4MfbJTy6OndEPMt
         TGeZbob8eQKRX3CKhUUG7Hm6WoHhQnriot4Q9jqU7C1bImvKGqnPIWwqHtSHvPQj5Sde
         42Zo3R2dJilKoiy8oU/LEivGKl5frZad1QHaPKP10uVElTG6OqnfD2sxH07PPdLfuN56
         EaGocHu454Y6dSDVTERPGS4ZT82oOO/EbHQtbdzZ8PtQy1jZxYmwUm9z/R3HenyJ5aVr
         JjsQ==
X-Gm-Message-State: AOAM533hTZwYMcoGZ4FqjoPuIK5MY3/CQ9+kg/rsfISbS+0tmHCqC40L
        3f7S3jiDQMS9WtqYTEnB8zn1Ow==
X-Google-Smtp-Source: ABdhPJyOoRHjtPd3DoEsugJyzaQv5ojfAOnEbMdclww6O0RQ8JTng4cv/JosRjhQyBpM4FXwDflR2A==
X-Received: by 2002:a02:9663:: with SMTP id c90mr7531038jai.16.1615766638270;
        Sun, 14 Mar 2021 17:03:58 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4d84:eb70:5c32:32b8])
        by smtp.gmail.com with ESMTPSA id p13sm6943059ilp.1.2021.03.14.17.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 17:03:57 -0700 (PDT)
Date:   Sun, 14 Mar 2021 18:03:53 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
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
Message-ID: <YE6kacDMLga/kfvf@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-7-yuzhao@google.com>
 <74C83FFE-DC78-40CD-B6BE-00614DC8F125@nvidia.com>
 <20210314225103.GQ2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314225103.GQ2577561@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 10:51:03PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 14, 2021 at 06:12:42PM -0400, Zi Yan wrote:
> > On 13 Mar 2021, at 2:57, Yu Zhao wrote:
> > 
> > > Some architectures support the accessed bit on non-leaf PMD entries
> > > (parents) in addition to leaf PTE entries (children) where pages are
> > > mapped, e.g., x86_64 sets the accessed bit on a parent when using it
> > > as part of linear-address translation [1]. Page table walkers who are
> > > interested in the accessed bit on children can take advantage of this:
> > > they do not need to search the children when the accessed bit is not
> > > set on a parent, given that they have previously cleared the accessed
> > > bit on this parent in addition to its children.
> > >
> > > [1]: Intel 64 and IA-32 Architectures Software Developer's Manual
> > >      Volume 3 (October 2019), section 4.8
> > 
> > Just curious. Does this also apply to non-leaf PUD entries? Do you
> > mind sharing which sentence from the manual gives the information?
> 
> The first few sentences from 4.8:
> 
> : For any paging-structure entry that is used during linear-address
> : translation, bit 5 is the accessed flag. For paging-structure
> : entries that map a page (as opposed to referencing another paging
> : structure), bit 6 is the dirty flag. These flags are provided for
> : use by memory-management software to manage the transfer of pages and
> : paging structures into and out of physical memory.
> 
> : Whenever the processor uses a paging-structure entry as part of
> : linear-address translation, it sets the accessed flag in that entry
> : (if it is not already set).

As far as I know x86 is the one that supports this.

> The way they differentiate between the A and D bits makes it clear to
> me that the A bit is set at each level of the tree, but the D bit is
> only set on leaf entries.

And the difference makes perfect sense (to me). Kudos to Intel.
