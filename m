Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50A3361FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhDPMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:36:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234291AbhDPMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618576545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0NXzHc9C8GdWfSwnMIwDRzLMUHI+KIfop/E4cJH7Jg=;
        b=tP9KOVEDOaM7So8SGRLXgp7ANRlSAxH4MY5wrOUuBb6O31oVpHWz0GSj5wGPcIEvutyVrP
        hfbCN0DXoMql+zbEVRjZUU7+wKRk2TlzqvulmCyP2/Rl5a1kph9jVQXAZjdozRk1o/RSGq
        khWiykqBZJR77ljxa6TEMC84NO6U9is=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BDA68ABED;
        Fri, 16 Apr 2021 12:35:45 +0000 (UTC)
Date:   Fri, 16 Apr 2021 14:35:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com
Subject: Re: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
Message-ID: <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
References: <20210401183216.443C4443@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am really sorry to jump into this train sooo late. I have quickly
glanced through the series and I have some questions/concerns. Let me
express them here rather than in specific patches.

First of all I do think that demotion is a useful way to balance the
memory in general. And that is not really bound to PMEM equipped
systems. There are larger NUMA machines which are not trivial to
partition and our existing NUMA APIs are far from ideal to help with
that.

I do appreciate that the whole thing is an opt in because this might
break workloads which are careful with the placement. I am not sure
there is a way to handle constrains in an optimal way if that is
possible at all in some cases (e.g. do we have a way to track page to
its cpuset resp. task mempolicy in all cases?).

The cover letter is focusing on usecases but it doesn't really provide
so let me try to lay it down here (let's see whether I missed something
important).
- order for demontion defines a very simple fallback to a single node
  based on the proximity but cycles are not allowed in the fallback
  mask.
  I have to confess that I haven't grasped the initialization
  completely. There is a nice comment explaining a 2 socket system with
  3 different NUMA nodes attached to it with one node being terminal.
  This is OK if the terminal node is PMEM but how that fits into usual
  NUMA setups. E.g.
  4 nodes each with its set of CPUs
  node distances:
  node   0   1   2   3
  0:  10  20  20  20
  1:  20  10  20  20
  2:  20  20  10  20
  3:  20  20  20  10
  Do I get it right that Node 3 would be terminal?
- The demotion is controlled by node_reclaim_mode but unlike other modes
  it applies to both direct and kswapd reclaims.
  I do not see that explained anywhere though.
- The demotion is implemented at shrink_page_list level which migrates
  pages in the first round and then falls back to the regular reclaim
  when migration fails. This means that the reclaim context
  (PF_MEMALLOC) will allocate memory so it has access to full memory
  reserves. Btw. I do not __GFP_NO_MEMALLOC anywhere in the allocation
  mask which looks like a bug rather than an intention. Btw. using
  GFP_NOWAIT in the allocation callback would make more things clear
  IMO.
- Memcg reclaim is excluded from all this because it is not NUMA aware
  which makes sense to me.
- Anonymous pages are bit tricky because they can be demoted even when
  they cannot be reclaimed due to no (or no available) swap storage.
  Unless I have missed something the second round will try to reclaim
  them even the later is true and I am not sure this is completely OK.

I hope I've captured all important parts. There are some more details
but they do not seem that important. 

I am still trying to digest the whole thing but at least jamming
node_reclaim logic into kswapd seems strange to me. Need to think more
about that though.

Btw. do you have any numbers from running this with some real work
workload?
-- 
Michal Hocko
SUSE Labs
