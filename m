Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102C83996E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCA0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:26:00 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42719 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCAZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:25:58 -0400
Received: by mail-oi1-f178.google.com with SMTP id v142so4100374oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sf9HPjX/QRw5TUCBPMkwIobQvyDUNSU8DnXWCThttng=;
        b=lXyYsmHjMCk031tkWhLnBU8kbmJTb+chywkiYEpXQeAU+2q/dSOjy3z1Cgk8KSjA9l
         j+ZetNlnwdTzYQz1XalYZazk9biXAeuqG7EJRxw6mND10vlWJBJ6oY9szlC7B40w1baY
         HwN3g6HA8M9ppv3NmmfcNnSKHX2k/2Ls1vF+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sf9HPjX/QRw5TUCBPMkwIobQvyDUNSU8DnXWCThttng=;
        b=XHX2Sb1EawQDKz9lxjY3/bbdsQTiuyofXzFm0u0jpk+/Ock2JjLe332KTaqAhSJFJt
         wrgd8VpUFsIGyHk+VtXdSDRAw4kQGar9xJpCKrPMW9rwolxpAPU5d0kQJSbPkrECG0ar
         b42JlbvOlOwg6m6jNJg+BHwDJem/mv4Poaumiqr5ZX9uRhydXvHBME5SjwJYDqk22Y5w
         oK1trSSPyWarrvF/IHShTVwjqzl5cfnP5arWpA/Yjf9Ss/jrlwIsQYVbz4WQAZTh0fWQ
         hzHBHyFku8g0kFGEP2hF1qYvHQN1DKbd5B+247Q7Y0twMAiQ45fTPuqThoFb89+GpJdx
         4Opw==
X-Gm-Message-State: AOAM531EzwBaNJvTuPsHjhcMyQBO9dvdyaghNfktVpPmFJFy2Ry0ptAm
        cJY4v4ns3OhADrykBALc4nlZUvle3SSXPHRpvvSqBA==
X-Google-Smtp-Source: ABdhPJyY5laFn5SRHNT37MHyapZ0GwE1ObVpQfvDvSQd6CoIw7eXVr3cYfAO4YpBf2ZSmCLl+Qq0taNnfzOtiSyKJMA=
X-Received: by 2002:aca:654d:: with SMTP id j13mr5653421oiw.125.1622679784640;
 Wed, 02 Jun 2021 17:23:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jun 2021 17:23:04 -0700
MIME-Version: 1.0
In-Reply-To: <1622652185-7157-1-git-send-email-khsieh@codeaurora.org>
References: <1622652185-7157-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 2 Jun 2021 17:23:04 -0700
Message-ID: <CAE-0n522L0hmAK40xj3TGimBjeqQgqO2YWsGOrYv-BPqr33tkA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: power off DP phy at suspend
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

Quoting Kuogee Hsieh (2021-06-02 09:43:05)
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
> Changes in V2:
> -- stashed changes into dp_ctrl.c
> -- add is_phy_on to monitor phy state
>
> Changes in V3:
> -- delete is_phy_on
> -- call dp_ctrl_off_link_stream() from dp_pm_suspend()
>
> Changes in V4:
> -- delete changes made at dp_power.c
> -- move main link status checking to dp_pm_suspend
>
> Fixes: 0114f31a2903 ("drm/msm/dp: handle irq_hpd with sink_count = 0 correctly)
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Ok, this seems to work and is nice and small

Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
