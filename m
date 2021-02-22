Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68EF321166
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBVHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhBVHap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613978957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s4sMHD6GbS6u/vJyEHvXYgmlyz7YMmLRul3YJcd4zs=;
        b=hsOj/cE/sYm0IH7jM5R8pn4d1XCdgEqW002P371yi8dyLzEUdet/stRtleyxbRziI2Syhl
        UiMp1YR6Cprv8mdbexPgJdAGTGdZL53x2JEPyoIA7ywmsPMfpQibuynZXPJbBe204shztv
        NpkRduwURIH5SR3Ks5yW30TAhzeZMWQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-a65usm4bOGOv7i9uY4fBlA-1; Mon, 22 Feb 2021 02:29:15 -0500
X-MC-Unique: a65usm4bOGOv7i9uY4fBlA-1
Received: by mail-ed1-f71.google.com with SMTP id j10so6517761edv.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0s4sMHD6GbS6u/vJyEHvXYgmlyz7YMmLRul3YJcd4zs=;
        b=TET6F62gncm7LjYWfNumnrMlxaWpz05X8f0URD2UJInWkstZgD/bt08c0F7xGl/vYZ
         CLLYfD1Asu46FYOYji/+HW8wyNJrK5LccyQOmQ9lMC8xQsvWEK/PySw9V+xWImfwNZtj
         067TzHygRbma5Wp3nvIUpUlOtDHXY33BGUvMMYOolWNmA47iyYdwG3TXqc9w/IdVhwzC
         KsjuGkmK+zJzdTNMZhiKK0n/6rcJJCUD0Cl2ACi8Vlm7tjn7h5D3G/UkOlnIMYDzOYst
         A/f5Pr0JS+ELn/TrVdCY3Gvu1xigoxBogloKv2kN+vST+/p0eqHGMB/tMr16QfVrjKVk
         PQag==
X-Gm-Message-State: AOAM530g1Fej8zdhv9jvzls2mMQE7QL0O2ewkIBzyUNT40Y8zslA/gPl
        biKpsXAlosyMwBEIc7W8xGZfz2xPO34eQft067N50Kqz90uwz+GTZje1nQzSWaEAoVRggi1DnLY
        XxAXfQqSPAGl4gcmAUaLL7h91
X-Received: by 2002:a17:906:1613:: with SMTP id m19mr19976797ejd.344.1613978954361;
        Sun, 21 Feb 2021 23:29:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfM0dRzz9C2jb+fvVq1S2GC9IwCom3WEozaNsTcncE9JSQrHy/5uaT8Ak1rak1OAJuroVkag==
X-Received: by 2002:a17:906:1613:: with SMTP id m19mr19976790ejd.344.1613978954254;
        Sun, 21 Feb 2021 23:29:14 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id r1sm10881273eds.70.2021.02.21.23.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 23:29:13 -0800 (PST)
Date:   Mon, 22 Feb 2021 02:29:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Message-ID: <20210222022550-mutt-send-email-mst@kernel.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
 <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:42:44AM +0800, Jason Wang wrote:
> 
> On 2021/2/19 11:38 下午, Guenter Roeck wrote:
> > On 2/19/21 12:45 AM, Jason Wang wrote:
> > > We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> > > lot of confusion. E.g it may break various default configs which want
> > > virtio devices.
> > > 
> > > So this patch fixes this by hide the prompot and document the
> > ... by hiding the prompt and documenting ...
> 
> 
> Hi Michael:
> 
> Would you like me to post a new version or you can fix those typos when
> applying the patch?
> 
> Thanks


A new version. However I have a suggestion.

How about we call the new library VIRTIO_PCI_LIB? That would be
a new auto-selected symbol.

We can then keep VIRTIO_PCI as a symbol enabling the actual driver.



> 
> > 
> > > dependency.
> > > 
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Anders Roxell <anders.roxell@linaro.org>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > > ---
> > >   drivers/virtio/Kconfig | 9 +++++----
> > >   1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index 6b9b81f4b8c2..be7df369bc2b 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -13,12 +13,12 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> > >   	  VIRTIO_F_ACCESS_PLATFORM
> > >   config VIRTIO_PCI_MODERN
> > > -	tristate "Modern Virtio PCI Device"
> > > -	depends on PCI
> > > +	tristate
> > >   	help
> > >   	  Modern PCI device implementation. This module implements the
> > >   	  basic probe and control for devices which are based on modern
> > > -	  PCI device with possible vendor specific extensions.
> > > +	  PCI device with possible vendor specific extensions. Any
> > > +	  module that selects this module must depend on PCI.
> > >   menuconfig VIRTIO_MENU
> > >   	bool "Virtio drivers"
> > > @@ -28,7 +28,8 @@ if VIRTIO_MENU
> > >   config VIRTIO_PCI
> > >   	tristate "PCI driver for virtio devices"
> > > -	depends on VIRTIO_PCI_MODERN
> > > +	depends on PCI
> > > +	select VIRTIO_PCI_MODERN
> > >   	select VIRTIO
> > >   	help
> > >   	  This driver provides support for virtio based paravirtual device
> > > 

