Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA33F5D20
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhHXLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236379AbhHXLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629804697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tP5a6fccu03ylsrPCjFXQRJ2IVJ92J0bcnTBejvh2I4=;
        b=PwaNrcI3SIy0qU33W0C6VPPV/VXciiGtfxe++4sz0pzj3Y+RZ28/DKUsxaKsp6+2FO+Lch
        8x8HwoyiRQeGIqXtHT+5imCPBmXsT8lqdTJ8WrjWV1/ZuuwhQAehLS9vYGptJxq6/4z57r
        oYWxPM22xvNPDUFOKv2cIDiHO1C6Wvk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-Pvu3xfsvP4-YxRaOMtfBJQ-1; Tue, 24 Aug 2021 07:31:36 -0400
X-MC-Unique: Pvu3xfsvP4-YxRaOMtfBJQ-1
Received: by mail-ej1-f72.google.com with SMTP id ak17-20020a170906889100b005c5d1e5e707so2172802ejc.16
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tP5a6fccu03ylsrPCjFXQRJ2IVJ92J0bcnTBejvh2I4=;
        b=ZedIJIEkFc8P5NjPTB4z1lZQFPgxrnRDEmSqZuDh6n8KFRPwdqHJVqxOElDXN+/MWl
         2LWXEb4m+3tkvDkwMXc3I3uLu1fbSWVIM47kUdGi8xT1XQ4nIcaeq0jwma9VC1yYTZUo
         giusb1EHkQ66iC6q4htw62R8ldH/Rv6DWMeGjMMl5TGEZKmK7PqpeT3JrGgdOX/9ZkMi
         4cINB3aBqtNrpsGQNe65Jkt2JJUA2YiAdTxIo94QpxFiZ5WfkmC2lcPThf0nq4s/Y89K
         pi+F8UfoGtcKGGBlRhASWg98nc5C6Ktp40bxCG8XzJz6bWgYtT2urduqNV+7eQXTcXn7
         tMEQ==
X-Gm-Message-State: AOAM530MAcTpPZZSW9UWaLzedFVdS2n5b+1g+3GEPrEcBKhwB5Uo7yC4
        iC7Ha4UQ0eYHUAiCwz2fiJ0WgvLV55bmSaagFJE/ursllWuoaGdp3P7eyW6qQ+AtWi+2ba8qX0k
        wLUEVr/gD6o5trDP1WubRLrA1
X-Received: by 2002:aa7:c5cb:: with SMTP id h11mr11572949eds.255.1629804694928;
        Tue, 24 Aug 2021 04:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztfOKCpWkq+cpuotpu6M9IwGlTHyNsYPqN20t7g9LEX+64r23BIx9ole/wLFW5RU0jYEjk6Q==
X-Received: by 2002:aa7:c5cb:: with SMTP id h11mr11572937eds.255.1629804694767;
        Tue, 24 Aug 2021 04:31:34 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id v8sm10674845edc.2.2021.08.24.04.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:31:34 -0700 (PDT)
Date:   Tue, 24 Aug 2021 07:31:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        vgoyal@redhat.com, jasowang@redhat.com
Subject: Re: [RFC PATCH 0/1] virtio: false unhandled irqs from
 vring_interrupt()
Message-ID: <20210824072622-mutt-send-email-mst@kernel.org>
References: <20210824105944.172659-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824105944.172659-1-stefanha@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:59:43AM +0100, Stefan Hajnoczi wrote:
> While investigating an unhandled irq from vring_interrupt() with virtiofs I
> stumbled onto a possible race that also affects virtio_gpu. This theory is
> based on code inspection and hopefully you can point out something that makes
> this a non-issue in practice :).
> 
> The vring_interrupt() function returns IRQ_NONE when an MSI-X interrupt is
> taken with no used (completed) buffers in the virtqueue. The kernel disables
> the irq and the driver is no longer receives irqs when this happens:
> 
>   irq 77: nobody cared (try booting with the "irqpoll" option)
>   ...
>   handlers:
>   [<00000000a40a49bb>] vring_interrupt
>   Disabling IRQ #77
> 
> Consider the following:
> 
> 1. An virtiofs irq is handled and the virtio_fs_requests_done_work() work
>    function is scheduled to dequeue used buffers:
>    vring_interrupt() -> virtio_fs_vq_done() -> schedule_work()
> 
> 2. The device adds more used requests and just before...
> 
> 3. ...virtio_fs_requests_done_work() empties the virtqueue with
>    virtqueue_get_buf().
> 
> 4. The device raises the irq and vring_interrupt() is called after
>    virtio_fs_requests_done_work emptied the virtqueue:
> 
>    irqreturn_t vring_interrupt(int irq, void *_vq)
>    {
>        struct vring_virtqueue *vq = to_vvq(_vq);
> 
>        if (!more_used(vq)) {
>            pr_debug("virtqueue interrupt with no work for %p\n", vq);
>            return IRQ_NONE;
>            ^^^^^^^^^^^^^^^^
> 
> I have included a patch that switches virtiofs from spin_lock() to
> spin_lock_irqsave() to prevent vring_interrupt() from running while the
> virtqueue is processed from a work function.
> 
> virtio_gpu has a similar case where virtio_gpu_dequeue_ctrl_func() and
> virtio_gpu_dequeue_cursor_func() work functions only use spin_lock().
> I think this can result in the same false unhandled irq problem as virtiofs.
> 
> This race condition could in theory affect all drivers. The VIRTIO
> specification says:
> 
>   Neither of these notification suppression methods are reliable, as they are
>   not synchronized with the device, but they serve as useful optimizations.
> 
> If virtqueue_disable_cb() is just a hint and might not disable virtqueue irqs
> then virtio_net and other drivers have a problem because because an irq could
> be raised while the driver is dequeuing used buffers. I think we haven't seen
> this because software VIRTIO devices honor virtqueue_disable_cb(). Hardware
> devices might cache the value and not disable notifications for some time...
> 
> Have I missed something?
> 
> The virtiofs patch I attached is being stress tested to see if the unhandled
> irqs still occur.
> 
> Stefan Hajnoczi (1):
>   fuse: disable local irqs when processing vq completions
> 
>  fs/fuse/virtio_fs.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Fundamentally it is not a problem to have an unhandled IRQ
once in a while. It's only a problem if this happens time
after time.


Does the kernel you are testing include
commit 8d622d21d24803408b256d96463eac4574dcf067
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Tue Apr 13 01:19:16 2021 -0400

    virtio: fix up virtio_disable_cb

?

If not it's worth checking whether the latest kernel still
has the issue.

Note cherry picking that commit isn't trivial there are
a bunch of dependencies.

If you want to try on an old kernel, disable event index.

> -- 
> 2.31.1
> 

