Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9493E8E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhHKKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:18:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:59049 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhHKKSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:18:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="237118251"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="237118251"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 03:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506892636"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 03:18:17 -0700
Subject: Re: [PATCH 1/5] perf script: Fix unnecessary machine_resolve()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-2-adrian.hunter@intel.com>
 <YRLErQjNd77Y1jKy@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <002d3bee-ae51-4a19-9eaa-8cdc63a97e86@intel.com>
Date:   Wed, 11 Aug 2021 13:18:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRLErQjNd77Y1jKy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 9:25 pm, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 10, 2021 at 02:48:09PM +0300, Adrian Hunter escreveu:
>> machine_resolve() may have already been called. Test for that to avoid
>> calling it again unnecessarily.
> 
> By some dlfilter function, right...
> 
> Perhaps it would be better for machine__resolve() itself to check that?
> 
> Probably we'll need a 'force' arg, or have __machine__resolve() that
> does exactly what machine__resolve() does today and then tools wanting
> to force it to avoid using whatever is 'cached'?

Yes, or perhaps introduce machine__resolve_once() and thread__resolve_once() ?

> 
> - Arnaldo
>  
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/builtin-script.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index e2e165b53499..f469354155f1 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -2212,7 +2212,7 @@ static int process_sample_event(struct perf_tool *tool,
>>  	if (filter_cpu(sample))
>>  		goto out_put;
>>  
>> -	if (machine__resolve(machine, &al, sample) < 0) {
>> +	if (!al.thread && machine__resolve(machine, &al, sample) < 0) {
>>  		pr_err("problem processing %d event, skipping it.\n",
>>  		       event->header.type);
>>  		ret = -1;
>> -- 
>> 2.17.1
>>
> 

