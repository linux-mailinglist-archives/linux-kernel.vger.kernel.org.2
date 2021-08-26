Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075413F8B53
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbhHZPt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhHZPtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:49:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:49:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n27so5554136oij.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qa0fqLYy9vP/cy82c+R1T/pMSHWa/WdHi0MVUVDi4jA=;
        b=M7jfr02E5dD4+M0dAvgKeiThaQE1g3FeQz8OCuEraAfu/zDSXYCOfXe7B6wVke9GyG
         euM0Fc33dJym41pHswF0XjIZdfjGn6Zyw9I/ILJMjVuIm1jl1bhFwRamchltkT/AF39f
         hN7gP0W3sRMTVDGjG7uRpvT23BayKZDDGiKSZPPIShoUyxvB31OWweaAcr5El9bftkaa
         TT23e3EV0sOp8XHIe1zvge79EyGd6IS1KWykrDMI6p96GvPOTEkpy05zXUWIfeNOHTw6
         48yrknZHPclaUeONFgJwPKmlJGZ1W+qQSZerQZUGSs2h6GQBgGrOUZTqyToemvU/klbv
         3NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Qa0fqLYy9vP/cy82c+R1T/pMSHWa/WdHi0MVUVDi4jA=;
        b=G7DOxYwAAcPOaMW48vPeDbaHGRe/mqWDSwGh4TudKpxZ39UHhHwodC1JZ/pikH8Arp
         GUFNTYxWo94iC1Ch5EdcXAu2d2mFKeWTvFpgdvtAiIVnaqPDw3BnNgLXmYmFgO/tyf50
         SM6Tn1048D12HUbNWtsjZMslnce0th82qjH5ScUApOxUDN4m9YJ89e9aKofGCzMnLvY+
         XQt7hIgLY4ueOmLc6PWdQI7vRJk0UO8Mt5H8qhBkPdIBxaO4Pc57vlNxlpRISJ4dErRH
         c5m2K6KRrQVeYRNUU6x7/fOTKWZdlpjtzugH1ZzcyKiwM9mTwxDxCQxpc4FJ9RIyic7/
         OrIg==
X-Gm-Message-State: AOAM530xTY0ksVQqp7IRzhUwpcoHBN33hNl8WkKkpEOSqtY+gRi+H57U
        MnfNBalQisn0TJNW6Fqn7oA=
X-Google-Smtp-Source: ABdhPJwfJGNXEni2uL0E8ntXubdpiGnZunFbZdheFu0qO7DzDWdsh4gutdUf2RiFj4AHEWpPpXt7qg==
X-Received: by 2002:a54:488c:: with SMTP id r12mr11714638oic.115.1629992945362;
        Thu, 26 Aug 2021 08:49:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4sm651325ooa.35.2021.08.26.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 08:49:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 26 Aug 2021 08:49:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jian Cai <jiancai@google.com>
Cc:     mike.leach@linaro.org, dianders@chromium.org, mka@chromium.org,
        manojgupta@google.com, llozano@google.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: syscfg: fix compiler warnings
Message-ID: <20210826154903.GA4082743@roeck-us.net>
References: <20210825222514.2107728-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825222514.2107728-1-jiancai@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 03:25:14PM -0700, Jian Cai wrote:
> This fixes warnings with -Wimplicit-function-declaration, e.g.
> 
> ^[[1m/mnt/host/source/src/third_party/kernel/v5.4/drivers/hwtracing/coresight/coresight-syscfg.c:455:15: ^[[0m^[[0;1;31merror: ^[[0m^[[1mimplicit declaration of function 'kzalloc' [-Werror,-Wimplicit-function-declaration]^[[0m
>         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
> ^[[0;1;32m                     ^

You might want to split this into multiple lines and remove the ANSI
escape codes. Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> 
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
>  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
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
