Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B541106D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhITHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhITHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:45:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21277C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:44:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso11356874wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UuwX+BZTrhgkM5095i9y1izfITUl3ZNzJEk4qvv1Wvo=;
        b=WZV/vN+Rzhvt2qdmkiqIMPMfPh2ezmBLQvFYmyExzx3tyD++Mb8PF19c8FohC7Jq4i
         z3JHqMJqWpoDC3YiqxYAfXFpywdRSJ0BNxAVBTaUmCme+wx0L3X06Tw+KAIDrNmC/+Gw
         W6hVH/r2NombkAj5H9+G+aZA0S8CR/djjuv6lqxKWk+Y2AejHgyazhZx8yZQcP44cRTb
         2mNZpoH+Lr93S5LRtUoBuCDaBU7tkDru2lOZJgcNL2Q++nuQryy64qPP7OYwExXs10WX
         2VMBISSh0S/WdtYws7kd90OZV5ZitgXYpqOLQuoDbt3Ll+alg+HHLGjbR9tIEWz4kndo
         qi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UuwX+BZTrhgkM5095i9y1izfITUl3ZNzJEk4qvv1Wvo=;
        b=rAQPm/S0tIRkZZLHwl58FVrrr9RCvP4rmPXUT8vzW2RuLHJs/GMtl01kV3Jx2iG0Nn
         ae3qj6xgXTG/ydolJgFQfvJ54GqhhEcPQCoY6ZGdcyUyE2sTlV+vS75GfLQD5fm8ZafV
         fgPwxkBRodd0GFeigSvdYdLNZKSAp9WV5qIXjJC6eirKhJaObye8qwnb7NWFIsqPHJcx
         qstYtu09GiR3ouW+Wrc4d569lyjCmukwpL1eJgr5R4SbcPJP/3T8mKv/+FiOP1aDY/NN
         iWOtDpQPB7mn2vONjdJZPvWFb8wmxfAqsixqoVJMEnPzYtISCCTBkejZ2aaRq1cWPDeC
         eZ7Q==
X-Gm-Message-State: AOAM532S5uGF94UZgJm4NPQ5khQL9Hk5WnNxTIGXhPD6hj4iB4J+jHwj
        uGsSBd7X1TW5fbwve0smrQ9HsSSCgTA=
X-Google-Smtp-Source: ABdhPJzLZsJv19kIPrY2w25+vrvZR1MhAgajmQ9+0KprWwhQ+GG2BYlEIOgvZ61/j9zZUzGy0NlQnw==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr27994539wmc.85.1632123842985;
        Mon, 20 Sep 2021 00:44:02 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
        by smtp.gmail.com with ESMTPSA id r27sm15163967wrr.70.2021.09.20.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 00:44:02 -0700 (PDT)
Subject: Re: [PATCH] drm/radeon: fix uninitialized bool variable
To:     Zhiwei Yang <yangzhiwei@uniontech.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210918094157.4770-1-yangzhiwei@uniontech.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <484936f6-86e8-2078-3739-674a04283666@gmail.com>
Date:   Mon, 20 Sep 2021 09:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210918094157.4770-1-yangzhiwei@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 18.09.21 um 11:41 schrieb Zhiwei Yang:
> The bool variable detected_hpd_without_ddc in struct radeon_connector
> is uninitialized when first used, that may cause unnecessary ddc ops.
> Make it as false when a new connector is alloced.
>
> Signed-off-by: Zhiwei Yang <yangzhiwei@uniontech.com>
> ---
>   drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index fe12d9d91d7a..c1987a66373f 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -1866,6 +1866,7 @@ radeon_add_atom_connector(struct drm_device *dev,
>   	bool shared_ddc = false;
>   	bool is_dp_bridge = false;
>   	bool has_aux = false;
> +	bool detected_hpd_without_ddc = false;

In general good catch, but I don't see the need for a local variable here.

Just initialize the member directly or even better change the allocation 
of the connector into a kzalloc().

Christian.

>   
>   	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
>   		return;
> @@ -1923,6 +1924,7 @@ radeon_add_atom_connector(struct drm_device *dev,
>   	radeon_connector->shared_ddc = shared_ddc;
>   	radeon_connector->connector_object_id = connector_object_id;
>   	radeon_connector->hpd = *hpd;
> +	radeon_connector->detected_hpd_without_ddc = detected_hpd_without_ddc;
>   
>   	radeon_connector->router = *router;
>   	if (router->ddc_valid || router->cd_valid) {
> @@ -2384,6 +2386,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
>   	struct radeon_connector *radeon_connector;
>   	struct i2c_adapter *ddc = NULL;
>   	uint32_t subpixel_order = SubPixelNone;
> +	bool detected_hpd_without_ddc = false;
>   
>   	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
>   		return;
> @@ -2414,6 +2417,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
>   	radeon_connector->devices = supported_device;
>   	radeon_connector->connector_object_id = connector_object_id;
>   	radeon_connector->hpd = *hpd;
> +	radeon_connector->detected_hpd_without_ddc = detected_hpd_without_ddc;
>   
>   	switch (connector_type) {
>   	case DRM_MODE_CONNECTOR_VGA:

