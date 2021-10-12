Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC3429C00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJLDiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJLDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:38:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D739C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:36:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id v10so3257431qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuQBYQiE0//qwdR0lx7ufC/zx2o6SBXy6e/jdiWZvrU=;
        b=os/NuwEqCmcu0BrOeQfB4+n7QKmw1s47pBPDW8YOBVogWBAmvvbRsvbsJA46s5un4n
         eIzjs6xSLG8TCx9TycSaw6F9URHG/10SY7z/h9OBcxjvvNVWs0F15ZI/fMSyHTaGiGY/
         gjLYecaGaHCYDEEtMUERWa8As1PEiyzLLFvGQWUqhPHcMJ4RlG1LXh1MpyV7a8nJ/ubX
         6rVk6jca+FTiUatOC3sYtLC3jRs4hxLAIT2mkIWF4khFzpcSUdeY1xsGIxbnPai9Ckwd
         03jBu5odwiHeSOV9gnYJJTuDUSG6gnsbQVRAYkV3ADgfGRa0UaoyWB5ysNN0imlQWFsq
         ipvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuQBYQiE0//qwdR0lx7ufC/zx2o6SBXy6e/jdiWZvrU=;
        b=mRw/YG+12DHjKV2DN5hcklEcswoPjSN4DtFv4BKeZWEdbHSRhKdvvfr3WKT8rVMPqP
         oEkQmm2+xuoW9qGsPM014pLZdZdQMOYhEil57si//dhkv7dgK/z73h1eHXvqGRohGW5B
         eZ6doDi49kz78I2aKLX4oDdtqO5ZRESrfdJP9a61XKMuBR1wDiPolZrH26bZNQwbZlDy
         50Yy2If80qoM1ugW1YLO6nFigpQcaj+mHGr1HjJkAr9z/v6Br7vP4ngP5YADs6PSuNkR
         zaY1K2/lSWlyvKSfpyNkJnZrEAhLRDzptKuLByJwik4hDJSoXpOMLpeZDq4j4SCue5Nh
         W3ow==
X-Gm-Message-State: AOAM5318rMz3W2/0WdpVHVBp8oClN//vY54TDlFP0WTDeaPWB9p1cdG3
        tRR4VB7Yik65L3u7x3AC6j4Fl7GX5mCzlik1yc9s5A==
X-Google-Smtp-Source: ABdhPJxlbpmzun2i5ifUkeHpsWQA8qd+5ZG5Cd31eOgNJQa6VTEb8HUSywYsLuVpWrVbDUjc6Uz4EsHBYXxFEF/i6bg=
X-Received: by 2002:a0c:fad0:: with SMTP id p16mr255245qvo.3.1634009763022;
 Mon, 11 Oct 2021 20:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga> <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
In-Reply-To: <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Oct 2021 06:35:51 +0300
Message-ID: <CAA8EJpo7kg2h3dJEW+ZCrRhqZ4rvNrs_7WRiX+-adGXXAtu=BA@mail.gmail.com>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Thierry Reding <treding@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Oct 10, 2021 at 6:17 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 09 Oct 21:33 CDT 2021, Dmitry Baryshkov wrote:
> >
> > > After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
> > > qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
> > > However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
> > > qcom_smmu_impl_init() is never called.
> > >
> > > So, let's fix this by always calling qcom_smmu_impl_init(). It does not
> > > touch the smmu passed unless the device is a non-Qualcomm one. Make
> > > ARM_SMMU select QCOM_SCM for ARCH_QCOM.
>
> Sorry about this bug. I was sure I had it working, but I lost part of the commit
> during a rebase, and my randconfig builds still succeeded without it, so I
> sent a wrong version.
>
> > Arnd's intention was to not force QCOM_SCM to be built on non-Qualcomm
> > devices. But as Daniel experienced, attempting to boot most Qualcomm
> > boards without this results in a instant reboot.
> >
> > I think it's okay if we tinker with CONFIG_ARM_SMMU_QCOM for v5.16, but
> > we're getting late in v5.15 so I would prefer if we make sure this works
> > out of the box.
>
> Yes, makes sense. For reference, see below for how I would fix this properly,
> this is what I had intended to have in the patch. Feel free to pick
> either version
> as the immediate bugfix. I'll give the below a little more randconfig testing
> overnight though. The pasted version of the patch is probably
> whitespace-damaged,
> let me know if you would like me to send it as a proper patch.
>
>        Arnd
>
> 8<-----
> Subject: iommu: fix ARM_SMMU_QCOM compilation
>
> My previous bugfix ended up making things worse for the QCOM IOMMU
> driver when it forgot to add the Kconfig symbol that is getting used to
> control the compilation of the SMMU implementation specific code
> for Qualcomm.
>
> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Let's get either of them in.

> ----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..2dfe744ddd97 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -311,6 +311,7 @@ config ARM_SMMU
>         select IOMMU_API
>         select IOMMU_IO_PGTABLE_LPAE
>         select ARM_DMA_USE_IOMMU if ARM
> +       select QCOM_SCM if ARM_SMMU_QCOM
>         help
>           Support for implementations of the ARM System MMU architecture
>           versions 1 and 2.
> @@ -355,6 +356,13 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>           'arm-smmu.disable_bypass' will continue to override this
>           config.
>
> +config ARM_SMMU_QCOM
> +       def_bool y
> +       depends on ARM_SMMU && ARCH_QCOM
> +       help
> +         When running on a Qualcomm platform that has the custom variant
> +         of the ARM SMMU, this needs to be built into the SMMU driver.
> +
>  config ARM_SMMU_V3
>         tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>         depends on ARM64



-- 
With best wishes
Dmitry
