Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0483A3663C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhDUCjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:39:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:62201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhDUCjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:39:47 -0400
IronPort-SDR: eP+a1mr/KfaC/Jg55lMltJoLPxGmG/HbysmMeqoE/Hq+geyl0HHumI+x9IrhW8T5wlS11Ip9pY
 ZOJMPoA+sSjw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182760138"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="182760138"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 19:39:14 -0700
IronPort-SDR: K7XfZeMNVYpafHIWc7vTA4+M09/d5rQIU8zcG/Z3dVwBpFx7lKwed+FtYCFhTqHge/jQkeP4LC
 V5QB9dX1KukA==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="427337606"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 19:39:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        rientjes@google.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com
Subject: Re: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
References: <20210401183216.443C4443@viggo.jf.intel.com>
        <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
        <9cd0dcde-f257-1b94-17d0-f2e24a3ce979@intel.com>
        <YHmm11fxEnxXAxas@dhcp22.suse.cz>
Date:   Wed, 21 Apr 2021 10:39:09 +0800
In-Reply-To: <YHmm11fxEnxXAxas@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 16 Apr 2021 17:02:23 +0200")
Message-ID: <87czuo1hv6.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Fri 16-04-21 07:26:43, Dave Hansen wrote:
>> On 4/16/21 5:35 AM, Michal Hocko wrote:
>> > - Anonymous pages are bit tricky because they can be demoted even when
>> >   they cannot be reclaimed due to no (or no available) swap storage.
>> >   Unless I have missed something the second round will try to reclaim
>> >   them even the later is true and I am not sure this is completely OK.
>> 
>> What we want is something like this:
>> 
>> Swap Space / Demotion OK  -> Can Reclaim
>> Swap Space / Demotion Off -> Can Reclaim
>> Swap Full  / Demotion OK  -> Can Reclaim
>> Swap Full  / Demotion Off -> No Reclaim
>> 
>> I *think* that's what can_reclaim_anon_pages() ends up doing.  Maybe I'm
>> misunderstanding what you are referring to, though.  By "second round"
>> did you mean when we do reclaim on a node which is a terminal node?
>
> No, I mean the migration failure case where you splice back to the page
> list to reclaim. In that round you do not demote and want to reclaim.
> But a lack of swap space will make that page unreclaimable. I suspect
> this would just work out fine but I am not sure from the top of my head.

I have tested this via injecting some migration errors (returning 0 from
demote_page_list() before migration) on a system without swap.  The
system can still work properly.  In ftrace, I can find add_to_swap() are
called much more times, and it can deal with the situation where the
swap space isn't available.

Best Regards,
Huang, Ying
