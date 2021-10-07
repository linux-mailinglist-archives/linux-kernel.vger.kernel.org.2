Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0769C425256
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhJGL5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJGL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 07:56:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 04:55:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so22000634edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Sc46Q9eMcwlaMy2IZJgD2QwpVCcYg9+SD8cXYZgbr4=;
        b=RT9YmSKnUjHCEr3v6bar51e1fzGq7K8YE+IB7ejWFNs9jODGQtkmWkzq2hgZujJCUJ
         mnennI/hqWHn0R1mtQCCEqvymetd/bl2VgplLcGb/U/N0sjVCoyKEwx/mkoc9MmETaWb
         ceVbHfdd9xnvcaN9u+osChdyCUu9BQJsE2WJ1gkkcj9kLDP7jXmcIiWdLsxl9rKdDTIf
         H3EuUUBia7VJlzi8PEgVftWKFBtcQ65f0EUzVoBGCFv1cdIyTgp1RMdXi/gD1rVfq7g4
         IPgNqk9yxnkGrT6gy6s2iNHiSDmFQpfjA2B5eyN0gQHdihyPlscJUjXMjZzUJB7bbr1L
         Wh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Sc46Q9eMcwlaMy2IZJgD2QwpVCcYg9+SD8cXYZgbr4=;
        b=b+r0j8zgoGD/67gKWdA1IyWZM3UuWtSmfA/RPy/Kqy+1SD9+x0911naFckurk08tSf
         K7f6DDdHlyg0FmIAAYG6CZt/oxXj4G8UPv5jKG7jY3aQC8n0QG90iXbdJdbKDObSr1Hd
         5Y8I96uTOwcCmK4JULDohsTAmHNNYEbr6V9FaS0tVQTrjpEUCj7U4im0O04DGsHDLUCv
         XSCEzXmIjM1eMPnOjhOJmG01lBZnL7rzUtzQpmZmOhLtojHlZuTk/4PyUEocgTYWXSzd
         TlPIB9LNaj+s2LIcNZJon2S5tmcXmMDVK5r5E6MUoDL57Jix0AVKHHEhk9sh74vOTsrZ
         plUA==
X-Gm-Message-State: AOAM530eFI+IEdsB3lNxTEaSmQPspJvZT7Hy/ysZXIOqfQPlDuJ1Hq4u
        CWCdTdIFunujNZF1jfme6sCfYWMElFgGiFI15BY=
X-Google-Smtp-Source: ABdhPJyCXK/u3V2xMWIJIiVDE8gg9vaOTOj4ckAKIeY5EmY50zW1eFNxbthRtAZ1ldJbNFWWIlCpZCQBCqK/PKY06k8=
X-Received: by 2002:a17:906:3383:: with SMTP id v3mr5173329eja.213.1633607703888;
 Thu, 07 Oct 2021 04:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com> <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder> <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com> <20211007113221.GF2744544@nvidia.com>
In-Reply-To: <20211007113221.GF2744544@nvidia.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 8 Oct 2021 00:54:52 +1300
Message-ID: <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
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

On Fri, Oct 8, 2021 at 12:32 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 07, 2021 at 06:43:33PM +1300, Barry Song wrote:
>
> > So do we have a case where devices can directly access the kernel's data
> > structure such as a list/graph/tree with pointers to a kernel virtual address?
> > then devices don't need to translate the address of pointers in a structure.
> > I assume this is one of the most useful features userspace SVA can provide.
>
> AFIACT that is the only good case for KVA, but it is also completely
> against the endianess, word size and DMA portability design of the
> kernel.
>
> Going there requires some new set of portable APIs for gobally
> coherent KVA dma.

yep. I agree. it would be very weird if accelerators/gpu are sharing
kernel' data struct, but for each "DMA" operation - reading or writing
the data struct, we have to call dma_map_single/sg or
dma_sync_single_for_cpu/device etc. It seems once devices and cpus
are sharing virtual address(SVA), code doesn't need to do explicit
map/sync each time.

>
> Jason

Thanks
barry
