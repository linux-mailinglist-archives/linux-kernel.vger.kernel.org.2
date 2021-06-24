Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F333B3924
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhFXWZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFXWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624573359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g477a7vYcPKjBKrDFYuYGrViI13ze8NFDaxSg09H1cQ=;
        b=SZvzVfWZDgxUs16lzZoL+yzcVQ0ndXdSGGjxUDZST62VFoLqV+ODwHOArDRESz18CUdW5z
        +Joy9dL62IZKbo7bWjbDkNCEF+toc7ivsVBDjuU8jaApx7MjjCTpLlrtVK/N12hQzugECa
        jiFgt5q+qYxdrF9jw9t8cQDV5vTNyNw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-qXCJhEJ-Psq7XK7GtZSgxg-1; Thu, 24 Jun 2021 18:22:37 -0400
X-MC-Unique: qXCJhEJ-Psq7XK7GtZSgxg-1
Received: by mail-oi1-f199.google.com with SMTP id n144-20020acad6960000b029023d8bff0429so896481oig.21
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 15:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g477a7vYcPKjBKrDFYuYGrViI13ze8NFDaxSg09H1cQ=;
        b=OazHg+AYyP4gghtTGwqliIgqlA2YTB8M/fxTn4jOOHCZvbCWQ8QubmPYn9CeJ3iAol
         c/SZ77tk16FCeQcX3ct4J2G18ssWq7/uXi2i/sOkaIRYK5imIUCccyH4LI/NwsVCNKq0
         ICCTmzvlU6kR4M+nF8CDg5tody2YNNr6BrMta0rpM11uEo8cbwwSXquaH2kLlNI9pykb
         bkso1Gm5SJfHhMDnZ2xB33+jpaXThYXZlMk3punNl3anltwivqSszCfdQwmjRc44SbIE
         MUVoNHFBF43KNwl2ODoAEOOLiKrTtvf2PZCpyLrxrP1CYDgdNDNqtOxCPRvwBBrkJ4vn
         H2Mw==
X-Gm-Message-State: AOAM533nLeTs+5jZHo4pjRI0jwtqX/gDx8DhFPdHevGOFiL4HY+hjaju
        rvktniiDl8YWlEaSk2m7NRjZa4J3Drfvp0BT6f2tOAz4EYEWr3andjCcme/y0kb2Hwc73thyhjl
        5UQl3aQso5JWErQQ0SW7B3s+6
X-Received: by 2002:aca:3047:: with SMTP id w68mr1880002oiw.6.1624573357104;
        Thu, 24 Jun 2021 15:22:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBPANrb92It2A02MpQuIyUGqsZj+J9hwey1ULiCLGhpflsYkKlL9h3yl020Nq3skcI4zeyXA==
X-Received: by 2002:aca:3047:: with SMTP id w68mr1879989oiw.6.1624573356916;
        Thu, 24 Jun 2021 15:22:36 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id s4sm502047oou.43.2021.06.24.15.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:22:36 -0700 (PDT)
Date:   Thu, 24 Jun 2021 16:22:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tian\, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dey\, Megha" <megha.dey@intel.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Liu\, Yi L" <yi.l.liu@intel.com>,
        "Lu\, Baolu" <baolu.lu@intel.com>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        "Kumar\, Sanjay K" <sanjay.k.kumar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] vfio/pci: Document the MSI[X] resize side effects
 properly
Message-ID: <20210624162234.6476712c.alex.williamson@redhat.com>
In-Reply-To: <87im23bh72.ffs@nanos.tec.linutronix.de>
References: <20210622131217.76b28f6f.alex.williamson@redhat.com>
        <87o8bxcuxv.ffs@nanos.tec.linutronix.de>
        <20210623091935.3ab3e378.alex.williamson@redhat.com>
        <MWHPR11MB18864420ACE88E060203F7818C079@MWHPR11MB1886.namprd11.prod.outlook.com>
        <87mtrgatqo.ffs@nanos.tec.linutronix.de>
        <20210623204828.2bc7e6dc.alex.williamson@redhat.com>
        <87im23bh72.ffs@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 14:06:09 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> The documentation of VFIO_IRQ_INFO_NORESIZE is inaccurate as it suggests
> that it is safe to dynamically add new MSI-X vectors even when
> previously allocated vectors are already in use and enabled.
> 
> Enabling additional vectors is possible according the MSI-X specification,
> but the kernel does not have any mechanisms today to do that safely.
> 
> The only available mechanism is to teardown the already active vectors
> and to setup the full vector set afterwards.
> 
> This requires to temporarily disable MSI-X which redirects any interrupt
> raised by the device during this time to the legacy PCI/INTX which is
> not handled and the interrupt is therefore lost.
> 
> Update the documentation of VFIO_IRQ_INFO_NORESIZE accordingly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/uapi/linux/vfio.h |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -699,10 +699,19 @@ struct vfio_region_info_cap_nvlink2_lnks
>   * disabling the entire index.  This is used for interrupts like PCI MSI
>   * and MSI-X where the driver may only use a subset of the available
>   * indexes, but VFIO needs to enable a specific number of vectors
> - * upfront.  In the case of MSI-X, where the user can enable MSI-X and
> - * then add and unmask vectors, it's up to userspace to make the decision
> - * whether to allocate the maximum supported number of vectors or tear
> - * down setup and incrementally increase the vectors as each is enabled.
> + * upfront.
> + *
> + * MSI cannot be resized safely when interrupts are in use already because
> + * resizing requires temporary disablement of MSI for updating the relevant
> + * PCI config space entries. Disabling MSI redirects an interrupt raised by
> + * the device during this time to the unhandled legacy PCI/INTX, which
> + * means the interrupt is lost.
> + *
> + * Enabling additional vectors for MSI-X is possible at least from the
> + * perspective of the MSI-X specification, but not supported by the
> + * exisiting PCI/MSI-X mechanisms in the kernel. The kernel provides
> + * currently only a full teardown/setup cycle which requires to disable
> + * MSI-X temporarily with the same side effects as for MSI.
>   */
>  struct vfio_irq_info {
>  	__u32	argsz;
> 

There's good information here, but as per my other reply I think
NORESIZE might be only a host implementation issue for both MSI and
MSI/X.

I'd also rather not focus on that existing implementation in this
header, which is essentially the uAPI spec, because that implementation
can change and we're unlikely to remember to update the description
here.  We might even be describing a device that emulates MSI/X in some
way that it's not bound by this limitation.  For example maybe Intel's
emulation of MSI-X backed by IMS wouldn't need this flag and we could
update QEMU to finally have a branch that avoids the teardown/setup.
We have a flag to indicate this behavior, consequences should be
relative to the presence of that flag.

Finally a nit, I don't really see a strong case that the existing text
is actually inaccurate or implying some safety against lost interrupts.
It's actually making note of the issue here already, though the more
explicit description is welcome.  Thanks,

Alex

