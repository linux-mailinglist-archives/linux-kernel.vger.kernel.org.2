Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7E3F3B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhHUOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhHUOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:46:19 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6EC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:45:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso1428021otu.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=seOiZCj4hVVjWxrbxl6hqZpUw4GOWVp72vSNdyBOoLQ=;
        b=i0TMWCd4aPkJFrJ/hQK1dtztJRvrcDKtXs64adu7ftX/RSQWKNo6jyWeVN28cLQoxR
         UjzLKXFricQ4rRMyRWWOCoZ9/fPUyz6+E6XPnzwKQdl5nTLB8nbNTz4VtQopf/XI8lq7
         38s7VJcaMuf88SacBaXC5WfcLg5h6L2FPOmIT00kGatLQmcog0EsRPVT4pW2TeEcm2Ig
         g69TWLU4Ew63QftZrrtVfSSA6GaH3DPQN0FOYO0IslsNpqItfkb6Y+yH1e7YI31bEGJu
         i99POLa4V84gllAxucSNAPcjM03BH8uJwABKBVb4a2CCMr2dAy34zMFsxGrbjCDTtKQx
         s1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=seOiZCj4hVVjWxrbxl6hqZpUw4GOWVp72vSNdyBOoLQ=;
        b=dmVLP58LHIY9VCHG5O2z915WQvmi7WKlG2x1SnvM7eWBpKZ7Faab012Gt67Ag3KQkL
         1h+yf6VcdlpG8v0OCIc6KEHcjhkeAJKJGMiiwrWGWnbZOEb8nqsNcYcP3HcYMuTXiFYu
         dI+RMC70kONbKup/Qm71onwUrxF3WDLIsN9FGAAzbJxenKD79mxIucvMHa2sHaq2ezPS
         s6oEhITt451kTI+jQe/ClN+0+BOC7IsOQRTHBiupasnw0wlod5My9M5vtW/kigBGiI8Y
         gi8YI/HcCZ4suGh/1yh7yptCF/R6KJOAJnvf4zk0+hmR/7UDQsfu2ARfnlan1mZXwNjy
         bGZQ==
X-Gm-Message-State: AOAM5332oNk/ojHzqpO1sEko2/imDtyoIjZ8LrrWtKrcOdLpQ4LtDerc
        V97qq62XkqGOPagN+NmSz3w=
X-Google-Smtp-Source: ABdhPJzbSYJyfMoiDDta8lSR4MWJveHmEwBOFW1zZr+vo3bqHaniyGSWUjJ1ikOgaDV/NmBLpjc62g==
X-Received: by 2002:a05:6830:1db3:: with SMTP id z19mr2008366oti.369.1629557139608;
        Sat, 21 Aug 2021 07:45:39 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id u14sm2389634oth.73.2021.08.21.07.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 07:45:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove forward declaration of
 Efuse_Read1ByteFromFakeContent
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com
References: <20210821000508.79422-1-phil@philpotter.co.uk>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <ac672cfe-038d-2fe9-0ac6-904ad7761b54@lwfinger.net>
Date:   Sat, 21 Aug 2021 09:45:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821000508.79422-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 7:05 PM, Phillip Potter wrote:
> Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> from core/rtw_efuse.c, as the function is defined in full directly
> after this and therefore this forward declaration is redundant.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_efuse.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
> index decccf7622f0..45b757ab64e1 100644
> --- a/drivers/staging/r8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
> @@ -29,12 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
>   #define REG_EFUSE_CTRL		0x0030
>   #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
>   /*  */
> -
> -bool
> -Efuse_Read1ByteFromFakeContent(
> -			struct adapter *pAdapter,
> -			u16 Offset,
> -		u8 *Value);
>   bool
>   Efuse_Read1ByteFromFakeContent(
>   			struct adapter *pAdapter,
> 

Phil,

There a number of such forward references immediately followed by the actual 
routine. I removed some of these when the driver was in the GitHub repo, but I 
missed a few.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

