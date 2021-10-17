Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43964305E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbhJQBee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhJQBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 21:34:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96919C061767
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 18:32:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q129so19184218oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2wy87Ngcu7gVRUKvzaxFI3AG8ttBjWS13MSfr80Tlnw=;
        b=Yz2U+KS+8IlSi/BJ9Aa0q6OomQhz9T99n2XyNvmu8tLFnrxR7oWndK9jZGw2pvVYxd
         zzfe0BKVkv0bWf/kocXFO8C7+cxvQq5UVc2fkF32ONIXJupUWROCG2whGlpy+K50kCXh
         Rzjx6cBP7z48rwQlRDLo6WSsQYYRbhsSYdNp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2wy87Ngcu7gVRUKvzaxFI3AG8ttBjWS13MSfr80Tlnw=;
        b=6pECNyhmfzH2JtUEnaQtbODx7fdDcUYVtyVX1pUz5dtJmUXdIMBo3G0YgnP9+lrjkP
         xIrjYe8dYsxrj004CLtB5Zr6yqInLxarmSwzcjVuSrNWryC8A4W9IKAk1SMPBwkQJw+H
         mhsjyIdJjWkRj9yy2qCWxGQ+wzPbWmDQiR/rwvqJr87L3qrAXLp80kdPz9+zPgflZpex
         CSSO4eqyztohCggM5uTkhE9W+pPB/bkl0TFz88rPYQkEVHTPY6Pvv8d50CbtN9QkdnEH
         GN+mV27BMdbrJPqPK92Mm78Q8mBF0SwIxV+b7683+Pj4lApJ/tYaALaFgZ4SSynBDTXq
         buKQ==
X-Gm-Message-State: AOAM530FKZZlufAGKpkoHwdXNzqZtPOsD091NkO4NNWsjEGz3ZlVlzyq
        KaMQ7f4gG1jZZCr6yHpWzM2Uja8s00J7qEnUftT+jA==
X-Google-Smtp-Source: ABdhPJy9TGOZNQrC0+Gt3LlttQmcsoNpL5AXVWWKf1RKVOfK+qDdiu0E74boUW3aoYhS7g527dvN6POC4ocGd8TjeKw=
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr8370296oib.32.1634434342991;
 Sat, 16 Oct 2021 18:32:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 16 Oct 2021 20:32:22 -0500
MIME-Version: 1.0
In-Reply-To: <20211016221843.2167329-8-bjorn.andersson@linaro.org>
References: <20211016221843.2167329-1-bjorn.andersson@linaro.org> <20211016221843.2167329-8-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 16 Oct 2021 20:32:22 -0500
Message-ID: <CAE-0n53R79HOoBsuLXVkVhYotFam8k4mWZqWnaiJcqcr7w522w@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] drm/msm/dp: Add sc8180x DP controllers
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

Quoting Bjorn Andersson (2021-10-16 15:18:43)
> The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
> DP driver.
>
> Link: https://lore.kernel.org/linux-arm-msm/20210725042436.3967173-7-bjorn.andersson@linaro.org/

BTW, was the link intentional?
