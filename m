Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECB3421F90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhJEHo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhJEHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633419755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdh6ajdDzhpIekGGpi0K51OPld4n6Pfnxhu7uKZt4wQ=;
        b=Z3gstj0VNnBLGQFitCieCemRexZh2Qsi5TPeI8Kyj16rB/HxBRGklfm8VDCTgIpPe8JSJ+
        Dx9IzYr87sHPqeZzfFZHvSP5zivmhtJrjofSMcWwR9f1281okIBVRpQM4cbCCT2GkO5YfR
        vPHKWR7uGMlH0V0udniEdHm08UPNw54=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-mOyT2mIENq65YYXo2Kz7DA-1; Tue, 05 Oct 2021 03:42:34 -0400
X-MC-Unique: mOyT2mIENq65YYXo2Kz7DA-1
Received: by mail-ed1-f69.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso5243498edn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hdh6ajdDzhpIekGGpi0K51OPld4n6Pfnxhu7uKZt4wQ=;
        b=P8jqUSS7pH2us3aiSkhGbZcixolnDdJn3B6v6BD3woRWjqhfT0epGl9nFXuLn59s3n
         30MMMV4BwiATYpdFo8InSQ35/cqt9k/iUZTnasMjSYi5+69HlFAdfxXfStu2FbuV0V/M
         7vaPkPrgh/x3OywmOdWWGq4b7s3krwWhKN++XXUn9wKj0R2kWIrFwxOunZCovCRQW/W0
         Ol4CcuA0ak/MSxyGsDp4ruyJBCVyJs07VcEjCy0bzaUDsWqBFbzcgvcMR6GBYVLeVIlZ
         TX3+KdWCmPqZbBEd9Oas/ZAZVknWc741z3Se08VzgJfVE3ztL/zw1vLdli2sXLjkKU+6
         FyBw==
X-Gm-Message-State: AOAM530JV9I9UowvgLpG2YnGPOQMrNj/vbb7pz6GtFjgl8imLFAaRBp6
        /Er19Ugd5JhaFbFKKiIWd+99Y4Aj9sTYUDCYzEf3rE0nDqp+xEyP/GDP4o6EyW8uI9ElacbFj1+
        AxnmIGMSCWrgHLM7stc8zS9nQ
X-Received: by 2002:a50:da8f:: with SMTP id q15mr24812771edj.139.1633419753316;
        Tue, 05 Oct 2021 00:42:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6gJQrrFofN/nnKlla94Bn55mQ1vSe2CTR69P0rD4NoYrvXgQ7h0i+F77LXOMSwecauICbcQ==
X-Received: by 2002:a50:da8f:: with SMTP id q15mr24812754edj.139.1633419753121;
        Tue, 05 Oct 2021 00:42:33 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id q17sm8347882edd.57.2021.10.05.00.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:42:32 -0700 (PDT)
Date:   Tue, 5 Oct 2021 03:42:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 0/9] More virtio hardening
Message-ID: <20211005032924-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> Hi All:
> 
> This series treis to do more hardening for virito.
> 
> patch 1 validates the num_queues for virio-blk device.
> patch 2-4 validates max_nr_ports for virito-console device.
> patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> interrupt handler is tiggered. If this makes sense we can do similar
> things in other transport drivers.
> patch 8-9 validate used ring length.
> 
> Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> 
> Please review.
> 
> Thanks

So I poked at console at least, and I think I see
an issue: if interrupt handler queues a work/bh,
then it can still run while reset is in progress.

I sent a patch to fix it for console removal specifically,
but I suspect it's not enough e.g. freeze is still broken.
And note this has been reported without any TDX things -
it's not a malicious device issue, can be triggered just
by module unload.

I am vaguely thinking about new APIs to disable/enable callbacks.
An alternative:

1. adding new remove_nocb/freeze_nocb calls
2. disabling/enabling interrupts automatically around these
3. gradually moving devices to using these
4. once/if all device move, removing the old callbacks

the advantage here is that we'll be sure calls are always
paired correctly.





> Jason Wang (9):
>   virtio-blk: validate num_queues during probe
>   virtio: add doc for validate() method
>   virtio-console: switch to use .validate()
>   virtio_console: validate max_nr_ports before trying to use it
>   virtio_config: introduce a new ready method
>   virtio_pci: harden MSI-X interrupts
>   virtio-pci: harden INTX interrupts
>   virtio_ring: fix typos in vring_desc_extra
>   virtio_ring: validate used buffer length
> 
>  drivers/block/virtio_blk.c         |  3 +-
>  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
>  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
>  drivers/virtio/virtio_pci_common.h |  7 ++--
>  drivers/virtio/virtio_pci_legacy.c |  5 +--
>  drivers/virtio/virtio_pci_modern.c |  6 ++--
>  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
>  include/linux/virtio.h             |  1 +
>  include/linux/virtio_config.h      |  6 ++++
>  9 files changed, 118 insertions(+), 31 deletions(-)
> 
> -- 
> 2.25.1

