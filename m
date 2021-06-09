Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C53A0903
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhFIB3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235074AbhFIB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623202039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGp/0RPvZPb+IOMbTE2NveByUxQDrcE60zp+PyvVOGM=;
        b=I1GrLcRCUJYZ9LBowuAkCjpofXOgzHVFjrAG6kXDWDVSQ002aQeoeFR53S4sJqA5sHnVS+
        Zqdg4tMM/nV5OvmhAcomsTjplI2pgZvm37H1qGeXsgK3kpHqdLkBZxA3OajGmnGaoAjHoJ
        OCMzTiWxjZlv9kxaHK8E81mPl3hZC3k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-2RdVNNHSP6Kc6eWu91Safg-1; Tue, 08 Jun 2021 21:27:17 -0400
X-MC-Unique: 2RdVNNHSP6Kc6eWu91Safg-1
Received: by mail-ot1-f72.google.com with SMTP id t13-20020a0568301e2db02903db6adef049so10495097otr.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 18:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JGp/0RPvZPb+IOMbTE2NveByUxQDrcE60zp+PyvVOGM=;
        b=QKBDV4xGMEYV76ZK4JwgdMXUe+7/k/qwNIU6NCRKBDIRTcmFWRWt42Q+aOW/Yzmwg2
         X/DaB7BHN4QWm7ri+BS9UONMU7SLF6QVseYLRXavN4nETr0fxCUXnRGmr9BGUrN4SxXt
         miif999TmKh9VfNojNuvA4Yi97n/ZO7txJydbNk6nIIFcNeUqrV6+eWhNgHJASMn82kf
         /tyXonsfpui47TIPisZ6c/3RPEJCXcnKbXC3n3zRC3Xudx9ngBXORlzWauBkg0LvhTyN
         mS9RL3/E9Csj+xKwZLpDPdRPRYzRSPfkz7jDBbqRc9Abr1MqIHvpdVioOBtxP5NEJwqi
         Sr+w==
X-Gm-Message-State: AOAM533vMMJl6k4CdXr5mc2JlIHlYTBdmj9V+qgIaxsPgyUWy78eoMo3
        xVL0taZ3LZJwYrDq5x0s+ZN/Csz2RWzh6VEYGJF/XjYaT46e1mMZgc1vKF1yzOKJLKExZU+Qq3M
        1SnHV/IrGRkk6xEYhZtA/p5ZX
X-Received: by 2002:a05:6808:65a:: with SMTP id z26mr2084849oih.85.1623202036847;
        Tue, 08 Jun 2021 18:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQjbYHx9vbf7buJfv0hZjocAAsik2BDyau0SyM9QI17Tm0zs7xe3LgZX3rYmnKU+ZOsJpHxQ==
X-Received: by 2002:a05:6808:65a:: with SMTP id z26mr2084831oih.85.1623202036662;
        Tue, 08 Jun 2021 18:27:16 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id t14sm3189692ooh.39.2021.06.08.18.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:27:16 -0700 (PDT)
Date:   Tue, 8 Jun 2021 19:27:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>, cohuck@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aviadye@nvidia.com, oren@nvidia.com, shahafs@nvidia.com,
        parav@nvidia.com, artemp@nvidia.com, kwankhede@nvidia.com,
        ACurrid@nvidia.com, cjia@nvidia.com, yishaih@nvidia.com,
        kevin.tian@intel.com, hch@infradead.org, targupta@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, liulongfang@huawei.com,
        yan.y.zhao@intel.com
Subject: Re: [PATCH 09/11] PCI: add matching checks for driver_override
 binding
Message-ID: <20210608192711.4956cda2.alex.williamson@redhat.com>
In-Reply-To: <20210608224517.GQ1002214@nvidia.com>
References: <20210603160809.15845-1-mgurtovoy@nvidia.com>
        <20210603160809.15845-10-mgurtovoy@nvidia.com>
        <20210608152643.2d3400c1.alex.williamson@redhat.com>
        <20210608224517.GQ1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 19:45:17 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 08, 2021 at 03:26:43PM -0600, Alex Williamson wrote:
> > > drivers that specifically opt into this feature and the driver now has
> > > the opportunity to provide a proper match table that indicates what HW
> > > it can properly support. vfio-pci continues to support everything.  
> > 
> > In doing so, this also breaks the new_id method for vfio-pci.    
> 
> Does it? How? The driver_override flag is per match entry not for the
> entire device so new_id added things will work the same as before as
> their new match entry's flags will be zero.

Hmm, that might have been a testing issue; combining driverctl with
manual new_id testing might have left a driver_override in place.
 
> > Sorry, with so many userspace regressions, crippling the
> > driver_override interface with an assumption of such a narrow focus,
> > creating a vfio specific match flag, I don't see where this can go.
> > Thanks,  
> 
> On the other hand it overcomes all the objections from the last go
> round: how userspace figures out which driver to use with
> driver_override and integrating the universal driver into the scheme.
> 
> pci_stub could be delt with by marking it for driver_override like
> vfio_pci.

By marking it a "vfio driver override"? :-\

> But driverctl as a general tool working with any module is not really
> addressable.
> 
> Is the only issue the blocking of the arbitary binding? That is not a
> critical peice of this, IIRC

We can't break userspace, which means new_id and driver_override need
to work as they do now.  There are scads of driver binding scripts in
the wild, for vfio-pci and other drivers.  We can't assume such a
narrow scope.  Thanks,

Alex

