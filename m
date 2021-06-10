Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFD3A3706
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFJW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:27:27 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:37515 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFJW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:27:25 -0400
Received: by mail-io1-f51.google.com with SMTP id q7so28829890iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7TVjLZ+YHlKeGJ8qAU9Un06YFm9yXurMjRE2VQEqoY=;
        b=lcnU0h1GZrdQJLHy8y+QLyi53BxH+7M3T72jS6rR9R+chmR1B7uM/QQBUr0wb9Na5Y
         ztJ6PqO0L1apCQeAEkrh7TvbJK5Uw0hLjM37NV2AFe/Kgnno9gNP2tycgvMLwh4zbi58
         Q26dJPAFABhMVEZeABUu2C+MTVBBYla4XZvvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7TVjLZ+YHlKeGJ8qAU9Un06YFm9yXurMjRE2VQEqoY=;
        b=VFqctm/KJkBHchXK6ctpIcK7bNsCseL5PE7wTtICiGQVGrJ+UCKrIKYCjjRpmWra6i
         7N/Oe3yO/siwGof8Hx2zl83LXJJBgfDpaX6+u54pWZOJ98xH+HMzOdjEEN54AkhRrfVv
         rEyi+WUHgtZAizFzoWNOAk8AoqY3D6hftZiIcSRGuI8WVF6bIxw3yxLzf+CwunYxfoOo
         /N9CjzD32ByAegk8PGN6XUsU5z9iKLJXl6gaPetLO8FFK4GXzmeRA+VqTFjg/K3ZDtq1
         4JWjT7lnNuZ5VOQRQmteV6SlFs+Z5vsknPc76EWnvgcQay5aR6U1ulB42WlK12f4FIdY
         QfNQ==
X-Gm-Message-State: AOAM530H5moJq+OINtpn2KSk0nUgDYts42m9hm1wYWcfX4+gE0VtCEmU
        aUVJEsgjrbxnkyNESi941P7bKTZp2Q+rjg+cdvDZag==
X-Google-Smtp-Source: ABdhPJxXRsWHoRSS+DqKbfDPMQ4aRNvfX6WB5CCyhEHmFMsKbxf9xeh5w6evmQo2ATTX7WJCxTs0JimQzDD9PcEr90Q=
X-Received: by 2002:a6b:cf13:: with SMTP id o19mr599046ioa.206.1623363860099;
 Thu, 10 Jun 2021 15:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <1623293391-17261-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1623293391-17261-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 10 Jun 2021 15:28:15 -0700
Message-ID: <CAJs_Fx6qgQFOp16SLQfz-Aaj4mqTo+vCvfpQr_E3UapVTrsu6Q@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Fix arm_smmu_device refcount leak in
 address translation
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 7:50 PM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>
> The reference counting issue happens in several exception handling paths
> of arm_smmu_iova_to_phys_hard(). When those error scenarios occur, the
> function forgets to decrease the refcount of "smmu" increased by
> arm_smmu_rpm_get(), causing a refcount leak.
>
> Fix this issue by jumping to "out" label when those error scenarios
> occur.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6f72c4d208ca..3a3847277320 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1271,6 +1271,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>         u64 phys;
>         unsigned long va, flags;
>         int ret, idx = cfg->cbndx;
> +       phys_addr_t addr = 0;
>
>         ret = arm_smmu_rpm_get(smmu);
>         if (ret < 0)
> @@ -1290,6 +1291,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>                 dev_err(dev,
>                         "iova to phys timed out on %pad. Falling back to software table walk.\n",
>                         &iova);
> +               arm_smmu_rpm_put(smmu);
>                 return ops->iova_to_phys(ops, iova);

I suppose you could also:

   addr = ops->iov_to_phys(...);
   goto out;

but either way,

Reviewed-by: Rob Clark <robdclark@chromium.org>

>         }
>
> @@ -1298,12 +1300,14 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>         if (phys & ARM_SMMU_CB_PAR_F) {
>                 dev_err(dev, "translation fault!\n");
>                 dev_err(dev, "PAR = 0x%llx\n", phys);
> -               return 0;
> +               goto out;
>         }
>
> +       addr = (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
> +out:
>         arm_smmu_rpm_put(smmu);
>
> -       return (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
> +       return addr;
>  }
>
>  static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> --
> 2.7.4
>
