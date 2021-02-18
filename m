Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B321B31E37C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 01:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBRAZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 19:25:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:6111 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhBRAZx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 19:25:53 -0500
IronPort-SDR: ytTFoo1O2QfahhbRHOqfZ7eloZehoBRlQhPZsmrJgu8fWOYPp6cdHLygIGEYgp0ll1bDm7Ndo1
 8Ptk435q33Kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171027953"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="171027953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 16:24:07 -0800
IronPort-SDR: Mdm7wz1sx4z42hmy5f7BORR9PbmqKOnJU6YRfOi2m08tk1MTWhexfybUt+xDjR6XjirQCiHPSa
 OttuOSH2cjgA==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="400207076"
Received: from unknown (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 16:24:04 -0800
Subject: Re: [PATCH v9] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20210128013417.25597-1-yao.jin@linux.intel.com>
 <YBcuvN106bsa7F+9@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <88f2c092-2fc8-7b3f-3d41-e2ac64bc7eb9@linux.intel.com>
Date:   Thu, 18 Feb 2021 08:24:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YBcuvN106bsa7F+9@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2/1/2021 6:27 AM, Jiri Olsa wrote:
> On Thu, Jan 28, 2021 at 09:34:17AM +0800, Jin Yao wrote:
>> Uncore becomes die-scope on Xeon Cascade Lake-AP and perf has supported
>> --per-die aggregation yet.
>>
>> One issue is found in check_per_pkg() for uncore events running on
>> AP system. On cascade Lake-AP, we have:
>>
>> S0-D0
>> S0-D1
>> S1-D0
>> S1-D1
>>
>> But in check_per_pkg(), S0-D1 and S1-D1 are skipped because the
>> mask bits for S0 and S1 have been set for S0-D0 and S1-D0. It doesn't
>> check die_id. So the counting for S0-D1 and S1-D1 are set to zero.
>> That's not correct.
>>
>> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>>       1.001460963 S0-D0           1            1317376 Bytes llc_misses.mem_read
>>       1.001460963 S0-D1           1             998016 Bytes llc_misses.mem_read
>>       1.001460963 S1-D0           1             970496 Bytes llc_misses.mem_read
>>       1.001460963 S1-D1           1            1291264 Bytes llc_misses.mem_read
>>       2.003488021 S0-D0           1            1082048 Bytes llc_misses.mem_read
>>       2.003488021 S0-D1           1            1919040 Bytes llc_misses.mem_read
>>       2.003488021 S1-D0           1             890752 Bytes llc_misses.mem_read
>>       2.003488021 S1-D1           1            2380800 Bytes llc_misses.mem_read
>>       3.005613270 S0-D0           1            1126080 Bytes llc_misses.mem_read
>>       3.005613270 S0-D1           1            2898176 Bytes llc_misses.mem_read
>>       3.005613270 S1-D0           1             870912 Bytes llc_misses.mem_read
>>       3.005613270 S1-D1           1            3388608 Bytes llc_misses.mem_read
>>       4.007627598 S0-D0           1            1124608 Bytes llc_misses.mem_read
>>       4.007627598 S0-D1           1            3884416 Bytes llc_misses.mem_read
>>       4.007627598 S1-D0           1             921088 Bytes llc_misses.mem_read
>>       4.007627598 S1-D1           1            4451840 Bytes llc_misses.mem_read
>>       5.001479927 S0-D0           1             963328 Bytes llc_misses.mem_read
>>       5.001479927 S0-D1           1            4831936 Bytes llc_misses.mem_read
>>       5.001479927 S1-D0           1             895104 Bytes llc_misses.mem_read
>>       5.001479927 S1-D1           1            5496640 Bytes llc_misses.mem_read
>>
>>  From above output, we can see S0-D1 and S1-D1 don't report the interval
>> values, they are continued to grow. That's because check_per_pkg() wrongly
>> decides to use zero counts for S0-D1 and S1-D1.
>>
>> So in check_per_pkg(), we should use hashmap(socket,die) to decide if
>> the cpu counts needs to skip. Only considering socket is not enough.
>>
>> Now with this patch,
>>
>> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>>       1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
>>       1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
>>       1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
>>       1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
>>       2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
>>       2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
>>       2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
>>       2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
>>       3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
>>       3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
>>       3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
>>       3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
>>       4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
>>       4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
>>       4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
>>       4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
>>       5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
>>       5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
>>       5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
>>       5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
>>
>> On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
>> is not changed.
>>
>> Reported-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>> v9:
>>   Rename zero_per_pkg to evsel__zero_per_pkg and move it to evsel.c. Then
>>   evsel__zero_per_pkg can be called under different code path.
>>
>>   Call evsel__zero_per_pkg in evsel__exit().
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 

Can this fix be accepted or anything else I need to improve?

Thanks
Jin Yao

