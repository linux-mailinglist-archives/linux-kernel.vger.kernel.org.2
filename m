Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A006633E306
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCQAwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:52:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:14776 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhCQAvr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:51:47 -0400
IronPort-SDR: r4Y3nN72wtkhgoiUUWjPups8eZ7Z2dx/shjuAhB0aoLd5aKAr6zQyvk0n66iU6uQCSu+4EBLHc
 8oqY78wifESA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176958912"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="176958912"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 17:51:46 -0700
IronPort-SDR: tlsFoyTrBXJMUG5IsO9ar4eS81uF2tNkp1yStbkVP0RkoWLxlZQTBy84X1d0FPTS5hBMPRBvfQ
 yW/I5IPKwatw==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412439728"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 17:51:43 -0700
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava> <20210316163421.GQ203350@tassilo.jf.intel.com>
 <YFEBaVNDokSVW/34@kernel.org> <20210316200220.GS203350@tassilo.jf.intel.com>
 <YFEpQs4TnnxPPznF@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ea1afc3b-0617-5b21-d0b1-9fd77bbcf0d1@linux.intel.com>
Date:   Wed, 17 Mar 2021 08:51:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFEpQs4TnnxPPznF@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2021 5:55 AM, Jiri Olsa wrote:
> On Tue, Mar 16, 2021 at 01:02:20PM -0700, Andi Kleen wrote:
>> On Tue, Mar 16, 2021 at 04:05:13PM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Mar 16, 2021 at 09:34:21AM -0700, Andi Kleen escreveu:
>>>>> looks ok, but maybe make the option more related to CVS, like:
>>>>>
>>>>>    --x-summary, --cvs-summary  ...?
>>>>
>>>> Actually I don't think it should be a new option. I doubt
>>>> anyone could parse the previous mess. So just make it default
>>>> with -x
>>>
>>> In these cases I always fear that people are already parsing that mess
>>> by considering the summary lines to be the ones not starting with
>>> spaces, and now we go on and change it to be "better" by prefixing it
>>> with "summary" and... break existing scripts.
>>
>> I think it was just one version or so?
>>
>> FWIW perf has broken CSV output several times, I added workarounds
>> to toplev every time. Having a broken version for a short time
>> shouldn't be too bad.
>>
>> I actually had a workaround for this one, but it can parse either way.
>>
>>>
>>> Can we do this with a new option?
>>>
>>> I.e. like --cvs-summary?
>>
>> If you do it I would add an option for the old broken format
>> --i-want-broken-csv. But not  require the option forever
>> just to get sane output.
> 
> I like that.. also we'll find out how many people are actually parsing that ;-)
> 
> jirka
> 

Is it serious or just a joke? :)

Thanks
Jin Yao

>>
>> Or maybe only a perf config option.
>>
>> -Andi
>>
> 
