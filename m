Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5C3418F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCSJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229838AbhCSJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s0PczpDbwsPC5lQkBB89vq5oDLbkXKIf3dA1wCttmZ0=;
        b=hha9aVk8CgJWMmc5rukCMr29PPMMr2FxK5NwAhUKnaiKHb1jjbhlkjP8nBEVgzfXv/LEJq
        t24LN1oF0ZVNlAdgu5Co14WTOQAsUSDZKV2PcltLFmUFoaP9zVVGVErcuyRfGXzNXJcgie
        fNT3n4JlxZOzdlr9ALixqUCxZrM+/qo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-3ZSvPL5pMyKKYwp2iB88Dg-1; Fri, 19 Mar 2021 05:57:22 -0400
X-MC-Unique: 3ZSvPL5pMyKKYwp2iB88Dg-1
Received: by mail-wr1-f70.google.com with SMTP id r12so21601391wro.15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0PczpDbwsPC5lQkBB89vq5oDLbkXKIf3dA1wCttmZ0=;
        b=nyttcTwXJTN/wcK6lebFAT7mrr5qCsfEM0sm8IvA9zu1CvDEnKExJs77HPAMwPFiyS
         l1nkIPhtG5RTUyAZri6DDLRE1NVMfMBMnd49kydj0iF4Wv2owoMZH7a4o3Ju3UcAhTE5
         Gb+t/D9tfCSiLGERr64qLM1nha6JE4qHOP6eQSZICA2MDk5EhLNxL5La6iewNC8mh4jW
         c+28c27H58DVy6FoPEA5MJlkCo08om6lMYNxhpjyTqc2CsS6erkbpIuG2uyzpyVcKxXA
         QuWMahDY73qdEeLokRabunBEb1qdm5pIQvvJjjPSJhalGmaKb5wEPz0Rxi82yKaRLxve
         IewQ==
X-Gm-Message-State: AOAM531HN+alAE81oKnWin0p6c6eCXxD4mW5LXlmmCDAAYSlx88C12f3
        WCVVYqOSaUPlGkOwsFJjCG32P+nr4tkXofF2V9KHEnTxM+GGWMQFqBfNJiuzFGASqCa0EGR3DIY
        IgpoXpLDf/9FtYzknlCwLB1dNRXkGp4is4bQt8bps
X-Received: by 2002:a05:600c:220d:: with SMTP id z13mr2955176wml.1.1616147841802;
        Fri, 19 Mar 2021 02:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOEla5BNWHU1g97Pq8e92rbVtjZyisiqoILIxYNfkNvpqjWZOUdjVvSJ1zyfBh+8SUEzzYdsvjQ9RNg/izpQU=
X-Received: by 2002:a05:600c:220d:: with SMTP id z13mr2955164wml.1.1616147841683;
 Fri, 19 Mar 2021 02:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-20-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-20-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:57:11 +0100
Message-ID: <CACO55tuB4ACS=zFmUCj=q+V0cRScW8N-HgCcejAB5P=n_uNnCQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] drm/nouveau/nouveau_ioc32: Demote kernel-doc abuse
 to standard comment block
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:25 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ioc32.c b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> index 8ddf9b2325a42..2af3615c5205c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> @@ -38,7 +38,7 @@
>
>  #include "nouveau_ioctl.h"
>
> -/**
> +/*
>   * Called whenever a 32-bit process running under a 64-bit kernel
>   * performs an ioctl on /dev/dri/card<n>.
>   *
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

