Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3E3FA74F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhH1TVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhH1TVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:21:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C6C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:20:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so6669320wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3blXmIdosDOuNNq7nc3EFCtcuawBSD/bJRQmtHW5+7k=;
        b=BoUhq/GfIAy4h/4PE78IRtrCiIBdQAyXgY6Hkfs+QynhWluSjz7NDD+9Umc0Pr8E8M
         fHbWxcESZS4Hh8Owb59LUMiZQmODjssSQ6AxMWJ1KdUld7S3t/3/fU8AOG7gOnIrI8NX
         Rx1xrMjwKfUQTkS/Aw+/7Mx4LkNtmteALToLtPY5No8G+/8xTNsyxWr8nnKLA6HJBJSy
         jyxW2Na7Ydie2n3BvrB/bHckxzIHV9oKuHT/JGcYhDveRPP6miCnqt44nJIRceFZqIRk
         3BfOBEVqu6Y5grr/EgSCJb/NJddRA5sZKIH0mWsV7s/ORtvHHHv6jjf7Kq3EkFQUpRr+
         LfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3blXmIdosDOuNNq7nc3EFCtcuawBSD/bJRQmtHW5+7k=;
        b=Omea2CEjfdKzgyYCDvrc9oBAVlALEgrHa6ocIIN0Rsp9NJSB02rUflPgslLxqG5BUG
         D5z4LcxSN+aIEEvgTgm1Hf5bKJKoyNPE3flZJolHMAESxX8gIid+BNUVHJ4yxt29gfyv
         JilgslCg0wG1dVLsCCtmFOfgg84ERa99Gby6rqyC6AQ6lufooqaSqJhfRQh4YDdghSXX
         n3bD3Bu/ctrtFTBUSNVdV2QuetFEHe09xEccfL9LAUlD5rVjbKobblV3ZV7CFji0wRhR
         PISM8aq0BzAsHLZ1GkEmSTvbigUWYFBDSEjshmjCM9HtwQKlyTO+qWP5c0ousvukR8IT
         xS6w==
X-Gm-Message-State: AOAM531+eBusHNR+P6pwRUH67FvaQXCRm/GJpEs2nk/4Ri+U0sLS0bYM
        Y2u2IaP/O34C6yiX/gAizN8=
X-Google-Smtp-Source: ABdhPJyz5Emi3EedmduPhplg1maqn6jL2UZ6g5VEtgiYyqYMWWDP52GalTmaWl05OkvAXPqygVClRQ==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr15046919wmc.148.1630178456131;
        Sat, 28 Aug 2021 12:20:56 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::884b? ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with UTF8SMTPSA id p13sm10288209wro.8.2021.08.28.12.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 12:20:55 -0700 (PDT)
Message-ID: <1e31610a-0324-dfb7-abe5-f05d652d461d@gmail.com>
Date:   Sat, 28 Aug 2021 21:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: core: remove null check before vfree
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YSp4UP1+HrhmDA3C@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YSp4UP1+HrhmDA3C@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 19:54, Saurav Girepunje wrote:
> Remove NULL check. NULL check before freeing function is not needed.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> index f6dffed53a60..4726771a8403 100644
> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> @@ -155,9 +155,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
>   		spin_unlock_bh(&pstapriv->sta_hash_lock);
>   		/*===============================*/
> 
> -		if (pstapriv->pallocated_stainfo_buf)
> -			vfree(pstapriv->pallocated_stainfo_buf);
> -		}
> +		vfree(pstapriv->pallocated_stainfo_buf);
> 
>   	return _SUCCESS;
>   }
> --
> 2.32.0
> 

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
