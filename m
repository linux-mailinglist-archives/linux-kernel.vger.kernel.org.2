Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BB4232A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhJEVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236697AbhJEVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633467930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfl0QljxqRN6yI8SUHIl8xNQ8TUgxD9hmUMeCkJYtjg=;
        b=FEuR2DOQ3Yd0+H68rqBN3BSsamWEnANjpklj8vrYUfM88Ap9nqOICEqZQUk9BsevHwENZn
        fazPBsqHrPHhtzFkvZ7k08ovfeH9ypyxlMQnKuWf47f/5GCBIGOkl8F9ytHbep0fvYHqku
        i/08j0MQcexrmMXGC6Y+28+1sT2zjRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-NNwi7a0NP3OLeMd2xIXB3w-1; Tue, 05 Oct 2021 17:05:29 -0400
X-MC-Unique: NNwi7a0NP3OLeMd2xIXB3w-1
Received: by mail-wr1-f71.google.com with SMTP id o2-20020a5d4a82000000b00160c6b7622aso222103wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfl0QljxqRN6yI8SUHIl8xNQ8TUgxD9hmUMeCkJYtjg=;
        b=Tuyn2iMUlvAMVJ6PCoA3YXskO6DJPvLoGk3uOZBgTp2FYXdnYLSBn9gpie38b6aQZj
         7/P5zsU2+9M5NfRTjUnfAdK7bfIGUONCnIuuzV17ZZVLv7ldEEi4fkrrEcfLSXZiKDdA
         fx3tTKmHQe3hWDv+H4GPqRi9m0+mWsyvenyq8KzdaPQNfA0iEga9IYtb32JI7hZ/TX7r
         amhWWlQ5TozpgrdCGk+8Kd6Rz+2rtohDtvoKjPU1/nW2fcPEs3Tpg9NMWI0qAsvS1H/s
         iDkydxzC54fKK8R75gX88N1CVePz1Ti6sAUFSighLYbq444R0VfTlPshNl8geIEepSq8
         NEJA==
X-Gm-Message-State: AOAM530UICMoVa42GeNXEOoatCoV53q0zfXABLgsiXeBmtxF89S7EMGD
        cUej77vygB+UljtisSDln9M+ZJyHIpkhxwE7i0KCetD/QkkFxkSOUEI6cHKZcdIa952XkI8T0Bf
        fN3qGCbLjUzbulB57ynQp90+yLHd1kTJbafBSUbot
X-Received: by 2002:adf:a48e:: with SMTP id g14mr20425032wrb.11.1633467927806;
        Tue, 05 Oct 2021 14:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiloegc3LkQgPGDy2mGV9rNwvfCW4BBiNUOpQ5JaCgezh9eZPz8MNKKjRvqx+jq/zeUAXhbeGE8En37pMb/tg=
X-Received: by 2002:adf:a48e:: with SMTP id g14mr20425022wrb.11.1633467927644;
 Tue, 05 Oct 2021 14:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210401141731.1684236-1-yangyingliang@huawei.com>
In-Reply-To: <20210401141731.1684236-1-yangyingliang@huawei.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 5 Oct 2021 23:05:16 +0200
Message-ID: <CACO55ttptSsD05p5b8GWnBfjSoN-QK6N5urR-JUthqWeiprB8A@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH -next] drm/nouveau/gem: remove redundant semi-colon
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

sorry for the late response though.

On Fri, Apr 2, 2021 at 12:28 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index c88cbb85f101..492e6794c5e6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -303,7 +303,7 @@ nouveau_gem_set_domain(struct drm_gem_object *gem, uint32_t read_domains,
>         struct ttm_buffer_object *bo = &nvbo->bo;
>         uint32_t domains = valid_domains & nvbo->valid_domains &
>                 (write_domains ? write_domains : read_domains);
> -       uint32_t pref_domains = 0;;
> +       uint32_t pref_domains = 0;
>
>         if (!domains)
>                 return -EINVAL;
> --
> 2.25.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

