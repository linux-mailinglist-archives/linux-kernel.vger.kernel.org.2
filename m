Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2D39AAD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFCTUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:20:02 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45849 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:20:01 -0400
Received: by mail-ot1-f42.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so6760473otc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVZkEcekhqbnYW1h79/086gtCptoM6ZVrjdw+tbtwF4=;
        b=m0lJeGNhBjHYCOQzf6QJ7imtzvshgDNhXRa/Qu6sOJchVPKw+XP8AlBbhEfZEz21Hl
         JsSa+UYTN32cuGukTWFZaj2uZHXdhCOyfM+AlOZXXhYWFp2wN1A1oT1YGKtFIoY9s1lS
         /cNpqGAu0Sh7e39Pqk6ZhcH3wRIdiSnW09xLSW05P4bnB8lwfpecABd2ldHJNWItVuKC
         4SkXE5AzudSdshpLnbpXsuMBjr1EIVGDIMCJAq3ltvMhtAMl+3Pl637XACOiJRnnezBD
         w/nd1wBOO/mAyRISu005O4MG7pVnZjY4Dtb3b8h1iO4jfDUNmgiGkU1VYCGspxJYRCCH
         4kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVZkEcekhqbnYW1h79/086gtCptoM6ZVrjdw+tbtwF4=;
        b=S1Kx8mRYaks7+ROu10vo+5FSAOfe7rRGU35h0HRZIdRmtpWonSpHYn+oFFWcGjqBs8
         4U/ZOd4/7pCFa6sM99nWixTQmTNY7bB5Y3uzL/VirZn5slAljfrWGMIK96wxsmG93tEO
         oDriSLDOG7jQdJg8eJ10tVikEh3hVeOx/qiNC7on90m4CgCfLzH+UbssIT2lRdkvoc5i
         3WFZm+fQ77izTg0PHU2XJibexwoGutPQ3AvsOyQZk0oSfI+f+J9atAHDQlMOMaX7RdSO
         R7BTtPl61rnvI19DXzNsN3IFOodItyQduurigjVApHttyoX5Jg3r85owrec/3Ib27NoI
         AruQ==
X-Gm-Message-State: AOAM5317uIOHE/Okjj766yehQ0ZLgM9c8sLXrbs7kXQ83t+rpVAqagvZ
        E2okEye1vDG3BPMx2/0i00gaiFJEgbit/hytpPE=
X-Google-Smtp-Source: ABdhPJx9480g6CnPMdSfd014SVi7Vj/41AaOlvBl8yste0UcbI4xfPH0kRwOyOaYfayw8sJLEzijOximmwsLL+OQu28=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr672501oti.23.1622747836678;
 Thu, 03 Jun 2021 12:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210603192238.0bbc6686@canb.auug.org.au> <20210603113051.2095866-1-yukuai3@huawei.com>
In-Reply-To: <20210603113051.2095866-1-yukuai3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 3 Jun 2021 15:17:05 -0400
Message-ID: <CADnq5_NgNgQFTWM6soPjhPSce-JwVMh5jpc4RBZyxv+NU5J0Ow@mail.gmail.com>
Subject: Re: [PATCH] drm: fix doc warnings in drm_atomic.h
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jun 3, 2021 at 7:21 AM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Add description for parameters for
> for_each_new_plane_in_state_reverse to fix warnings:
>
> include/drm/drm_atomic.h:908: warning: Function parameter or member '__state' not described in 'for_each_new_plane_in_state_reverse'
> include/drm/drm_atomic.h:908: warning: Function parameter or member 'plane' not described in 'for_each_new_plane_in_state_reverse'
> include/drm/drm_atomic.h:908: warning: Function parameter or member 'new_plane_state' not described in 'for_each_new_plane_in_state_reverse'
> include/drm/drm_atomic.h:908: warning: Function parameter or member '__i' not described in 'for_each_new_plane_in_state_reverse'
>
> Fixes: a6c3c37b661d ("drm/amd/display: fix gcc set but not used warning of variable 'old_plane_state'")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  include/drm/drm_atomic.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 8f1350e599eb..1701c2128a5c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -898,6 +898,10 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  /**
>   * for_each_new_plane_in_state_reverse - other than only tracking new state,
>   * it's the same as for_each_oldnew_plane_in_state_reverse
> + * @__state: &struct drm_atomic_state pointer
> + * @plane: &struct drm_plane iteration cursor
> + * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
> + * @__i: int iteration cursor, for macro-internal use
>   */
>  #define for_each_new_plane_in_state_reverse(__state, plane, new_plane_state, __i) \
>         for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1); \
> --
> 2.31.1
>
