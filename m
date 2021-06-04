Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0939B471
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFDH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229958AbhFDH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622793483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ijE1pTqJ41WHz6rwXA+sUBCq0HtCCMDO+vlAdF3MMZo=;
        b=V8TTiKJndgnteNsrR9F3nIk4wrwTNkqvEkMLOlU2h/CUGy874UTYxsKxUN1gwNaZGMx2xa
        hoX4yOWXc/VXF8Qm2byTz74ipaw5zQGAhQoA0lxV7gBBxlvFbCGAcjLfqYtOcVC3Ath1nS
        4eWHlODha0kFGmg4a6GhKq3h+MrEPE0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-2pOCwBmgORW52nHG6YXTsg-1; Fri, 04 Jun 2021 03:58:01 -0400
X-MC-Unique: 2pOCwBmgORW52nHG6YXTsg-1
Received: by mail-ej1-f70.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso3069308ejn.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ijE1pTqJ41WHz6rwXA+sUBCq0HtCCMDO+vlAdF3MMZo=;
        b=PN62fyLP8CAo06qbKcYkm6jG1rpIhVIUI7MIsh8bwb/ewWqzGXvPire2IJFnWYrFf9
         qx6lAkOhp3D4lx1il/IeyZQ4SWnoRUngjcTcaeZuabCdctxGPT96NWq0rxW4b4M1sdSR
         6bqXgCv/7OUiDt+e7rLw6MUeQDaaLH0kEXe436yj9XSIUolM3r6ZsjYjxx0coUwKovIu
         IkbVhm2d0jsGGf85LL1Jn2xnYmlmobdLOjogW+76J2p0lGsbUwbhXs+Wwwj9rzRe07TA
         I5SwTSEWphncxQsePzAS+Q5n5NdDJq71sbZ3zLGgscxd14UA/IQgBxfD9/u/LcbHWsSB
         ZMCA==
X-Gm-Message-State: AOAM530ZVcdDZe7xMYm+xDhwnic8jHDOyzvNK8SFFfn+2QEoVBWIgga5
        IhPLPd2mvJELlPVb6EZiDfOpKXDx2DQ/w7fcTaEJJMzAGXVrvvd+bRqjETRGrss3GYNN5ErsRIM
        MYLtSBEDW9MoRpPBGUC/ESE6P
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr2975478ejy.211.1622793480444;
        Fri, 04 Jun 2021 00:58:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP44+2T+Zo6x8GpZCsoSBuzEEhmD8Fx/J6CPl5A7XREyZf4HGgU80zzZ6Okjs6N3aS0Oq7Ig==
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr2975471ejy.211.1622793480307;
        Fri, 04 Jun 2021 00:58:00 -0700 (PDT)
Received: from steredhat ([5.170.129.161])
        by smtp.gmail.com with ESMTPSA id n2sm2855332edi.32.2021.06.04.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 00:57:59 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:57:56 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, elic@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa: mandate 1.0 device
Message-ID: <20210604075756.z67ycpyonmhqs37k@steredhat>
References: <20210604050251.57834-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210604050251.57834-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:02:51PM +0800, Jason Wang wrote:
>This patch mandates 1.0 for vDPA devices. The plan is never to support
>transitional devices for vDPA devices in the future.
>
>The reasons are:
>
>- To have the semantic of normative statement in the virtio spec and
>  eliminate the burden of transitional device for both vDPA bus and
>  vDPA parent
>- Eliminate the efforts for dealing with endian conversion in the
>  management tool
>- Mandate vDPA vendor to ship modern device instead of transitional
>  device which is easily broken and unsafe
>- Transitional device never work since the first day of vDPA
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/vdpa.h | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

