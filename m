Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4CA3FA776
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhH1T5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1T5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:57:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:56:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a25so21574207ejv.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tqa4ZrfDsVyGaU1+CM8aMMCa9NVr2chnhBF8cJPwrec=;
        b=swEFPqWU6QiBbAxg5VOiyU/IVhZIb3u69gWdNjzXz2u6hK7sBJ0G2/VZ8fbOvIlDLo
         oznUy4UY5teZCbYDjIl116hT05/XorczS8rSAAG+dxLgwG9/U9vPLj+n0kkXpeBsoIQ0
         /FAe/m3O7ssLSCOLBiVG2xmfofeBJQH+W/uIW1usLpkz1Ad7J9OkPR+UcaFXGiGFE8pE
         qbf6VqpPwyCCDb8fWeQ2ZmkjKxeVopTKEWOQ9kYj5VW2K2o/1pYJ940dgPIhBpl4m1dR
         MHOGx2TFCoFASzN0b9B5ov0f9aboAJlv0W2LbQ2pY59uhDQs4ckXjeB3IO+Px9konVuB
         WfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tqa4ZrfDsVyGaU1+CM8aMMCa9NVr2chnhBF8cJPwrec=;
        b=IPEmZppJzaIIsZ24WT5sY94Z0kN+ZqBkJbi1mepoE5xc5xOmWOTCVNlFMh5oBwX/9Y
         BYVDYdyEMM00I2QKKlC8opD9meY/gx0ld/av27oK2b+vD8eUNtJOJI90Q/iC8pppXGLm
         yd4ASbjuBkMSLkVEVo8gWHPCvoSgwk8pWKxJS5sb8CQAg+TcQgwACd1j+eBMrr4kqzLN
         J774OmldbE4hOhoJpn2Dw/VPkd+qDAV3X4Adh5xDg4pHSN9Z1FlnpZNkoK5DLdu2oSXy
         proNz9I1jAY73CfiA2BvEqBnIDKDReZ7Cw+R+NcGlBfeHYddO6ItuZAnU9cw6eB14pjh
         4++w==
X-Gm-Message-State: AOAM531lUrT0dlcYF5jK8/C4hVdm0rT/Pa1AbG7GLc6wtuxJ3lshTBn8
        O12BbBaUGZIwyyJMKFbYqWk=
X-Google-Smtp-Source: ABdhPJxLUktT4rZoNPaA/IaXDZg3kF1n+91dwfEou7ZTrO0HlpF6n1Okt9SNleL6Bz07WE3PPtCCuA==
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr16844731ejb.3.1630180577617;
        Sat, 28 Aug 2021 12:56:17 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::884b? ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with UTF8SMTPSA id s7sm5292402edu.23.2021.08.28.12.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 12:56:17 -0700 (PDT)
Message-ID: <f6ffc51d-fb39-5191-e2fa-1b3200b89d87@gmail.com>
Date:   Sat, 28 Aug 2021 21:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: core: remove null check before vfree
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YSp4UP1+HrhmDA3C@user>
 <1e31610a-0324-dfb7-abe5-f05d652d461d@gmail.com>
 <b098cbe9-1cc6-d97f-e1d8-df6c99b0afa0@gmail.com>
 <20210828194734.7xn3tkdh2yay5yyt@kari-VirtualBox>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210828194734.7xn3tkdh2yay5yyt@kari-VirtualBox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/21 21:47, Kari Argillander wrote:
> On Sat, Aug 28, 2021 at 09:30:14PM +0200, Michael Straube wrote:
>> On 8/28/21 21:20, Michael Straube wrote:
>>> On 8/28/21 19:54, Saurav Girepunje wrote:
>>>> Remove NULL check. NULL check before freeing function is not needed.
>>>>
>>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>>> ---
>>>>    drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>>>> b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>>>> index f6dffed53a60..4726771a8403 100644
>>>> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>>>> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>>>> @@ -155,9 +155,7 @@ u32    _rtw_free_sta_priv(struct    sta_priv
>>>> *pstapriv)
>>>>            spin_unlock_bh(&pstapriv->sta_hash_lock);
>>>>            /*===============================*/
>>>>
>>>> -        if (pstapriv->pallocated_stainfo_buf)
>>>> -            vfree(pstapriv->pallocated_stainfo_buf);
>>>> -        }
>>>> +        vfree(pstapriv->pallocated_stainfo_buf);
>>>>
>>>>        return _SUCCESS;
>>>>    }
>>>> -- 
>>>> 2.32.0
>>>>
>>>
>>> Acked-by: Michael Straube <straube.linux@gmail.com>
>>>
>>> Thanks,
>>> Michael
>>
>> Whoops, I missed that you removed the } that belongs to the enclosing if
>> block. Probably because it is not properly indented in the original
>> code.
> 
> Easy to miss because that bracket is in wrong place in first place.
> 
> Michael can you now on even build test before sending. Thanks.
> 

Sure, I usually do. For this one I did not but obviously I should have..
;)

