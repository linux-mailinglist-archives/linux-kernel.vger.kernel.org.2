Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5438297D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhEQKJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhEQKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:09:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B74C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:08:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so8312306ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YY0Ck0zSEdF0gTBX54lqL24Ab+0Kr/VRz/DFUzjuM+g=;
        b=t2Qah4MVCccGQAbBlBUSHbq7DQayF2QSFlCfKfOm3pxH1qITcPNHssp1n8J6FBA26e
         IX7lxhiAVIyAZqC+49tC46y4HCpqTw1hbvtrD42TbM3WZKgdbQhg184890hEo/tb5Shm
         4s/ftORFUyF/qz+cckCmNnv78VJrZu7EWpUix7dSjo3n5+UbMYo0p7kf+IqoxvzJpw8q
         b8wKN4CiATLnn6yC5e3Kjvw5OODAlpFcN7DePttM6RyYqyB/odkAhRjzJANG/baoYb/T
         0ot9aXnrvN1KHUnwa1ZzNylWKWMYpPEjwxRS+IGJlaYj6BatTAPVzegiqRTsg3IP3N9L
         g9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YY0Ck0zSEdF0gTBX54lqL24Ab+0Kr/VRz/DFUzjuM+g=;
        b=PWdQfSNG34+FKYxd7DeV6x4D9WnfxctlLbK0cTIbW4hNts4rYsvxM2CZuFN1zkAyzi
         MwnSr+bdZ7kBLborEJgI229SaJ7L9nbwoKPKV5VoTSYV6H9rVx2Y/dtP/kzx3FLYyJXt
         GdQwU1cxIYncysx/RoJm/83NXfLklJ9f9gEe3q2MMXGr1auMLGozR9c15O3rG3vNNrVw
         2TxiCWXE3/qDSdv804dAfkHrH+gdcOb9xvZfFQjbZN0PzVQ4EFebFADJ8NEk1gTiB4AS
         c8n8wo8S24CDAKI4A23glhwtVz5Uzq3pXXspF9M9mKk77/aAX55LqedmScKiIKmFRYPh
         +jaA==
X-Gm-Message-State: AOAM531YDsA1B8GmjDKmz1mi6PuZ2Vx4xtC07BgfA7kceAiEUd6+fSiQ
        i5lqQOYAwMzCD+/EMKs4HCOMQ67kU0JU+dhP4SxE
X-Google-Smtp-Source: ABdhPJyHmhdb6cFUkH+Qw1gIFQstYwMcmHhYtVTIHJIsAvKLCNTMmKuQvaiwd3TNse5uGZUOJe/+xEBp/ag4GkTzJpw=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr26584774ejz.247.1621246103464;
 Mon, 17 May 2021 03:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210517093428.670-1-xieyongji@bytedance.com> <20210517093428.670-14-xieyongji@bytedance.com>
 <20e1d79f-c3f6-5553-d6b6-1f1051c39ccc@redhat.com>
In-Reply-To: <20e1d79f-c3f6-5553-d6b6-1f1051c39ccc@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 17 May 2021 18:08:12 +0800
Message-ID: <CACycT3us0h_mpiZ+aeBt18HDwDs3GQf=-tDjQAyqtYfHCVw8YQ@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 13/15] virtio-mem: Handle virtio_device_ready() failure
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        jean-philippe@linaro.org, Ohad Ben Cohen <ohad@wizery.com>,
        bjorn.andersson@linaro.org, vgoyal@redhat.com, miklos@szeredi.hu,
        lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 5:48 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.05.21 11:34, Xie Yongji wrote:
> > Now virtio_device_ready() will return error if we get
> > invalid status. Let's handle this case on probe.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/virtio/virtio_mem.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> > index 32a8e359a5c3..1148c392ff94 100644
> > --- a/drivers/virtio/virtio_mem.c
> > +++ b/drivers/virtio/virtio_mem.c
> > @@ -2602,13 +2602,17 @@ static int virtio_mem_probe(struct virtio_device *vdev)
> >       if (rc)
> >               goto out_unreg_mem;
> >
> > -     virtio_device_ready(vdev);
> > +     rc = virtio_device_ready(vdev);
> > +     if (rc)
> > +             goto out_unreg_device;
> >
> >       /* trigger a config update to start processing the requested_size */
> >       atomic_set(&vm->config_changed, 1);
> >       queue_work(system_freezable_wq, &vm->wq);
> >
> >       return 0;
> > +out_unreg_device:
> > +     unregister_virtio_mem_device(vm);
> >   out_unreg_mem:
> >       unregister_memory_notifier(&vm->memory_notifier);
> >   out_del_resource:
> >
>
> I assume this will really be a corner case to hit, right?
>

Yes, it should almost never happen if the device is trusted.

Thanks,
Yongji
