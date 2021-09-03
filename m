Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1A3FFB06
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347742AbhICHX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:23:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:45465 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234791AbhICHX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:23:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="219412694"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="219412694"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 00:22:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="533766730"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.90]) ([10.238.4.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 00:22:45 -0700
Subject: Re: [LKP] Re: [sched/fair] c722f35b51: tbench.throughput-MB/sec
 -29.1% regression
To:     Rik van Riel <riel@surriel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, aubrey.li@linux.intel.com, yu.c.chen@intel.com
References: <20210519082211.GF29704@xsang-OptiPlex-9020>
 <1d942826-badc-ca0d-6d46-1b207caf7f84@intel.com>
 <ed06ccf4ddb98ec9c31d30d5f92f637bdb890326.camel@surriel.com>
From:   "Xing, Zhengjun" <zhengjun.xing@intel.com>
Message-ID: <304055ef-0c04-676b-3ed2-2b0cd0fe6d0b@intel.com>
Date:   Fri, 3 Sep 2021 15:22:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ed06ccf4ddb98ec9c31d30d5f92f637bdb890326.camel@surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

     Do you have time to look at this? I re-test it in v5.13 and v5.14, 
the regression still existed. Thanks.

On 5/27/2021 10:00 AM, Rik van Riel wrote:
> Hello,
>
> I will try to take a look at this on Friday.
>
> However, even if I manage to reproduce it on one of
> the systems I have access to, I'm still not sure how
> exactly we would root cause the issue.
>
> Is it due to
> select_idle_sibling() doing a little bit
> more work?
>
> Is it because we invoke test_idle_cores() a little
> earlier, widening the race window with CPUs going idle,
> causing select_idle_cpu to do a lot more work?
>
> Is it a locality thing where random placement on any
> core in the LLC is somehow better than placement on
> the same core as "prev" when there is no idle core?
>
> Is it tbench running
> faster when the woken up task is
> placed on the runqueue behind the current task on the
> "target" cpu, even though that CPU isn't currently
> idle, because tbench happens to go to sleep fast?
>
> In other words, I'm
> not quite sure whether this is
> a tbench (and other similar benchmark) specific thing,
> or a kernel thing, or what instrumentation we would
> want in select_idle_sibling / select_idle_cpu for us
> to root cause issues like this more easily in the
> future...

-- 
Zhengjun Xing

