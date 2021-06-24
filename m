Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A553B350A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhFXRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231407AbhFXRzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624557161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRyTmO/okuVJfaJ7dk8yyjIjINkUQGFobyRYmuUJ7W4=;
        b=YuyAIucpXjPxanHwMGDX4DCy6kSBUgxVfkdowsyRtB4M4LIH0YTZrD9VM6ObmkeZpOzm+K
        i8k6uwbL2WH7vGdsyuDpTU63b4xdcGEIFYa4YDSJTpSthaYkC/t3b9z1GVbcxb+9JYtQLR
        8cXPbEIHBulER2RCEGEKDft96BlSdFU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-KPO89TcdNx-WS9KdWXpW9g-1; Thu, 24 Jun 2021 13:52:40 -0400
X-MC-Unique: KPO89TcdNx-WS9KdWXpW9g-1
Received: by mail-oi1-f198.google.com with SMTP id r3-20020acac1030000b02902068458b0f9so4301001oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 10:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRyTmO/okuVJfaJ7dk8yyjIjINkUQGFobyRYmuUJ7W4=;
        b=tfznNkbrWAHCMD2wn5a6lR6YsAJTGW4TG/dewlBR7lxiAexQVn3m9Lrh/N12Dq9xnt
         cPVD1xhnFtcLe4SqHzExMYxRUILDuRafVPi1zZx1/b4htjDqZD8H2NoHm+FFvqAX+CD4
         HSc+N6FePFKrqAdsn0bE+D4jNlvhA35XJ0ACZwq40JbL8RMutxmHZ31lVYj3UV6wyVr6
         1YajKW0awFFLX0D4k0GfDEPi2h/CNDDOQwlrPrg0Rpjz6z/f69peszFxLZgPd8Giccfh
         JogTJVbgSAa5DJQtyQYdcWg4L2D7fzRHOsLJhCwZhGLVW9uGzWAdAKpbSaa4kd3s/dob
         pwpg==
X-Gm-Message-State: AOAM530w4FjhhB4cjWI8oxzXzAF6z46XChEA/iaNC/zoabcfVPNNvYS4
        azjSeHo8Hc9mfPG91MXnzzw5N0SbnJ1f94R7PbG9AsZxPiIomD/67cvTDdXHcVqe+Pl87Jxded6
        Fc9cDPSDQGzUayVKjw75OxBFR
X-Received: by 2002:aca:dac5:: with SMTP id r188mr8247757oig.100.1624557159310;
        Thu, 24 Jun 2021 10:52:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZkDJ1EqRluMEmHYdzB3B6fB7sbOa/DXhC0Do1suiUawkIbE6RZUJHW5yZlj88tgCSUQZpZA==
X-Received: by 2002:aca:dac5:: with SMTP id r188mr8247743oig.100.1624557159087;
        Thu, 24 Jun 2021 10:52:39 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y17sm779762oih.54.2021.06.24.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:52:38 -0700 (PDT)
Date:   Thu, 24 Jun 2021 11:52:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        "Bjorn Helgaas" <helgaas@kernel.org>
Subject: Re: Virtualizing MSI-X on IMS via VFIO
Message-ID: <20210624115236.309d6b48.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB18864420ACE88E060203F7818C079@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210622131217.76b28f6f.alex.williamson@redhat.com>
        <87o8bxcuxv.ffs@nanos.tec.linutronix.de>
        <20210623091935.3ab3e378.alex.williamson@redhat.com>
        <MWHPR11MB18864420ACE88E060203F7818C079@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 00:00:37 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, June 23, 2021 11:20 PM
> >  
> [...]
>  > > So the only downside today of allocating more MSI-X vectors than
> > > necessary is memory consumption for the irq descriptors.  
> > 
> > As above, this is a QEMU policy of essentially trying to be a good
> > citizen and allocate only what we can infer the guest is using.  What's
> > a good way for QEMU, or any userspace, to know it's running on a host
> > where vector exhaustion is not an issue?  
> 
> In my proposal a new command (VFIO_DEVICE_ALLOC_IRQS) is
> introduced to separate allocation from enabling. The availability
> of this command could be the indicator whether vector 
> exhaustion is not an issue now?

We have options with existing interfaces if we want to provide some
programmatic means through vfio to hint to userspace about vector
usage.  Otherwise I don't see much justification for this new ioctl, it
can largely be done with SET_IRQS, or certainly with extensions of
flags.

> > > So no, we are not going to proliferate this complete ignorance of how
> > > MSI-X actually works and just cram another "feature" into code which is
> > > known to be incorrect.  
> > 
> > Some of the issues of virtualizing MSI-X are unsolvable without
> > creating a new paravirtual interface, but obviously we want to work
> > with existing drivers and unmodified guests, so that's not an option.
> > 
> > To work with what we've got, the vfio API describes the limitation of
> > the host interfaces via the VFIO_IRQ_INFO_NORESIZE flag.  QEMU then
> > makes a choice in an attempt to better reflect what we can infer of the
> > guest programming of the device to incrementally enable vectors.  We  
> 
> It's a surprise to me that Qemu even doesn't look at this flag today after
> searching its code...

There are no examples of the alternative, it would be dead, untested
code.  The flag exists in the uAPI to indicate a limitation of the
underlying implementation that has always existed.  Should we remove
that limitation, as Thomas now sees as possible, then QEMU wouldn't
need to make a choice whether to fully allocate the vector table or
incrementally tear-down and re-init.

> > could a) work to provide host kernel interfaces that allow us to remove
> > that noresize flag and b) decide whether QEMU's usage policy can be
> > improved on kernels where vector exhaustion is no longer an issue.  
> 
> Thomas can help confirm but looks noresize limitation is still there. 
> b) makes more sense since Thomas thinks vector exhaustion is not 
> an issue now (except one minor open about irte).

As noted elsewhere, a) is indeed a limitation of the host interfaces,
not implicit to MSI-X.  Obviously we can look at different QEMU
policies, including generating hardware faults to the VM on exhaustion
or unmask failures, interrupt injection or better inferring potential
vector usage.  Thanks,

Alex

