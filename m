Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061523FF356
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbhIBSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241887AbhIBSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630608065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bj1YZCOICCuWhBGeiWp2KDW8cxmxWvm+507OpITl/f8=;
        b=DQH/HJfwQtcnYPdFrBhl0Z2Ygp/76yFhtTdaTrsWViUvLiHYFedQZ0rc5RjOLeya9ElWNZ
        R4bA9k0j+4OAxsBNvyKI/CUGrp5zCynved3glRvEveE1IQFUbIp5V77iE1HXukY3qheQGf
        GzZigtCQHbTcxJ89F1PpCCvPBkWr3PY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-wz9vbUERNEmhTOTbcWmZww-1; Thu, 02 Sep 2021 14:41:02 -0400
X-MC-Unique: wz9vbUERNEmhTOTbcWmZww-1
Received: by mail-qt1-f198.google.com with SMTP id c20-20020a05622a059400b002a0bb6f8d84so2611723qtb.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Bj1YZCOICCuWhBGeiWp2KDW8cxmxWvm+507OpITl/f8=;
        b=sbE8nOUAIAw/VH3Mu6gbfNS2zkFgAvPg3E6xQ0u146Gbx6q/En3J/X6clUcAA4t93j
         wxkEghWle3qZRbZ3EEIFITzfaKdoNz1/HZOG3+qGYNOOZlw40UAuYrXae2hfVoFePICZ
         9qJaRDoPsCTBBtbEfO6NVKfQCKuigAhdFILoYMaNtBbbvvoOaZNEiSD97t4nOjv8/vgo
         iLf+ZXOAiVIAPrNYOr9MhIJXdZ9Pvw/jn8Lk/aSAWsNJltTiSny6n4zb6ionBe8BsRr8
         r+I7DcHOnxgqM7FeDGr7mw8ztJmQu33JWZFdF5rQe7QDWN99NwNVB5qWh6kdUrldloCu
         CmOg==
X-Gm-Message-State: AOAM532A6bIAmmxM8WwlZg5mh9sD+wqlC8dyUm2FW/EFGygA6wpaBwnE
        ESWwM6mnZys3Fstb5kYJPXOV4NYwdhzCxK4TJxTtYOJzdUAS3NsZteAtQtSBgG+uSL35XyHYEoH
        SXgc17m1H7EVobOg9iOPw/a+/
X-Received: by 2002:ac8:7ef6:: with SMTP id r22mr4422750qtc.158.1630608061641;
        Thu, 02 Sep 2021 11:41:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzER9U7aKRPWcbQbf6Y4ZH5pTc8T3UJYAdtuN5uesnicOA+1yjnC5jy8JOV95bM70GmgFDNcw==
X-Received: by 2002:ac8:7ef6:: with SMTP id r22mr4422741qtc.158.1630608061430;
        Thu, 02 Sep 2021 11:41:01 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id p22sm1995353qkj.16.2021.09.02.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:41:00 -0700 (PDT)
Message-ID: <2d6784e3327cab7bfdc88ca1ef7c9c4c9cca113a.camel@redhat.com>
Subject: Re: [PATCH] drm/msm: remove unneeded variable
From:   Lyude Paul <lyude@redhat.com>
To:     cgel.zte@gmail.com, robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        airlied@redhat.com, laurent.pinchart@ideasonboard.com,
        chi.minghao@zte.com.cn, treding@nvidia.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Date:   Thu, 02 Sep 2021 14:40:59 -0400
In-Reply-To: <20210831115127.18236-1-chi.minghao@zte.com.cn>
References: <20210831115127.18236-1-chi.minghao@zte.com.cn>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Do you need me to push this?

On Tue, 2021-08-31 at 04:51 -0700, cgel.zte@gmail.com wrote:
> From: Chi Minghao <chi.minghao@zte.com.cn>
> 
> Fix the following coccicheck REVIEW:
> ./drivers/gpu/drm/msm/edp/edp_ctrl.c:1245:5-8 Unneeded variable
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Chi Minghao <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/msm/edp/edp_ctrl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/edp/edp_ctrl.c
> b/drivers/gpu/drm/msm/edp/edp_ctrl.c
> index 4fb397ee7c84..3610e26e62fa 100644
> --- a/drivers/gpu/drm/msm/edp/edp_ctrl.c
> +++ b/drivers/gpu/drm/msm/edp/edp_ctrl.c
> @@ -1242,8 +1242,6 @@ bool msm_edp_ctrl_panel_connected(struct edp_ctrl
> *ctrl)
>  int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
>                 struct drm_connector *connector, struct edid **edid)
>  {
> -       int ret = 0;
> -
>         mutex_lock(&ctrl->dev_mutex);
>  
>         if (ctrl->edid) {
> @@ -1278,7 +1276,7 @@ int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
>         }
>  unlock_ret:
>         mutex_unlock(&ctrl->dev_mutex);
> -       return ret;
> +       return 0;
>  }
>  
>  int msm_edp_ctrl_timing_cfg(struct edp_ctrl *ctrl,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

