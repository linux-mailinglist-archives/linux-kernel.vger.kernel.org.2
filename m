Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D686541EDC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354474AbhJAMr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353423AbhJAMr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:47:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA505C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:46:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bd28so34251214edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA98+GIBaPHY6lzBmZ4Tvs/snpUhHoNpqwt61nTpkis=;
        b=Is5IqeVMoXBsSYVNc+BFcM1OoT119+AkF8qL2/okCD58nmP6OhA3iQ4f5TMNyqrjoK
         cb2+r1W2u4pyHVeqXBDFMdeNnRqec2bqCqRpXsfVEJ95ZOUESabZJVLBWm+5rhgdlHUv
         b/ryU+BYOE6LEkxv0n83Nab6K3vvgwDIwWPW5i0jFtfaKH69YjR9S24feRgohcJQQHtB
         g4ns6FIB7E0M2bKArcf/fXtJ5w0Roum8U/kDMjAsnl84CKLQ/ldLzZTNShmaAJikKVs4
         zvZBe8R9Ts+G9JhY3gnUQ/6vvote/VYDxgAHFmSzlDKPmb1BG0p4iOmvfHnAvWWNO+LY
         3AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA98+GIBaPHY6lzBmZ4Tvs/snpUhHoNpqwt61nTpkis=;
        b=DbJeP7B5JW38LjIPjej1Bw3fealD80MBBvkMWMxFySLZAuqhV12n47AMa4aac3QpHL
         tPjYQb0hROj0nXyx5yqR6/Wz57i+LP8HXffjib9IEzRpq7yVusmpdW9MQhlTN5VVbK9V
         wHDxT7hPX9ZLM7C6mfMq3Dtbd2DxxIV7gMetNf4IaZPUxZJ5QtUYRApAOOcMBXy6VpTa
         sRczo1eE/IGRxYj8G5QWGXv0PPHITO6GzvfStLc5dwVkg2K2M0CM1HjRkNjsp62w4Wza
         eNYmIKR3tsnQ+1QTUwK5k3eXsYakFQcdIVNqjUZ1FeTo8JUClQoktqn15K2BXsCha1RR
         jZdg==
X-Gm-Message-State: AOAM530WVjCJDdHF5KUl6Z/nYtedjrJU08UeCN64zL1+K/Khb3fMX1tm
        kbRhn0aU/r6kTGx3eypJbvpOUX6Re+TIC/Iseuv0eH56n5AJTA==
X-Google-Smtp-Source: ABdhPJxWiAd7awY5FtJw8iqY2HDUYsVtRLzq0FFELa59+THVoAzC4qdbZLWi9qBDropgPYf+lhIrCIjpvxRQBPP+EW0=
X-Received: by 2002:a17:906:280f:: with SMTP id r15mr5671342ejc.559.1633092371103;
 Fri, 01 Oct 2021 05:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com> <20211001123623.GM964074@nvidia.com>
In-Reply-To: <20211001123623.GM964074@nvidia.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 2 Oct 2021 01:45:59 +1300
Message-ID: <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 1:36 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sat, Oct 02, 2021 at 01:24:54AM +1300, Barry Song wrote:
>
> > I assume KVA mode can avoid this iotlb flush as the device is using
> > the page table of the kernel and sharing the whole kernel space. But
> > will users be glad to accept this mode?
>
> You can avoid the lock be identity mapping the physical address space
> of the kernel and maping map/unmap a NOP.
>
> KVA is just a different way to achive this identity map with slightly
> different security properties than the normal way, but it doesn't
> reach to the same security level as proper map/unmap.
>
> I'm not sure anyone who cares about DMA security would see value in
> the slight difference between KVA and a normal identity map.

yes. This is an important question. if users want a high security level,
kva might not their choice; if users don't want the security, they are using
iommu passthrough. So when will users choose KVA?

>
> > which have been mapped in the current dma-map/unmap with IOMMU backend.
> > some drivers are using bouncing buffer to overcome the performance loss of
> > dma_map/unmap as copying is faster than unmapping:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907676b130711fd1f
>
> It is pretty unforuntate that drivers are hard coding behaviors based
> on assumptions of what the portable API is doing under the covers.

not real when it has a tx_copybreak which can be set by ethtool or
similar userspace
tools . if users are using iommu passthrough, copying won't happen by
the default
tx_copybreak.  if users are using restrict iommu mode, socket buffers
are copied into
the buffers allocated and mapped in the driver. so this won't require
mapping and
unmapping socket buffers frequently.

>
> Jason

Thanks
barry
