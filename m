Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875D454F50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhKQV2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhKQV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:28:49 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:25:50 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t19so9390454oij.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsu8m7qQZBsyokKQZY/iZgWOtExTquEP9UNXXnM1Y8c=;
        b=b533kvOf4e8JBJ9EkfEo3sj0vhQ75lTR8y1eKODyoirSRFIQuU9CL6bJ6IdUO3dggl
         Hbu31/Ad4e7ESqE+85/dRjFUnvjwJYD50t/92GYwlbRvJIjQkmbLftmZCebSvDfyqNoK
         uQeOK6+l5P6+7UJN2M7oUemyLBu05La8WBbtvkhYkgkwVldALtOSBbaV6l6GtCZKY6iY
         j7kbLGsCFI35kTGidd4bSElsoD8FHEwwqHU/h4YDmaIOvv2l7NT6MbPTcTp7uhSZKMd5
         JLm1FJ2f/drGidY82Qj8/wKCFM7K0ukA9IylajmJE2xgTsj4lTZT+gRKYbRUFvFPHh9l
         Z6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsu8m7qQZBsyokKQZY/iZgWOtExTquEP9UNXXnM1Y8c=;
        b=LhExFQ13Vfm2NE9E1xl5tbLNmdiuJUqt63Mt1L11nBYW8J0k5qf3yKFNyC3BEuH6hT
         +0CFriH1m+OPnhkURuv+9EPDi45aKZomn10CXZ4gEfYXrqDzvcTq45/iz12I7FNGnN4C
         bZ1q72fCBaUArOrurCqx8Bojlu+SPI1Z2o7dI3dks3Vf9q/UkMzS51WlyYIg94dDOgr3
         SIy6MMGxY6nqihRJpUsThIwyx2T1V/8laqxiZoUw3DtJvdUI1vtdyit32t1QTiTBsT0g
         upzqDluMx1wi9YQ7kJwoimyKgqEYjgFhNEaBxDx67t0TpsAQb1hvCWjqIdut56CPtJv1
         pJGw==
X-Gm-Message-State: AOAM530LLXNc9+XBWKcZA+wcIHBG7DvrMhvpYf/gKzlGruW1UOVfDfg1
        dpJnKRta7IALIRehbrOVUO2QTHXgauaESTCBcYY=
X-Google-Smtp-Source: ABdhPJy5h/L+MOfdOoOjqkVwS+fSx+XGB7jC6qbNniJ83Ca/X7uM2gYzZJqyGXoZ9O04fFdc8zN5edaSaWWn8c3+glY=
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr2808864oic.123.1637184349846;
 Wed, 17 Nov 2021 13:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20211115071429.7314-1-bernard@vivo.com>
In-Reply-To: <20211115071429.7314-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Nov 2021 16:25:39 -0500
Message-ID: <CADnq5_Nj46a0mOHKcR-Y__fucV9Ug7EpvtZphFfWMTHtaoGfkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: remove useless break after return
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Evan Quan <evan.quan@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied thanks.  If you want to make the numbering more sequential,
please also update the other dce files if you make that change.

Alex

On Mon, Nov 15, 2021 at 2:14 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This change is to remove useless break after return.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index b200b9e722d9..8318ee8339f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -2092,22 +2092,18 @@ static int dce_v8_0_pick_dig_encoder(struct drm_encoder *encoder)
>                         return 1;
>                 else
>                         return 0;
> -               break;
>         case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
>                 if (dig->linkb)
>                         return 3;
>                 else
>                         return 2;
> -               break;
>         case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
>                 if (dig->linkb)
>                         return 5;
>                 else
>                         return 4;
> -               break;
>         case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
>                 return 6;
> -               break;
>         default:
>                 DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
>                 return 0;
> --
> 2.33.1
>
