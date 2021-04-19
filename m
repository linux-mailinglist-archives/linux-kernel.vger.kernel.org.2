Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A43640CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbhDSLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238751AbhDSLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KNIBhiX96SBAEns+eZY4MeATI7Fr3o+QWf55kiN81w=;
        b=XaTePvUbXK36QhJwvnZ1uP25q9CCbBv25m+s139x18KUdEpCBdTOt5j6pWoRACfBzO6jSz
        sFfdpBg+U/8gL0fBRn8XeTOOIVplwM7kWY8ABOzYU8Q+CuR/Wqsb5BSLgGPiL7JWCFaoyA
        muPu2VH8aRf2YaCMJFrK+sNnvCJIZ5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-RT1EFSAwOxiowCLQYNLIng-1; Mon, 19 Apr 2021 07:46:32 -0400
X-MC-Unique: RT1EFSAwOxiowCLQYNLIng-1
Received: by mail-wr1-f69.google.com with SMTP id s9-20020a5d51090000b02901028ea30da6so8891183wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4KNIBhiX96SBAEns+eZY4MeATI7Fr3o+QWf55kiN81w=;
        b=cWLEmYw6oZoUn4cQYsouhQVoxlE0AsHFKbbYcb4Khtb9Ykkoo/gIWTbqNqk04Go4GC
         YBWSA6QHB/4DJr83ox9PCzxfWxMykNCUXyVbLbgh42cJEcv9R7aIbx12HjTKFxPB+FQo
         YYqBzl4M1MVQsVDx0exmVNmcLa7EezuGSyzguDk97gzUccPopImvqm/26k8AzruVq/Z2
         /8V8CITWqW9LNkVanZ/kM1svuk3w9iRIoJlDsNFPqewuE1YRYLNSnepP0oeZ1XxlSnv9
         jSrfv/0Dy3tr2iF1qBTvJLyf95suhup9rzbpb3RKRduGqEbDgnjrl3P1bGDFUDl0/Upr
         yLYg==
X-Gm-Message-State: AOAM531W79y5IBcUSTOjVLhwmuE06wsIq9dMbu6CstvfxRs5w84s43s3
        LNMtfU8na5M5nw2AoAfbmifg6NDXEYL6R3EQWvLe8j3+EH2g27HQzdZ4m7/OAzwdXR/MTkygbUl
        bqsBguw4G9zPK9u2Y8dFefQKZHcV+FQu/KO2skD5Q
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr21147828wma.164.1618832790916;
        Mon, 19 Apr 2021 04:46:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzowTJOaUjO7V9rrnhDskD/pazvcM/Gbrdk15YuD9A3xkWwis/lEV+VVmSDcLCwGuQu5ct6FvqXa0KU8VEG1q0=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr21147815wma.164.1618832790809;
 Mon, 19 Apr 2021 04:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-12-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-12-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:46:20 +0200
Message-ID: <CACO55tu3ZiNYKQgXEYtnt9VMa+FdSXKRfK1atWzY+mfUsr=jAQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 11/40] drm/nouveau/dispnv50/headc57d: Make local
 function 'headc57d_olut' static
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
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous =
prototype for =E2=80=98headc57d_olut=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/dr=
m/nouveau/dispnv50/headc57d.c
> index fd51527b56b83..bdcfd240d61c8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> @@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size=
, void __iomem *mem)
>         writew(readw(mem - 4), mem + 4);
>  }
>
> -bool
> +static bool
>  headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int s=
ize)
>  {
>         if (size !=3D 0 && size !=3D 256 && size !=3D 1024)
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

