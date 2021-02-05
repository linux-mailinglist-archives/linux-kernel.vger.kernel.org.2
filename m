Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F99311A7C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhBFDuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhBFCwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:52:38 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13453C08ED39
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:16:54 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d7so6264511otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwe5uVEsJGK5yJWOuT60cjDB4g4zMZRqI4yHWXKKFDI=;
        b=IM6esCCJ8RSmF8l/G+Bs94LbX/NU9QtFerWFm8Ry+QRZ2aK1X/5vZ7KM8dXRk/gcxc
         +lLPPO5A28xF9bzh0Og4iaO04fE9OAbpRTlncabU5ttXENHcJywW0KqltVuDsYavSsmA
         luTp2pKBk0buMzX7l88tKH/zeAnM2hVyXpTOyjWFgkEu3OA1Z/gWH83ap+50Fk5JHA76
         VSBrZph6h+eeQXVQoncFCHJfnN2HdMaTiiSUIdyRSWP6TqSje5NDRfwLpgU5TyykxK4/
         HE/kqZVwz4VKy+/dZ6XOGai/g97A9ngk/VqlCQeef8G73vdxrBtpksXp2RSg/rDw2+VV
         tNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwe5uVEsJGK5yJWOuT60cjDB4g4zMZRqI4yHWXKKFDI=;
        b=m7dydI//m2/vIB8ClBZc9opik75Vm9CujCDTXCjgU55b83D0Lqnzp86eiWsqFXXvUP
         Z0dpkeTIKjhoXJyujImxXEFuTesaN9AX4cAoVrGfcCXAqHTYi2n0qwnl41zX3/AXI17g
         s/g8PNJKXra0ddiiuU6d1Hrk4lCHgGxxTs8fY1rnaZG9IzuSp9asyEgW/ptD/CNoyP37
         aANNLbgEd6WraLy29cuKHRg/PH9E1zzWPPMunTwUnaStfiXdwcI3z6en2lk7FCee2H6R
         NaxMZr2Z+x3iWFTSKiaPa7acV3o0FFbeCQ5G6xdOC76+fVmYtplFv/k4p54Bt0KXqIiX
         Zfhw==
X-Gm-Message-State: AOAM530jbYgr1xKINliGMZw/t9ExuPU5lYcNDhSbhzJ+aUd8m1VKVp5b
        S+2eRgq8blorzbh7WaX/Z2CcQYL5p2I=
X-Google-Smtp-Source: ABdhPJxqRVskNlO0mie8LeYeds1HCwXPOcoIn1x549FmvwaAzQv14DWVVBBJ1Y0bMHPKm38eNyYGYA==
X-Received: by 2002:a9d:6757:: with SMTP id w23mr5302278otm.101.1612567013247;
        Fri, 05 Feb 2021 15:16:53 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o98sm2121605ota.0.2021.02.05.15.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 15:16:52 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: Add Edimax EW-7811UN V2 to device
 table
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210204085217.9743-1-martin@kaiser.cx>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <134235b7-f15d-9ac9-5fc9-58f3628479aa@lwfinger.net>
Date:   Fri, 5 Feb 2021 17:16:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204085217.9743-1-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 2:52 AM, Martin Kaiser wrote:
> The Edimax EW-7811UN V2 uses an RTL8188EU chipset and works with this
> driver.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/rtl8188eu/os_dep/usb_intf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> index 43ebd11b53fe..efad43d8e465 100644
> --- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> @@ -41,6 +41,7 @@ static const struct usb_device_id rtw_usb_id_tbl[] = {
>   	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
>   	{USB_DEVICE(0x2C4E, 0x0102)}, /* MERCUSYS MW150US v2 */
>   	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
> +	{USB_DEVICE(0x7392, 0xb811)}, /* Edimax EW-7811UN V2 */
>   	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
>   	{}	/* Terminating entry */
>   };
> 

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

