Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA436322BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBWNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:46:25 -0500
Received: from z11.mailgun.us ([104.130.96.11]:26226 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBWNqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:46:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614087962; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=q+9rPbpfOFwFc2NgncWfqaEw2Cv1mL6rgZsV2hVae08=; b=ckvNR8m1VjXPhibN9lJS3AvfEyQZHaEpCPI8X/JyAqlclXTbcIbYkGor7n4bfE/BWqu5kmtU
 oTL5WmKIZc8RyunLdTJGyW8uEJCeDW+8RaGjE7TwH/eqUgJZFbK75uD7C/KaycPhqWKs4cHK
 Mg2llafyU5edgpP8kqS+JY2WAQw=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 603506f5090a774287f6c963 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Feb 2021 13:45:25
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC64CC43466; Tue, 23 Feb 2021 13:45:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.158.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B11B5C433C6;
        Tue, 23 Feb 2021 13:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B11B5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH RFC 0/1] mm: balancing the node zones occupancy
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        rientjes@google.com, mhocko@suse.com, david@redhat.com,
        mgorman@techsingularity.net, linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, sudaraja@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <cover.1613661472.git.charante@codeaurora.org>
 <1c445421-ddeb-8768-03d0-81537b0d1875@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <ee78c83d-da9b-f6d1-4f66-934b7782acfb@codeaurora.org>
Date:   Tue, 23 Feb 2021 19:15:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1c445421-ddeb-8768-03d0-81537b0d1875@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vlastimil for the review comments!!

On 2/19/2021 4:56 PM, Vlastimil Babka wrote:
> Can you share the use case for doing this? If it's to replace a failed RAM, then
> it's probably extremely rare, right.
> 
>> We have the proof-of-concept code tried on the Snapdragon systems with
>> the system configuration, single memory node of just 2 zones, 6GB normal
>> zone and 2GB movable zone. And this Movable zone is such that hot-added
>> once and there after offline/online based on the need.
> Hm, snapdragon... so is this some kind of power saving thing?
> 

You are correct. This is the power saving usecase which does the offline
and online of the memory blocks in the system by the user. This is not a
failed RAM.

> Anyway, shouln't auto NUMA balancing help here, and especially "Migrate Pages in
> lieu of discard" (CC'd Dave) as a generic mechanism, 

On the Snapdragon systems we have got only single memory node with
Normal and movable zones. And my little understanding is that on most
embedded systems we will just have single memory node.

My limited understanding about this auto NUMA balancing is that there
should be min. 2 nodes for this balancing to trigger. Please correct if
I am wrong here. If I am correct then this approach is not suitable for
us. Moreover the idea I would like to convey in this RFC patch is about
__balancing the zones in a node but not across NUMA nodes__.

> so we wouldn't need to have hotplug-specific actions?
David has told a very simple view of this problem which is nothing todo
with the hotplug specific actions.

With just 2 zones(Normal and Movable) in a single node in the system,

1. Application 1 allocates a lot of memory and gets ZONE_MOVABLE.
2. Application 2 allocates a lot of memory and gets ZONE_NORMAL.
3. Application 1 quits.

Then after step3, we can expect a lot free memory in the Movable zone
but normal zone is under pressure. Applying the similar semantics of
Auto numa balancing("Migrate pages in lieu of swap/discard"), we could
migrate some eligible pages of Application 2 to Movable zone there by
can relieve some pressure in Normal zone.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
