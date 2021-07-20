Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E923CF5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhGTHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234146AbhGTHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626768812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iR1FfPEi/dSZlfY2U/ypFz4NVPRyvseiKT4LAhvExgQ=;
        b=XO6S2pWnV11SZ6rNBRq3ZM2q5YJrIbK3E99jQ9SrkJmPZWOMgNZARt+qwOArnTxtzP9aUA
        X73Cc4iODam6yn6TJ1q3F4yulFmomKgSgMMCK1O7imsStgGvutwpwcICpiSTaBaZg4nlD0
        7ndU41E5Sype8MdossjJfi1DkpTitHI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-TT8mmK7UPDKLPhbgWUoS_g-1; Tue, 20 Jul 2021 04:13:31 -0400
X-MC-Unique: TT8mmK7UPDKLPhbgWUoS_g-1
Received: by mail-ed1-f72.google.com with SMTP id g23-20020aa7c8570000b02903954c05c938so4921676edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iR1FfPEi/dSZlfY2U/ypFz4NVPRyvseiKT4LAhvExgQ=;
        b=EKLmTtxfg4ZwpFmc2I4T3NC6T3rLy4HRjFToNSHDUmpHiTmD08xO4z7dyIXPgLYXTP
         CXfZsqGnrob1qu4ypYaC8vhxk+DAGIAQJDuUSNV5P0kaeBBUK2yR32KoaIf2+Gyta3ra
         KeFFqBUsDeD/ed8HaS5san2PFnkoKukqFyW472+qM1ovaEBfkJgWU+pGOpxQM05nP+eW
         y1NQT76t/tKwlfuiFC9bEeBHFp1rjJRNaSX9rFuBlybF4EBwA6t4NTvrI+7FypyvsEQN
         rqjdK3r0zCvX+XU2sJ84tcS+sy1gbkJDSIMpUfrZ4CMTWG2J1GECb29C5vCyFAlw/9qP
         ItLQ==
X-Gm-Message-State: AOAM533wIqOs2Z8GF4TRglF3Zqf1VN2W6NckkJk0nATprvut6HU8hsz3
        2nY0//p8a2zG3c/SQUOcS8NsVb/L9DTFLm0IM0TXMC7R7xU1ZQO1KWz54qDZRz0mERNB2Ujbe1z
        s4ZbmJrH3pjnzEckVAqv10Sok
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr39516672eds.374.1626768810120;
        Tue, 20 Jul 2021 01:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTElRn2REEtTessTQf5nVgqHL9zBooMet57C/pD7unDakj1dPrn3LW7+7oWhizoutwOC1gfQ==
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr39516657eds.374.1626768809987;
        Tue, 20 Jul 2021 01:13:29 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id jw8sm6767787ejc.60.2021.07.20.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 01:13:29 -0700 (PDT)
Date:   Tue, 20 Jul 2021 10:13:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210720081327.6govoz2jjb6osxjt@steredhat>
References: <20210720052533.415991-1-elic@nvidia.com>
 <20210720065740.56udn3ndebzvu26o@steredhat>
 <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:14:35AM +0300, Eli Cohen wrote:
>On Tue, Jul 20, 2021 at 08:57:40AM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
>> > When calling vringh_init_iotlb(), use the negotiated features which
>> > might be different than the supported features.
>> >
>> > Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
>> > Signed-off-by: Eli Cohen <elic@nvidia.com>
>> > ---
>> > v0 --> v1:
>> > Update "Fixes" line
>> >
>> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
>> > 1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > index 14e024de5cbf..89a474c7a096 100644
>> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>> > {
>> > 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> >
>> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
>> > 			  VDPASIM_QUEUE_MAX, false,
>> > 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>> > 			  (struct vring_avail *)
>> > @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>> > 	vq->device_addr = 0;
>> > 	vq->cb = NULL;
>> > 	vq->private = NULL;
>> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
>>
>> vdpasim_vq_reset() is called while resetting the device in vdpasim_reset()
>> where we also set `vdpasim->features = 0` after resetting the vqs, so maybe
>> it's better to use the supported features here, since the negotiated ones
>> are related to the previous instance.
>>
>
>I don't think using supported features is valid. Better to make sure
>vringh_init_iotlb() is called after the features have been negotiated.
>

I think the vringh_init_iotlb() call in vdpasim_vq_reset() is just used 
to clean up the `struct vringh`, then it will be initialized in 
vdpasim_queue_ready() when features have already been negotiated.

Maybe here we can pass 0 (to the features parameter) if we don't want to 
use the features supported by the device.

Thanks,
Stefano

