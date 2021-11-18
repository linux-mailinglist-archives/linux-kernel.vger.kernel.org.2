Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5696545547C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 06:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbhKRF6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 00:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243222AbhKRF6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 00:58:31 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D921C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:55:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so4397794pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M6fU9HCOMXaAwWu55zqsqx8GoNSHTp7qVG4HyvmThLM=;
        b=UHufCLPWyoOczeZ10rpOHREDHnb3KpiCBx3l1fTQm5RvUKFPfoiV3nIdNI1zko70SG
         /rKe8N7G0c0n05WH2WbNalEhgCbNcRUSas8ntyCf23nZUCkn6i9wCai27/OIwEMEJyOv
         ThePhBf4AWclUuOtatuS2nfw5iiz775JEIGgnd/uYe4rXrmhZLY9uVjezatexQW9zJlr
         f/ua1KJym4YKdxaoZO7i5Sm2rmE52E/ZEveHM3ZGMEyCS4qLoJEPYgizR4iGB0ez384E
         65/JeZxmXvJ2XZODMZNCnYNZLTvHyi9Vh/6xPx5IAmj5cvI8gu2XavIl9F9ECYt2hs+g
         UB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6fU9HCOMXaAwWu55zqsqx8GoNSHTp7qVG4HyvmThLM=;
        b=yXErgeSSLxaDILoxxu5UisWJyrrX6jAO6zsSUWCeQvbDKWS5TPv07EGNd4VKzy9zTe
         yUNiTA36KUNlnCbw9wUG2OuVbsTA4Bu3PjMGEVerxNTFn/PQgX02QEoKYrae7L1q138l
         6PLwWsDVX34MCH8xz4Eaxbr7JegQOIcL2TDWlWF3agQEcLiYdLg8j67HYz0wLx8fDxtE
         Bxcyx2Y6KrItFylQ3x8WlVKM854+3EduJXOad5P/ohe0syGwqyRXy1XZC9u8wazWMftB
         b3nkx9xQTS6oZepg0dGUCEd5bT9ioEODqNz8LvIZrg4x66kxJvS0f8Yx6wnb4a03k6fz
         inmA==
X-Gm-Message-State: AOAM533t7Q74Uxiqpu5cZYYhZR+oY4lChpJ+NQN0Wz5JczmJ8/+KD4HH
        Wnx2aWyY7pdAtWxOTyL85GTZqA==
X-Google-Smtp-Source: ABdhPJw1U92hefuFRAL0GmhDcNMuPQUVRaJ5rI4xhjzGg+pVLc+xkbJYl2Vby+uLLS0FJI1gYbeHXQ==
X-Received: by 2002:a05:6a00:23c8:b0:49f:e054:84d7 with SMTP id g8-20020a056a0023c800b0049fe05484d7mr53924075pfc.50.1637214931490;
        Wed, 17 Nov 2021 21:55:31 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:8f8:11d:a96a:74d2])
        by smtp.gmail.com with ESMTPSA id u9sm1547277pfi.23.2021.11.17.21.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 21:55:31 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:55:27 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, fshao@chromium.org, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Subject: Re: [PATCH 3/3] drm/mediatek: add devlink to cmdq dev
Message-ID: <YZXqz6XDChwscDC0@google.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
 <20211117064158.27451-4-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117064158.27451-4-jason-jh.lin@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:41:58PM +0800, jason-jh.lin wrote:
> @@ -158,6 +159,7 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
>  	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
>  
>  	if (mtk_crtc->cmdq_client.chan) {
> +		device_link_remove(mtk_crtc->drm_dev, mtk_crtc->cmdq_client.chan->mbox->dev);
>  		mbox_free_channel(mtk_crtc->cmdq_client.chan);
>  		mtk_crtc->cmdq_client.chan = NULL;
>  	}
[...]
> @@ -956,6 +959,16 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  	}
>  
>  	if (mtk_crtc->cmdq_client.chan) {
> +		struct device_link *link;
> +
> +		/* add devlink to cmdq dev to make sure suspend/resume order is correct */
> +		link = device_link_add(dev, mtk_crtc->cmdq_client.chan->mbox->dev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +		if (!link) {
> +			dev_err(dev, "Unable to link dev=%s\n",
> +				dev_name(mtk_crtc->cmdq_client.chan->mbox->dev));
> +		}
> +

If device_link_add() failed, doesn't mtk_drm_crtc_create() need to return an error and exit?

OTOH, if device_link_add() failed, won't it bring any side effects to call device_link_remove()?
