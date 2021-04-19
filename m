Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3EC3640AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhDSLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhDSLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8Y5CVyN1MP/Z8t2JSwEW5URSTlMomMVuaaYfv0oBM0=;
        b=dvOaGU3Xjwelx3vXo09K4YYf5HZxBiYt4QCGGFyPQrJmkpgqqpCaDVvALwBUhij3+Mv2PN
        mrWNCGFejujNXVFjp3fiGkW1JOezJQGzGlFE87l7aMmyz/rZBAQyBukVWHYI0A8mIBHp/8
        lpFqcLhE0Lu3Mdbu16PxnykNP3RHypI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-63bsHF2fO9SlcUIZJb7FVQ-1; Mon, 19 Apr 2021 07:43:05 -0400
X-MC-Unique: 63bsHF2fO9SlcUIZJb7FVQ-1
Received: by mail-wr1-f69.google.com with SMTP id h3-20020adfa4c30000b02901027da44a81so8852820wrb.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C8Y5CVyN1MP/Z8t2JSwEW5URSTlMomMVuaaYfv0oBM0=;
        b=hr+i9lb2eB+VazIWwZscivIbEDkj4VScBQSusLGSf5m5wmN41DZ1dgVNjGP1C8ERVg
         2sqUlViOuFulCwhwvOzex35R3y44khmWLomkflgLbg3kQQXQPNC511wz8F7eUYVTDTNJ
         jvbxXM21sNJts1hf1RZXS0C1Lva5udA0F34z8I5PSvhcvmYO2uALnZm3X5WozkEKpCwD
         j022SoXdqCiKAEuDye82K+XlcpkbN/o1irleXWTw+omXIi6RENdHIf1TnrnUQj5o+3Rl
         sMRjb+OMiDWs//P/lIt6clhnhu7VoTDkq/fiFc99ZXDNp4Ql+jq3NOmFWokevix7u5Br
         +LHQ==
X-Gm-Message-State: AOAM5329qWWA7KooywHBS8WOZiwiqarEYOBWdqscqEQr0V0TNGKqScD/
        nRdPpVUGDAR4V8ABKN3/DcJM8Hw8BdsHxzeh+hvWjAWBX/+0+Krjg2vUkFz2ze47pcLT17L/2gP
        gagNXGTRA1jUojj0gOG1UF4tbo1RMCBp9UUGeM/kd
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr13538358wrd.177.1618832584174;
        Mon, 19 Apr 2021 04:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfQUBy2vieiz4RATYX7I0oL2DB8pFKAjVreQXmtZ/buDJbNPRvIUWMiZeyhXngE0AQn6P4cMUuzFKThM/G5Hg=
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr13538343wrd.177.1618832584067;
 Mon, 19 Apr 2021 04:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-3-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-3-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:42:53 +0200
Message-ID: <CACO55tu_DT++t-0Jpf2ksa=poPmyMZH5gDpOLq7gBj6BR7_AJg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 02/40] drm/nouveau/dispnv50/disp: Remove unused
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 4:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c:1381:6: warning: variable =E2=80=
=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
>

not a big fan of just ignoring return codes, I'd rather see it handled
somehow, unless somebody knowing more about the details here says it's
okay.

> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 1c9c0cdf85dbc..4801aafd9552b 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1410,10 +1410,9 @@ nv50_mstm_prepare(struct nv50_mstm *mstm)
>  {
>         struct nouveau_drm *drm =3D nouveau_drm(mstm->outp->base.base.dev=
);
>         struct drm_encoder *encoder;
> -       int ret;
>
>         NV_ATOMIC(drm, "%s: mstm prepare\n", mstm->outp->base.base.name);
> -       ret =3D drm_dp_update_payload_part1(&mstm->mgr);
> +       drm_dp_update_payload_part1(&mstm->mgr);
>
>         drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
>                 if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_DPMST) =
{
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

