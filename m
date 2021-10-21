Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2A435EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJUKXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUKXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:23:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37029C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:21:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so171485wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L8BI/UeS5rklzPLKEiL5KyWodzXOR1Tsa0X8Ku4Jm8A=;
        b=TJi+c1pOx7myObGBybET7L+8R1yOArMZhm5m5XroKUVu0D0S+gBgHesZQUSqxMnXcg
         1RMo3M14FUSH6ERPR6udzoVQWsBs/8SSdM4pLexBy5sWnYX7g/gOnSzL8qIBezeX/v6t
         c+diEaYveT7AKvhYUDrYTZ54BRy1yKMUR8afURcTcrkvI7LiO7zw6SLE9EHj60FQg8bi
         20yWNeSIKFM3qmOObNthVPUhGdkxz+ZZdQMGexzl9PBxRyDXbyaVoeYhEBnlFTmMtsTX
         zg98E6v4HXM3FX1NcbJuCyZpUkSozkxYBv691YRh/FKAT6lMD1o+O1NCRJkOGGJaDzSw
         FZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8BI/UeS5rklzPLKEiL5KyWodzXOR1Tsa0X8Ku4Jm8A=;
        b=esh3Ja4Vx+jpw5XlJdBPl0KKgBXkvNUvTuXmB5E0YVKFAWfwqoPHeY5m6Rx5pT9eXM
         dXxNLYkKp+mo28WTTTJVvzpC4pht/SPBLMXd9fAuVr0FMknOxqXt5o3IPWjQKp1A0VHU
         Sa7+QZo6/QCaKUQAISBty0zwKQ68OOy2nfSl9UWKYciMLF7IUdIAjWNXppzzS8JAO2PN
         DeT/Mk7rK/khMhZdhTgs4ILb89lt6yC42Krm25BdNFjsenVhSUV3FoUlFiF26L88sx6H
         klv14UwRNWYudhL3OdA5vXnw7zTRwzqJxSNpEiYxlssoR2UP+BG4Ms9iQ4LchDpA0Yhx
         LT6g==
X-Gm-Message-State: AOAM531QWj2FBwaJOaZoSlopjZgwyektQDzt3AMt47EsEniqHjavAS1l
        sEZTHKwEKhPmBrEOySJa6Eo=
X-Google-Smtp-Source: ABdhPJzeKbxbQ74FY69QJbDgUFdVmDcKbQKYa2kzZhfUE1ac9kmAlCaA+hHtVT/VQ4GgPxHy0L5ySQ==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr6071813wrv.171.1634811682829;
        Thu, 21 Oct 2021 03:21:22 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id t188sm4473276wma.43.2021.10.21.03.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:21:22 -0700 (PDT)
Message-ID: <4312f537-524a-77f6-baa6-a00d4a40b676@gmail.com>
Date:   Thu, 21 Oct 2021 12:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/5] staging: r8188eu: remove unused defines and enums
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-5-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211020195401.12931-5-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 21:54, Martin Kaiser wrote:
> Remove a couple of unused defines and an unused enum
> from rtl8188e_cmd.h.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/rtl8188e_cmd.h | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
> index 01404b774ebd..1e01c1662f9a 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
> @@ -27,15 +27,6 @@ enum RTL8188E_H2C_CMD_ID {
>   	/* Class DM */
>   	H2C_DM_MACID_CFG		= 0x40,
>   	H2C_DM_TXBF			= 0x41,
> -
> -	/* Class BT */
> -	H2C_BT_COEX_MASK		= 0x60,
> -	H2C_BT_COEX_GPIO_MODE		= 0x61,
> -	H2C_BT_DAC_SWING_VAL		= 0x62,
> -	H2C_BT_PSD_RST			= 0x63,
> -
> -	/* Class */
> -	 H2C_RESET_TSF			= 0xc0,
>   };
>   
>   struct cmd_msg_parm {
> @@ -44,10 +35,6 @@ struct cmd_msg_parm {
>   	u8 buf[6];
>   };
>   
> -enum {
> -	PWRS
> -};
> -
>   struct setpwrmode_parm {
>   	u8 Mode;/* 0:Active,1:LPS,2:WMMPS */
>   	u8 SmartPS_RLBM;/* LPS= 0:PS_Poll,1:PS_Poll,2:NullData,WMM= 0:PS_Poll,1:NullData */
> 

Looks good, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>
