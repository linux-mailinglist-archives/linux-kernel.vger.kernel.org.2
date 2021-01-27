Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC77330603E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhA0Pw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:52:56 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:60810 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233939AbhA0PtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:49:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611762521; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=KK5LTyLrZxs4hbfirnv0cqVe1btPvHM4AcbOjvUNy6k=; b=aOz/NoO23x11YpN9ymCo8daHZDc2Jy2vUEzSNCWULSSLriudVbfWyydj2e+C4yz6gbaa/zid
 b7F+Eqs5Iu5FhNSYSs3tmSbom2J50UFbjF4aUt9IFycVgnu33n6E8iXUCzlacjbKMPMj7VHl
 XkYqgDsggVX3RgbQbZiSeIlJqlA=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60118b35a2f5d01cec56d505 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 15:48:05
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3048C43468; Wed, 27 Jan 2021 15:48:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.144.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B2F4C43462;
        Wed, 27 Jan 2021 15:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B2F4C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V3] mm/compaction: correct deferral logic for proactive
 compaction
To:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
 <af22a056-5c27-256f-74d-63de8fd33084@google.com>
 <80a1a433-c520-4c73-61ce-55cf33739fc5@suse.cz>
 <627a82ec-94ef-a233-4637-28bc82a886e9@google.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <7ce8f4f1-0d83-bb85-e516-33071d85ad3a@codeaurora.org>
Date:   Wed, 27 Jan 2021 21:17:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <627a82ec-94ef-a233-4637-28bc82a886e9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2021 4:24 AM, David Rientjes wrote:
> On Wed, 20 Jan 2021, Vlastimil Babka wrote:
> 
>> On 1/19/21 8:26 PM, David Rientjes wrote:
>>> On Mon, 18 Jan 2021, Charan Teja Reddy wrote:
>>>
>>>> should_proactive_compact_node() returns true when sum of the
>>>> weighted fragmentation score of all the zones in the node is greater
>>>> than the wmark_high of compaction, which then triggers the proactive
>>>> compaction that operates on the individual zones of the node. But
>>>> proactive compaction runs on the zone only when its weighted
>>>> fragmentation score is greater than wmark_low(=wmark_high - 10).
>>>>
>>>> This means that the sum of the weighted fragmentation scores of all the
>>>> zones can exceed the wmark_high but individual weighted fragmentation
>>>> zone scores can still be less than wmark_low which makes the unnecessary
>>>> trigger of the proactive compaction only to return doing nothing.
>>>>
>>>> Issue with the return of proactive compaction with out even trying is
>>>> its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
>>>> the scores across the proactive compaction is same, thinking that
>>>> compaction didn't make any progress but in reality it didn't even try.
>>>
>>> Isn't this an issue in deferred compaction as well?  It seems like 
>>> deferred compaction should check that work was actually performed before 
>>> deferring subsequent calls to compaction.
>>
>> Direct compaction does, proactive not.
>>
>>> In other words, I don't believe deferred compaction is intended to avoid 
>>> checks to determine if compaction is worth it; it should only defer 
>>> *additional* work that was not productive.
>>
>> Yeah, that should be more optimal.
>>
> 
> Charan, is this something you'd like to follow up on, or should I take a 
> look instead?
> 

Sure David. Happy to follow up on this. Thanks!

> Thanks!
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
