Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551D437492B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhEEUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEEUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:15:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:14:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j17so2250605qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+jjeEQF3xaIPQlwhGWprqXCtf+a5GVL9PJ3c+CmBaaI=;
        b=Qj+hddOVEJnmo8hg7lgul4xcuG8RVdY0sWqOcNQZXzyeM/cFHlKLF+St1c3GXu3Jlp
         bWrR6LHfXkeRSrjuLsJWjzCXjuyU28WFotCpvt/rCatCZiM3VkyKsv8K49VncT4wZAle
         oC5IQ9qX2YsFsyJ4Sn+HAbILLfHQmYfmJnftMTY0uNQ6ececzYMncPApRzv8WW2ykGqM
         qbdl15s0lfuQQbl8eu7wLqHOsAv3SCSMWnvjhtEFcnl3WCxjvn3idBino7bUksb7ghlf
         wZYeKLR3mKeNaEMXUFthyZdtUI6pgZAjBg83XlXIQqJKUtkgstXasgUpiFQmVRuSpWuz
         xaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jjeEQF3xaIPQlwhGWprqXCtf+a5GVL9PJ3c+CmBaaI=;
        b=bSXq71Qzh+G2h0WvOcCmIb3iKg8VppEqdBv8aSJO8PFfKZ0Yv35B6pJZwpIs4AOrS1
         aq+6HBLLB1vLgdMYoK+atYEFypDxkCCl4WKIBTDi5vpSHs8W1IBev4FNby7mhXwRDiRD
         qVRq0lA0OfiPCNHowvxnpdiuZnjl2W/FPpKCrzua41F+ee/7L879BDD9D8e84ZJ+PbZA
         5xwk6kxpQQbDRNHYBnucW/zpDUmm2M8LWtC7RMj1SbyAkYRgbyfEOhVFQ/LtA1RMhdVY
         kmcZHuklOayTwqfsVsSJTLGnuPKqSjRrk8D2mlGXRq/exCMQK9ThBkwK3YyrYMyYgz0P
         yASQ==
X-Gm-Message-State: AOAM532FgiU1m7Fqr3u6flP8xLBhS12kijPckfy4c75znTWY58CDtvim
        Ltca9PCbuicSru9nsrwkYL2ZKQ==
X-Google-Smtp-Source: ABdhPJxyWdI1pj+uGPYyfER/3770N6GgOO+jx6uMeY9S22MRCSdg7XkAQOkgs3N30CG2ijFfwIUEFQ==
X-Received: by 2002:ac8:5d93:: with SMTP id d19mr376380qtx.334.1620245682881;
        Wed, 05 May 2021 13:14:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id z4sm270458qtq.34.2021.05.05.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:14:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1leNur-001Xna-Hk; Wed, 05 May 2021 17:14:41 -0300
Date:   Wed, 5 May 2021 17:14:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <20210505201441.GD2047089@ziepe.ca>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
 <YIgfbZDo9eQ2tKvc@kroah.com>
 <20210427161235.GB1370958@nvidia.com>
 <YIlTzGLpbRj3rh/R@kroah.com>
 <20210428130044.GQ1370958@nvidia.com>
 <YIq24bDyB49QJm0S@kroah.com>
 <20210503183051.GO1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503183051.GO1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 03:30:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 29, 2021 at 03:38:41PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 28, 2021 at 10:00:44AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 28, 2021 at 02:23:40PM +0200, Greg Kroah-Hartman wrote:
