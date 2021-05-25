Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1138FC40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhEYIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:10:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:10049 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232027AbhEYIJI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:08 -0400
IronPort-SDR: 0GOsS9DYOEPEkX2KuRz7xvmklck6bdGXKCbzAvJIgUb0ijUSK8j+BdAiSBAHfm7oHNmNFTIEYs
 9z0LsOdiSkyg==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189506523"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="189506523"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 00:39:45 -0700
IronPort-SDR: YmMP62HvLnsRDENhcuYbGX0IGcrKqlKQPGHYD0tYuzZh5nSZJkvW7v/E348GFtIWjn3wKW2SzO
 aGsISOFUentQ==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="442428432"
Received: from unknown (HELO [10.239.159.33]) ([10.239.159.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 00:39:41 -0700
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
Message-ID: <aa5f0be5-c939-3c26-9d2a-3a073449bf98@linux.intel.com>
Date:   Tue, 25 May 2021 15:39:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <3d9e738d-b972-056b-d0bc-35ed1aaefbad@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

>>>       rec_argv = calloc(rec_argc + 1, sizeof(char *));
>>>       if (!rec_argv)
>>>           return -1;
>>> +    /*
>>> +     * Save the allocated event name strings.
>>> +     */
>>> +    rec_tmp = calloc(rec_argc + 1, sizeof(char *));
>>> +    if (!rec_tmp) {
>>> +        free(rec_argv);
>>> +        return -1;
>>> +    }
>>
>> why not do strdup on all of them and always call free instead?
>> that would get rid of the rec_tmp and tmp_nr
>>
> 
> That is also one method. Let me try it.
> 

If we do strdup on all of them, such as,

	if (e->record)
		rec_argv[i++] = strdup("-W");

	rec_argv[i++] = strdup("-d");

	if (mem->phys_addr)
		rec_argv[i++] = strdup("--phys-data");
	....

That looks too much strdup used here. So I choose to use a rec_tmp[] to record the allocated string 
and free them before exit the function.

Or we record the start index and end index in rec_argv[] for the allocated event string, use strdup 
on them and call free before exit the function.

What do you think?

Thanks
Jin Yao
