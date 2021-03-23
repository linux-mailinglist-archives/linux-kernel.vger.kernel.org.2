Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB6346968
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCWT7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhCWT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616529554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnU/WxIV38U6h+KpWHxuZSN2zS4UClavD9NJYvWgSiQ=;
        b=KmfBZixtdTztpbOmhcBj1TbV7V+L6RSbckgVo0FHNparz8uU3wkda6K/pfRy6rescWTfGE
        EaclzWxtJudbrOO/K/aSWFa1QJ1uEjJqMGb4BQV/Q5z7giluhGyfJ/GlYFO9uRIoLxV3UR
        8LG58Z5jlt/CmUlnMuaR/j4wTRAI09s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-VJzlf7__PEiZXNOUfOKP3g-1; Tue, 23 Mar 2021 15:59:10 -0400
X-MC-Unique: VJzlf7__PEiZXNOUfOKP3g-1
Received: by mail-ed1-f71.google.com with SMTP id h5so1483929edf.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZnU/WxIV38U6h+KpWHxuZSN2zS4UClavD9NJYvWgSiQ=;
        b=QrmqGBoQEKLg6+YICRGNqzI94sEvxRD4tchJpH5SPFwtNL7Fve8YP4ZwbGMYxcVGJv
         X8cy+L7uwwJY3rYuwQauD3+dJIywu3s+GWL04P9kphasYE7F67LmjfgGOtHuz/4YeChE
         uJyCxmHY3FVWBOJz951UeiA5dUd6sHS5XmkBvmfV2IKagH+kLp8EMMm3ODBkhnuGzR5v
         i5rPgCBHylBgDXl6jMqySMe4fXvJw89vn4cfVNDWsqas8tc8ZTVIomc9s7CRSjRO/H+y
         pDN+pAD7XYgg35fwfirHOGvAW2dSM/QPd0rfHsUSME2jBVmYkspNNHKTRglvGWfHjuHM
         cU7g==
X-Gm-Message-State: AOAM531f7nUqE2QuV8dtHuEYL7fsEpt+Otf8frcFJpk1yaxh2wNiQepR
        E/Pe/Vk0BxbW+CluSrEJWNReNCz5pJOTugGwY35y2FUpQukWG4N+pMa3mdpZ2dnp9+oIHkqzp1C
        qaTaIZecOJ2joCQtdJJYQe5pN
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr6260146edb.243.1616529549297;
        Tue, 23 Mar 2021 12:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+vu1miGSiLvu0tDwIVVVskyv2SMYDx5RCClcXRYYxAqmgBO6rbIyn7Ks4ZDjtrsqXfZsjnQ==
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr6260135edb.243.1616529549118;
        Tue, 23 Mar 2021 12:59:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y24sm1095eds.23.2021.03.23.12.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:59:08 -0700 (PDT)
Subject: Re: [PATCH] platform: mellanox: Typo fix in the file mlxbf-bootctl.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, andy@infradead.org,
        dvhart@infradead.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210317095650.2036419-1-unixbhaskar@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0f460307-25e6-4aad-5d43-31bfee59ef75@redhat.com>
Date:   Tue, 23 Mar 2021 20:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317095650.2036419-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/17/21 10:56 AM, Bhaskar Chowdhury wrote:
> 
> s/progamming/programming/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/mellanox/mlxbf-bootctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 5d21c6adf1ab..1c7a288b59a5 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -208,7 +208,7 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
>  	 * 0011 = version 1, 0111 = version 2, 1111 = version 3). Upper 4 bits
>  	 * are a thermometer code indicating key programming has completed for
>  	 * key n (same encodings as the start bits). This allows for detection
> -	 * of an interruption in the progamming process which has left the key
> +	 * of an interruption in the programming process which has left the key
>  	 * partially programmed (and thus invalid). The process is to burn the
>  	 * eFuse for the new key start bit, burn the key eFuses, then burn the
>  	 * eFuse for the new key complete bit.
> --
> 2.30.2
> 

