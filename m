Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6731856B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBKGyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBKGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:53:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 22:53:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so5833281edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 22:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NrN4FfPe5CMHaaU1dbu02FtdHBZWG5buzc/G7deMVgU=;
        b=ray3Xpbvqqfw2/L13BH10nsKdUmzDf6NL/V5NUroNiILdUUKcR8KnIrjlyapwepevO
         0bAudgtLnKfpQmFXBLBNaABqlntdajUrvBbDiTlI1J+A9YyJx9gfhQp2ERDLgw7Tpt/8
         +TGEIRHLCRpoAW9iZLUI877S42N7JECtlXezEyIttuR5caQz/1BDChI83Bl2ePeY9sA1
         cgQ9sV1GaHLql+df+gakuK5ayYdyjkqVSAT4RgXVcOnmm/qEiN8JHacIS+8WQivjMVco
         +HhjHuhSSxsL/RO/SsTh2ib1zlw2FAdB1proZZ2FS0veiumBL1OZJASKjdyuyOPYaQwQ
         jSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NrN4FfPe5CMHaaU1dbu02FtdHBZWG5buzc/G7deMVgU=;
        b=OUPGV4n/EBedyW86fpctpR/k+H6quqb/wBIOnF86BU8Q2brFJMzAvMla7rjI7gu53M
         4OeV4QTRTo9bYEglIIlfOlVtjbUq+1CILElecJF8mswEpGubqEpgSjrf8u/3Okh/jDpn
         u25ZW+SRjyshkH1tboUmdzpPsNOBqyTsFLXZv6oRX5PQCDj9bpNI1sBa6xTxU4vo/vuU
         zUg0XDgjBfnrOYh7MVinUsMCS1iGZ09NXaMtMz2bOLwY8diFZkTug2kxK/HyC9WqXHeC
         V3f1HnerWeXJ4nxfzsBM7XaW9L9sjHU/x66VZ0zlx3faz1L/NRslv+1XjIYa0GBO51f/
         ifxw==
X-Gm-Message-State: AOAM532Owdf7e2OM8MosOnbJ12NLMr9ZHX3gd3GLL28mBbEkEcE1emOh
        H3wKfODWJ4EyClI4FFi3vTE=
X-Google-Smtp-Source: ABdhPJwqGBgF72DY+3WAno6ovOdlez4lkzBI4kD6pM5/AlzGgPzxPbioIf3FiA7SW4E4vLOxd6HlZA==
X-Received: by 2002:a05:6402:4310:: with SMTP id m16mr6793687edc.207.1613026390417;
        Wed, 10 Feb 2021 22:53:10 -0800 (PST)
Received: from localhost ([49.205.77.137])
        by smtp.gmail.com with ESMTPSA id f6sm2993875edk.13.2021.02.10.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:53:10 -0800 (PST)
Date:   Thu, 11 Feb 2021 12:23:05 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Fatih YILDIRIM <yildirim.fatih@gmail.com>
Cc:     gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Macros with complex values should be enclosed in
 parentheses.
Message-ID: <20210211065305.llj6xr5phtnsv6ha@xps.yggdrail>
References: <20210211062543.9817-1-yildirim.fatih@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211062543.9817-1-yildirim.fatih@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/11 09:25AM, Fatih YILDIRIM wrote:
> Signed-off-by: Fatih YILDIRIM <yildirim.fatih@gmail.com>
> ---
> Hi,
> I have a coding style fix.
> By the way, I'm following the Eudyptula Challenge Linux kernel tasks
> and this is my first patch related to my task no 10.
> I hope I'm doing it the right way.
> Thanks for your understanding and kind comments.
>
>  drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index 39138191a556..c62a494ed6bb 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
>  #define TX_RATE_FIXED		5
>
>  /* 11b rate */
> -#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
> -#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
> -#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
> -#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
> +#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
> +#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
> +#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
> +#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */
>
>  /* 11g rate */
> -#define TX_RATE_6M	(u8)(60 / 5)	/* 11g basic rate */
> -#define TX_RATE_12M	(u8)(120 / 5)	/* 11g basic rate */
> -#define TX_RATE_24M	(u8)(240 / 5)	/* 11g basic rate */
> -#define TX_RATE_9M	(u8)(90 / 5)
> -#define TX_RATE_18M	(u8)(180 / 5)
> -#define TX_RATE_36M	(u8)(360 / 5)
> -#define TX_RATE_48M	(u8)(480 / 5)
> -#define TX_RATE_54M	(u8)(540 / 5)
> +#define TX_RATE_6M	((u8)(60 / 5))	/* 11g basic rate */
> +#define TX_RATE_12M	((u8)(120 / 5))	/* 11g basic rate */
> +#define TX_RATE_24M	((u8)(240 / 5))	/* 11g basic rate */
> +#define TX_RATE_9M	((u8)(90 / 5))
> +#define TX_RATE_18M	((u8)(180 / 5))
> +#define TX_RATE_36M	((u8)(360 / 5))
> +#define TX_RATE_48M	((u8)(480 / 5))
> +#define TX_RATE_54M	((u8)(540 / 5))
>
>  static inline bool is_11b_rate(u8 rate)
>  {
> --
> 2.20.1
>
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Hey Fatih

Try looking at accepted patches before you send one through
Like dan carpenter says sit on the patch for a day no matter how simple.
I think greg's bot picked up you have no commit message

Try using --annotate with git send-email to confirm your changes before
you send it.

I too made such a mistake so relax and take time before you send
Ideally send it to yourself first.
I am also a mentee :)

cheers,
aakash hemadri
