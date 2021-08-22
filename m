Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261873F3F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhHVLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhHVLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:55:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:55:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o15so8719467wmr.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O7ZwczbeMR/YAkYS1Itn/5ZToVV+8zRvhc01oQeZjrA=;
        b=I2aowjRvamyDFJwmsALT6bFyPoB01MRLr/fP9dqbriQNTzaTmILnsf5ATt12A+1X0j
         DH7lRR5YsW+5piWxbkdgjpoP6EwYLVF3Mkq4VlY2/czG7t9GubK8mYoV7PMxA+B8Exq+
         fn+DIjOlYZulgr/YDqH8AMRpKqu31w7Y9bJQxaaBqpl/Owxxpt+ljWkPqqjq89rVAPE9
         BoTmL7E3AIGr6Vh0WRXcrsGZKTdhheEq5JEMwr0BDVUK2bbSedm0CBds3wpxEc1/V8s5
         omBqN9cwvcb6jd1nx3wvv0O8uE6fRqr84JA4ex6/uvny97WeZINRnIYewiMnxvSJfQHV
         64bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O7ZwczbeMR/YAkYS1Itn/5ZToVV+8zRvhc01oQeZjrA=;
        b=JK6ME1cq50NDl5okA6drxmXe6du9A4XKXBAClWuF99mMSiYQ0viK9CFoUAgxlKo69q
         pVmtB6PjtTlNCabuFXCdxKEnQ8WoKenK3gBwv6POixxSWF7bJGbDscyJvG3Gxbj9igvC
         tsCH/tvKQgvaBLdumz/1MqfDb1TSS5LxD2OSYq9yCi5n4mvH6Bf4eZor0/TtUVHxvc3N
         dkGMSg6MYhWGH5Z1LCqsJeRI4rYeJ5fPXo/+FEg2dwOKhZk8SkTs/OTebaX8ZTLbd+X0
         qO8eVsbYa4uJqJNwBqmgFmMWlwKdwu3W137ZM/w9WeQ4I0MAcMGS87UpbXsKNiElmkoN
         AmzQ==
X-Gm-Message-State: AOAM5336GY2NE+T+M2wQdR570yYJYsZ+ccnP/jilqu+ZFvSBshrm6ePh
        x5zW6mmfGY/JkV2EIRZ6tEDEcgB3xys=
X-Google-Smtp-Source: ABdhPJx+aKdGGcRzworMCbhoPyusUkyTrSKnZYepR4sNOtL8AphSHo4x9dkDEvRNoE+JzuVCovRbiA==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr11476611wmq.88.1629633316348;
        Sun, 22 Aug 2021 04:55:16 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id l19sm10521393wmi.4.2021.08.22.04.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 04:55:15 -0700 (PDT)
Subject: Re: [PATCH 01/10] staging: r8188eu: remove unnecessary cast
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <7718dee6-e841-8e8b-8db1-210425ddba77@gmail.com>
Date:   Sun, 22 Aug 2021 13:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> name is a const char * by default. This type should be ok for r8188eu.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index e002070f7fba..72556ac10d7d 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -61,7 +61,7 @@ struct rtw_usb_drv {
>   };
>   
>   static struct rtw_usb_drv rtl8188e_usb_drv = {
> -	.usbdrv.name = (char *)"r8188eu",
> +	.usbdrv.name = "r8188eu",
>   	.usbdrv.probe = rtw_drv_init,
>   	.usbdrv.disconnect = rtw_dev_remove,
>   	.usbdrv.id_table = rtw_usb_id_tbl,
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
