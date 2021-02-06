Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD8311AB7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBFELS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:11:18 -0500
Received: from so15.mailgun.net ([198.61.254.15]:36077 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhBFCz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:55:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612580110; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Wp8L5Uv0x1WmD2G3Tgk2vfJDnMP6rhkD3cr6tfJd2/Y=; b=cGSG9/3zOgSsUosG1vpJDIvJ6Vp1CKWRKvybbzBKO7hz1N84R4Vq8pgt8QYtg5wvQ1M1Z84i
 Ffl0vddeQb2yHkDiA/+9M00QWw2jwDB9YrRKPZPyRnKBKVcUzmkOROkZZN7YNV3AVD6MzVan
 HzhOLW+m10g0qdlRdcCQARh7P1w=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 601df77734db06ef798aa116 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Feb 2021 01:57:11
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5203C43463; Sat,  6 Feb 2021 01:57:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.158.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DFC5C433C6;
        Sat,  6 Feb 2021 01:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DFC5C433C6
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
 <160ba3b5-2cd4-5ff0-1348-fb477cefd33d@codeaurora.org>
 <1213f4c6-7557-268d-253e-23f8fea55b19@google.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <8a03203b-e6dd-3a86-5b83-33d9c6adcc11@codeaurora.org>
Date:   Sat, 6 Feb 2021 07:27:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1213f4c6-7557-268d-253e-23f8fea55b19@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2021 3:58 AM, David Rientjes wrote:
>> In the code, when COMPACT_SKIPPED is being returned, the page will
>> always be NULL. So, I'm not sure how much useful it is for the page ==
>> NULL check here. Or I failed to understand your point here?
>>
> Your code is short-circuiting the rest of  __alloc_pages_direct_compact() 
> where the return value is dictated by whether page is NULL or non-NULL.  
> We can't leak a captured page if we are testing for it being NULL or 
> non-NULL, which is what the rest of __alloc_pages_direct_compact() does 
> *before* your change.  So the idea was to add a check the page is actually 
> NULL here since you are now relying on the return value of 
> compact_zone_order() to be COMPACT_SKIPPED to infer page == NULL.
> 
> I agree that's currently true in the code, I was trying to catch any 
> errors where current->capture_control.page was non-NULL but 
> try_to_compact_pages() returns COMPACT_SKIPPED.  There's some complexity 
> here.

Thanks for the detailed explanation. This looks fine to me. I will send
V2 with this information in the commit log.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
