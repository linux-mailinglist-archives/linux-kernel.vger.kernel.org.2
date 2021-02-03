Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5130E4DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhBCVVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:21:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:25415 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhBCVVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:21:23 -0500
IronPort-SDR: 9iRoWZmpdjX0qAY0PNNNylaAoswbye1QR/QRDCIc60vSp0r5PCSf8UvnC7F8B/AILsdtXBBz+o
 5Gpqs+e5SRTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177611971"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="177611971"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 13:19:37 -0800
IronPort-SDR: hsinj5kv10yTDmsD5/bhiEnMOB0jUnvW5Y4QygiYJ64UjSjhWpsNm+F7Tv2skwx5Nd/RELJaoh
 1eQ1Ao4luRpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="396819985"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2021 13:19:36 -0800
Received: from [10.251.9.135] (kliang2-MOBL.ccr.corp.intel.com [10.251.9.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 42C155802A4;
        Wed,  3 Feb 2021 13:19:35 -0800 (PST)
Subject: Re: [PATCH 5/9] perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-6-git-send-email-kan.liang@linux.intel.com>
 <20210203203105.GJ854763@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3429f643-c0a1-320b-035f-24406d0b8f7d@linux.intel.com>
Date:   Wed, 3 Feb 2021 16:19:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203203105.GJ854763@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2021 3:31 PM, Arnaldo Carvalho de Melo wrote:
>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>> @@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
>>   		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
>>   		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
>>   		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
>> -		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
>> +		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(WEIGHT_STRUCT),
> I have CODE_PAGE_SIZE in my perf/core branch, was this somehow removed?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c1de7f3d84ca324c7cda85c3ce27b11741af2124
> 
> I see, you did this patchkit on top of upstream, that has just
> DATA_PAGE_SIZE, while my perf/core branch has CODE_PAGE_SIZE. I'm
> adjusting it, please next time do tooling development on acme/perf/core.

Sorry, I will rebase the patchset on acme/perf/core.

Thanks,
Kan
