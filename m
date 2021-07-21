Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9F3D19DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhGUWAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhGUWAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:00:18 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE86C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:40:53 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id m14-20020a4a240e0000b029025e4d9b0a3dso913715oof.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KEVgavtFokaJseyLsj85tRS/d/rmuvKUZEz1jbsigY0=;
        b=YWntnAY45UIkoNTLLa74vviHMxh/jaVtTmvHPSSDb5RD2eo3rsagGUGXof2ePUT7dg
         kKHv+kyJqjE10h5nvKoL0VVytFjVHwqiPAAu7aB4hIw31vGX5D9/2Rp6FzkVLE+V4Vmr
         IbfnZswljUpK9UkXzyJ/jhjsELUfJxxMtjUJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KEVgavtFokaJseyLsj85tRS/d/rmuvKUZEz1jbsigY0=;
        b=kly/0fswRjhvRM51M+h13IXH+rYO5lT/kI5a3I5OTsnSTUlJ1OQnhW6fkj5DjOdFjO
         Tm3EQZ3Ovl9MI0RZpG9gJtFED/dwlXW32AV7tMx8ajyWhriV2EKz7UxZ91o52uuxCG/+
         matbjHVebU+yguRkBY5pK25MQ3oFG/9iwEqB2cJ9/AEXbYzVwCWjsLJIQ46YWh6tmTlR
         AGNv/95SXMipWBgYjMuzHFDtl0LLWCE9TAieU0A6jAV2nc0hZ9FmwG/gg+RzVPZWnobo
         TI2A4igrOAuNxiD3J1Z6Qd2HfyiNBkc9vKlMLvTxHiuQRpSXJT97K+6c9QpK08aUSVEN
         uaJw==
X-Gm-Message-State: AOAM533kTPgQJejOUoZwwhXNI6JrQ8XpLbc+DLUs9mhGUFd3c+ILyg76
        ycl1du4J7n316WIb6j4/01cJHQE4Z3H3QYd/3FXQ4w==
X-Google-Smtp-Source: ABdhPJxntp+G+9rokY2CN2MxKmxY0rpDa6yDFX1UvyHoclObrnzcw8afQvfO/r7cISRj3JfakWdZ3O8HM3QzIH0aqwA=
X-Received: by 2002:a4a:e206:: with SMTP id b6mr25761720oot.16.1626907252629;
 Wed, 21 Jul 2021 15:40:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 22:40:52 +0000
MIME-Version: 1.0
In-Reply-To: <1624365748-24224-3-git-send-email-rajeevny@codeaurora.org>
References: <1624365748-24224-1-git-send-email-rajeevny@codeaurora.org> <1624365748-24224-3-git-send-email-rajeevny@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 22:40:52 +0000
Message-ID: <CAE-0n536DwZhxb6M1HvJHAiaChtq2vg1HfiYV+ntrjMVfpRxdQ@mail.gmail.com>
Subject: Re: [v2 2/3] drm/msm/dsi: Add PHY configuration for SC7280
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, abhinavk@codeaurora.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org, jonathan@marek.ca,
        dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajeev Nandan (2021-06-22 05:42:27)
> The SC7280 SoC uses the 7nm (V4.1) DSI PHY driver with
> different enable|disable regulator loads.
>
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
