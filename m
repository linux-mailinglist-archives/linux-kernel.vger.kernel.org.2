Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6366F367CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhDVIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhDVIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:36:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF766C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:35:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d21so32331671edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s/cffvQ0TVq9UxDXzdd2LQZUeEczDjN1Xnth6iUsGig=;
        b=x4Gspg/q2I9oEmvUCCEpSE1b5ox2sUEqPUdnOLrcQE3vOppB6PQ6k9ZtofzZWjEb1a
         3FM+8LzcyvfoDOVXVX2nLmOeRHWMFKPqVAw35Zd0ovSrELefjmKTQtc93IWZ29wFT2Xu
         dszd++1QZeg4Uq62kbvQ8KtWlXfJOkXJHdwbeGAo3oCJ/uJkgivFSbEyHNPd+unBxtvN
         Qbws78wMcY4LxGWHBHO1nZLpuXz+fYjJ18BaK3AzkoX/Vbg81raEKeruJgoWghxfe5iN
         1g5oeGedVkhJLBP500FhtA+imSlVj+fa9sCjZuZgEDFKeVvLVdfzsstzfwBrpTGBlWH3
         7Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/cffvQ0TVq9UxDXzdd2LQZUeEczDjN1Xnth6iUsGig=;
        b=lCaKTmMhx6MuXodCWp1w8pBAdLX5c8cXiCIgO/2m3KZfDcqRW+IhYFYfFEVjNOacFe
         xwOvQG1drR19Uvygj14BiBBH1DMSzai6Fauk62G2pQXfbtI+XsIQTJFMwJsohcWJx3DT
         aQAR7LANZuvhBZ5fu3WmArOVLgkGebIdhMeKGJKJHbQvt1cSp1jS38uMd7UXJhTjxCLR
         mOIqQz2OUs15DGiImJFyNHxFrWTBhzlPeGTvh99ps0326hYSk1mlMYWEZbd3WFOzTaQT
         lhQGSOHY3SZGYWsRBDBgJCF2/FwnxFnA0ts2FPrDVfCvFH15UG7FVzKNkONW80fBdlp6
         HG7w==
X-Gm-Message-State: AOAM532fuoGzUHGwSoL95dGmHav1QP28zyMfLcQdWTOuOj9n9BcYuwZw
        p0akv4utTlVtzvNkJQRLUEI9V7E9z/VIHIeH
X-Google-Smtp-Source: ABdhPJy5++Q5jV8wK05xdQAYd8mpIXSUhqXjhLrZbJJKic6rtCN+qkeWE87S9QEp6RKBdzG1jxC2bA==
X-Received: by 2002:aa7:d3da:: with SMTP id o26mr2381639edr.147.1619080553981;
        Thu, 22 Apr 2021 01:35:53 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id u19sm1468911edy.23.2021.04.22.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:35:53 -0700 (PDT)
