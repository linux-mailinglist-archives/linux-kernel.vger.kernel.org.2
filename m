Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F334445E13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhKECyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:54:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:23036 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhKECyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:54:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="211885833"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="211885833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 19:51:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="501791069"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 19:51:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <ziy@nvidia.com>, <osalvador@suse.de>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: migrate: Add new node demotion strategy
References: <c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com>
        <665cb882-6dbc-335f-1435-e52659d7ee58@intel.com>
Date:   Fri, 05 Nov 2021 10:51:31 +0800
In-Reply-To: <665cb882-6dbc-335f-1435-e52659d7ee58@intel.com> (Dave Hansen's
        message of "Thu, 4 Nov 2021 08:18:02 -0700")
Message-ID: <87tugrxqks.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 11/4/21 2:13 AM, Baolin Wang wrote:
>> +What:		/sys/kernel/mm/numa/demotion_mode
>> +Date:		November 2021
>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:	Set the demotion mode when enabling demoting pages during reclaim
>
> I don't think we need a tunable for this.  The existing behavior is just
> stupid for your hardware and can be replaced.

Yes.  I think so too.  I don't think DIRECT_DEMOTION is reasonable for your system.

> Let's also try to do it with the existing node_demotion[] data
> structure before we go adding more.

To avoid cache ping-pong, I guess some kind of per-CPU data structure
may be more suitable for interleaving among multiple nodes.

Best Regards,
Huang, Ying
