Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F88322A89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhBWMbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:31:16 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:30623 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhBWMaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:30:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614083436; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RCyGcMrLAoXPkwdjDqoRBfFHog9HDnSKHwrh4kSkF7w=; b=E3jRwiiE4r7VeIpyKuip2GfYX0xoORTYqzWPyYtiu9gtrZRKdgh/ox4yXjSaG6mqtXudpRIp
 vvxtTdhHFB6ZDpfBVe9q4YeffcQtrJAYmUKGw1wbEqeYx1NbdDnKRlWhBr1GZsvaDBDpXpbM
 6TQeHrtkqBKt1A4A6Kri7H6z3Do=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6034f54fe87943df30eb0d9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Feb 2021 12:30:07
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3A6EFC433C6; Tue, 23 Feb 2021 12:30:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.158.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 756DCC433C6;
        Tue, 23 Feb 2021 12:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 756DCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH RFC 0/1] mm: balancing the node zones occupancy
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        rientjes@google.com, vbabka@suse.cz, mhocko@suse.com,
        mgorman@techsingularity.net, linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, sudaraja@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <cover.1613661472.git.charante@codeaurora.org>
 <82e0e9c2-8187-8e2f-0d5e-304dafcda017@redhat.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <d1590275-b70d-5e09-5047-cc0fa268b583@codeaurora.org>
Date:   Tue, 23 Feb 2021 18:00:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <82e0e9c2-8187-8e2f-0d5e-304dafcda017@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks David for the review comments!!

On 2/18/2021 11:46 PM, David Hildenbrand wrote:
>> I would like to start discussion about  balancing the occupancy of
>> memory zones in a node in the system whose imabalance may be caused by
>> migration of pages to other zones during hotremove and then hotadding
>> same memory. In this case there is a lot of free memory in newly hotadd
>> memory which can be filled up by the previous migrated pages(as part of
>> offline/hotremove) thus may free up some pressure in other zones of the
>> node.
> 
> Why is this specific to memory hot(un)plug? I think the problem is more
> generic:
> 
> Assume
> 
> 1. Application 1 allocates a lot of memory and gets ZONE_MOVABLE.
> 2. Application 2 allocates a lot of memory and gets ZONE_NORMAL.
> 3. Application 1 quits.
> 
> Same problem, no?

Thanks for simplifying this problem. Yeah, this looks more generic
problem. But for these type of problems, user/system administrator has
clear view about the state of the system and thus may need to take some
decisions to maintain the the node zones balancing e.g. like this change
where migrate the eligible pages to other zones.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
