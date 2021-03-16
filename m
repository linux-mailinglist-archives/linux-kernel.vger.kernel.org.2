Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECF233D631
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhCPOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:54:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:37029 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235775AbhCPOx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:53:56 -0400
IronPort-SDR: 6/1W9/345agPUGwJbAjL7x1hczcWvZ4j9dcBL6ZDPYIPipN1J0kLU3frCKf8POZetF6XZIqqB2
 uY4dWhBEDR2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="209206489"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="209206489"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 07:53:55 -0700
IronPort-SDR: is7oJmygyzq4PKLb7OuR3sKl0cyjp5w/mT+jKDETIVT6uYK6zo5XIeNE6AOGafcpuf3XxLTHQp
 LuMEBXIcgO1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="590678407"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2021 07:53:54 -0700
Received: from [10.254.95.225] (kliang2-MOBL.ccr.corp.intel.com [10.254.95.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6102F5807EA;
        Tue, 16 Mar 2021 07:53:53 -0700 (PDT)
Subject: Re: [PATCH 1/5] perf/x86/intel/uncore: Parse uncore discovery tables
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
 <1615566878-70244-2-git-send-email-kan.liang@linux.intel.com>
 <YFCZyqz+56bB8n2k@hirez.programming.kicks-ass.net>
 <f6231c10-60b1-34ec-fb7e-103a6cd2dbcf@linux.intel.com>
 <YFC7GeBzL70QX2fS@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bdeda732-7b5e-1a99-29e4-e68d165822d1@linux.intel.com>
Date:   Tue, 16 Mar 2021 10:53:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFC7GeBzL70QX2fS@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2021 10:05 AM, Peter Zijlstra wrote:
> On Tue, Mar 16, 2021 at 08:42:25AM -0400, Liang, Kan wrote:
>>
>>
>> On 3/16/2021 7:43 AM, Peter Zijlstra wrote:
>>> On Fri, Mar 12, 2021 at 08:34:34AM -0800, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> A self-describing mechanism for the uncore PerfMon hardware has been
>>>> introduced with the latest Intel platforms. By reading through an MMIO
>>>> page worth of information, perf can 'discover' all the standard uncore
>>>> PerfMon registers in a machine.
>>>>
>>>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>>>> a PCI device with the unique capability ID 0x23 can be found on each
>>>> die. Perf can retrieve the information of all available uncore PerfMons
>>>> from the device via MMIO. The information is composed of one global
>>>> discovery table and several unit discovery tables.
>>>
>>>> If a BIOS doesn't support the 'discovery' mechanism, there is nothing
>>>> changed.
>>>
>>> What if the BIOS got it wrong? Will the driver still get it correct if
>>> it is a known platform?
>>
>> Yes, I will submit a platform specific patch to fix this case.
>>
>>>
>>> Do we need a chicken flag to kill the discovery? uncore_no_discover?
>>>
>>
>> Yes, I plan to introduce a .use_discovery_tables flag to indicate whether to
>> use the discovery tables for the known platform.
>>
>> The below codes is part of the upcoming SPR uncore patches.
>> The first SPR uncore patch will still rely on the BIOS discovery tables,
>> because some uncore block information hasn't been published yet. We have to
>> retrieve the information fro the tables. Once all the information is
>> published, we can kill the discovery by removing the ".use_discovery_tables
>> = true".
> 
> I was thinking of a module parameter, such that we can tell it to skip
> discovery on module load time etc.
> 

Sure, I will add a module parameter, uncore_no_discover.
If users don't want the discovery feature, they can set 
uncore_no_discover=true.

Thanks,
Kan
