Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39C413F59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhIVCVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:21:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:7884 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhIVCU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:20:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="210581568"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="210581568"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 19:19:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550012337"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 19:19:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>,
        <mhocko@suse.com>, <weixugc@google.com>, <osalvador@suse.de>,
        <rientjes@google.com>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <gthelen@google.com>,
        <yang.shi@linux.alibaba.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order
 updates
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
        <20210917223505.F817CB6B@davehans-spike.ostc.intel.com>
        <87k0jeog7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2d7e4078-f9c0-7511-0bab-de5dab25b45d@intel.com>
        <87a6k66lnd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <d87ef236-f113-8765-7fef-e41db0adf2b2@intel.com>
Date:   Wed, 22 Sep 2021 10:19:16 +0800
In-Reply-To: <d87ef236-f113-8765-7fef-e41db0adf2b2@intel.com> (Dave Hansen's
        message of "Tue, 21 Sep 2021 10:01:35 -0700")
Message-ID: <87tuid5p3v.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 9/21/21 7:36 AM, Huang, Ying wrote:
>>> This removes the need for the demotion code to track *any* state.  I've
>>> attached a totally untested patch to do this.
>> Yes.  This sounds good.  I will try to test this patch on my side.
>> 
>>>From another point of view, we still need to update demotion order upon
>> CPU hotplug too, because whether a node has CPU may be changed there.
>> And we need a solution for that too.
>
> Just to recap...  The reason I sent this series is that there's a known,
> detectable regression in a memory hotplug "benchmark".  This affects the
> 5.15 series.
>
> While I agree that we should look into the impact on CPU hotplug, I
> think we should probably focus on the *known* memory hotplug issue for 5.15.

Yes.  We got a regression report about memory hotplug.  And that
reminded me that CPU hotplug may be a problem too.  Because CPU hotplug
is used during suspend/resume for every laptop.  The latency of
suspend/resume may impact the user experience of the Linux laptop users.

And, it seems that your previous solution can deal with CPU hotplug
too.   So, can we keep that too for CPU hotplug?

Best Regards,
Huang, Ying
