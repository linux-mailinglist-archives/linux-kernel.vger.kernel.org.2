Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42F3B2746
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhFXGQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhFXGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:16:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B50C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:14:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s14so3013573pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osJqntoZHJL8VeQbE2d8Gx1TrOiajWQXazXH9w70kIY=;
        b=f09JHaTt6yY9HlwcujpzmyCJbvbUoIE0cZNa0aICkCK68T/rODYze/6/aKRkuFqgtc
         aQSgGc4CEL1bXaOSKVo+xlBop7hH5m1EqqxXbZi8VyWUJmFL6g6BM4X4ZMkMlYffhkXb
         itPPZk67YIl+8XjGG/C0lboNwjIIr80wXQ+NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osJqntoZHJL8VeQbE2d8Gx1TrOiajWQXazXH9w70kIY=;
        b=O8bvoBuFwsauFXOWt4/PyCLgcBuahgpevfyRUP1UJ3hyqK0Vw+7BhrMIYwNrNkuTth
         Kh5I/tioHJ42+odkKEaLVABmfqUmB0ah43zjw+qBZoX4UA6RPquVeREafSHQC3kE9Wtb
         0XsHwECLPapHl8ULEHs2jt/AIf0mMcY3E+amhUP7KUxbCl0NuZ1CAlCj2IKX1NbOOTg8
         svJsj5pCPo0d6DpvH10TBzx9UPUaBYg43/1/RdMbmXNMC4AfFWHE/h7DPCAeXiPWcvqP
         hCv/oP57p70IZTBFTo0873nV8ShclNIzMgc1ggoMbMOeAwWhGT27nwJOBAPC2oL9NWxr
         DDMA==
X-Gm-Message-State: AOAM530lh/bqPjGX6VvgU9eLqFYydLHuMolwm2W/txs6YJDnNQZk+7xJ
        65BETxyQuV7lIvsAWWqUpozI2ezYVyyKdw==
X-Google-Smtp-Source: ABdhPJwEOZeeOfG7TAyj2t6gZ+N23/PGHOKllsrBsVtkf5ZFc0ZXBWl0AH6CtpkH5QdoD0RvZAe/YQ==
X-Received: by 2002:a63:a53:: with SMTP id z19mr3231745pgk.125.1624515254032;
        Wed, 23 Jun 2021 23:14:14 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id s4sm1295713pjn.31.2021.06.23.23.14.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 23:14:13 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id w71so4295123pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:14:13 -0700 (PDT)
X-Received: by 2002:a92:750c:: with SMTP id q12mr2332407ilc.303.1624514749926;
 Wed, 23 Jun 2021 23:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210619034043.199220-1-tientzu@chromium.org> <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com> <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com> <20210624054315.GA25381@lst.de>
In-Reply-To: <20210624054315.GA25381@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 24 Jun 2021 14:05:39 +0800
X-Gmail-Original-Message-ID: <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
Message-ID: <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, benh@kernel.crashing.org,
        joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        jani.nikula@linux.intel.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 1:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jun 23, 2021 at 02:44:34PM -0400, Qian Cai wrote:
> > is_swiotlb_force_bounce at /usr/src/linux-next/./include/linux/swiotlb.h:119
> >
> > is_swiotlb_force_bounce() was the new function introduced in this patch here.
> >
> > +static inline bool is_swiotlb_force_bounce(struct device *dev)
> > +{
> > +     return dev->dma_io_tlb_mem->force_bounce;
> > +}
>
> To me the crash looks like dev->dma_io_tlb_mem is NULL.  Can you
> turn this into :
>
>         return dev->dma_io_tlb_mem && dev->dma_io_tlb_mem->force_bounce;
>
> for a quick debug check?

I just realized that dma_io_tlb_mem might be NULL like Christoph
pointed out since swiotlb might not get initialized.
However,  `Unable to handle kernel paging request at virtual address
dfff80000000000e` looks more like the address is garbage rather than
NULL?
I wonder if that's because dev->dma_io_tlb_mem is not assigned
properly (which means device_initialize is not called?).
