Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5C368863
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhDVVDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:03:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:62972 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236877AbhDVVDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:03:33 -0400
IronPort-SDR: 9n87g+KJ8fXCPgQEawcNEx5p/BKNvD94pXDBul/SOs/RYY8J9CNgD0mxF4HgnZoCVHgXzvisqb
 hxi5qFu1TTaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281301341"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281301341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:02:58 -0700
IronPort-SDR: BwxzlXGV6rYqGB38hPzKe9g1Uto1iOH898kNrc+p0jorGkvST92B6KWznxaC3wfi80KzXV+44q
 Q0BjTIddDrEw==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455951434"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.72.4])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:02:57 -0700
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
To:     Yu Zhao <yuzhao@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
 <a085478d-5118-cdff-c611-1649fce7a650@linux.intel.com>
 <CAOUHufbVmsvWQ-_PSn8CCanuJqRR6Tmj01s17WvKsc3pRa87xw@mail.gmail.com>
 <2ea3318a-b17c-ec4c-5425-cb93e079a994@linux.intel.com>
 <CAOUHufY_0WO5LJ13EL9-bQLvmNaaOpPFMVNUsRvYrefrLqS9aw@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <bb5f5e9c-3af1-3b0c-3f0d-8b117596f8ce@linux.intel.com>
Date:   Thu, 22 Apr 2021 14:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufY_0WO5LJ13EL9-bQLvmNaaOpPFMVNUsRvYrefrLqS9aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/21 1:57 PM, Yu Zhao wrote:
> On Thu, Apr 22, 2021 at 2:38 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>>
>>
>>
>> On 4/22/21 1:30 PM, Yu Zhao wrote:
>>>
>>> HZ/10 is purely arbitrary but that's ok because we assume normally
>>> nobody hits it. If you do often, we need to figure out why and how not
>>> to hit it so often.
>>>
>>
>> Perhaps Zhengjun can test the proposed fix in his test case to see if the timeout value
>> makes any difference.
> 
> Shakeel has another test to stress page reclaim to a point that the
> kernel can livelock for two hours because of a large number of
> concurrent reclaimers stepping on each other. He might be able to
> share that test with you in case you are interested.

That will be great.  Yes, we are interested to have the test.

Tim

> 
> Also it's Hugh who first noticed that migration can isolate many pages
> and in turn block page reclaim. He might be able to help too, in case
> you are interested in the interaction between migration and page
> reclaim.
> 
> Thanks.
> 
