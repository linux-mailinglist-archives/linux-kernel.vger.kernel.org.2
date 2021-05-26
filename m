Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1C390E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEZBxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:53:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:29137 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231810AbhEZBxJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:53:09 -0400
IronPort-SDR: jmPDnaOafe7uR54Ocf5WPX1PYem/OTtSnhWsCeeWSQH3b5gIGJswhNVwsP8hLHMSKa9EJ478qR
 4Vmy7e4Iuv2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="182678540"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="182678540"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 18:51:39 -0700
IronPort-SDR: WwbU4BHYu2aAGkRs47Hm5MaSArW5f+T5U5ATlNnm23l8P/MWJX87QAf2bfFgPwuxN9aRr3sCMi
 Hfr8URtk/FAg==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="443710902"
Received: from unknown (HELO [10.239.159.33]) ([10.239.159.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 18:51:36 -0700
Subject: Re: [PATCH v1 4/5] perf mem: Support record for hybrid platform
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-5-yao.jin@linux.intel.com> <YKvgFVVywalr+Owr@krava>
 <3d9e738d-b972-056b-d0bc-35ed1aaefbad@linux.intel.com>
 <aa5f0be5-c939-3c26-9d2a-3a073449bf98@linux.intel.com>
Message-ID: <6d6f1040-6c96-7d1d-c766-5fb0057e1cc4@linux.intel.com>
Date:   Wed, 26 May 2021 09:51:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <aa5f0be5-c939-3c26-9d2a-3a073449bf98@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/25/2021 3:39 PM, Jin, Yao wrote:
> Hi Jiri,
> 
>>>>       rec_argv = calloc(rec_argc + 1, sizeof(char *));
>>>>       if (!rec_argv)
>>>>           return -1;
>>>> +    /*
>>>> +     * Save the allocated event name strings.
>>>> +     */
>>>> +    rec_tmp = calloc(rec_argc + 1, sizeof(char *));
>>>> +    if (!rec_tmp) {
>>>> +        free(rec_argv);
>>>> +        return -1;
>>>> +    }
>>>
>>> why not do strdup on all of them and always call free instead?
>>> that would get rid of the rec_tmp and tmp_nr
>>>
>>
>> That is also one method. Let me try it.
>>
> 
> If we do strdup on all of them, such as,
> 
>      if (e->record)
>          rec_argv[i++] = strdup("-W");
> 
>      rec_argv[i++] = strdup("-d");
> 
>      if (mem->phys_addr)
>          rec_argv[i++] = strdup("--phys-data");
>      ....
> 
> That looks too much strdup used here. So I choose to use a rec_tmp[] to record the allocated string 
> and free them before exit the function.
> 
> Or we record the start index and end index in rec_argv[] for the allocated event string, use strdup 
> on them and call free before exit the function.
> 

This method looks also not OK.

The rec_argv[] is changed in cmd_record() for some complex command lines.

For example,

./perf mem record -- ./memtest -R0d -b2000 -d64 -n100

Before cmd_record(), rec_argv[3] = "-e".
After cmd_record(), rec_argv[3] = "-d64"

Even we do strdup on all of rec_argv[], but the entries are probably changed in cmd_record(), so we 
can't free the entries at the end of __cmd_record().

Maybe we have to use the original way which just records the allocated event string to a temporary 
array and free the whole array at the end of __cmd_record().

What do you think?

Thanks
Jin Yao

> What do you think?
> 
> Thanks
> Jin Yao
