Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFF3DBE88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhG3Svs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3Svr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:51:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA570C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:51:42 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so10596844oti.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yA4gui9DD/LmW4Ty2YpYVvn6CWdZivb2tv6TTmjH338=;
        b=jpR6lkUrbB+YEgoT+BkTpMdJW66emssZ3GLxwGdx9gaTQOonAxKjPO6d9tBxE1Ytwf
         Cv3hjg+IOZP2mqOhlepwn+BDxxPpCE1CpQ1OWXzpW/PRjCIV06JhHXXp3JUFFS4se/Ki
         /yWUfWuaIfBGwggvtKOhX4OREFCLTQTBqRLRI5KY9M+oiASZa0tBQmPL590YJ1QG6Syk
         gQ/ceNJPEydt90o2a3bg7ehAcRSYwEgZjMriSN99UxMTwPYWAtg+IWvbUMYZRa0e3YVg
         Irg3YvKJkH25GNqgIOVWkonYk0xrPzJ3q5FlsTRsYoVsHxD8siwosEcM54vtNNdvERUB
         PZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yA4gui9DD/LmW4Ty2YpYVvn6CWdZivb2tv6TTmjH338=;
        b=piYLeXBD8EvVDET3ElBSuuBMzJy48ASMMguA3B12814ynqrJD41EzsZ4UwxgBJV6IT
         ZK7hR6Ud5KMdtCJFCWekI7ScICQ7PaBN/I9VjJmFpNJIkRMuJLNkue2dFWJ8H0pazsfs
         TToEfhAW3JsYplhhWz1USYqEMQVa8HHy6r5TxUUK8p9yeH/mN8PO9GT15ElZ/EJZT3HQ
         JWU63dNUf93GGCm9vgGS/gbBcj1HHPwBWociIes4GRhNTjhhb7GS974aWNhQAdQiq3Lr
         sdhHc9+/8axWD4ujfkyOoWG9YIRS3ZqWIJGf6r/8thoKKnHqwtNe0VAY0C+rtq/kcJIU
         wRwA==
X-Gm-Message-State: AOAM531J9+2lbjQnmdRO7Jqjty2Uvr38pg6JM3kdd6y3VwBN98C5XRB0
        WYDF5cwEODmCackbGxTsuL8hXKT0ps4=
X-Google-Smtp-Source: ABdhPJx04fJT3RC9KgaKQ2xlKPiYjlAdDtm8VKvhjoBdpCaz6zJOtG1EmuH0AwL+YQyj7w5mti38fQ==
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr3199524otr.166.1627671101823;
        Fri, 30 Jul 2021 11:51:41 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100f.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100f.res6.spectrum.com. [2603:8090:2005:39b3::100f])
        by smtp.gmail.com with ESMTPSA id q13sm367386oov.6.2021.07.30.11.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 11:51:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: Remove no more used functions and
 variables
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210730103716.27210-1-fmdefrancesco@gmail.com>
 <20210730103716.27210-3-fmdefrancesco@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2daf2287-e019-3be3-6627-b698bee6246b@lwfinger.net>
Date:   Fri, 30 Jul 2021 13:51:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730103716.27210-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 5:37 AM, Fabio M. De Francesco wrote:
> Remove the functions and variables from rtw_security.c that are no more
> necessary since the patch that replaces getcrc32() with crc32_le().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_security.c | 37 ---------------------
>   1 file changed, 37 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
> index 9625beea4b3c..136ba1e61dca 100644
> --- a/drivers/staging/r8188eu/core/rtw_security.c
> +++ b/drivers/staging/r8188eu/core/rtw_security.c
> @@ -74,43 +74,6 @@ static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32
>   
>   }
>   
> -static int bcrc32initialized;
> -static u32 crc32_table[256];
> -
> -static u8 crc32_reverseBit(u8 data)
> -{
> -	return (u8)((data<<7)&0x80) | ((data<<5)&0x40) | ((data<<3)&0x20) |
> -		   ((data<<1)&0x10) | ((data>>1)&0x08) | ((data>>3)&0x04) |
> -		   ((data>>5)&0x02) | ((data>>7)&0x01);
> -}
> -
> -static void crc32_init(void)
> -{
> -	if (bcrc32initialized == 1) {
> -		return;
> -	} else {
> -		int i, j;
> -		u32 c;
> -		u8 *p = (u8 *)&c, *p1;
> -		u8 k;
> -
> -		c = 0x12340000;
> -
> -		for (i = 0; i < 256; ++i) {
> -			k = crc32_reverseBit((u8)i);
> -			for (c = ((u32)k) << 24, j = 8; j > 0; --j)
> -				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
> -			p1 = (u8 *)&crc32_table[i];
> -
> -			p1[0] = crc32_reverseBit(p[3]);
> -			p1[1] = crc32_reverseBit(p[2]);
> -			p1[2] = crc32_reverseBit(p[1]);
> -			p1[3] = crc32_reverseBit(p[0]);
> -		}
> -		bcrc32initialized = 1;
> -	}
> -}
> -
>   /*
>   	Need to consider the fragment  situation
>   */
> 

These two patches are

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks for your contribution.

Larry

