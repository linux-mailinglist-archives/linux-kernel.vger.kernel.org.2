Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97DD41A532
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhI1CS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238512AbhI1CS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632795438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjDH+v8vXfFpUX6MvlCaFytflSzUw6jy65GgeDUX/wA=;
        b=WE8LOAPz3CUzPc4JoO3ciwxyLYyeopDo9MYYqlMg3JPKhM9tJkBNox4/2DUIncqbM6tM/T
        Me3637dhX0s1iJGQTieHMAQnwXIBzaui5K1I5mBXWOSuFqAYq1ZnJ4PVDp0ODehxxkmNmB
        rSdIvXZVjpjYguc4FvCI8fQdiU1mEck=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-3b-hPYDuNgSKaKfYnmVtrw-1; Mon, 27 Sep 2021 22:17:16 -0400
X-MC-Unique: 3b-hPYDuNgSKaKfYnmVtrw-1
Received: by mail-lf1-f70.google.com with SMTP id bp11-20020a056512158b00b003fc7d722819so17760755lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjDH+v8vXfFpUX6MvlCaFytflSzUw6jy65GgeDUX/wA=;
        b=AeOP/vxeGOFEgkgvVOiKf0CZDA3n6Y2Gf3qRH9NCl/1CrRCWM4AyQgf8rhWlDhzE0+
         Pvx56oeVxX1XmdJGnDAo5OPK4O4K82Ihor1O4XaPpdM9cHXgjBuyqSJ03a6X9Kq6t1KY
         Y0morVv0YtnSshZy37BpfX3njPdunD4nhsiaM0sX4Lw6sSuK5G9fbXKvRpqCHp0fQMLf
         vUQxf53FfL1Q6F5QPvB8GGL+32Z1MJmYi+IBLS2Lot7fk/TYHVN9dDPhBGVSz2aNCkPN
         4BIV1ttI24ySsFc1B5Cf5owDCoHJIFEpQL4Eqn12Etpx/Phl9EmE+R4Mp0z8kU+0nrAX
         ZvjA==
X-Gm-Message-State: AOAM5304QQR7OlsZqUDhTB4om0Hr2oAH3HZZEGf0FIWhG9CQVfCZMOlp
        yuIWb22PQlXdPy7GCDn/Ra9FEkw2orMxcu77EYkpJvpaVjHx5O/MpUg7XL9lh00FN5p3xHt93iT
        47qUGtauTDrk4cjxjpAilNL3ryzx2InsWQY/OdFKp
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr3023662lfr.580.1632795435029;
        Mon, 27 Sep 2021 19:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9tp6c4VDNDZmHayadbTG+vvHo5VUHS5CIyS5CDuzclWyj25CxSSe/riXLL8VnAe2i7A0xZ1VmyXTPZc6+qTo=
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr3023650lfr.580.1632795434860;
 Mon, 27 Sep 2021 19:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com> <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <CACGkMEt5rQv8DFdsYuJ6SF2YOsh_3YP_yzSsdL3X_n3Mfz3Gag@mail.gmail.com>
 <20210926032434.GA32570@L-PF27918B-1352.localdomain> <CACGkMEtrGtbzNrf96uz9zwZ7ohNg1-dUoMLfL4HWoZwv8Zejdw@mail.gmail.com>
 <20210927063000-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210927063000-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Sep 2021 10:17:04 +0800
Message-ID: <CACGkMEs+s1ArZqgPqwJ2VLMxO9GWqfZNPeLv9BFoHvn6TFHndQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 6:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Sep 26, 2021 at 12:18:26PM +0800, Jason Wang wrote:
> > > > I wonder if the following can work with ENI:
> > > >
> > > > -device virtio-net-pci,mrg_rxbuf=off
> > > >
> > > > ?
> > >
> > > ENI didn't work.
> > > I will remove F_MRG_RXBUF when get_features.
> >
> > I think we need to fail FEATURE_OK if F_MRG_RXBUF is not negotiated.
> > Since VERSION_1 requires a fixed header length even if F_MRG_RXBUF is
> > not negotiated.
> >
> > But this trick doesn't come for free. If some driver doesn't support
> > mrg_rxbuf, it won't work.
> >
> > Thanks
>
> Yea. Ugh. Down the road I think we'll add legacy support to vdpa on
> strongly ordered systems.

I don't see the connection, can you explain why?

> Doing it in userspace is just too messy imho.
> But yes, this kind of hack is probably ok for weakly ordered systems.
> BTW we need to set VIRTIO_F_ORDER_PLATFORM, right?

Right.

Thanks

>
> --
> MST
>

