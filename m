Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD93F3F22
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhHVL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhHVL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:57:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD685C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:57:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v10so10404126wrd.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BujFUWKPfh9ULOTXul8Joza1GB05OuxtEo0gxSDLVLM=;
        b=FtmtZedpdgN6q+hPxMXJytaLi1u2Z2CDN4DQrBN3DPuCB9lC3X91gtitUk5ottQHLu
         RKJiQ2Kw4R1sYMLNqlRJCnBXBZTizpKyrd9jsOiSMjtlkbD18eEQJQ7EQOr7R5gTVcIa
         0OO2dMWV5HGiK9RI/k2vN/8zqygU0jTBEzwyY0dXsCoZYuZIaA2OTTSoTrFreMNhdiov
         w9i7Zhv7jWXdhMacZgHUS3FO2iKXv0QshrC4IV1JhVjkHgfFEvcnopcC4TlcPYPdlCgN
         7fzUOuRyA4ix5/LHiUsC6TFB828Nm5RJSMgOMRjeSQLfx5XCj4G5loVQtdLFSdAZ98B/
         2d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BujFUWKPfh9ULOTXul8Joza1GB05OuxtEo0gxSDLVLM=;
        b=fIFZvb0GRj9aFUJERwqsmPN0OofcpGwjIBeRszkdqfl9CkiJU4quxEEOvVFLDRJ9Pm
         MMtTfne1h7XF5JkXgD0lPWZ9BCvhtwwtGKhvFcUGnWjRcoF/Ae1NJd9TDbSNGXz1NbIu
         hcQF6SzRbMdLvlOlOQNgt7VuCz6G6qLjsCRD0vYF6BVG9iB3jGbxrkooQZNEScIhJ26Z
         p8/dCzvB04bM9rlJBwfePQrPhrg9t7pJSpJi+fVybB3up9mMCoz28wTCcL5ZEMfp/ytK
         PW66HR23rpXlW2aCDnfL5TpGyzLORqe7ES47ojosTx8MTCi/a8l3wc3NhnNVXHIyzgSc
         gjnA==
X-Gm-Message-State: AOAM533o2EMA05V1OVf2rC58KRwyeY8Oe2r+b7eyVNQvpFbhbig3wiZL
        GjiHpzp9QN4O6rSKjPt9qaZ07tGqzVk=
X-Google-Smtp-Source: ABdhPJw1g7BaYLAWa8PRyoegeomT+1Axe5l+n1SMivYHtqnFrriE5wU8D32+wGZDebVAk8Oy1S1S1Q==
X-Received: by 2002:adf:fa82:: with SMTP id h2mr8131900wrr.129.1629633433431;
        Sun, 22 Aug 2021 04:57:13 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id j17sm11690572wrt.69.2021.08.22.04.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 04:57:13 -0700 (PDT)
Subject: Re: [PATCH 02/10] staging: r8188eu: remove unused define
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-2-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <f98161a4-2065-d915-1d1e-04fbcf202e2d@gmail.com>
Date:   Sun, 22 Aug 2021 13:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-2-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> _HCI_OPS_OS_C_ is not used in the r8188eu driver. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 953fa05dc30c..a11a0597e515 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -1,8 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright(c) 2007 - 2011 Realtek Corporation. */
>   
> -#define _HCI_OPS_OS_C_
> -
>   #include "../include/osdep_service.h"
>   #include "../include/drv_types.h"
>   #include "../include/osdep_intf.h"
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
