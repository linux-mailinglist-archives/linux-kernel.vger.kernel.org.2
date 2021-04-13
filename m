Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5335E148
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhDMOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDMOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:21:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:21:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so26257425ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XSb26jWChq8UeB+2eG8t5Jx3KUuQ9YtghNH+PRQLkiY=;
        b=k3pN5OC9G/4r78rKs51gKlPvO4wrZICaChTRKTnSRjLSywsKf07n6zNAkTF9Ne1o4d
         +jFK5LbkH7qequCu3zp6PMfMIm0ZOqF5tQlMU0FGle1bTjVZLJYlQJqn4U8NEhpucNnK
         upY+Bcj95F9aZorRKFwRu8uZpDWhTgjb1el7yjPiVJflv59Bpb45WnIk5jmJLP0/WSUJ
         BbJ41+ChRp+bHpKKF3AwHOPh6M4x+EpQpr9PBhRcCxneHRBxhfbLih/fLud/nBSq/lr7
         WMnE0Jd8qUIx5+9/WdOvi8uPusmIJAX0Vwg0Ct7EoqfpeCxI/6a+2yov8TTZQDnLK2L4
         yoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XSb26jWChq8UeB+2eG8t5Jx3KUuQ9YtghNH+PRQLkiY=;
        b=dBwAgp6yrwDaXD+Tn3WzPmcUEIKqEFmAAnILUIKP+edDLJmpdJM+oTJMye2mn/RtZz
         CnWNu60lYQc4j8zf1Id3SZcgSZ2fxfwSmp2ONd+QfXcP2Uq48YOPyHR5b9/7nTYmSWuV
         6Oji5t4qsJapTPA0K+T3yTB08WSnpsetXfYN3sv2UmYCHYtuKSzl8HxZMsTNzTvgska0
         y+UlkM3K2eRpZ7edJgwhOH5p1V91BV1TZQfwAUAMeVLLivqcxMVOCrUcZOuWd3CgtOc3
         +tDFUfL5AMYi5cyCsylGFQ3cEp3DTNb6dZfDWvpLBkouJfCJ7MEazO501qbhAQZb00cM
         dCdA==
X-Gm-Message-State: AOAM5308s1DcAJWWX3yFbv3YUklxr/bSIcC3tHnuM3jx/8PQjEfxpOjf
        V8uPzpES8lOvfDeTr9mQSntFGqQS/jb73A==
X-Google-Smtp-Source: ABdhPJymdeMv0uUjFWR0CdB8/8ZZeGwkDBV5G3UaD6/U/HYdz7Z/jYamUPyVKggm6swd2pkExAzDnw==
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr32177502ejq.416.1618323679310;
        Tue, 13 Apr 2021 07:21:19 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id gt26sm7368877ejb.31.2021.04.13.07.21.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 07:21:18 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id m9so3922693wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:21:17 -0700 (PDT)
X-Received: by 2002:a5d:510d:: with SMTP id s13mr37457079wrt.12.1618323677563;
 Tue, 13 Apr 2021 07:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com> <20210413054733.36363-4-mst@redhat.com>
 <805053bf-960f-3c34-ce23-012d121ca937@redhat.com> <20210413100222-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413100222-mutt-send-email-mst@kernel.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 13 Apr 2021 10:20:39 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe=3cAkhwjSDDt1U8mSiVj5BKgJ7DJGxAAoF22kac3CMQ@mail.gmail.com>
Message-ID: <CA+FuTSe=3cAkhwjSDDt1U8mSiVj5BKgJ7DJGxAAoF22kac3CMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx
 queue lock
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 13, 2021 at 04:54:42PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2021/4/13 =E4=B8=8B=E5=8D=881:47, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > It's unsafe to operate a vq from multiple threads.
> > > Unfortunately this is exactly what we do when invoking
> > > clean tx poll from rx napi.

Actually, the issue goes back to the napi-tx even without the
opportunistic cleaning from the receive interrupt, I think? That races
with processing the vq in start_xmit.

> > > As a fix move everything that deals with the vq to under tx lock.
> > >

If the above is correct:

Fixes: b92f1e6751a6 ("virtio-net: transmit napi")

> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 22 +++++++++++++++++++++-
> > >   1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 16d5abed582c..460ccdbb840e 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1505,6 +1505,8 @@ static int virtnet_poll_tx(struct napi_struct *=
napi, int budget)
> > >     struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > >     unsigned int index =3D vq2txq(sq->vq);
> > >     struct netdev_queue *txq;
> > > +   int opaque;

nit: virtqueue_napi_complete also stores as int opaque, but
virtqueue_enable_cb_prepare actually returns, and virtqueue_poll
expects, an unsigned int. In the end, conversion works correctly. But
cleaner to use the real type.

> > > +   bool done;
> > >     if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
> > >             /* We don't need to enable cb for XDP */
> > > @@ -1514,10 +1516,28 @@ static int virtnet_poll_tx(struct napi_struct=
 *napi, int budget)
> > >     txq =3D netdev_get_tx_queue(vi->dev, index);
> > >     __netif_tx_lock(txq, raw_smp_processor_id());
> > > +   virtqueue_disable_cb(sq->vq);
> > >     free_old_xmit_skbs(sq, true);
> > > +
> > > +   opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > > +
> > > +   done =3D napi_complete_done(napi, 0);
> > > +
> > > +   if (!done)
> > > +           virtqueue_disable_cb(sq->vq);
> > > +
> > >     __netif_tx_unlock(txq);
> > > -   virtqueue_napi_complete(napi, sq->vq, 0);
> >
> >
> > So I wonder why not simply move __netif_tx_unlock() after
> > virtqueue_napi_complete()?
> >
> > Thanks
> >
>
>
> Because that calls tx poll which also takes tx lock internally ...

which tx poll?
