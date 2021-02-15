Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4A31BB28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBOOdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhBOOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613399541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5iotNNVRDZZFpt9DojBqreSnQL5CMIXscXuC8GHPa8=;
        b=etvl1tai5dPslsQYmGHjRQwpXK4rw66nb3GW3WhOVzPQI7KVE4QRX3oJ1Cvq0Ilv88mOF4
        w27BsQb2pSNISujhqaUBOHXTQJkdGwmE7CXUpYQLc4r6dtaH7/3AaGrmzOYv6kN6Z8M/W1
        +eo8fcs07IKBryZvaOmBClOLpRG6A1Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-0a8Y_DXzO4ug7F1VIqSJ7A-1; Mon, 15 Feb 2021 09:32:19 -0500
X-MC-Unique: 0a8Y_DXzO4ug7F1VIqSJ7A-1
Received: by mail-qv1-f70.google.com with SMTP id e6so5268810qva.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V5iotNNVRDZZFpt9DojBqreSnQL5CMIXscXuC8GHPa8=;
        b=jk+8qCQNZxY5URE2hGJP+WTmbBjrxh/nVkoL/LUbMtCGRr813Jsw7NwbfkQ1a8hua3
         0ffEO/rWunNChr+E7ht3eKCPShivNQxEFG+4FMBmNFAb1A9NT14lqCdv8iYp9dLG0d9t
         tplyz24HocBKDLMCbEfNPKwavLOwSTDaRW6LjrZ85Q1M9kYHQs/nNBxDo7zwkh3thb94
         eKTIS1QGSIFgBZxLt7AzTTSlRlgfjjV1Wb+u9zf7IiZ6HDS5vj/mhgt8geuHgvfaStK0
         VE/yj0fL6suJfm6GUDCwk+cvuysEUoZ5+jFRRxqMYbY17T/CoXt6ToF6xkP+A/bkRKkz
         NfNQ==
X-Gm-Message-State: AOAM530FVMPtKPaeyGy/H7bVFnoLVTQtMKjSkaU3JpXXOocHghVEnFL3
        hiGwyfMP6k2+S3gGBsNmNalpmXxBSs+BBlLxIw60pP+/+5BY/tKmL61mH1xyQcO3ICfsarCEWyq
        ZiugNQA8GqypP50WTNo+0fgga
X-Received: by 2002:ac8:4d45:: with SMTP id x5mr14412656qtv.339.1613399539384;
        Mon, 15 Feb 2021 06:32:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyzm183aQbQZxgKjyU7MLFXVJ6Mlub05Cm/l5b+A3lD2FZd7RebwG5Xiuj0JTWTj0dd3dV2w==
X-Received: by 2002:ac8:4d45:: with SMTP id x5mr14412643qtv.339.1613399539207;
        Mon, 15 Feb 2021 06:32:19 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q6sm12083067qkd.41.2021.02.15.06.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 06:32:18 -0800 (PST)
Subject: Re: [PATCHv5 1/7] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
To:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
 <bc43e8ab-b8df-fd2f-31e4-02cdc48cadff@redhat.com>
 <3ff3e9ca-cdca-796e-0b57-5010963e7ee1@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <12eb2031-db0a-4c00-117e-f3ee8dd15978@redhat.com>
Date:   Mon, 15 Feb 2021 06:32:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3ff3e9ca-cdca-796e-0b57-5010963e7ee1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/21 6:41 AM, Richard Gong wrote:
> Hi Tom,
>
> On 2/13/21 9:44 AM, Tom Rix wrote:
>>
>> On 2/9/21 2:20 PM, richard.gong@linux.intel.com wrote:
>>> From: Richard Gong <richard.gong@intel.com>
>>>
>>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
>>> aligns with the firmware settings.
>>>
>>> Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")
>>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>>> ---
>>> v5: new add, add the missing standalone patch
>>> ---
>>>   include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>>> index a93d859..f843c6a 100644
>>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>>> @@ -56,7 +56,7 @@
>>>    * COMMAND_RECONFIG_FLAG_PARTIAL:
>>>    * Set to FPGA configuration type (full or partial).
>>>    */
>>> -#define COMMAND_RECONFIG_FLAG_PARTIAL    1
>>> +#define COMMAND_RECONFIG_FLAG_PARTIAL    0
>>
>> Is this the stand alone fix split from v3's patch 1 ?
>>
>> https://lore.kernel.org/linux-fpga/YBFW50LPP%2FyEbvEW@kroah.com/
>> Yes, it is a stand-alone patch.

Thanks.

Reviewed-by: Tom Rix <trix@redhat.com>

>
>> Tom
>>
>>>     /**
>>>    * Timeout settings for service clients:
>>
> Regards,
> Richard
>

