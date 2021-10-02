Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741CA41FCFD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhJBQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhJBQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 12:11:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440BC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 09:09:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so12352053pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:cc:subject:content-language
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=BMdIVWKp3ys5Ki4OkuinpSXjnqylPnTrfzGBeDzjdeo=;
        b=Q05CiJuLApqub6sFWeG6+kf66teDw7Z9v7cmgqGKaLhZWKlvjclXChpT+BRNKXJWkC
         hqIfq7aPINSgCtZGiiR48mO9WNHXkr+5hrIwM5oWYha2Cn0N9+f3h/xNPmASKQcLJ1iZ
         k/FptNiJLEiXD6k6DlQ5fs5EjCcXtzpNyo9OP1baiLqwS1ZEhYWOADatfp0Gp3Ocw7Wb
         UaMMtEfVb6o9nmk2ii5h0EM4rqkmR9ePepjYVrORmxlIxNPx1WoEgwidbNpIRgHwsfWi
         P/aUW+dPFfmOG9+t4Zehvqk+76c6WsohFFGSGeceVN2eht5E2BZqJh83hL24Z0Zo9rkd
         XAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BMdIVWKp3ys5Ki4OkuinpSXjnqylPnTrfzGBeDzjdeo=;
        b=OJMaHM5YQm2r24NpkhPXg4YrusN3KMeo/y0y/ZuKrWEkviCtFYvKNo7YJW8sAEojAc
         DWchJe0HXrmTBo8GJGCn8GBolK0/l3ir0lSzKv6FTXxwPHDKw+xrA6H2k+o9kvxhzJ4v
         t8GcSXa8gTZUDa/DVXuL6hbPUS/4ydLMTLOlG9fH/f+gj7Q/Wb1E7mXg460zGUxX1vsu
         tsfS82yjk9xx6Tub43DeIxV0MGejoNGk/jk33X/kKF3lYs3lWqnB+2lkjp2spSpkV3gl
         AVsrh/ljnK7tRIyQJBdCto5S7wxRonMXG0KpPEefK5yUQQs35O9zYK+RSFTtzoZMdTxk
         pYGA==
X-Gm-Message-State: AOAM533z6uXyrlEw5NxxvorgvCIZs1FduBU5YigAwTBu/CYYn28HpU7P
        JgvEgDmI+EuQ3MXtlTStCTk=
X-Google-Smtp-Source: ABdhPJxYDkCwwhPFpfdW/zRSqjObWrvwbVCUu1j5WXpD1xbbqvw5mWkpoyk/yTGQ8L0Yq3JrKdariQ==
X-Received: by 2002:a63:5213:: with SMTP id g19mr3402250pgb.87.1633190964703;
        Sat, 02 Oct 2021 09:09:24 -0700 (PDT)
Received: from [192.168.1.6] ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id b129sm9204377pfg.157.2021.10.02.09.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 09:09:24 -0700 (PDT)
Message-ID: <c00d96ef-0168-c004-7fb1-a422a7c8aaa3@gmail.com>
Date:   Sat, 2 Oct 2021 21:39:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Cc:     saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove unused variable pAdapter
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <YVh3MP/JrUwkKr3Y@user>
 <59ac1835-2afd-cd7a-d073-5c5d2bb02805@gmail.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <59ac1835-2afd-cd7a-d073-5c5d2bb02805@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/21 9:08 pm, Michael Straube wrote:
> Thanks for you patch Saurav, just some minor style issue.
> 
> On 10/2/21 17:13, Saurav Girepunje wrote:
>> Remove unused variable pAdapter in Efuse_Read1ByteFromFakeContent.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/r8188eu/core/rtw_efuse.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c 
>> b/drivers/staging/r8188eu/core/rtw_efuse.c
>> index 801887f497cf..d33a5b3b4088 100644
>> --- a/drivers/staging/r8188eu/core/rtw_efuse.c
>> +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
>> @@ -28,8 +28,7 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
>>   #define REG_EFUSE_CTRL        0x0030
>>   #define EFUSE_CTRL            REG_EFUSE_CTRL        /*  E-Fuse 
>> Control. */
>>
>> -static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
>> -                       u16 Offset,
>> +static bool Efuse_Read1ByteFromFakeContent(u16 Offset,
>>                          u8 *Value)
> 
> There is no need for a line break here.                 ^
> 
> Other than that looks good to me.
> 
> Thanks,
> Michael

Thanks Michael for review. Yes line break not needed here. I will 
update. I will resend the patch.

Regards,
Saurav
