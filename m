Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF18405FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347610AbhIIW6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:58:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:38575 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244256AbhIIW6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:58:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220610022"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="220610022"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 15:56:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="694374571"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.200.87]) ([10.212.200.87])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 15:56:52 -0700
Subject: Re: [PATCH v2] perf list: Display hybrid pmu events with cpu type
To:     Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210903025239.22754-1-yao.jin@linux.intel.com>
 <CAP-5=fVT6G6Ysdd39O3XROyKUxAs6uQVeO8mnbsy-Oy5VqujrA@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <0ccb62bf-34be-b986-4794-d8cc2a767a3e@linux.intel.com>
Date:   Thu, 9 Sep 2021 15:56:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVT6G6Ysdd39O3XROyKUxAs6uQVeO8mnbsy-Oy5VqujrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2021 3:37 PM, Ian Rogers wrote:
> On Thu, Sep 2, 2021 at 7:54 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>> Add a new option '--cputype' to perf-list to display core-only pmu events
>> or atom-only pmu events.
>>
>> Each hybrid pmu event has been assigned with a pmu name, this patch
>> compares the pmu name before listing the result.
> Would this work more broadly for any PMU type? If so perhaps pmu
> rather than cputype is a more appropriate option name?

It's not just the cpu pmu, because it still lists the uncore events, 
which makes sense.

If you want to match the pmu it probably would make sense to match it in 
the default matching for non option arguments in perf list. But that 
would be a different patch.

-Andi


