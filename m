Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9C44786C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 03:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhKHCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 21:14:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:25033 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232513AbhKHCOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:14:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="255812649"
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="255812649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 18:12:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="502813869"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 18:12:09 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <osalvador@suse.de>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: migrate: Add new node demotion strategy
References: <c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com>
        <665cb882-6dbc-335f-1435-e52659d7ee58@intel.com>
        <87tugrxqks.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <c0023ae8-0aff-0890-00fb-310d72130f8a@intel.com>
Date:   Mon, 08 Nov 2021 10:12:06 +0800
In-Reply-To: <c0023ae8-0aff-0890-00fb-310d72130f8a@intel.com> (Dave Hansen's
        message of "Fri, 5 Nov 2021 08:47:23 -0700")
Message-ID: <877ddjxuo9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 11/4/21 7:51 PM, Huang, Ying wrote:
>>> Let's also try to do it with the existing node_demotion[] data
>>> structure before we go adding more.
>> To avoid cache ping-pong, I guess some kind of per-CPU data structure
>> may be more suitable for interleaving among multiple nodes.
>
> It would probably be better to just find something that's more
> read-heavy.  Like, instead of keeping a strict round-robin, just
> randomly select one of the notes to which you can round-robin.
>
> That will scale naturally without having to worry about caching or fancy
> per-cpu data structures.

Yes.  That sounds good.  And per-CPU data structure is used inside
random API too :-)

Best Regards,
Huang, Ying
