Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C13BF631
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhGHHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhGHHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:24:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9264BC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 00:21:53 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso4914606oty.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=GlyNpRS/ZnIBH6T2xmI7UmonQRyHCXFhA2s03oASO4Q=;
        b=jL5qIurr1gZORF2l3P73QnDTKzVDziGFZCyboRb1kV87XmAQ3xV2137WoL+6fqbPxf
         USiWqleYoU4DFDU1QZQTlLrmI3bT+B43wyCaF5rxa5uxR2MvLyMbKv/H80xkqOfoCEI8
         loFn7s7cjibETX6nxR1KxSCuBLTgZLr2zhUjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=GlyNpRS/ZnIBH6T2xmI7UmonQRyHCXFhA2s03oASO4Q=;
        b=smlftEqGzyiZowTHtrwP3OEy72vyl0G7BL8fRm7/M6UPceEfuaomds4oWfer4IkP/l
         jQSi9CVFQA8zko4YoKk+C5wYNTMr6pInch5FKw9/jlxmTsTLTdCLYTrABt4Aw+ZB2ahl
         f1JfCOcTroSDirA3s/Iffy+6Bgd4LXwQPapj8yZU0+VR0SO/HVhR/jBmuQBGQM0xnTzr
         eHLk3jk5WH2QEycMS6wpn2BfosPF9j+z9eCIKuqkLJCHPKG/v2R/jcZlqdJHww0K9nkY
         Ol3Lg2uQBukfkq9rYX5CX8d7fPq8BalmQAVTTWCDblfyuU6P7XqQP+Oqsjl3laCSSIUk
         U/bw==
X-Gm-Message-State: AOAM5333+VPQWZxm1xdMOsUwixQ1LfGVtS/Z9WwfTKf2LyobuLTwlQs7
        rlQw+OCJUDs0fI7kz62sw5g1TA1mpA/3sHaYCaluag==
X-Google-Smtp-Source: ABdhPJxy7gr/M5KMw/WA3ZBc9mM+qV00yrR2nRuHoHKyp5ya9CGCYK6cQTX1rnZPidxNZK1/pUWAtTPnp2LZZMf9Nv4=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr23059307otf.25.1625728912972;
 Thu, 08 Jul 2021 00:21:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 07:21:52 +0000
MIME-Version: 1.0
In-Reply-To: <1625592020-22658-8-git-send-email-khsieh@codeaurora.org>
References: <1625592020-22658-1-git-send-email-khsieh@codeaurora.org> <1625592020-22658-8-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 07:21:52 +0000
Message-ID: <CAE-0n51U8faPjxfFcd3uuOk27urR2rCSGhg1Kat1AO6LLixYTw@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/msm/dp: retrain link when loss of symbol lock detected
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-06 10:20:20)
> Main link symbol locked is achieved at end of link training 2. Some
> dongle main link symbol may become unlocked again if host did not end
> link training soon enough after completion of link training 2. Host
> have to re train main link if loss of symbol lock detected before
> end link training so that the coming video stream can be transmitted
> to sink properly.
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>

I guess this is a fix for the original driver, so it should be tagged
with Fixes appropriately.

> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 0cb01a9..e616ab2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1661,6 +1661,25 @@ static bool dp_ctrl_any_lane_cr_lose(struct dp_ctrl_private *ctrl,
>         return false;
>  }
>
> +static bool dp_ctrl_loss_symbol_lock(struct dp_ctrl_private *ctrl)
> +{
> +       u8 link_status[6];

Can we use link_status[DP_LINK_STATUS_SIZE] instead?

> +       u8 status;
> +       int i;
> +       int lane = ctrl->link->link_params.num_lanes;

s/lane/num_lanes/

would make the code easier to read

> +
> +       dp_ctrl_read_link_status(ctrl, link_status);
> +
> +       for (i = 0; i < lane; i++) {
> +               status = link_status[i / 2];
> +               status >>= ((i % 2) * 4);
> +               if (!(status & DP_LANE_SYMBOL_LOCKED))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>  {
>         int rc = 0;
> @@ -1777,6 +1796,17 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>         return rc;
>  }
>
> +static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
> +{
> +       int ret = 0;

Please drop init of ret.

> +       u8 cr_status[2];
> +       int training_step = DP_TRAINING_NONE;
> +
> +       ret = dp_ctrl_setup_main_link(ctrl, cr_status, &training_step);

as it is assigned here.

> +
> +       return ret;

And indeed, it could be 'return dp_ctrl_setup_main_link()' instead.

> +}
> +
>  int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>  {
>         int ret = 0;
> @@ -1802,6 +1832,10 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>                 }
>         }
>
> +       /* if loss symbol lock happen, then retaining the link */

retain or retrain? The comment seems to be saying what the code says "if
loss retrain", so the comment is not very useful.

> +       if (dp_ctrl_loss_symbol_lock(ctrl))
> +               dp_ctrl_link_retrain(ctrl);
> +
>         /* stop txing train pattern to end link training */
>         dp_ctrl_clear_training_pattern(ctrl);
>
