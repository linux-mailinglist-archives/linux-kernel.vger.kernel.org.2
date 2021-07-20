Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790BE3CF4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbhGTGRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242791AbhGTGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626764265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aATh9Mp3JsAAK9AMXlEVTfSs9zkYB1yHocq5Q1WegPs=;
        b=VSB4Hu0tuinhYnu225tabittNwlQKIIs0FXTNvI6FqD59mSHU/zqU+31UVvRMV6NcqM78F
        1fy8kF/8lqBRLxpEg0dihkZLKlUva2+OTO1IRp6hsYCfi5QoYO46Prs1qRjMfOOPT+i6kQ
        sN2p3DxfkQkEZrhdKyg4HgU04ysAYI0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-bwHlG480MpiIgaVtCuUn6Q-1; Tue, 20 Jul 2021 02:57:44 -0400
X-MC-Unique: bwHlG480MpiIgaVtCuUn6Q-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564020054b0290395573bbc17so10390393edu.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aATh9Mp3JsAAK9AMXlEVTfSs9zkYB1yHocq5Q1WegPs=;
        b=RDE2wNHlACg+8WrgKwjfIdtHuNlPeWAB3CNt69Zlr/mEy4fHvwf0jJAnDExilWtaeN
         ievH9Jdqt2mL/mcM3uNMfOhVhii6/h/EalLPkKm/hWHAtO2lyX37v7ml9gSkesj8GQxp
         ZEK+mIcxYygWEvxguM+ZcVT7bzS2kV544dMrdhj3w6mFl7acsZPU5NIKhM+flwQRjeqx
         sbFgEGFr1oFfR+ZghM6vruClZH4tNR21CJ78tAmDKp5HqlsZ1ZlALcLO0Q14HskWKcIf
         ivwsmjyB8GownBioBfGnMZEN/S/2lQg+9nHh1fH/LVGnDOuNJq0rsY7YavyN1Z/0NdNV
         cMGg==
X-Gm-Message-State: AOAM532qQx6t7//FVCKMGExUJs5A/XfxVH7ydMVWxqmzXI0lcg/KV0dm
        bt+FJ9O+iIwB3bTFcOk88s15Rw7DB3Z9xAeaGY/eTU8p6D4VTKN94i4ckBrxslXItaiRuz9Mx/0
        OmeWTQBl3gEuMcwqSnFZ/lv1T
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr7514348ejm.457.1626764263338;
        Mon, 19 Jul 2021 23:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC2Gfso/vjpaol40WZv9MdPLMw4mV1khcxPxWldef29NHXVpjb0R8LIGdlpTHVyJ2RezcO/Q==
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr7514338ejm.457.1626764263190;
        Mon, 19 Jul 2021 23:57:43 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id q9sm6758618ejf.70.2021.07.19.23.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:57:42 -0700 (PDT)
Date:   Tue, 20 Jul 2021 08:57:40 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210720065740.56udn3ndebzvu26o@steredhat>
References: <20210720052533.415991-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210720052533.415991-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
>When calling vringh_init_iotlb(), use the negotiated features which
>might be different than the supported features.
>
>Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
>Signed-off-by: Eli Cohen <elic@nvidia.com>
>---
>v0 --> v1:
>Update "Fixes" line
>
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 14e024de5cbf..89a474c7a096 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> {
> 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
>-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>+	vringh_init_iotlb(&vq->vring, vdpasim->features,
> 			  VDPASIM_QUEUE_MAX, false,
> 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> 			  (struct vring_avail *)
>@@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> 	vq->device_addr = 0;
> 	vq->cb = NULL;
> 	vq->private = NULL;
>-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>+	vringh_init_iotlb(&vq->vring, vdpasim->features,

vdpasim_vq_reset() is called while resetting the device in 
vdpasim_reset() where we also set `vdpasim->features = 0` after 
resetting the vqs, so maybe it's better to use the supported features 
here, since the negotiated ones are related to the previous instance.

Thanks,
Stefano

