Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62237ED1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbhELUML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359638AbhELSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:53:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33154C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:50:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso20693622ots.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=L7DlZ5NyTwLk7rVfxKjK+qgzyH7WbDEj7IFbwXV5/ko=;
        b=W5ENh4vHkaVFcb5NO44g5Hjz7X+WFAaPID+EfPoYkTag44QDfGmgs5sj6vKBYWQte6
         z7q8dQceV/9w0LOqAbkxm5FOwSOuXkZsgRNRl+CU7nya3U6oEjbixXUn69Kb2DrzZ3vp
         H29bJR8RUzo0tnd6lsUnojame717iZdO3/NFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=L7DlZ5NyTwLk7rVfxKjK+qgzyH7WbDEj7IFbwXV5/ko=;
        b=d9IUcdDnvYQXPxP7m5qOM+BJ6acEDTQAd/65lLHYqqA9wd9ZzzapQE7uzD9lV/iG+N
         HaQPjfUGyR0FWlVQWNg8ODfAqWxty8NhM4esIrylSMVS6heqP71F6zFLfxqix3GSelr9
         esm7oB1aoyDuPM8UV6KvPZjwhrUkUWyIX3Idu0K42mzS8DGOLFDj8MsL+tKFXm3M09eV
         qCw0F0YJC5a3zeUYz5lFOzfJPKRFzCrA0shF2k6Sfd+sIPANIOXSix2D12an8jnfIY4s
         NazHsbc9B07Pl05QbJMiJ6rZdKfaRsJEhRZCpXk/hFd3vKlkXPN0VYfPjl0RrY3iWWtL
         ytcg==
X-Gm-Message-State: AOAM5319lrUFgYu+/e5puHsyBf8OZyDGIx5xEwX8IcsdcOMsPLOk7rtb
        j3pXzABWIqKtw4wgbZKvoMDqy1cazhBnO+fBPcS1ZA==
X-Google-Smtp-Source: ABdhPJzIipDkUQDMHFojJ3nyYAssT6+br/EGKtgrhlZUKlZMGCZyBx8bfbd3zJEFcJcLl9lzwKJvetiEr+/fDpmYsEo=
X-Received: by 2002:a9d:425:: with SMTP id 34mr32079004otc.25.1620845441618;
 Wed, 12 May 2021 11:50:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 May 2021 11:50:41 -0700
MIME-Version: 1.0
In-Reply-To: <1620840558-28684-1-git-send-email-khsieh@codeaurora.org>
References: <1620840558-28684-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 12 May 2021 11:50:41 -0700
Message-ID: <CAE-0n517Xkj=-m=gYv-FkpWGP+xC=ht8pRTtr5V8CKdrNtq9gQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: handle irq_hpd with sink_count = 0 correctly
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-05-12 10:29:18)
> irq_hpd interrupt should be handled after dongle plugged in and
> before dongle unplugged. Hence irq_hpd interrupt is enabled at
> the end of the plugin handle and disabled at the beginning of
> unplugged handle. Current irq_hpd with sink_count = 0 is wrongly
> handled same as the dongle unplugged which tears down the mainlink
> and disables the phy. This patch fixes this problem by only tearing
> down the mainlink but keeping phy enabled at irq_hpd with
> sink_count = 0 handle so that next irq_hpe with sink_count =1 can be
> handled by setup mainlink only.
>
> Changes in v2:
> -- add ctrl->phy_Power_count
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c |  5 +--
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 83 ++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 46 +++++++++++++++-----
>  4 files changed, 118 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index b1a9b1b..f4f53f2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -582,10 +582,9 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
>
>         u32 reftimer = dp_read_aux(catalog, REG_DP_DP_HPD_REFTIMER);
>
> -       /* enable HPD interrupts */
> +       /* enable HPD plug and unplug interrupts */
>         dp_catalog_hpd_config_intr(dp_catalog,
> -               DP_DP_HPD_PLUG_INT_MASK | DP_DP_IRQ_HPD_INT_MASK
> -               | DP_DP_HPD_UNPLUG_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK, true);
> +               DP_DP_HPD_PLUG_INT_MASK | DP_DP_HPD_UNPLUG_INT_MASK, true);
>
>         /* Configure REFTIMER and enable it */
>         reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 8d59eb9..b5bed5f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -77,6 +77,8 @@ struct dp_ctrl_private {
>         struct dp_parser *parser;
>         struct dp_catalog *catalog;
>
> +       int phy_power_count;

This is still redundant. Please restructure the code to call the power
on/off function in one place and the init/exit function in another so
that we don't have to reference count it.
