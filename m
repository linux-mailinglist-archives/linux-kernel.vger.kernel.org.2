Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BEB3F3A55
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhHULEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHULEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 07:04:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2EEC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 04:03:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so8370863wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+oBfSTls/jelXZfAiR3pNRnb9JU1CX2FyMD8hziKDQ0=;
        b=eYRMnopUXoYrlOmkuwqRXuHSrTRE+iwUJe3ofMMk/ZHeKJmbNCQNIDdoGD38IBvVPH
         9ulrJAjsZ6TgSQ/JVXcmkfsBeXEbVlgxJ+Fqu+zXNzUAo8nfupq0ys8fU0rP4zM4/von
         Jsxjlsp9hnwJ/jVCoHP71uZinidjHwCqPnxHbAhMV/ib58JpxX8Da1z/9gEo+bXSsHvh
         fL8Fy2hD8ZC9OXFHgWth0+FcZceisy4NEUfv2CZQW3UXm7PlgepGeHlwKWqAiyHq9aDz
         rP0nN7pAabTPOKTwUdzMQNdAv8XRUmBxefkjBkFb/gLDx/8nIcWq3SZfScL0TRjKI2f0
         rU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+oBfSTls/jelXZfAiR3pNRnb9JU1CX2FyMD8hziKDQ0=;
        b=IJYxRmuT7lfHjrx4GCdpLoZ9vaMw6SIpQKyLsjXkZU1oVrRy9MuI5t6Q4GcV2g8XHG
         lx0mTLOwR755C2skNIaTwtbUM1qgGcTLLgbpL2lopzivgEtithcvEp+kar5C4MbeAR39
         SCAUyTe0YVctOUq4t1wqsMC2w0RW+B288PyQ2VKdoQEZNsHdFE2qfNlCE3o6NgMWHCCl
         xsS6S6LUiamkkQD0z1FpLPaaXdIJM8XyXDqssojStiejILA5uSFClDEJBbf4BSIAM6AA
         BfVvUmS0H7l9IqJzZRrZX3mi9jyyIpfx+aG00848902NefOhux+6qy4B6faXhmpoGUMH
         M3mw==
X-Gm-Message-State: AOAM532PwfmnuVg9k4ZGxP05sfmseUcFfwpBFPCtiKRRpI0bg8gWupDz
        04hB7A6LyQ6MbQbWZBqJOz0=
X-Google-Smtp-Source: ABdhPJy2xXAhK3JwFgr+FxlHKupWZkKRxvUDlPEVUIrIJksHQ1Bq0E2IeeN5MeScrbJLV4ddgQLXTA==
X-Received: by 2002:a05:600c:2f0f:: with SMTP id r15mr8044964wmn.29.1629543822429;
        Sat, 21 Aug 2021 04:03:42 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::3c39? ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id d4sm9152919wrc.34.2021.08.21.04.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 04:03:42 -0700 (PDT)
Subject: Re: [PATCH v2] staging: r8188eu: change declaration of
 Efuse_Read1ByteFromFakeContent
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, Larry.Finger@lwfinger.net,
        fmdefrancesco@gmail.com
References: <20210821105615.6307-1-phil@philpotter.co.uk>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <f151ef3c-d625-a937-2096-afae4fee20f1@gmail.com>
Date:   Sat, 21 Aug 2021 13:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821105615.6307-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 12:56 PM, Phillip Potter wrote:
> Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> from core/rtw_efuse.c, as the function is defined in full directly
> after this and therefore this forward declaration is redundant.
> 
> In addition, convert the storage class of the function to static, as the
> function is only used with rtw_efuse.c, and tidy up the signature
> alignment.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> V1: Removed forward declaration.
> V2: Takes account of feedback from Michael Straube and Fabio M. De
>      Francesco to make storage class of the function static.
> 
> ---
>   drivers/staging/r8188eu/core/rtw_efuse.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
> index decccf7622f0..c1c70648f5bc 100644
> --- a/drivers/staging/r8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
> @@ -29,17 +29,9 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
>   #define REG_EFUSE_CTRL		0x0030
>   #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
>   /*  */
> -
> -bool
> -Efuse_Read1ByteFromFakeContent(
> -			struct adapter *pAdapter,
> -			u16 Offset,
> -		u8 *Value);
> -bool
> -Efuse_Read1ByteFromFakeContent(
> -			struct adapter *pAdapter,
> -			u16 Offset,
> -		u8 *Value)
> +static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
> +					   u16 Offset,
> +					   u8 *Value)
>   {
>   	if (Offset >= EFUSE_MAX_HW_SIZE)
>   		return false;
> 

Looks good to me.

Acked-by: Michael Straube<straube.linux@gmail.com>


Thanks,

Michael
