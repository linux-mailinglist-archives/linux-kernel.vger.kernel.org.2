Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E153115A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhBEWgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:36:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:12111 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhBEOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:53:15 -0500
IronPort-SDR: 0cgLrLvhckE8o2UJXDN5A5ghXY9ickVM7ocYPbTXZQangKakgBHZdzosYkOAN4R+pWuIsyd8QO
 9cZ8QXJ1uRNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168556989"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="168556989"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:51:26 -0800
IronPort-SDR: PjIg4TSDLs4JDfbmYwRiX32i3K5dTo4h0kERzOIc8Uic5v20hGW2Ulpvp5V5uc6uoYL5Q1ghwH
 a9Nuy3E5R7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="508561370"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2021 06:51:26 -0800
Received: from [10.254.80.1] (kliang2-MOBL.ccr.corp.intel.com [10.254.80.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 80507580689;
        Fri,  5 Feb 2021 06:51:25 -0800 (PST)
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <A90940CE-3DFB-4774-BA46-0C5FEB4953A0@linux.vnet.ibm.com>
 <27633871-eda5-7faa-8783-84dd49f8a6cd@linux.intel.com>
 <6F377E9D-89F8-414F-A2CC-C96797697159@linux.vnet.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2f2ede9e-b098-4921-59e2-1289bdc87ba1@linux.intel.com>
Date:   Fri, 5 Feb 2021 09:51:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6F377E9D-89F8-414F-A2CC-C96797697159@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2021 7:55 AM, Athira Rajeev wrote:
>>> Because in other archs, the var2_w of ‘perf_sample_weight’ could be used to capture something else than the Local INSTR Latency.
>>> Can we have some weak function to populate the header string ?
>> I agree that the var2_w has different meanings among architectures. We should not force it to data->ins_lat.
>>
>> The patch as below should fix it. Does it work for you?
> My point about weak function was actually for the arch specific header string. But I guess we should not force it to data->ins_lat

Yes, I don't think PowerPC should force var2_w to data->ins_lat. I think 
you can create your own field.

> as you mentioned. I checked the below patch defining an ‘arch_perf_parse_sample_weight' for powerpc and it works.
> 
> But one observation is that, for cases with kernel having support for PERF_SAMPLE_WEIGHT_STRUCT but missing arch specific support for  ‘arch_perf_parse_sample_weight', it will report ‘Local Weight’ wrongly since weak function takes it as 64 bit. Not sure if that is a valid case to consider though.

Currently, the PERF_SAMPLE_WEIGHT_STRUCT is only enabled on X86 by default.
https://lore.kernel.org/lkml/1612296553-21962-6-git-send-email-kan.liang@linux.intel.com/

For PowerPC, the PERF_SAMPLE_WEIGHT is still the default setting. There 
is no way to set PERF_SAMPLE_WEIGHT_STRUCT via perf tool.
I don't think the above case will happen.

Thanks,
Kan
