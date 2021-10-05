Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F594423331
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhJEWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhJEWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:08:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACEC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:06:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s15so2296073wrv.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fQrziVQsjoK41YRSvHFjh72HJt/r7Rv3LbcHkyKWWZ0=;
        b=LB2IoZRRf7cNb+hhjmYdCbFze2eIYGQmxThHHm7Aq8v2SDAzpPwovkGVlDQHit651Y
         CXVYMuKNP5oI0TljXLIB9FEl0TKPFFuyjGabRi/P5MIDG4HZysYzK6Cm0sU+1renYd/H
         N17fkEg5ulPU2w933s4E4vyIJZOzEGlPjIELs24XGO980EfEexfSahRDnHrNGJ3ScMqa
         IICHCP2FxH50HrTgEgZLsSJWpdQQEIz6BH5lSNfeeg896l/r2l5QvTFWYF9aHDqUnH6j
         /f6UAGo0JLbX+qAggAiyxABE4BZAqlwKRi2dz/3Z5LzSQEp8VRJ11SwnblWjEkGLJtgv
         Fd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fQrziVQsjoK41YRSvHFjh72HJt/r7Rv3LbcHkyKWWZ0=;
        b=0kGQRzaxzQYWlZqDbgsHNm98kGwovQKdearhJNCkNI5ejAXD7VIAYjauE8AsEWYNnf
         k+YzM9aphT9BpMlNM2RtpQ1wxhtz41Mm4CMfWip+8566URzu3nFdEW906TQQyoRXKi4B
         QdVYcRjW294mRXoZanHm3DMohgw+rl6vWSH6MaGku6aXjJgkaMMGRq4rX4FM3cgnCGLv
         ldZVGOb6Vs3KlXFXyN5Fk4SawqubSDF34r4DsoPGwGhxEb06oPlgP9Oeem9acb/wZ9l7
         zGmYx6K7Zfw+jczlj3oxiI+6oNzZQBsXUimqk8tHefpTzd47SSk4aOceqfKyqzTewzBv
         SLBw==
X-Gm-Message-State: AOAM533+3xadCN7fJzikV8LCQcE+OTep2iqYUClV8OmNy8IKgU73vXNJ
        YCJGjTMsBuEqZ/QUBXe7MIc=
X-Google-Smtp-Source: ABdhPJxceOuDErxrR2Wi1j8K0pgWYPDo4qGh3OHmyYYpV4G9G9/RjEx6VR1XQHFqKfLhrcJfeAIEmQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr24710660wrd.380.1633471606170;
        Tue, 05 Oct 2021 15:06:46 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id b13sm2210208wmj.3.2021.10.05.15.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:06:45 -0700 (PDT)
Message-ID: <b0094ee2-671e-9444-8d99-596530f8fa53@gmail.com>
Date:   Wed, 6 Oct 2021 00:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 5/9] staging: r8188eu: remove two write-only hal
 components
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-5-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-5-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> RegTxPause and RegBcnCtrlVal from struct hal_data_8188e are set but never
> read. Remove them.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c      | 2 --
>   drivers/staging/r8188eu/include/rtl8188e_hal.h | 3 ---
>   2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index bd3ba6ab364f..1e6885d75bf3 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -556,8 +556,6 @@ static void _InitBeaconParameters(struct adapter *Adapter)
>   	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
>   	rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
>   
> -	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
> -	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE);
>   	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2);
>   	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2);
>   	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR + 1);
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index bfe32864ded6..b374398bad24 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -307,9 +307,6 @@ struct hal_data_8188e {
>   	u8	LastHMEBoxNum;
>   
>   	u8	fw_ractrl;
> -	u8	RegTxPause;
> -	/*  Beacon function related global variable. */
> -	u32	RegBcnCtrlVal;
>   	u8	RegFwHwTxQCtrl;
>   	u8	RegReg542;
>   	u8	RegCR_1;
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
