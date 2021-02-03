Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5530D0FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhBCBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhBCBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:46:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FFC061573;
        Tue,  2 Feb 2021 17:46:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m2so4094157wmm.1;
        Tue, 02 Feb 2021 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NA+Vp6FOxTsN0rhRmqWACq/BX4WRBLfi30qX+qsu3WA=;
        b=pAFQ38fj4r/BasPAvMLNQe+108j256tvT/jZiRNbzIYyZeKz4jQqRAc7n0CgGe+FbT
         /sKq4I/sjRMZLhUtLKwxAiKHU0Gg9aBU4Zo4EN+3qShSaTNVWiwk7Vib8u4QSvcbBZHe
         rahywyW8WRbvWpRPrutG/9MVWGQg6maeku9tHP20/RfbWWknqnKUeVadlDQyUSKk64oP
         xgvUtuP8f3UZGjFHsYViHRsKsQd/V/bi4fezrs6Dmu2wTzdit6JXDFvlLNBqBWJC2Iy4
         BGAiXzg0nlYAEITmGVPHc38u70jbFCSkB9wjJqFzQujaLFdKXHHAJxesNLJ9hdS/DCnC
         QgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NA+Vp6FOxTsN0rhRmqWACq/BX4WRBLfi30qX+qsu3WA=;
        b=uPq2ZyXQuEM/KBUhsVnG4dOLzzWxkN1jekuXwZMNRi/rhhXpIUgGFjHKdaRWneZUyU
         wq2nh+Wtqe+D0OIP3+0JfAT5+ygcCAO8h7g+x6NdIBsjJ+RFMcjW3a86MDKpa5XcErm9
         OKwkGsUR7Ss6LOD90R8xe2t/mrx0518fkQbQr6gyC/KL1yE+7gTdphllpAzHW/7Adzz9
         xLfPihCU9vt8YYwNvsAdRHPoO4wUq6PVM0GUXWxnCWzCdTOALy2rkjeqF1RiXmc1mNRJ
         dflHkaWyzalJMEUWIzUgBjJeUnTa9f52HDFaY8Wwrxx0sQrgyKG7uVt0ogGTsBqKfN7G
         6acw==
X-Gm-Message-State: AOAM532uk9kJgzPA2cqoFQcKttFQz49fMUtpUcA00iCktCN1+qYd9gcS
        Dq73fcOQggmyCj5pLeWCdaxh39dvn07Dnl/C5is=
X-Google-Smtp-Source: ABdhPJweWJm9bNSHZ1fcDogI4a6pspPbN1XKVhCcuzUdgLu8xCK2ZtvzgwGygNuVi1YcLZZ9N82vivx7UxB18K4ahT8=
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr629304wmj.58.1612316758120;
 Tue, 02 Feb 2021 17:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20210202073258.559443-3-zhang.lyra@gmail.com> <20210202104257.736836-1-zhang.lyra@gmail.com>
 <20210202141349.GB32671@8bytes.org>
In-Reply-To: <20210202141349.GB32671@8bytes.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 3 Feb 2021 09:45:21 +0800
Message-ID: <CAAfSe-uGeji18yZaqEWAS1W-_3Fmvnq_7PQmGE7hhGs4r+Mcvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 22:14, Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Feb 02, 2021 at 06:42:57PM +0800, Chunyan Zhang wrote:
> > +static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
> > +                                        dma_addr_t iova)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     unsigned long flags;
> > +     phys_addr_t pa;
> > +     unsigned long start = domain->geometry.aperture_start;
> > +     unsigned long end = domain->geometry.aperture_end;
> > +
> > +     if (iova < start || iova > end)
> > +             pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
> > +                    iova, start, end);
>
> It is not a good idea to continue here with an out-of-range iova. The
> code below might access random memory for its checks. Better do a
> WARN_ON here and return an invalid physical address.

Yes, I will fix this.

Thanks,
Chunyan

>
> > +
> > +     spin_lock_irqsave(&dom->pgtlock, flags);
> > +     pa = *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));
> > +     pa = (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PAGE_SIZE - 1));
> > +     spin_unlock_irqrestore(&dom->pgtlock, flags);
> > +
> > +     return pa;
> > +}
> > +
