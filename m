Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F374445100
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKDJUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:20:47 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:44932 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230335AbhKDJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:20:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uv.rXld_1636017486;
Received: from 30.21.164.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uv.rXld_1636017486)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Nov 2021 17:18:07 +0800
Subject: Re: [RFC PATCH 3/3] mm: compaction: Fix the migration stats in
 trace_mm_compaction_migratepages()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     akpm@linux-foundation.org, mingo@redhat.com, ziy@nvidia.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
 <6fac1a89862b6a8bda4314d1f51380862a6fa986.1635936218.git.baolin.wang@linux.alibaba.com>
 <20211103094232.32a14cf0@gandalf.local.home>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <b1ec38a9-7513-bd18-9243-60f92eaf0d07@linux.alibaba.com>
Date:   Thu, 4 Nov 2021 17:18:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211103094232.32a14cf0@gandalf.local.home>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/3 21:42, Steven Rostedt wrote:
> On Wed,  3 Nov 2021 18:51:16 +0800
> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> @@ -2398,10 +2399,10 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>   
>>   		err = migrate_pages(&cc->migratepages, compaction_alloc,
>>   				compaction_free, (unsigned long)cc, cc->mode,
>> -				MR_COMPACTION, NULL);
>> +				MR_COMPACTION, &nr_succeeded);
>>   
>> -		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
>> -							&cc->migratepages);
>> +		trace_mm_compaction_migratepages(cc->nr_migratepages,
>> +						 nr_succeeded);
> 
> Also, I'm surprised you don't just pass in 'cc' and do the dereferencing in
> the trace event macro. Accessing the pointers from the trace event and not
> dereferencing them to the tracepoint function moves the changes out of line
> here and helps with I$.
> 
> You could improve some of the other tracepoints that dereference 'cc' as
> well in that file.

Sure. Will do in a separate patch.

> 
> But as for this change, I'm good with it.
> 
> For the tracing aspect:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 

Thanks.
