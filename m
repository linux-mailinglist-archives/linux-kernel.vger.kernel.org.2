Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD15424CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhJGFpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhJGFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:45:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD5C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 22:43:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d8so18493987edx.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 22:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yLst2vmAYOFfsPqRs1YkPG/caPM67bEIOVz4JIIhbY=;
        b=oX+0VezrM6zgV7l+fjfAmT1wzCL9iZWgh3KtUE95eSsTFi1DbMwgGIj/fTYu6Gdte6
         59+2J+G4RutJG9OooRKbOCiVWfC2adXFdEC/4OFTMkpWEE+iJGqx3pvrRtCjureIghJ8
         TD5Kk7O/JyQ/uYcl63nCTbSfsTEY98McLCjE/+f/Rzpdt2941R/xuRnZzhZolXkCOzKU
         nIgFwffvYulGbHkPdmJJYbQdY1NwXFOA5qAvC60HF4K8yVnaoIHQKUwKa56RDhEzLuIm
         80+0OqDpO202MisydJCXUbRnob65HcG8j7gPkpRmo6lalywhAGFgJere/LU1dl4ZUB4i
         vScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yLst2vmAYOFfsPqRs1YkPG/caPM67bEIOVz4JIIhbY=;
        b=rxB4Yh/1OtfxBx8pjGrNNp9MVO5tCQxIpwaRSbZ6I1cZGtQFUp3JsRXRRjd7/A2Aci
         VQZMYb/0QP3xs8BKieFE6rnotf4nJzUY/7SgSsBuicwmTE/6qsCSPRQ2sd3svNwdDXAy
         RzLY8xZLhUh1RQQAU6i/LCktSzhFM4+r0o1t2JHTAUmoi4kC1d+yQXsakYOt2UiM1Vlh
         qM9YJ/QiNhZ+a7IV2C5t/10O8RlQoK1Xg8WUNNnsdG5XLILuIWBw6QHm8YJ8lrRo7fAR
         pKQHfdsXnv7yGuwIJpWHG9MyqmODuGicrbqQtnX2txX3XHrxOkYIXhecMKx/oU+kstnj
         dZHg==
X-Gm-Message-State: AOAM532utl0LAVsTjwEd4xNbcAXOwaj3nqfAxCJRDlSLQk3H3PPBkM/g
        yvXNZ50lY8D555G4O4hcSBDD+3CU7XOLiG50z8I=
X-Google-Smtp-Source: ABdhPJygsOBrVz+xXtAl5BwMSgWm8ko/zp+KlRk0jNNlblvwD9ydnXMLD9SK52HKDCQSpTlfSlXAmmxqPjdgbZ0IPjc=
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr3671932edv.384.1633585424465;
 Wed, 06 Oct 2021 22:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com> <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder> <20211004182142.GM964074@nvidia.com>
In-Reply-To: <20211004182142.GM964074@nvidia.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 7 Oct 2021 18:43:33 +1300
Message-ID: <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 7:21 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Oct 04, 2021 at 09:40:03AM -0700, Jacob Pan wrote:
> > Hi Barry,
> >
> > On Sat, 2 Oct 2021 01:45:59 +1300, Barry Song <21cnbao@gmail.com> wrote:
> >
> > > >
> > > > > I assume KVA mode can avoid this iotlb flush as the device is using
> > > > > the page table of the kernel and sharing the whole kernel space. But
> > > > > will users be glad to accept this mode?
> > > >
> > > > You can avoid the lock be identity mapping the physical address space
> > > > of the kernel and maping map/unmap a NOP.
> > > >
> > > > KVA is just a different way to achive this identity map with slightly
> > > > different security properties than the normal way, but it doesn't
> > > > reach to the same security level as proper map/unmap.
> > > >
> > > > I'm not sure anyone who cares about DMA security would see value in
> > > > the slight difference between KVA and a normal identity map.
> > >
> > > yes. This is an important question. if users want a high security level,
> > > kva might not their choice; if users don't want the security, they are
> > > using iommu passthrough. So when will users choose KVA?
> > Right, KVAs sit in the middle in terms of performance and security.
> > Performance is better than IOVA due to IOTLB flush as you mentioned. Also
> > not too far behind of pass-through.
>
> The IOTLB flush is not on a DMA path but on a vmap path, so it is very
> hard to compare the two things.. Maybe vmap can be made to do lazy
> IOTLB flush or something and it could be closer
>
> > Security-wise, KVA respects kernel mapping. So permissions are better
> > enforced than pass-through and identity mapping.
>
> Is this meaningful? Isn't the entire physical map still in the KVA and
> isn't it entirely RW ?

Some areas are RX, for example, ARCH64 supports KERNEL_TEXT_RDONLY.
But the difference is really minor.

So do we have a case where devices can directly access the kernel's data
structure such as a list/graph/tree with pointers to a kernel virtual address?
then devices don't need to translate the address of pointers in a structure.
I assume this is one of the most useful features userspace SVA can provide.

But do we have a case where accelerators/GPU want to use the complex data
structures of kernel drivers?

>
> Jason

Thanks
barry
