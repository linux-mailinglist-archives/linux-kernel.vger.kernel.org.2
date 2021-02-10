Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E94E3166E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhBJMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231773AbhBJMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612960512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9BSzyb2e+6npXvlQKaKsVtbO2RXid50XjjwcfxjJRE=;
        b=BmHn/CruB6Hdy7RURZ/fqy5AEQAXvK1uvo5s2o/ZvTeshmldmt16D0ZkZDPKf3PAEPX0RC
        GoyJBpxKxax3WshYuAQv8xDUgFt2NxUh6SoOC3qIyi+ZNfRYzJH8hROmFLPNrfxMmhjVV+
        DPpcecmBIDQrZSQhJaCdDvFJiifi/jE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-kw42BTlFN8eDbrW7OD9U9w-1; Wed, 10 Feb 2021 07:35:08 -0500
X-MC-Unique: kw42BTlFN8eDbrW7OD9U9w-1
Received: by mail-wr1-f71.google.com with SMTP id d7so1734990wri.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r9BSzyb2e+6npXvlQKaKsVtbO2RXid50XjjwcfxjJRE=;
        b=UXdRVIQj9Pj0LjPKwu/2moo8LCKdDyEZO0d0Bo4HbPwckmMYrWEa5SCaYNaNA/uy3q
         duj4hbfcMfdiswa9PXKEiR8emjTisrjBh9GVphKL/J5E9avW7h1wARARAoKLLRNKwDb7
         Y0A6Mqk+QgB/lmuo3b6YOYh6pNlFtrsuFLnD8uGNd1N9hzSwQuF+yOWR2vtf7npjsgdW
         r9JR3ybt871+SrIc9G5InbjM/CO8tOFEwEDLGs58CfmvfPm9FYKdzp+Q1yV5B0muwzI4
         MaxZgzlsAtWi6kAl18tSGnWYSI2JWG3lDpvL8ltU6QM7WgrzhWuQpjYdrNhIEyolJkLv
         fzAQ==
X-Gm-Message-State: AOAM531muxL6yHIMSuPXdAecrmp3PEDxNOipYPpRTK5atMLbnUmy3t6N
        IfTdPOdGSRG5DDkRbi9AetyyacgkyrtZ2K9csBh9zeKrJA7guIrlpTxIq6EWBvQHlZST6f3bBzE
        jemAMcY+suBDnYth22Yhdh8Kr
X-Received: by 2002:adf:d852:: with SMTP id k18mr3485070wrl.262.1612960507773;
        Wed, 10 Feb 2021 04:35:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkbUgr0QieZfImnKg2Mg3kQ6hfRq4PRP6E/bJ3CbrAeTM6nxJpHt1GPBO96hNlreeAnnVNMA==
X-Received: by 2002:adf:d852:: with SMTP id k18mr3485058wrl.262.1612960507639;
        Wed, 10 Feb 2021 04:35:07 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id f2sm2856130wrt.7.2021.02.10.04.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:35:06 -0800 (PST)
Date:   Wed, 10 Feb 2021 07:35:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210210073404-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210209091916-mutt-send-email-mst@kernel.org>
 <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:44:03PM +0800, Jason Wang wrote:
> 
> On 2021/2/9 下午10:20, Michael S. Tsirkin wrote:
> > On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   drivers/virtio/Kconfig                 |  10 +-
> > >   drivers/virtio/Makefile                |   1 +
> > >   drivers/virtio/virtio_pci_common.h     |  27 +-
> > >   drivers/virtio/virtio_pci_modern.c     | 617 -------------------------
> > >   drivers/virtio/virtio_pci_modern_dev.c | 599 ++++++++++++++++++++++++
> > >   include/linux/virtio_pci_modern.h      | 111 +++++
> > >   6 files changed, 721 insertions(+), 644 deletions(-)
> > >   create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
> > >   create mode 100644 include/linux/virtio_pci_modern.h
> > > 
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index 7b41130d3f35..6b9b81f4b8c2 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> > >   	  This option is selected if the architecture may need to enforce
> > >   	  VIRTIO_F_ACCESS_PLATFORM
> > > +config VIRTIO_PCI_MODERN
> > > +	tristate "Modern Virtio PCI Device"
> > > +	depends on PCI
> > > +	help
> > > +	  Modern PCI device implementation. This module implements the
> > > +	  basic probe and control for devices which are based on modern
> > > +	  PCI device with possible vendor specific extensions.
> > > +
> > >   menuconfig VIRTIO_MENU
> > >   	bool "Virtio drivers"
> > >   	default y
> > > @@ -20,7 +28,7 @@ if VIRTIO_MENU
> > >   config VIRTIO_PCI
> > >   	tristate "PCI driver for virtio devices"
> > > -	depends on PCI
> > > +	depends on VIRTIO_PCI_MODERN
> > >   	select VIRTIO
> > >   	help
> > >   	  This driver provides support for virtio based paravirtual device
> > Looks like VIRTIO_PCI_MODERN is actually just a library that
> > virtio pci uses. Is that right?
> 
> 
> Right.
> 
> 
> > In that case just select it
> > automatically, let's not make users enable it manually.
> 
> 
> I've considered to do this but the problem is that the module depends on PCI
> so it can't be selected I think.

Drop the dependency, document that whoever selects it must depend on PCI.

> Thanks
> 
> 
> > 

