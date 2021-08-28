Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF83FA755
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhH1TbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhH1TbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:31:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0F1C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:30:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h9so21521405ejs.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=+1evt0wlFoLtIOlqCJmQkkMUPdGJYqS85gEK2HrtK6Y=;
        b=lbKPe9hQ/2TThG38WOxsnifFkccV+Kqsn3Z44Ad9qlOdUe+htljoUc84JEaoWGyZnN
         PnGVYcbspdgyZ5Prd0K2uj8ZoS0cz4Y7ZSAkREymEaA6Bbni7WXwE2/02rV3eZOmxgk/
         Xpv1ou6Tvv6bDaJypZnBuDhqUCr018HrvuKJfAHZP9xP0VpjE1sb5St5gVfVuYzubBxf
         7Ifp4/dA54m9BoqkDaVupwhusABQFP8GNzwGgZEXb6T1gqpVBWkzHPRiVfAW1/tBIdUF
         cFk1PGdHEiPSUayWwJU19BHMa6UkfKZhOgdQ/RvokMNh1oREBPewWc4wfCXGYkbVCdsS
         DERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=+1evt0wlFoLtIOlqCJmQkkMUPdGJYqS85gEK2HrtK6Y=;
        b=I6RfLjF8y77qduS2M/0RzItd4k/mLzZZNuX8KD/gaS9B0CSAcU2cXd7E45OGA9VKaD
         9lnzd11kxR0YwVYxWqlpoq9Jh0EshiNcqCKMuGUjYkvsxSMV3kuKgymz3A5g14GUugQh
         fqqgV3nkTzLWqB/RCR4qJMvewcrLZ84LyJNUPc/Onwp2IgAT/t4NWUzu9NfEknWSSPKP
         AS2Na9NF4eXN2IDdATvKSYoMgMfQSNo7ywI9OitVXBb/JUqGPNFoQvmIIKdR6eAaBUHV
         TA4LZCOjhh0B6UxaZMpcIqO2ODrsu62J9yoMtOjWDMcasd898LmjwyAhzofNGYwGfHzV
         ty8w==
X-Gm-Message-State: AOAM5314fBk2Qa1nfbIChz7Pta/xuM1ZnKu1c1Ga/EzJ7vGYTqmroGSd
        jgcji96nsvWYqz1k6BQlVf0=
X-Google-Smtp-Source: ABdhPJzQT1Z4GiWLQMWKU/AtdIO8yfetOP32pxp0htvodlE8vGh1MuBMF/sK08kOjZif8heEWN7S7w==
X-Received: by 2002:a17:906:e50:: with SMTP id q16mr952813eji.370.1630179015340;
        Sat, 28 Aug 2021 12:30:15 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::884b? ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with UTF8SMTPSA id s21sm3293862ejq.61.2021.08.28.12.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 12:30:14 -0700 (PDT)
Message-ID: <b098cbe9-1cc6-d97f-e1d8-df6c99b0afa0@gmail.com>
Date:   Sat, 28 Aug 2021 21:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: core: remove null check before vfree
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YSp4UP1+HrhmDA3C@user>
 <1e31610a-0324-dfb7-abe5-f05d652d461d@gmail.com>
In-Reply-To: <1e31610a-0324-dfb7-abe5-f05d652d461d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 21:20, Michael Straube wrote:
> On 8/28/21 19:54, Saurav Girepunje wrote:
>> Remove NULL check. NULL check before freeing function is not needed.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>   drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c 
>> b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>> index f6dffed53a60..4726771a8403 100644
>> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
>> @@ -155,9 +155,7 @@ u32    _rtw_free_sta_priv(struct    sta_priv 
>> *pstapriv)
>>           spin_unlock_bh(&pstapriv->sta_hash_lock);
>>           /*===============================*/
>>
>> -        if (pstapriv->pallocated_stainfo_buf)
>> -            vfree(pstapriv->pallocated_stainfo_buf);
>> -        }
>> +        vfree(pstapriv->pallocated_stainfo_buf);
>>
>>       return _SUCCESS;
>>   }
>> -- 
>> 2.32.0
>>
> 
> Acked-by: Michael Straube <straube.linux@gmail.com>
> 
> Thanks,
> Michael

Whoops, I missed that you removed the } that belongs to the enclosing if
block. Probably because it is not properly indented in the original
code.

Best regards,
Michael


