Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E88377634
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 12:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhEIKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhEIKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 06:20:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD58C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 03:19:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n205so7568054wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M0bkUeXYPhnIUVhNGq+tOx9WjWx9RYLlW738sWjVtpY=;
        b=CXivvTV1OFjggjNeH5cTybc7YMn1hMqwt6i2wEDPUK9t+CQym+vgynzBtrN0nHgkZy
         wcEo992HBaa+hb45stE2Jxh1/0/3sasqPp+/4cd4OG3AkdiIveceBVhm7da3KoXE2Ydf
         exbvp7Otq7dC9Au1se66sSXJd82VwjksRTYiam3SFFL+ehYTBdzH6vms4FJ+6I8+f3TV
         3m7FsLhMOVDgx61p7lvRoa3evVfH8RdNzv0fFiJpvRw5/9JRFCKHfMc9hCd3R9Pd78Tb
         pQhIVsAQY0XLRxm+U7zhC3+nB4c7q4nTYULALx8hIpzWFaMhqo+SkQ1X9FQQVnkZ4BJg
         eD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0bkUeXYPhnIUVhNGq+tOx9WjWx9RYLlW738sWjVtpY=;
        b=sBpW84FS4U8P9iY6For2bft9+Rr11dBrO8wB6yjwt4D20RFKeUc04lrnKmccgCd1B/
         c6umIXBeybYaDWn5Dykkukr+7I8EfkB6SKTqhaLdOI0dPm9rneg1/AnZ+ItAwqPPzQqO
         liPSHywktSvIwRua3LRA6JGAAhF2o9sLLB3scJIFzbNucDu5ESUxOz7ye0nRGmzNWQkh
         HW/67M73LkIoOYvci+wrAamk04T1/WPWX7Eog471e4c4d9DZSTHHa4X9vSRF9+L2UdYH
         +wLSPD+w7mCwihRmNdovTOSwCoPl+OMpV4FqMzGiMeGYWVcoVw29Lzx6IfH9nDdODdBg
         ohYg==
X-Gm-Message-State: AOAM532drXm6Xq/n6pefOP0TyI4VfMr3JR9f/rwIZRSfONUMvjtX6vhd
        PrQrIAWuhUp7ikXF8nogblE=
X-Google-Smtp-Source: ABdhPJwCynxQ7r6sJCveGge5h+pxbIEFHJFhfcM1fNQ+STs3RlYvBb+WNOjZICcYOunr1/mcYILScA==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr32030622wmc.79.1620555581994;
        Sun, 09 May 2021 03:19:41 -0700 (PDT)
Received: from [10.21.182.168] ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w7sm17238435wru.51.2021.05.09.03.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 03:19:41 -0700 (PDT)
Subject: Re: [PATCH 046/190] Revert "net/mlx4_core: fix a memory leak bug."
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-47-gregkh@linuxfoundation.org>
 <1027d8d1-5cea-0a04-4974-3f9672ff7d4e@gmail.com> <YIgK2Hbnmxz2dPCe@kroah.com>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
Message-ID: <fb1d28e2-f715-9053-7c77-d618a92fa729@gmail.com>
Date:   Sun, 9 May 2021 13:19:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIgK2Hbnmxz2dPCe@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2021 4:00 PM, Greg Kroah-Hartman wrote:
> On Mon, Apr 26, 2021 at 02:18:37PM +0300, Tariq Toukan wrote:
>>
>>
>> On 4/21/2021 3:58 PM, Greg Kroah-Hartman wrote:
>>> This reverts commit febfd9d3c7f74063e8e630b15413ca91b567f963.
>>>
>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>> faith" to try to test the kernel community's ability to review "known
>>> malicious" changes.  The result of these submissions can be found in a
>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>
>>> Because of this, all submissions from this group must be reverted from
>>> the kernel tree and will need to be re-reviewed again to determine if
>>> they actually are a valid fix.  Until that work is complete, remove this
>>> change to ensure that no problems are being introduced into the
>>> codebase.
>>>
>>> Cc: Qiushi Wu <wu000273@umn.edu>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>    drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
>>> index f6cfec81ccc3..380e027ba5df 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx4/fw.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
>>> @@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struct *work)
>>>    		if (err) {
>>>    			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
>>>    				 err);
>>> -			goto out;
>>> +			return;
>>>    		}
>>>    		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
>>>    		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);
>>>
>>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>>
>> The original commit febfd9d3c7f74063e8e630b15413ca91b567f963 is a bad
>> commit. Not to be re-submitted.
> 
> Thanks for the review, will keep!
> 
> greg k-h
> 

Hi Greg,

I got confused with another error handling code in same function.

After a second look, original commit 
febfd9d3c7f74063e8e630b15413ca91b567f963 looks fine to me.

Regards,
Tariq
