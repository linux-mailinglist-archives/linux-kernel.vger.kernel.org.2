Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753084528E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhKPEB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbhKPEBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:01:22 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDAC1F14FF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:43:24 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bf8so38611424oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 16:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AR+MJXQt1hZ4ak+KffeN9j/qO8HcFtJTxsTibtq8SN0=;
        b=OcKmfLQ8A9BF4S3di4lz4OZXJGUTA4mbSUlF7s+b0wJ+grSJIRm0i7Ca1yMgwNY2g8
         70uW5S/5kzyfc1VQ8Ov++7/+Wf/wwIurMBsGC3VDQ7uOz30vQJ8ca0/iDQhvQA8YU7oX
         rWRos7i6GY4nzLNbDZkm+x0eFcNMhKjkB3BMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AR+MJXQt1hZ4ak+KffeN9j/qO8HcFtJTxsTibtq8SN0=;
        b=CO5zGgLb7oLH1ssWBpq63o0f731lYgZZYkILjeLm4yJi6tChYRCRTRTg8LvGYHEUMB
         A+DROiYID07gBWX7+cJloiblwKJxDcgkJQPW7y72OsUwBLnyI4enL0eGHLoAxfySb4y8
         THhsSF2voBbcdmq9Fwt6W/pq2A5+zjd6Xe+n+LtNVNuCubDdfeKKKqS80Fh4jJAtXmfF
         Tto8Ki+503hOg5XItsQAqnoc3z6FxHlwd8XhGlMjTa/8bsAEul88HKtnLYUOWN4cnR+E
         iHYlMemB7/uNE/RkzT1vbEpdjut8KX6UdNWelEkr/fsY8K+kWdfQDW6iIVVZAGse+bsD
         uRpg==
X-Gm-Message-State: AOAM530bmCQAppsuwG1G0B+E57LEJdnwzBUQ3kCKIifJNvhdhdD67Iss
        SATp3GGIe7JioeB8vBA0F42tST2xVRFmeBoEzc0upWDojIE=
X-Google-Smtp-Source: ABdhPJz9z5atxroq/GjxihboHlC2x5PboGmywHnjxtnAjxqEQZyoBJQEvr8K/IKhil58m74mic8cKR+6S4n+PtT7tBE=
X-Received: by 2002:aca:2319:: with SMTP id e25mr49152738oie.164.1637023403674;
 Mon, 15 Nov 2021 16:43:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 16:43:23 -0800
MIME-Version: 1.0
In-Reply-To: <20211110120512.150940-1-deng.changcheng@zte.com.cn>
References: <20211110120512.150940-1-deng.changcheng@zte.com.cn>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 16:43:23 -0800
Message-ID: <CAE-0n50=P06ByQrG0FixVK4cGW--Vgt6uwGsLUu792SPhqzqXQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/msm/dp: remove unneeded variable
To:     cgel.zte@gmail.com, robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        abhinavk@codeaurora.org, deng.changcheng@zte.com.cn,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2021-11-10 04:05:12)
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Fix the following coccicheck review:
> ./drivers/gpu/drm/msm/dp/dp_debug.c: Unneeded variable
>
> Remove unneeded variable used to store return value.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
> index 2f6247e80e9d..c5c75273d1e5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> @@ -365,7 +365,6 @@ static const struct file_operations test_active_fops = {
>
>  static int dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)

Would be nice to make it void as well and then cleanup the caller. Can
you do that too?

>  {
> -       int rc = 0;
>         struct dp_debug_private *debug = container_of(dp_debug,
>                         struct dp_debug_private, dp_debug);
>