Subject: Re: [PATCH] microblaze: add 'fallthrough' to memcpy/memset/memmove
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20210421022041.10689-1-rdunlap@infradead.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <2e96bc5b-2f2b-fcd5-ec38-8f0ca33dff60@monstr.eu>
Date:   Thu, 22 Apr 2021 10:35:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421022041.10689-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/21 4:20 AM, Randy Dunlap wrote:
> Fix "fallthrough" warnings in microblaze memcpy/memset/memmove
> library functions.
> 
>   CC      arch/microblaze/lib/memcpy.o
> ../arch/microblaze/lib/memcpy.c: In function 'memcpy':
> ../arch/microblaze/lib/memcpy.c:70:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    70 |    --c;
> ../arch/microblaze/lib/memcpy.c:71:3: note: here
>    71 |   case 2:
> ../arch/microblaze/lib/memcpy.c:73:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    73 |    --c;
> ../arch/microblaze/lib/memcpy.c:74:3: note: here
>    74 |   case 3:
> ../arch/microblaze/lib/memcpy.c:178:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   178 |   *dst++ = *src++;
> ../arch/microblaze/lib/memcpy.c:179:2: note: here
>   179 |  case 2:
> ../arch/microblaze/lib/memcpy.c:180:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   180 |   *dst++ = *src++;
> ../arch/microblaze/lib/memcpy.c:181:2: note: here
>   181 |  case 1:
>   CC      arch/microblaze/lib/memset.o
> ../arch/microblaze/lib/memset.c: In function 'memset':
> ../arch/microblaze/lib/memset.c:71:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    71 |    --n;
> ../arch/microblaze/lib/memset.c:72:3: note: here
>    72 |   case 2:
> ../arch/microblaze/lib/memset.c:74:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    74 |    --n;
> ../arch/microblaze/lib/memset.c:75:3: note: here
>    75 |   case 3:
>   CC      arch/microblaze/lib/memmove.o
> ../arch/microblaze/lib/memmove.c: In function 'memmove':
> ../arch/microblaze/lib/memmove.c:92:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    92 |    --c;
> ../arch/microblaze/lib/memmove.c:93:3: note: here
>    93 |   case 2:
> ../arch/microblaze/lib/memmove.c:95:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    95 |    --c;
> ../arch/microblaze/lib/memmove.c:96:3: note: here
>    96 |   case 1:
> ../arch/microblaze/lib/memmove.c:203:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   203 |   *--dst = *--src;
> ../arch/microblaze/lib/memmove.c:204:2: note: here
>   204 |  case 3:
> ../arch/microblaze/lib/memmove.c:205:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   205 |   *--dst = *--src;
> ../arch/microblaze/lib/memmove.c:206:2: note: here
>   206 |  case 2:
> ../arch/microblaze/lib/memmove.c:207:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   207 |   *--dst = *--src;
> ../arch/microblaze/lib/memmove.c:208:2: note: here
>   208 |  case 1:
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/lib/memcpy.c  |    4 ++++
>  arch/microblaze/lib/memmove.c |    5 +++++
>  arch/microblaze/lib/memset.c  |    2 ++
>  3 files changed, 11 insertions(+)
> 
> --- linux-next-20210420.orig/arch/microblaze/lib/memcpy.c
> +++ linux-next-20210420/arch/microblaze/lib/memcpy.c
> @@ -68,9 +68,11 @@ void *memcpy(void *v_dst, const void *v_
>  		case 1:
>  			*dst++ = *src++;
>  			--c;
> +			fallthrough;
>  		case 2:
>  			*dst++ = *src++;
>  			--c;
> +			fallthrough;
>  		case 3:
>  			*dst++ = *src++;
>  			--c;
> @@ -176,8 +178,10 @@ void *memcpy(void *v_dst, const void *v_
>  	switch (c) {
>  	case 3:
>  		*dst++ = *src++;
> +		fallthrough;
>  	case 2:
>  		*dst++ = *src++;
> +		fallthrough;
>  	case 1:
>  		*dst++ = *src++;
>  	}
> --- linux-next-20210420.orig/arch/microblaze/lib/memmove.c
> +++ linux-next-20210420/arch/microblaze/lib/memmove.c
> @@ -90,9 +90,11 @@ void *memmove(void *v_dst, const void *v
>  		case 3:
>  			*--dst = *--src;
>  			--c;
> +			fallthrough;
>  		case 2:
>  			*--dst = *--src;
>  			--c;
> +			fallthrough;
>  		case 1:
>  			*--dst = *--src;
>  			--c;
> @@ -201,10 +203,13 @@ void *memmove(void *v_dst, const void *v
>  	switch (c) {
>  	case 4:
>  		*--dst = *--src;
> +		fallthrough;
>  	case 3:
>  		*--dst = *--src;
> +		fallthrough;
>  	case 2:
>  		*--dst = *--src;
> +		fallthrough;
>  	case 1:
>  		*--dst = *--src;
>  	}
> --- linux-next-20210420.orig/arch/microblaze/lib/memset.c
> +++ linux-next-20210420/arch/microblaze/lib/memset.c
> @@ -69,9 +69,11 @@ void *memset(void *v_src, int c, __kerne
>  		case 1:
>  			*src++ = c;
>  			--n;
> +			fallthrough;
>  		case 2:
>  			*src++ = c;
>  			--n;
> +			fallthrough;
>  		case 3:
>  			*src++ = c;
>  			--n;
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



