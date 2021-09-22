Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47674415390
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhIVWqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhIVWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632350711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6zD8kdwatd21Yh5voYOyt3V4ervr93MOQFFBWnGbwo=;
        b=SxxnBoXzMFI9V5PnNlcLYtA5kDEs1zWLDlo4O5hkOPlFLgceS+T35Nl3dd7LsLTvDNgovc
        YnlpS2Zsz52pIkevwCd1bZl4KXdAkrB18JiQwIRIb5pUoWMZZgmT8q9zhLAwRNjI2f2RxJ
        JidBhY+/c0I63xtOhHvPMGOfRUEEmpc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-z5XUQKEvPTe-uI0iuOtRsA-1; Wed, 22 Sep 2021 18:45:10 -0400
X-MC-Unique: z5XUQKEvPTe-uI0iuOtRsA-1
Received: by mail-oo1-f72.google.com with SMTP id f16-20020a4a9210000000b002a84ff0cc9aso2571838ooh.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=E6zD8kdwatd21Yh5voYOyt3V4ervr93MOQFFBWnGbwo=;
        b=DeMwQlgQB6/LAcn2jH9H+SS8r3sVqFcV9R3FeGbYzHHNFits/wEr7ojzxilRZ1jESB
         s1k4Bcdi0pHdjw+5NvmtPV2FkF1JKPJ0LTYVhsXLJ4PGMfUb8hcgj+UhLNo7+XjkbYLX
         1QcYh1qlI9KbruDB/H2WMU01pC/LQtXtB1R5t5uUXe/apWHFxP9eyx3umDvnufKuXNQx
         9k1dWb2aRCGkPJ+abXG9KqVY7AY5DV9IgzBzVJHuT08McbFi/5oS3W6zyzyrJbd5TcVx
         NApvEGgjyn6+yqDtHt2st54EfWMwmhj8Kcuzp/uMvgKMkQQSKBYzovMUjOzMmRj6YKE8
         DCxg==
X-Gm-Message-State: AOAM533cpgXAFFvZCQjxYZtrH2mpoLGa3NdNdG9EspgYUvlDUGefe75Y
        6sJi84WGl5tEaaQUEbB5dd/MFGUN66ySSP+jLawVC3yO9OFsPDHL2nUsDAv+l3ZRzEHitWCltXd
        17fkKT8gD9+gDhdaZBRwiAqB9
X-Received: by 2002:a9d:705e:: with SMTP id x30mr1392980otj.221.1632350709669;
        Wed, 22 Sep 2021 15:45:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxauNjEloOgS43KwaOum7NgsKLZs/SbMjhtO3+rybjyroY+pJjDvh7BSn/x0DQg1xt7M+tqTw==
X-Received: by 2002:a9d:705e:: with SMTP id x30mr1392942otj.221.1632350709347;
        Wed, 22 Sep 2021 15:45:09 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u27sm899416otj.6.2021.09.22.15.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:45:08 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:45:06 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "lkml@metux.net" <lkml@metux.net>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lushenming@huawei.com" <lushenming@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210922164506.66976218.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB543366158EA87572902EFF5E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-4-yi.l.liu@intel.com>
        <20210921160108.GO327412@nvidia.com>
        <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210922005337.GC327412@nvidia.com>
        <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210922122252.GG327412@nvidia.com>
        <20210922141036.5cd46b2b.alex.williamson@redhat.com>
        <BN9PR11MB543366158EA87572902EFF5E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 22:34:42 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, September 23, 2021 4:11 AM
> > 
> > On Wed, 22 Sep 2021 09:22:52 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:
> > >  
> > > > > Providing an ioctl to bind to a normal VFIO container or group might
> > > > > allow a reasonable fallback in userspace..  
> > > >
> > > > I didn't get this point though. An error in binding already allows the
> > > > user to fall back to the group path. Why do we need introduce another
> > > > ioctl to explicitly bind to container via the nongroup interface?  
> > >
> > > New userspace still needs a fallback path if it hits the 'try and
> > > fail'. Keeping the device FD open and just using a different ioctl to
> > > bind to a container/group FD, which new userspace can then obtain as a
> > > fallback, might be OK.
> > >
> > > Hard to see without going through the qemu parts, so maybe just keep
> > > it in mind  
> > 
> > If we assume that the container/group/device interface is essentially
> > deprecated once we have iommufd, it doesn't make a lot of sense to me
> > to tack on a container/device interface just so userspace can avoid
> > reverting to the fully legacy interface.
> > 
> > But why would we create vfio device interface files at all if they
> > can't work?  I'm not really on board with creating a try-and-fail
> > interface for a mechanism that cannot work for a given device.  The
> > existence of the device interface should indicate that it's supported.
> > Thanks,
> >   
> 
> Now it's a try-and-fail model even for devices which support iommufd.
> Per Jason's suggestion, a device is always opened with a parked fops
> which supports only bind. Binding serves as the contract for handling
> exclusive ownership on a device and switching to normal fops if
> succeed. So the user has to try-and-fail in case multiple threads attempt 
> to open a same device. Device which doesn't support iommufd is not
> different, except binding request 100% fails (due to missing .bind_iommufd
> in kernel driver).

That's a rather important difference.  I don't really see how that's
comparable to the mutually exclusive nature of the legacy vs device
interface.  We're not going to present a vfio device interface for SW
mdevs that can't participate in iommufd, right?  Thanks,

Alex

