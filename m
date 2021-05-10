Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998A6377CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhEJHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230009AbhEJHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620630068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Ccocry+LC8Oe8hSofuaYNRZNWwXj9OcoogwaqXg/EU=;
        b=H9ZbFDwho42mUx+dHCObyYC9LGyo/MgN2Mw7iuJSaDGyFgFV7Jo0YGupYZ9Zn/3xsLHAgP
        A1E4zfEoAmuMBoFfpHEzUgA9TBDB0tVm7QqJb675/+mXEnR+sFQly7RZjx0wgdQFzIP9Y1
        qTIgbSZ5pB71yInVsHNiDvhuCkVm88M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-V7J47yloOji-Tg-osHm88Q-1; Mon, 10 May 2021 03:01:05 -0400
X-MC-Unique: V7J47yloOji-Tg-osHm88Q-1
Received: by mail-ej1-f70.google.com with SMTP id yh1-20020a17090706e1b029038d0f848c7aso4391480ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Ccocry+LC8Oe8hSofuaYNRZNWwXj9OcoogwaqXg/EU=;
        b=luFGzztnjcj0HGS3O73NRHRSTMPNWv4Q6dzyFMJQ6JHj4Z/0fxdBVHGzXMfAH18CKi
         SL+ud3SckNRRdihtTwKJY/cq+b4lhLiOqbJtuN/WMbICnBp0u6PsaTnB4qcBSLK/4aXP
         PL3zPPq+IrBGXt1a1C04W2mIdve/01FJ8cXETSkei7nRAt+H8yJwum9LnrVWt+x7HPC4
         tfq8/3V4eVv7iupyFptrP8tO18tutE8wwhx+SRg8u+ADhnDA12ZApw8LPEuhc0OHFtG2
         M8tRiAtXoa02HUYHOHemsodU+wXMn9yjpgwKKzKRgTVCVhdkPHd0h3AbjPF5QGm4gYQK
         bpsQ==
X-Gm-Message-State: AOAM532zR2aoEPk2i8yzRbC+ZrEvRRbnAWFshMYy+y1CWrRqqQ4zNwSK
        3fzK4HlQoi0oLWqu+jkKcVmXZ8qsUHGsU6QZbTOsF5pSH6R8W0/tOdt2MswHWKDLRNn8gen+ybg
        WcaBhrLa98nzQtiwm1B+bTqGv
X-Received: by 2002:a17:907:2663:: with SMTP id ci3mr23894271ejc.540.1620630063926;
        Mon, 10 May 2021 00:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhIhplVuPHeT7rXzzBN3tJyJ6NtNTIZsq1e3F5sXmvdr8VITGqlg4MplkKxm5ee2cDul6AQA==
X-Received: by 2002:a17:907:2663:: with SMTP id ci3mr23894254ejc.540.1620630063773;
        Mon, 10 May 2021 00:01:03 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id g13sm8392482ejx.51.2021.05.10.00.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 00:01:03 -0700 (PDT)
Date:   Mon, 10 May 2021 09:01:01 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] vdpa_sim_blk: remove duplicate include of linux/blkdev.h
Message-ID: <20210510070101.iimcdu7zkmx5on6a@steredhat>
References: <20210510024307.7143-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210510024307.7143-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:43:03AM +0800, Wan Jiabing wrote:
>In commit 7d189f617f83f ("vdpa_sim_blk: implement ramdisk behaviour")
>linux/blkdev.h was included here causing the duplicate include.
>Remove the later duplicate include.
>
>Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index 5bfe1c281645..a790903f243e 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -15,7 +15,6 @@
> #include <linux/blkdev.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
>-#include <linux/blkdev.h>
> #include <uapi/linux/virtio_blk.h>
>
> #include "vdpa_sim.h"
>-- 
>2.20.1
>

Ooops...

Thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

