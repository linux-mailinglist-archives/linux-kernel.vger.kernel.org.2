Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09433A984
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCOCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:02:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:55153 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhCOCCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:02:04 -0400
IronPort-SDR: 5ooNthalqJg/PpFtKke59cJ8+Jz7U72b6YUvF4FnZbWZvwdDsV7UgItdicPWRTDhGD10RW0jD3
 h75oSuXrw5ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="189115623"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="189115623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 19:02:01 -0700
IronPort-SDR: +kaNfRDrjEhmkLxXgsfXup0/EBiB1tXl8TNxGLOcRDKWTQ7stHhGOW0MeM9OO+kZPllc8xkUlo
 agckKal9jLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="387944589"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2021 19:02:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4FD0D3023AF; Sun, 14 Mar 2021 19:02:01 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Yu Zhao <yuzhao@google.com>
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
Subject: Re: [PATCH v1 10/14] mm: multigenerational lru: core
References: <20210313075747.3781593-1-yuzhao@google.com>
        <20210313075747.3781593-11-yuzhao@google.com>
Date:   Sun, 14 Mar 2021 19:02:01 -0700
In-Reply-To: <20210313075747.3781593-11-yuzhao@google.com> (Yu Zhao's message
        of "Sat, 13 Mar 2021 00:57:43 -0700")
Message-ID: <871rchw4x2.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:
> +
> +#ifdef CONFIG_MEMCG
> +		if (memcg && atomic_read(&memcg->moving_account))
> +			goto contended;
> +#endif
> +		if (!mmap_read_trylock(mm))
> +			goto contended;

These are essentially spinloops. Surely you need a cpu_relax() somewhere?

In general for all of spinloop like constructs it would be useful to
consider how to teach lockdep about them.

> +	do {
> +		old_flags = READ_ONCE(page->flags);
> +		new_gen = ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> +		VM_BUG_ON_PAGE(new_gen < 0, page);
> +		if (new_gen >= 0 && new_gen != old_gen)
> +			goto sort;
> +
> +		new_gen = (old_gen + 1) % MAX_NR_GENS;
> +		new_flags = (old_flags & ~LRU_GEN_MASK) | ((new_gen + 1UL) << LRU_GEN_PGOFF);
> +		/* mark page for reclaim if pending writeback */
> +		if (front)
> +			new_flags |= BIT(PG_reclaim);
> +	} while (cmpxchg(&page->flags, old_flags, new_flags) !=
> old_flags);

I see this cmpxchg flags pattern a lot. Could there be some common code
factoring?

-Andi
