Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3826A3A3E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhFKJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhFKJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:07:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61CC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:05:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso8196768wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ry2suuzXUcu07KBYOEsb0YWMddgl4sZoFMfa7hKOgms=;
        b=zP33EHoQsf7qLPQMdpBdFo7t8iJNFw2h3mCHTGhZs6q/PNkWYYg6Lj7b/4oKCHxfnc
         PgeM5chi+Q2hdpb0PWjfcfrWfXduRDbn6SHDbUR5I5kDp5EZpJx5mC58hsnSEYi307LR
         RCj3W0r3b6rJDe6LZH0lOoufyqEM+UKiPVAEmHiBY1lHpwqRGcdrPktVAI+y8ZvDMQ+2
         JQLootHAB320n0+/e0lXFYpv+2wOJWGGG6pbel+FSRTZSG9Cwuh2998/wEA1CPCO1PP7
         nZrN/tES0u0uBGJ2bYXyhm4Rh1DSYTXg4imyqZcDbZ50jciSX6AK+TJoeffZbadQZpA7
         q1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ry2suuzXUcu07KBYOEsb0YWMddgl4sZoFMfa7hKOgms=;
        b=m92A5VGWXOUShrfxvFKz3ztt9ixGSj62z7CAAWphIRXYjrezVsskvhR1CDMwx8ndoe
         KpfyNQfQtrka5LD3VG3NkPIYFUfpf2S7gPvsKk8lCI3Eyk9XJCZ0SMfgtwSqMw6HPyAP
         nlPbhkrdukCs32bxx0wkw323vGDezQuDh5gBIgNi2qRypt8525fuecgaJkXqAaTDp3L5
         sF01h6Fw9LAb2HxvDQoQTzT5TavYpNlqlVzrNI9huDMKLH1mPHgnK/WFslERLhwJdf7o
         jPfmwuWFVcrfB2qMgPSAr2kqF8n9dyGHYhLyMG/0ch0ClPHvDDEvNN88aPL60jvHDoDR
         KTJQ==
X-Gm-Message-State: AOAM532mCp7bk8kbFuA5GfKGdY/t9hAFtBkeGlZRv/QqZkIjljaTQHaA
        mB11MKgs2TJeIv5WMg4PXKM+s1TygYM6QgJHgbPutw==
X-Google-Smtp-Source: ABdhPJyMlGh/XMRZoKA9ZoOaNrMuesnznrGSeVm7Eiib/+SYCe73p200udVyt5+QPKdB81ZQgtzC6XY+WhMXpi1YZsM=
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr19048807wma.60.1623402329133;
 Fri, 11 Jun 2021 02:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com> <20210610210913.536081-2-tyhicks@linux.microsoft.com>
In-Reply-To: <20210610210913.536081-2-tyhicks@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 11 Jun 2021 11:05:18 +0200
Message-ID: <CAHUa44HU+KnqRKnvhK=Xm3WJeYN5HPJ83e0=v+CZ0hztBWh6Fw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] optee: Fix memory leak when failing to register
 shm pages
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

On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> Free the previously allocated pages when we encounter an error condition
> while attempting to register the pages with the secure world.
>
> Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
> Fixes: 5a769f6ff439 ("optee: Fix multi page dynamic shm pool alloc")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Looks good.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
