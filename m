Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6242F33CCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhCPEpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhCPEpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:45:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:45:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n132so35832376iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DBsfjI7Y9qCZHdzx/JVFP1TkC1/+jN/GH13dkfs78b4=;
        b=g1xy5TEBHfyPxwIXSOaSp8xTF1R7KhbcM3BdOHdTD05qOZbn9PYJUcQzYtp1Ruj1dw
         8rzK9epnwJp9Bkl8FdPGMgK1k5JbJhzDY0V5X5xGfivH30XARF+tbRUacnLA9uelzrE2
         dCC06tiUSl2CxsJBvMquE22cSymjRNRX5fiXHqsPurc0w2/kpRhfr0RNA+bCKiKQU18T
         98oynbx9Y9+sMVAGdQx2JDQAS7Ndloh0m2yeFDlCOVFXZH3M5iJLyb8Wv1T6a/2SR2/Q
         gpt/QNM1qKaoiyWYq+qn9PMDTxDDRe3UvQvtQQbBzEJGcKCx/ORO3Nl0jKbXJ1ZmZpHk
         qRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBsfjI7Y9qCZHdzx/JVFP1TkC1/+jN/GH13dkfs78b4=;
        b=KPgHihwyf2tkqT0ch0eYAIq0uE9YxTLWDRgxYtgsuZVE1rncS/2CpyupEe+oEoiwd2
         x6jm0Uycw9pRIB1aAuUNl1YsLjynrz/q4J3vDrijht9wo1FWhsPY2HK+IgVVVYNy7Gde
         R5muR0NW4/IkYxlnlh4Mq7tMxLBObrWYXwy3Q5PR3Zj4fszsWpzVINyfnBm6StPckDkn
         xAOTcBZmXg3yLUgXNC8hlXwazLXuW6JGDyqkUcq3P3JQzoblUpcrVGAfE5muVSMlJCjo
         hVaC/SUgk9zDcIwv5wDdVX7FcgO2tCGHmv7vkYafmmGs0lRogbv4QVUvVSHTrJdmxdjk
         PU6g==
X-Gm-Message-State: AOAM532yu0c1jOEZ0jNvuL7AQRDGHxhrnkTRu560m8FXmPwN1UZmYaKE
        1UpGvQsqbDwm7Qco9BWj32T3yQ==
X-Google-Smtp-Source: ABdhPJxEpIUeNmedia6BMm/JQ8HjdRr7IDMTVY5N83A2Lur9+0y0RVAnR4BZhFaLMKNV7N3UQ+uY/g==
X-Received: by 2002:a02:9985:: with SMTP id a5mr12336093jal.122.1615869923602;
        Mon, 15 Mar 2021 21:45:23 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:d825:37a2:4b55:995f])
        by smtp.gmail.com with ESMTPSA id 5sm8716358ill.20.2021.03.15.21.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:45:22 -0700 (PDT)
Date:   Mon, 15 Mar 2021 22:45:18 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Huang, Ying" <ying.huang@intel.com>
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
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 10/14] mm: multigenerational lru: core
Message-ID: <YFA33n+zQb8oomjJ@google.com>
References: <87im5rsvd8.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im5rsvd8.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:08:51AM +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
> [snip]
> 
> > +/* Main function used by foreground, background and user-triggered aging. */
> > +static bool walk_mm_list(struct lruvec *lruvec, unsigned long next_seq,
> > +			 struct scan_control *sc, int swappiness)
> > +{
> > +	bool last;
> > +	struct mm_struct *mm = NULL;
> > +	int nid = lruvec_pgdat(lruvec)->node_id;
> > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > +	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
> > +
> > +	VM_BUG_ON(next_seq > READ_ONCE(lruvec->evictable.max_seq));
> > +
> > +	/*
> > +	 * For each walk of the mm list of a memcg, we decrement the priority
> > +	 * of its lruvec. For each walk of memcgs in kswapd, we increment the
> > +	 * priorities of all lruvecs.
> > +	 *
> > +	 * So if this lruvec has a higher priority (smaller value), it means
> > +	 * other concurrent reclaimers (global or memcg reclaim) have walked
> > +	 * its mm list. Skip it for this priority to balance the pressure on
> > +	 * all memcgs.
> > +	 */
> > +#ifdef CONFIG_MEMCG
> > +	if (!mem_cgroup_disabled() && !cgroup_reclaim(sc) &&
> > +	    sc->priority > atomic_read(&lruvec->evictable.priority))
> > +		return false;
> > +#endif
> > +
> > +	do {
> > +		last = get_next_mm(lruvec, next_seq, swappiness, &mm);
> > +		if (mm)
> > +			walk_mm(lruvec, mm, swappiness);
> > +
> > +		cond_resched();
> > +	} while (mm);
> 
> It appears that we need to scan the whole address space of multiple
> processes in this loop?
> 
> If so, I have some concerns about the duration of the function.  Do you
> have some number of the distribution of the duration of the function?
> And may be the number of mm_struct and the number of pages scanned.
> 
> In comparison, in the traditional LRU algorithm, for each round, only a
> small subset of the whole physical memory is scanned.

Reasonable concerns, and insightful too. We are sensitive to direct
reclaim latency, and we tuned another path carefully so that direct
reclaims virtually don't hit this path :)

Some numbers from the cover letter first:
  In addition, direct reclaim latency is reduced by 22% at 99th
  percentile and the number of refaults is reduced 7%. These metrics are
  important to phones and laptops as they are correlated to user
  experience.

And "another path" is the background aging in kswapd:
  age_active_anon()
    age_lru_gens()
      try_walk_mm_list()
        /* try to spread pages out across spread+1 generations */
        if (old_and_young[0] >= old_and_young[1] * spread &&
            min_nr_gens(max_seq, min_seq, swappiness) > max(spread, MIN_NR_GENS))
                return;

        walk_mm_list(lruvec, max_seq, sc, swappiness);

By default, spread = 2, which makes kswapd slight more aggressive
than direct reclaim for our use cases. This can be entirely disabled
by setting spread to 0, for worloads that don't care about direct
reclaim latency, or larger values, they are more sensitive than
ours.

It's worth noting that walk_mm_list() is multithreaded -- reclaiming
threads can work on different mm_structs on the same list
concurrently. We do occasionally see this function in direct reclaims,
on over-overcommitted systems, i.e., kswapd CPU usage is 100%. Under
the same condition, we saw the current page reclaim live locked and
triggered hardware watchdog timeouts (our hardware watchdog is set to
2 hours) many times.
