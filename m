Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97B3F3F42
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhHVM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhHVM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:26:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B116C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:26:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so21730784wrn.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T7fSKli+UNhh3LDQln8Jkh3y6lz/VRyR8HfJLUjKlNA=;
        b=FBK1FL8fNHSQq1gCBSj6Ap9Osp+vqwiW2nN/mJ7UHg0KhPNhgMpgOjTADqc8ZjZ5y/
         aYiyt3HdzP++MSArOyajt5fIKzW3CPOCQOEbqweJB/+FtkmFe1JxZHcvLJsdYxhGr/Lx
         3FmFIpJZzoTOSvH35pgae4Rrffu85OVgXgMRF7Fcm+O5EYWUrcAQvA4+pGqmeUwPaEnZ
         iBmsSp3FugzE4PaEt8gylxyClQLcSnHMZSLLOT1clfwYIjpTBZlECEBRCaWcbouo0oJ2
         /1V/VIh1gkBXLTgCfodAh8KXMLKk1280XBWoNb1ipDEDSNCQLEWLw86zarhw7b1SBNhf
         ghUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7fSKli+UNhh3LDQln8Jkh3y6lz/VRyR8HfJLUjKlNA=;
        b=HJOuFqgndTGJtsnLS0tpLZVEzcJ5n+ZlrmxbznJvwy7ajitwJlJhmvPrhAkgH6GSVw
         MGZ2Xk6nihgbsgaqrVDFVHqpGmANurAfhV+sIFMlu3367T+34YyLlVhWOfLNT8MV4qC3
         fhv4mlEQIWLgt57UQBWuy/BDTqYqeJ5RurgiaGlYiFgNw5qVSye9UbG5J1WPIUVG9soj
         +TT9ukNT4+kn6FZMBbM1ERuojQ6xFFwEQ00b5ms8IFkMv5MDMQGv73MO9BK9eMDBFupV
         n8kbzWtertftzD5/E61Uncw/+GI95oYhR9PJLuT+GySTKkn218Q4nnlJff/FFMK/W1Hu
         9XLg==
X-Gm-Message-State: AOAM531GZSGi6v6XW4wgLzbBv+gB4ak5iMYrz7H9jM9We+u9HcFf6kqT
        diKb5064XLehNK0ojdmvn/Id82fRJsw=
X-Google-Smtp-Source: ABdhPJyaUoGaLCl96GnyolGyPnFrfkYmoWgVBeON8SM1TyUuJcwolju3RU7XbBckEzWk4XPWoM9rVA==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr8396394wrs.217.1629635160105;
        Sun, 22 Aug 2021 05:26:00 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id x11sm4386842wro.83.2021.08.22.05.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:25:59 -0700 (PDT)
Subject: Re: [PATCH 06/10] staging: r8188eu: clean up the usb_readXY functions
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-6-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <ada3cb7d-79a2-791e-1744-b6f8ab380486@gmail.com>
Date:   Sun, 22 Aug 2021 14:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-6-martin@kaiser.cx>
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
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 30 +++++----------------
>   1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index dccb9fd34777..cb969a200681 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -98,46 +98,30 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
>   
>   static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
>   {
> -	u16 wvalue;
> -	u16 len;
> -	u8 data = 0;
> -
> -
> -
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = 1;
> -
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
> -
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
> +	u8 data;
>   
> +	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, REALTEK_USB_VENQT_READ);
>   
>   	return data;
> -
>   }
>   
>   static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
>   {
> -	u16 wvalue;
> -	u16 len;
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
>   	__le32 data;
>   
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = 2;
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
> +	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_READ);
>   
>   	return (u16)(le32_to_cpu(data) & 0xffff);
>   }
>   
>   static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
>   {
> -	u16 wvalue;
> -	u16 len;
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
>   	__le32 data;
>   
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = 4;
> -
> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
> +	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_READ);
>   
>   	return le32_to_cpu(data);
>   }
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
