Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5493CF498
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbhGTF4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:56:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55153 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242337AbhGTFz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:55:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626762966; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=YE1T2xZb6fDHPiJnhikKXUdq3LSoAaWqTEG2r5s1rx4=; b=ZJTdmAvExrERjXCa5Rv0dIFbmBo8SDt8oHCktNTYol5FmS4ewgaidrSNPktQmmdb5SnaOPcC
 gaTxOhWjJkYGBkLwFemmBJnQNbytSKnvyqm9TuUs4DFlmJhpnwYtlsSBl6mlyQT386YZLLYy
 yk3YPPzX/RXsLQyBkYTmCEh5s2k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f66ec64815712f3aa12a80 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Jul 2021 06:35:50
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E35FC433F1; Tue, 20 Jul 2021 06:35:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.103] (unknown [14.192.2.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE5BAC433F1;
        Tue, 20 Jul 2021 06:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE5BAC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] mm: slub: Fix slub_debug disablement for list of slabs
To:     David Rientjes <rientjes@google.com>
Cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org>
 <dfcaaf6b-9a23-41f8-7baf-187e7c83e20@google.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <d34f793d-7c7e-aec4-a1a3-eab233dc11ab@codeaurora.org>
Date:   Tue, 20 Jul 2021 12:05:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <dfcaaf6b-9a23-41f8-7baf-187e7c83e20@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2021 11:51 AM, David Rientjes wrote:
> On Tue, 13 Jul 2021, vjitta@codeaurora.org wrote:
> 
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> Consider the scenario where CONFIG_SLUB_DEBUG_ON is set
>> and we would want to disable slub_debug for few slabs.
>> Using boot parameter with slub_debug=-,slab_name syntax
>> doesn't work as expected i.e; only disabling debugging for
>> the specified list of slabs, instead it disables debugging
>> for all slabs. Fix this.
>>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>  mm/slub.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index dc863c1..5a88418 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1429,6 +1429,7 @@ static int __init setup_slub_debug(char *str)
>>  	char *slab_list;
>>  	bool global_slub_debug_changed = false;
>>  	bool slab_list_specified = false;
>> +	bool slab_list_debug_disable = true;
>>  
>>  	slub_debug = DEBUG_DEFAULT_FLAGS;
>>  	if (*str++ != '=' || !*str)
>> @@ -1436,7 +1437,6 @@ static int __init setup_slub_debug(char *str)
>>  		 * No options specified. Switch on full debugging.
>>  		 */
>>  		goto out;
>> -
>>  	saved_str = str;
>>  	while (str) {
>>  		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
>> @@ -1445,6 +1445,8 @@ static int __init setup_slub_debug(char *str)
>>  			slub_debug = flags;
>>  			global_slub_debug_changed = true;
>>  		} else {
>> +			if (flags || !IS_ENABLED(CONFIG_SLUB_DEBUG_ON))
> 
> Could you explain the check for CONFIG_SLUB_DEBUG_ON here?
>
Thanks for the review.

The check for CONFIG_SLUB_DEBUG_ON is for below scenario:

Consider CONFIG_SLUB_DEBUG_ON is not set and the below boot parameter is
set incorrectly "slub_debug=-,slab_name", Now without the additional
CONFIG_SLUB_DEBUG_ON check slab_list_debug_disable will still be true
and slub_debug will be set to DEBUG_DEFAULT_FLAGS instead of 0 as the
below check fails.

if (!global_slub_debug_changed && !slab_list_debug_disable)
	slub_debug = 0;

> I don't believe that using `-' for slub_debug is *only* useful when 
> CONFIG_SLUB_DEBUG_ON is enabled.
> 

'-' is still useful in CONFIG_SLUB_DEBUG_ON disabled case even with the
above check, all the possible cases using '-' work as expected.

i.e;
slub_debug=-.slab_name
slub_debug=flag,slab_name;-,slab_name

Thanks,
Vijay

>> +				slab_list_debug_disable = false;
>>  			slab_list_specified = true;
>>  		}
>>  	}
>> @@ -1456,7 +1458,7 @@ static int __init setup_slub_debug(char *str)
>>  	 * long as there is no option specifying flags without a slab list.
>>  	 */
>>  	if (slab_list_specified) {
>> -		if (!global_slub_debug_changed)
>> +		if (!global_slub_debug_changed && !slab_list_debug_disable)
>>  			slub_debug = 0;
>>  		slub_debug_string = saved_str;
>>  	}

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
