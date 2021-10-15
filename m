Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D557542FAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbhJOSV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbhJOSVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:21:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB12C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:19:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v127so3192868wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R/dz9+WiCzlF7Mip7NpDVh0nc3yRnz/ch3JiE8P+Gec=;
        b=n9ZhygoEwy6GIbJWEKJbPGMoh4j1vFIJRpHwMe+FzMGv7A3ZowubZZxgNQCjo/BN8k
         poFov7qVco1ERmPYhEkEcLKwIapVzTPC/2L7ED4zGJfv/0JtEVj6+7xUheXnSKS3hsxA
         0QLfKpCJHrTQ6i8B9SlktCeWLw4s+BE3OXKodW0Hg3yTZhjWXY4FdRvLCCwos49oe6An
         ZMhVXfs5YKUfzUhc9oLFcFk/eEuSEpHiVKJiA1/bxopPAyquB/1wTb/oQdbvTfEFEyPo
         umwnVIsUW5vD5D66JmV+fQKB4jPRMd+8T88tK8hp7DbXiZx8Og/7HtbXj+9eMnu706hU
         ij4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/dz9+WiCzlF7Mip7NpDVh0nc3yRnz/ch3JiE8P+Gec=;
        b=EHOmXo0GOTgefZ5DPbI/rlqcr2sK7XZyvz8CtTe0OMc9W72sx+97x2Lnvt60GLurOx
         Ytag51TWHKUumYxMvDY5AhdfaDx/psuwuVZtGBmHEjknONniKKT0tcEwNfe+DmwkY3sW
         AsQgy2vjx02LzuLujUE+SvN8wVGOGxShvAKMaqx7SmTjMZ8ZnrmkebS7vRKPxumsVHKP
         8LdJTz6mY6a5wxHiagIytG3RYSnMpgFk0T/30bjE7n8gDXMagyNv2GlF0LLWazfRmSAc
         WXhrkPaJRUYBYFxatMU7bkeJlSpppaB7ZGArAGR+ad09iOY1TFhmL+TAQ/IDWFI0HgOp
         gcvA==
X-Gm-Message-State: AOAM530Ua35mJtATec7sF6KhHLiNSXXdlgWT7xhrO+8/Q6dilNDTySkW
        ciKjLSqFjJNyYfzobwirIFU=
X-Google-Smtp-Source: ABdhPJxOLZD9ADgpllTByySgB7oz5wprdBfEFUcsccB1dnwRDJNjkkkVhPn9CUt1zJxj0VvvhW1eXg==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr27810416wmc.180.1634321986864;
        Fri, 15 Oct 2021 11:19:46 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::ad78? ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id s13sm11448168wmc.47.2021.10.15.11.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 11:19:46 -0700 (PDT)
Message-ID: <2c826db6-dab1-2135-14b1-d9fda25951d9@gmail.com>
Date:   Fri, 15 Oct 2021 20:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 0/7] staging: r8188eu: odm cleanups
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20211015163507.9091-1-straube.linux@gmail.com>
 <YWnDVkwcnVEEoxm4@equinox>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YWnDVkwcnVEEoxm4@equinox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 20:07, Phillip Potter wrote:
> On Fri, Oct 15, 2021 at 06:35:00PM +0200, Michael Straube wrote:
>> This series removes:
>> - empty / unused functions from odm.c
>> - two never set / unused fields from odm_dm_struct
>> - the function ODM_CmnInfoPtrArrayHook()
>>
>> Tested on x86_64 with Inter-Tech DMG-02.
>>
>> Michael Straube (7):
>>    staging: r8188eu: remove empty functions from odm.c
>>    staging: r8188eu: remove ODM_SingleDualAntennaDefaultSetting()
>>    staging: r8188eu: remove GetPSDData()
>>    staging: r8188eu: remove ODM_AntselStatistics_88C()
>>    staging: r8188eu: pBandType is never set
>>    staging: r8188eu: pMacPhyMode is not used
>>    staging: r8188eu: remove ODM_CmnInfoPtrArrayHook()
>>
>>   drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |   2 +-
>>   drivers/staging/r8188eu/hal/odm.c             | 144 ------------------
>>   drivers/staging/r8188eu/hal/odm_HWConfig.c    |   7 +-
>>   drivers/staging/r8188eu/hal/odm_interface.c   |   5 -
>>   drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 +-
>>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   5 +-
>>   drivers/staging/r8188eu/include/odm.h         |  38 -----
>>   .../staging/r8188eu/include/odm_interface.h   |   2 -
>>   drivers/staging/r8188eu/include/odm_precomp.h |   2 -
>>   9 files changed, 6 insertions(+), 201 deletions(-)
>>
>> -- 
>> 2.33.0
>>
> 
> Dear Michael,
> 
> Looks good to me. Built and tested on my USB-N10 Nano, works well. Many
> thanks.
> 
> For whole series:
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Regards,
> Phil
> 

Thank you for testing and your ack Phillip.

Regards,
Michael
