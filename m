Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1240A4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhINDyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbhINDyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:54:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B105C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:53:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so16503678otg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=i2DVq77R46Q4oh+eoDH+BZdxkoPPbYH0B3FNJQ4zVf8=;
        b=CMeXYN+FAfHLeldeEcNaPsiUkFhdg2wk1AlaVy9Mv8UANEWITSv1wHEBzyDKn8kain
         k7vZS1ckAohDbls3Havh4j+kVV9vU078oxz5MduWpkm1sBTA1vmajJ4DkxAdgHNDKJ4K
         JHuWlxjVlQtMrPJZRfiY+Rgj3REm6Ludl/9xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=i2DVq77R46Q4oh+eoDH+BZdxkoPPbYH0B3FNJQ4zVf8=;
        b=ir/26UH4NJhSXxy72SfYhPaRbbzPvCi0uwJF61RaiLV/svP/cbhxVUO0KAhFKNzYmR
         OKnIn/xbd/Ay+w0HyDM9VzZh/2vN1zaLiqCW5JifNzt2RyESSOYlE7sPPN9SdCDJLtVp
         wMLGlP1JYPJS7/Bk2wiIiH4B5r/dbeGCrG3q9nufYWTaLzAoIUqiDbS93RNWgZWr6tpF
         1knyYmUT+4AD4tgHaCvntcAMbtRHpg+/eebIH+fKSlZ1hegHIasnhQO4q5hO4aIUQD4F
         falr/hKgPYD8xQN8ptV7nJ+u4dkibPcoeNgLBgblxq54gLkhXjiY5hiBrW7JKUa/AxZ4
         pZ7A==
X-Gm-Message-State: AOAM532MzMKoJtpbzoX1OIUeWMprHTJJF0hNA20Bd1UA1O1trBfRw1b9
        kmCnVKMHws2ETlikNXzisQoeyahdF2tHyO43ApYw8Q==
X-Google-Smtp-Source: ABdhPJwoKH4NRu22aHQhQLigGEjP8NGge3P2aM9lWffyrcLEzgZPwADb20z4GDX00vaZCgpJyE32xaMgcvWXUq6bKJg=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr12716971ots.77.1631591612907;
 Mon, 13 Sep 2021 20:53:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Sep 2021 20:53:32 -0700
MIME-Version: 1.0
In-Reply-To: <1628726882-27841-2-git-send-email-sbillaka@codeaurora.org>
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org> <1628726882-27841-2-git-send-email-sbillaka@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 13 Sep 2021 20:53:32 -0700
Message-ID: <CAE-0n51EiVHB56AC5tdyRtkpy0B9OuOp_y5xBceaU_pyzr+_JA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/msm/dp: Add support for SC7280 eDP
To:     Sankeerth Billakanti <sbillaka@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-08-11 17:08:01)
> The eDP controller on SC7280 is similar to the eDP/DP controllers
> supported by the current driver implementation.
>
> SC7280 supports one EDP and one DP controller which can operate
> concurrently.
>
> The following are some required changes for the sc7280 sink:
> 1. Additional gpio configuration for backlight and pwm via pmic.
> 2. ASSR support programming on the sink.
> 3. SSC support programming on the sink.
>
> Signed-off-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  4 ++--
>  drivers/gpu/drm/msm/dp/dp_ctrl.c               | 19 +++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.c            | 32 ++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_parser.c             | 31 +++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_parser.h             |  5 ++++
>  5 files changed, 87 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index b131fd37..1096c44 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -856,9 +856,9 @@ static const struct dpu_intf_cfg sm8150_intf[] = {
>  };
>
>  static const struct dpu_intf_cfg sc7280_intf[] = {
> -       INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> +       INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>         INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> -       INTF_BLK("intf_5", INTF_5, 0x39000, INTF_EDP, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
> +       INTF_BLK("intf_5", INTF_5, 0x39000, INTF_DP, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),

Why is this INTF_5? Instead of INTF_2? I noticed that if I changed it to
INTF_2 that I could get external DP to work but not the internal eDP.
Then changing it back to INTF_5 got eDP interface working but not DP. I
also noticed that we changed it from INTF_EDP to INTF_DP for the eDP
hardware. Can you please explain this struct? I looked at it and I still
don't understand what's going on.

The index (fifth element above) seems to need to match the index that is
set for the address in sc7280_edp_cfg[]. If the two don't match things
don't seem to work either. But then I also tried flipping that and still
things didn't work. Does that index matter? Or can the first INTF_DP be
0 still?
