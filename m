Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41C93A77B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFOHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFOHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:12:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACDEC0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:10:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so1030122wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW960DyAkJbZgIulFh2SqKgZviNtgHFFzWUHYQAciss=;
        b=TvW1XGLl5bBBwb99rHkJePUTzdbV7rSN6B1VDY8W31TGCATQ9bjidrAgwKLLgINUpJ
         loo3c2/atVGTWFw8KUjTKnil0+62LwQOiRx6GX12Yoe6CAqxLoXUwrXpDJr3nZD+plII
         u7K5aZ/PQ40WDn/FfOp9vGBBK+ZuH9MKuYxRZ1xNucIjJ7Nmjw43CUUjOpDfDMTc12WI
         guwyZuKeVyMkjQkJ3Zhukwo9m7vrlX33KxpGaXfcO0OsxliXAgybh6SObPkqvMYpYe53
         JgNBEMhsvli7NMaP0biXVAW4sXELZJGPOPrEst/+b/M/mP4YI+0bMGKWzX1loxr4OcYK
         5n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW960DyAkJbZgIulFh2SqKgZviNtgHFFzWUHYQAciss=;
        b=DWrGB6wT1RISWuUDGN2E4XptqLUnWQ7gx6AVKy81JGMgLWH5J1CeeT72QjEGy1JsaG
         8txoBhwt0AgiS2gRNtag/Nnx7z0Zu6Xy4pdPHZ4/74tAL8XTFWy1goaZaZef76lHZqPR
         NnWh+veemdzwPGKy4oJCJ3cTn7czoND8MuRUHUyiflh9c4gUCi2bzPgV8Cti9xE7x7Si
         /4vET84vJopQeTaNMb4XwwcufPcMom7JeUfssjWBw8amUocPK0qC1NnPucBCOI7u8W0x
         /XtpTI6qwOQ9XWmtx/QbLqXb5i14zs337d9WASWeu0Qree2UDULwxCYr1vI7H3H1SrB2
         z6jw==
X-Gm-Message-State: AOAM531RJ05vODL12usHWyUUMxZ0vx7Z/sRTnnZudU9ay5ZOhVQcVwqQ
        iQ4ejTsdrOaIWD4RDzSc1Bq2XcFzoB/kuYJ5fdyavA==
X-Google-Smtp-Source: ABdhPJz5rVd5W8B/FQIKX6pBxgS6Znp7UnQMQ1wxjlQWONGkOGM546PORvSVmNM/dDoLfR/RfkdyuHbrNfd4+ZipfrM=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr3573406wml.30.1623741018772;
 Tue, 15 Jun 2021 00:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com> <20210614223317.999867-7-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-7-tyhicks@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 15 Jun 2021 09:10:08 +0200
Message-ID: <CAHUa44G+hxjckap1e1qZXTf6vQqQYNMw=ofzdFCP1OgCXQsF5Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] tee: Correct inappropriate usage of
 TEE_SHM_DMA_BUF flag
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:33 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> From: Sumit Garg <sumit.garg@linaro.org>
>
> Currently TEE_SHM_DMA_BUF flag has been inappropriately used to not
> register shared memory allocated for private usage by underlying TEE
> driver: OP-TEE in this case. So rather add a new flag as TEE_SHM_PRIV
> that can be utilized by underlying TEE drivers for private allocation
> and usage of shared memory.
>
> With this corrected, allow tee_shm_alloc_kernel_buf() to allocate a
> shared memory region without the backing of dma-buf.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/call.c     | 2 +-
>  drivers/tee/optee/core.c     | 3 ++-
>  drivers/tee/optee/rpc.c      | 5 +++--
>  drivers/tee/optee/shm_pool.c | 8 ++++++--
>  drivers/tee/tee_shm.c        | 4 ++--
>  include/linux/tee_drv.h      | 1 +
>  6 files changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
