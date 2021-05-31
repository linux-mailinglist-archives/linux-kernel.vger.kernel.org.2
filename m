Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53239596F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhEaLJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:09:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21332 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaLJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:09:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622459292; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Je2jG62bL2bT7Cs5lG5xTsh/f/2D1DPuOzZ1sWvFbZE=; b=f2gseDigj950Ulgo7rRyv2Irel1U04zGbbWmgy/9dK64tLitXimVqlAF69XvQnEUJFgajgag
 xWbywpW4S2QuzqlOa5JjX3d/AukxxaHaw0VsuLjsJqyS9F0yZSyu2JbdmF7e/jNYEo8awVTT
 GFLZJ6MMQPhy+dhrwdzWvuwRzk8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60b4c38c8491191eb3c05a4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 11:07:56
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4FBBC4360C; Mon, 31 May 2021 11:07:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.86.187] (unknown [49.204.181.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A50C5C433F1;
        Mon, 31 May 2021 11:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A50C5C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
 <b43fad97-5f40-c94a-7cb4-9a31edd6668f@codeaurora.org>
 <dca0fe16-18ed-fa6f-6062-2659e061c26b@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <d53ca307-49a7-9999-f3d1-b8c03ab25773@codeaurora.org>
Date:   Mon, 31 May 2021 16:37:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <dca0fe16-18ed-fa6f-6062-2659e061c26b@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2021 3:25 PM, Vlastimil Babka wrote:
> On 5/31/21 8:55 AM, Faiyaz Mohammed wrote:
> 
>>> I don't see any of the symlinks under /sys/kernel/debug/slab/, so I think the
>>> aliases handling code is wrong, and I can see at least two reasons why it could be:
>>>
>>
>> I think I missed one thing, when CONFIG_SLUB_DEBUG_ON enable or
>> slub_debug is pass through command line __kmem_cache_alias() will return
>> null, so no symlinks will be created even if CONFIG_SLAB_MERGE_DEFAULT
>> is enable and to store user data we need to enable CONFIG_SLUB_DEBUG_ON
>> or pass slub_debug through command line.
> 
> So you're saying that caches with SLAB_STORE_USER can never be aliases as the
> merging logic will prevent merging with any debug flag, including STORE_USER. So
> if we ignore aliases, it means we will not create the debugfs files for caches,
> where opening the files would just return error, so we don't lose anything by
> not creating the files in the first place.
> 
> In that case, for consistency I would recommend to skip debugfs creation for all
> caches without SLAB_STORE_USER (even if the caches are not an alias). I think we
> can make this decision now as it's a whole new debugfs subtree so we don't break
> any pre-existing code.
> 

Hmmm, I think yes we can skip debugfs creation for all cache without
SLAB_STORE_USER	flag set instead of returning error after opening of
file. I will do the change in next patch version.

Thanks and regards,
Mohammed Faiyaz