> > > 
> > > > > We've talked about this specifically before:
> > > > > 
> > > > > http://lore.kernel.org/r/20210331170720.GY2710221@ziepe.ca
> > > > > 
> > > > > I still don't understand what you mean by "udev sees it properly", as
> > > > > above, all the tests I thought of look OK.
> > > > 
> > > > Can you query the udev database to see the attribute values?
> > > 
> > > It appears so unless I misunderstand your ask:
> > > 
> > > $ udevadm info -a /sys/class/infiniband/ibp0s9
> > >     ATTR{ports/1/cm_rx_duplicates/dreq}=="0"
> > 
> > That works?  Nice, I didn't think it did.
> > 
> > But what about the uevent that fired for "1", isn't there attibutes
> > assigned to it that udev ignores?
> 
> I'm not completely familiar with uevents, but:
> 
> $ find /sys/class/infiniband/ibp0s9/ -name "uevent"
> /sys/class/infiniband/ibp0s9/uevent
> 
> $ udevadm monitor & modprobe mlx5_ib
> KERNEL[169.337295] add      /bus/auxiliary/drivers/mlx5_ib.multiport (drivers)
> UDEV  [169.354621] add      /bus/auxiliary/drivers/mlx5_ib.multiport (drivers)
> KERNEL[169.393088] add      /devices/pci0000:00/0000:00:09.0/infiniband_verbs/uverbs0 (infiniband_verbs)
> KERNEL[169.393516] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/umad0 (infiniband_mad)
> KERNEL[169.394040] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/issm0 (infiniband_mad)
> UDEV  [169.395189] add      /devices/pci0000:00/0000:00:09.0/infiniband_verbs/uverbs0 (infiniband_verbs)
> UDEV  [169.397812] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/issm0 (infiniband_mad)
> KERNEL[169.407727] add      /devices/pci0000:00/0000:00:09.0/net/ib0 (net)
> KERNEL[169.407851] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/rx-0 (queues)
> KERNEL[169.408113] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/tx-0 (queues)
> KERNEL[169.409059] add      /devices/pci0000:00/0000:00:09.0/infiniband/mlx5_0 (infiniband)
> KERNEL[169.411483] bind     /devices/pci0000:00/0000:00:09.0/mlx5_core.rdma.0 (auxiliary)
> KERNEL[169.411836] add      /bus/auxiliary/drivers/mlx5_ib.rdma (drivers)
> KERNEL[169.411973] add      /module/mlx5_ib (module)
> UDEV  [169.420570] bind     /devices/pci0000:00/0000:00:09.0/mlx5_core.rdma.0 (auxiliary)
> UDEV  [169.421365] add      /bus/auxiliary/drivers/mlx5_ib.rdma (drivers)
> UDEV  [169.447853] add      /module/mlx5_ib (module)
> KERNEL[169.482293] move     /devices/pci0000:00/0000:00:09.0/infiniband/ibp0s9 (infiniband)
> UDEV  [169.486395] add      /devices/pci0000:00/0000:00:09.0/infiniband/mlx5_0 (infiniband)
> UDEV  [169.495193] move     /devices/pci0000:00/0000:00:09.0/infiniband/ibp0s9 (infiniband)
> UDEV  [169.698592] add      /devices/pci0000:00/0000:00:09.0/net/ib0 (net)
> UDEV  [169.700436] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/rx-0 (queues)
> UDEV  [169.700712] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/tx-0 (queues)
> UDEV  [170.042132] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/umad0 (infiniband_mad)
> 
> I don't see any uevents related to the nested attributes. Same on
> removal.

With some debugging, the uevent situation is like this..

When '1' is created as a kobj the code does call

		kobject_uevent(&port->kobj, KOBJ_ADD);

However DEBUG_KOBJECT reveals:

 kobject: '1' (00000000d2367083): kobject_uevent_env: filter function caused the event to drop!

Which happens because 
  top_kobj == mlx5 (ie the struct device)
  top_kobj->kset->uevent_ops == device_uevent_ops
  get_ktype(kobj "1") == &port_type 

Thus calling
  dev_uevent_filter(mlx5 kset, kobj "1") == 0

As get_ktype(kobj "1") != &device_ktype

Which I read to mean these nested attributes under a struct device
won't generate a uevent.

The uevent for the struct device is supressed until all the child
kobjects are created and this explains how udev sees the child kobj's
and doesn't see extra uevents to confuse it.

Jason
