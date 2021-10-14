Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA642D07A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhJNCfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhJNCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634178790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9syLy/5lFT2IgnWtiCBBV/6jUpNv+u7xCyBw4FzVlk=;
        b=NRA3LDlxnIkWVxYreqWaEJ+0GyNOpGXiuRJuPw4CvVRLNtr2gmGy0xWjP3BFzvSWzicYS7
        tm+x/VnQgubjOR+okIAYfu0IfEj+znBtG2WgF6T8OOq+RmcinW+aue2S/wptlDw5HTKRmt
        6WHrj4/wYQwrDE02ytiZnl0OY58T1Eg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-LCLKH96eP7OWEDpDy10PQw-1; Wed, 13 Oct 2021 22:33:08 -0400
X-MC-Unique: LCLKH96eP7OWEDpDy10PQw-1
Received: by mail-lf1-f72.google.com with SMTP id bi16-20020a0565120e9000b003fd56ef5a94so3342558lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9syLy/5lFT2IgnWtiCBBV/6jUpNv+u7xCyBw4FzVlk=;
        b=H1goZR/dy7vWNVAsw4rDiA77WWxGFdPrJLNYW2lQlFRRlT1Mr75UGnPYXLR2stRf9M
         ik/uCR2tN93OPcqortWc2FeaJOKcAAaO+n2k0NKG6uJ6wBfIZRQ+mbhuryhsK0CAmRMk
         p4SfEmB7qEWsT3eJyLCQpewnytTRpl7hKuLcKC76e+FMsYsSUIh/FjRzGUjULJuL9qsL
         xxT0M/TyN923KGhUjL8MYM/zox6VlMcstu3y95qaDLX2je9I+g1MOIj2IVHLg0fOKaBJ
         pYfuJznIOZUT34ahzF1yor2sw4dXzO1APkOfYXrEAUWIr1r9s1lBApGgRp7GnhR5gF72
         V0Jw==
X-Gm-Message-State: AOAM532jgqYk6/L9hPib5tSnmpOPBUplvOmz9+87zZjyJd0QdAgoHwmJ
        6eJyTYgZJbYWRh6sz/nxGMDZWPkOowRyGal4+U8CRZSj6Rt4BbJm1nMUTuUZnh7gPb3aqSacYS4
        vklM0iDUmBK/D7gQDJfauuJc08uKn99VnCdAydaRa
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3210316ljg.277.1634178787282;
        Wed, 13 Oct 2021 19:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf3YgJ//fIl53fImLAabG4WgjCSQL4ncBCHKGjYUsyRMheyzyU8vNl+89MVuLRmlHLKUWqwEmhcjG6EPGYqPM=
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3210300ljg.277.1634178787098;
 Wed, 13 Oct 2021 19:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-3-jasowang@redhat.com>
 <20211013060808-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013060808-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 10:32:54 +0800
Message-ID: <CACGkMEvzkomOzeQLEE91v79dRY_CtzUJMHTvUeg3Zt7R1J-QTw@mail.gmail.com>
Subject: Re: [PATCH V2 02/12] virtio: add doc for validate() method
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 6:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:17PM +0800, Jason Wang wrote:
> > This patch adds doc for validate() method.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> And maybe document __virtio_clear_bit : it says
> "for use by transports" and now it's also legal in the
> validate callback.

Ok, let me do that in v3.

Thanks

>
> > ---
> >  include/linux/virtio.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..0cd8685aeba4 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
> >   * @feature_table_size: number of entries in the feature table array.
> >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > + * @validate: optional function to do early checks
> >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> >   * @scan: optional function to call after successful probe; intended
> >   *    for virtio-scsi to invoke a scan.
> > --
> > 2.25.1
>

