Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A359351BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhDASJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbhDARya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:54:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D838C05BD38
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:09:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l18so1881353edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xO3dsxvfU/Plyunxb3D77pfF4fNlDgU8wQSxluJppcw=;
        b=Y72TPEyaa2Dq8XsQe6wwqyQwsKeGSuH1bHQskv5exkjmQvxEsxknYlNi6g0ELnbe4T
         8mc7TP7rOJD+i/de5dN9BqrxlOsrdAffXSUdFx1K/6dy/n+0rTMYqn9HeGpJc/29nZMi
         RSmcrnPUKV5El44SbvKDQo8Aa6KHvSb2Ud5T2uoIxtsJr+Daw20dff7HXzROGvn+apmg
         ytrvq+gn8S3IDagWFqRbPybI+PPrSrYtQLZvyZDgy4ub4UnFsyNRypRmH5PmSOlmkams
         Xo/RP3XNyv4jffx5rMZYFQubihVg3QpKVzlZFT1/XA+msTjBYFef1TlZyMxgoG6Nh/qD
         eAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xO3dsxvfU/Plyunxb3D77pfF4fNlDgU8wQSxluJppcw=;
        b=DsRhzbMwTvYDHYZPzS47C2YxMCtzm/46mxW28SAQzOhs/U8oL3eaadM3WrKE/9lssx
         fljnsuC8J9N0B9uGjmf4Tk0RTT12oQ7ZcmxdGfIhAnSDYmmoj17lXnWLsCORn+OSpFE2
         vnMCC8jx/R18lXD1AZgfDNRGNvuKEXE5N+Ow+jy9mhxLgKC6oQoa3dz5HQ1yBdB1dW2q
         AWv8j3EPAMtbs6uIr5hGnEhsjQ+Q4KGUyA3PcNk6CElLCzotLK8vQyxbDLFX4JM7cFc4
         OTsJ+qn9n/KpWUqmv8OWJGA4CLptKCbOh6pKxhICDAOYUevIUL5z8tz48m5CEp0EVdrc
         dlfg==
X-Gm-Message-State: AOAM5334I17Z3gqPmx7KWpf+F+HTuuhi6QXzwJYMaErLesSvC/nu1IIi
        oEZ4uS2/yzap9NqtCFQ9z8U=
X-Google-Smtp-Source: ABdhPJx5+6b9rgn2O44UXE28FFTYJcvj5X02ZlHRmJXtFYyLpVdJEmES4u25TJdg8YIxLy1sPK+QDA==
X-Received: by 2002:a05:6402:57:: with SMTP id f23mr9512601edu.323.1617282587175;
        Thu, 01 Apr 2021 06:09:47 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3c32:c312:443f:a091? ([2a02:908:1252:fb60:3c32:c312:443f:a091])
        by smtp.gmail.com with ESMTPSA id h13sm3570492edz.71.2021.04.01.06.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:09:46 -0700 (PDT)
Subject: Re: [PATCH] drm/ttm: add __user annotation in radeon_ttm_vram_read
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
References: <20201024004706.24518-1-linux@rasmusvillemoes.dk>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d09f16d8-528e-2815-8f26-ab85c27b1fea@gmail.com>
Date:   Thu, 1 Apr 2021 15:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201024004706.24518-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.10.20 um 02:47 schrieb Rasmus Villemoes:
> Keep sparse happy by preserving the __user annotation when casting.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going over old patches and stumbled over that once.

Alex did you missed to pick it up?

Regards,
Christian.

> ---
>
> kernel test robot has already started spamming me due to 9c5743dff. If
> I don't fix those warnings I'll keep getting those emails for
> months, so let me do the easy ones.
>
>
>   drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 36150b7f31a90aa1eece..ecfe88b0a35d8f317712 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -1005,7 +1005,7 @@ static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
>   		value = RREG32(RADEON_MM_DATA);
>   		spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
>   
> -		r = put_user(value, (uint32_t *)buf);
> +		r = put_user(value, (uint32_t __user *)buf);
>   		if (r)
>   			return r;
>   

