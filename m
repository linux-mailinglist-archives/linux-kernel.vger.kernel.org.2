Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD43F3A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhHUKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhHUKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 06:39:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6982C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:38:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f10so11353895lfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1NFaB1vrGY395t3LmMNK1Kr2EpLKYOnHDpfQxxhGX0I=;
        b=nCstrLpgzGRl7acokaU4Pjzz55z8v+eLAuqIh5jd1+cMUtquWDu1IywFrt+keSDTrN
         saeff9V3w0F9lSgtEhZvfgLpPE3Osr1SGNZnCNJBbkICwwjnypwFjycXZJlL+U8WeY2P
         22hPW9Z9SkQ8jFpVQhESg34qDjhlTs+/MN/hLb3fdM4kNG5+FckfrtpVgsVeXQJJwkMc
         +zf9HiK3F0qIfa9oDclYMAIsdt/XLHOh0faV8oo9Sc7fxL0vGmyuIzXjcwCugyCgqW/T
         QQMRfqz4yOwbCqGv4Gs9DbzzPPc/Uva1BInLx3mAmoZWux3FAHNSkBXnfyJHKGOCRQlx
         RKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1NFaB1vrGY395t3LmMNK1Kr2EpLKYOnHDpfQxxhGX0I=;
        b=LcNOoAfVM2J6cqZykVoZ5h1zSJ0CyO3duo0XSdZwzQvbj7iMR9HSBCrozwDcPAEZu0
         vbgxK+DKLKXa8ixB8MUydQtFJH/5vZ/G7dkIuboIhN/qiKo0efgkD+GGPfrfUzFrPkRO
         oWHj88e/ipv7ZLc0yloOpwL/hV5GZlIgQKAxxWov8fcNL/E8imt2XhvWmE5rbM/O7GN7
         UozV8ohxjd04mZIWETz4xeG23WEOGEEm1ZzPXCKUDnjrUPsGfjfNSzOLDbsu7XyZs9rp
         PQhKUJu/IIOu/QvP6UVWqL3GaDi2osbgFUxvDrSbARM2P7xn32suCLDpjolfp8VuDNO/
         hODw==
X-Gm-Message-State: AOAM533PqNQ3D0XukDjZ+/aN0n0eHzKCG2Ld0UbTPYS8nhWJJH89Xj4x
        yyJBX6b/XkU8iMsuilt9gpM=
X-Google-Smtp-Source: ABdhPJwOEVPDoonCEJrpty94tMJuVsuKAzBx998wD9s1rTHc5GSujYZQwTh9td89hoxVEdUkJWkfKQ==
X-Received: by 2002:a05:6512:2202:: with SMTP id h2mr18086137lfu.658.1629542332321;
        Sat, 21 Aug 2021 03:38:52 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id s3sm429547lfe.288.2021.08.21.03.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 03:38:51 -0700 (PDT)
Subject: Re: [PATCH RFC 3/3] staging: r8188eu: add error argument to
 read_macreg
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com
References: <cover.1629479152.git.paskripkin@gmail.com>
 <44a5a4ab2eae8e0deb969028a5488ea892008c8d.1629479152.git.paskripkin@gmail.com>
 <1590e1abf3991c4b9023173bddee5b9e912d2c47.camel@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <7f54ca0a-a413-7284-7501-7b1ba1b19609@gmail.com>
Date:   Sat, 21 Aug 2021 13:38:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1590e1abf3991c4b9023173bddee5b9e912d2c47.camel@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 2:18 AM, Phillip Potter wrote:
> On Fri, 2021-08-20 at 20:07 +0300, Pavel Skripkin wrote:
>> Since read_macreg() calls rtw_read*() internally we should tell
>> callers about an error on the read side.
>> 
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> ---
>>  drivers/staging/r8188eu/core/rtw_mp.c    | 9 ++++-----
>>  drivers/staging/r8188eu/include/rtw_mp.h | 2 +-
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/staging/r8188eu/core/rtw_mp.c
>> b/drivers/staging/r8188eu/core/rtw_mp.c
>> index 601a1fd5d4e7..6bbea1cc364a 100644
>> --- a/drivers/staging/r8188eu/core/rtw_mp.c
>> +++ b/drivers/staging/r8188eu/core/rtw_mp.c
>> @@ -7,20 +7,19 @@
>>  #include "../include/odm_precomp.h"
>>  #include "../include/rtl8188e_hal.h"
>>  
>> -u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz)
>> +u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz, int
>> *error)
> 
> Dear Pavel,
> 
> Correct me if I'm wrong, but this read_macreg function seems to be
> completely unused by the rest of the driver. Rather than changing the
> signature to do error handling, maybe it would be better to just remove
> it?
> 
> That is just my view though, would be interested to see what others
> think - perhaps it could come in handy at some point.
> 

yes, this function is unused for now, but I am aware about plans for 
this function :) If no one has plans for it, it can be removed.


With regards,
Pavel Skripkin
