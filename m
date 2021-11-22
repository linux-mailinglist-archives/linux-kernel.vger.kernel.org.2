Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C206E458878
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 04:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhKVDya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 22:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhKVDy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637553083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZoTqA9iiFG9nkpS66qOwO3q3VJpM/VpcOc+Jqz0mA0=;
        b=TuahKyIb6Hwj1V+4WiaHUKVf31E3U8MKH1BlKvlKtAf6SGJm2KmMmAKUstlF/F5ncW7OND
        isxvUkR+lBS+b8v9INGcqQy/QTQKChGpHDfHzAl+CbSK8UEj9Le5AA6i5UJC6YdL97zhd9
        Bnt9B3eks5rSiUdMMTWtiwUoNQe6a2k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-wibcb-3OP2uemofykEenSg-1; Sun, 21 Nov 2021 22:51:22 -0500
X-MC-Unique: wibcb-3OP2uemofykEenSg-1
Received: by mail-lf1-f69.google.com with SMTP id k5-20020a05651210c500b0040934a07fbdso11112436lfg.22
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 19:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZoTqA9iiFG9nkpS66qOwO3q3VJpM/VpcOc+Jqz0mA0=;
        b=VepkYSSaPUxM/oiD3Z2CuXXkFYeemQh9bhAgM9vxSS3j8/S3PP6djPjDOMvHVSDFUX
         dXPoHeCeGGpX9BWAhV+p5RNwJVm87nk/p73srpGYKTuNX2nvD6BrMMPO6KaPbZ5O/1p7
         Hz0X/mVycgfAIF0GZRIpsrOX0F84o54NuML9ZX48XEvmx/8n6Z2B8zcj4h/4bFZmwg4U
         I7TBmPs6wjlCYf+0ZsN3RV45fq8LQGhGAHL6Co4SZKx12aVc2fSJjETtsTr8vr8gKJGo
         znjWxu1gPMRxFhNGkeFHsnyDYXbR0xCY9m5wIXIrXuAwksQvKLCy/NnZLr9EJ9lgHfuI
         DNfw==
X-Gm-Message-State: AOAM531Vzt56cVkAq6PxqsEO74BFwqW0F3hc99818W8iOPsAKgzkqsJi
        UbvEf45y1Z7rGg5Htkx9UAENGJZszKMwOMEvqy/HHTnQ4ncyzQ015eg0L4gnJ49Cj+dJOYkNFjY
        7YZ3364MGdz9b2f562u/spASJdZDJGLVY01TvTpRk
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr55542520lfv.481.1637553080340;
        Sun, 21 Nov 2021 19:51:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRhp3qnggyh9IV/j+nxJud16x/I5z46Jl3/q8pwRp7lFSjvOjUZebdYRAYcWh6jwM4VsQB8bwBiyV068HiNRY=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr55542487lfv.481.1637553080159;
 Sun, 21 Nov 2021 19:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com> <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
In-Reply-To: <20211119160951.5f2294c8.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 22 Nov 2021 11:51:09 +0800
Message-ID: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:10 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 27 Oct 2021 10:21:04 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch validate the used buffer length provided by the device
> > before trying to use it. This is done by record the in buffer length
> > in a new field in desc_state structure during virtqueue_add(), then we
> > can fail the virtqueue_get_buf() when we find the device is trying to
> > give us a used buffer length which is greater than the in buffer
> > length.
> >
> > Since some drivers have already done the validation by themselves,
> > this patch tries to makes the core validation optional. For the driver
> > that doesn't want the validation, it can set the
> > suppress_used_validation to be true (which could be overridden by
> > force_used_validation module parameter). To be more efficient, a
> > dedicate array is used for storing the validate used length, this
> > helps to eliminate the cache stress if validation is done by the
> > driver.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Hi Jason!
>
> Our CI has detected, that virtio-vsock became unusable with this
> patch on s390x. I didn't test on x86 yet. The guest kernel says
> something like:
> vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
>
> Did you, or anybody else, see something like this on platforms other that
> s390x?

Adding Stefan and Stefano.

I think it should be a common issue, looking at
vhost_vsock_handle_tx_kick(), it did:

len += sizeof(pkt->hdr);
vhost_add_used(vq, head, len);

which looks like a violation of the spec since it's TX.

>
> I had a quick look at this code, and I speculate that it probably
> uncovers a pre-existig bug, rather than introducing a new one.

I agree.

>
> If somebody is already working on this please reach out to me.

AFAIK, no. I think the plan is to fix both the device and drive side
(but I'm not sure we need a new feature for this if we stick to the
validation).

Thanks

>
> Regards,
> Halil
>

