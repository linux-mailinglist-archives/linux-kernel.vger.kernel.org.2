Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE139C2CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFDVrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhFDVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622843115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSr4NtU9kRyTYI9vJXKuouCcXbXTwJvBiHy5x/6JVcU=;
        b=Nwrd4W3xDTc/nPFGTpxk/vPg4Q+MP8NuisNDlBcju6oqKLf1sNAWalmlsZy3+h4+UvUssK
        VZdN7dG0Vae5uYS/PFO9kuaiLyW1j9fdVluXui+D1j1lWEfYgs8TQrWaQk372YJB26uY+e
        hkPNBAyHxBLg6BSHnOoeB2x6BCRG3Ic=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-hyNLE5jKMHSBwI_n5BXQqQ-1; Fri, 04 Jun 2021 17:45:13 -0400
X-MC-Unique: hyNLE5jKMHSBwI_n5BXQqQ-1
Received: by mail-ot1-f72.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so6071905ots.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zSr4NtU9kRyTYI9vJXKuouCcXbXTwJvBiHy5x/6JVcU=;
        b=JNevwz3xfHtWGjACHaUTqp5CIagQ4/DFDwEV7PkpVMGMOYz9cgD4CslN8/spN+KGNb
         spR833pk12LjDegfGNyiDlG8m2mR89qpjfdKmY549s+E+Kea67CihKGJjfqkZgHLvMEy
         cENGO/krG/0LniX6gVK8LLRHt19K7yk83ONTc7W9/4EQK3E1m8GxOLsSJZ7kp9QrEDcU
         dDRfKRl7E3ImDMzR8in9Id7O6An4b71TiIhiXlN+gQoMlwo+j1ZvddBPmVYC/HajC9fk
         0CWRh1AiO30xK5PDN3wtpHijt0ouLnBryv8VsQHEyx/U62qPAjrywAQaDXi2eGRTNpgF
         Qekw==
X-Gm-Message-State: AOAM533pUe8gjOXHPSfF4gCptkMxZkpSWuytLuroJ47ewPZZmcUNd1l/
        DGYNxxSqy/6nRDMEqRy4Oa7DsuCS0vDFWdVBs1UJZjBf5fdI+d73xCNo+p5I92I+uu+6a6+aMDm
        xwhG5hcpSYc+q058nt4og+WlL
X-Received: by 2002:a4a:b544:: with SMTP id s4mr5214633ooo.62.1622843113070;
        Fri, 04 Jun 2021 14:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXMJF5jgtVADecJNiiiu5bWXOc0GxXvl+uaj344NIz3ZPmM3VepTqHL8yFOEd8Ck092h+X+Q==
X-Received: by 2002:a4a:b544:: with SMTP id s4mr5214626ooo.62.1622843112930;
        Fri, 04 Jun 2021 14:45:12 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id l10sm752196ots.32.2021.06.04.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:45:12 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:45:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604154511.2bcb48dc.alex.williamson@redhat.com>
In-Reply-To: <20210604121337.GJ1002214@nvidia.com>
References: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
        <20210602180925.GH1002214@nvidia.com>
        <20210602130053.615db578.alex.williamson@redhat.com>
        <20210602195404.GI1002214@nvidia.com>
        <20210602143734.72fb4fa4.alex.williamson@redhat.com>
        <20210602224536.GJ1002214@nvidia.com>
        <20210602205054.3505c9c3.alex.williamson@redhat.com>
        <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210603124036.GU1002214@nvidia.com>
        <20210603144136.2b68c5c5.alex.williamson@redhat.com>
        <20210604121337.GJ1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 09:13:37 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 03, 2021 at 02:41:36PM -0600, Alex Williamson wrote:
> 
> > Could you clarify "vfio_driver"?    
> 
> This is the thing providing the vfio_device_ops function pointers.
> 
> So vfio-pci can't know anything about this (although your no-snoop
> control probing idea makes sense to me)
> 
> But vfio_mlx5_pci can know
> 
> So can mdev_idxd
> 
> And kvmgt

A capability on VFIO_DEVICE_GET_INFO could provide a hint to userspace.
Stock vfio-pci could fill it out to the extent advertising if the
device is capable of non-coherent DMA based on the Enable No-snoop
probing, the device specific vfio_drivers could set it based on
knowledge of the device behavior.  Another bit might indicate a
preference to not suppress non-coherent DMA at the IOMMU.  Thanks,

Alex

