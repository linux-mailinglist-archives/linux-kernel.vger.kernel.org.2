Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7A8413F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhIVCIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:08:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:17863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhIVCIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:08:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="221613768"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="221613768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 19:07:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="474388035"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 19:07:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Weizhao Ouyang <o451686892@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
References: <20210921064553.293905-1-o451686892@gmail.com>
        <20210921064553.293905-3-o451686892@gmail.com>
        <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <d57aaff2-b154-4462-1a7d-3d288ebabb6a@gmail.com>
        <87ee9i6n1w.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <384b551e-28f0-ca7a-61b5-78f238de6e4d@nvidia.com>
Date:   Wed, 22 Sep 2021 10:07:10 +0800
In-Reply-To: <384b551e-28f0-ca7a-61b5-78f238de6e4d@nvidia.com> (John Hubbard's
        message of "Tue, 21 Sep 2021 11:00:04 -0700")
Message-ID: <87y27p5po1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Hubbard <jhubbard@nvidia.com> writes:

> On 9/21/21 07:06, Huang, Ying wrote:
> ...
>>>> Can we add BUILD_BUG_ON() somewhere to capture at least some
>>>> synchronization issue?
>>>
>>> Hi Huang, we discussed this in the v1 thread with you and John, seems you
>>> missed it. Now we just add a comment to do the synchronization, and we can
>>> figure out a more general way to use strings which in trace_events straight.
>> Got it!  And I think we can add the BUILD_BUG_ON() now and delete it
>> when we have a better solution to deal with that.  But if you can work
>> out a better solution quickly, that's fine to ignore this.
>> 
>
> I have a solution now, it's basically what I sent earlier. There appears to be
> some confusion about it. I'll send it out as a patch that builds on top of
> these two, hopefully in a few hours, if no problems pop up during testing.

Sorry, I didn't read your latest email.  The solution looks good!
Thanks!

Best Regards,
Huang, Ying
