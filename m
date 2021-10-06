Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D04239D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhJFIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhJFIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:38:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB07EC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:36:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x7so6862158edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1tBZGy5fjJyJT/4JFxiN73sucm9vQCvvn6+DPKKJICA=;
        b=2CuFqvJr513dWu1skEcdBu0Nq4oS4MA2bRqLND1PG6Awe+zw7N+fuyUpXlk8wIP37w
         w9+mAAwFj8UiP2CHLps/tDB0WQes/G0Z4M1oS2eSpSP63ikcXMbUkXWLbMF3og4MhWch
         FPNpmUAZUlbcrW3BFJ51+Y9UO+lurBInwO5bxpxUaPLV3+8pIUMCTcwvHklHhuFQroYY
         JgzwPJIk6RuZasrp+RoGZRxNjYFoH+ECEn4sCtqmre4FELGgSHHod8otLwWnEK+VFgDj
         896sCkd52xRl9ZQuJye8gZeJGVag5iB5yiDtmFF1d1w9MN8QNhviZTXNDXirgXEwcNKw
         tSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tBZGy5fjJyJT/4JFxiN73sucm9vQCvvn6+DPKKJICA=;
        b=KHz5PyXDKctvKzsed5T6EjvBZ2lClCBJXUz/nNzr+A6ooKcrbfhhKB0w7ft9FEx/G6
         Hae7rhBfb6wFrQ7L35i6cYyYLdaxVncyJddLVK4zRb3uogayuIvEtoQnZVFepiTc4tTT
         w7vUqTa1igyEYnFEn4Qq0zctCHdNVe8Or08u74octd9tvFvuogaMniZABnWSfsWk/05J
         W9xqOYez1Kh0Xsrp1yqQL7wPP9mu+FZ3NYIWhBlF72jkIlWGIEC13JOqy4/Cpt7prfrG
         9S44JW4dyjJ7ZOSGsKz446Yzr0A8Jf0pjq/JMYys0MMG6DskhvmKxjBQVDaWpBsBnkgK
         6coA==
X-Gm-Message-State: AOAM532ZYngjfCiFaRe+nNh0hruUwUTPih68Ga6x/DPZrjNtgmyypHtG
        cwXW6rfLFpBbzyBerSi39tbNlg==
X-Google-Smtp-Source: ABdhPJwwn6FIVs2SyZPbbAfEcgEqJBvREAVmQV/FN+Zsg0aF/NHMIARtLR+lRfOmVjdC0nF8FdMSwg==
X-Received: by 2002:a17:906:1dc4:: with SMTP id v4mr30818651ejh.282.1633509384396;
        Wed, 06 Oct 2021 01:36:24 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:f7e3:cb47:8607:1e3? ([2a01:e0a:3cb:7bb0:f7e3:cb47:8607:1e3])
        by smtp.gmail.com with ESMTPSA id b13sm11604804ede.97.2021.10.06.01.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 01:36:23 -0700 (PDT)
Subject: Re: [PATCH v6 1/5] tee: add sec_world_id to struct tee_shm
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>, sughosh.ganu@linaro.org
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
 <20211006070902.2531311-2-jens.wiklander@linaro.org>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <2af3eda2-2ceb-4812-a813-ae3dff02cdac@forissier.org>
Date:   Wed, 6 Oct 2021 10:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006070902.2531311-2-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 9:08 AM, Jens Wiklander wrote:
> Adds sec_world_id to struct tee_shm which describes a shared memory
> object. sec_world_id can be used by a driver to store an id assigned by
> secure world.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  include/linux/tee_drv.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 3ebfea0781f1..a1f03461369b 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -197,7 +197,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>   * @num_pages:	number of locked pages
>   * @dmabuf:	dmabuf used to for exporting to user space
>   * @flags:	defined by TEE_SHM_* in tee_drv.h
> - * @id:		unique id of a shared memory object on this device
> + * @id:		unique id of a shared memory object on this device, shared
> + *		with user space
> + * @sec_world_id:
> + *		secure world assigned id of this shared memory object, not
> + *		used by all drivers
>   *
>   * This pool is only supposed to be accessed directly from the TEE
>   * subsystem and from drivers that implements their own shm pool manager.
> @@ -213,6 +217,7 @@ struct tee_shm {
>  	struct dma_buf *dmabuf;
>  	u32 flags;
>  	int id;
> +	u64 sec_world_id;

Wouldn't it make more sense to have this outside struct tee_shm in a
driver-specific struct? (which could always be obtained from a struct
tee_shm * using container_of() for example).

>  };
>  
>  /**
> 
