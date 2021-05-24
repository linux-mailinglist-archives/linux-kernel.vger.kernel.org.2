Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2678B38E11C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhEXGmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:42:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:18538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhEXGmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:42:37 -0400
IronPort-SDR: qwNz6/JnzdA9gyRKWp4QwOy8vTGykmEzUye7RBSqtP6yJxVXxvyDp2ClSdqdS02jDCTCftbLtc
 Ncqgnb653PnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="201911177"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201911177"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 23:41:09 -0700
IronPort-SDR: tBmlxU85sdkzOKgYUEVOq98k7qF5meHJKDECbnpz8Fdpntgbk9SzRrFs72tzH0hPu2ygfajP87
 KPlu4G8UOpCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="413468428"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2021 23:41:08 -0700
Subject: Re: [PATCH V2] perf script: Find script file relative to exec path
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210522100151.670-1-adrian.hunter@intel.com>
 <YKp8ejb3zzmk6go8@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a5492881-c6c3-da0d-7a7b-846cdd030971@intel.com>
Date:   Mon, 24 May 2021 09:41:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKp8ejb3zzmk6go8@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/21 7:02 pm, Jiri Olsa wrote:
> On Sat, May 22, 2021 at 01:01:51PM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index 4e4aa4c97ac5..db8f24341406 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -1876,6 +1876,7 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
>>  
>>  struct scripting_ops python_scripting_ops = {
>>  	.name			= "Python",
>> +	.dirname		= "python",
>>  	.start_script		= python_start_script,
>>  	.flush_script		= python_flush_script,
>>  	.stop_script		= python_stop_script,
>> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
>> index 714581b0de65..721f38c0d5cf 100644
>> --- a/tools/perf/util/trace-event-scripting.c
>> +++ b/tools/perf/util/trace-event-scripting.c
>> @@ -63,6 +63,7 @@ static int python_generate_script_unsupported(struct tep_handle *pevent
>>  
>>  struct scripting_ops python_scripting_unsupported_ops = {
>>  	.name = "Python",
>> +	.dirname = "python",
>>  	.start_script = python_start_script_unsupported,
>>  	.flush_script = flush_script_unsupported,
>>  	.stop_script = stop_script_unsupported,
>> @@ -126,6 +127,7 @@ static int perl_generate_script_unsupported(struct tep_handle *pevent
>>  
>>  struct scripting_ops perl_scripting_unsupported_ops = {
>>  	.name = "Perl",
>> +	.dirname = "perf",
> 
> looks like typo.. usually means that you run perf way too often ;-)

Betrayed by muscle memory! :-)
