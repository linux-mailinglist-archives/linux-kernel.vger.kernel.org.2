Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D89374D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhEFCXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:23:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:6872 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhEFCXq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:23:46 -0400
IronPort-SDR: QrP1rrvhPXb07KWT4xEJ9Zrrq67gb5ish3g9r5PKc8qJo31XAFtsHlIAHP+RgdodQuTqf8JZvf
 hmN8FQD47/zA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="195236045"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="195236045"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:22:48 -0700
IronPort-SDR: SfHyyOLNGdl8JZ7gdVwKgIeJD+7K53nKxnWnLPRjLNz4kzI3YNqc5kdc0i9DUBNk0rvSwWvJhR
 c241KjzrGj0g==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="434114146"
Received: from unknown (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:22:46 -0700
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJFgrKB9ZavgbA1P@krava> <YJGgYSXcJbZ2n3H3@kernel.org>
 <YJGifgASdDD7T8Xc@krava> <YJKiYziYlLgUmMwq@kernel.org>
 <YJL//g4j7RgmSIqW@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ef4ea10d-667d-2fed-25d0-2bc27482bba0@linux.intel.com>
Date:   Thu, 6 May 2021 10:22:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJL//g4j7RgmSIqW@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/6/2021 4:28 AM, Jiri Olsa wrote:
> On Wed, May 05, 2021 at 10:49:23AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, May 04, 2021 at 09:37:34PM +0200, Jiri Olsa escreveu:
>>> On Tue, May 04, 2021 at 04:28:33PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> Em Tue, May 04, 2021 at 04:56:44PM +0200, Jiri Olsa escreveu:
>>>>> On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
>>>>>> It would be useful to let user know the hybrid topology.
>>>>>> Adding HYBRID_TOPOLOGY feature in header to indicate the
>>>>>> core cpus and the atom cpus.
>>>>
>>>>>> With this patch,
>>>>
>>>>>> For the perf.data generated on hybrid platform,
>>>>>> reports the hybrid cpu list.
>>>>
>>>>>>    root@otcpl-adl-s-2:~# perf report --header-only -I
>>>>>>    ...
>>>>>>    # cpu_core cpu list : 0-15
>>>>>>    # cpu_atom cpu list : 16-23
>>>>
>>>>> hum, should we print 'hybrid:' or something to make
>>>>> sure its not confused with something else? like
>>>>   
>>>>>    # hybrid cpu_core cpu list : 0-15
>>>>>    # hybrid cpu_atom cpu list : 16-23
>>>>
>>>> But this _core/_atom already got to be enough? I disagreed with that
>>>> naming, but neverthless having one or the other present in an output is
>>>> a clear mark of this hybrid topology.
>>>>
>>>> I.e having that extra hybrid string that wouldn't add information to the
>>>> output.
>>>
>>> sure when you know that cpu_core/cpu_atom are hybrid pmus ;-)
>>> and I guess other arch will come with other names
>>
>> Yeah, its too Intel centric, I thought they would come up with
>> cpu_big/cpu_little and map it to core/atom on Intel and whatever other
>> BIG/little arches come up with.
>>
>> Perhaps:
>>
>> root@otcpl-adl-s-2:~# perf report --header-only -I
>> ...
>> # hybrid cpu system:
>> # cpu_core cpu list : 0-15
>> # cpu_atom cpu list : 16-23
>>
>> ?
> 
> 'hybrid pmus' would sounds better to me,
> but as long as there's hybrid in there I'm good ;-)
> 
> thanks,
> jirka
> 

:)

Thanks
Jin Yao

>>
>> - Arnaldo
>>
> 
