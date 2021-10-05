Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9484232CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhJEV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236093AbhJEV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633469253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwFfE+Y5InXuG9Mab93GHBXLo4VdByGAgXtkzB6nG04=;
        b=fHfdka/zfLwvLoBw7UygiX9NKpcVNSmzjMELbxOBetR9ukDCce9zyQzD1IYr/e1Baso3nZ
        DNEOqwqKjws0E/CrXd+ignQFbV1c49S8AWdWuJ9nb6DZ0g9a31pieiEbnIKG8QiIEJ0Uqs
        UZL36cdNKhH/cUVpogjq5M/NNAPkeD4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-I-_bGNB0OKO0gkQJAzLE8w-1; Tue, 05 Oct 2021 17:27:32 -0400
X-MC-Unique: I-_bGNB0OKO0gkQJAzLE8w-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so345248wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwFfE+Y5InXuG9Mab93GHBXLo4VdByGAgXtkzB6nG04=;
        b=J9hP0eIrYLhyq1ClRQdnIS/UwgTcgQEYq037navf4mGwhZam2IpCdNXhWIuSz8HReR
         QcCP7baAR96GQvRbefu1b64k86UUhi1XWW7O/CMTbj7/SPTmQ+Li6IO0EaT7BqDOKBrq
         UR/DpsBT1L/5hKvW6ePuWq6KtiAj4k/UL9s4S9V4GtCs6wfcQalxiyfNBgp7KRdSCDQF
         5rfBjURUQKG+0aXj01pUi82+h9kwOdP1tzmzIdqjsCKBoWsIYp2gkIohEN19KntUpfCp
         OU1xWHwXpvr4CNFnKn9+mubWnBo5ZfO/FjAmIzRHKvKLVHOIbdc0MS/4Qb8E4NBS5TFO
         5q+Q==
X-Gm-Message-State: AOAM5301X2UP2xKa/4ST62QTAkL+VeHQYevyfh+BdSKDE/kXF7ibn8Ab
        lZvZ1rvhUXDkUIGHCXwa03vQg0yj06Wd7KGx2nKgID80+ESWfD0+wa3Otak//gKhhLQl+IVno9T
        jW/Yv20fAn0uRng1+1Jjr/ASU2WHhGaSFILmTFnLp
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr6013043wmk.141.1633469251524;
        Tue, 05 Oct 2021 14:27:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI6arb7Nu/LjPRQIeObx0l28qGXQBbA7WeXp9gAXr9AfEhUSIm9b8jErwZn57n5uHfE3BhTGBeeSFglHTNUn4=
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr6013031wmk.141.1633469251335;
 Tue, 05 Oct 2021 14:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210907122633.16665-1-cymi20@fudan.edu.cn>
In-Reply-To: <20210907122633.16665-1-cymi20@fudan.edu.cn>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 5 Oct 2021 23:27:20 +0200
Message-ID: <CACO55tvUuZJD_AOgxS=Ts3MBhXkJARwWapF6QaxQqTk0JG7zWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/svm: Fix refcount leak bug and missing check
 against null bug
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it makes sense to add a Fixes tag to this:

Fixes: 822cab6150d3 ("drm/nouveau/svm: check for SVM initialized
before migrating")
Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Tue, Sep 7, 2021 at 3:20 PM Chenyuan Mi <cymi20@fudan.edu.cn> wrote:
>
> The reference counting issue happens in one exception handling path of
> nouveau_svmm_bind(). When cli->svm.svmm is null, the function forgets
> to decrease the refcount of mm increased by get_task_mm(), causing a
> refcount leak.
>
> Fix this issue by using mmput() to decrease the refcount in the
> exception handling path.
>
> Also, the function forgets to do check against null when get mm
> by get_task_mm().
>
> Fix this issue by adding null check after get mm by get_task_mm().
>
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index b0c3422cb01f..9985bfde015a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -162,10 +162,14 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
>          */
>
>         mm = get_task_mm(current);
> +       if (!mm) {
> +               return -EINVAL;
> +       }
>         mmap_read_lock(mm);
>
>         if (!cli->svm.svmm) {
>                 mmap_read_unlock(mm);
> +               mmput(mm);
>                 return -EINVAL;
>         }
>
> --
> 2.17.1
>

