Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2933CC59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhCPD5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhCPD5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:57:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:57:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id w11so9973320iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qa8CZwJOeZFJUfkuJ5OjeuaRp9kzYHq6lZBFu2jA+Gw=;
        b=K6nq/jUY0UMPI4TsIymeF0yspJqJuN1e2Z/ELnVv5em0SXtGDAABy7ex9PGaTNWwSl
         N1Fq6HTh6rmKDN3STw8c2mhsUy7YH6cKAPaIiEOI9GVz0Lh+liGEC7CSGEnnSG6YIEat
         JCmYLtK7lOXFqGwBjPrEKy4YWNkKIwX/H+BY9U/nrbu1dIbmOQI49D77iPSweFNlLspI
         YWzk8P7mgvaos+kVOn3k1gezit5F1w6aSLY0QPGjjqAMCBilHvtlNvjK6pCPt1ufWI3s
         0LegBteUZudjGDyj7eQ/2NqYTKnqdQBmHtYLD9yFbEUP3fFmrlJIrh4norJ0TtqqwnSL
         641g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qa8CZwJOeZFJUfkuJ5OjeuaRp9kzYHq6lZBFu2jA+Gw=;
        b=cLgH4Mha5AnoqWZonlKnqyjvv5BxPVPPJr+XaWSYueD009Z/qnkYq0RNprkfcuZmnk
         HVtLD4HdhPJo7Ox9ocE2SQTvtuWQ5PyYU6H/xreRwc3JyqsflTkOIS8xJCsCsiWmfzzV
         XXvF2jH0znfbwqFPIrPgslLKUcs7qp0lh6ICIsMsf5/zMLJiCl55JKRDZ3WJqRcVpLlr
         HYtK7bqVNHvZy6JeWmBanSzLeBcFS1lDd6qG2rIgaCZEQHHoO7hqNBwF2WVIQq+UrnJk
         lDFS3NFBPLfXanlIvK2dKeZquKy4+i3r9RIj7fa9FzS1bSepXJlqTn7bMcmhwjbmlHMB
         4czQ==
X-Gm-Message-State: AOAM5304+7Mite0wXgndhylSz3Z+2ahreyaKoOxsXDTbVN0ESft+P7aw
        AfZxsxaK7HorBxZNI8c5PlOfbg==
X-Google-Smtp-Source: ABdhPJwNp0pcHttp9QW2yxQMvwq4OEcBYKJA/vZFr+ygOrf1wEU5FGRF8D/a5+9oMEQRgREz3ckO7Q==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr1932727iot.186.1615867026137;
        Mon, 15 Mar 2021 20:57:06 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:d825:37a2:4b55:995f])
        by smtp.gmail.com with ESMTPSA id y13sm6447282ioc.36.2021.03.15.20.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 20:57:05 -0700 (PDT)
Date:   Mon, 15 Mar 2021 21:57:00 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 09/14] mm: multigenerational lru: mm_struct list
Message-ID: <YFAsjP7NIZM5Ld+m@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-10-yuzhao@google.com>
 <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
 <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:07:36AM +0800, Huang, Ying wrote:
> Rik van Riel <riel@surriel.com> writes:
> 
> > On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:
> >
> >> +/*
> >> + * After pages are faulted in, they become the youngest generation.
> >> They must
> >> + * go through aging process twice before they can be evicted. After
> >> first scan,
> >> + * their accessed bit set during initial faults are cleared and they
> >> become the
> >> + * second youngest generation. And second scan makes sure they
> >> haven't been used
> >> + * since the first.
> >> + */
> >
> > I have to wonder if the reductions in OOM kills and 
> > low-memory tab discards is due to this aging policy
> > change, rather than from the switch to virtual scanning.

There are no policy changes per se. The current page reclaim also
scans a faulted-in page at least twice before it can reclaim it.
That said, the new aging yields a better overall result because it
discovers every page that has been referenced since the last scan,
in addition to what Ying has mentioned. The current page scan stops
stops once it finds enough candidates, which may seem more
efficiently, but actually pays the price for not finding the best.

> If my understanding were correct, the temperature of the processes is
> considered in addition to that of the individual pages.  That is, the
> pages of the processes that haven't been scheduled after the previous
> scanning will not be scanned.  I guess that this helps OOM kills?

Yes, that's correct.

> If so, how about just take advantage of that information for OOM killing
> and page reclaiming?  For example, if a process hasn't been scheduled
> for long time, just reclaim its private pages.

This is how it works. Pages that haven't been scanned grow older
automatically because those that have been scanned will be tagged with
younger generation numbers. Eviction does bucket sort based on
generation numbers and attacks the oldest.
