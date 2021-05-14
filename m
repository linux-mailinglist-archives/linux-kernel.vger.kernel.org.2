Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF91380445
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhENHas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhENHar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620977376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLaSX75gXckI8Z8WzprraSW9kYtncj9z6b/WJYFwkBs=;
        b=IF8n5oNhWNOv4ndLb/AqSJ57XsSND67LPaulWnhVAMe//ECSTdNHrOxP3BB9avcZobI5Fe
        +rt9zdStDiygw+0eUUUW2PSDelsQn5Kv92V7+NTh7evyND0FlIGYTfS4qeoBbz6UJI2CKn
        qgT8YroZzvlqWaJJGVuSMj1NBAPUF24=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-bpq-5SoIOdSipku2IcKafQ-1; Fri, 14 May 2021 03:29:34 -0400
X-MC-Unique: bpq-5SoIOdSipku2IcKafQ-1
Received: by mail-lj1-f199.google.com with SMTP id r15-20020a2eb60f0000b02900eddb317c52so6144564ljn.21
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLaSX75gXckI8Z8WzprraSW9kYtncj9z6b/WJYFwkBs=;
        b=aI4dj9TxzFnc/dDhx1SPnqsSxgS1hzR115wI5XpqDSt03PfmWBK0m1PrXVQrAedVB2
         cE5ATyKsG0yPVPZ0/ToujtL9dpqW1GTNE+mG9ky0Tf9o660nsP0UIPSHZTktXvTvwvGg
         rbkEL3wqIC3JBfF2nYjtCRYId0/Ltg5ajzSY/L+DLC6RIS5BwcW39wfEQ2sB5SrAF/r+
         EDJVfWx1DDUznCZIfzGkuLFHjH7rCaCcAOvF7z/+1mPyaA1Ts4F2HYoqfHRMdppeq4/T
         MhfvppWZ0c3jdYTb7qwsJAIBCLHaO0+pBY3JLaCBhv8kEUqUGuzACjHKg1mCn6bRPp28
         lDZg==
X-Gm-Message-State: AOAM530FNTrFdTJGPOnyi/7mkzxxfmwW/deQZsCTlzD6qFMufL+JZaJH
        J5AP8c6Odp5LKFBHuWqe53YCP5tAV+N71rrRhLGOS1DQXateg5nx3c7ZVa67VzccIh/egqCnjBR
        6irUUrgi0oE1fyp7OPHFN91MDv2wffXlraYl9i2lC
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr31104398lfl.258.1620977373358;
        Fri, 14 May 2021 00:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Gls0aXdzkjmHbhas1oEWoz6vOBmT2YTHRf29pZ421C71h5IAXzfqDqoCC/Q7e+ENngkENKWuM+lhgqOXZzk=
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr31104385lfl.258.1620977373195;
 Fri, 14 May 2021 00:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210423080942.2997-1-jasowang@redhat.com> <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
In-Reply-To: <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 May 2021 15:29:20 +0800
Message-ID: <CACGkMEv0uWd+X87cYoG-GGjTXBvRztp2CY3RKyq9jFbSYK1n0Q@mail.gmail.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xieyongji@bytedance.com, file@sect.tu-berlin.de,
        ashish.kalra@amd.com, konrad.wilk@oracle.com,
        kvm <kvm@vger.kernel.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:27 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Apr 23, 2021 at 04:09:35PM +0800, Jason Wang wrote:
> > Sometimes, the driver doesn't trust the device. This is usually
> > happens for the encrtpyed VM or VDUSE[1].
>
> Thanks for doing this.
>
> Can you describe the overall memory safety model that virtio drivers
> must follow?

My understanding is that, basically the driver should not trust the
device (since the driver doesn't know what kind of device that it
tries to drive)

1) For any read only metadata (required at the spec level) which is
mapped as coherent, driver should not depend on the metadata that is
stored in a place that could be wrote by the device. This is what this
series tries to achieve.
2) For other metadata that is produced by the device, need to make
sure there's no malicious device triggered behavior, this is somehow
similar to what vhost did. No DOS, loop, kernel bug and other stuffs.
3) swiotb is a must to enforce memory access isolation. (VDUSE or encrypted VM)

> For example:
>
> - Driver-to-device buffers must be on dedicated pages to avoid
>   information leaks.

It looks to me if swiotlb is used, we don't need this since the
bouncing is not done at byte not page.

But if swiotlb is not used, we need to enforce this.

>
> - Driver-to-device buffers must be on dedicated pages to avoid memory
>   corruption.

Similar to the above.

>
> When I say "pages" I guess it's the IOMMU page size that matters?
>

And the IOTLB page size.

> What is the memory access granularity of VDUSE?

It has an swiotlb, but the access and bouncing is done per byte.

>
> I'm asking these questions because there is driver code that exposes
> kernel memory to the device and I'm not sure it's safe. For example:
>
>   static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
>                   struct scatterlist *data_sg, bool have_data)
>   {
>           struct scatterlist hdr, status, *sgs[3];
>           unsigned int num_out = 0, num_in = 0;
>
>           sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
>                             ^^^^^^^^^^^^^
>           sgs[num_out++] = &hdr;
>
>           if (have_data) {
>                   if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
>                           sgs[num_out++] = data_sg;
>                   else
>                           sgs[num_out + num_in++] = data_sg;
>           }
>
>           sg_init_one(&status, &vbr->status, sizeof(vbr->status));
>                                ^^^^^^^^^^^^
>           sgs[num_out + num_in++] = &status;
>
>           return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
>   }
>
> I guess the drivers don't need to be modified as long as swiotlb is used
> to bounce the buffers through "insecure" memory so that the memory
> surrounding the buffers is not exposed?

Yes, swiotlb won't bounce the whole page. So I think it's safe.

Thanks

>
> Stefan

