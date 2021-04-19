Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84BF3640C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhDSLqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233653AbhDSLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNNDgS/DJt2QoriZuV2s4KpJFXyuczWKmKTdkPTzwJc=;
        b=GV5b9jgOPC6wyHw6L97sPQJ1K9s0dHlGDCdfs9aLhVycdXXr9qGdvvWO0qg0ZMi2+Bye65
        SVod2wF3HcciilqSc+6P+GG20OY+WQ/m+ah1xdregCx9lV2IbXXyfgfH+2C0G9e2oaBiGW
        juE/yN84nX1hUZZg91ptzMsjO8m/OrA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-UQGv7nCgNn6_pQ-cn_t30g-1; Mon, 19 Apr 2021 07:46:13 -0400
X-MC-Unique: UQGv7nCgNn6_pQ-cn_t30g-1
Received: by mail-wr1-f69.google.com with SMTP id t14-20020a5d6a4e0000b029010277dcae0fso8885641wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZNNDgS/DJt2QoriZuV2s4KpJFXyuczWKmKTdkPTzwJc=;
        b=dMoP6gj0+i2taU+OboVKaKn/7M3DnQwk4MgWjzqqZY7w9kr91cs+YgtdzpzhobWLSA
         5hmIN42n5j0v/9TG4wymTWKhORLzO0r3ZV/Pm/7Ro8Uw4QdSnAB/lHcW8NgUqkrVFp1q
         rVqMN9295POnCvXh/4NCG4UZYLPkE5YacXQ/zprZEMQJ0HGyKIrTHpn50sCw7Dkc7SB4
         MZ7xTHX3IhMHzRco6FoL/vK0h6+KB7grwB626x4hEc4m+h6WUeu8yk4/6nm2eCXeiAOF
         3JMfSYZY+onBYouFHHJpbA8HILs8CJmgzh5nb6PNl6cIwzQT4QO9cA0BsmsWTgzmzQcL
         6t9A==
X-Gm-Message-State: AOAM533ag6dw0n2cns3QJB4Sa8pkPzoA4jWKnaXDGMZ0r3qqFXW819kA
        HZgTuxhnxKKAFkoEsj4jTkYcSuY8lFdDhgUEfcefSCk+NQewnX8imgJeHnMZjflUPUF8g8nM+YV
        K1nCjPoqYvG5JCPeFb7c3nfxVzLksLatFcGFN7sgA
X-Received: by 2002:a1c:b656:: with SMTP id g83mr21220078wmf.163.1618832772824;
        Mon, 19 Apr 2021 04:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc36e3XbifOKjDUWSKMAEVxvDyobteKY+iWwQTENq4j97KWY9GuD+Osi2UrIND/jrqWxZZjJydw+YBSnHR6jQ=
X-Received: by 2002:a1c:b656:: with SMTP id g83mr21220070wmf.163.1618832772716;
 Mon, 19 Apr 2021 04:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-11-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-11-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:46:02 +0200
Message-ID: <CACO55tu=3H=vEcE6zDA951CqQf1wmKJrVMvBy=EEpp+R5MZG0w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 10/40] drm/nouveau/dispnv50/disp: Remove unused
 variable 'ret' from function returning void
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

On Fri, Apr 16, 2021 at 4:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c: In function =E2=80=98nv50_mstm_=
cleanup=E2=80=99:
>  drivers/gpu/drm/nouveau/dispnv50/disp.c:1357:6: warning: variable =E2=80=
=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
>

same comment here: we should really check if it's better to handle the
error and report it back that something failed or so..

> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 4801aafd9552b..351f954989530 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1386,12 +1386,11 @@ nv50_mstm_cleanup(struct nv50_mstm *mstm)
>  {
>         struct nouveau_drm *drm =3D nouveau_drm(mstm->outp->base.base.dev=
);
>         struct drm_encoder *encoder;
> -       int ret;
>
>         NV_ATOMIC(drm, "%s: mstm cleanup\n", mstm->outp->base.base.name);
> -       ret =3D drm_dp_check_act_status(&mstm->mgr);
> +       drm_dp_check_act_status(&mstm->mgr);
>
> -       ret =3D drm_dp_update_payload_part2(&mstm->mgr);
> +       drm_dp_update_payload_part2(&mstm->mgr);
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

