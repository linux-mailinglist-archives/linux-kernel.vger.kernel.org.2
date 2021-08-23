Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053763F4C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhHWOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:25:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:24:21 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso36716627ott.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0GkLT6HMfRhAbPekloSJCZfvHcvKIje+CzM5kFXovwo=;
        b=DTe/HJxE8iZ06wj7tEDBIoJ8IEym1Zk7w+BOrEaOkUxRCVuM34SW25e/RJmeoTrDoe
         cvv9w+fLx+LBARTzMpiq9U4z3jHciuC1gyJA+STf1qDTVY7leEGbXrH0lmSl6uwFU5HR
         OUkCQUow3T6U2uqHjYSpA0c+thEf7248GY3dibIU07ZZ2+zB0CD9AazTmmOtJA2WZT+X
         R5cJJrAJ3Ii6by/IajJj9k3sGoKt5640QJV/OlcMm4q9+gnJu7NpKoBaUmOFQ9v2XdJL
         KwQWRv07FX7g7y/VRy5KrWeeNaX5E7CW0sEzNPqxaaWfGGcWPM8kMbPwk0i2okBrncNO
         pL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0GkLT6HMfRhAbPekloSJCZfvHcvKIje+CzM5kFXovwo=;
        b=tLJndkNujElyjGBOMwrkWtXMUw0oVirP55PpPZMWPMtL6n1Qw9MvbZGIKFga4NwbMz
         av5SO9h3U4FrjQCteDMhLIPPn0YAsPl89fsQb6VLFMj85vV+ylMrPOo87d6VtXNlD9ZU
         1FZRYGHqI30/LX+0+DmqUOysRcWn918cKZo4kWW5scBCORzpjcc/zM7W+AcETMrh9GIz
         MHw26OnPHJx6dMjDhkuXUE+CQKYxlMi9+sN/2Ear/LPeZfe+Ez7gGsLu+VrM2EDjuShd
         +uSAozLV9BRhuMH5vn4MT6G7YLqWlLhEIJUVwB5koB6CC6zobOKBg8H9jQHsXvwDsArk
         D1Pg==
X-Gm-Message-State: AOAM533OAXERU5V1iUBBuMSBDicLlvd4qh8pF6bGoDJo1piPwc333YD1
        BPSjqr9a/PDaJCKOPYgsIgNNldr+DE8=
X-Google-Smtp-Source: ABdhPJxr+VuWvoULVTLeCGhFeOnYz52ScqC7ZuZCocnNSn1eq9B8v8zavn7AMSesxRcqMCEKvFSqDA==
X-Received: by 2002:aca:a9c1:: with SMTP id s184mr11191586oie.145.1629728660572;
        Mon, 23 Aug 2021 07:24:20 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id l4sm2317016oth.4.2021.08.23.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 07:24:19 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
 <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
 <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <25d336b5-8008-9b3b-7efe-a82afaea0e98@lwfinger.net>
Date:   Mon, 23 Aug 2021 09:24:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 3:44 AM, Aakash Hemadri wrote:
> On 21/08/21 09:48PM, Aakash Hemadri wrote:
>> Fix sparse warning:
>>> rtw_br_ext.c:836:54: warning: cast to restricted __be32
>>
>> dhpch->cookie is be32, change it's type.
>>
>> Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
>> ---
>>   drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
>> index f6d1f6029ec3..f65d94bfa286 100644
>> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
>> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
>> @@ -649,7 +649,7 @@ struct dhcpMessage {
>>   	u_int8_t chaddr[16];
>>   	u_int8_t sname[64];
>>   	u_int8_t file[128];
>> -	u_int32_t cookie;
>> +	__be32 cookie;
>>   	u_int8_t options[308]; /* 312 - cookie */
>>   };
>>   
>> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>>   				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
>>   					struct dhcpMessage *dhcph =
>>   						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
>> -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
>> +					u32 cookie = be32_to_cpu(dhcph->cookie);
>>   
>>   					if (cookie == DHCP_MAGIC) { /*  match magic word */
>>   						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
>> -- 
>> 2.32.0
>>
> 
> David Laight suggested to use get_unaligned_be32, I am not sure if it's
> the right thing to do because as far as I understand get_unaligned_be32
> byteshifts the argument.
> 
> Can someone please confirm if this change is okay?
> 

It is not needed. variable dhcph->cookie is 4-byte aligned. Usind the unaligned 
version would just add cpu cycles and arrivw at the same point!

Larry

