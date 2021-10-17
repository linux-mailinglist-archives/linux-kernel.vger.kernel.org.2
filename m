Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444934305E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbhJQBdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 21:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhJQBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 21:33:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942DC061768
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 18:31:21 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id g125so19072023oif.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=FkZ8BDMTGchcGS1E2IMJTlJ/g3mJdDD78OtHNGJ/EEg=;
        b=h9Pokhi4AVZI55uOa2jKdmsv1a9iMYO6Olt4WTnzPXHH1FearCdMb+CLrENVdDFx9F
         r+dk3bWzipc0ifqGDMW8qvRcQGRlZU//OAQbH/kZbfAKAh25odMFAv6FZdL1fDv5ixBe
         0qIlOENPlbW5mFiKP9X5w4oAif6j1ttN8V8Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=FkZ8BDMTGchcGS1E2IMJTlJ/g3mJdDD78OtHNGJ/EEg=;
        b=2MDeRJmsRilglBKgxjI36YwPBsM7VMx/ryrMjsMBJVFojyUsDB40AjSJujy0UwCme+
         t8oc+1ZGeRohm4okXwHWQkzBMKf9h0KTSYnIQuhjTh9uKCDneOIau9CswfP+gEb69lzA
         GQbEz1qTNLCMPeoSsZx6WhiPDRdKRxciZLaFMgj+SPL6yM8yhVRB+17M25/ZJvvpTWnO
         tSIANnz8HGDMbac7TtVUdYlC5rKRAq3VVHZim2ISETB064CaZNotqZMKfG1S99vhWyFi
         ATAxCggz8+T9hORG3oMx5sNYNWV8BnvccBZ5Jah/a/Q81eX8cyoJ+6WoDeuU/6hS1+nd
         ta+Q==
X-Gm-Message-State: AOAM532Frpr1hOmnk84HQDg8HQFcRv/SvkDeTJp7K20GTqA6yEFHIn6c
        3PznsHZmyiXzIkxyreTHKoTLNFOdsn3CSJujA/Kycw==
X-Google-Smtp-Source: ABdhPJyugEUY5uN9Q+jCOvC6LoW1QUtqZ3z4ufKS9HicaDBtN79ngOQb5eAvAKrduNWR9bmcYtqK+pwYIsIhVnOfYlE=
X-Received: by 2002:aca:3306:: with SMTP id z6mr23201636oiz.164.1634434280958;
 Sat, 16 Oct 2021 18:31:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 16 Oct 2021 20:31:20 -0500
MIME-Version: 1.0
In-Reply-To: <20211016221843.2167329-6-bjorn.andersson@linaro.org>
References: <20211016221843.2167329-1-bjorn.andersson@linaro.org> <20211016221843.2167329-6-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 16 Oct 2021 20:31:20 -0500
Message-ID: <CAE-0n51WqRgoY11x_y-LoNAwzaZZWDgWxU4z+bcfRRa7OfaAtw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/msm/dp: Support up to 3 DP controllers
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-16 15:18:41)
> Based on the removal of the g_dp_display and the movement of the
> priv->dp lookup into the DP code it's now possible to have multiple
> DP instances.
>
> In line with the other controllers in the MSM driver, introduce a
> per-compatible list of base addresses which is used to resolve the
> "instance id" for the given DP controller. This instance id is used as
> index in the priv->dp[] array.
>
> Then extend the initialization code to initialize struct drm_encoder for
> each of the registered priv->dp[] and update the logic for associating
> each struct msm_dp with the struct dpu_encoder_virt.
>
> A new enum is introduced to document the connection between the
> instances referenced in the dpu_intf_cfg array and the controllers in
> the DP driver and sc7180 is updated.
>
> Lastly, bump the number of struct msm_dp instances carries by priv->dp
> to 3, the currently known maximum number of controllers found in a
> Qualcomm SoC.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
