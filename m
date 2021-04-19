Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFE3640EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhDSLuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238909AbhDSLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Nvnr/mWvz+T6laJ/pjEcnY0Y4Tpa0q+5QaX0V8C0qs=;
        b=jLE818sfJNucl2yE7RyVGHyxXTaSNvZTr/Uhi+HUpXsrfHyh0QmMU/tVB46Kdha5yhSWnW
        n7XNBnX+DNqCqb7YCB4UU8nZAZg8YRPoL1xCACsud4jZ7pVbDmbee7ggYKsMJqUMSs06Yp
        SjfKtwSeCNgrN6FllngFlb8/xvvyBes=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-69tz6OWNMeau-IOoT36AAA-1; Mon, 19 Apr 2021 07:49:31 -0400
X-MC-Unique: 69tz6OWNMeau-IOoT36AAA-1
Received: by mail-wr1-f70.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so8940124wrl.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Nvnr/mWvz+T6laJ/pjEcnY0Y4Tpa0q+5QaX0V8C0qs=;
        b=E/3l0DsmVVVhhkDn+LdDRUklFN6NX/iAjVjdPV7FrNmRHFbWlDXIfU0hi5WpIYY1PN
         uIDwGHhF6gzaarNRByOnq8yLpJzZ5LVHyaT1ydDrmyqnbN2+KhaEbNlavkqv03sBWya5
         b7HHLRVMOtjZMCGqVAOfrHukzi2Ljv1HmRmJ68npMKiJCDDwtbDkB5SWMsL3CDu2Yyxx
         0on3UE2+97E9Xuz2OLGlSrkSscJMYEIBEFeGpdb+VFHJaKxc4JCr2aeuMhBiPbHiUTc7
         LSi9EsiGEM6FZ5+J23OMOBhyrFcXYiq7/ktD4qt7PfEBhsqPgZzcQwMz+ZZDf8Hizonr
         WFhQ==
X-Gm-Message-State: AOAM531SUkyO8J3wwO+IMiqCEuwAoDncNYWa5B25tyJo8hb3iOxkCZ6T
        no91j1QDqQsw6b5dbJrnMo2hdCujFN02cCtOGF3LiDTXZ/T4RdSRpxfoXWjFNgjdO9dbG/HfBAV
        FdX0n8tVKyDoKNjLBiy4RCQhfY+ywgZ+I0SG0y++1
X-Received: by 2002:a1c:1f52:: with SMTP id f79mr21592716wmf.171.1618832970138;
        Mon, 19 Apr 2021 04:49:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbWHC/ooj/VbZZN3N0wPL5QrNvrPzxuDU9v2cQf3Sv9GVLeLTyCV/rsvFtv2/ZSANB/M4j+9FNq3XLJqeWUPY=
X-Received: by 2002:a1c:1f52:: with SMTP id f79mr21592702wmf.171.1618832970007;
 Mon, 19 Apr 2021 04:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-15-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-15-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:49:19 +0200
Message-ID: <CACO55tsz_2G0aozzLXK_X7Hyw+Y0dtR=YdGi=sP73zdNnor1_A@mail.gmail.com>
Subject: Re: [PATCH 14/40] drm/nouveau/nouveau_ioc32: File headers are not
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

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Apr 16, 2021 at 4:38 PM Lee Jones <lee.jones@linaro.org> wrote:
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

