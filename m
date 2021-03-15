Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47A33A9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCODRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCODQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:16:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805EDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:16:40 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i18so8008757ilq.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8CSdX0A5B03bYxZSOAFsQfaxoGs/c+Z6tlah++60gTY=;
        b=M1aCcZ0O6ZbH9y3UD8F1qMyWCkdN6xkqXLyKM3I+zmtPFHX8f6FNDs7tvIQe7NsjT/
         xM3kxaB3ieHl8V+SF/VkTwa0+SRxkAmzV3IXkXDiwYr/5L+IKf1C34btj0YoSB+nwsDg
         yfmDE3cjTZAA7UffAYwO1RdVkMLZv6SI1HV4sThbBYzaqwIAsgkw1pdI3IyhGbf9l4Th
         LAmDHQYTkMybikVR43XL7MM7ocQ47MTqezZTIsoA/o+qFmHetlHMIq279IiTQ5+Hxtnm
         Pi45BWbNfksXX22GbhbNuXiUtK/siaJXHqraAvlYUKhPLN2TljkE/iJF8B7y1bp1tWD3
         gBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8CSdX0A5B03bYxZSOAFsQfaxoGs/c+Z6tlah++60gTY=;
        b=dI6gDfbjKtIsCqExjjDRkMNHmNczjnwTnS2wJk6MT8uwpWViQyNb289OxWl7ww0g4X
         LCiT5/yPZdItXQ6IbffUnX7a0F95hVSCwEVAMAeqU8YvQvhhR8rmU1Q0VUlIuK7G5JBR
         IFbfVm+I/9uTMYASQdb/sxwuNEiAGD9l1f2Uf+v6LrpgB3xv0Me1NzZSPhqcFVRJ6xJh
         O9ZOKGYPp2nzuTTH4h1W2sjdRz0gRufqnizeIc9gCkwhVQ8yBxhBVxckWKk4YVClSqLl
         JHLGQnZBs67HEjJJ2p0Yn6pucrg4zKdQsiXMkdn66JvWZfJWSpwY5rIGrapVljjvOqCp
         hL0g==
X-Gm-Message-State: AOAM531CYplH4QPL255fMjL5FtINeSHUaBzWNW5cM5tJlmfYbY42XcGT
        ViYtELobknmEWFaWIVMHv5/Urw==
X-Google-Smtp-Source: ABdhPJws6zaW8x+jq9JtvGiyR0BJEFsx418QCKCDT8zxit3R7F7nTOvZNlLr2f3XrZG1R0qIhEZdgA==
X-Received: by 2002:a92:de4c:: with SMTP id e12mr10256007ilr.63.1615778199817;
        Sun, 14 Mar 2021 20:16:39 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4d84:eb70:5c32:32b8])
        by smtp.gmail.com with ESMTPSA id a5sm7138189ilh.23.2021.03.14.20.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:16:39 -0700 (PDT)
Date:   Sun, 14 Mar 2021 21:16:35 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 06/14] mm, x86: support the access bit on non-leaf PMD
 entries
Message-ID: <YE7Rk/YA1Uj7yFn2@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-7-yuzhao@google.com>
 <ce818341-ed33-cd8c-5c06-65147f510c4d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce818341-ed33-cd8c-5c06-65147f510c4d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 04:22:03PM -0700, Dave Hansen wrote:
> On 3/12/21 11:57 PM, Yu Zhao wrote:
> > Some architectures support the accessed bit on non-leaf PMD entries
> > (parents) in addition to leaf PTE entries (children) where pages are
> > mapped, e.g., x86_64 sets the accessed bit on a parent when using it
> > as part of linear-address translation [1]. Page table walkers who are
> > interested in the accessed bit on children can take advantage of this:
> > they do not need to search the children when the accessed bit is not
> > set on a parent, given that they have previously cleared the accessed
> > bit on this parent in addition to its children.
> 
> I'd like to hear a *LOT* more about how this is going to be used.
> 
> The one part of this which is entirely missing is the interaction with
> the TLB and mid-level paging structure caches.  The CPU is pretty
> aggressive about setting no-leaf accessed bits when TLB entries are
> created.  This *looks* to be depending on that behavior, but it would be
> nice to spell it out explicitly.

Good point. Let me start with a couple of observations we've made:
  1) some applications create very sparse address spaces, for various
  reasons. A notable example is those using Scudo memory allocations:
  they usually have double-digit numbers of PTE entries for each PMD
  entry (and thousands of VMAs for just a few hundred MBs of memory
  usage, sigh...).
  2) scans of an address space (from the reclaim path) are much less
  frequent than context switches of it. Under our heaviest memory
  pressure (30%+ overcommitted; guess how much we've profited from
  it :) ), their magnitudes are still on different orders.
  Specifically, on our smallest system (2GB, with PCID), we observed
  no difference between flushing and not flushing TLB in terms of page
  selections. We actually observed more TLB misses under heavier
  memory pressure, and our theory is that this is due to increased
  memory footprint that causes the pressure.

There are two use cases for the accessed bit on non-leaf PMD entries:
the hot tracking and the cold tracking. I'll focus on the cold
tracking, which is what this series about.

Since non-leaf entries are more likely to be cached, in theory, the
false negative rate is higher compared with leaf entries as the CPU
won't set the accessed bit again until the next TLB miss. (Here a
false negative means the accessed bit isn't set on an entry has been
used, after we cleared the accessed bit. And IIRC, there are also
false positives, i.e., the accessed bit is set on entries used by
speculative execution only.) But this is not a problem because of the
second observation aforementioned.

Now let's consider the worst case scenario: what happens when we hit
a false negative on a non-leaf PMD entry? We think the pages mapped
by the PTE entries of this PMD entry are inactive and try to reclaim
them, until we see the accessed bit set on one of the PTE entries.
This will cost us one futile attempt for all the 512 PTE entries. A
glance at lru_gen_scan_around() in the 11th patch would explain
exactly why. If you are guessing that function embodies the same idea
of "fault around", you are right.

And there are two places that could benefit from this patch (and the
next) immediately, independent to this series. One is
clear_refs_test_walk() in fs/proc/task_mmu.c. The other is
madvise_pageout_page_range() and madvise_cold_page_range() in
mm/madvise.c. Both are page table walkers that clear the accessed bit.

I think I've covered a lot of ground but I'm sure there is a lot more.
So please feel free to add and I'll include everything we discuss here
in the next version.
