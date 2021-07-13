Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C03C7A57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhGNAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGNAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:00:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CFC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:57:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v14so588197qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zVi6Upa6TvGQVrA4Uk3V9Aucme5rYYsn/FFlTnsYBE=;
        b=Jm53ya8qCS8kvz06IHHppipSYsjZFWjWQzGX6KnPDMOqtJsbSAfCMgZi9NE7MQESim
         aiQuq3ZWuZFbvBzPLwVzURfjxjGXTqkP6adcDU4KzvFzuIvXywZ1LI/noRlK57+Rh3Fi
         QFTGh4jfriWjkO/Iw9EnL6z63r+W/6vd6I684CrjXs9ZRIlN8FcDhy3mDA6mHL8vAQXk
         XYWKmdDYiNuPTWnWKolsj8yA2wIEBR4/WZR6XWJtWwu65fC31tGOVXrUepE/RrUW75aQ
         CWesEvdaXRlwNTM5hFkot1Uo1s+PDgLGnPSHhU5qqiX8CnCqC2T6rx+bj2wWMw7AYD49
         69AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8zVi6Upa6TvGQVrA4Uk3V9Aucme5rYYsn/FFlTnsYBE=;
        b=j4Kf4muhW7s74kT1QSPG7K1JueZ/ExxXX6UyUYcw6v23KMNfixtzRACkwuk50/w05T
         +g3BklVw7ojfyBmT6IhSXnB5DAUolYHYrLNq7NIAJ8ArcrB4iyypcYa3vLDNccjWn93b
         MKXh7SAmCWhmarxiCMn3RA4F87y5c7Yu7iNxKeHdE6JTlb6I+ViJukE4MB3ZLaht4Tou
         8v3F/65nN8Q37uv3zRJulwFIM/6npBgxywFhbKNZhVUG6CPkwWlIBbOqJjzq8SaoU9yg
         iFs3jjceQi8Fb6edNTXCQQRh5iSEAphceYIIKZvrJO1xBsdQ0KecVKcr92aktaXlJohI
         bmDA==
X-Gm-Message-State: AOAM530IW32QYgcEdM0+VqN/FuZr3iazY1woK3SJmD7ryWn/taeduDp+
        lJxnmUKwVm4ny9KzlO0PSZ+ZyDDgfGje6yvA
X-Google-Smtp-Source: ABdhPJwnKv9aLbsVfdblhmDtQKkmuAhXYGTLAEDiKLh9RpaAl7uhjGSZDhFpZYjRnHnzu1ZLAdCg4g==
X-Received: by 2002:ac8:5a94:: with SMTP id c20mr6734807qtc.30.1626220662527;
        Tue, 13 Jul 2021 16:57:42 -0700 (PDT)
Received: from fedora ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id u11sm226399qkk.72.2021.07.13.16.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:57:41 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Tue, 13 Jul 2021 19:57:40 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, will@kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu
 v2 and uses identity mapping
Message-ID: <YO4odF0EwqxfNLFq@fedora>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org>
 <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 03:43:42PM +0100, Robin Murphy wrote:
> On 2021-07-08 14:57, Kai-Heng Feng wrote:
> > On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > 
> > > On 2021-07-08 10:28, Joerg Roedel wrote:
> > > > On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> > > > > @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
> > > > > 
> > > > >               iommu = amd_iommu_rlookup_table[dev_data->devid];
> > > > >               dev_data->iommu_v2 = iommu->is_iommu_v2;
> > > > > +
> > > > > +            if (dev_data->iommu_v2)
> > > > > +                    swiotlb = 1;
> > > > 
> > > > This looks like the big hammer, as it will affect all other systems
> > > > where the AMD GPUs are in their own group.
> > > > 
> > > > What is needed here is an explicit check whether a non-iommu-v2 device
> > > > is direct-mapped because it shares a group with the GPU, and only enable
> > > > swiotlb in this case.
> > > 
> > > Right, it's basically about whether any DMA-limited device might at any
> > > time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
> > > possibility of device hotplug and the user being silly with the sysfs
> > > interface, I don't think we can categorically determine that at boot time.
> > > 
> > > Also note that Intel systems are likely to be similarly affected (in
> > > fact intel-iommu doesn't even have the iommu_default_passthough() check
> > > so it's probably even easier to blow up).
> > 
> > swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
> > disable it.
> 
> Oh, right... I did say I found this dance hard to follow. Clearly I
> shouldn't have trusted what I thought I remembered from looking at it
> yesterday :)
> 
> Also not helped by the fact that it sets iommu_detected which *does* disable
> SWIOTLB, but only on IA-64.
> 
> > I wonder if we can take the same approach in amd-iommu?
> 
> Certainly if there's a precedent for leaving SWIOTLB enabled even if it
> *might* be redundant, that seems like the easiest option (it's what we do on
> arm64 too, but then we have system topologies where some devices may not be
> behind IOMMUs even when others are). More fun would be to try to bring it up
> at the first sign of IOMMU_DOMAIN_IDENTITY if it was disabled previously,
> but I don't have the highest hope of that being practical.

<scratches his head>
It is kind of silly to enable SWIOTLB which will just eat 64MB of memory
"just in case".

The SWIOTLB does have support to do late initialization (xen-pcifront
does that for example - so if you add devices that can't do 64-bit it
will allocate something like 4MB).

Would that be a better choice going forward - that is allocate this
under those conditions?
> 
> Robin.
