Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C3459A06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhKWCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:20:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232317AbhKWCUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637633819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecCKMHgh1nP5alHe1rExeQVJFcZLj5dbAYvcIuSvMp8=;
        b=VG8Xqdyi/3vrjMtWhIk9rx182nOzySy9PxzY/2qbbn7wODOsrCOcY6SN49JLX66a0NUoqD
        RTVcPP5GI+5V0a0+L8bebxZi824bPpTcnVD6YNMfIaEtVTIjztuAdWk289i97t/lprwf4u
        G3oFEDBfUbtTJK7Vl0yl8km3IktEeBk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-yqRWHohbNU254HmiY57ESw-1; Mon, 22 Nov 2021 21:16:58 -0500
X-MC-Unique: yqRWHohbNU254HmiY57ESw-1
Received: by mail-lf1-f72.google.com with SMTP id 24-20020ac25f58000000b0041799ebf529so51589lfz.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecCKMHgh1nP5alHe1rExeQVJFcZLj5dbAYvcIuSvMp8=;
        b=a/Yvne/2txz+WgcIDIwOTziFgFCNoIbGdRv+rEBAExNn5fNe/r0U2ubJiuOH0l+Ntb
         +koikE6JAsoecp9tZMEnX88VhN1EmlWUpCzMRnCXFDRKbHiOuIE6RhZHrKfPMReXMwUD
         rfT/kRuuwMqK3DBht2URa/1Os4t+H5Xo1cGk9J1C5ArQ6xOLP/Ds77Be1dYvuvxfjJy2
         z6xvkPJ7b8Sa7kU1MoEhIc6V356YdZ1FEN0IKJf7N578Bl8gzxnLRzabLFDwKyWCzMZO
         6tJP8i/vlxl5IzbPrmFniobVZhInOtNkGIfvDTI9lBmZLyusni/UPEu+vCSiKDKigyk6
         /Jag==
X-Gm-Message-State: AOAM533Gmtq+YyR1ruQH113XnkFinjDWcq7MXi1t3ra8jaLbg8a0YVT9
        dVPJ8O8+TILv0O5EQKDPYCVPU3f66VijEa27Ta624hSh0PRUOmTFym0Eb9iTUDvoET9JVLJBLew
        ozON+6mD1TgsN+8Yn1oqJbv6wZWAM3BTlINpYMaXw
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr1123013lfv.481.1637633816981;
        Mon, 22 Nov 2021 18:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZdt/n+KGQPmtzq9KuLUyNSmS94ktfV31AZ4jOSU6mpao1hmU4eoYuLOvVeqk6uzcISZjccIPmcIlCHFZVPA8=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr1122994lfv.481.1637633816808;
 Mon, 22 Nov 2021 18:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20211122160812.25125-1-arnaud.pouliquen@foss.st.com> <CACGkMEsQVVMx_+ezoVZ86xEFuadNOzjwcNBnv+-h-pE0JnXhxw@mail.gmail.com>
In-Reply-To: <CACGkMEsQVVMx_+ezoVZ86xEFuadNOzjwcNBnv+-h-pE0JnXhxw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 23 Nov 2021 10:16:46 +0800
Message-ID: <CACGkMEvXNbAseqQSyJL-7W5VZvEQGnK0WttVYLvGY2btJ_mTPw@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: don't let virtio core to validate used length
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:15 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Nov 23, 2021 at 12:08 AM Arnaud Pouliquen
> <arnaud.pouliquen@foss.st.com> wrote:
> >
> > For RX virtqueue, the used length is validated in all the three paths
> > (big, small and mergeable). For control vq, we never tries to use used
> > length. So this patch forbids the core to validate the used length.
>
> If I understand the code correctly, the function that calls
> virtqueue_get_buf() ares:
>
> rpmsg_recv_done()
> get_a_tx_buf()
>
> So it looks to me like the above change log needs some tweak? (It
> looks like a copy from the virtio-net patch).
>
> The codes are fine.
>
> Thanks
>
> >
> > Without patch the rpmsg client sample does not work.


Btw, this probably uncovers a bug of the rpmsg device which needs to be fixed.

Thanks

> >
> > Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
> >
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 9c112aa65040..5f73f19c2c38 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -1054,6 +1054,7 @@ static struct virtio_driver virtio_ipc_driver = {
> >         .feature_table_size = ARRAY_SIZE(features),
> >         .driver.name    = KBUILD_MODNAME,
> >         .driver.owner   = THIS_MODULE,
> > +       .suppress_used_validation = true,
> >         .id_table       = id_table,
> >         .probe          = rpmsg_probe,
> >         .remove         = rpmsg_remove,
> > --
> > 2.17.1
> >

