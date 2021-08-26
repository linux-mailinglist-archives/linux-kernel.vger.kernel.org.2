Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1D3F82DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhHZHHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHZHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:07:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11369C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:06:37 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso2298599otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Fec8a8GcTBAqynn2ZZ7COpqa2SBkQGSlbtis8MeqbXA=;
        b=hBr3EdLiF710gt5w/7Ti6OPVvPt7kJNDQbZDuHcQcwmEP36zonNG1PzQEOnSfQmh6R
         LqyeSucKdE+WhY3M35Oe0js8ljT7e5Uhvty6o8QZNtmw0ZZK0TwNKIAhq0SQM+iQOS5q
         pBT8x6egV2yIYFMfJglx/8pEwVoidmAkWS8WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Fec8a8GcTBAqynn2ZZ7COpqa2SBkQGSlbtis8MeqbXA=;
        b=KXkfozMR+DhhUaH69kNSS7LH7OyBjuGKo/1Trt+ZOT4/g2/RFGxj6vJgkZPXRznwMs
         Q9PnoVnUTvOGNGfsyjUAktnWAJJoBeRNTcrcb//asM1LKxYL0h8dhvmBl28cZu58eguQ
         AHTyLKFRlBeFxcETFa68v+lFFRB+YykcBVzcacT91DRDoGvWjPK7EMtKg7q6bSh8F2K/
         TPFSSGfQhwiewTDESIw9nuLqrwH8R0GYTPJd54hTjh2ClVMzgTDgCA+lAvOqlHmXsjgA
         UCOcFRIKyPkETakAz8JM3EJkLnWO2nBS1Ngv4rF2SlIxBfTXj4Z0diCXEm9D9W36pHOv
         Zsuw==
X-Gm-Message-State: AOAM530eGhRTYmUkrbaoOjZ5ogjriwGzn7DdkdFjEGXDaVZqvb09OD8Y
        taySVdk/b0FDZKAZg/p6VZKfQj1rKNGb5DOTLK1zuA==
X-Google-Smtp-Source: ABdhPJxX2h4Sf0+gqNiQoqCR55xo9CLNG4eyz7rKWgznAHyCt52DcMIUBYImUTQuoIE/k/3zVeRSzxCSsUkwkxlhKnk=
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr1891301oto.233.1629961596490;
 Thu, 26 Aug 2021 00:06:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 07:06:36 +0000
MIME-Version: 1.0
In-Reply-To: <20210825234233.1721068-3-bjorn.andersson@linaro.org>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org> <20210825234233.1721068-3-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 07:06:36 +0000
Message-ID: <CAE-0n50X5vKU7arknufaj17YQ0UspET_oN9u+if89q4Y-DvTUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] drm/msm/dp: Modify prototype of encoder based API
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

Quoting Bjorn Andersson (2021-08-25 16:42:30)
> Functions in the DisplayPort code that relates to individual instances
> (encoders) are passed both the struct msm_dp and the struct drm_encoder. But
> in a situation where multiple DP instances would exist this means that
> the caller need to resolve which struct msm_dp relates to the struct
> drm_encoder at hand.
>
> Store a reference to the struct msm_dp associated with each
> dpu_encoder_virt to allow the particular instance to be associate with
> the encoder in the following patch.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
