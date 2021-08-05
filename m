Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8640A3E14C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbhHEMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhHEMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:33:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D113C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 05:33:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m12so6294231wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pq/7PwbB0ORjkXkPsbVs9ifsbwzmZqfthsgdsrE9peo=;
        b=PbmVcajgK+C6zfCQoD60/op6Ugqli0uugni4BzHnde5z1+sQvck/4+L2fsebhdymO8
         FQO/e5Zmn4aiTEe/1z1b8eSMqnoHeLK24scdi1NGpKtVSgljEcJWVFHdbDLur29BtJby
         6aV1B+webB0ZFCw1L1sPOEp1jm1Dd/KjTbs5AtqNChU2X9djg7k6aXMgz6Cx3AUJyOPt
         DLB19jX0w+u0j6S4SGv8hga0knSMvFPn6I0oiVeLf9PjoRwUPX4VVdD/7DqcrEm5qmnp
         Ol3uh/DfiIwru/ircpdbV6W+VlQ6cMudL4dAzVl6l8NOOt0eUaYe2H4TwMfe2kSdyqK1
         m04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pq/7PwbB0ORjkXkPsbVs9ifsbwzmZqfthsgdsrE9peo=;
        b=qbz02uCwX9qBMiba09jSJPIlpOTWocaOuO55xYtOPG/TTTWd5oFCQYRTMJHTmc41eP
         BNOcPYgvxwKtd96FGByeSYcM41SlljzIo1hDprtRoE9d6WaAdKdBPETq3AIJUq86ZlXp
         dm8MWWvKO75EknkmHFYNTZcXN/YmSPNhebiDa5ZWw2PDxWydGVMtgS+rW42vvlCnDNZw
         P1oDiXN1EumIl67/A7nOFIhBM+MfM+g3pRcqAcQ/+PhX+XuverEDpmSkNj73A0uYBkn6
         gYkeXGZedCmKvjM0lLhHH6ANS8xbKeRflmFlkeQPFkZ3FX1WVSa+DWuvclLE/7MT/YV8
         3aXg==
X-Gm-Message-State: AOAM530zOeeIHv1qE//Ejpz0dlZFGzIqoiU9+NFbw3GTsxFocydDcbTf
        TGzrOxqdIAMfBfD+5oKq3JpHd+Xgfpo=
X-Google-Smtp-Source: ABdhPJwP8PzL01eP0xe6aSZwwTPEGKbYH42KVliK4VaxwnFOmJ52jJuGRleH/T95c0lPQdcPxZ6Avw==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr5010415wrr.224.1628166800726;
        Thu, 05 Aug 2021 05:33:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ae89:49de:1628:3147? ([2a02:908:1252:fb60:ae89:49de:1628:3147])
        by smtp.gmail.com with ESMTPSA id g138sm6701228wmg.32.2021.08.05.05.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 05:33:20 -0700 (PDT)
Subject: Re: [PATCH] DRM: gpu: radeon: Fixed coding style issues
To:     =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?= <lonyelon@gmail.com>,
        airlied@linux.ie
Cc:     daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?= <sergio@lony.xyz>
References: <20210804112053.263887-1-sergio@lony.xyz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <296a3a38-2e9c-f3f2-66a8-70f52eaff2eb@gmail.com>
Date:   Thu, 5 Aug 2021 14:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804112053.263887-1-sergio@lony.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.08.21 um 13:20 schrieb Sergio Miguéns Iglesias:
> Fixed braces, an unnecessary if statement and added a missing space.
>
> Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>

Normally we see patches which just fixes coding style as unnecessary 
churn, but the "if (rbo) {}" is really ugly here.

So Reviewed-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_fb.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
> index 0b206b052972..6640b7c947fe 100644
> --- a/drivers/gpu/drm/radeon/radeon_fb.c
> +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> @@ -54,6 +54,7 @@ radeonfb_open(struct fb_info *info, int user)
>   	struct radeon_fbdev *rfbdev = info->par;
>   	struct radeon_device *rdev = rfbdev->rdev;
>   	int ret = pm_runtime_get_sync(rdev->ddev->dev);
> +
>   	if (ret < 0 && ret != -EACCES) {
>   		pm_runtime_mark_last_busy(rdev->ddev->dev);
>   		pm_runtime_put_autosuspend(rdev->ddev->dev);
> @@ -196,9 +197,8 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
>   		radeon_bo_check_tiling(rbo, 0, 0);
>   	ret = radeon_bo_kmap(rbo, NULL);
>   	radeon_bo_unreserve(rbo);
> -	if (ret) {
> +	if (ret)
>   		goto out_unref;
> -	}
>   
>   	*gobj_p = gobj;
>   	return 0;
> @@ -294,9 +294,6 @@ static int radeonfb_create(struct drm_fb_helper *helper,
>   	return 0;
>   
>   out:
> -	if (rbo) {
> -
> -	}
>   	if (fb && ret) {
>   		drm_gem_object_put(gobj);
>   		drm_framebuffer_unregister_private(fb);

