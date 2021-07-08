Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0D3C14BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhGHN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:59:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41244 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhGHN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:59:54 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1m1UWd-0005KW-O9
        for linux-kernel@vger.kernel.org; Thu, 08 Jul 2021 13:57:11 +0000
Received: by mail-ed1-f70.google.com with SMTP id w15-20020a05640234cfb02903951279f8f3so3335495edc.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtIU2Y6iPu0EP7ecFsyW91ksyJ0R/0bAhIVleyNgs7A=;
        b=NLVDkzc8eXVofbHS1IlBbFcfixzD3gpmU+NxDhnA4MMAWFdJEI+NVS7U/C0wVLPgDD
         Lij4+uvLkxjlgl1jYUOEOVwPiH4+CHoBprtt2UcresjBDA8+UGkR9VhnQ0vRVH2mlE+a
         hLJPVHjiLh7fJWz/6LPzLFkasYNu7j6gLbOwLU24O1wWpnlIXdZeJnd0LBBv3mddjCVg
         nbWt/f1YO0OXNY+0IDA++OWTjQRHQ0iiKvaeP5KdAcvR2Vd/F7ZJgmiwloxQMphQkv88
         dtpcSP652B+VzuFf8PS9B9cxlysTgzaa60UTsyk/XNJUt3OENV+k3J9f8fqS4twUTg1O
         IN8g==
X-Gm-Message-State: AOAM530ygZWDJ5u71ExThjtP9yIeDm0R3Fyo9uCFg9wRvxhe6XoYJ/BG
        0tBUiXuhmLCET+f3fR/4i54pql3IG9wo+OpRxZowJzlALgBAL9k6Whhc1JQuUlMuck8lZPvYjyH
        FBS2fiSBJBquOmow6XWDPDf+Dvhj711NkqUWPUaVjZGoG/GKYYAGK9ysNQA==
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr38792927edt.79.1625752631448;
        Thu, 08 Jul 2021 06:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbEeaHzN2wQKJ0MMMpDpph/5LvO8vkiIk5tQ+ewCrGeoVn6/+g1A8arKaePkuWRXHnP0W7jZzWZnxOGx/aRCE=
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr38792888edt.79.1625752631156;
 Thu, 08 Jul 2021 06:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
In-Reply-To: <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 8 Jul 2021 21:57:00 +0800
Message-ID: <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, will@kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-08 10:28, Joerg Roedel wrote:
> > On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> >> @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
> >>
> >>              iommu = amd_iommu_rlookup_table[dev_data->devid];
> >>              dev_data->iommu_v2 = iommu->is_iommu_v2;
> >> +
> >> +            if (dev_data->iommu_v2)
> >> +                    swiotlb = 1;
> >
> > This looks like the big hammer, as it will affect all other systems
> > where the AMD GPUs are in their own group.
> >
> > What is needed here is an explicit check whether a non-iommu-v2 device
> > is direct-mapped because it shares a group with the GPU, and only enable
> > swiotlb in this case.
>
> Right, it's basically about whether any DMA-limited device might at any
> time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
> possibility of device hotplug and the user being silly with the sysfs
> interface, I don't think we can categorically determine that at boot time.
>
> Also note that Intel systems are likely to be similarly affected (in
> fact intel-iommu doesn't even have the iommu_default_passthough() check
> so it's probably even easier to blow up).

swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
disable it.

I wonder if we can take the same approach in amd-iommu?

Kai-Heng

>
> Robin.
