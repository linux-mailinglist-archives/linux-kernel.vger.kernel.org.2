Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193793F55F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhHXCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233399AbhHXCsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629773281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fwaWgiERsG1JcbIwR2cIzqtgKwKsqVeO59xySGEKNhA=;
        b=L5VzPyokBIFGBROEn4jng2CRJehjBdHktRq3NEy41w5fZBqXMk0VYx/gQUCvDJ7+T0XTTe
        Zwb2tllIV81tsyzMucASLhFk2VKUMDD1UPk4q5NtgwI/KEaiTJwfDlMuVHOi4DO3fwRIjT
        3jSt1UYWRgpyIN6KVXczlXirCjxnqc8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-wRYkdan2PD2SY7xG4_xznw-1; Mon, 23 Aug 2021 22:47:59 -0400
X-MC-Unique: wRYkdan2PD2SY7xG4_xznw-1
Received: by mail-lj1-f200.google.com with SMTP id v25-20020a2e9919000000b001bc160ab064so4899441lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwaWgiERsG1JcbIwR2cIzqtgKwKsqVeO59xySGEKNhA=;
        b=d/Odq+v7aOFjbJ8H18apUBNSiwTlaCFjz4IME2GQUMzXVVjBkG0i+pMk9J1aSaJWYD
         kKfhxFvkvMUHGhzPtUQgRlM1uDHB4XZ9GNKf4qnZoLqlwFThJiWSEB+hz2NEaD7M8jv4
         6DmPp8x/nw3i/2RRqcawn2xUnWPXOYmY7KFohocodcGlX6JvBd+fA06wuy1G8mAiwCit
         JLnQHJRyOaVDU/NUrFbRNJ3k4v+T4K92d3JnMt+Cv+xq929A+yK02Q1wIl6qBw85gErh
         MZ06hJxU9HTGrEcElp5oShk3WZqAMD/YMYy0SscsntQynM7WRTA3udBPqak66a3piOa2
         NhYA==
X-Gm-Message-State: AOAM533a6YIXkTrLC/Ed4Xr5NR3Ev6ka8s6YTrIjQv/xraLXN00sW662
        RX3YfBZtiixGnBBlmJHZI2HkxT8ur/w9roD4ANEmCu95mmwNqvBMe2Rls75JHwlym3IBwBgbTIa
        CXaCJuLpdRhYXBRPI42O6pEqGagl1MMV4tE79g5Wo
X-Received: by 2002:a2e:bf23:: with SMTP id c35mr29023156ljr.404.1629773278399;
        Mon, 23 Aug 2021 19:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRj72YTFI5L2JcyZ+SRAIpY0EIDTg26qrzM45Tor/6ZXhVwoZ2v9X2i+Ndkrplm/lp6kSxo3hJVi4QwS74z+4=
X-Received: by 2002:a2e:bf23:: with SMTP id c35mr29023150ljr.404.1629773278247;
 Mon, 23 Aug 2021 19:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com> <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com> <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com> <20210823080952-mutt-send-email-mst@kernel.org>
 <b9636f39-1237-235e-d1fe-8f5c0d422c7d@nvidia.com>
In-Reply-To: <b9636f39-1237-235e-d1fe-8f5c0d422c7d@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 24 Aug 2021 10:47:47 +0800
Message-ID: <CACGkMEuc0C0=te3O6z76BniiuHJgfxHnaAZoX=+PCy4Y7DxRow@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 6:31 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
> > On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> >> It helpful if there is a justification for this.
> >>
> >> In this case, no such HW device exist and the only device that can cause
> >> this trouble today is user space VDUSE device that must be validated by the
> >> emulation VDUSE kernel driver.
> >>
> >> Otherwise, will can create 1000 commit like this in the virtio level (for
> >> example for each feature for each virtio device).
> > Yea, it's a lot of work but I don't think it's avoidable.
> >
> >>>>>>> And regardless of userspace device, we still need to fix it for other cases.
> >>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
> >>>>>>
> >>>>> No, there isn't now. But this could be a potential attack surface if
> >>>>> the host doesn't trust the device.
> >>>> If the host doesn't trust a device, why it continues using it ?
> >>>>
> >>> IIUC this is the case for the encrypted VMs.
> >> what do you mean encrypted VM ?
> >>
> >> And how this small patch causes a VM to be 100% encryption supported ?
> >>
> >>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
> >>>>
> >>> Isn't it the driver's job to validate some unreasonable configuration?
> >> The check should be in different layer.
> >>
> >> Virtio blk driver should not cover on some strange VDUSE stuff.
> > Yes I'm not convinced VDUSE is a valid use-case. I think that for
> > security and robustness it should validate data it gets from userspace
> > right there after reading it.
> > But I think this is useful for the virtio hardening thing.
> > https://lwn.net/Articles/865216/
>
> I don't see how this change is assisting confidential computing.
>
> Confidential computingtalks about encrypting guest memory from the host,
> and not adding some quirks to devices.

In the case of confidential computing, the hypervisor and hard device
is not in the trust zone. It means the guest doesn't trust the cloud
vendor.

That's why we need to validate any input from them.

Thanks

>
> >
> > Yongji - I think the commit log should be much more explicit that
> > this is hardening. Otherwise people get confused and think this
> > needs a CVE or a backport for security.
> >
>

