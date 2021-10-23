Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B7D43858C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 23:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhJWVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 17:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhJWVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 17:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635024691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvbR/cosDB5PzrAtt66M/Vg3Eshkd4GIz0r0Njwdz8U=;
        b=VuFPmF+oeQ5le9gPFdz5Ba+NCL8otqFQkAZb74+GibhI9x5SKwKeHRmLZ8aE6UO42ImJSw
        5dVS7gFLjA/hUAhRqQxeabS9CnSUpq7YjGpVBpDZry0ppwvUKdu+uMJsiIWtVBdeM5QvwQ
        HzIzIKWdLK34zGHFSpfZDXyXAPCtxkM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-J5_6sLQwPpuoPF_1PM-wOw-1; Sat, 23 Oct 2021 17:31:30 -0400
X-MC-Unique: J5_6sLQwPpuoPF_1PM-wOw-1
Received: by mail-wm1-f71.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso2615235wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 14:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvbR/cosDB5PzrAtt66M/Vg3Eshkd4GIz0r0Njwdz8U=;
        b=oWnootSFIQRs+nbME/BrVNxekP7nNRXBqssuasixsUBTBs3VhEti+gBuUydfBlnqS5
         gpy8hG3ClMCZKcd3ql5xv+dA3C2/RaynAMuZzZTmNTSYQEfLr5KUAEHA/nLZD7OTCKrp
         JWUDePKa6iEezYzhJbIBBPxh93SzTUkwgN4NHUM9B7F6vrmTBhOUYysxjoPtSHMekZMW
         z1sifKOQ7FL6eBadUWUVDHlsoFXVNcNJ8R1ETSyRYd2eAGd7ho+5PlZTJSsYf/JfNh+Z
         Hrl6P4QxV8WlYT6kOF+TmVkfQFjYvGkqSHyegZ6DE+RjSFmcGaIU0NM0sQ+fA7XajDBv
         jVRA==
X-Gm-Message-State: AOAM531sCXfbfQOmiegSkWHFvHEyzL9cGHh/yUmrweO+D2B6y/AgJaIr
        0ymIfjzUM1oEXlcp8apQZTudf53vQWIUzewL47vhSfPLbVo4qIfiOwYZ9XRtYM803jRxD3urYBc
        ygfwD3v2Wckn1OgWjAjYlyPSL
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr10114802wri.40.1635024689031;
        Sat, 23 Oct 2021 14:31:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1y608WZP9aSEm5XfV1q3IHejO+vI46FGmfXRmW672lUt8njZVZ9QYtKy9AW221jJLoqdo5w==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr10114785wri.40.1635024688881;
        Sat, 23 Oct 2021 14:31:28 -0700 (PDT)
Received: from redhat.com ([2.55.9.147])
        by smtp.gmail.com with ESMTPSA id c15sm11597358wrs.19.2021.10.23.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 14:31:27 -0700 (PDT)
Date:   Sat, 23 Oct 2021 17:31:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH V3 00/10] More virtio hardening
Message-ID: <20211023171627-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:01:42PM +0800, Jason Wang wrote:
> Hi All:
> 
> This series treis to do more hardening for virito.

OK. So patches 7-10 caused a crash in virtio-blk.
I'm close to sure it's patch 10 actually, and forcing
validation seems to fix the crash.
I also suspect it has something to do with the fact that
blk submits requests in the middle of the probe function.

picked up 1-6 for now.


> patch 1 validates the num_queues for virio-blk device.
> patch 2 validates max_nr_ports for virito-console device.
> patch 3-5 harden virtio-pci interrupts to make sure no exepcted
> interrupt handler is tiggered. If this makes sense we can do similar
> things in other transport drivers.
> patch 6-7 validate used ring length.
> patch 8-10 let the driver to validate the used length instead of the
> virtio core when possible.
> 
> Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> 
> Please review.
> 
> Changes since V2:
> - don't validate max_nr_ports in .validate()
> - fail the probe instead of trying to work when blk/console returns
>   invalid number of queues/ports
> - use READ_ONCE() instead of smp_load_acquire() for checking
>   intx_soft_enabled
> - use "suppress_used_validation" instead of "validate_used"
> 
> Changes since V1:
> - fix and document the memory ordering around the intx_soft_enabled
>   when enabling and disabling INTX interrupt
> - for the driver that can validate the used length, virtio core
>   won't even try to allocate auxilary arrays and validate the used length
> - tweak the commit log
> - fix typos
> 
> Jason Wang (10):
>   virtio-blk: validate num_queues during probe
>   virtio_console: validate max_nr_ports before trying to use it
>   virtio_config: introduce a new .enable_cbs method
>   virtio_pci: harden MSI-X interrupts
>   virtio-pci: harden INTX interrupts
>   virtio_ring: fix typos in vring_desc_extra
>   virtio_ring: validate used buffer length
>   virtio-net: don't let virtio core to validate used length
>   virtio-blk: don't let virtio core to validate used length
>   virtio-scsi: don't let virtio core to validate used buffer length
> 
>  drivers/block/virtio_blk.c         |  5 +++
>  drivers/char/virtio_console.c      |  9 +++++
>  drivers/net/virtio_net.c           |  1 +
>  drivers/scsi/virtio_scsi.c         |  1 +
>  drivers/virtio/virtio_pci_common.c | 48 ++++++++++++++++++++----
>  drivers/virtio/virtio_pci_common.h |  7 +++-
>  drivers/virtio/virtio_pci_legacy.c |  5 ++-
>  drivers/virtio/virtio_pci_modern.c |  6 ++-
>  drivers/virtio/virtio_ring.c       | 60 +++++++++++++++++++++++++++++-
>  include/linux/virtio.h             |  2 +
>  include/linux/virtio_config.h      |  6 +++
>  11 files changed, 135 insertions(+), 15 deletions(-)
> 
> -- 
> 2.25.1

