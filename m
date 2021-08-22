Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910593F3F79
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhHVN0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:26:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:25:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u1so8841281wmm.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZw4V2Zva7YZ4ZIBobOrnt2elWvFQ0nGG2fMiXvkreg=;
        b=e9MHF138iOszSWiu/z/oFHbPB0n6q7aUnWysxNFTpiW0GA0/SR5eQIt5KlXXoiQPhT
         6KGTYbb6npHFiiMCwjjA2sNzdOBvnrDPEIFQTG+jyH7eKuFUKBUXE2zaBC1sbiOzMJ23
         UtcrQckzLt0P19mZbYZWm9iMqZ/e/1xp/DhhyifO/nKfeiX0OK5YCcVnMaoxr+fkhtMI
         LJ9M7a03BVa2wkn0sY9ppjg7HYJNiZCSKzaUpyiZAOVA3HaRiZTHwZ2Ej2Q2TEtWDptZ
         2lmgarcnDev9X3cuhI+hpBuDIOATfmW101pBYpk59vjwcdbZda0hbRTatIVxczdRwcxk
         Sq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZw4V2Zva7YZ4ZIBobOrnt2elWvFQ0nGG2fMiXvkreg=;
        b=Px4D8t9rhNJmUyBL/ybbxjdeYAgJY3+gWmPGGE8TgJnZsAyPOJnw43jYmpQZFt/Skq
         9wvd6Ii65gEH0ZOxgaLmox6Hvl0N8kVGuYaRBo+KfWz872Dg7AAMN8g8ZRW8IpDD4M7P
         G9iUzOOidD5RQUduvlH660xAnhPNwykndMl8rHiUnsl1TkmYkYxOklztkmqevTIPIjL6
         duDLg5kurgmKymzw0pAXvLAd+rI7c5E934OMX/MLBr0dc40Wt1VmOi6PWCE8OKrAebAL
         JfrMZbyu747ce8KONOiXEUl/dMX/X14ADm1W/VXxQedbihmtDxe2OP2CBYy+sh0k61bh
         uaPw==
X-Gm-Message-State: AOAM5329MA36KKNm/UtloFF49ETWR6eVnNB6d3HgGh5u9Z3SLkIk/0fN
        rrX01kja18yeYahEjFuHeAiH9HqOyEw=
X-Google-Smtp-Source: ABdhPJzJD/D5Vd4j8FYUKzHj6M0sF8kJAvRDQicS2NBxK4KpfLL6TCNaByg7u9S+h/wHX8gE29pLWA==
X-Received: by 2002:a05:600c:4656:: with SMTP id n22mr8006302wmo.74.1629638734921;
        Sun, 22 Aug 2021 06:25:34 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id q11sm3747298wrx.85.2021.08.22.06.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 06:25:34 -0700 (PDT)
Subject: Re: [PATCH 08/10] staging: r8188eu: clean up the usb_writeN
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-8-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <6593f24b-8986-df5f-e2ba-5358360939df@gmail.com>
Date:   Sun, 22 Aug 2021 15:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-8-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> Remove unnecessary variables, check the length.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index e01f1ac19596..5408383ccec3 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -151,20 +151,15 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
>   
>   static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
>   {
> -	u16 wvalue;
> -	u16 len;
> +	u16 wvalue = (u16)(addr & 0x0000ffff);
>   	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
> -	int ret;
> -
>   
> +	if (length > VENDOR_CMD_MAX_DATA_LEN)
> +		return -EINVAL;
>   
> -	wvalue = (u16)(addr & 0x0000ffff);
> -	len = length;
> -	memcpy(buf, pdata, len);
> +	memcpy(buf, pdata, length);

Hi Martin, shouldn't this be

memcpy(buf, pdata, (length & 0xffff));

>   
> -	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, REALTEK_USB_VENQT_WRITE);
> -
> -	return ret;
> +	return usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
>   }
>   
>   static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
> 

Regards,
Michael
