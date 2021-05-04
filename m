Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10E33730B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhEDTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhEDTW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:22:27 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F957C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:21:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u16so9840728oiu.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0MpBQXXQXovBmumhU+vevXuEERixPQDIBphGMJ/1Eg=;
        b=eS9ZIMjKfbA79gkqM/if0o/ll0b0hJg4orJQPJNRFHk7eYNAbu8O/2wS892rhv/0i0
         ydt7KLieBtrj44E712kqAVQIiJ/mTOsrTzGB8ohvG6HSoZfZEs1rUyhZHv+s8On1/n9Y
         WUNnW8cdZzFM5sYmOR5BF+BYrCvEoH2DXPjr6p1YQmIlqypJ7w7aNwz2yjaaU+JERf9Y
         8RJuZS8q69DExe7dpglbq+PIoBtNixQR88bJM7+qdO7xaXIM8N+/LZ9Tq7mukJxUrDnC
         nnbXiXCDvG4OhqkvobGzMduzQ/1ZlAtXUi979RvD/2Bk93iQNjNT233LXmSIDPBUPPBF
         qx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0MpBQXXQXovBmumhU+vevXuEERixPQDIBphGMJ/1Eg=;
        b=pccBAlTqSRhDlgiAlEMMEcJjWDEuZ/ye7Hi9LDNtgzNClPi9UJ4aJ5DHoDRqomsx1E
         bzo2/28iPub1Nslxk74msv4Hy63QolQKVtrn6OaEtL3VZoRzvizvKGbqeOmnFRIgyfZD
         tDHzpuPLY5Jdw5TgV/vo7hnC8nzHmuP8d2wJ/N9mlo6NVIXY97Fungv6jphmargBSQcy
         g6K0hY4iKnh/+dj+KUfmLI2sL0M5mKDAyzTdiihjXAyrsemfzA/CQjkUNCbgwvO/+Fel
         TUseW4Urcm/FLv1R1L4kABAyPDJsglYBSIHkFF3TXn0bQEDIXXf2+wn1CplAbiV2iBuE
         EJmw==
X-Gm-Message-State: AOAM531Be1Cu0ZijzWfeT7Gjvat4FAucnhLzlBk7y8/Atk8kvsn7DWMy
        /YMTX6G669mhyLipQ6jhYyLaGHI5srcSGhF6RPI=
X-Google-Smtp-Source: ABdhPJywFB9WXlrVjqngMggBTfwS/CosEWD+ccvn0Upp/auCBQw09pw14KzZN0/jk1umIf2aCBqXfO/ZcKNq5aix8v8=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr18402833oig.120.1620156090910;
 Tue, 04 May 2021 12:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210427094449.14730-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210427094449.14730-1-fmdefrancesco@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 4 May 2021 15:21:20 -0400
Message-ID: <CADnq5_NGWrsxaxJqE+_y7Lm4Fdx=BkZYAaYWz_VACAVSgV-ivQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/amdgpu/amdgpu_drv.c: Replace
 drm_modeset_lock_all with drm_modeset_lock
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, shaoyunl <shaoyun.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 5:45 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> drm_modeset_lock_all() is not needed here, so it is replaced with
> drm_modeset_lock(). The crtc list around which we are looping never
> changes, therefore the only lock we need is to protect access to
> crtc->state.
>
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Applied.  Thanks!

Alex


> ---
>
> Changes from v3: CC'ed more (previously missing) maintainers.
> Changes from v2: Drop file name from the Subject. Cc'ed all maintainers.
> Changes from v1: Removed unnecessary braces around single statement
> block.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 80130c1c0c68..39204dbc168b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1595,17 +1595,15 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>         if (amdgpu_device_has_dc_support(adev)) {
>                 struct drm_crtc *crtc;
>
> -               drm_modeset_lock_all(drm_dev);
> -
>                 drm_for_each_crtc(crtc, drm_dev) {
> -                       if (crtc->state->active) {
> +                       drm_modeset_lock(&crtc->mutex, NULL);
> +                       if (crtc->state->active)
>                                 ret = -EBUSY;
> +                       drm_modeset_unlock(&crtc->mutex);
> +                       if (ret < 0)
>                                 break;
> -                       }
>                 }
>
> -               drm_modeset_unlock_all(drm_dev);
> -
>         } else {
>                 struct drm_connector *list_connector;
>                 struct drm_connector_list_iter iter;
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
