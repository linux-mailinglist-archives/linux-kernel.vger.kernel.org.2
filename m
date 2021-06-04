Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1D39B4B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFDITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:19:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099FC061761
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:17:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g18so8138730edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pA6kOnUwGdLjT+HtkefvlY6EKpZPlfWYliJZeTH5cjY=;
        b=lFADnsF9UsFoaDLFuDiE3qR4lJMI7Y7rpbFv5JEXZif3sE9d8YQ/mNyYh0aRuRfBgk
         5vuz3z36rznFoGquR3uZXfm7ikUjs6XlkUKvlJV2j03J9kBfJ8xZe1cP2Jlbt6CicVlG
         e6xeysQ/9sIGQmaN2+m9Gkaa49FOBsaOdz0fTQ3Ot97KcMDbjRb+b7XEN7yuRYRqyrEA
         r2MzPj+49IDhlieo3n2onlDQdV2deXczTLFcvXtDY7kBNyyyTKmNWdlE5lqgEXSVyOrI
         SaRRQ36GmcrpO10KPkJuwT7MtAHtafCuhVx4/qlKo0csmuy3sTJNqqBN0EFyRtslVpda
         uY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pA6kOnUwGdLjT+HtkefvlY6EKpZPlfWYliJZeTH5cjY=;
        b=j3+PvY2y6zYwWKJ+589hx6W69nqz3vFk38hWiGZtqTzP60dGzUSUKu8Hj7P0T71vSe
         kJNkcN3W4NU04iQh7fvkL2M7qGhvv11Qsxxn2FBXxcHV7NNta3GsQM+MMr6fgOLc95Vf
         MX9tF5LIPJw7NxSRQjzQVVYSvRu5qc8ng1CUT6MMUaOux9vLHs1VQ60P9SQP5LL5ABb+
         nStSXBwIF/F8WjKcBMKPUC7uFvZaTy4rsmf8XfC9bdaFZc5dsXL3IG0rEGYSPDj9liei
         vcE4T5KNQelYWPKQnURJhxkQttzKFAILdHHk9iC2l59QHq3Uvfr1mQq9TkLXctzNbx85
         +FWg==
X-Gm-Message-State: AOAM5333Y4bqAZvI9cqNQY2f88UzZ5usiIZAVDvSGajrTQzwCfAkUtvi
        lxEUPYTbVV6KjMHwQJOGfJGbjg==
X-Google-Smtp-Source: ABdhPJw58GrIl0M//k4Pi6xFOWNDjtRp84dO52fgTzB2d60XpXUPnEoWEYtxwESxba+7iC/zDodKCQ==
X-Received: by 2002:aa7:d8d8:: with SMTP id k24mr3365926eds.253.1622794669861;
        Fri, 04 Jun 2021 01:17:49 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id am5sm2465979ejc.28.2021.06.04.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 01:17:49 -0700 (PDT)
Date:   Fri, 4 Jun 2021 10:17:30 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLnhmgLVPJR7LJmk@myrica>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601202834.GR1002214@nvidia.com>
 <MWHPR11MB1886172080807517E92A8EF68C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886172080807517E92A8EF68C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:25:00AM +0000, Tian, Kevin wrote:
> > > This implies that VFIO_BOUND_IOASID will be extended to allow user
> > > specify a device label. This label will be recorded in /dev/iommu to
> > > serve per-device invalidation request from and report per-device
> > > fault data to the user.
> > 
> > I wonder which of the user providing a 64 bit cookie or the kernel
> > returning a small IDA is the best choice here? Both have merits
> > depending on what qemu needs..
> 
> Yes, either way can work. I don't have a strong preference. Jean?

I don't see an issue with either solution, maybe it will show up while
prototyping. First one uses IDs that do mean something for someone, and
userspace may inject faults slightly faster since it doesn't need an
ID->vRID lookup, so that's my preference.

> > > In addition, vPASID (if provided by user) will
> > > be also recorded in /dev/iommu so vPASID<->pPASID conversion
> > > is conducted properly. e.g. invalidation request from user carries
> > > a vPASID which must be converted into pPASID before calling iommu
> > > driver. Vice versa for raw fault data which carries pPASID while the
> > > user expects a vPASID.
> > 
> > I don't think the PASID should be returned at all. It should return
> > the IOASID number in the FD and/or a u64 cookie associated with that
> > IOASID. Userspace should figure out what the IOASID & device
> > combination means.
> 
> This is true for Intel. But what about ARM which has only one IOASID
> (pasid table) per device to represent all guest I/O page tables?

In that case vPASID = pPASID though. The vPASID allocated by the guest is
the same from the vIOMMU inval to the pIOMMU inval. I don't think host
kernel or userspace need to alter it.

Thanks,
Jean
