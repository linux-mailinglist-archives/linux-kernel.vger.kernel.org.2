Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7B41AD70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhI1LAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239306AbhI1LAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632826735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8c+hflDGNsMrT5vO+jy/cfJzWzyzHOCwO8M7rh07Hg=;
        b=B/xuW6vixVRmDx4v88tuEsbmHjHSFMIJaUUojQCCR+8PqPn5UnLV7NckYPAE9CcZ+y5Xse
        /zpCPM2VYi1mZn8W+4CH26RbCVSaasqw4vMR56EFywC6uDm8/FhI7j5tXBZ7N5mJQl2Fyc
        VPq5K01r434y9v/Ln8f7pkkXyV0Um1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-f84SZYzXP46A3XNfylszZg-1; Tue, 28 Sep 2021 06:58:53 -0400
X-MC-Unique: f84SZYzXP46A3XNfylszZg-1
Received: by mail-wr1-f70.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso14966266wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8c+hflDGNsMrT5vO+jy/cfJzWzyzHOCwO8M7rh07Hg=;
        b=WnLJfSqCtLeEvaZSUMvUvS0+2TFpRmeFbFwpKcXDNBfH0Yg9tSoaneXIUgs+k3jVzM
         xRWYF+VIxBWf0CQR0phvZkGKAMunoePwZqOWmjn76rLiZiR3laxnoin9dbqqH1LpCSh+
         arXWyIs8tYxbHFZ79hAeWlec84s8FPxxe+AMqAiCrM1oj8JphlwKIM9oyAVgHMpeg6Rn
         6eoS1Sp7zEtZx0OKeJZnXcaysLzj0ulnoGWBc8hvLo+f5GJLlzy/qG8ojjqj86103Kwn
         D/rm51C0yS6S/hoGnUtfZ7DOfVwvM1InGNygVuq8NNs1eXfPWdbYQld04blbZX297VKZ
         PtKQ==
X-Gm-Message-State: AOAM533ng9edVnfv3qa04X7FZVNemDkKkVAyPjfpzlCLAy/HoPmWlRWJ
        3pLGZ7tfc9MtMPGIsh/sqjKxsUkw09hcReWxfcxpZlWi4jkoiXFOgJbqUN+WPQoqnuWur0o0YGG
        jSx31cvPf/8eNeDrcHtPCpnoumRbpv1mpykWTocOA
X-Received: by 2002:adf:e684:: with SMTP id r4mr5677726wrm.229.1632826732810;
        Tue, 28 Sep 2021 03:58:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygTC0Jp4Je4Y9cx0DBYAkxxSPfYMtxRdQ9C+S8cLTPvi1JkgxasSroln52KwncpyJXM3dc/8k14aIWfFB+2GU=
X-Received: by 2002:adf:e684:: with SMTP id r4mr5677714wrm.229.1632826732610;
 Tue, 28 Sep 2021 03:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210807032054.642867-1-yong.yiran@zte.com.cn>
In-Reply-To: <20210807032054.642867-1-yong.yiran@zte.com.cn>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 28 Sep 2021 12:58:41 +0200
Message-ID: <CACO55tvKSF59imAr3_-6DshDz2wVrTtJ9ZHGfMStc9vgDh6H6w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH linux-next] drm/nouveau/nvenc: remove duplicate
 include in base.c
To:     cgel.zte@gmail.com
Cc:     Ben Skeggs <bskeggs@redhat.com>, yong.yiran@zte.com.cn,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

and picked

On Mon, Aug 9, 2021 at 12:14 AM <cgel.zte@gmail.com> wrote:
>
> From: yong yiran <yong.yiran@zte.com.cn>
>
> 'priv.h' included in 'base.c' is duplicated.
> Remove all but the first include of priv.h from base.c.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> index c39e797dc7c9..cf5dcfda7b25 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> @@ -21,7 +21,6 @@
>   */
>  #include "priv.h"
>
> -#include "priv.h"
>  #include <core/firmware.h>
>
>  static void *
> --
> 2.25.1
>

