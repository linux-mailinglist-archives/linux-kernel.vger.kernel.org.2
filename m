Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24B139ABB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFCUYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:24:32 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3514C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:22:47 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so1701467ool.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cMLM4cflpxEbsfu/ce/EkzAINJ+710gVrefVr0HI+qY=;
        b=L0SkuWBv+83YGqTd6ik3MB9wor9LeocWUua6DOQob5uCIeKncJusY/+64rblVTnKgZ
         tTRCUuoUgWaAQg7TsuVlaO5NxTdPq6WOncJXARM0/uRiV35POzwPmEbSKaXyAuzCtWDc
         ONq7D/gq3ivz6aXRSTHk3Dn7oHzaEooVJ3WyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cMLM4cflpxEbsfu/ce/EkzAINJ+710gVrefVr0HI+qY=;
        b=k9KLyGpbm5gJUxIMauJECOCN/Pmq1FQC+JRP8aRtEcVKuoWqOzE2dkqMUHLwB01neu
         HUMVvBGfZZePytomCa4Wzm01UFYJPI4vGedrhd+qT0cuQf39X7knsWoAed27VViPn6+d
         OFwRiZ+r5J1jdAJmURzUMEyn8dUEa22G5UN14iyRP4rdZTelrfGHr33WmYhZ3vC0XDgy
         MSL/Vgk//mNoDU03BoizzbioYfyQ9fmWrGHRtoFFnhKuYQkTF/Z3VaHFwVfUTdStvIa9
         L4RC0BNh8sjt5KRNyOBZnT8wBmB9JARaHMcLd1oUis59tCJ0MQsyq9SXvJx64AzevIIq
         7mMQ==
X-Gm-Message-State: AOAM5320zjl8donCrEs8fuw2f8dJWZNHmhRRcIFSdof+z11hI/QpoGXY
        ahFKKOzBc/Ax9ROLjLZmHhiD2q5iB7yK5rY7C4S1Gg==
X-Google-Smtp-Source: ABdhPJwJRX5XWGLQvcvpQ5gyjX7E4oP0MOspFx028qV6yYflYoKemYC4DYS5FSHp16wnBONkFO2dTwSCsw/L7BS4wVU=
X-Received: by 2002:a4a:85ca:: with SMTP id u10mr857805ooh.80.1622751767413;
 Thu, 03 Jun 2021 13:22:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jun 2021 20:22:47 +0000
MIME-Version: 1.0
In-Reply-To: <1622734846-14179-1-git-send-email-khsieh@codeaurora.org>
References: <1622734846-14179-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 3 Jun 2021 20:22:47 +0000
Message-ID: <CAE-0n51-CsHPwYmceUq1kTaG=L+ifG3kX2pxJxTG_=r4Xm67_g@mail.gmail.com>
Subject: Re: [PATCH v5] drm/msm/dp: power off DP phy at suspend
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you Cc dri-devel?

Quoting Kuogee Hsieh (2021-06-03 08:40:46)
> Normal DP suspend operation contains two steps, display off followed
> by dp suspend, to complete system wide suspending cycle if display is
> up at that time. In this case, DP phy will be powered off at display
> off. However there is an exception case that depending on the timing
> of dongle plug in during system wide suspending, sometimes display off
> procedure may be skipped and dp suspend was called directly. In this
> case, dp phy is stay at powered on (phy->power_count = 1) so that at
> next resume dp driver crash at main link clock enable due to phy is
> not physically powered on. This patch will call dp_ctrl_off_link_stream()
> to tear down main link and power off phy at dp_pm_suspend() if main link
> had been brought up.
>
