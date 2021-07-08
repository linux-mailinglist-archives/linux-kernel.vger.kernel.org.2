Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7843BF520
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 07:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhGHFku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 01:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229579AbhGHFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 01:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625722687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spF0nArutEY6c3aIx13REIr795lrsmfn1haElbr+KLA=;
        b=e82b52OCQVba8K0Wqevy7CJ7prZwRWKQn65XvHmaCZdTVWI4ZPaf9HjP/CZG4E7aWbEIj1
        Yy/vnzAb4TWyZBxKQnCmMh/L3NmlNv4u9xHMQJz/dTXkBXirZ2N+Tttl1iQgZhPMVCtHTV
        4OtHJyPEjLSJmtBwgkaaBgjQZ1adncU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-uGsBcRJmOmCE1JGxFO-L5A-1; Thu, 08 Jul 2021 01:38:03 -0400
X-MC-Unique: uGsBcRJmOmCE1JGxFO-L5A-1
Received: by mail-ej1-f72.google.com with SMTP id hy7-20020a1709068a67b02904cdf8737a75so1319021ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 22:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spF0nArutEY6c3aIx13REIr795lrsmfn1haElbr+KLA=;
        b=hLEIRc1P3Fgp38vv+R4DeaKlfEF9J0y0dJDf2Tz9CeTMOwSLRuntkHw4PoR7ax+fAv
         Z7cEqL54tvD3Kf6ZLld1efBrz5OHI0rs1Sw5WOSqwfuHR2P/1GFnB+HOLPXsMI9WB8F9
         tD2p+xyvtS0YZx0SKSJhreRPHTeII7RRiNG5n+9iaqtKhfhH611hPEFJb5hlmGiyadbN
         deTRKXpxpofAp/9Pxo/jbHEDgXv5yBsUNe88jWOFSRoKQk7jSOtRkH2D3GO3/8Snv2aT
         mTkzUAX8IasSWQXxnPAyAnuHNbsSkJoYXdhksLFPT/jVllp8E+DQTHP2ErScw1k+u8Qs
         BRLg==
X-Gm-Message-State: AOAM532gV2b13Ns6ihqrdE9lqbokmnU2M1hjz8APs2VxeQr1vp/51F0y
        1msDT/WjQnITUscs5AOkeIyqgnFWGuXzcnnDM6lkfMrLyKLT6FR5c7Ye8q4ZOX4iO/PsmGIF7Fj
        GQnzdZRI5hb+0mSrNtzSqUxqP
X-Received: by 2002:a17:907:7212:: with SMTP id dr18mr28905049ejc.552.1625722682008;
        Wed, 07 Jul 2021 22:38:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr/sbyOQpdtUbzU7QHEy9dd02nFuTQg1VAzXOEOpF3qC+d41ZbIDeUh1QH2XFxPMOF/uWisQ==
X-Received: by 2002:a17:907:7212:: with SMTP id dr18mr28905040ejc.552.1625722681786;
        Wed, 07 Jul 2021 22:38:01 -0700 (PDT)
Received: from redhat.com ([2.55.150.102])
        by smtp.gmail.com with ESMTPSA id z25sm356160ejb.9.2021.07.07.22.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 22:37:57 -0700 (PDT)
Date:   Thu, 8 Jul 2021 01:37:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20210708013725-mutt-send-email-mst@kernel.org>
References: <20210708110854.1a1ab200@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708110854.1a1ab200@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 11:08:54AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/block/virtio_blk.c:986:14: error: initialization of 'int (*)(struct virtio_device *, void *)' from incompatible pointer type 'int (*)(struct virtio_device *)' [-Werror=incompatible-pointer-types]
>   986 |  .probe    = virtblk_probe,
>       |              ^~~~~~~~~~~~~
> drivers/block/virtio_blk.c:986:14: note: (near initialization for 'virtio_blk.probe')
> drivers/char/virtio_console.c:2213:11: error: initialization of 'int (*)(struct virtio_device *, void *)' from incompatible pointer type 'int (*)(struct virtio_device *)' [-Werror=incompatible-pointer-types]
>  2213 |  .probe = virtcons_probe,
>       |           ^~~~~~~~~~~~~~
> drivers/char/virtio_console.c:2213:11: note: (near initialization for 'virtio_console.probe')
> drivers/char/virtio_console.c:2228:11: error: initialization of 'int (*)(struct virtio_device *, void *)' from incompatible pointer type 'int (*)(struct virtio_device *)' [-Werror=incompatible-pointer-types]
>  2228 |  .probe = virtcons_probe,
>       |           ^~~~~~~~~~~~~~
> drivers/char/virtio_console.c:2228:11: note: (near initialization for 'virtio_rproc_serial.probe')
> drivers/scsi/virtio_scsi.c:983:11: error: initialization of 'int (*)(struct virtio_device *, void *)' from incompatible pointer type 'int (*)(struct virtio_device *)' [-Werror=incompatible-pointer-types]
>   983 |  .probe = virtscsi_probe,
>       |           ^~~~~~~~~~~~~~
> drivers/scsi/virtio_scsi.c:983:11: note: (near initialization for 'virtio_scsi_driver.probe')
> drivers/net/virtio_net.c: At top level:
> drivers/net/virtio_net.c:3387:14: error: initialization of 'void * (*)(struct virtio_device *)' from incompatible pointer type 'int (*)(struct virtio_device *)' [-Werror=incompatible-pointer-types]
>  3387 |  .validate = virtnet_validate,
>       |              ^~~~~~~~~~~~~~~~
> drivers/net/virtio_net.c:3387:14: note: (near initialization for 'virtio_net_driver.validate')
> drivers/net/virtio_net.c:3388:11: error: initialization of 'int (*)(struct virtio_device *, void *)' from incompatible pointer type 'int (*)(struct virtio_device *)' [-Werror=incompatible-pointer-types]
>  3388 |  .probe = virtnet_probe,
>       |           ^~~~~~~~~~~~~
> drivers/net/virtio_net.c:3388:11: note: (near initialization for 'virtio_net_driver.probe')
> 
> Caused by commit
> 
>   e397242b72e2 ("virtio: allow passing config data from validate callback")
> 
> I have used the vhost tree from next-20210707 for today.


My bad - pushed a wrong head by mistake. thanks!

> -- 
> Cheers,
> Stephen Rothwell


