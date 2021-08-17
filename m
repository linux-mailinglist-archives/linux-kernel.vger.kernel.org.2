Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766913EE6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhHQHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhHQHHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:07:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:06:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i6so30191272edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdL9A5Bks/5vn8JW+16em0duE4n+ssWkWG29OSq8opQ=;
        b=hWvl9c8Rgr8vY8JdclfWv1qbJY2E4lZuTXn26Se5+G+3LnfMgZK4uefrOizvC+zUiS
         5+esBDdQSFgJv5Eb4zpF0Ju3h5/TtH3BexC/gjmjrNZjX3W99Q6ji7h+CC2JjAjpZhOg
         Xd4zVICAEh9KOdPq/rmRo73HoqXXq81bXdFNKggciv37NJB86OBbfEvKl2EdIPI92tGE
         bJ6d1AmqfHGUWtGbKVUgNneRKCF4sTunBjJa7gs8LqxyVzvL8QTGnMl78rLA3DjmJeuF
         7sL8GqZiKRZWl9eERdNAOQUo/nmCBDcXM+CpK/FccRVEjsQ5HzIf8hnTVtOT4Epu0yjS
         dG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdL9A5Bks/5vn8JW+16em0duE4n+ssWkWG29OSq8opQ=;
        b=ji82gb8h+jvTrBhSh6QV/tFhJpZ5PbqiCXRhdHe+CzA1pKHcd0oa3mgUVxJj4lwUr9
         x13dUHLqOWe8DuxarCYWeHNoWBiyVu4ZtPUoqualnRkpqv0/HZuSZvkYqTKiYnHXC5Dm
         cS0k6BHWPN4S8cWoHPQotkKbEukNEiRyIx9G9tc7fC+FrkyIZKwCfeu+m+kL93G7ehat
         gPKEqJxDYD+eVaPj7luJ+rdbNVFZvuZPLjkupwocRnNeQAGDqQ9bqkIeNKvYaBQDDmvu
         5sKa/L7i1heyFoJhPRugKSeiyzFnQhcR0O5SKCP19cd8ADpbqP75bpDN3Q6ANFW2c8ij
         WP5Q==
X-Gm-Message-State: AOAM533RDYpKUsgP8eSJQVTJX/E65lfopvtNJ6WR8lsd5NvCpe+C9+zE
        N290kzSgXjZN08WgVrwUCZWmiTtVQL8=
X-Google-Smtp-Source: ABdhPJwnQ9Dh7+zxTZOrs8Q9WHObL4l1Kc5BlXa87CNnS0HDxNe7IwBWRRWYOGF+jMkIPaAIwCWAaw==
X-Received: by 2002:a05:6402:1850:: with SMTP id v16mr2565716edy.308.1629183986886;
        Tue, 17 Aug 2021 00:06:26 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id l16sm354923eje.67.2021.08.17.00.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 00:06:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] staging: r8188eu: perform cleanup in
 rtl8188e_Add_RateATid
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210816234459.132239-1-phil@philpotter.co.uk>
 <20210816234459.132239-4-phil@philpotter.co.uk>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <d9a12b30-07bf-0c73-4a32-b2f4703998f3@gmail.com>
Date:   Tue, 17 Aug 2021 09:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816234459.132239-4-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 1:44 AM, Phillip Potter wrote:
> Perform some cleanup items in the rtl8188e_Add_RateATid function:
> (1) Rename variable shortGIrate to short_gi_rate to comply with kernel
>      camel case rules.
> (2) Introduce additional whitespace around certain operators in the
>      function, to make it clearer what is happening.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index 77c057e276a5..8d03b24dc5af 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -155,25 +155,25 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
>   {
>   	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
>   
> -	u8 macid, raid, shortGIrate = false;
> +	u8 macid, raid, short_gi_rate = false;
>   
> -	macid = arg&0x1f;
> +	macid = arg & 0x1f;
>   
> -	raid = (bitmap>>28) & 0x0f;
> +	raid = (bitmap >> 28) & 0x0f;
>   	bitmap &= 0x0fffffff;
>   
>   	if (rssi_level != DM_RATR_STA_INIT)
>   		bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, macid, bitmap, rssi_level);
>   
> -	bitmap |= ((raid<<28)&0xf0000000);
> +	bitmap |= ((raid << 28) & 0xf0000000);
>   
> -	shortGIrate = (arg&BIT(5)) ? true : false;
> +	short_gi_rate = (arg & BIT(5)) ? true : false;
>   
> -	raid = (bitmap>>28) & 0x0f;
> +	raid = (bitmap >> 28) & 0x0f;
>   
>   	bitmap &= 0x0fffffff;
>   
> -	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, shortGIrate);
> +	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, short_gi_rate);
>   }
>   
>   void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
> 

Perhaps the added spaces around operators could conflict with
pending patch sets that address spacing style issues, otherwise...

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
