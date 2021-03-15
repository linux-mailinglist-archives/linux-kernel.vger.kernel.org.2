Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B354833A94C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 02:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCOBZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:25:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:63731 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCOBZ3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:25:29 -0400
IronPort-SDR: wLBXwF9Cr4CjA75kzP7yvptdaeI213a6E2qnbcmTio8kMAWvyEs9XN3HPxqkI1jPoI+5SfMQeW
 rRdesp56Y4TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="274064413"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="274064413"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 18:25:23 -0700
IronPort-SDR: SCQAArOtPSLGQskwJbnP9HymAjc4p2JAv7OC3h7OGmzL2e6ROS2rxjEunNdWXChgBm4dcSLBrr
 AyUJ/fnb9nXg==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="411672159"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 18:25:20 -0700
Subject: Re: [PATCH v2 07/27] perf evlist: Hybrid event uses its own cpus
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-8-yao.jin@linux.intel.com> <YEu9wl4FcF+AoRTy@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d5f20c67-1e5f-e5c1-4665-717468dc88be@linux.intel.com>
Date:   Mon, 15 Mar 2021 09:25:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEu9wl4FcF+AoRTy@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/13/2021 3:15 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:22PM +0800, Jin Yao wrote:
>> On hybrid platform, atom events can be only enabled on atom CPUs. Core
>> events can be only enabled on core CPUs. So for a hybrid event, it can
>> be only enabled on it's own CPUs.
>>
>> But the problem for current perf is, the cpus for evsel (via PMU sysfs)
>> have been merged to evsel_list->core.all_cpus. It might be all CPUs.
>>
>> So we need to figure out one way to let the hybrid event only use it's
>> own CPUs.
>>
>> The idea is to create a new evlist__invalidate_all_cpus to invalidate
>> the evsel_list->core.all_cpus then evlist__for_each_cpu returns cpu -1
>> for hybrid evsel. If cpu is -1, hybrid evsel will use it's own cpus.
> 
> that's wild.. I don't understand when you say we don't have
> cpus for evsel, because they have been merged.. each evsel
> has evsel->core.own_cpus coming from pmu->cpus, right?
> 
> why can't you just filter out cpus that are in there?
> 
> jirka
> 

Yes, you're right. This patch is wide and actually it's not very necessary.

The current framework has processed the cpus for evsel well even for hybrid evsel. So this patch can 
be dropped.

Thanks
Jin Yao

