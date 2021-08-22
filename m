Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2413F3F43
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhHVM3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhHVM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:29:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC82C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:28:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u1so8788419wmm.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jPp7QEaPt1Sw5YHA6F6IZfCBjiMiNjX+vQKALZJ4QI=;
        b=eVg11WaVtYLB5ceZ8giZlV2tN6dioW/R3JazFuYxWaaNoCVeNxUnIeDAZ+VO4+AN6u
         uz4ViYuelrrHtsvEtK2ICH59/xo1VIkmd7FWdK8LJk6/EsmvqeptAHb5hNHcenN869i0
         g0we1hZpBpBa8BXy1gNpRdpU09ZaFGtvuRNAu1H0Yn28nHm8afXs05JDSL02e9vxCfm/
         HOApYjzLF3J9sInBiEO6Umb3QWi+WCJt1jm1wx0uJ5urh8lir+f5uNm+QPegCTVJDfX1
         kWbaD5BSdP/iecviZ9AyuLHtAK6Zu4z5ZF7gYWTGvDY//FvQhBSHLpxE1MJ0E+ufTGtF
         mZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jPp7QEaPt1Sw5YHA6F6IZfCBjiMiNjX+vQKALZJ4QI=;
        b=Ja9FUPY25E5tBe6ysVmr87ZZtffJVQVaSOMIGsvkiRmXD120BhoHG3KM2KhLrNOQZA
         pADfbI4jJf8uuUqVcqWfg06l7BAUCY1yzO1h/e5+7MPcEjNZYUYVefG7C7D9CT3iM8hl
         xrJaiHAuP0W5kAJmbpxTfbyKScM/FDSwxEkDXfFRFVdYWObjSIXt9OmPGKg5R2o4zZfr
         JffGcUfR8SQIXzza4Murfhcs4kw0cUHLNGwCCt0zzKwnlqLsEJxM+StdMjNlWYte7+0c
         DZBpRvH2Vmn7YOzXxrnHWxu6OnznX3cukK+0zhhkCSJ1Jp1Mg/b1RifUpG8jXybwkOT9
         LI7Q==
X-Gm-Message-State: AOAM530JATqlFeqoCjsA87bub2IcAu/PUNoHpiHBiTLeklzNs3KylfCF
        aJPHW3mpT/kXkPzDTyG5vpbGinbXDt0=
X-Google-Smtp-Source: ABdhPJydQRA/FCE3APD0sPKHzXyd7WiVc/HpIAwqKQa110LOXauvfeiaclR8MLzayJAxdW/dLPH8dg==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr12230151wmk.51.1629635327606;
        Sun, 22 Aug 2021 05:28:47 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id n15sm500015wrv.48.2021.08.22.05.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:28:47 -0700 (PDT)
Subject: Re: [PATCH 07/10] staging: r8188eu: clean up the usb_writeXY
 functions
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-7-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <a146d415-3cd9-8ad1-4a20-06f304eb0487@gmail.com>
Date:   Sun, 22 Aug 2021 14:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-7-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> Remove unnecessary variables, summarize declarations and assignments.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 50 ++++-----------------
>   1 file changed, 8 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index cb969a200681..e01f1ac19596 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -128,59 +128,25 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>   
>   static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
>   {
> -	u16 wvalue;
> -	u16 len;
> -	u8 data;
> -	int ret;
> -
> -
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = 1;
> -	data = val;
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
>   
> -	return ret;
> +	return usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
>   }
>   
>   static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
>   {
> -	u16 wvalue;
> -	u16 len;
> -	__le32 data;
> -	int ret;
> -
> -
> -
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = 2;
> -
> -	data = cpu_to_le32(val & 0x0000ffff);
> -
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
> -
> -
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
> +	__le32 data = cpu_to_le32(val & 0x0000ffff);
>   
> -	return ret;
> +	return usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
>   }
>   
>   static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>   {
> -	u16 wvalue;
> -	u16 len;
> -	__le32 data;
> -	int ret;
> -
> -
> -
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = 4;
> -	data = cpu_to_le32(val);
> -
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
> -
> -
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
> +	__le32 data = cpu_to_le32(val);
>   
> -	return ret;
> +	return usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
>   }
>   
>   static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
