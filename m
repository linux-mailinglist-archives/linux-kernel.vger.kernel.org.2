Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC674305D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 03:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbhJQBcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhJQBcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 21:32:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233BC061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 18:30:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso786612otl.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ubDJVQq78uVYhJbYvgkSAR8BkeRUeNLoFmCL9We36F0=;
        b=flYkLHhlsDBt7e3MlODNLUfbSjUku5qphnfo9uSFkDOvVTyMIbxeq1/Hq9T6WyHtvg
         XJO/07qz87PhIw/OmVM1eQ+/AkpkXbeyxhk/sQGsNfActPTAz4bUJuD5rXjt9MGYxaGJ
         80bs7G6KMq3j5xCfoFO+v1KZos7l6gKi2rAWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ubDJVQq78uVYhJbYvgkSAR8BkeRUeNLoFmCL9We36F0=;
        b=62kxMZ2Mx5Qw1MqEAFCUC/3kvZNmc12rjeP9g4jP6+p3HYisNhRu7Cx1MWX9c9SG3Z
         FdIVKJY03Qb5TtmhH9bC20uXbQc1s+PzLMPttJPN/TZ355lXdUydYyXBxYbo0grqiMY4
         vm8O6PL0CRXqT6LkjWIDYqi5or9pNgf76T7iDEM5cabfUknDFyHkOwIVkaAQgl72brLc
         pQczF59BCeFvAMgbcXcMRK0K2SU6rzeZQpbyd5Dbj8UDc5LvZgJ4vRAwSurLiDAba+Nk
         iNQHDQo7folq9h/D7NcXdnT+UwmeG2Uaft/RgZFFD6s+8natoYixoJmwhei3pW5hC6iV
         +qhg==
X-Gm-Message-State: AOAM5305mj3N+bqnFX20T1Ef0arGX1s3C/9CGEUqjRVbKyLhAQy/vSBo
        HBd5s96owAYydvufLOue0RH3IFK7cFMGrUpEX30LGw==
X-Google-Smtp-Source: ABdhPJwr06h9bD3MmzMdWkXAGp+iEIqQozkRjbdPwjgtYY8VoqiNVHLEO5C2EDLfQSqnSUcnH8rKmBifxGT81/0YlVc=
X-Received: by 2002:a05:6830:4187:: with SMTP id r7mr9420950otu.126.1634434209334;
 Sat, 16 Oct 2021 18:30:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 16 Oct 2021 20:30:08 -0500
MIME-Version: 1.0
In-Reply-To: <20211016221843.2167329-4-bjorn.andersson@linaro.org>
References: <20211016221843.2167329-1-bjorn.andersson@linaro.org> <20211016221843.2167329-4-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 16 Oct 2021 20:30:08 -0500
Message-ID: <CAE-0n52t0UF8usgvb5=8c9wdb_r+WKt7oNDncaVY=x8WZkVUWA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] drm/msm/dp: Allow specifying connector_type per controller
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

Quoting Bjorn Andersson (2021-10-16 15:18:39)
> As the following patches introduced support for multiple DP blocks in a
> platform and some of those block might be eDP it becomes useful to be
> able to specify the connector type per block.
>
> Although there's only a single block at this point, the array of descs
> and the search in dp_display_get_desc() are introduced here to simplify
> the next patch, that does introduce support for multiple DP blocks.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
