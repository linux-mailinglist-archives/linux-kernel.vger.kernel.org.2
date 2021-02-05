Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D942A310DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhBEO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:29:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:16255 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhBEOSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:18:54 -0500
IronPort-SDR: Md9gHOWmaXCgIfNFCHnB1TbIL75Hsw5CNCDn9kt6rZGAOrA9ZjRt8pfQyT7lUQZ0+qiMihwoKC
 sDWTYffNQtzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="178879683"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="178879683"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:38:07 -0800
IronPort-SDR: 227D2ET+ba/qRbtZ+yCKwyHqYwI5MZcMZwAvT9sFy8iXgQmSs5kk0hAs2jkJLiQLAixIIQbQ1R
 CU7DuqsYQ5SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="508557741"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2021 06:38:06 -0800
Received: from [10.254.80.1] (kliang2-MOBL.ccr.corp.intel.com [10.254.80.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8C4AF580689;
        Fri,  5 Feb 2021 06:38:05 -0800 (PST)
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7chGxZc0MA4nqVeJRDXLEzWsQ-ceJ+xgMVmEbQbDVDf72w@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a1e837a6-9c6a-c613-d7b9-8e6547dfcf67@linux.intel.com>
Date:   Fri, 5 Feb 2021 09:38:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7chGxZc0MA4nqVeJRDXLEzWsQ-ceJ+xgMVmEbQbDVDf72w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2021 6:08 AM, Namhyung Kim wrote:
> On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The instruction latency information can be recorded on some platforms,
>> e.g., the Intel Sapphire Rapids server. With both memory latency
>> (weight) and the new instruction latency information, users can easily
>> locate the expensive load instructions, and also understand the time
>> spent in different stages. The users can optimize their applications
>> in different pipeline stages.
>>
>> The 'weight' field is shared among different architectures. Reusing the
>> 'weight' field may impacts other architectures. Add a new field to store
>> the instruction latency.
>>
>> Like the 'weight' support, introduce a 'ins_lat' for the global
>> instruction latency, and a 'local_ins_lat' for the local instruction
>> latency version.
> 
> Could you please clarify the difference between the global latency
> and the local latency?
>

The global means the total latency.
The local means average latency, aka total / number of samples.

Thanks,
Kan
