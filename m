Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5438730BEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBBMvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:51:15 -0500
Received: from so15.mailgun.net ([198.61.254.15]:31413 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231397AbhBBMup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:50:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612270224; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=J/NXG1LRk/BPgg6FDhPDMsreIASGs/2C+VqHxELMnyo=; b=lnSBuMzUJjklyVjnT41roBlyKRAFSyxb6xtjs1S6qdPIrje9aGPCgJnnrD/uTSBaaR9rUIrC
 gZzOduFcdNtaorbkuSBF6lSLmUy2y4Pio9S/mvAlN/vDAzAGa8jklnan12qYCq48EVFsn1lW
 TPw6PQzNCpz/i0Y9hQ2nF4p1Hhk=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60194a71bfd95207230a6257 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Feb 2021 12:49:53
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95909C43466; Tue,  2 Feb 2021 12:49:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.149.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 652EBC433CA;
        Tue,  2 Feb 2021 12:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 652EBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm: page_alloc: update the COMPACT[STALL|FAIL] events
 properly
To:     David Rientjes <rientjes@google.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1612187338-19100-1-git-send-email-charante@codeaurora.org>
 <d9d1dd7b-1fe7-67b6-6ba4-fb1a6faa8fae@google.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <160ba3b5-2cd4-5ff0-1348-fb477cefd33d@codeaurora.org>
Date:   Tue, 2 Feb 2021 18:19:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d9d1dd7b-1fe7-67b6-6ba4-fb1a6faa8fae@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David for the review!!

On 2/2/2021 2:54 AM, David Rientjes wrote:
> On Mon, 1 Feb 2021, Charan Teja Reddy wrote:
> 
>> By defination, COMPACT[STALL|FAIL] events needs to be counted when there
> 
> s/defination/definition/\

Done.

> 
>> is 'At least in one zone compaction wasn't deferred or skipped from the
>> direct compaction'. And when compaction is skipped or deferred,
>> COMPACT_SKIPPED will be returned but it will still go and update these
>> compaction events which is wrong in the sense that COMPACT[STALL|FAIL]
>> is counted without even trying the compaction.
>>
>> Correct this by skipping the counting of these events when
>> COMPACT_SKIPPED is returned for compaction. This indirectly also avoid
>> the unnecessary try into the get_page_from_freelist() when compaction is
>> not even tried.
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>  mm/page_alloc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 519a60d..531f244 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4152,6 +4152,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>>  	memalloc_noreclaim_restore(noreclaim_flag);
>>  	psi_memstall_leave(&pflags);
>>  
>> +	if (*compact_result == COMPACT_SKIPPED)
>> +		return NULL;
>>  	/*
>>  	 * At least in one zone compaction wasn't deferred or skipped, so let's
>>  	 * count a compaction stall
> 
> This makes sense, I wonder if it would also be useful to check that 
> page == NULL, either in try_to_compact_pages() or here for 
> COMPACT_SKIPPED?

In the code, when COMPACT_SKIPPED is being returned, the page will
always be NULL. So, I'm not sure how much useful it is for the page ==
NULL check here. Or I failed to understand your point here?

As, till now, COMPACTFAIL also presents page allocation failures because
of the direct compaction is skipped, creating a separate COMPACTSKIPFAIL
event which indicates that 'failed to get the free page as direct
compaction is skipped' is useful?
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
