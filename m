Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEC3640E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhDSLti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234081AbhDSLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8/WB5h/DCpqWz25sPbtK613PP91ho7sThr7U3NsdLI=;
        b=OEtl5oYZ0J24OGiW5ijqjxbuWwts0PrdNg4U7v0JVJfqSRLgU3vRSLTYnVczKd4vxsOrxB
        YhbdCU3661vXSvGgXqwjROjg41pLL4VOKZROu5SV+Bx+CIYK2SPwZ05xxYkZIKxrPxLAju
        EsncctTIf4A0U80NBZ4ASwMFzZDx8ag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-Fh0QZauRN2StP-3MSqTJTQ-1; Mon, 19 Apr 2021 07:49:02 -0400
X-MC-Unique: Fh0QZauRN2StP-3MSqTJTQ-1
Received: by mail-wr1-f71.google.com with SMTP id l18-20020a0560000232b02901026f4b8548so8941428wrz.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X8/WB5h/DCpqWz25sPbtK613PP91ho7sThr7U3NsdLI=;
        b=L5nCwI/w2uA9dReEJX0rkuu5HUCYZm3qy+fxug/EDkvbfvHNla2qPSdsdiMn60Q93N
         Q1mQpV6H4KlmMSvIEeYTmJ1rgIcP5o02tSZkbzvvjoMizkmg1tM+0MZwX1ItgPFCPUnh
         Y+O4dNpp1eo+J2OGd01Pmak64zpsLKbuJ2KGvsjZydj8Ar529TUbNBnTrZBsQgd0ItOR
         +aqCy5VkVyQERqyutZOlJWQcSFE/5mQQgWREUrhtbG8I+fduT9Y9jCAPoArdgx1Mjr5t
         tVbaBNfNafV/C30JVe8bfxA+DpqC4j/DL5Y8p+rm8z2GZ8JA8a6lXQeOQkMeyTC0JD8v
         U0QQ==
X-Gm-Message-State: AOAM530Pbh0RdAYFsTZVFMWFGYIYq5ks41IcyZDQl+haQ7PfzEgruvn4
        5fGLKjT9Oz63j8hOWjzgL3PnDLayBr862EBi+sY8T4tZAKHPq5N2pLrg+fCNMSjvJbfACoTCs2R
        QYlXbLCIGTYDP20Gp7A/0PJtEGhGQgV/57EvPxpIO
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr21036159wmr.139.1618832941559;
        Mon, 19 Apr 2021 04:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqeEo6baFAOSCC5EED8Adjw7elmBbplC1HwyVdu+epP3qNnST1SJ2pLkLV0oLFm79ijqBFSPkWTkiLHj2i6Lo=
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr21036144wmr.139.1618832941419;
 Mon, 19 Apr 2021 04:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-16-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-16-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:48:50 +0200
Message-ID: <CACO55tvbVFPfjzTxmoKMbxVv1bR9xguX+QCLZawtg2SdSN9qzQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 15/40] drm/nouveau/nouveau_svm: Remove unused
 variable 'ret' from void function
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
>  drivers/gpu/drm/nouveau/nouveau_svm.c: In function =E2=80=98nouveau_pfns=
_map=E2=80=99:
>  drivers/gpu/drm/nouveau/nouveau_svm.c:810:6: warning: variable =E2=80=98=
ret=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index 1c3f890377d2c..26af6ee915368 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -811,7 +811,6 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm=
_struct *mm,
>                  unsigned long addr, u64 *pfns, unsigned long npages)
>  {
>         struct nouveau_pfnmap_args *args =3D nouveau_pfns_to_args(pfns);
> -       int ret;
>
>         args->p.addr =3D addr;
>         args->p.size =3D npages << PAGE_SHIFT;
> @@ -819,8 +818,8 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm=
_struct *mm,
>         mutex_lock(&svmm->mutex);
>
>         svmm->vmm->vmm.object.client->super =3D true;
> -       ret =3D nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*a=
rgs) +
> -                               npages * sizeof(args->p.phys[0]), NULL);
> +       nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
> +                         npages * sizeof(args->p.phys[0]), NULL);

yeah mhh.. I think this one is actually fine, but it might make sense
to still report something back, although in userspace we still don't
care as the CL API doesn't return any error.

>         svmm->vmm->vmm.object.client->super =3D false;
>
>         mutex_unlock(&svmm->mutex);
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

