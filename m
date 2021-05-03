Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAA371EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhECRiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhECRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:38:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:37:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i26so6146538oii.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1t1KFawxYQnhUD83BXZON5c+I9V+6Zm5vY5OwXhyWio=;
        b=kA5Kuz7NATBEr8XwwT8JD+RGGvAQ5TGvjuTr9YOBmGqJasqgukewX0AhaQKXLGgjMg
         /iMEC4zweiCWDjmfCuseq+UeugkRUSN05I3DxnVNoIfh6CXWTBC5de8EiUnE1oBtCSKR
         kkGJYkVZ++HOnlOJhtyQF1wez4smdPHk7ZvSUun0+AOyb74yA6XdY7g/x3NcV2qHw4sA
         xIypnPvH5L9Fsr0bk/xPkwWwG6VOeTZiq/3sMiLuYLoeSsvx8BHRi9lMRlrXJrMIpjNM
         qFfIHxUJi7SxypwqmEh9DAgWgIANiRcFoldj3lA5FM/Rm+n/mzALumHmkINw8mnY6d02
         WGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1t1KFawxYQnhUD83BXZON5c+I9V+6Zm5vY5OwXhyWio=;
        b=kzbQYzbbmQIJ04mKqPvQ6LPF/b87zj53rSb2zzK1AL3+gZAc26m9msXYMQwPGoKM9F
         tA1e52DZm/e3aQZKr2z5ltF/ZzHKDl5k6titn8k4EC4tLfeJYLJnQ6FKkryZ7sI4YWem
         oaXnYzgwc4OcnWCU4I6dxh3qziO8fASi2h0IyCIgCofUnxSVbY1Aw6M6vXLK108waWMi
         Dx1AP1BDQuJhAKrsbOZleabwm/7lyIuli9CE8WXhYUbgNUMWaXWSQL7CjHEFMH7jmAoM
         aB0gQVwFvL1OFg7mUCvTsNcSx878k8kWW/DQOrbhrkC/o7HCfI2VZ0/Uh39xSuP1MNvT
         Bxmg==
X-Gm-Message-State: AOAM531S0l+Qlfc1i+IHSB9QBFZ4YKplyxrkBP0Ljc2TQpOz1CO+aig8
        h4ttFKrfoqNPfAtm2v3tRuezpCLpvRc=
X-Google-Smtp-Source: ABdhPJyp3wlyDlW4UUKIwWYd8l9YfM1NC1KgaDjlaiLDTq3BB4YMrQJd35a/4q2fRpFNW0JftaLy8w==
X-Received: by 2002:aca:4c58:: with SMTP id z85mr2894675oia.46.1620063431457;
        Mon, 03 May 2021 10:37:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p189sm95372oif.31.2021.05.03.10.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:37:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210428173301.149619-1-linux@roeck-us.net>
 <YJApQTRSEWUuR4qd@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c317df15-1414-3765-1040-4938a9a48776@roeck-us.net>
Date:   Mon, 3 May 2021 10:37:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJApQTRSEWUuR4qd@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 9:48 AM, Greg Kroah-Hartman wrote:
> On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:  
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
>> index 85663182b388..9cb2c7a112d2 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
>> @@ -124,11 +124,8 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
>>  	spin_lock_bh(&pstapriv->sta_hash_lock);
>>  
>>  	phead = get_list_head(&pstapriv->free_sta_queue);
>> -	plist = get_next(phead);
>> -
>> -	while (phead != plist) {
>> -		psta = container_of(plist, struct sta_info, list);
>> -		plist = get_next(plist);
>> +	list_for_each(plist, phead) {
>> +		psta = list_entry(plist, struct sta_info, list);
>>  	}
>>  
>>  	spin_unlock_bh(&pstapriv->sta_hash_lock);
> 
> 
> This chunk didn't apply to my tree as someone else cleaned something in
> this function.
> 
> But that doesn't even really matter as this function does nothing at
> all!
> 

You are correct. Weird.

Guenter
