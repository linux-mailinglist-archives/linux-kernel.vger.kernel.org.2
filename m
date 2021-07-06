Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1B3BC806
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGFInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhGFInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:43:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4137EC061760
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:40:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n9so7735062wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JLlTuAeFJ55bKl70feqPAdDJNogiM+fpe/R9P7DcSms=;
        b=LRnsqjRbV1SjBgROJlBIakdBOYICsTI8ulzfPsgIQuMlSJ8mh2dRGC7U1wsehHvWvI
         IyKsCEPEE7aj2cDyk/ASRk28e+xTY39qV9bf/70BQD/NFfB3eA0zVAekYrESOuCPHLQL
         fqnRDhDxHDjGgI1GsURpOfaynvOOqUO2t/nUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JLlTuAeFJ55bKl70feqPAdDJNogiM+fpe/R9P7DcSms=;
        b=h5rBUH6CAKjrRUMWkPWY1S1sZAcmB2QjT6SXBQojw+ECZko2hQ1Or/lCnbmPNE+Qt3
         fIJBkXNNX8dwJgThHNvRf/1aR8CiBMxj5q5YPalcQzUZ2ZKvi/jTBUOqEcJYygHxzFjz
         yuER9w8PA0x947u3vAv0fef+Kg+Gm4qOZtFCJlaJw6P/wK1QAs7Qv1BjLAANxCLGFnay
         sPF5b59h39Hm03SH11xTXTlNNF4ZIDFgjFzm0Qkuyw9YaM+pH+w1uZ6r47tGfG1WLNpe
         8r8RUVINbDmgtzgbIaHUXHoXDn0Ke42ekNB1or7rO1Al5S/zj9dBurMfrzJqaRd+OK21
         eO2Q==
X-Gm-Message-State: AOAM530qG5Hjni7evR2LJLg9QLGuF74HzytDOQtriGUGdL4wcnwde0HF
        JzqLqOsT+BacbgnbceiDJADVfw==
X-Google-Smtp-Source: ABdhPJw0uQEuhFtLZ/yp2rlntAi8MREzCiqyFoKyRYiByd6f3gcRZqvzyCKHQD5Nm2De5YPjEiQssQ==
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr12110209wrq.90.1625560840330;
        Tue, 06 Jul 2021 01:40:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b8sm2176254wmb.20.2021.07.06.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:40:39 -0700 (PDT)
Date:   Tue, 6 Jul 2021 10:40:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YOQXBWpo3whVjOyh@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20210705130314.11519-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705130314.11519-1-ogabbay@kernel.org>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 04:03:12PM +0300, Oded Gabbay wrote:
> Hi,
> I'm sending v4 of this patch-set following the long email thread.
> I want to thank Jason for reviewing v3 and pointing out the errors, saving
> us time later to debug it :)
> 
> I consulted with Christian on how to fix patch 2 (the implementation) and
> at the end of the day I shamelessly copied the relevant content from
> amdgpu_vram_mgr_alloc_sgt() and amdgpu_dma_buf_attach(), regarding the
> usage of dma_map_resource() and pci_p2pdma_distance_many(), respectively.
> 
> I also made a few improvements after looking at the relevant code in amdgpu.
> The details are in the changelog of patch 2.
> 
> I took the time to write an import code into the driver, allowing me to
> check real P2P with two Gaudi devices, one as exporter and the other as
> importer. I'm not going to include the import code in the product, it was
> just for testing purposes (although I can share it if anyone wants).
> 
> I run it on a bare-metal environment with IOMMU enabled, on a sky-lake CPU
> with a white-listed PCIe bridge (to make the pci_p2pdma_distance_many happy).
> 
> Greg, I hope this will be good enough for you to merge this code.

So we're officially going to use dri-devel for technical details review
and then Greg for merging so we don't have to deal with other merge
criteria dri-devel folks have?

I don't expect anything less by now, but it does make the original claim
that drivers/misc will not step all over accelerators folks a complete
farce under the totally-not-a-gpu banner.

This essentially means that for any other accelerator stack that doesn't
fit the dri-devel merge criteria, even if it's acting like a gpu and uses
other gpu driver stuff, you can just send it to Greg and it's good to go.

There's quite a lot of these floating around actually (and many do have
semi-open runtimes, like habanalabs have now too, just not open enough to
be actually useful). It's going to be absolutely lovely having to explain
to these companies in background chats why habanalabs gets away with their
stack and they don't.

Or maybe we should just merge them all and give up on the idea of having
open cross-vendor driver stacks for these accelerators.

Thanks, Daniel

> 
> Thanks,
> Oded
> 
> Oded Gabbay (1):
>   habanalabs: define uAPI to export FD for DMA-BUF
> 
> Tomer Tayar (1):
>   habanalabs: add support for dma-buf exporter
> 
>  drivers/misc/habanalabs/Kconfig             |   1 +
>  drivers/misc/habanalabs/common/habanalabs.h |  26 ++
>  drivers/misc/habanalabs/common/memory.c     | 480 +++++++++++++++++++-
>  drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
>  drivers/misc/habanalabs/goya/goya.c         |   1 +
>  include/uapi/misc/habanalabs.h              |  28 +-
>  6 files changed, 532 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
