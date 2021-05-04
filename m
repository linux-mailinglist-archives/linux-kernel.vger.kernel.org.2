Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7C37252F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhEDEnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhEDEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:43:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 21:42:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so7142481oti.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 21:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=11Nzt21PGgG7EY1Zm8LPZ6J+bFs0Dr0fBy2u4R0XE/M=;
        b=eMDxI/J5JXLmmKxTyVqOM4RrALRwtyMIm7+ZVgBG5CshybG7FGuLkpX5f0siwUVD/Y
         HoFLI68bUSlqWKu34+h4BOf+B3SG6I0D93xctqrZUs8i1JCfWEqKvdEQ8AyQH2KDklLw
         8hkXj1MLvgoLX3BWvOfcXqJ54hj5dHndfr7ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=11Nzt21PGgG7EY1Zm8LPZ6J+bFs0Dr0fBy2u4R0XE/M=;
        b=CpF0bE/8IN0qhKe+7nAJb2v2J92pCGlos9hGi709huwP2Lu9EVVdaw2X71OJIrVr09
         a8XKrNuzaPh8sNPOT9cnohdmq86S8D6eqsZnH6MoNu4dVAQHIi8nsjIqCgsLcW0zWdNZ
         MBu9uXjQ7b0xccVGNWtP7vkPsz/ejBUgPnKvx4bBARghAeZEtxWdj7nCGzfiiMMca5Kk
         4Sa/rcnjcCKRM8n0RjxaA8+35QGm/kI2tXa/uq44wTt2N496Jg//24ejSC6mzvyokvw2
         CrB0Y1ZEKHizckFxRuA9SAXvLvkYsf8Bx3l3v2aFDsXwEC/Jd21rknIJ9J7prvwgga7L
         bNyg==
X-Gm-Message-State: AOAM532qIEv+vSx3G32eqs7EgXqr5vyLCZP48NCFzshxeXEi3oywpmK2
        lprqn8Dk3hHfQb0wb4XxTKmrofTSL89/sbqvbQc4vQ==
X-Google-Smtp-Source: ABdhPJxCezCWHhNH1naSml5SlQdlnfQJrJxORDMFSaHhNEWOV1BLyNy+3WNmkZObBEETMxJdHv/XU00MVUB6ixxxRwc=
X-Received: by 2002:a9d:5e19:: with SMTP id d25mr17278425oti.308.1620103346067;
 Mon, 03 May 2021 21:42:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 21:42:25 -0700
MIME-Version: 1.0
In-Reply-To: <1619048258-8717-4-git-send-email-khsieh@codeaurora.org>
References: <1619048258-8717-1-git-send-email-khsieh@codeaurora.org> <1619048258-8717-4-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 3 May 2021 21:42:25 -0700
Message-ID: <CAE-0n50EW8evqt1NtbjEbSS71CzSAzXR21-FvCrTmvsaj+GGHQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/msm/dp: check main link status before start
 aux read
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-21 16:37:37)
> Maybe when the cable is disconnected the DP phy should be shutdown and
> some bit in the phy could effectively "cut off" the aux channel and then
> NAKs would start coming through here in the DP controller I/O register
> space. This patch have DP aux channel read/write to return NAK immediately
> if DP controller connection status is in unplugged state.
>
> Changes in V4:
> -- split this patch as stand alone patch
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 7c22bfe..fae3806 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -343,6 +343,11 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>
>         mutex_lock(&aux->mutex);
>
> +       if (!dp_catalog_link_is_connected(aux->catalog)) {
> +               ret = -ETIMEDOUT;
> +               goto unlock_exit;
> +       }
> +
>         aux->native = msg->request & (DP_AUX_NATIVE_WRITE & DP_AUX_NATIVE_READ);
>
>         /* Ignore address only message */

Can the code check for aux timeouts? So instead of blindly completing
'aux->comp' we would do the transfer, and then dp_aux_cmd_fifo_tx()
would check to see if the completion was completed from the irq
handler because of a timeout or a nack, etc. I think the code is
probably racy, given that dp_aux_isr() is called from irq context, and
aux_error_num is set from the irq context and tested in non-irq context.
This code needs a spinlock and then to check the isr bits to figure out
if it should tell the upper layers that the address was wrong, or there
was a nack or a timeout, etc.

I don't think we need to check the link to see if it is connected, just
look at the irq bits to see if the response was bad and letting higher
layers know that should quickly cut off the transactions.
