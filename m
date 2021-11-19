Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E36456EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhKSMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:07:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90851C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:04:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso10296727wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEl+2nnslB5uaeju5+/7vr2ZFc54QG0+pBvSVOyEKew=;
        b=wDzgQVthg8pLs/fZi+XntPUZ1VfVWCSzNKy5hhFLiC6MpqSw3pBohzKhJAmGUYsKZK
         MX1pY5gxYnF9QoeYd0YoR8TScsLTElz9JkTcT7HXFtRHAvkIpCoFrTBwgmnQJGHPX8AV
         fhcI9KEgeSeWFugvGruZeHk6akAKXIMDSIOQjPW5PNQZfNuI7RakkT0FlmgFj0ZBLbuN
         mjN/911pMSgtYscGK+XJUeUJjUBQEd6W7DUWXemcWVUnXvdAVdNgO6Kucgi0Ti+GHIdv
         TDQ3Px3kKHW1x1NHEv2aBCYmDKqQzFim2ewNCYsaGPu070/TDxXNcxI0UplpycZ7cQFS
         17Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEl+2nnslB5uaeju5+/7vr2ZFc54QG0+pBvSVOyEKew=;
        b=S22ymSDUuoeVd8grlhu9nfF1MMNEKhuYsxrqtgktgyF3xxH+f9M8JZx6zj3ok12m7/
         qJEeVB3LVZEPzQg0oMA27A8Qz40S+pWiuEuuAMzNhIyC9havm8XQQmIFfu2CcBM/S5/V
         9yWlYrmNC8OJ8ElXXOShKVpIXk510eGe7YJJOOpFt173Wibp2fr/mG0gK/OYpQ8rOf03
         IK3Cs7+liymNGpUxs+aC+DK+IEi2NZ/ncsz/x60vlmjiULwQbX1kfISCfhUwqNKlFBH/
         6bEZOHLDnHs0bpvoiaRZN2a5rpYVexheGtxiK/ayuUrjQSIy0n8ghkuymQns75aBvbFO
         WA1A==
X-Gm-Message-State: AOAM533+IE8VhmUEtRL20VSLSGymrkL3cL6GRUe/Nc8kgE1GCuiYSRLO
        BVTYZ5zm2uNpbGSxAi6JZBrwKAnjIqw8Y3E1ae1+V/ix25GvO3AZ
X-Google-Smtp-Source: ABdhPJypwWwXyOzdLATGe0dexpc49ClDU8TYSHiRiLM/qwW9xedwkZVJJQq7TaRuLJIFMJ8EnXYjfkTOwhlOOudOWnM=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr6173497wmf.177.1637323479085;
 Fri, 19 Nov 2021 04:04:39 -0800 (PST)
MIME-Version: 1.0
References: <1637309143-53528-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1637309143-53528-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 19 Nov 2021 13:04:28 +0100
Message-ID: <CAHUa44EPVSQSMr78om6SXG3B+UEQ-J6qUnLJs_ZqswTAbTv2+Q@mail.gmail.com>
Subject: Re: [PATCH -next] optee: Fix NULL but dereferenced coccicheck error
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 9:05 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
> dereferenced.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/tee/optee/smc_abi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 92759d7..1f471ff 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1505,8 +1505,6 @@ static int optee_probe(struct platform_device *pdev)
>         kfree(optee);
>  err_free_pool:
>         tee_shm_pool_free(pool);
> -       if (optee->smc.memremaped_shm)
> -               memunmap(optee->smc.memremaped_shm);

Thanks for reporting. This should rather be fixed as:
        if (memremaped_shm)
                memunmap(memremaped_shm);

Cheers,
Jens

>         return rc;
>  }
>
> --
> 1.8.3.1
>
