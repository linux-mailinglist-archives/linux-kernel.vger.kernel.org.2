Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4C44A505
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbhKIC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242018AbhKIC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636426510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcTad0s1zvICS8LxeQTrtyxxid2izF1mjCXQxAurXKY=;
        b=C91HZ2ZX4BsaB0N6v2sW+Rwk49icfnfB4ZkSG9/SEgz3IPY/TMaumYr+nS2v6EKKdhg39F
        6/hzKZnLRBM8H4igQp/MEl3kepMukgNDnG12WCBrR0mUadK2gUNGF/k/K7pqp2LgBMit45
        vEHTXaCDmpPyTtqBPQFb28lweyaI5n8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-ZIheFP31PzKiPHAXm_hdiA-1; Mon, 08 Nov 2021 21:55:09 -0500
X-MC-Unique: ZIheFP31PzKiPHAXm_hdiA-1
Received: by mail-lf1-f70.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso2673276lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AcTad0s1zvICS8LxeQTrtyxxid2izF1mjCXQxAurXKY=;
        b=WNOrQVggTfqB66kBR9kuPa4BYADyNS1yCErsAQ/CPn8XtPdMfjsqaYzGF9dpFBowoH
         Ix4f6eoVsbHW/71mm0QVJnU1g+YAkFE5UWjNSmFL+ZQnl3d4sgCuudtgk9cRasLjvDTK
         OXTqoZ94A2jHcIFnDogrR6+V65Y6v8i40QkQzaS2qyZxId8/eGRPQEOIgUAXqUOgUK7z
         xHvzSoQPJm1yqQ3lrPFOsiVcT9NYPUa9oGAHvW3cXH879ULl5tDPBF9PkVNJSVmWARqT
         PWRQKRExSl26MYLIipkuHqirW6r1MPWlsnt6N406owxFgZl+8IEXzg9wFRYK2xj5to/X
         ncWA==
X-Gm-Message-State: AOAM5319NSZ0Dc7kwLepHLThBpgl9tl7d++CMAGp+GwNSYvG13AasK/J
        zvKziNxlIEjyaJZn+4HkiLYjwhWBqTWS4rqFCGsZwDtwoyYYObomWlNCd9QH0FlRYieXGK2yoGH
        5Pdl6HF+KbAEXKaW+CNMqYWiWzr5hyvdFKkLbWuio
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr3929568lfg.498.1636426507724;
        Mon, 08 Nov 2021 18:55:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzoTxL0Mk4o67I/bfxIlxvjzL7/EGLPXyM6pWuABUduS0GHa/cGuGMSr7Ifk1yQh3rc/WK2uaYSsPUZAeDPfE=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr3929546lfg.498.1636426507506;
 Mon, 08 Nov 2021 18:55:07 -0800 (PST)
MIME-Version: 1.0
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com> <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
In-Reply-To: <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 9 Nov 2021 10:54:56 +0800
Message-ID: <CACGkMEt3yA+fkFJxKfrXyui-rYVSk78=1AqrT0TYQqzcqTJVyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in 'eni_vdpa_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mst <mst@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 3:32 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 08/11/2021 =C3=A0 06:55, Jason Wang a =C3=A9crit :
> > On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> >>
> >> In the error handling path, a successful 'vp_legacy_probe()' should be
> >> balanced by a corresponding 'vp_legacy_remove()' call, as already done=
 in
> >> the remove function.
> >>
> >> Add the missing call and update gotos accordingly.
> >>
> >> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >>   drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/en=
i_vdpa.c
> >> index 3f788794571a..12b3db6b4517 100644
> >> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> >> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> >> @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *id)
> >>          if (!eni_vdpa->vring) {
> >>                  ret =3D -ENOMEM;
> >>                  ENI_ERR(pdev, "failed to allocate virtqueues\n");
> >> -               goto err;
> >> +               goto err_remove_vp_legacy;
> >>          }
> >>
> >>          for (i =3D 0; i < eni_vdpa->queues; i++) {
> >> @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, =
const struct pci_device_id *id)
> >>          ret =3D vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queue=
s);
> >>          if (ret) {
> >>                  ENI_ERR(pdev, "failed to register to vdpa bus\n");
> >> -               goto err;
> >> +               goto err_remove_vp_legacy;
> >>          }
> >>
> >>          return 0;
> >>
> >> +err_remove_vp_legacy:
> >> +       vp_legacy_remove(&eni_vdpa->ldev);
> >
> > Won't vp_legacy_remove() be triggered by the put_devic() below?
>
> Hi, I'm sorry but i don't see how.
>
> My understanding is that:
>    - on "put_device(&eni_vdpa->vdpa.dev);", the corresponding release
> function will be called.
>
>    - This release function is the one recorded in the
> '__vdpa_alloc_device()' function.
>
>    - So it should be 'vdpa_release_dev()'.
>
>    - This function, AFAIU, has no knowledge of 'vp_legacy_remove()' or
> anything that could call it.
>
>
> Unless I misread something or miss something obvious, I don't see how
> 'vp_legacy_remove() would be called.
>
>
> Could you elaborate?

I think the device should release the driver (see
device_release_driver()) during during its deleting.

Thanks

>
> CJ
>
> >
> > Thanks
> >
> >>   err:
> >>          put_device(&eni_vdpa->vdpa.dev);
> >>          return ret;
> >> --
> >> 2.30.2
> >>
> >
> >
>

