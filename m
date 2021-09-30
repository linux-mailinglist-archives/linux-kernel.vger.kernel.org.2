Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC61041E066
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352915AbhI3R7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352882AbhI3R7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:59:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123ABC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:57:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k24so7057577pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g6bz22D6xwh6dY6ebf3YVMVwbapBNBp7nh6i3iRX4rg=;
        b=dOKiID32WTuG8C1FY2tDSCXxPTOcTSojqkYxtMXC81eBn/3A6Aez9SSrNtOe43/vqZ
         r14bP3+HhfILcH+mSy8qbeihv9hjIQXbOsvQAQoJGyCKi69gMmOvcfw3hK26OXgksxet
         6+FGEby1cJgq/DR2sx0qdTMffsxJehFBI0/Jf/sVsQgmrcbIcBz6EdQNrgyPsTt1ZPgS
         ZCrOOjiBSKNIPp+/HCaTNKw6aPf7kK6fUNTW2E3WZsyf88X/+1OL9qKMSq5fRaxxt2F7
         DIRuiz0ePqm6/qsgCz/Hfrbu/DHfLIfGouCHbrROrDb5RKPxOQPBaXqRmADH9pI1E8cY
         amAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6bz22D6xwh6dY6ebf3YVMVwbapBNBp7nh6i3iRX4rg=;
        b=x4UlrPbKqL1GtFcN2d2gKA8cIOOUythbmOU+/txTOOcjbbgE/sqJfsgIU12450tvJc
         Dt78uECTiWLlZJx0XGC+1CilO4zFR/tmIIeMvBgK2c4OdUU/wYHsO3tSnY2uzJkaoWJI
         +12i6C1WQ9h2mSbF2SBptJWQNtfyhG3cKO/m1XT8g3I3/IUhZItTU+QiyqZPbgakEp3A
         csfB2S+ziiA0SIF+Kma9CKhqi+YWW4why4oJCOhVDWL7+Lr7JhYr+pCSY0+EwDTD7qZq
         la40plvWfaRSmrBmVF3okWht4p5hTCL2atfByGPTTtDqGDnqGkW53ND5l87P05pHGDqZ
         lGLw==
X-Gm-Message-State: AOAM530f8OAfyjpb8s7jEEC5VsEby4qQS49huIFxAwcFvbjpgqwozmQ+
        4bdifqCKo02/1fZt9douA+5LQg==
X-Google-Smtp-Source: ABdhPJxFoKp6KZ5DBAWAIpSMmQfLSbSbpU7b0scWhFG5joQHGKa00Znngko+61mQV7anI0cielGpPw==
X-Received: by 2002:aa7:8887:0:b0:43c:83fe:2c56 with SMTP id z7-20020aa78887000000b0043c83fe2c56mr5591779pfe.82.1633024674520;
        Thu, 30 Sep 2021 10:57:54 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s188sm3436085pfb.44.2021.09.30.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:57:53 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:57:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 01/17] coresight: trbe: Fix incorrect access of the
 sink specific data
Message-ID: <20210930175751.GC3047827@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-2-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-2-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:05PM +0100, Suzuki K Poulose wrote:
> The TRBE driver wrongly treats the aux private data as the TRBE driver
> specific buffer for a given perf handle, while it is the ETM PMU's
> event specific data. Fix this by correcting the instance to use
> appropriate helper.
> 
> Fixes: 3fbf7f011f242 ("coresight: sink: Add TRBE driver")
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index d4c57aed05e5..e3d73751d568 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -363,7 +363,7 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>  
>  static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>  {
> -	struct trbe_buf *buf = perf_get_aux(handle);
> +	struct trbe_buf *buf = etm_perf_sink_config(handle);

I really wonder how things got to work before...

I have fixed the 13-character SHA in the "Fixes" tag and added this patch to my
local tree.  More comments tomorrow.

Thanks,
Mathieu

>  	u64 limit = __trbe_normal_offset(handle);
>  	u64 head = PERF_IDX2OFF(handle->head, buf);
>  
> -- 
> 2.24.1
> 
