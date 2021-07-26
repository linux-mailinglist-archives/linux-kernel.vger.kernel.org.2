Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E413D6A67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhGZXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbhGZXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:11:59 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750FC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:52:26 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so2661395oos.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dRaHtjS0KrTz4yuMDHKsz+U68MHHTci+vBVq7wMAHKw=;
        b=AvHO4vlBdmphRLFE1VF1DCJfbyTvm/5I94Unc/gLh+OhuuKt7bnc/QMo5D0l+5vdX9
         HUBVtcsSCB3rh6Cs96P+4lu5ABM/EN3WeQJZGQg1nTOIArK4SQhBFK4KnHQdjpIboXlf
         dfDSdYpePU+/obZDzB4Fx2hhqJi48U6l8l04Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dRaHtjS0KrTz4yuMDHKsz+U68MHHTci+vBVq7wMAHKw=;
        b=iseq2NBDPRzK7V6vLfaEwLGP7TzYPBS3jWQUw9GnGRGSvoNE1+J3fMLF1hbUpFkQ51
         olH1MadE4NJX9JibAsfXIwQTUDZwdiJp6qceVDWR/mr6ezUFeQP2KXbyeYaikXhGA4Zh
         m/XEjYg7jX9B55taiNyPCx4bKN168ygB3FwJbWdxIki8wTJxlVxHgTXWGRuj9gyUmCnf
         IwPvcBfFqNox6/CrDDv4OueD3o6e5JIhsLJP1xhmZ7J0i7gpSGVtJ5YsodKokmUlrgYW
         johDILU61gI0IdZs4XdJmwVHJn2LnVL1FNx7wNCEB0iR1DbUuV6vNEZonIvwWWKRX7VW
         OG5g==
X-Gm-Message-State: AOAM530lkpS/WtWXFIyXEpcoHugJGqlVthJB+tzqiBhYB3pWsyePk1ob
        63E4Om9T4E8K/Utezi7WbxZKgzk6yJAKgvLeERKKzw==
X-Google-Smtp-Source: ABdhPJxSyAGaBm1flEDwyQLTJt1JWFzQAyotby+cedJ15X8enDG0o3MaedDkJEWuJ2piJSo1jaW+PEA+CtzX3wp4PZQ=
X-Received: by 2002:a4a:a6c2:: with SMTP id i2mr12012017oom.92.1627343546057;
 Mon, 26 Jul 2021 16:52:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 19:52:25 -0400
MIME-Version: 1.0
In-Reply-To: <20210725042436.3967173-6-bjorn.andersson@linaro.org>
References: <20210725042436.3967173-1-bjorn.andersson@linaro.org> <20210725042436.3967173-6-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 19:52:25 -0400
Message-ID: <CAE-0n53J6dqB7X7LoKd4VYVgA-ujbV1shFWdYZvLZZ+q3Tjpmw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: msm/dp: Add SC8180x compatibles
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

Quoting Bjorn Andersson (2021-07-24 21:24:35)
> The Qualcomm SC8180x has 2 DP controllers and 1 eDP controller, add
> compatibles for these to the msm/dp binding.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
