Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E50334BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhCJWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:32:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:2646 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCJWcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:32:24 -0500
IronPort-SDR: irAAH4pWqakEVARJUayqUCRj+IdlLjfeCqBk6gxe/kjalmBs1lxpcYQeQ1KappvfHf2WcxojW1
 bl0W2A/OxdQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188613759"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="188613759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:32:24 -0800
IronPort-SDR: mX/MstW726YNg1QkzwchYQiR2gA2iYiBKFsqImz3R42IklhtA/Br+s2qy+n6ot9cqmWvhIxQOI
 8QVlzdATryTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="589001786"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 14:32:24 -0800
Received: from [10.251.19.203] (kliang2-MOBL.ccr.corp.intel.com [10.251.19.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6134A580841;
        Wed, 10 Mar 2021 14:32:22 -0800 (PST)
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
 <20210310165358.GI23521@zn.tnic>
 <20210310194644.GA1218@ranerica-svr.sc.intel.com>
 <20210310200147.GJ23521@zn.tnic>
 <20210310222548.GA28393@ranerica-svr.sc.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <142a4a09-7e92-506c-d683-fb0dd06c1abc@linux.intel.com>
Date:   Wed, 10 Mar 2021 17:32:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210310222548.GA28393@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2021 5:25 PM, Ricardo Neri wrote:
> On Wed, Mar 10, 2021 at 09:01:47PM +0100, Borislav Petkov wrote:
>> On Wed, Mar 10, 2021 at 11:46:44AM -0800, Ricardo Neri wrote:
>>> But this series provides the use case, right? Kan's patches handle PMU counters
>>> that may differ cross types of CPUs. In patch 2, get_hybrid_params()
>>> needs to check first if X86_FEATURE_HYBRID_CPU is enabled before
>>> querying the hybrid parameters. Otherwise, we would need to rely on the
>>> maximum level of CPUID, which may not be reliable.
>>
>> On Wed, Mar 10, 2021 at 11:33:54AM -0800, Srinivas Pandruvada wrote:
>>> We are working on changes to P-State driver for hybrid CPUs using this
>>> define. They are still work in progress.
>>> But this patch can be submitted later with our set of changes.
>>
>> Answering to both with a single mail:
>>
>> I don't have a problem with X86_FEATURE_HYBRID_CPU - I simply don't want
>> to show "hybrid_cpu" in /proc/cpuinfo unless there's a valid use case
>> for userspace to know that it is running on a hybrid CPU.
> 
> Ah, I get your point now. You would like to see
> 
> #define X86_FEATURE_HYBRID_CPU               (18*32+15) /* "" This part has CPUs of more than one type */
> 
> Right? Now your first comment makes sense.
> 
> Srinivas, Kan, I don't think we need to expose "hybrid_cpu" in
> /proc/cpuinfo, do we?
> 

Right, Perf doesn't use the "hybrid_cpu" in /proc/cpuinfo.

Thanks,
Kan
