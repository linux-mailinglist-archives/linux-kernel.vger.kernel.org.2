Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A733B797E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhF2Uo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhF2UoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:44:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D0C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:41:54 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so172821oti.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=G+rJt0C2Slb8d0ZfNqjQGxxap0txWSw7TQID7jmhkhA=;
        b=mVRdapNlPo1HO1UIHjT7z8yyfjnNO/EX3RIshPo2eOjrZ2A663ejNox8Ye0VcVg4JN
         XvC6WBo/o828ePCTyS7LXPjbqnTFmQwrYruwV1dCRHCsd9+LcK7hC3+YstZuiG3ruTAa
         TpOrW/4SPyteSuXHPz5ZbvGPPEu2/qz55Ha6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=G+rJt0C2Slb8d0ZfNqjQGxxap0txWSw7TQID7jmhkhA=;
        b=Lsi2KlbeWpCy4zWJuVg91dxiovzBQuvP3bOkeBo/hFXxJ7VYrCKiao7x2zkir22qr6
         A07J3QneEUc+N5qwmyTo4RhI1VUOax6lsKHQe1iK9wvdjDYIWdf62f57hEzhYynvxhFU
         KjybPDPRBDW0iduxL1jmFHblomxcrTNy2QcgFMyaaU5EbkHwZM+AEDW2+a/2tmGAYTq9
         AgvVXvCUbOAfvxv2n+O1Pnygd3gdND+NgD+p4WqNC8t9RJIiZQBue+5iejAOvldYEfb/
         EpQEgwFUnYAJ9QUzXyLT0MJ92ko2+m6o8HSAZupl4W3gFffN8KwwLN/45anaJu2zGLo0
         AWrA==
X-Gm-Message-State: AOAM531VVLFQ0zRFrD1khpi9jaMdhYH5bx/YGZw8j8sNB2JpjqnavlaU
        xb++Y8cUH7H+Xb1056RdB+OCZgg7HT4P1xvUv+nf+A==
X-Google-Smtp-Source: ABdhPJx1TFgBKD9DcRhcjUnyrBLH010Bm78M/wrrOZ+J+cCVRwJkR63kAnvPTLiNwVCDc2nMUTp58bOkpkUx6NEVUQY=
X-Received: by 2002:a9d:2781:: with SMTP id c1mr6020558otb.34.1624999314141;
 Tue, 29 Jun 2021 13:41:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Jun 2021 13:41:53 -0700
MIME-Version: 1.0
In-Reply-To: <1624997336-2245-1-git-send-email-khsieh@codeaurora.org>
References: <1624997336-2245-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 29 Jun 2021 13:41:53 -0700
Message-ID: <CAE-0n50onDrop=67VvMWL2sbSJedxhKEX13PsiZNaokucSgLew@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix return code on sideband message failure
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run, Lyude Paul <lyude@redhat.com>
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        rsubbia@codeaurora.org, rnayak@codeaurora.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Lyude, author of fixed commit. Please add relevant folks in the future.

Quoting Kuogee Hsieh (2021-06-29 13:08:56)
> From: Rajkumar Subbiah <rsubbia@codeaurora.org>
>
> The commit 2f015ec6eab69301fdcf54d397810d72362d7223 added some debug

Please write

Commit 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
selftests") added some debug

> code for sideband message tracing. But it seems to have unintentionally
> changed the behavior on sideband message failure. It catches and returns
> failure only if DRM_UT_DP is enabled. Otherwise it ignores the error code
> and returns success. So on an MST unplug, the caller is unaware that the
> clear payload message failed and ends up waiting for 4 seconds for the
> response.
>
> This change fixes the issue by returning the proper error code.

$ git grep "This patch" -- Documentation/process

>
> Change-Id: I2887b7ca21355fe84a7968f7619d5e8199cbb0c6

Please replace with

Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
selftests")

> Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>

Should be a Signed-off-by from Kuogee Hsieh here.

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1590144..8d97430 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2887,11 +2887,13 @@ static int process_single_tx_qlock(struct drm_dp_mst_topology_mgr *mgr,
>         idx += tosend + 1;
>
>         ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
> -       if (unlikely(ret) && drm_debug_enabled(DRM_UT_DP)) {
> -               struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> +       if (unlikely(ret)) {
> +               if (drm_debug_enabled(DRM_UT_DP)) {
> +                       struct drm_printer p = drm_debug_printer(DBG_PREFIX);
>
> -               drm_printf(&p, "sideband msg failed to send\n");
> -               drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> +                       drm_printf(&p, "sideband msg failed to send\n");
> +                       drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> +               }
>                 return ret;
>         }
>

With the above fixed up

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
