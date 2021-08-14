Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E143EC0E7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhHNGbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 02:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhHNGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 02:31:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4BC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 23:31:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w24so421419wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtcXPH0QsKZK91gULvtuZyrVdm2c/ou4YyVO9R8Tjas=;
        b=PxDZJi6ym08BAMxJCJEzovKp9hlAwah97TMkUTz7/BxgMh4HQXjtMmEYsI2qi3I6nQ
         ht93C7HpPmAHK2HVBpAeryvv+fNb/JZ9u07iiUTTxl7GG2NFVpPNubA0B/B5X6DSOMuC
         3su9p4rBOoA3MkNjl+Tml9939F1afITOv9jvGsL7u9rab/9uIJvZBXH+TanemvQ1Qir0
         mbsK4e5rm9Nqx2/u5Q0O21HoV0VViCOi2npbMxy9wd9zhvVZQW6v/vT01yklGG16cy9f
         qeyqSD6j+Ri6kUwPhDURMZE5JX6VTX0cxaEazRCwWWk8Vg5LnpIS+WqAYOIRwClyBrtT
         v6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtcXPH0QsKZK91gULvtuZyrVdm2c/ou4YyVO9R8Tjas=;
        b=o2TI8tZOHb41uU33sOFRFSjV2F/QIaC8FwyUZBFpGckZX06VmWSeCL9DCO0c5h+lFy
         d6WK2GhJnb822sKBpST1Q1+i4ASEAMWOglYEVMuJ/rEDOTyuXb4lqbsvb+MDrLLXMccg
         1hHZl6UBelmgp0clycsH7LPcC+b3v1vpeeY7q4u/H3dw8flioXoHG+BpXsvA62rofdFp
         G4rPYQfrw6n+XVmDYqf7KcIkxfX+QUgBGs8HXSZc0306VFsY4ENIloJa7ad0Nedi6Uoj
         XrhNMf2TFEFmsLy5Bmw11bw0m48rP36f/9AjvCv9KTCbFlKlAItPgqFAwuLkrZWv7BGZ
         t3UQ==
X-Gm-Message-State: AOAM530ibbFfr5AMI0FF0O7wr0Mnr6QWfbbc3E35MlL734TZC5WhgyQM
        0f9VSc5QzSxS/+MnQke6sGlKM7INnZw=
X-Google-Smtp-Source: ABdhPJw4iWyxTuMXYHkD5xDsOxLCqNutJt5p1e2SMEjfQAL4FN6es8Ocl07DJV0NAqaVjgHLTnw5Og==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr5983139wml.42.1628922679442;
        Fri, 13 Aug 2021 23:31:19 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::2571? ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id d4sm3788029wrc.34.2021.08.13.23.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 23:31:18 -0700 (PDT)
Subject: Re: [PATCH 0/4] staging: r8188eu: refactor Hal_GetChnlGroup88E()
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210813073109.25609-1-straube.linux@gmail.com>
 <20210813094401.y2d6wehhdtuvbvp4@viti.kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <036352c3-9ed7-b758-0abb-9423a6f248c8@gmail.com>
Date:   Sat, 14 Aug 2021 08:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210813094401.y2d6wehhdtuvbvp4@viti.kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 11:44 AM, Martin Kaiser wrote:
> Thus wrote Michael Straube (straube.linux@gmail.com):
> 
>> This series refactors Hal_GetChnlGroup88E().
>>   - removes 5GHz code
>>   - changes return type to void
>>   - cleans up camel case naming
> 
>> Michael Straube (4):
>>    staging: r8188eu: remove 5GHz code from Hal_GetChnlGroup88E()
>>    staging: r8188eu: convert return type of Hal_GetChnlGroup88E() to void
>>    staging: r8188eu: rename parameter of Hal_GetChnlGroup88E()
>>    staging: r8188eu: rename Hal_GetChnlGroup88E()
> 
>>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 90 ++++++-------------
>>   1 file changed, 26 insertions(+), 64 deletions(-)
> 
>> -- 
>> 2.32.0
> 
> Hi Michael,
> 
> this series looks ok to me.
> 
> Acked-by: Martin Kaiser <martin@kaiser.cx>
> 

Hi Martin,

thank you.

Michael
