Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771AE39CA67
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFESHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFESHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:07:47 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15113C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 11:05:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn21so16004727ljb.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HPNZUjts9UudLzP09/coPUV1Ff1X+d0BSq9trpWcovM=;
        b=fX38TsT3xJ6wNl0xHLCorZDdBhQrq9paS38D8mjCjJ/V/XwE69CpSRog+NL61s8txT
         JQaGF+NKVA9v0Y20FkW1TkQt1q9HH+J1oujuCM1OCOyy8MJMhRy+hc2XW8DjvGdiGTtj
         iWevNQxvBlt66bk/P45X/OtR00+UEr41ZcEBzAI9nBm6cwuNCe6DxD+ORMb6GCQ3H1Ez
         Dd9I7SNuBpjBkoRUEw8+eY81DBHGuiBU7eHUWWI+sgurgxa2XI6jXYw2pJPHIIDRocl4
         4hMDHzcrnpwd0COthwKDe699yOG3UC8jl58XIkC5y4tvMSQjZk2JOufzTKN5T9LpAWLU
         Cjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HPNZUjts9UudLzP09/coPUV1Ff1X+d0BSq9trpWcovM=;
        b=o6u3wbMSOD6frxnw9diBPs3vCi0gObVt6DLbevXBH9ffyJ95MjPSH9mu/Hb9tSfogV
         9iI5anIvdnIgnSmkXrj4Q0CV2lB5Qv6QZW2w5NUl2PoCRjGuWFjHnDWpaHjHuQG9yTAw
         PFQ96+iBYegD5uyAwkmFya4r5Sm9258XeOBjDUzkNyVzoQcNhDkvE9+PMnPPfIDMKN47
         6yrSO8EQkFEL6h88hhiyeIN9f8S9it7Tn9tFkGTOL6vB/LLJQsLkz92zvj+CLrKLPEKk
         +qyS18BUXEX747Ro2K52p4sLwNcF2TxoOcG/lrOQKyHiHmHxSdlEmzNImQaYH4vNjpIh
         fIOw==
X-Gm-Message-State: AOAM530wKSsCKrF6j2g77WRmNb+mOlW1vR/5mYAkLLmQ9pSqdHeak5ml
        +2VovoV1bbRbtGueylRZONo=
X-Google-Smtp-Source: ABdhPJysif/Ky7tpuXROZiKz/P5ym0EdTg1Za2e2Wf6HkPx9pKn+r8Ps+Xp3mRHNBNaDRuTiELXmFQ==
X-Received: by 2002:a2e:b5b3:: with SMTP id f19mr8198850ljn.305.1622916357316;
        Sat, 05 Jun 2021 11:05:57 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id e29sm922432lfb.258.2021.06.05.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 11:05:56 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:05:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] NTB: perf: Fix an error code in perf_setup_inbuf()
Message-ID: <20210605180554.ql4rhpukj57ujkxw@mobilestation>
References: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yang.

On Fri, Jun 04, 2021 at 06:20:50PM +0800, Yang Li wrote:
> When the function IS_ALIGNED() returns false, the value of ret is 0.
> So, we set ret to -ENOMEM to indicate this error.
> 
> Clean up smatch warning:
> drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error
> code 'ret'.

Great catch! Thanks for posing the fix. Indeed ret would zero in case of
unaligned buffer allocation. Though such situation is very improbable.
A tiny nitpick below.

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 89df135..c20b375 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -598,6 +598,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
>  		return -ENOMEM;
>  	}
>  	if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {

> +		ret = -ENOMEM;

I'd set -EINVAL here. In this case we do have enough memory, but the
base address is unaligned in a way the NTB hw requires. After fixing
that feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  		dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
>  		goto err_free_inbuf;
>  	}
> -- 
> 1.8.3.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1622802051-43464-1-git-send-email-yang.lee%40linux.alibaba.com.
