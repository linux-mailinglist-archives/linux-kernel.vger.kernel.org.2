Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84583D89EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhG1Ilv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhG1Ilu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:41:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D75C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:41:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso1294923otb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCGN/WeXxsssAPjPbi75fC+4aFNT1qOx2HsJIWcUzsI=;
        b=z35rX2Xn3bqzz0BumMXI11i9SJjhv8GyRuMv6c/sAlHul+wxZNquvpAoU1QA8oKpRa
         4oBpJW0lJvr1oEaDj31IIO/jf/LhcVzrzmufPFLVce0SGUMLYF+d/AuiI9NQvN+UDJxM
         04L0Q2vJBZcyD1aoQbtK6cW6gQLJF7KX86U1d5gAIFxJs43rykM9LM4roqusBHSXSx8s
         dTnMV9bD1BqqNrL7HsNK1amUwBrJVkXXqHhqDfrq3zS2rvRKSaqSMWzX+Ha8CvSZTJR/
         bOzNQ4AoXH3mcCdaZG+QFLLghJs0mt7xw+XyB16WQNnTl66ELwuP9YV0AYEcDGUTjiA3
         L1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCGN/WeXxsssAPjPbi75fC+4aFNT1qOx2HsJIWcUzsI=;
        b=DBnU/uU4pJ8McC+SjwhSMsjz3MP1jYZO7Tw/FtT0rtWRg7+7mTZE1jVgk+q97H8YLv
         fBwGrMOlASw4jjzRcCum1UMqeJsWXhhNGXGDtzq/d2UaYmVIpyhm8Ck3/rz1s2hJY6fo
         Vy/JGEzk98H1P+utuzMzorNVJSWj8rLLzk8cNy24jM2hi01XL8XCO5P7t+sy5Y9Y6VbK
         rBcCTLf9MxZ5quVGAWbykw3lWNC5b4rrMyLgbbLjXjI8jBginCeUFa34P7aJ/+8iCB8S
         us+86Me2M5JJwBmhFJwXjFXCfv67P3gkv5H/tl1h47F/MW62ny5YiBBBzObCrgSd599O
         TShQ==
X-Gm-Message-State: AOAM533+MY+2YhZRHll980hp71a1uNsaC6zSrvzsH40qQ6c5KiWn2y01
        zltTra/gmZM46tKtp6MvToUkMynyDPJzPwUa0KziiQ==
X-Google-Smtp-Source: ABdhPJxgMnrYpJnUb5T2xgkCoMmGLeyrF9R9dVxjGkZj0sgJQVoGHIBI9IASBT8ZlfLvsJv75ei/0ObmveIoHUsaNp0=
X-Received: by 2002:a05:6830:242f:: with SMTP id k15mr18879422ots.72.1627461708597;
 Wed, 28 Jul 2021 01:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org> <20210722121757.1944658-2-jens.wiklander@linaro.org>
In-Reply-To: <20210722121757.1944658-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 28 Jul 2021 14:11:37 +0530
Message-ID: <CAFA6WYPW3XQiXJSxsj_HDXZ_JPEx58hOZiZ1Yctn-r7FG6hUpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tee: add sec_world_id to struct tee_shm
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds sec_world_id to struct tee_shm which describes a shared memory
> object. sec_world_id can be used by a driver to store an id assigned by
> secure world.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  include/linux/tee_drv.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 54269e47ac9a..1a29f0e66e13 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -196,7 +196,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>   * @num_pages: number of locked pages
>   * @dmabuf:    dmabuf used to for exporting to user space
>   * @flags:     defined by TEE_SHM_* in tee_drv.h
> - * @id:                unique id of a shared memory object on this device
> + * @id:                unique id of a shared memory object on this device, shared
> + *             with user space
> + * @sec_world_id:
> + *             secure world assigned id of this shared memory object, not
> + *             used by all drivers
>   *
>   * This pool is only supposed to be accessed directly from the TEE
>   * subsystem and from drivers that implements their own shm pool manager.
> @@ -212,6 +216,7 @@ struct tee_shm {
>         struct dma_buf *dmabuf;
>         u32 flags;
>         int id;
> +       u64 sec_world_id;
>  };
>
>  /**
> --
> 2.31.1
>
