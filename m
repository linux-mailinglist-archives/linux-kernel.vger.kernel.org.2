Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0291543C5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhJ0I6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241118AbhJ0I6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635324968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bg2jmWugrAP5drzBc7AtpQfP7KTLK8hNbD3CI7qc7g=;
        b=T2/B1hW08RJjQEEB65XouIjCwdvDrYXp0k19YNMXqGZvP07mfggRELZEETOuz4dr48sPDp
        n5aSYOpY8YO/FgX2oATjKm49exCSjL5TFMdSfLK5Y13xdANXqpf+33TDCaxqr67+oLzIP6
        5CYQ1Huxssxvp9zCLTwXqdAG6Lks3Pg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-zeySlddaPOOwj4X5_dULqw-1; Wed, 27 Oct 2021 04:56:07 -0400
X-MC-Unique: zeySlddaPOOwj4X5_dULqw-1
Received: by mail-wm1-f69.google.com with SMTP id a21-20020a1c7f15000000b0032cd93a2bd7so108381wmd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7bg2jmWugrAP5drzBc7AtpQfP7KTLK8hNbD3CI7qc7g=;
        b=4p1uSade6dTsBUuiVmVkuyS+JFw910ar7vo5302gjxzN6y0Mlpe9300ivs/tgtB776
         7PETkLnBLOmuoRqq1jrxNIUkxy/PZvmRJHiVJNJHNLtzc+jiyqHWlh1ArmM7LUaHlV9m
         gidHzindVyvzLXgKjZqnvnGzqnlot/pbH2jrv1VgUv+jhkg8Rb9EWXtqqhr86XEbGKhg
         7Se0Kp9dkl1VdqhSEBvacOOkieaU70KesRId81DFjEDu4IIZH63wdwx9pTJsx92hlpb+
         q6bmqcWQvZ2DoLXxlLHwnV/zAam5jlIp4tkWSR4K+6NsZe+cwF8aPnTvtubRKHia7TkM
         xcQg==
X-Gm-Message-State: AOAM533ph0yS8BQBy23qaaPqmjh6zxFcaMwJn5H9W/1C+MaFY8AkPZSB
        IlDqbCsttvbHXPMUqKXGp/aPYoKq/6kv2W1IPs3FrxqLTddOkwiVPbhGB/I7JHmuCy3lwRrmdTK
        le+lzt2BdfrJ8yskxswK0pPSD
X-Received: by 2002:a5d:5191:: with SMTP id k17mr28697923wrv.166.1635324966165;
        Wed, 27 Oct 2021 01:56:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdvrKPLGWce0zKxktjiX4WZxnekcKuLnVTB4v3+lf2dmRnC6Bb5uHHKMtXNijIGyJvWy3P0A==
X-Received: by 2002:a5d:5191:: with SMTP id k17mr28697903wrv.166.1635324965997;
        Wed, 27 Oct 2021 01:56:05 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
        by smtp.gmail.com with ESMTPSA id t3sm3296837wrq.66.2021.10.27.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:56:05 -0700 (PDT)
Date:   Wed, 27 Oct 2021 04:56:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: select CONFIG_SG_POOL
Message-ID: <20211027045533-mutt-send-email-mst@kernel.org>
References: <20211027082433.52616-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027082433.52616-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:24:13AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Switching virtio-blk to the sg_pool interfaces causes a build
> failures when they are not part of the kernel:
> 
> drivers/block/virtio_blk.c:182:3: error: implicit declaration of function 'sg_free_table_chained' [-Werror,-Wimplicit-function-declaration]
>                 sg_free_table_chained(&vbr->sg_table,
>                 ^
> drivers/block/virtio_blk.c:195:8: error: implicit declaration of function 'sg_alloc_table_chained' [-Werror,-Wimplicit-function-declaration]
>         err = sg_alloc_table_chained(&vbr->sg_table,
>               ^
> 
> Select this symbol through Kconfig, as is done for all other
> users.
> 
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'll squash this to avoid bisect failures, ok?

> ---
>  drivers/block/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index d97eaf6adb6d..2a51dfb09c8f 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -371,6 +371,7 @@ config XEN_BLKDEV_BACKEND
>  config VIRTIO_BLK
>  	tristate "Virtio block driver"
>  	depends on VIRTIO
> +	select SG_POOL
>  	help
>  	  This is the virtual block driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
> -- 
> 2.29.2

