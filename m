Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD43640F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhDSLuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238943AbhDSLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618833001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OeTmn3FpbFUKffAvSBuF9L9RSoOACTtnRhAzQxRMNI=;
        b=ZlBbfp0klhF4Qd/5iwSm7PtEjR5KcN/fLfNZWhG2D0YZRgwKL8v+GvcxvKdZi6ouer7Gk+
        3RKnIca/2O748IEX8HabsQ3PBZQF561BVjREY52VQpOhW0aGS2mFdGlJ/BC1cv/GJjYHhx
        De8wd18PtUhDBIRjwPEBMCc93alb4Qw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-zbF6XZwGOA2jW4Jvzx-hXg-1; Mon, 19 Apr 2021 07:50:00 -0400
X-MC-Unique: zbF6XZwGOA2jW4Jvzx-hXg-1
Received: by mail-wm1-f70.google.com with SMTP id v65-20020a1cde440000b029012853a35ee7so3968996wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4OeTmn3FpbFUKffAvSBuF9L9RSoOACTtnRhAzQxRMNI=;
        b=lXiZ8wWJldABYDrd4wyImkowH8dfXhWb9QL6MxaGyxRjFwZCwH2RvL4LTEZeli7UDc
         +SkoUsqfvyOvAremP1QbG7sQEkh3S7eAmoGkSi5zfDA4WNPORXWN+rnEP8oXAr6IFAB7
         KVplHnsf1jqh9fXU6GZD2SHX6hrl0KsyPFQ+7mnZVIgmhjdzE9vqLpOkBIAgzfPSAKra
         GIAqnw35KFIC1MzecFo9/KuV3SH2g9mV5vy6ghLAiQ1iZlVzq5DuZIoOPeZ0jFb7US/f
         GrinuULzeFTlIb7tMab+T35KebuKoQfUhxqWjJzxZYFRtT/+sOECcMOp8lcxrFKdpOPp
         kOwA==
X-Gm-Message-State: AOAM532MuZDxVjFRHvqO4Ir4IAG6ePm8McPFKCdWqDc1MbXfTolsqJCE
        KIlX2HvXPCMZFnlt/0oPDBS1ijflHdcLo6TTLiaHo1TlIiZxroE/3ReGEhp314wfWtoo8YUY4nq
        UCy59QcgPsBLxRKCZWh3NjAhSOFRnhgCpm5fUqLqL
X-Received: by 2002:adf:ec42:: with SMTP id w2mr14074907wrn.373.1618832998771;
        Mon, 19 Apr 2021 04:49:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLwKcD0/QfFrXTpG9Ze8cVc8PUyBjsNLwD4wylL2K1NJkkTxya259K5+FXuzZ/wkYrN2Jsdk/SsSVasMPFFAs=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr14074891wrn.373.1618832998608;
 Mon, 19 Apr 2021 04:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-14-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-14-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:49:48 +0200
Message-ID: <CACO55tu6B5kQM3HKAeMFNQ7TF3vKzsgMVC0J18h+UNeJi-O36Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 13/40] drm/nouveau/dispnv50/disp: Include header
 containing our prototypes
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

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Apr 16, 2021 at 4:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c:2599:1: warning: no previous pro=
totype for =E2=80=98nv50_display_create=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 351f954989530..4905ed584ff48 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -68,6 +68,8 @@
>
>  #include <subdev/bios/dp.h>
>
> +#include "nv50_display.h"
> +
>  /***********************************************************************=
*******
>   * EVO channel
>   ***********************************************************************=
******/
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

