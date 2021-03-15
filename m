Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F133A986
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhCOCFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:05:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:23747 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhCOCFG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:05:06 -0400
IronPort-SDR: QUXVDh1ZHkWAuaOs95zMm/4iRzeULlguPhHoRYaULBFGKOxeWpgY4BjR6yaPO7H75pBJYnTCF9
 APKfsvJhL6cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="176155359"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="176155359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 19:05:03 -0700
IronPort-SDR: W1zli7DB7+Qnk5OSd8HjoSFwrLC4OEUoIt3ev9dbhSxdgHZwdrv9Uzd8PPt364vyJMu0Z7jYea
 u0h4LVMyZ9jw==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="411680328"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 19:04:58 -0700
Subject: Re: [PATCH v2 09/27] perf parse-events: Create two hybrid hardware
 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-10-yao.jin@linux.intel.com> <YEu9zbr75p+OLY2o@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <65b8208c-ac5d-bdea-a11a-64d4a3d29562@linux.intel.com>
Date:   Mon, 15 Mar 2021 10:04:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEu9zbr75p+OLY2o@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/13/2021 3:15 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:24PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>    cycles: 4: 800933425 1002536659 1002536659
>>    cycles: 5: 800928573 1002528386 1002528386
>>    cycles: 6: 800924347 1002520527 1002520527
>>    cycles: 7: 800922009 1002513176 1002513176
>>    cycles: 8: 800919624 1002507326 1002507326
>>    cycles: 9: 800917204 1002500663 1002500663
>>    cycles: 10: 802096579 1002494280 1002494280
>>    cycles: 11: 802093770 1002486404 1002486404
>>    cycles: 12: 803284338 1002479491 1002479491
>>    cycles: 13: 803277609 1002469777 1002469777
>>    cycles: 14: 800875902 1002458861 1002458861
>>    cycles: 15: 800873241 1002451350 1002451350
>>    cycles: 0: 800837379 1002444645 1002444645
>>    cycles: 1: 800833400 1002438505 1002438505
>>    cycles: 2: 800829291 1002433698 1002433698
>>    cycles: 3: 800824390 1002427584 1002427584
>>    cycles: 4: 800819360 1002422099 1002422099
>>    cycles: 5: 800814787 1002415845 1002415845
>>    cycles: 6: 800810125 1002410301 1002410301
>>    cycles: 7: 800791893 1002386845 1002386845
>>    cycles: 12855737722 16040169029 16040169029
>>    cycles: 6406560625 8019379522 8019379522
>>
>>     Performance counter stats for 'system wide':
>>
>>        12,855,737,722      cpu_core/cycles/
>>         6,406,560,625      cpu_atom/cycles/
> 
> so we do that no_merge stuff for uncore pmus, why can't we do
> that in here? that'd seems like generic way
> 
> jirka
> 

We have set the "stat_config.no_merge = true;" in "[PATCH v2 08/27] perf stat: Uniquify hybrid event 
name".

For hybrid hardware events, they have different configs. The config is 0xDD000000AA (0x400000000 for 
core vs. 0xa00000000 for atom in this example)

We use perf_pmu__for_each_hybrid_pmu() to iterate all hybrid PMUs, generate the configs and create 
the evsels for each hybrid PMU. This logic and the code are not complex and easy to understand.

Uncore looks complicated. It has uncore alias concept which is for different PMUs but with same 
prefix. Such as "uncore_cbox" for "uncore_cbox_0" to "uncore_cbox_9". But the uncore alias concept 
doesn't apply to hybrid pmu (we just have "cpu_core" and "cpu_atom" here). And actually I also don't 
want to mix the core stuff with uncore stuff, that would be hard for understanding.

Perhaps I misunderstand, correct me if I'm wrong.

Thanks
Jin Yao

