Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B693B4766
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFYQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhFYQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624638433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5o+qfP6GHLfIPfnq02TmNaEHiucEY8RMLS1UO4vZ+s=;
        b=D0zFbwKuAXBltJ0CyDOOPDCLkicehizQLEnbHUBFuHTgAv/L9kRECge7d4CL3q09IMIFtZ
        m19DHtSujYHf1Rgtwnh4bmKWWjmHRZjw0t4Totiasd4yH1iaFKJn8VXx8joY2XE2oDQP+/
        uVY838Uy9i+4A8SfKIZnMBetXMN0u8k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-EW3P2BswPWqrFC709QKkQw-1; Fri, 25 Jun 2021 12:27:12 -0400
X-MC-Unique: EW3P2BswPWqrFC709QKkQw-1
Received: by mail-qk1-f198.google.com with SMTP id y206-20020a3764d70000b02903b2ff4c81b1so9035600qkb.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 09:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=U5o+qfP6GHLfIPfnq02TmNaEHiucEY8RMLS1UO4vZ+s=;
        b=NYKTdckT/4ORvehhwPGLQMBVmY8zSuhLPnuUlvo3VxbnAMoLsQDGdnXGbtqipv40tj
         boKZpljfvP4PWm4p5wfIkKgomZn05THkgSfHjUR5kofuR2zwgi9VR/9buhcObPd3lDSQ
         Pf7iYZdsPaCrr8oGJMEe0fgdWgyHRj2Ol80pZXaankI3Z1hzy39FV9bilfbASWn/eIuA
         55qOo5Mxtc+GWybwQmHY+cqPJUeTlhBE6+cBcf6Ra5aj46mE89tR6YbSiC3VF3qXWE1P
         chin7Wu+yAZHSZpwqzK9AfjoEgSZlhbau+M4nNzjYEoxIAvX4ggHP/XRY3mforRXZyX+
         pK1g==
X-Gm-Message-State: AOAM5336rlxPD9ndLOieyDZQLXJ3NZK/MaYcKDhbSlX8XWilhxadFUNN
        dE/DfVGzAUO6ymwOM79+L16SwtwtsxzOAeFb793EjPDQE5hrvdsuJ4ao3Ay3Ms9GQiB17Ao61Bk
        mKtokGiKxwi+Z3mfRuAIWg6xm
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr11777570qvi.44.1624638431614;
        Fri, 25 Jun 2021 09:27:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNCXBo3wDqEwZBbeZJgLcThoweJoirnmT4pfoxXYsxbDiSqWO1f6DFrN67Lv8a1Xvc6DS5QA==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr11777554qvi.44.1624638431416;
        Fri, 25 Jun 2021 09:27:11 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id t62sm5240494qkc.26.2021.06.25.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:27:11 -0700 (PDT)
Message-ID: <a48763801f0e903a227283a12cf881dc143034ff.camel@redhat.com>
Subject: Re: [PATCH] drm/msm/dp: Add missing drm_device backpointer
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 12:27:09 -0400
In-Reply-To: <20210625034721.1287948-1-bjorn.andersson@linaro.org>
References: <20210625034721.1287948-1-bjorn.andersson@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah - must have missed this when I added this. Thanks for the fix!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2021-06-24 at 20:47 -0700, Bjorn Andersson wrote:
> '6cba3fe43341 ("drm/dp: Add backpointer to drm_device in drm_dp_aux")'
> introduced a mandator drm_device backpointer in struct drm_dp_aux, but
> missed the msm DP driver. Fix this.
> 
> Fixes: 6cba3fe43341 ("drm/dp: Add backpointer to drm_device in drm_dp_aux")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 3 ++-
>  drivers/gpu/drm/msm/dp/dp_aux.h     | 2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c
> b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 4a3293b590b0..88659ed200b9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -441,7 +441,7 @@ void dp_aux_deinit(struct drm_dp_aux *dp_aux)
>         dp_catalog_aux_enable(aux->catalog, false);
>  }
>  
> -int dp_aux_register(struct drm_dp_aux *dp_aux)
> +int dp_aux_register(struct drm_dp_aux *dp_aux, struct drm_device *drm_dev)
>  {
>         struct dp_aux_private *aux;
>         int ret;
> @@ -455,6 +455,7 @@ int dp_aux_register(struct drm_dp_aux *dp_aux)
>  
>         aux->dp_aux.name = "dpu_dp_aux";
>         aux->dp_aux.dev = aux->dev;
> +       aux->dp_aux.drm_dev = drm_dev;
>         aux->dp_aux.transfer = dp_aux_transfer;
>         ret = drm_dp_aux_register(&aux->dp_aux);
>         if (ret) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h
> b/drivers/gpu/drm/msm/dp/dp_aux.h
> index 0728cc09c9ec..7ef0d83b483a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.h
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.h
> @@ -9,7 +9,7 @@
>  #include "dp_catalog.h"
>  #include <drm/drm_dp_helper.h>
>  
> -int dp_aux_register(struct drm_dp_aux *dp_aux);
> +int dp_aux_register(struct drm_dp_aux *dp_aux, struct drm_device *drm_dev);
>  void dp_aux_unregister(struct drm_dp_aux *dp_aux);
>  void dp_aux_isr(struct drm_dp_aux *dp_aux);
>  void dp_aux_init(struct drm_dp_aux *dp_aux);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> b/drivers/gpu/drm/msm/dp/dp_display.c
> index c26562bd85fe..2f0a5c13f251 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -259,7 +259,7 @@ static int dp_display_bind(struct device *dev, struct
> device *master,
>                 return rc;
>         }
>  
> -       rc = dp_aux_register(dp->aux);
> +       rc = dp_aux_register(dp->aux, drm);
>         if (rc) {
>                 DRM_ERROR("DRM DP AUX register failed\n");
>                 return rc;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

