Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D833E7CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbhHJPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242563AbhHJPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628610912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6JGdWkKZw7m5I7Ml6W62XXk0juw8pt6sorDOvoT2gRc=;
        b=EhdjvSlZxRVcCJcWxNK3nhtBLcP77wdLmZbU+xETYq71DVJUSGV2sSKDLe01i2tknbwern
        8IDl+jrRrvYVs/J59I50+AMDntPL0/ZWveePDXTgK2xndwtK1EAMDong/F/WdJwEoQAbog
        ncf1/+BrZZ7TrUD5TllJKIOaSw7uIKo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-5Q0UFvAhNbClrBqhYl_1_A-1; Tue, 10 Aug 2021 11:55:11 -0400
X-MC-Unique: 5Q0UFvAhNbClrBqhYl_1_A-1
Received: by mail-ed1-f69.google.com with SMTP id eg56-20020a05640228b8b02903be79801f9aso1453609edb.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6JGdWkKZw7m5I7Ml6W62XXk0juw8pt6sorDOvoT2gRc=;
        b=UzW6ba+/B0Ib/XM4vzB/LEQBHvkg1N0hCbvFiSgXBQJv8sVEYY24gWVbrYXWwOifq1
         fHEMuuQcqLiKbn+/l3AwA1MCcSTZO4urAedM/mcFcynSnx2dBq8dOfrk8YpaPtRFBOLb
         v0FOTsFg40YdHb/1wr8uD3PS6PBvyunaY2ggyzRshgQocU8QHJNEP1kbXMhfTpChGc0D
         1ypmuZOQ7kn5cWmZvCVkYVVVL54l9IQYEUbBTSCiCCPp+UM3C1FWxByBsZOFjUaBvuah
         BtQv+gbFcj4IYGF3fbE8lPadRYHImmNeix8fIS8cRbO+2c2rIIpabGz6zgRV+1H/Ci8g
         Utcg==
X-Gm-Message-State: AOAM533dlbRGcaf1xtw/QLbBsO9K2q0l8p5gQQ+dtV7G0Ud5FpawtpS5
        94iZ+hh9qIMCNTI+VDzk+eUlL6lZm+vb1FcdEOs11EYkEW7E1qwTGmMcX7wD8TLvx2SiG5QvfjN
        UG2QJ/2uDuLij9QAGBaMh1Ddf
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr5765629edu.74.1628610910303;
        Tue, 10 Aug 2021 08:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhAqOjbpwq6qZvKf52l1eB2CXoys1g5LMgipiutGJOsuuQSXt7GBewnhdf/LGYjWompbmqjw==
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr5765602edu.74.1628610910109;
        Tue, 10 Aug 2021 08:55:10 -0700 (PDT)
Received: from redhat.com ([2.55.156.103])
        by smtp.gmail.com with ESMTPSA id jo17sm3085686ejb.40.2021.08.10.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:55:08 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:55:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210810115418-mutt-send-email-mst@kernel.org>
References: <20210720052533.415991-1-elic@nvidia.com>
 <20210720065740.56udn3ndebzvu26o@steredhat>
 <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
 <20210720081327.6govoz2jjb6osxjt@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720081327.6govoz2jjb6osxjt@steredhat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:13:27AM +0200, Stefano Garzarella wrote:
> On Tue, Jul 20, 2021 at 10:14:35AM +0300, Eli Cohen wrote:
> > On Tue, Jul 20, 2021 at 08:57:40AM +0200, Stefano Garzarella wrote:
> > > On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
> > > > When calling vringh_init_iotlb(), use the negotiated features which
> > > > might be different than the supported features.
> > > >
> > > > Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > > v0 --> v1:
> > > > Update "Fixes" line
> > > >
> > > > drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
> > > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > index 14e024de5cbf..89a474c7a096 100644
> > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> > > > {
> > > > 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> > > >
> > > > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > > > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> > > > 			  VDPASIM_QUEUE_MAX, false,
> > > > 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> > > > 			  (struct vring_avail *)
> > > > @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> > > > 	vq->device_addr = 0;
> > > > 	vq->cb = NULL;
> > > > 	vq->private = NULL;
> > > > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > > > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> > > 
> > > vdpasim_vq_reset() is called while resetting the device in vdpasim_reset()
> > > where we also set `vdpasim->features = 0` after resetting the vqs, so maybe
> > > it's better to use the supported features here, since the negotiated ones
> > > are related to the previous instance.
> > > 
> > 
> > I don't think using supported features is valid. Better to make sure
> > vringh_init_iotlb() is called after the features have been negotiated.
> > 
> 
> I think the vringh_init_iotlb() call in vdpasim_vq_reset() is just used to
> clean up the `struct vringh`, then it will be initialized in
> vdpasim_queue_ready() when features have already been negotiated.
> 
> Maybe here we can pass 0 (to the features parameter) if we don't want to use
> the features supported by the device.
> 
> Thanks,
> Stefano

Eli? Maybe you can describe what is the observed bug the patch
is trying to fix.

Thanks!

-- 
MST

