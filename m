Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0783B167C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFWJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:10:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:08:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w21so3314598qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13Gr0i1MTKRVJOLYjbaQS0t+sJQavN2HZYVSf9igv0I=;
        b=SA9G17LOrb34DyVZWPMTTHIONdcJ/5ZbZWqssqBb4aWqa4vseTx3+V6CkFU4RvePBr
         YNNS8jqCGxfTDXRduKfQQMwLt3JL1m3nr4PNVWIksCr6YiJm78aGWUxZDo4V4hXGS1bN
         zAH4ZuRlx4WIbGetsYgzQvT1yucBC3KtrF3U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13Gr0i1MTKRVJOLYjbaQS0t+sJQavN2HZYVSf9igv0I=;
        b=O5xtF2GfLBmhhsdsKeBWjavL9xbE8xeYGOL7FObJ2+AyFf1UG5lUFjyQcU1ixsd3hI
         i36x/qZvuMurAr9Ozt2UwdbMXJtujQ6lazI+L5iBYARi8AV66BzcGEMWhENo59umTRAW
         BHeHR9ghyf5J/fYQJqMIVukvnHxiaKGaMzpJf6Aa+rtx/9GKOLU0QHa7Ro0gNiw3VCJU
         xXwLBXuhN4GUjbgqjxNh8HKFFSCQlDEs7Vkz7fWIM5d4lMbZoFBXF6YLqpE/Af9eSjfq
         u80M1mM9aOaKQ7o5kL9suVIgXNSCy2zJU9njtts5ZJhSpxpiRNYupILg0eCvnGZcD9hL
         DSbw==
X-Gm-Message-State: AOAM532N/nNuc7Bj9u21/jCwWeAbtmsTgWT1bNkECh/vun9Y5iDuRkd+
        WymKm4o5542cBzIc+odoLdPo9eELFICh1w==
X-Google-Smtp-Source: ABdhPJxMagnHN4AyuVL4WstpLFrmfoHT6yiyIcCLnBFmMIhkL0agQyeMI2IkdR0ikHyIBFWPhxYRpw==
X-Received: by 2002:a05:620a:d4e:: with SMTP id o14mr9201441qkl.402.1624439310433;
        Wed, 23 Jun 2021 02:08:30 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id o21sm3551621qtt.51.2021.06.23.02.08.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 02:08:30 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id t9so1512579qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:08:30 -0700 (PDT)
X-Received: by 2002:a02:4b46:: with SMTP id q67mr7991027jaa.84.1624438886886;
 Wed, 23 Jun 2021 02:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210619034043.199220-1-tientzu@chromium.org> <YNLy7z0Zq1AXKLng@char.us.oracle.com>
In-Reply-To: <YNLy7z0Zq1AXKLng@char.us.oracle.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 23 Jun 2021 17:01:16 +0800
X-Gmail-Original-Message-ID: <CALiNf28U9xaqth99u=hB45b=qWMYaSoe2DGgNVFrHXze6wNmdQ@mail.gmail.com>
Message-ID: <CALiNf28U9xaqth99u=hB45b=qWMYaSoe2DGgNVFrHXze6wNmdQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] Restricted DMA
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 4:38 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Sat, Jun 19, 2021 at 11:40:31AM +0800, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce restricted DMA. Restricted
> > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > specially allocated region and does memory allocation from the same region.
> > The feature on its own provides a basic level of protection against the DMA
> > overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system needs
> > to provide a way to restrict the DMA to a predefined memory region (this is
> > usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> >
> > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> > [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
>
> Heya Claire,
>
> I put all your patches on
> https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/log/?h=devel/for-linus-5.14
>
> Please double-check that they all look ok.
>
> Thank you!

They look fine. Thank you!
