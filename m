Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD941CC48
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbhI2THI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244887AbhI2THH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632942325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85NOeq9kRcTFRqNT/gP4PrOFWq1cbQJO0LsYgy0Arqs=;
        b=Hm2HGl/9kWRnGkFEFQbmXmy/Etsd+FpVD7+K6PrAJlqaruG/OVZXCC9H8q+JRY7dJaURKw
        mm9931Ck5zRMn1GzBNRmbd7seuSLIRiqYgpc6N318zBZyHCo/msTvAdwatHCs1IJ7w1IPC
        meHKIZyi9hqXWQWt8hYMYaCs53qUVtU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-lZ0_XGNbPdW1C0K9pS3dgQ-1; Wed, 29 Sep 2021 15:05:24 -0400
X-MC-Unique: lZ0_XGNbPdW1C0K9pS3dgQ-1
Received: by mail-oi1-f199.google.com with SMTP id y5-20020aca3205000000b0027644481fe7so2551705oiy.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85NOeq9kRcTFRqNT/gP4PrOFWq1cbQJO0LsYgy0Arqs=;
        b=5TvAVwdN/VyHks1Yw3f5yXKKxgwTXObmhFut6BumpYeCFKWydVoKUDF7IxJKZkLwIq
         C5WWEXARKavYQn6NzYSsIiW/H1TKjS7rkkzjIC1MscPPkS9dy+aUSrShD41JZ6q29UEb
         sT7USkJ6XKIQTEHHppde6maFU6xOuL7VtUclIeq7CIzrwDY+I2UuMCDyc47UKxivCsVY
         PsEtMWMsnc6bjuzO7QhNDGpz/XYw6/4mv8tNzE7Ns28+PSx8eVjobIvvt//dF/jAJBNg
         pLRiMy9rGe+FMQmkxwt9+fGEaSaIS0RxwKimHwHem4IXNsMDgeGzFQbcda9hSL7gDafH
         7RQQ==
X-Gm-Message-State: AOAM532kDrX8HysBD2PEVBdauCaIavrAwtNc+YKbdmvbWXrA7bObTlcA
        9bQQITc/8NH6LZJQ2Vmd/CzuTJRzw9WYoR1fDgQHcy2p328lc0pDapouUOpEIyjYLHC9iMJq8e6
        d4OywFGsITXZUoNi4zPdV7u0s
X-Received: by 2002:a9d:4705:: with SMTP id a5mr1401103otf.237.1632942323858;
        Wed, 29 Sep 2021 12:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+KGp/sh/UihDrTdyYD4Z3RDCBe5RWKG52xsBpGNBpcqEB4R141NFhp0vsmLjZ8H3+PuwzlA==
X-Received: by 2002:a9d:4705:: with SMTP id a5mr1401070otf.237.1632942323621;
        Wed, 29 Sep 2021 12:05:23 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id p9sm111523ots.66.2021.09.29.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:05:23 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:05:21 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Liu Yi L <yi.l.liu@intel.com>, jgg@nvidia.com, hch@lst.de,
        jasowang@redhat.com, joro@8bytes.org, jean-philippe@linaro.org,
        kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
        pbonzini@redhat.com, lushenming@huawei.com, eric.auger@redhat.com,
        corbet@lwn.net, ashok.raj@intel.com, yi.l.liu@linux.intel.com,
        jun.j.tian@intel.com, hao.wu@intel.com, dave.jiang@intel.com,
        jacob.jun.pan@linux.intel.com, kwankhede@nvidia.com,
        robin.murphy@arm.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        nicolinc@nvidia.com
Subject: Re: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Message-ID: <20210929130521.738c56ed.alex.williamson@redhat.com>
In-Reply-To: <YVPKu/F3IpPMtGCh@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-3-yi.l.liu@intel.com>
        <YVPKu/F3IpPMtGCh@yekko>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 12:08:59 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Sun, Sep 19, 2021 at 02:38:30PM +0800, Liu Yi L wrote:
> > This patch introduces a new interface (/dev/vfio/devices/$DEVICE) for
> > userspace to directly open a vfio device w/o relying on container/group
> > (/dev/vfio/$GROUP). Anything related to group is now hidden behind
> > iommufd (more specifically in iommu core by this RFC) in a device-centric
> > manner.
> > 
> > In case a device is exposed in both legacy and new interfaces (see next
> > patch for how to decide it), this patch also ensures that when the device
> > is already opened via one interface then the other one must be blocked.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>  
> [snip]
> 
> > +static bool vfio_device_in_container(struct vfio_device *device)
> > +{
> > +	return !!(device->group && device->group->container);  
> 
> You don't need !! here.  && is already a logical operation, so returns
> a valid bool.
> 
> > +}
> > +
> >  static int vfio_device_fops_release(struct inode *inode, struct file *filep)
> >  {
> >  	struct vfio_device *device = filep->private_data;
> > @@ -1560,7 +1691,16 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
> >  
> >  	module_put(device->dev->driver->owner);
> >  
> > -	vfio_group_try_dissolve_container(device->group);
> > +	if (vfio_device_in_container(device)) {
> > +		vfio_group_try_dissolve_container(device->group);
> > +	} else {
> > +		atomic_dec(&device->opened);
> > +		if (device->group) {
> > +			mutex_lock(&device->group->opened_lock);
> > +			device->group->opened--;
> > +			mutex_unlock(&device->group->opened_lock);
> > +		}
> > +	}
> >  
> >  	vfio_device_put(device);
> >  
> > @@ -1613,6 +1753,7 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
> >  
> >  static const struct file_operations vfio_device_fops = {
> >  	.owner		= THIS_MODULE,
> > +	.open		= vfio_device_fops_open,
> >  	.release	= vfio_device_fops_release,
> >  	.read		= vfio_device_fops_read,
> >  	.write		= vfio_device_fops_write,
> > @@ -2295,6 +2436,52 @@ static struct miscdevice vfio_dev = {
> >  	.mode = S_IRUGO | S_IWUGO,
> >  };
> >  
> > +static char *vfio_device_devnode(struct device *dev, umode_t *mode)
> > +{
> > +	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));  
> 
> Others have pointed out some problems with the use of dev_name()
> here.  I'll add that I think you'll make things much easier if instead
> of using one huge "devices" subdir, you use a separate subdir for each
> vfio sub-driver (so, one for PCI, one for each type of mdev, one for
> platform, etc.).  That should make avoiding name conflicts a lot simpler.

It seems like this is unnecessary if we use the vfioX naming approach.
Conflicts are trivial to ignore if we don't involve dev_name() and
looking for the correct major:minor chardev in the correct subdirectory
seems like a hassle for userspace.  Thanks,

Alex

