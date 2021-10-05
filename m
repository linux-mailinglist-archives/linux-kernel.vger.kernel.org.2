Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9483642332E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhJEWIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhJEWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:08:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84502C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:06:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so2336428wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vFz2ixooEH7WCAssNrj2XaXWHqUxWi5Jrrg6C4o9k5E=;
        b=NQZLtOX/o8cYhbJs2WkgZoeAwBdLxlImSbzhoF3kWECAv5hGtHo8cQWW8UXMpwLI46
         +bFuON8mIU1lWqvM6WwC/yR5D5LSWMc/R5cQxnc9dNEHEhS2ekWTvCxX9ZLY2Ua7rp6p
         OUJiSQTzfGKZOziDrMzxJfTzVZNiDQSLozgtCUX3hnCSflj+qvmvjri8mKZ+bZEnTvgo
         xJU2i42hy3Myl81Up7BmJ+fWQcfxdPALnv+bdJqdeewDb+c8+X7kq/2fOAtACGHPJRDc
         GGA/26W2sbN5L5Ro5MnDiyuB+41zVkzDhbcBWoBDjLEWFtE8cLKZdGFvdozkEvF8mr2n
         zhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vFz2ixooEH7WCAssNrj2XaXWHqUxWi5Jrrg6C4o9k5E=;
        b=xdhwrnzigsHu0x4ijgzSb+v7VHvv80m2gWTV7K1/5f7vmf16YDsc7U157auG2NQkru
         Kk3Wj6iRoNiGGMqddgbWnrnLScKxCZZ5UV78Q1ZWevx8QpYCDAo3MtDf8cxZXrxsjdx/
         PpYoX+xbwk0qWM3P/5WD69Pl9gZAbr1KO9df2JsImVjo11doNmDdasbHVyiEXOzThjYr
         ctkBmfcWyFcAE9aq0kXwSjLQnLAAlpmswPuKN9NXAcOQmUd+Y6rEmo1KiCi/oj0Mb/LO
         Lc3LwPqfZi2YnrB0mR/EbugkbKcdo5u6E2gkhuUQwz1uZtKX9rZeJI6r3hRZt+NPPbFm
         Y4rg==
X-Gm-Message-State: AOAM532qU/at/4nvxLkUZ/6qabBcyhYbSOiphaUrMXcfTVF3f4rkljof
        3eqjO+nPqNGgxvAF0+eRmDM=
X-Google-Smtp-Source: ABdhPJx5NashpsRnp5sMz8WHZPcUqpt0aIM+jfSAiCSmrxeF/dvefrnVP+i34wKZ+Olxee1UJvKpWQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr6213235wmq.122.1633471587146;
        Tue, 05 Oct 2021 15:06:27 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id j4sm19174690wrt.67.2021.10.05.15.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:06:26 -0700 (PDT)
Message-ID: <d6f016e1-b6d3-05eb-1880-9346580aca3f@gmail.com>
Date:   Wed, 6 Oct 2021 00:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 4/9] staging: r8188eu: remove unused IntrMask
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-4-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-4-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> The IntrMask array is set but never read. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c      | 3 ---
>   drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index f71f25e234ab..bd3ba6ab364f 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -119,18 +119,15 @@ static void _InitInterrupt(struct adapter *Adapter)
>   {
>   	u32 imr, imr_ex;
>   	u8  usb_opt;
> -	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
>   
>   	/* HISR write one to clear */
>   	rtw_write32(Adapter, REG_HISR_88E, 0xFFFFFFFF);
>   	/*  HIMR - */
>   	imr = IMR_PSTIMEOUT_88E | IMR_TBDER_88E | IMR_CPWM_88E | IMR_CPWM2_88E;
>   	rtw_write32(Adapter, REG_HIMR_88E, imr);
> -	haldata->IntrMask[0] = imr;
>   
>   	imr_ex = IMR_TXERR_88E | IMR_RXERR_88E | IMR_TXFOVW_88E | IMR_RXFOVW_88E;
>   	rtw_write32(Adapter, REG_HIMRE_88E, imr_ex);
> -	haldata->IntrMask[1] = imr_ex;
>   
>   	/*  REG_USB_SPECIAL_OPTION - BIT(4) */
>   	/*  0; Use interrupt endpoint to upload interrupt pkt */
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index fc6acbba17e7..bfe32864ded6 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -356,7 +356,6 @@ struct hal_data_8188e {
>   
>   	/*  Interrupt relatd register information. */
>   	u32	IntArray[3];/* HISR0,HISR1,HSISR */
> -	u32	IntrMask[3];
>   	u8	C2hArray[16];
>   	u8	UsbTxAggMode;
>   	u8	UsbTxAggDescNum;
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
