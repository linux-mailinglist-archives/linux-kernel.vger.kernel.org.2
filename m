Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0F415132
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhIVUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237286AbhIVUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632341441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVDSHQbpVe8JTY8isblrL8p142CPVwt8+X+MPr7eWPw=;
        b=a233ldhimVDIrls1bZs8+PfFFGWYCGNYZ4CfC0NXQcJty1QiPd0vpUzgKEnlG8O0mA/qEX
        FvtMxNi3GoN+USyDGNIEwOjzpQ8uEkLtFYkVLucsV7feU+sEEL2I8+RutpvS4r30nUg5m8
        eNG9RVvSPK7DTCvoozKZB988UmRE2Ro=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-nQ4uj1kQNlO_jWtyYdQVcw-1; Wed, 22 Sep 2021 16:10:40 -0400
X-MC-Unique: nQ4uj1kQNlO_jWtyYdQVcw-1
Received: by mail-ot1-f70.google.com with SMTP id 8-20020a9d0588000000b0051defe13038so1778941otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LVDSHQbpVe8JTY8isblrL8p142CPVwt8+X+MPr7eWPw=;
        b=U6tw0yrBH7zlbRFQ7j6RcsMhJcAPW4fG+vtYGpFzott7wZSdexWAaSBZerLEH7Bka1
         bUv7p6ZtEeQKzVgJ4B94AwVhHx0SNhXyjd6QInChFn7DrDniRUpV+mGK5opGBJ/nRQqu
         Gc0hfCQSHR274tOSHwm0ag5p/k2/UFJYGHh5CcG8TsOW4R72OjMmPbEkaVCy6wD1sDIe
         3IqMbpkTRWQzHi9QchgMS18ayJ/8/ZTSWKKFchjf8zzhU3FLdOAyQunSbgEPBp+NC5Ie
         vdSFk4+C+rJ5LPB2WwmmmYd+5VTjjf5naT6y5pzUZRmlBpQrsuUg0nR3rSTWDpRJFTch
         aZFA==
X-Gm-Message-State: AOAM5330V/IZ7qn2vUx/9oQGXgn81JMWsXydOnX7ZbPWuA5WrW6cUmBH
        q54hGnJA4yAUc/uNF1F3AFw7GJqIRJU/a6HkuZre34bNIyyPQ2HW2/y61oZ8Y7T5FxL/VtUUH66
        caF+Sx6pBtIiZpnN60ynnRLgx
X-Received: by 2002:aca:5f09:: with SMTP id t9mr785734oib.157.1632341439233;
        Wed, 22 Sep 2021 13:10:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsexkS3ssuL6wF9vSWKPex4M0QKWRz+hAFF7uOcJjumY+ZptpBRjRLEImjoapaxD27rGKTYw==
X-Received: by 2002:aca:5f09:: with SMTP id t9mr785712oib.157.1632341438954;
        Wed, 22 Sep 2021 13:10:38 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id a15sm720852otq.13.2021.09.22.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:10:38 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:10:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20210922141036.5cd46b2b.alex.williamson@redhat.com>
In-Reply-To: <20210922122252.GG327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-4-yi.l.liu@intel.com>
        <20210921160108.GO327412@nvidia.com>
        <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210922005337.GC327412@nvidia.com>
        <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
        <20210922122252.GG327412@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 09:22:52 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:
> 
> > > Providing an ioctl to bind to a normal VFIO container or group might
> > > allow a reasonable fallback in userspace..  
> > 
> > I didn't get this point though. An error in binding already allows the
> > user to fall back to the group path. Why do we need introduce another
> > ioctl to explicitly bind to container via the nongroup interface?   
> 
> New userspace still needs a fallback path if it hits the 'try and
> fail'. Keeping the device FD open and just using a different ioctl to
> bind to a container/group FD, which new userspace can then obtain as a
> fallback, might be OK.
> 
> Hard to see without going through the qemu parts, so maybe just keep
> it in mind

If we assume that the container/group/device interface is essentially
deprecated once we have iommufd, it doesn't make a lot of sense to me
to tack on a container/device interface just so userspace can avoid
reverting to the fully legacy interface.

But why would we create vfio device interface files at all if they
can't work?  I'm not really on board with creating a try-and-fail
interface for a mechanism that cannot work for a given device.  The
existence of the device interface should indicate that it's supported.
Thanks,

Alex

