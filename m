Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C983695E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhDWPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhDWPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:15:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28351C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:15:18 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r186so21700011oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H20jNSQBl2MjyzyhkMYaw3Uy+F10G5cykrLW0bCJkBA=;
        b=pbgHZ7XQhrdOvbvAEjMyl0uK0HMUgeZJJF+ej6t7BPq/nAAOkrIUydX+1QHj4u3KvE
         pLJIkbIJwMGOu2yzI3poPk98hnq8bSFyQsAtWmghJefxSFUCF5GgUMakEzY/G52IecyX
         N6vnUWZQjFjsNFgoTDl14F24ZjuyimIj9GRrfxpXByaXYg6s8L10Jnibgr7D8hc4giuF
         9f9P1y+QA4CxKMKY70bvbYeAP0qqZg1jXldsiydJzBDv6EDSTapmYebrwv5u129V0FFd
         m648IZf/e0ns6mu6mKhFtYsSa+kbirPQhcKZNtXvnLauhKVBdnelRFhMWp3L6ty0K8Yw
         ck1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H20jNSQBl2MjyzyhkMYaw3Uy+F10G5cykrLW0bCJkBA=;
        b=qCYfYfkOeDkjuizthO/EPLkv8tK3JeWq4W9LQwZRvO9rJEtEvmf125ggZ2nvdCHZpz
         cVtmWQzrQe4HjlaNFtf5z3jj9y86SRSG/eb+ckpYnsYhXJ1Y1Lc+k2wdqgS6rA1Dvaxs
         x2r2895RcqeG7NZoLZ+7jGMbfI/vernKr79ng50VrJkfLzAJvHHDfD7nW44zUNZNzrxx
         ISzugbSI50OrvaI9MqLJ7WHVcx4yiQBFkG+H4IaP2Pvcj35QvSuW4YqSan6AGiew36PC
         JCxoWSDmIJNGgCtTvO79XMXI7xj/e/tKnY/OgExNbbUe4/eCRzh5rSkjntEPkK93OZuC
         lwkw==
X-Gm-Message-State: AOAM530mmuSlihCyjl8M11GYqlU9mZyF9KuGk8lE+3VcNXV/cXsenTdP
        ZhCm/LT3P4CEsMUEQuUu17Nr7Q==
X-Google-Smtp-Source: ABdhPJweYNjzWUSWU6X45/xUm+r362Z1QMdsI+CBjPXjPS8ZOsGsSpPe5+cGwgePXKHxnPQi2QkCMg==
X-Received: by 2002:aca:75cc:: with SMTP id q195mr4322750oic.88.1619190917554;
        Fri, 23 Apr 2021 08:15:17 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 88sm1422029otx.2.2021.04.23.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:15:17 -0700 (PDT)
Date:   Fri, 23 Apr 2021 10:15:15 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 22/27] drm/panel: panel-simple: Remove extra call:
 drm_connector_update_edid_property()
Message-ID: <YILkg2ChCZChEqqu@builder.lan>
References: <20210416223950.3586967-1-dianders@chromium.org>
 <20210416153909.v4.22.Icb581b0273d95cc33ca38676c61ae6d7d2e75357@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416153909.v4.22.Icb581b0273d95cc33ca38676c61ae6d7d2e75357@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Apr 17:39 CDT 2021, Douglas Anderson wrote:

> As of commit 5186421cbfe2 ("drm: Introduce epoch counter to
> drm_connector") the drm_get_edid() function calls
> drm_connector_update_edid_property() for us. There's no reason for us
> to call it again.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> As Laurent pointed out [1] this is actually a pretty common
> problem. His suggestion to do this more broadly is a good idea but
> this series is probably a bit ambitious already so I would suggest
> that be taken up separately.
> 
> [1] https://lore.kernel.org/r/YGphgcESWsozCi1y@pendragon.ideasonboard.com
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/panel/panel-simple.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 90a17ca79d06..c91e8aa108f7 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -512,7 +512,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
>  	if (p->ddc) {
>  		struct edid *edid = drm_get_edid(connector, p->ddc);
>  
> -		drm_connector_update_edid_property(connector, edid);
>  		if (edid) {
>  			num += drm_add_edid_modes(connector, edid);
>  			kfree(edid);
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
