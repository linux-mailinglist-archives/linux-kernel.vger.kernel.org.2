Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064373418F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSJ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhCSJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgleNGeQ16aMvI/a7tBquUukHlqXq2WMoe5SiiWgH/M=;
        b=PO3jwXabE7lCi/+W53eCb0OjOm4PHZ1JXh9kgQkQOnx3lggfOx/8nYAdvGg8KPBXGOMTV0
        hgTd0ZHuPg79xIDmUhLg91zsUbyExy3pwHFtzqzwTPOJx6DevqfIwQyiI+7wEZR4EEoH8K
        DVfu1JE1ntfOurUcVadDy47wb+K55hA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-W-ZpCN4hO6qsckxKNBoiAA-1; Fri, 19 Mar 2021 05:57:31 -0400
X-MC-Unique: W-ZpCN4hO6qsckxKNBoiAA-1
Received: by mail-wm1-f69.google.com with SMTP id v5so12686557wml.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgleNGeQ16aMvI/a7tBquUukHlqXq2WMoe5SiiWgH/M=;
        b=EJUfn5lS6Q4k+YPrQg4s7xLD13q7E4P1sh/8BeqKuy/nSdMBON8Q2PGXoB/nRYXN/S
         D+nTT3atL2yBnM0R23rCsyVSCQEUsW1+ZpOxpZ37luioxgqndiag98rd8qOqMviOicbG
         smGAQkpRA0lcerj8JGWbfbEb5x1gtRcHGU4d8dT8C6KztyZIE/W9QPLU3TyLzpKxeuDX
         CUILFzV4BuE7sl7QmJdUL/j9gZsPVrk38zREGv1CQgqpbXFJ+ET4LyO6so5PVurgkPL+
         hWmRhNUc2jNj07wRnV03Lx3LD5POtLWvocU4JGaE2BApd9/F2l3VeipZiazABEt9DeoN
         NkJA==
X-Gm-Message-State: AOAM533WuIY3ImdC6DqLY+lU2O8EOrRt1ordn6AzVjMH3ihJu8bF16mZ
        MrQbqfUTNVq7pIRK8mMM/TR5zf9sKby0xS84Zi4ikrzq7uwsuD6RosTQLqljvEZ3mZhNpX17Hl4
        SquE+z1QAG0aNli7fCBiPjrTdTpvwnm70bd3W2KhL
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr3595025wrz.373.1616147850301;
        Fri, 19 Mar 2021 02:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyodC37R41eda3GZ5ZIkrkElEd2nIrO+/K3P2l9TcTShBgK7E6mIX6v+y8SYjujCKVkuwpVpy49XjH2/oX0tZQ=
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr3595013wrz.373.1616147850147;
 Fri, 19 Mar 2021 02:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-18-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-18-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:57:19 +0100
Message-ID: <CACO55tvmj1-_ZcmLyN0tUdrH1QzN2c23-a+bDBXCKEOEsiak9g@mail.gmail.com>
Subject: Re: [PATCH 17/19] drm/nouveau/nouveau_ioc32: File headers are not
 good candidates for kernel-doc
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
>  drivers/gpu/drm/nouveau/nouveau_ioc32.c:2: warning: Cannot understand  * file mga_ioc32.c
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
> index adf01ca9e035d..8ddf9b2325a42 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file mga_ioc32.c
>   *
>   * 32-bit ioctl compatibility routines for the MGA DRM.
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

