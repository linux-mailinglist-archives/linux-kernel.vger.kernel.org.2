Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850FA41D3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348441AbhI3G77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348434AbhI3G74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:59:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E9C06176A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:58:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z24so21005813lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AM58cnJzWheq7pN6e6L+Di8EyxwT/TZuwdLAOFe5lTM=;
        b=zUA02mDiD7ySh4VXdtJEkfF+YdiTY26SnB/zKlU6AV6H7K06hWuMhIkqyICSRgwmLh
         mMJqj75qYMRjZUryj8QznGOt1/uDr4q20FUyRlmfjvyWGDa9fNh1/KqmeTmllPC6LWsE
         x4UA5ycScWSfPjOhkCW04pIaQRZYoSk1kxBDhV5iIfdgOPXgQIurppjGXWQBQKV44tdK
         e3xYCw8TWtFK4EQHVWDRiAj+PrQUHjPo23h+iyjT1HwajPzvid5J/T6xDSKDma7HJFnH
         Cj5iu6tWUHc/wClUvPhMJJqFlksmjgvu0yQ5HqUPJilAeIxDFCaEgOlTE9y+38eHL9g4
         81Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AM58cnJzWheq7pN6e6L+Di8EyxwT/TZuwdLAOFe5lTM=;
        b=0tKq9QDMnmQdIYcWR/Bcr+fg52U/jZCbBjy1CaXjzmGpUOLYgjRUph2c7rTHG7g/4i
         kPPQ4+BS+AzMjoBHud5fGYDj3ZyM9fwCvOEF8j5xBWjG4x/+w3KxUyvEiyFcSgxIQZyQ
         ywZ71y7VDiX8OonIqXNVLFHzCZ0VZ5hKf85PxIhaCPxTL1WmEc/BfTxtx2EMv1ib7BMT
         CKPrxi4IP1PyZE4xfhT9CfesGAvWwExWKRD8ppGNPzcAX1boKwe5FdoJJl7H2pxFphFk
         BvGUenTLGqEQLiTyBYGyrkGhGk6vYCgUfstNNQr+38hHZ9BZgKzYnTp1u78rdbF2YaNo
         8PDg==
X-Gm-Message-State: AOAM532kro/nxyjRBkVCkau1Qgl9ySmOMi1x9X6JWZ4oZPGMrCgfu4pg
        u/TZ1bdhONrKszdWRHN/SBzhMHEkZeKJGHTVOOI80A==
X-Google-Smtp-Source: ABdhPJyBqEgHtMpNYqgONgpO8bSsYcGCUmFFaeLYGEyFgNwtKcwbfga4y3No6ih2UN25mIxw8sdz+lK6j2VMsBbQMOg=
X-Received: by 2002:a19:f507:: with SMTP id j7mr4119788lfb.645.1632985091555;
 Wed, 29 Sep 2021 23:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210930062014.38200-1-mie@igel.co.jp> <20210930062014.38200-2-mie@igel.co.jp>
 <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com>
In-Reply-To: <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Thu, 30 Sep 2021 15:58:00 +0900
Message-ID: <CANXvt5pcHbRVa9=Uqi-MN6RY1g6OY1MDecyhdedqL8Xmv0y6QQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] Providers/rxe: Add dma-buf support
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=E5=B9=B49=E6=9C=8830=E6=97=A5(=E6=9C=A8) 15:37 Zhu Yanjun <zyjzyj2000@=
gmail.com>:
>
> On Thu, Sep 30, 2021 at 2:20 PM Shunsuke Mie <mie@igel.co.jp> wrote:
> >
> > Implement a new provider method for dma-buf base memory registration.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  providers/rxe/rxe.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> > index 3c3ea8bb..84e00e60 100644
> > --- a/providers/rxe/rxe.c
> > +++ b/providers/rxe/rxe.c
> > @@ -239,6 +239,26 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd=
, void *addr, size_t length,
> >         return &vmr->ibv_mr;
> >  }
> >
> > +static struct ibv_mr *rxe_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t of=
fset,
> > +                                       size_t length, uint64_t iova, i=
nt fd,
> > +                                       int access)
> > +{
> > +       struct verbs_mr *vmr;
> > +       int ret;
> > +
> > +       vmr =3D malloc(sizeof(*vmr));
> > +       if (!vmr)
> > +               return NULL;
> > +
>
> Do we need to set vmr to zero like the following?
>
> memset(vmr, 0, sizeof(*vmr));
>
> Zhu Yanjun
Thank you for your quick response.

I think it is better to clear the vmr. Actually the mlx5 driver allocates
the vmr using calloc().

In addition, rxe_reg_mr() (not rxe_reg_dmabuf_mr()) is used the malloc
and not clear the vmr. I think It has to be fixed too. Should I make
another patch to fix this problem?

Thanks a lot.
Shunsuke

~
