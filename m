Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F73E2169
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 04:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbhHFCPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 22:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbhHFCPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 22:15:44 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE640C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 19:15:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x12so4102870qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 19:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Imy8OreXrectZDHPA2KWQvvopUzEYXdivHeaJKFxqpw=;
        b=TLEmeQiCIiGQ7wCbsNTZiXznL/Qe/SmmLjIDwfE2OPFDAAKJwKwem0xLhdEvI9eF9w
         ePFC/vJhM5qtwNECXdguUzpTSPuSWPMFrCcWsHM9oCVOkFBkU1XH062mljS2Vyj5Qmi6
         bnlu2+N0SnFi/fT2DucYSaElfxZ48+hnX7LNXzaLjfGQF/IVMlsHwZ2xC3NSzJE+38Bn
         yFfV7Qxr2/zwb458JkK55uWrSpT74x3horLalFZjRBgOAY/2EL11JQwwussgS9NE8Fm+
         FIQCtq2kllD2uPMENaCN1FaSHxQ23eYCzrD9TbBHPmqyEt1/Hrrhdk8HYjB2tb8kaEjH
         rQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Imy8OreXrectZDHPA2KWQvvopUzEYXdivHeaJKFxqpw=;
        b=H8w0GeYOiCz5DOcpTMQu4SJcH+UWSTh61VT0Fun6ReqXvHzimKxhRfads7qh4+CDE2
         HX7U9GeSNaW0ocP3DA46T17JFLEabtZMis7Z5c11I36M8oTHUvYZ7gAjrquDh1p4aD93
         n47jvTEPnjAjgNq/EVkWbLkL3uIFClFTUl1+rkr8kgtkWO3HOnWn/OJf/ISWnELlMwr9
         /1h8RPfBl0yz51tzh7nCGjMqg17fk2PoYBmPcLTRJzc0poIYO6+m+aU7l4pyBf9GWz7O
         XVqFNsSunwtq3EtGNw/G6A9E/kJSq6ZZhzGWa/ZEGYjYR3y7NDxKyn2XpOWPEgrqcIVA
         ISKg==
X-Gm-Message-State: AOAM533Xpe+877JMQGKrzc/gjbrV7oBuc8GqHP+USBR+rUZ+xJfxpoRX
        bm3x5YY3WpwAYbbpuhH8jvw9Yfor9uInkQgGor0=
X-Google-Smtp-Source: ABdhPJyDRTi8g/fjdPgi4sNbcwYcP9GyrixgU9oT7EXZ1xkE/iW+FGwuFXyoA9KhnMVPnLoJppLN/hrWhtZhcygElwU=
X-Received: by 2002:a0c:e84e:: with SMTP id l14mr8797811qvo.38.1628216128097;
 Thu, 05 Aug 2021 19:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628094600.git.robin.murphy@arm.com> <5cc86b540faeb0367df9bd6901a15974f0e31c52.1628094601.git.robin.murphy@arm.com>
In-Reply-To: <5cc86b540faeb0367df9bd6901a15974f0e31c52.1628094601.git.robin.murphy@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 6 Aug 2021 10:15:16 +0800
Message-ID: <CABOV4+VPX-RK-mz-GDZLD_qNDxmBSc3hQGLkvj4NKP6sGOLSxQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/25] iommu/sprd: Drop IOVA cookie management
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com, Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 1:18 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> The core code bakes its own cookies now.
>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thank you for the patch!

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

>
> ---
>
> v3: Also remove unneeded include
> ---
>  drivers/iommu/sprd-iommu.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 73dfd9946312..27ac818b0354 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -8,7 +8,6 @@
>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> -#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/errno.h>
>  #include <linux/iommu.h>
> @@ -144,11 +143,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
>         if (!dom)
>                 return NULL;
>
> -       if (iommu_get_dma_cookie(&dom->domain)) {
> -               kfree(dom);
> -               return NULL;
> -       }
> -
>         spin_lock_init(&dom->pgtlock);
>
>         dom->domain.geometry.aperture_start = 0;
> @@ -161,7 +155,6 @@ static void sprd_iommu_domain_free(struct iommu_domain *domain)
>  {
>         struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>
> -       iommu_put_dma_cookie(domain);
>         kfree(dom);
>  }
>
> --
> 2.25.1
>
