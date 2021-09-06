Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0174401D65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbhIFPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhIFPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:07:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E5DC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 08:06:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so4478775pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7bRVRr2cmpld6cVkhHmLiLm6xvgtUebQbicDG7ir3G0=;
        b=m3nCH0H6dheq/9gTKSlhvraisRdbU5lL2ciDS36vzIDNR1/GfkpADfpz+Lr8Zi9McP
         X54Xa3Xa+ngumTj/Kc19bIeGcTGHUbmVht9CjCjbeG4HmBSFRCTZbk1bbg1NYA5iLYlJ
         V+w6SYY5dzVgMDGqFxYfcXSkMUgtWk7XVfhRQfZVOmUYDYliDBdX2FLGOF1mfAC1fiul
         Y/P7hl0GWXTT04cGhvFT5k3hXHEc2B1jm1Ntt2Ibgq1poHOSYFrZehamga0XLgshVSsw
         tcm+Di7AMp44hpK6vNUklq8WVLIsdKydM/3QPz2d3MRdpBmEQSGHN/vibbH9o/P6MJ7Z
         sCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7bRVRr2cmpld6cVkhHmLiLm6xvgtUebQbicDG7ir3G0=;
        b=XAx99DwTnePG9bK3rOOBMAfA7w05jrUaN2fIVt6B01F/JcK98tzQcW4hkhYZaxMQEv
         OOq+xdipO/w6pl2ag8JJMt3f5Xgej2jhGJasMbBeB2sapEJrESxWaX31CufgC+sM2EEO
         Q62sIkFuLKnyoaE8/Hu3/U5sz+noJuVFh842YOj90jVHkrkcdFFLb1Cv0PnZg+qnhMvZ
         VzOeFUm4RM7OuGXIXboLDzm6sihGmrYJixtek+O/FMFtC8oaE4PhV5RAhf0UQ28rf5ye
         AzGNUyI5zhCQR7kJHkQF9v3FwAIKAz+uHA9BUqpYQlTzMnQaaOlH2ypR4K0Z394Hu2/A
         7W9g==
X-Gm-Message-State: AOAM531ocHjr5DX53I3JO1RJV5fvxrh44a2PXO7OhOlfwV3mZScJ2g4q
        qYLNpblO7Qp78NfdT8L2e16Wsw==
X-Google-Smtp-Source: ABdhPJz7QhFvvQoZNbJT/uu0Intg4qqFBqp1QJOwcr6xXyv7hMGFbr/9aIkaYAr/nvmPmo2gRdieZw==
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr14275270pjb.97.1630940789541;
        Mon, 06 Sep 2021 08:06:29 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y126sm5275753pfy.88.2021.09.06.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 08:06:28 -0700 (PDT)
Date:   Mon, 6 Sep 2021 09:06:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jian Cai <jiancai@google.com>
Cc:     mike.leach@linaro.org, linux@roeck-us.net, dianders@chromium.org,
        mka@chromium.org, manojgupta@google.com, llozano@google.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: syscfg: fix compiler warnings
Message-ID: <20210906150625.GA1228692@p14s>
References: <20210830172820.2840433-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830172820.2840433-1-jiancai@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:28:19AM -0700, Jian Cai wrote:
> This fixes warnings with -Wimplicit-function-declaration, e.g.
> 
> drivers/hwtracing/coresight/coresight-syscfg.c:455:15: error:
> implicit declaration of function 'kzalloc' [-Werror,
> -Wimplicit-function-declaration]
>         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev),
>                              GFP_KERNEL);
> 
> Fixes: 85e2414c518a ("coresight: syscfg: Initial coresight system configuration")
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
> 
> Changes v1 -> v2:
>   Format the commit message and add Fixes and Reviewed-by tag.
> 
>  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
>  1 file changed, 1 insertion(+)
>

I have applied this patch to my local tree.  I will push it to the coresight-next
branch when 5.15-rc1 is published next week.

Thanks,
Mathieu

> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index fc0760f55c53..43054568430f 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  #include "coresight-config.h"
>  #include "coresight-etm-perf.h"
> -- 
> 2.33.0.259.gc128427fd7-goog
> 
