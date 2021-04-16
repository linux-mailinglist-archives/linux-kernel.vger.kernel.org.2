Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3631236222F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhDPO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:27:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:4721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235814AbhDPO1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:27:09 -0400
IronPort-SDR: /Sp6f+BVIfpyXUsXZHB56v5e4jRwlPQdr2cegVDeZIBP0dwuO9F1F3Kve8g2uwr0tAL3OYKqEU
 +ykXNDKWI82Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175153612"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="175153612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:26:44 -0700
IronPort-SDR: 0w32KQlFl1AWpDccPudMMQAdGFtLJ9GaOahaij1O3FWLPpbn3ABJ1uRjQ14OetOX/aI9NTMwzM
 5c7qEWokIu1A==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="453355311"
Received: from mhsedler-mobl1.amr.corp.intel.com (HELO [10.212.149.97]) ([10.212.149.97])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:26:44 -0700
Subject: Re: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
To:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <9cd0dcde-f257-1b94-17d0-f2e24a3ce979@intel.com>
Date:   Fri, 16 Apr 2021 07:26:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/21 5:35 AM, Michal Hocko wrote:
>   I have to confess that I haven't grasped the initialization
>   completely. There is a nice comment explaining a 2 socket system with
>   3 different NUMA nodes attached to it with one node being terminal.
>   This is OK if the terminal node is PMEM but how that fits into usual
>   NUMA setups. E.g.
>   4 nodes each with its set of CPUs
>   node distances:
>   node   0   1   2   3
>   0:  10  20  20  20
>   1:  20  10  20  20
>   2:  20  20  10  20
>   3:  20  20  20  10
>   Do I get it right that Node 3 would be terminal?

Yes, I think Node 3 would end up being the terminal node in that setup.

That said, I'm not sure how much I expect folks to use this on
traditional, non-tiered setups.  It's also hard to argue what the
migration order *should* be when all the nodes are uniform.

> - The demotion is controlled by node_reclaim_mode but unlike other modes
>   it applies to both direct and kswapd reclaims.
>   I do not see that explained anywhere though.

That's an interesting observation.  Let me do a bit of research and I'll
update the Documentation/ and the changelog.

> - The demotion is implemented at shrink_page_list level which migrates
>   pages in the first round and then falls back to the regular reclaim
>   when migration fails. This means that the reclaim context
>   (PF_MEMALLOC) will allocate memory so it has access to full memory
>   reserves. Btw. I do not __GFP_NO_MEMALLOC anywhere in the allocation
>   mask which looks like a bug rather than an intention. Btw. using
>   GFP_NOWAIT in the allocation callback would make more things clear
>   IMO.

Yes, the lack of __GFP_NO_MEMALLOC is a bug.  I'll fix that up.

GFP_NOWAIT _seems_ like it will work.  I'll give it a shot.

> - Memcg reclaim is excluded from all this because it is not NUMA aware
>   which makes sense to me.
> - Anonymous pages are bit tricky because they can be demoted even when
>   they cannot be reclaimed due to no (or no available) swap storage.
>   Unless I have missed something the second round will try to reclaim
>   them even the later is true and I am not sure this is completely OK.

What we want is something like this:

Swap Space / Demotion OK  -> Can Reclaim
Swap Space / Demotion Off -> Can Reclaim
Swap Full  / Demotion OK  -> Can Reclaim
Swap Full  / Demotion Off -> No Reclaim

I *think* that's what can_reclaim_anon_pages() ends up doing.  Maybe I'm
misunderstanding what you are referring to, though.  By "second round"
did you mean when we do reclaim on a node which is a terminal node?

> I am still trying to digest the whole thing but at least jamming
> node_reclaim logic into kswapd seems strange to me. Need to think more
> about that though.

I'm entirely open to other ways to do the opt-in.  It seemed sane at the
time, but I also understand the kswapd concern.

> Btw. do you have any numbers from running this with some real work
> workload?

Yes, quite a bit.  Do you have a specific scenario in mind?  Folks seem
to come at this in two different ways:

Some want to know how much DRAM they can replace by buying some PMEM.
They tend to care about how much adding the (cheaper) PMEM slows them
down versus (expensive) DRAM.  They're making a cost-benefit call

Others want to repurpose some PMEM they already have.  They want to know
how much using PMEM in this way will speed them up.  They will basically
take any speedup they can get.

I ask because as a kernel developer with PMEM in my systems, I find the
"I'll take what I can get" case more personally appealing.  But, the
business folks are much more keen on the "DRAM replacement" use.  Do you
have any thoughts on what you would like to see?
