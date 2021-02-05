Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7303115A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBEWgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:36:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:9567 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhBEOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:53:40 -0500
IronPort-SDR: RvahoqJLxSjtRGXA2zj6YpnLmJ1zDALiR4iFVstsjZ+Pzwe9PuaVQL9aat0tmCu0LYHdW88TLH
 /sr4hSj7RROA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="200442316"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="200442316"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:17:39 -0800
IronPort-SDR: L6CzNtDxpBu6RHEK3JSvltd5mnMaj4aKDyfoDUPvtYO66nEQQHW9L6a58oeHSy8rPXxEhNk1+v
 X3jBwxFSzcpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="576707723"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 05 Feb 2021 06:17:38 -0800
Received: from [10.254.80.1] (kliang2-MOBL.ccr.corp.intel.com [10.254.80.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C836B580689;
        Fri,  5 Feb 2021 06:17:37 -0800 (PST)
Subject: Re: [PATCH 3/9] perf tools: Support data block and addr block
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-4-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7cj-q_-+98o-VH02WhC+wcJ44bAG8ZyV1UFN7ATT7Lxn6w@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2beff67f-1a1c-c899-e1e7-8ac47e421c4a@linux.intel.com>
Date:   Fri, 5 Feb 2021 09:17:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cj-q_-+98o-VH02WhC+wcJ44bAG8ZyV1UFN7ATT7Lxn6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2021 6:02 AM, Namhyung Kim wrote:
> On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Two new data source fields, to indicate the block reasons of a load
>> instruction, are introduced on the Intel Sapphire Rapids server. The
>> fields can be used by the memory profiling.
>>
>> Add a new sort function, SORT_MEM_BLOCKED, for the two fields.
>>
>> For the previous platforms or the block reason is unknown, print "N/A"
>> for the block reason.
>>
>> Add blocked as a default mem sort key for perf report and
>> perf mem report.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> [SNIP]
>> +int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>> +{
>> +       size_t l = 0;
>> +       u64 mask = PERF_MEM_BLK_NA;
>> +
>> +       sz -= 1; /* -1 for null termination */
>> +       out[0] = '\0';
>> +
>> +       if (mem_info)
>> +               mask = mem_info->data_src.mem_blk;
>> +
>> +       if (!mask || (mask & PERF_MEM_BLK_NA)) {
>> +               l += scnprintf(out + l, sz - l, " N/A");
>> +               return l;
>> +       }
>> +       if (mask & PERF_MEM_BLK_DATA)
>> +               l += scnprintf(out + l, sz - l, " Data");
>> +       if (mask & PERF_MEM_BLK_ADDR)
>> +               l += scnprintf(out + l, sz - l, " Addr");
> 
> So this means it's possible to have BLK_DATA and BLK_ADDR
> together and in that case it'll print "DataAddr", right?

Yes, it's possible. If so, it will print "Data Addr".

Thanks,
Kan
> 
> 
>> +
>> +       return l;
>> +}
>> +
>>   int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>>   {
>>          int i = 0;
>> @@ -348,6 +371,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_in
>>          i += perf_mem__tlb_scnprintf(out + i, sz - i, mem_info);
>>          i += scnprintf(out + i, sz - i, "|LCK ");
>>          i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>> +       i += scnprintf(out + i, sz - i, "|BLK ");
>> +       i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
>>
>>          return i;
>>   }
