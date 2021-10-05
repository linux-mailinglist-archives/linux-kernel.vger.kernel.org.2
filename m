Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A94423332
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhJEWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhJEWIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:08:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCCEC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:07:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r10so2292136wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EI3G8VZjcZoUXoKns09EXb0KlF0BfbnupH/W8neV6aI=;
        b=KOKCktSbplLJ41mxs+iE9C83jKFxnLoPhR/eNFhspRqbN0PhtgAjqiquYlYijKM6Rk
         64vrS4ZFCFg7C4IQRR5vj0zGAS44dXcQ189e7hvvywSfP2QmWjRf9kj9/8bUeJ1Zqolt
         xBFtxg83AXcF7tUGWGjp5ySdQMCjyRGC865g5tSvpHy/+n62i3EiyIQlDLbtKXaHnbbK
         qKyGg5EzXhHE0aQItYX05+88yv7dBSAH7F6cEXEZKYNdV16Sm6EZV1HCujGOrcY2SDaQ
         AC4tLbOhO/0LsVsyUVpbIbgdodUWQJXYVhypMRGw0HADnR9vjDhkcGrV9LRcVfAgAusR
         EUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EI3G8VZjcZoUXoKns09EXb0KlF0BfbnupH/W8neV6aI=;
        b=MYylJ5OS6qNCbUQx7iJL65lzn3PdsyxKORAwJ+4Vs/McX4xx5DIl/EC79qhYi8arSI
         fuZqMvm/aB34vea4ELq46a+WdSI+yeFWs8K9DR0h1h6wOjTqBh1WJAwGdkj4k6WRl4Zj
         c/yrAJTQQF680KpEufoviBDc5i6rylLq2Us2DrfR/c3VpYeJN/TlaWtIY0n/fcv0iE0h
         g0zKxwb0KTOkMJbGqv30NVLO6T3JKjM2WWCqabsbdh76vXG7PvtNlrbtEIPDBWl4A1MC
         tuGVFaSCljkq60ESFJYLBG+eP4AgcETBpqbWP2EMFGxlHocj/vAprej2HTn7YerdyTHb
         A+bg==
X-Gm-Message-State: AOAM532BmscH8httDj1jm+2UsLDHIPaGXkfSoWSfok513lz4TTnO6BSM
        1juq25UydUL+Tgs4fJ7Q+ss=
X-Google-Smtp-Source: ABdhPJxk73ZQYqCxt/oNZqQA40uUWWGdRRazNeg1V+WutdzmXyHI7ByU64YIcERJqqTiQkwC7tcd+g==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr6217204wme.94.1633471618815;
        Tue, 05 Oct 2021 15:06:58 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id s24sm2916820wmh.34.2021.10.05.15.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:06:58 -0700 (PDT)
Message-ID: <448f1193-c22b-851d-4bf2-5aeec64268d1@gmail.com>
Date:   Wed, 6 Oct 2021 00:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 6/9] staging: r8188eu: HardwareType is write-only
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-6-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-6-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> HardwareType in struct adapter is never read, it can be removed.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 1 -
>   drivers/staging/r8188eu/include/drv_types.h | 1 -
>   drivers/staging/r8188eu/include/hal_intf.h  | 2 --
>   3 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index c15a75513c8c..9544300fab65 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -562,6 +562,5 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
>   void rtl8188eu_set_hw_type(struct adapter *adapt)
>   {
>   	adapt->chip_type = RTL8188E;
> -	adapt->HardwareType = HARDWARE_TYPE_RTL8188EU;
>   	DBG_88E("CHIP TYPE: RTL8188E\n");
>   }
> diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
> index 6d63429d06c6..9fa561ad340b 100644
> --- a/drivers/staging/r8188eu/include/drv_types.h
> +++ b/drivers/staging/r8188eu/include/drv_types.h
> @@ -206,7 +206,6 @@ struct adapter {
>   	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
>   	int	bDongle;/* build-in module or external dongle */
>   	u16	chip_type;
> -	u16	HardwareType;
>   	u16	interface_type;/* USB,SDIO,SPI,PCI */
>   
>   	struct dvobj_priv *dvobj;
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index 29ca90a86844..ee8e67dafe7c 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -137,8 +137,6 @@ struct hal_ops {
>   #define RF_CHANGE_BY_HW		BIT(30)
>   #define RF_CHANGE_BY_SW		BIT(31)
>   
> -#define HARDWARE_TYPE_RTL8188EU 17
> -
>   #define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
>   
>   void rtl8188eu_set_hal_ops(struct adapter *padapter);
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
