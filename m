Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724A43D19D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGUV7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGUV7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:59:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F83C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:40:12 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so3544230otq.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Q4wvBXyV2lJ1aTRox0e1+Ok+AEaw/CVcGBs0YMHYsP0=;
        b=XqZH1FzW4TAdt+62lo9scgkSGaBidkfe9huO0q1U3Ro1mui8RWXUgDF4qzAHCY6Ru+
         iZ8zSponbgyYt6LXGU0IodEXLM8IGxpYpjT2JbWrcYJxLuLC7ydskbWTAd4EndoQ0uzM
         zAZJ+shbHzcPMS1D4t5gFzBXtgmxI7uFF4NFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Q4wvBXyV2lJ1aTRox0e1+Ok+AEaw/CVcGBs0YMHYsP0=;
        b=a4vWKA9BwJ3t/wUorPFnR/edJpVorDrYaf9tTjlmEKDe+k8V/mdnWxuhSqy+Ark9l+
         ALXimDwldArgwsPNxBL45vE+wshAZ12o3slJvGHWT73ECBJ/dg99hLnj9d/hAMdJFwa0
         qT2TIeppzqrsouasVJXc9CvQGZbKIg3X/C1SbN9XggvE8JfGS8wkYSGhQ4WO2esTOWoR
         UtNX33aL3mPTceqEphQVvZ2qbhkK7Qo5jucYjA7tCYLGJHPZLnrnhq7Vz+J3CkuTXoi2
         Ecvwboa0pOJDv2Sx2L3L4+OqjT5+sorBYzG3mxyFvjmJJcTOvJ+V1NoFVJjwfP1J40Ph
         B8Qw==
X-Gm-Message-State: AOAM5300v9bKYtY46xA0haE3Mt/lQcd6BdSSo4Ow2VbroKHJanYrLYeq
        fCWtqLqVDVY6vdT0o3JtMrzhlW1A4pvROIs+gIayCA==
X-Google-Smtp-Source: ABdhPJwocIiRhFwFOnsM81FkofvQbBA36K0D5dCAYY3+kDkw8/j6vCVRW/AWV4EzATwWCQE40EPyTZCpO+0f5mG/y5g=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr27826933otf.25.1626907211418;
 Wed, 21 Jul 2021 15:40:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 22:40:11 +0000
MIME-Version: 1.0
In-Reply-To: <1624365748-24224-2-git-send-email-rajeevny@codeaurora.org>
References: <1624365748-24224-1-git-send-email-rajeevny@codeaurora.org> <1624365748-24224-2-git-send-email-rajeevny@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 22:40:10 +0000
Message-ID: <CAE-0n50Km=XxJ93ZJkwcWWJdzvBba_We=bZYzkdYKoB-cwTYkg@mail.gmail.com>
Subject: Re: [v2 1/3] dt-bindings: msm/dsi: Add sc7280 7nm dsi phy
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

Quoting Rajeev Nandan (2021-06-22 05:42:26)
> The SC7280 SoC uses the 7nm (V4.1) DSI PHY driver.
>
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
