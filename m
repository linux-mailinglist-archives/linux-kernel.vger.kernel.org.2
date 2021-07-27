Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB543D6D99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhG0Enr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:43:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55162 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234745AbhG0Eno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:43:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627361025; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=l0LBbkn2wIgdM60dnKzVULyBKqRCDMcLHAj1YaazBvI=; b=ppYO1RhkUkdQ3YyWSa5cnWsV3ASh4ZMetEHUME1fEByfv4sglJytdCVtNKdp+EYfLF/XJ7Se
 3GamzMxI+XQuyAur50rioP3DAQ0slWx3c0orwJYe+cyBwpdLJNishw4qf5/8dyMY/1Uv0O0C
 KLft1dAvFPlAQSAPrFyJFTV55D4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60ff8ef4e81205dd0a845e21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Jul 2021 04:43:32
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D958C43144; Tue, 27 Jul 2021 04:43:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.102] (unknown [14.192.2.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CA9DC4323A;
        Tue, 27 Jul 2021 04:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CA9DC4323A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] mm: slub: Fix slub_debug disablement for list of slabs
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org>
 <bf2a8571-325c-6d94-0d5a-f6df71ae0c4f@suse.cz>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <e0442add-dcf0-57d7-2298-3459136673af@codeaurora.org>
Date:   Tue, 27 Jul 2021 10:13:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <bf2a8571-325c-6d94-0d5a-f6df71ae0c4f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2021 4:02 AM, Vlastimil Babka wrote:
> On 7/13/21 1:45 PM, vjitta@codeaurora.org wrote:
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
> 
> Would the following work too, and perhaps be easier to follow?

Right, the below change would also work and its easier to follow as you
said. We can go with this.

Reviewed-by: Vijayanand Jitta <vjitta@codeaurora.org>

Thanks,
Vijay

> ----8<----
> diff --git a/mm/slub.c b/mm/slub.c
> index 090fa14628f9..024f49706386 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1400,12 +1400,13 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
>  static int __init setup_slub_debug(char *str)
>  {
>  	slab_flags_t flags;
> +	slab_flags_t global_flags;
>  	char *saved_str;
>  	char *slab_list;
>  	bool global_slub_debug_changed = false;
>  	bool slab_list_specified = false;
>  
> -	slub_debug = DEBUG_DEFAULT_FLAGS;
> +	global_flags = DEBUG_DEFAULT_FLAGS;
>  	if (*str++ != '=' || !*str)
>  		/*
>  		 * No options specified. Switch on full debugging.
> @@ -1417,7 +1418,7 @@ static int __init setup_slub_debug(char *str)
>  		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
>  
>  		if (!slab_list) {
> -			slub_debug = flags;
> +			global_flags = flags;
>  			global_slub_debug_changed = true;
>  		} else {
>  			slab_list_specified = true;
> @@ -1426,16 +1427,18 @@ static int __init setup_slub_debug(char *str)
>  
>  	/*
>  	 * For backwards compatibility, a single list of flags with list of
> -	 * slabs means debugging is only enabled for those slabs, so the global
> -	 * slub_debug should be 0. We can extended that to multiple lists as
> +	 * slabs means debugging is only changed for those slabs, so the global
> +	 * slub_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
> +	 * on CONFIG_SLUB_DEBUG_ON). We can extended that to multiple lists as
>  	 * long as there is no option specifying flags without a slab list.
>  	 */
>  	if (slab_list_specified) {
>  		if (!global_slub_debug_changed)
> -			slub_debug = 0;
> +			global_flags = slub_debug;
>  		slub_debug_string = saved_str;
>  	}
>  out:
> +	slub_debug = global_flags;
>  	if (slub_debug != 0 || slub_debug_string)
>  		static_branch_enable(&slub_debug_enabled);
>  	else
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
